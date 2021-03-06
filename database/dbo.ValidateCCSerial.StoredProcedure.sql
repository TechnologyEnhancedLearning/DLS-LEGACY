USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 10/08/2017
-- Description:	Checks the validity of serial number for user, version number and activation limit and returns a return code and matching message
-- =============================================
CREATE PROCEDURE [dbo].[ValidateCCSerial]
	-- Add the parameters for the stored procedure here
	@serial_number as nchar(18),
	@username as nvarchar(255),
	@versionnumber as varchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @_ReturnCode as Integer
    DECLARE @_ReturnMessage as nvarchar(1000)
    --Check that the version number matches the config db latest version
    IF (SELECT ConfigText from Config WHERE ConfigName = N'ContentCreatorCurrentVersion') <> @versionnumber
    begin
    --no match return code:
    set @_ReturnCode = 602
    declare @_latest as nvarchar(15)
    select @_latest = ConfigText from Config WHERE ConfigName = N'ContentCreatorCurrentVersion'
    declare @_dlurl as nvarchar(500)
    SELECT @_dlurl = ConfigText from Config WHERE ConfigName = N'ContentCreatorDownloadURL'
    set @_ReturnMessage = 'Installation failed. This (v' + @versionnumber + ') is not the latest version of the Content Creator installer. The latest version of the installer (v' + @_latest + ') can be downloaded from the Content Creator tab of the IT Skills Pathway Content Management System or directly from ' + @_dlurl
    goto OnExit
    end
    --If a blank serial number has been supplied return a custom code and message:
    if @serial_number = '' or @serial_number = 'trial'
    begin
    set @_ReturnCode = 555
    set @_ReturnMessage = 'No serial number was supplied. Content Creator will be installed as a 30 day trial.'
    goto OnExit
    end
    --Check that the serial number matches the username:
    if not exists (SELECT * FROM CCLicences AS cc WHERE Active = 1 AND LicenceText = @serial_number AND ((SELECT [Email] FROM AdminUsers WHERE AdminID = cc.AssignedUserID) = @username OR (SELECT [Login] FROM AdminUsers WHERE AdminID = cc.AssignedUserID) = @username))
    begin
    set @_ReturnCode = 602
    set @_ReturnMessage = 'The supplied serial number and username do not match any entries in the Content Creator licence database.'
    goto OnExit
    end
    if @username <> 'admin'
    begin
    -- get the activation limit for this serial number:
    declare @_ActivationLimit as integer
    SELECT @_ActivationLimit = ActivationLimit FROM CCLicences AS cc1 WHERE Active = 1 AND LicenceText = @serial_number
    --Reset the activation count if this is a newer version than the previous version installed:
    if (SELECT LatestVersionInstalled FROM CCLicences AS cc1 WHERE Active = 1 AND LicenceText = @serial_number) <> @versionnumber
    begin
   
    
    -- and then check that the activation limit hasn't been reached
    if (SELECT ActivationCount FROM CCLicences AS cc1 WHERE Active = 1 AND LicenceText = @serial_number) >= @_ActivationLimit
    BEGIN

     set @_ReturnCode = 602
    set @_ReturnMessage = 'The activation limit (' + CAST(@_ActivationLimit as nvarchar) +') has already been reached for this serial number. Your licence allows you to install this software on up to ' + CAST(@_ActivationLimit as nvarchar) +' devices. Contact it.skills@nhs.net if you believe this activation request is legitimate.'
    goto OnExit
    END 
    end
    --all checks have been passed. Update the activation count and return success code
    update CCLicences set LatestVersionInstalled = @versionnumber, ActivationCount = 0 WHERE Active = 1 AND LicenceText = @serial_number
    end
    UPDATE CCLicences SET ActivationCount = ActivationCount+1 WHERE Active = 1 AND LicenceText = @serial_number
    set @_ReturnCode = 601
    
    OnExit:
    	SELECT @_ReturnCode as ValidationCode, @_ReturnMessage AS ValidationMessage
END
GO
