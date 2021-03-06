USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 20/09/2019
-- Description:	Returns a list of tutorials related to the log item as a string.
-- =============================================
CREATE FUNCTION [dbo].[ReturnTutorialsLinkedToLogItemAsString]
(
	-- Add the parameters for the function here
	@LearningLogItemID Int
)
RETURNS nvarchar(2000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar nvarchar(2000)

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultVar = COALESCE(STUFF((SELECT ', ' + Q1.TutorialName 
FROM            (SELECT        t.TutorialName
FROM            LearningLogItemTutorials AS lit INNER JOIN Tutorials AS t ON lit.TutorialID = t.TutorialID
WHERE        (LearningLogItemID = @LearningLogItemID)) AS Q1
ORDER BY TutorialName
FOR XML PATH('')),1, 2, ''), '')


	-- Return the result of the function
	RETURN @ResultVar

END
GO
