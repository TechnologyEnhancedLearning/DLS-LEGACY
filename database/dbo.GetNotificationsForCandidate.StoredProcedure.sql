USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 04/09/2018
-- Description:	Gets available notification and candidate subscription status.
-- =============================================
CREATE PROCEDURE [dbo].[GetNotificationsForCandidate]
	-- Add the parameters for the stored procedure here
	@CandidateID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        n.NotificationID, n.NotificationName, n.Description, CAST((SELECT COUNT(NotificationUserID) FROM NotificationUsers WHERE NotificationID = n.NotificationID AND CandidateID = @CandidateID) AS Bit) AS UserSubscribed,  [dbo].[RolesForNotificationCSV] (
   n.NotificationID) AS RolesList
FROM            Notifications AS n INNER JOIN
                         NotificationRoles AS nr ON n.NotificationID = nr.NotificationID
WHERE				nr.RoleID = 5	
						 GROUP BY n.NotificationID, n.NotificationName, n.Description
END

GO
