USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 28/01/16
-- Description:	Returns TRUE if the course has Post Learning assessments and they are switched on.
-- =============================================
CREATE FUNCTION [dbo].[CheckCustomisationHasAssessment]
(
	@CustomisationID Int
)
RETURNS Bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar bit

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultVar = CASE WHEN c.IsAssessed = 1 AND a.PLAssess = 1 THEN 1 ELSE 0 END
FROM            Customisations AS c INNER JOIN
                         Applications AS a ON c.ApplicationID = a.ApplicationID

	-- Return the result of the function
	RETURN @ResultVar

END

GO
