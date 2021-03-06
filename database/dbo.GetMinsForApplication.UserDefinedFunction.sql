USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 31/01/2019
-- Description:	Returns average time taken for a application.
-- =============================================
CREATE FUNCTION [dbo].[GetMinsForApplication]
(
	@ApplicationID Int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Mins Int
	
	SELECT       @Mins =  COALESCE(CAST(SUM(Mins) AS Int), 0)
FROM            (SELECT        TutorialID, CASE WHEN OverrideTutorialMins > 0 THEN OverrideTutorialMins ELSE AverageTutMins END AS Mins
FROM            Tutorials t INNER JOIN Sections s ON t.SectionID = s.SectionID
WHERE      (s.[ApplicationID] = @ApplicationID) and (t.Active = 1) and (s.ArchivedDate IS NULL)) AS Q1

RETURN @Mins
END
GO
