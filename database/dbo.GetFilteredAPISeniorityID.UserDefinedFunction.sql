USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 21/09/2020
-- Description:	Returns calculated SeniorityID for Filtered API
-- =============================================
CREATE FUNCTION [dbo].[GetFilteredAPISeniorityID] 
(
	-- Add the parameters for the function here
	@SelfAssessmentID int,
	@CandidateID int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Res int

	-- Add the T-SQL statements to compute the return value here
	SELECT @Res = (SELECT TOP (1) fsm.SeniorityID
FROM   (SELECT CompetencyGroupID, Confidence, [Relevance]
             FROM    dbo.GetSelfAssessmentSummaryForCandidate(@CandidateID, @SelfAssessmentID) AS GetSelfAssessmentSummaryForCandidate_1
             WHERE  (Confidence IS NOT NULL) AND ([Relevance] IS NOT NULL)) AS t INNER JOIN
             FilteredSeniorityMapping AS fsm ON t.CompetencyGroupID = fsm.CompetencyGroupID
ORDER BY t.[Relevance] - t.Confidence DESC)

	-- Return the result of the function
	RETURN @Res

END
GO
