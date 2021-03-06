USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 22/09/2020
-- Description:	Gets Filtered API profile for candidate
-- =============================================
CREATE PROCEDURE [dbo].[GetFilteredProfileForCandidate]
	-- Add the parameters for the stored procedure here
	@SelfAssessmentID int,
	@CandidateID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
 (SELECT CASE WHEN AVG(Result) < 4 THEN 414 WHEN AVG(Result) < 7 THEN 413 WHEN AVG(Result) < 9 THEN 412 ELSE 411 END AS FunctionID 
FROM   SelfAssessmentResults 
WHERE (CandidateID = @CandidateID) AND (SelfAssessmentID = @SelfAssessmentID) AND (AssessmentQuestionID = 1) ) AS [Function], (SELECT TOP (1) fms.SectorID 

FROM   FilteredSectorsMapping AS fms INNER JOIN 

             Candidates AS ca ON fms.JobGroupID = ca.JobGroupID 

WHERE (ca.CandidateID = @CandidateID)) AS Sector,
(SELECT [dbo].[GetFilteredAPISeniorityID] (
   @SelfAssessmentID,
  @CandidateID)) AS Seniority
  
END
GO
