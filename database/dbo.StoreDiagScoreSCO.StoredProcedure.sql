USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 08/08/2018
-- Description:	Updates the diagnostic score for a delegate using ProgressID and TutorialID to identify ASPProgress record to update
-- =============================================
CREATE PROCEDURE [dbo].[StoreDiagScoreSCO]
	@score int,
	@progressid int, 
	@TutorialID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE    aspProgress
SET              DiagHigh = (CASE WHEN DiagHigh > @score THEN DiagHigh ELSE @score END), 
                      DiagLow = (CASE WHEN DiagLow < @score AND DiagAttempts > 0 THEN DiagLow ELSE @score END), DiagLast = @score, DiagAttempts = DiagAttempts + 1
FROM            aspProgress INNER JOIN
                             (SELECT        TOP (1) t.TutorialID
                               FROM            Tutorials AS t INNER JOIN
                                                         Sections AS s ON t.SectionID = s.SectionID
                               WHERE        (t.OriginalTutorialID = @TutorialID) AND (s.ApplicationID =
                                                             (SELECT        c.ApplicationID
                                                               FROM            Customisations AS c INNER JOIN
                                                                                         Progress AS p ON c.CustomisationID = p.CustomisationID
                                                               WHERE        (p.ProgressID = @ProgressID))) OR
                                                         (s.ApplicationID =
                                                             (SELECT        c.ApplicationID
                                                               FROM            Customisations AS c INNER JOIN
                                                                                         Progress AS p ON c.CustomisationID = p.CustomisationID
                                                               WHERE        (p.ProgressID = @ProgressID))) AND (t.TutorialID = @TutorialID)) AS Q1 ON aspProgress.TutorialID = Q1.TutorialID
WHERE        (aspProgress.ProgressID = @progressid)
END
GO
