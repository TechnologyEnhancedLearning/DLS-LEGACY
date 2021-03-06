USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 12/06/14
-- Description:	Returns knoweldge bank results for centre / candidate for use with https://www.kunkalabs.com/mixitup-multifilter
-- =============================================
CREATE PROCEDURE [dbo].[GetKnowledgeBankData] 
	-- parameters
	@CentreID int,
	@CandidateID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF 1=0 BEGIN
    SET FMTONLY OFF
END
    --
	-- These define the SQL to use
	--
	SELECT        t.TutorialID, t.TutorialName, REPLACE(t.VideoPath, 'swf', 'mp4') + '.jpg' AS VideoPath, a.MoviePath + t.TutorialPath AS TutorialPath, COALESCE (t.Keywords, '') AS Keywords, COALESCE (t.Objectives, '') AS Objectives,
                             (SELECT        BrandName
                               FROM            Brands
                               WHERE        (BrandID = a.BrandID)) AS Brand,
                             (SELECT        CategoryName
                               FROM            CourseCategories
                               WHERE        (CourseCategoryID = a.CourseCategoryID)) AS Category,
                             (SELECT        CourseTopic
                               FROM            CourseTopics
                               WHERE        (CourseTopicID = a.CourseTopicID)) AS Topic, COALESCE (a.ShortAppName, a.ApplicationName) AS ShortAppName, t.VideoCount, COALESCE (COUNT(vr.VideoRatingID), 0) AS Rated, CONVERT(Decimal(10, 1), 
                         COALESCE (AVG(vr.Rating * 1.0), 0)) AS VidRating, @CandidateID AS CandidateID, a.hEmbedRes, a.vEmbedRes
FROM            VideoRatings AS vr RIGHT OUTER JOIN
                         Tutorials AS t ON vr.TutorialID = t.TutorialID INNER JOIN
                         Sections AS s ON t.SectionID = s.SectionID INNER JOIN
                         Applications AS a ON s.ApplicationID = a.ApplicationID
WHERE        (t.Active = 1) AND (a.ASPMenu = 1) AND (a.ApplicationID IN
                             (SELECT        A1.ApplicationID
                               FROM            Applications AS A1 INNER JOIN
                                                         CentreApplications AS CA1 ON A1.ApplicationID = CA1.ApplicationID
                               WHERE        (CA1.CentreID = @CentreID)))
GROUP BY t.TutorialID, t.TutorialName, t.VideoPath, a.MoviePath + t.TutorialPath, t.Objectives, a.AppGroupID, t.VideoCount, a.ShortAppName, a.ApplicationName, a.hEmbedRes, a.vEmbedRes, a.BrandID, a.CourseCategoryID, 
                         a.CourseTopicID, COALESCE (a.ShortAppName, a.ApplicationName), t.Keywords, t.Objectives
ORDER BY VidRating DESC, t.VideoCount DESC, Rated DESC
END

GO
