USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 23/02/2018
-- Description:	Inserts a new centre and adds default courses if required.
-- =============================================
CREATE PROCEDURE [dbo].[uspCentreInsertWithDefaults]
	-- Add the parameters for the stored procedure here
	@RegionID Int,
	@CentreName varchar(250),
	@ContactForename varchar(250),
	@ContactSurname varchar(250),
	@ContactEmail varchar(250),
	@ContactTelephone varchar(250),
	@AutoRegisterManagerEmail varchar(250),
	@CentreTypeID int,
	@AddCourses bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @_NewCentreID int
    -- Insert statements for procedure here
	INSERT INTO Centres
                      (Active, RegionID, CentreName, ContactForename, ContactSurname, ContactEmail, ContactTelephone, PriorCandidates, AutoRegisterManagerEmail,  AutoRegistered, CentreTypeID)
VALUES     (1,@RegionID,@CentreName,@ContactForename,@ContactSurname,@ContactEmail,@ContactTelephone,0,@AutoRegisterManagerEmail,0, @CentreTypeID)
if @AddCourses = 1
begin
SET @_NewCentreID = SCOPE_IDENTITY()
INSERT INTO [CentreApplications] ([CentreID], [ApplicationID]) SELECT @_NewCentreID, ApplicationID
FROM  Applications
WHERE (Debug = 0) AND (ArchivedDate IS NULL) AND (ASPMenu = 1) AND (CoreContent = 1) AND (BrandID = 1) AND (LaunchedAssess = 1)
               end

END
GO
