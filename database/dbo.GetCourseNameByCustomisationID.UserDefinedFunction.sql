USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 03/05/2018
-- Description:	Gets the application and customisation name for a CustomisationID
-- =============================================
CREATE FUNCTION [dbo].[GetCourseNameByCustomisationID]
(
	-- Add the parameters for the function here
	@CustomisationID Int
)
RETURNS nvarchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(255)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = a.ApplicationName + ' - ' + c.CustomisationName FROM Customisations AS c INNER JOIN Applications as a ON c.ApplicationID = a.ApplicationID WHERE c.CustomisationID = @CustomisationID

	-- Return the result of the function
	RETURN @Result

END

GO
