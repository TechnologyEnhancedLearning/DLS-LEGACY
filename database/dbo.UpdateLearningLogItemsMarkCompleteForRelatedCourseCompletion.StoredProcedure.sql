USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 16/10/2019
-- Description:	Checks for related incomplete learning log items when a progress record is complete and marks them as complete.
-- =============================================
CREATE PROCEDURE [dbo].[UpdateLearningLogItemsMarkCompleteForRelatedCourseCompletion] 
	-- Add the parameters for the stored procedure here
	@ProgressID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_CustomisationID Int
	DECLARE @_CandidateID Int
	DECLARE @_Duration int
    -- Insert statements for procedure here
	SELECT @_CustomisationID=CustomisationID, @_CandidateID=CandidateID, @_Duration = Duration FROM Progress WHERE ProgressID = @ProgressID
	DECLARE @_RecordsAffected Int = 0
	SELECT      @_RecordsAffected =  COUNT(lli.LearningLogItemID)
FROM            LearningLogItems AS lli INNER JOIN
                         ProgressLearningLogItems AS plli ON lli.LearningLogItemID = plli.LearningLogItemID INNER JOIN
                         Progress AS p ON plli.ProgressID = p.ProgressID
WHERE        (p.CandidateID = @_CandidateID) AND (lli.LinkedCustomisationID = @_CustomisationID) AND (lli.CompletedDate IS NULL) AND (lli.ArchivedDate IS NULL)
IF @_RecordsAffected > 0
begin
	UPDATE       lli
SET                CompletedDate =getDate(), DurationMins = @_Duration
FROM            LearningLogItems AS lli INNER JOIN
                         ProgressLearningLogItems AS plli ON lli.LearningLogItemID = plli.LearningLogItemID INNER JOIN
                         Progress AS p ON plli.ProgressID = p.ProgressID
WHERE        (p.CandidateID = @_CandidateID) AND (lli.LinkedCustomisationID = @_CustomisationID) AND (lli.CompletedDate IS NULL) AND (lli.ArchivedDate IS NULL)
end
SELECT @_RecordsAffected
Return @_RecordsAffected
END
GO
