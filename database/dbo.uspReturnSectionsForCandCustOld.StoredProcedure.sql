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
CREATE PROCEDURE [dbo].[uspReturnSectionsForCandCustOld]
	-- Add the parameters for the stored procedure here
	@CustomisationID Int,
	@CandidateID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     S.SectionID, S.ApplicationID, S.SectionNumber, S.SectionName, (SUM(asp1.TutStat) * 100) / (COUNT(T.TutorialID) * 2) AS PCComplete, 
                      SUM(asp1.TutTime) AS TimeMins, MAX(ISNULL(asp1.DiagAttempts,0)) AS DiagAttempts, SUM(asp1.DiagLast) AS SecScore, SUM(T.DiagAssessOutOf) 
                      AS SecOutOf, S.ConsolidationPath,
                          (SELECT     SUM(TotTime) AS AvgSecTime
                            FROM          (SELECT     AVG(ap.TutTime) AS TotTime, ap.TutorialID
                                                    FROM          aspProgress AS ap INNER JOIN
                                                                           Tutorials ON ap.TutorialID = Tutorials.TutorialID
                                                    WHERE      (Tutorials.SectionID = S.SectionID) AND (ap.TutTime > 0) AND (ap.TutStat = 2)
                                                    GROUP BY ap.TutorialID) AS Q1) AS AvgSecTime, S.DiagAssessPath, S.PLAssessPath, MAX(ISNULL(CAST(CT.Status AS Integer),0)) AS LearnStatus, 
                      MAX(ISNULL(CAST(CT.DiagStatus AS Integer),0)) AS DiagStatus, COALESCE (MAX(ISNULL(aa.Score,0)), 0) AS MaxScorePL,
                          (SELECT     COUNT(AssessAttemptID) AS PLAttempts
                            FROM          AssessAttempts AS aa
                            WHERE      (CandidateID = p.CandidateID) AND (CustomisationID = p.CustomisationID) AND (SectionNumber = S.SectionNumber)) AS AttemptsPL, 
                      COALESCE (MAX (ISNULL(CAST(aa.Status AS Integer),0)), 0) AS PLPassed, cu.IsAssessed, p.PLLocked
FROM         aspProgress AS asp1 INNER JOIN
                      Progress AS p ON asp1.ProgressID = p.ProgressID INNER JOIN
                      Sections AS S INNER JOIN
                      Tutorials AS T ON S.SectionID = T.SectionID INNER JOIN
                      CustomisationTutorials AS CT ON T.TutorialID = CT.TutorialID ON asp1.TutorialID = T.TutorialID INNER JOIN
                      Customisations AS cu ON p.CustomisationID = cu.CustomisationID LEFT OUTER JOIN
                      AssessAttempts AS aa ON S.SectionNumber = aa.SectionNumber AND cu.CustomisationID = aa.CustomisationID AND 
                      p.CandidateID = aa.CandidateID
WHERE     (CT.CustomisationID = @CustomisationID) AND (p.CandidateID = @CandidateID) AND (p.CustomisationID = @CustomisationID) AND (CT.Status = 1) OR
                      (CT.CustomisationID = @CustomisationID) AND (p.CandidateID = @CandidateID) AND (p.CustomisationID = @CustomisationID) AND 
                      (CT.DiagStatus = 1) OR
                      (CT.CustomisationID = @CustomisationID) AND (p.CandidateID = @CandidateID) AND (p.CustomisationID = @CustomisationID) AND (cu.IsAssessed = 1)
GROUP BY S.SectionID, S.ApplicationID, S.SectionNumber, S.SectionName, S.ConsolidationPath, S.DiagAssessPath, S.PLAssessPath, cu.IsAssessed, 
                      p.CandidateID, p.CustomisationID, p.PLLocked
END

GO
