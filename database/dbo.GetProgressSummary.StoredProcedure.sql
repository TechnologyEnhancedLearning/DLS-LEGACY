USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 03/10/2018
-- Description:	Returns progress detail
-- =============================================
CREATE PROCEDURE [dbo].[GetProgressSummary]
	-- Add the parameters for the stored procedure here
	@ProgressID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        ProgressID, CandidateID, SubmittedTime, Completed, Evaluated, FirstSubmittedTime, DiagnosticScore, ModifierID, CustomisationName, ASPMenu, ApplicationName, IsAssessed, AssessCount, AssessPass, LoginCount, 
                         LearningTime, CASE WHEN q1.AssessCount = 0 THEN NULL ELSE 100.0 * CAST(q1.AssessPass AS float) / CAST(q1.AssessCount AS float) END AS AssessRatio, CompleteByDate, EnrollmentMethodID, EnrolledBy, RemovedDate
FROM            (SELECT        p.ProgressID, p.CandidateID, p.SubmittedTime, p.Completed, p.Evaluated, p.FirstSubmittedTime, p.DiagnosticScore, p.ModifierID, c.CustomisationName, a.ASPMenu, a.ApplicationName, c.Question1, c.Question2, 
                                                    c.Question3, c.IsAssessed, P.EnrollmentMethodID, (SELECT Forename + ' ' Surname FROM AdminUsers WHERE AdminID = P.EnrolledByAdminID) AS EnrolledBy, P.RemovedDate,
                                                        (SELECT        COUNT(*) AS Expr1
                                                          FROM            AssessAttempts
                                                          WHERE        (ProgressID = @ProgressID)) AS AssessCount,
                                                        (SELECT        COUNT(*) AS Expr1
                                                          FROM            AssessAttempts AS AssessAttempts_1
                                                          WHERE        (ProgressID = @ProgressID) AND (Status = 1)) AS AssessPass,
                                                        p.LoginCount,
                                                        p.Duration AS LearningTime, p.CompleteByDate
                          FROM            Progress AS p INNER JOIN
                                                    Customisations AS c ON p.CustomisationID = c.CustomisationID INNER JOIN
                                                    Applications AS a ON c.ApplicationID = a.ApplicationID
                          WHERE        (p.ProgressID = @ProgressID) ) AS q1
END


GO
