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
CREATE PROCEDURE [dbo].[UpdateAdminUserRoles_V2] 
	-- Add the parameters for the stored procedure here
	@AdminID int,
	@CategoryID int,
	@CMSRole int,
	@CCLicence bit,
	@Supervisor bit,
	@Trainer bit,
	@CentreAdmin bit
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
	SET CategoryID=@CategoryID, ContentManager = @_CMS, ImportOnly = @_ImportOnly, ContentCreator = @CCLicence, Supervisor = @Supervisor, CentreAdmin = @CentreAdmin
	WHERE AdminID = @AdminID
	-- Add CC licence if not already granted:
	if @CCLicence = 1
	begin
	if not exists (SELECT * FROM CCLicences WHERE AssignedUserID = @AdminID AND Active = 1)
	begin
	if exists (SELECT * FROM CCLicences WHERE AssignedUserID = @AdminID AND Active = 0)
	begin 
	--reactivate:
	UPDate CCLicences SET Active = 1, ActivatedDate = GETUTCDATE() WHERE AssignedUserID = @AdminID
	end
	else
	begin
	-- assign next unassigned:
	UPDate TOP(1) CCLicences SET Active = 1, AssignedUserID = @AdminID, ActivatedDate = GETUTCDATE() WHERE AssignedUserID IS NULL
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
	-- centre admin notifications?
		IF @CentreAdmin = 1
		begin
		INSERT INTO NotificationUsers (NotificationID, AdminUserID)
		SELECT NR.NotificationID, @AdminID FROM NotificationRoles AS NR INNER JOIN Notifications AS N ON NR.NotificationID = N.NotificationID WHERE RoleID = 1 AND N.AutoOptIn = 1 AND (@AdminID NOT IN (SELECT AdminUserID FROM NotificationUsers WHERE NotificationID = N.NotificationID))
		end
		-- supervisor notifications?
		IF @Supervisor = 1
		begin
		INSERT INTO NotificationUsers (NotificationID, AdminUserID)
		SELECT NR.NotificationID, @AdminID FROM NotificationRoles AS NR INNER JOIN Notifications AS N ON NR.NotificationID = N.NotificationID WHERE RoleID = 6 AND N.AutoOptIn = 1 AND (@AdminID NOT IN (SELECT AdminUserID FROM NotificationUsers WHERE NotificationID = N.NotificationID))
		end
END
GO
