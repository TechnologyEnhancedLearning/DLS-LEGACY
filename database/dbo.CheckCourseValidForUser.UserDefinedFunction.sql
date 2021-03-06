USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 15/10/15
-- Description:	Returns TRUE if the course is valid for the centre / user. False if not.
-- =============================================
CREATE FUNCTION [dbo].[CheckCourseValidForUser]
(
	@CourseID Int,
	@CentreID int,
	@PublishToAll bit
)
RETURNS Bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar bit

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultVar = CAST(CASE WHEN @CourseID IN
                             (SELECT        ApplicationID
                               FROM            Applications AS a
                               WHERE        (ASPMenu = 1) AND (ArchivedDate IS NULL) AND (CreatedByCentreID = @CentreID) OR
                                                         (ASPMenu = 1) AND (ArchivedDate IS NULL) AND (@PublishToAll = 1)
                               ) THEN 1 ELSE 0 END AS Bit)

	-- Return the result of the function
	RETURN @ResultVar

END
GO
