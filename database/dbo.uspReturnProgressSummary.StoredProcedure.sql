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
CREATE PROCEDURE [dbo].[uspReturnProgressSummary]
	-- Add the parameters for the stored procedure here
	@ProgressID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     p.ProgressID, p.Completed, p.Evaluated, COALESCE
                          ((SELECT     MAX(DiagAttempts) AS Expr1
                              FROM         aspProgress
                              WHERE     (ProgressID = p.ProgressID)), 0) AS DiagAttempts, p.DiagnosticScore,
                          (SELECT     SUM(TutTime) AS TotTime
                            FROM          aspProgress AS ap
                            WHERE      (ProgressID = p.ProgressID)) AS TotTime, CASE WHEN
                          (SELECT     COUNT(CusTutID) AS Tuts
                            FROM          CustomisationTutorials AS ct
                            WHERE      (Status = 1) AND (CustomisationID = p.CustomisationID)) > 0 THEN
                          ((SELECT     SUM(TutStat) AS Done
                              FROM         aspProgress ap
                              WHERE     ProgressID = p.ProgressID)) * 100 /
                          ((SELECT     COUNT(CusTutID) AS Tuts
                              FROM         CustomisationTutorials AS ct
                              WHERE     (Status = 1) AND (CustomisationID = p.CustomisationID)) * 2) ELSE - 1 END AS LearningDone, COALESCE
                          ((SELECT     MAX(Attempts) AS Attempts
                              FROM         (SELECT     COUNT(AssessAttemptID) AS Attempts
                                                     FROM          AssessAttempts AS aa
                                                     WHERE      (CandidateID = p.CandidateID) AND (CustomisationID = p.CustomisationID)
                                                     GROUP BY SectionNumber) AS derivedtbl_1), 0) AS PLAttempts, COALESCE
                          ((SELECT     COUNT(Passes) AS Passes
                              FROM         (SELECT     COUNT(AssessAttemptID) AS Passes
                                                     FROM          AssessAttempts AS aa
                                                     WHERE      (CandidateID = p.CandidateID) AND (CustomisationID = p.CustomisationID) AND (Status = 1)
                                                     GROUP BY SectionNumber) AS derivedtbl_2), 0) AS PLPasses,
                          (SELECT     COUNT(s.SectionID) AS Sections
                            FROM          Sections AS s INNER JOIN
                                                   Applications AS a ON s.ApplicationID = a.ApplicationID INNER JOIN
                                                   Customisations AS c ON a.ApplicationID = c.ApplicationID
                            WHERE      (c.CustomisationID = p.CustomisationID)) AS Sections, Customisations.IsAssessed, Customisations.TutCompletionThreshold, 
                      Customisations.DiagCompletionThreshold
FROM         Progress AS p INNER JOIN
                      Customisations ON p.CustomisationID = Customisations.CustomisationID
WHERE     (p.ProgressID = @ProgressID)
END

GO
