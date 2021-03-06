USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 30/01/2020
-- Description:	Updates a LearningLogItem record and removes ProgressLearningLogItems for delegates who did not attend.
-- =============================================
CREATE PROCEDURE [dbo].[UpdateScheduledLearningLogItem]
	@LearningLogItemID int,
	@DueDate datetime,
	@CompletedDate datetime,
	@DurationMins int,
	@Topic nvarchar(255),
	@Outcomes nvarchar(MAX),
	@AdminID int,
	@LinkedProgressIDsCSV nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert new loearning log item:
	BEGIN
	UPDATE LearningLogItems SET DueDate=@DueDate, CompletedDate=@CompletedDate, DurationMins=@DurationMins, Topic=@Topic, Outcomes=@Outcomes, VerifiedByID = @AdminID 
	WHERE LearningLogItemID = @LearningLogItemID
	END

	-- Insert related log item tutorial link table records:
	BEGIN

		-- Remove any delegate progress link records where the delegate didn't attend:
		DELETE FROM ProgressLearningLogItems
		WHERE LearningLogItemID = @LearningLogItemID AND LearningLogID NOT IN (SELECT ID AS LearningLogID FROM [dbo].[tvfSplitCSV] (@LinkedProgressIDsCSV))
		END
END
GO
