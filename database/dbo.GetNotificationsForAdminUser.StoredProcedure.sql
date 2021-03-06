USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 04/09/2018
-- Description:	Gets available notification and admin user subscription status.
-- =============================================
CREATE PROCEDURE [dbo].[GetNotificationsForAdminUser]
	-- Add the parameters for the stored procedure here
	@AdminUserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @CC bit = 0
	DECLARE @CA bit = 0
	DECLARE @CMS bit = 0
	DECLARE @TR bit = 0
	DECLARE @CM bit = 0
	SELECT @CC = ContentCreator, @CA = CentreAdmin, @CMS = ContentManager, @CM = IsCentreManager, @TR = Supervisor FROM AdminUsers WHERE AdminID = @AdminUserID
    -- Insert statements for procedure here
	SELECT        n.NotificationID, n.NotificationName, n.Description, CAST((SELECT COUNT(NotificationUserID) FROM NotificationUsers WHERE NotificationID = n.NotificationID AND AdminUserID = @AdminUserID) AS Bit) AS UserSubscribed,  [dbo].[RolesForNotificationCSV] (
   n.NotificationID) AS RolesList
FROM            Notifications AS n INNER JOIN
                    NotificationRoles AS nr ON n.NotificationID = nr.NotificationID
WHERE				(nr.RoleID = 1	AND @CA = 1) OR
					(nr.RoleID = 2	AND @CM = 1) OR
					(nr.RoleID = 3	AND @CMS = 1) OR
					(nr.RoleID = 4	AND @CC = 1) OR
					(nr.RoleID = 6	AND @TR = 1)
GROUP BY n.NotificationID, n.NotificationName, n.Description
END

GO
