USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 10/04/2019
-- Description:	Returns the GroupCustomisationID if the progress record matches to a group cohort or 0 if it doesn't.
-- =============================================
CREATE FUNCTION [dbo].[GetCohortGroupCustomisationID]
(
	-- Add the parameters for the function here
	@ProgressID Int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @GroupCustomisationID Int

	-- Add the T-SQL statements to compute the return value here
	SELECT  TOP(1) @GroupCustomisationID =  gc.GroupCustomisationID
FROM            GroupCustomisations AS gc RIGHT OUTER JOIN
                         Customisations AS c ON gc.CustomisationID = c.CustomisationID RIGHT OUTER JOIN
                         Progress AS p ON c.CustomisationID = p.CustomisationID
WHERE        (p.ProgressID = @ProgressID) AND (gc.CohortLearners = 1)
ORDER BY GroupCustomisationID
IF @GroupCustomisationID IS NULL
BEGIN
SET @GroupCustomisationID = 0
END
	-- Return the result of the function
	RETURN @GroupCustomisationID

END
GO
