USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 09/01/2019
-- Description:	Returns data for Course Delegates grid. V2 adds Active Only param for ticket #165.
-- =============================================
CREATE PROCEDURE [dbo].[GetDelegatesForCustomisation_V2]
	-- Add the parameters for the stored procedure here
	@CustomisationID Int,
	@CentreID Int,
	@ActiveOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ProgressID, CourseName, CandidateID, LastName + ', ' + FirstName AS DelegateName, Email, SelfReg, DateRegistered, CandidateNumber, SubmittedTime AS LastUpdated, 
                  Active, AliasID, JobGroupID,
                      (SELECT JobGroupName
                       FROM      JobGroups
                       WHERE   (JobGroupID = q2.JobGroupID)) AS JobGroupName, Completed, RemovedDate, Logins, Duration, Passes, Attempts, PLLocked, CASE WHEN q2.Attempts = 0 THEN NULL 
                  ELSE q2.PassRate END AS PassRatio, DiagnosticScore, CustomisationID, Answer1, Answer2, Answer3, CompleteByDate
FROM     (SELECT ProgressID, CourseName, CandidateID, FirstName, LastName, Email, SelfReg, DateRegistered, CandidateNumber, SubmittedTime, Active, AliasID, JobGroupID, 
                                    Completed, RemovedDate, Logins, Duration, Attempts, Passes, CASE WHEN q1.Attempts = 0 THEN 0.0 ELSE 100.0 * CAST(q1.Passes AS float) / CAST(q1.Attempts AS float) 
                                    END AS PassRate, DiagnosticScore, CustomisationID, PLLocked, Answer1, Answer2, Answer3, CompleteByDate
                  FROM      (SELECT p.ProgressID, dbo.GetCourseNameByCustomisationID(p.CustomisationID) AS CourseName, c.CandidateID, c.FirstName, c.LastName, 
                                                       c.EmailAddress AS Email, c.SelfReg, p.FirstSubmittedTime AS DateRegistered, c.CandidateNumber, c.Active, c.AliasID, c.JobGroupID, p.SubmittedTime, 
                                                       p.Completed, p.RemovedDate, p.DiagnosticScore, p.CustomisationID,
                                                           p.LoginCount AS Logins,
                                                          p.Duration,
                                                           (SELECT COUNT(*) AS Expr1
                                                            FROM      AssessAttempts AS a
                                                            WHERE   (ProgressID = p.ProgressID)) AS Attempts,
                                                           (SELECT SUM(CAST(Status AS int)) AS Expr1
                                                            FROM      AssessAttempts AS a1
                                                            WHERE   (ProgressID = p.ProgressID)) AS Passes, p.PLLocked, c.Answer1, c.Answer2, c.Answer3, 
                                                       p.CompleteByDate
                                     FROM      Candidates AS c INNER JOIN
                                                       Progress AS p ON c.CandidateID = p.CandidateID
                                     WHERE   (p.CustomisationID = @CustomisationID) OR
                                                       (p.CustomisationID IN
                                                           (SELECT c1.CustomisationID
                                                            FROM      Customisations As c1
                                                            WHERE   (c1.CentreID = @CentreID) AND ((c1.Active = @ActiveOnly) OR (@ActiveOnly = 0)))) AND (CAST(@CustomisationID AS Int)  < 1)) AS q1) AS q2
ORDER BY LastName, FirstName
END


GO
