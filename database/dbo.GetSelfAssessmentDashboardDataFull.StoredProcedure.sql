USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 02/12/2019
-- Description:	Gets anonymous filtered self assessment outcome data for dashboard reports
-- =============================================
CREATE PROCEDURE [dbo].[GetSelfAssessmentDashboardDataFull]
	-- Add the parameters for the stored procedure here
	@CentreID Int,
	@BrandID Int,
	@Category Int,
	@Topic Int,
	@ApplicationID Int,
	@SectionName nvarchar(255),
	@TutorialName nvarchar(255),
	@Answer1 nvarchar(100),
	@Answer2 nvarchar(100),
	@Answer3 nvarchar(100),
	@Answer4 nvarchar(100),
	@Answer5 nvarchar(100),
	@Answer6 nvarchar(100),
	@FilterDate bit,
	@StartDate datetime,
	@EndDate datetime,
	@VerifiedOnly bit,
	@JobGroupID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        b.BrandName, cat.CategoryName, [top].CourseTopic, a.ApplicationName, s.SectionName, t.TutorialName, CASE WHEN c.F1Options IS NOT NULL THEN ca.Answer1 ELSE NULL END AS Answer1, 
                         CASE WHEN c.F2Options IS NOT NULL THEN ca.Answer2 ELSE NULL END AS Answer2, CASE WHEN c.F3Options IS NOT NULL THEN ca.Answer3 ELSE NULL END AS Answer3, CASE WHEN c.F4Options IS NOT NULL 
                         THEN ca.Answer4 ELSE NULL END AS Answer4, CASE WHEN c.F5Options IS NOT NULL THEN ca.Answer5 ELSE NULL END AS Answer5, CASE WHEN c.F6Options IS NOT NULL THEN ca.Answer6 ELSE NULL END AS Answer6, 
                         atd.DescriptorText, ap.LastReviewed, ap.SupervisorOutcome
FROM            CustomisationTutorials AS ct INNER JOIN
                         aspProgress AS ap INNER JOIN
                         Progress AS p INNER JOIN
                         Customisations AS cu ON p.CustomisationID = cu.CustomisationID ON ap.ProgressID = p.ProgressID INNER JOIN
                         AssessmentTypeDescriptors AS atd ON ap.AssessDescriptorID = atd.AssessmentTypeDescriptorID INNER JOIN
                         Applications AS a ON cu.ApplicationID = a.ApplicationID ON ct.CustomisationID = cu.CustomisationID INNER JOIN
                         Tutorials AS t ON ct.TutorialID = t.TutorialID AND ap.TutorialID = t.TutorialID INNER JOIN
                         Candidates AS ca ON p.CandidateID = ca.CandidateID INNER JOIN
                         Brands AS b ON a.BrandID = b.BrandID INNER JOIN
                         CourseCategories AS cat ON a.CourseCategoryID = cat.CourseCategoryID INNER JOIN
                         CourseTopics AS [top] ON a.CourseTopicID = [top].CourseTopicID INNER JOIN
                         Sections AS s ON a.ApplicationID = s.ApplicationID AND t.SectionID = s.SectionID INNER JOIN
                         Centres AS c ON cu.CentreID = c.CentreID
WHERE        (cu.Active = 1) AND (t.ContentTypeID = 4) AND (p.RemovedDate IS NULL) AND (ca.Active = 1) AND (ca.CentreID = @CentreID)
--apply filters:
AND (a.BrandID = @BrandID OR @BrandID <=0)
AND (a.CourseCategoryID = @Category OR @Category <=0)
AND (a.CourseTopicID = @Topic OR @Topic <=0)
AND (a.ApplicationID = @ApplicationID OR @ApplicationID <=0)
AND (s.SectionName = @SectionName OR @SectionName = 'Any')
AND (t.TutorialName = @TutorialName OR @TutorialName ='Any')
AND (ca.Answer1 = @Answer1 OR @Answer1 = 'Any')
AND (ca.Answer2 = @Answer2 OR @Answer2 = 'Any')
AND (ca.Answer3 = @Answer3 OR @Answer3 = 'Any')
AND (ca.Answer4 = @Answer4 OR @Answer4 = 'Any')
AND (ca.Answer5 = @Answer5 OR @Answer5 = 'Any')
AND (ca.Answer6 = @Answer6 OR @Answer6 = 'Any')
AND ((ap.LastReviewed BETWEEN @StartDate and @EndDate) OR @FilterDate = 0)
AND (ap.SupervisorOutcome IS NOT NULL OR @VerifiedOnly = 0)
AND (ca.JobGroupID = @JobGroupID OR @JobGroupID <= 0)
ORDER BY a.ApplicationName, s.SectionName, t.TutorialName
END
GO
