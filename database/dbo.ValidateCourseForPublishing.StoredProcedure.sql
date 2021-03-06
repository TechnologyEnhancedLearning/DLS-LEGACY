USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 21/05/2018
-- Description:	Returns validation info before publishing a course.
-- =============================================
CREATE PROCEDURE [dbo].[ValidateCourseForPublishing]
	-- Add the parameters for the stored procedure here
	@AppID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        (SELECT        COUNT(s.SectionID) AS Expr1
                          FROM            Applications AS a INNER JOIN
                                                    Sections AS s ON a.ApplicationID = s.ApplicationID
                          WHERE        (a.ApplicationID = @AppID) AND (a.DiagAssess = 1) AND
                                                        ((SELECT        SUM(DiagAssessOutOf) AS Expr1
                                                            FROM            Tutorials
                                                            WHERE        (SectionID = s.SectionID)) = 0)) AS SecsDiagNoOutOf,
                             (SELECT        COUNT(s.SectionID) AS Expr1
                               FROM            Applications AS a INNER JOIN
                                                         Sections AS s ON a.ApplicationID = s.ApplicationID
                               WHERE        (a.DiagAssess = 1) AND (a.ApplicationID = @AppID) AND (COALESCE (s.DiagAssessPath, '') = '')) AS SecsNoDiagUploaded,
                             (SELECT        COUNT(s.SectionID) AS Expr1
                               FROM            Applications AS a INNER JOIN
                                                         Sections AS s ON a.ApplicationID = s.ApplicationID
                               WHERE        (a.ApplicationID = @AppID) AND (a.PLAssess = 1) AND (COALESCE (s.PLAssessPath, '') = '')) AS SecsNoPLUploaded,
                             (SELECT        COUNT(s.SectionID) AS Expr1
                               FROM            Applications AS a INNER JOIN
                                                         Sections AS s ON a.ApplicationID = s.ApplicationID
                               WHERE        (a.DiagAssess = 1) AND (a.ApplicationID = @AppID) AND (s.PLAssessPath LIKE '%itspplayer.html') OR
                                                         (a.DiagAssess = 1) AND (a.ApplicationID = @AppID) AND (s.DiagAssessPath LIKE '%itspplayer.html') OR
                                                         (a.ApplicationID = @AppID) AND (s.PLAssessPath LIKE '%itspplayer.html') AND (a.PLAssess = 1) OR
                                                         (a.ApplicationID = @AppID) AND (s.DiagAssessPath LIKE '%itspplayer.html') AND (a.PLAssess = 1)) AS SecsCCPLorDiag
END
GO
