USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 17/04/2018
-- Description:	Assigns appropriate admin roles to administrator
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAdminUserRoles] 
	-- Add the parameters for the stored procedure here
	@AdminID int,
	@CategoryID int,
	@CMSRole int,
	@CCLicence bit,
	@Supervisor bit,
	@Trainer bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_ImportOnly bit = 0
	DECLARE @_CMS bit = 0
	if @CMSRole > 0
	begin
	set @_CMS = 1
	end
	if @CMSRole = 1
	begin
	set @_ImportOnly = 1
	end
    -- Insert statements for procedure here
	-- Update AdminUser Record:
	UPDATE AdminUsers 
	SET CategoryID=@CategoryID, ContentManager = @_CMS, ImportOnly = @_ImportOnly, ContentCreator = @CCLicence, Supervisor = @Supervisor
	WHERE AdminID = @AdminID
	-- Add CC licence if not already granted:
	if @CCLicence = 1
	begin
	if not exists (SELECT * FROM CCLicences WHERE AssignedUserID = @AdminID AND Active = 1)
	begin
	if exists (SELECT * FROM CCLicences WHERE AssignedUserID = @AdminID AND Active = 0)
	begin 
	--reactivate:
	UPDate CCLicences SET Active = 1 WHERE AssignedUserID = @AdminID
	end
	else
	begin
	-- assign next unassigned:
	UPDate TOP(1) CCLicences SET Active = 1, AssignedUserID = @AdminID WHERE AssignedUserID IS NULL
	end
	end
	end
	-- Remove if unset:
	if @CCLicence = 0

	begin
	if  exists (SELECT * FROM CCLicences WHERE AssignedUserID = @AdminID AND Active = 1)
	begin
	UPDate CCLicences SET Active = 0 WHERE AssignedUserID = @AdminID
	end
	end
END
GO
