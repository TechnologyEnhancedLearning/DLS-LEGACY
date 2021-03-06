USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 13/06/2018
-- Description:	Adds Notification User record if it doesn't already exist
-- =============================================
CREATE PROCEDURE [dbo].[InsertCandidateNotificationIfNotExists]
	-- Add the parameters for the stored procedure here
	@CandidateID int,
	@NotificationID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if not exists (SELECT * FROM NotificationUsers WHERE
                         (NotificationID = @NotificationID) AND (CandidateID = @CandidateID))
Begin
INSERT INTO NotificationUsers
                         (NotificationID, CandidateID)
VALUES        (@NotificationID,@CandidateID)
end
END

GO
