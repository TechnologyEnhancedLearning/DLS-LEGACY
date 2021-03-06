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
CREATE PROCEDURE [dbo].[uspReturnProgressDetail_V2]
	-- Add the parameters for the stored procedure here
	@ProgressID Int,
	@SectionID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT        T.SectionID, T.TutorialID, CASE WHEN T .OverrideTutorialMins > 0 THEN T .OverrideTutorialMins ELSE T .AverageTutMins END AS AvgTime, T.TutorialName, T.ExamAreaID, T.VideoPath, T.TutorialPath, 
                         T.SupportingMatsPath, T.Active, AP.TutStat, TutStatus.Status, AP.TutTime, AP.ProgressID, AP.DiagLast AS TutScore, T.DiagAssessOutOf AS PossScore, CT.DiagStatus, AP.DiagAttempts, T.Objectives
FROM            Progress AS P INNER JOIN
                         Tutorials AS T INNER JOIN
                         CustomisationTutorials AS CT ON T.TutorialID = CT.TutorialID INNER JOIN
                         Customisations AS C ON CT.CustomisationID = C.CustomisationID ON P.CustomisationID = C.CustomisationID AND P.CustomisationID = CT.CustomisationID INNER JOIN
                         TutStatus INNER JOIN
                         aspProgress AS AP ON TutStatus.TutStatusID = AP.TutStat ON P.ProgressID = AP.ProgressID AND T.TutorialID = AP.TutorialID
WHERE        (T.SectionID = @SectionID) AND (P.ProgressID = @ProgressID) AND (CT.Status = 1) AND (C.Active = 1)
ORDER BY T.OrderByNumber
END

GO
