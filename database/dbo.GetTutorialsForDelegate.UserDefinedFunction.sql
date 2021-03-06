USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 12/04/2013
-- Description:	This function returns a table of valid tutorialIDs for a delegate according to which courses they have registered for
-- =============================================

CREATE FUNCTION [dbo].[GetTutorialsForDelegate]
(
	@delegateID varchar(100)
)
RETURNS @TutorialTable TABLE 
(
	TutorialID int
)

AS	  
BEGIN
INSERT INTO @TutorialTable
	SELECT     t.TutorialID
FROM         Candidates AS c LEFT OUTER JOIN
                      CustomisationTutorials AS ct LEFT OUTER JOIN
                      Sections AS s RIGHT OUTER JOIN
                      Applications AS a ON s.ApplicationID = a.ApplicationID LEFT OUTER JOIN
                      Tutorials AS t ON s.SectionID = t.SectionID ON ct.TutorialID = t.TutorialID RIGHT OUTER JOIN
                      Customisations AS cu ON ct.CustomisationID = cu.CustomisationID RIGHT OUTER JOIN
                      Progress AS p ON cu.CustomisationID = p.CustomisationID ON c.CandidateID = p.CandidateID
WHERE     (a.ASPMenu = 1) AND (t.Active = 1) AND ((c.CandidateNumber = @delegateID) OR (c.AliasID = @delegateID)) AND
                      (ct.Status = 1) 
GROUP BY t.TutorialID, a.ApplicationName, t.TutorialName, a.ApplicationName, s.SectionNumber
ORDER BY a.ApplicationName, s.SectionNumber, t.TutorialID
RETURN
END


GO
