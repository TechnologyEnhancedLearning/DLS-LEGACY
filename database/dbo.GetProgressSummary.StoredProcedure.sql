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
SELECT ProgressID, CandidateID, SubmittedTime, Completed, Evaluated, FirstSubmittedTime, DiagnosticScore, ModifierID, CustomisationName, ASPMenu, ApplicationName, IsAssessed, AssessCount, AssessPass, LoginCount, LearningTime, CASE WHEN q1.AssessCount = 0 THEN NULL 
             ELSE 100.0 * CAST(q1.AssessPass AS float) / CAST(q1.AssessCount AS float) END AS AssessRatio, CompleteByDate, EnrollmentMethodID, EnrolledBy, RemovedDate, Question1, Question2, Question3, Answer1, Answer2, Answer3, Supervisor
FROM   (SELECT p.ProgressID, p.CandidateID, p.SubmittedTime, p.Completed, p.Evaluated, p.FirstSubmittedTime, p.DiagnosticScore, p.ModifierID, c.CustomisationName, a.ASPMenu, a.ApplicationName, p.Answer1, p.Answer2, p.Answer3,
                               (SELECT CoursePrompt
                               FROM    CoursePrompts
                               WHERE (CoursePromptID = c.CourseField1PromptID)) AS Question1,
                               (SELECT CoursePrompt
                               FROM    CoursePrompts AS CoursePrompts_2
                               WHERE (CoursePromptID = c.CourseField2PromptID)) AS Question2,
                               (SELECT CoursePrompt
                               FROM    CoursePrompts AS CoursePrompts_1
                               WHERE (CoursePromptID = c.CourseField3PromptID)) AS Question3, c.IsAssessed, p.EnrollmentMethodID,
                               (SELECT Forename + ' ' + Surname AS Expr1
                               FROM    AdminUsers
                               WHERE (AdminID = p.EnrolledByAdminID)) AS EnrolledBy, p.RemovedDate,
                               (SELECT COUNT(*) AS Expr1
                               FROM    AssessAttempts
                               WHERE (ProgressID = p.ProgressID)) AS AssessCount,
                               (SELECT COUNT(*) AS Expr1
                               FROM    AssessAttempts AS AssessAttempts_1
                               WHERE (ProgressID = p.ProgressID) AND (Status = 1)) AS AssessPass,
                               (SELECT COUNT(*) AS Expr1
                               FROM    Sessions
                               WHERE (CandidateID = p.CandidateID) AND (CustomisationID = p.CustomisationID)) AS LoginCount,
                               (SELECT SUM(Duration) AS Expr1
                               FROM    Sessions AS Sessions_1
                               WHERE (CandidateID = p.CandidateID) AND (CustomisationID = p.CustomisationID)) AS LearningTime, p.CompleteByDate, COALESCE
                                                        ((SELECT        Forename + ' ' + Surname
                                                            FROM            AdminUsers AS AdminUsers_1
                                                            WHERE        (AdminID = p.SupervisorAdminID)), 'None') AS Supervisor
             FROM    Progress AS p INNER JOIN
                           Customisations AS c ON p.CustomisationID = c.CustomisationID INNER JOIN
                           Applications AS a ON c.ApplicationID = a.ApplicationID
                          WHERE        (p.ProgressID = @ProgressID) ) AS q1
END

GO
