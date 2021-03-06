USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 25/11/2019
-- Description:	Retrieves the next and previous records for navigating through a self assessment
-- =============================================
CREATE FUNCTION [dbo].[GetNextAndPreviousaspProgressIDs]
(	
	-- Add the parameters for the function here
	@ProgressID int,
	@aspProgressID int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT (SELECT        COUNT(*)
FROM            aspProgress AS ap INNER JOIN
                         Progress AS p ON ap.ProgressID = p.ProgressID INNER JOIN
                         CustomisationTutorials AS ct ON p.CustomisationID = ct.CustomisationID AND ap.TutorialID = ct.TutorialID INNER JOIN
                         Tutorials AS t ON ap.TutorialID = t.TutorialID
WHERE        (ap.ProgressID = @ProgressID) AND (ct.Status = 1) AND (t.ContentTypeID = 4) AND (t.ArchivedDate IS NULL)) AS vCount,vRowNum, vPrev, vNext 
FROM (SELECT       ROW_NUMBER() OVER (ORDER BY s.SectionNumber, t.OrderByNumber) AS vRowNum, LAG(ap.aspProgressID) OVER (ORDER BY s.SectionNumber, t.OrderByNumber) AS vPrev, ap.aspProgressID, LEAD(ap.aspProgressID) OVER (ORDER BY s.SectionNumber, t.OrderByNumber) AS vNext
FROM            aspProgress AS ap INNER JOIN
                         Progress AS p ON ap.ProgressID = p.ProgressID INNER JOIN
                         CustomisationTutorials AS ct ON p.CustomisationID = ct.CustomisationID AND ap.TutorialID = ct.TutorialID INNER JOIN
                         Tutorials AS t ON ap.TutorialID = t.TutorialID INNER JOIN
                         Sections AS s ON t.SectionID = s.SectionID
WHERE        (ap.ProgressID = @ProgressID) AND (ct.Status = 1) AND (t.ContentTypeID = 4) AND (t.ArchivedDate IS NULL)) AS Q1
WHERE Q1.aspProgressID = @aspProgressID
GROUP BY vPrev, vNext, vRowNum
)
GO
