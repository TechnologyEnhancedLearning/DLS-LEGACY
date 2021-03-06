USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 15/08/2013
-- Description:	Gets section table for learning menu
-- =============================================
CREATE PROCEDURE [dbo].[uspReturnProgressDetail_V3]
	-- Add the parameters for the stored procedure here
	@ProgressID Int,
	@SectionID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT        AP.aspProgressID, T.SectionID, T.TutorialID, CASE WHEN T .OverrideTutorialMins > 0 THEN T .OverrideTutorialMins ELSE T .AverageTutMins END AS AvgTime, T.TutorialName, T.ExamAreaID, T.VideoPath, T.TutorialPath, 
                         T.SupportingMatsPath, T.Active, AP.TutStat, TutStatus.Status, AP.TutTime, AP.ProgressID, AP.DiagLast AS TutScore, T.DiagAssessOutOf AS PossScore, CT.DiagStatus, AP.DiagAttempts, T.Objectives, T.ContentTypeID, 
                         T.LearnerMarksCompletion, T.DefaultMethodID, T.SupervisorVerify, CASE WHEN AP.SupervisorVerifiedDate IS NULL 
                         THEN 'Not Verified' WHEN AP.SupervisorOutcome = 0 THEN T .SupervisorFailText WHEN AP.SupervisorOutcome = 1 THEN T .SupervisorSuccessText END AS SupervisorOutcomeText, AP.SupervisorVerifiedDate, 
                         AP.LastReviewed,

						 (SELECT        COUNT(*) AS LogActions
FROM            ProgressLearningLogItems AS pl INNER JOIN
                         LearningLogItems AS li ON pl.LearningLogItemID = li.LearningLogItemID INNER JOIN
                         LearningLogItemTutorials AS lit ON li.LearningLogItemID = lit.LearningLogItemID
WHERE        (pl.ProgressID = @ProgressID) AND (lit.TutorialID = T.TutorialID) AND (li.CompletedDate IS NULL) AND (li.ArchivedDate IS NULL)) AS LogActions,


(SELECT         COUNT(*) AS LogCompleted
                          
FROM            ProgressLearningLogItems AS pl INNER JOIN
                         LearningLogItems AS li ON pl.LearningLogItemID = li.LearningLogItemID INNER JOIN
                         LearningLogItemTutorials AS lit ON li.LearningLogItemID = lit.LearningLogItemID
WHERE        (pl.ProgressID = @ProgressID) AND (lit.TutorialID = T.TutorialID) AND (li.CompletedDate IS NOT NULL) AND (li.ArchivedDate IS NULL)) AS LogCompleted,


                           
                         CASE WHEN T .AssessmentTypeID = 0 THEN '' WHEN AP.AssessDescriptorID = 0 THEN 'Not assessed' ELSE
                             (SELECT        DescriptorText
                               FROM            AssessmentTypeDescriptors
                               WHERE        AssessmentTypeDescriptorID = AP.AssessDescriptorID) END AS SelfAssessStatus, COALESCE (AP.SupervisorOutcome, - 1) AS SupervisorOutcome, AP.AssessDescriptorID, AP.SupervisorVerificationRequested
FROM            Progress AS P INNER JOIN
                         Tutorials AS T INNER JOIN
                         CustomisationTutorials AS CT ON T.TutorialID = CT.TutorialID INNER JOIN
                         Customisations AS C ON CT.CustomisationID = C.CustomisationID ON P.CustomisationID = C.CustomisationID AND P.CustomisationID = CT.CustomisationID INNER JOIN
                         TutStatus INNER JOIN
                         aspProgress AS AP ON TutStatus.TutStatusID = AP.TutStat ON P.ProgressID = AP.ProgressID AND T.TutorialID = AP.TutorialID
WHERE        (T.SectionID = @SectionID) AND (P.ProgressID = @ProgressID) AND (CT.Status = 1) AND (C.Active = 1) AND (T.ArchivedDate IS NULL)
ORDER BY T.OrderByNumber
END

GO
