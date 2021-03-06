USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 21/04/2015
-- Description:	Returns average time taken for a customisation.
-- =============================================
CREATE FUNCTION [dbo].[GetMinsForCustomisation]
(
	@CustomisationID Int
)
RETURNS nvarchar(20)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Mins Int
	declare @hours  nvarchar(20)
	SELECT       @Mins =  COALESCE(CAST(SUM(Mins) AS Int), 0)
FROM            (SELECT        TutorialID, CASE WHEN OverrideTutorialMins > 0 THEN OverrideTutorialMins ELSE AverageTutMins END AS Mins
FROM            Tutorials
WHERE        (TutorialID IN
                             (SELECT        TutorialID
                               FROM            CustomisationTutorials
                               WHERE        (Status = 1) AND (CustomisationID = @CustomisationID)))) AS Q1
SET @hours = 
    CASE WHEN @Mins >= 60 THEN
        (SELECT CAST((@Mins / 60) AS VARCHAR(2)) + 'h ' +  
                CASE WHEN (@Mins % 60) > 0 THEN
                    CAST((@Mins % 60) AS VARCHAR(2)) + 'm'
                ELSE
                    ''
                END)
				WHEN @Mins > 0 THEN
CAST((@Mins % 60) AS VARCHAR(2)) + 'm'
    ELSE 
       'N/A'
    END
RETURN @hours
END
GO
