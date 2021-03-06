USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 28/01/16
-- Description:	Returns TRUE if the customisation and or section has diagnostic switched on.
-- =============================================
CREATE FUNCTION [dbo].[CheckCustomisationSectionHasDiagnostic]
(
	@CustomisationID Int,
	@SectionID int --0 = ignore
)
RETURNS Bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar bit

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultVar = CASE WHEN COUNT(ct.TutorialID) > 0 THEN 1 ELSE 0 END
FROM            CustomisationTutorials AS ct INNER JOIN
                         Tutorials AS t ON ct.TutorialID = t.TutorialID INNER JOIN
                         Customisations AS c ON ct.CustomisationID = c.CustomisationID INNER JOIN
                         Applications AS a ON c.ApplicationID = a.ApplicationID
WHERE        (t.SectionID = @SectionID) AND (ct.CustomisationID = @CustomisationID) AND (ct.DiagStatus = 1) AND (a.DiagAssess = 1) OR
                         (ct.Status = 1) AND (ct.CustomisationID = @CustomisationID) AND (@SectionID = 0)

	-- Return the result of the function
	RETURN @ResultVar

END


GO
