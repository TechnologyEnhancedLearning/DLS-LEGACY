USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 11/12/2014
-- Description:	Populates the activity log for the previous 24 hours
-- =============================================
CREATE PROCEDURE [dbo].[PopulateActivityLog]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   DECLARE @StartDate datetime
DECLARE @EndDate datetime

Set @StartDate = DateAdd(day, -1, GETUTCDATE())
Set @StartDate = cast(cast(@StartDate as DATE) as datetime)

Set @EndDate = GETUTCDATE()
Set @EndDate =  cast(cast(@EndDate as DATE) as datetime)
-- Insert the registrations:
INSERT INTO tActivityLog
                      (LogDate, LogYear, LogMonth, LogQuarter, CentreID, CentreTypeID, RegionID, CandidateID, JobGroupID, CustomisationID, ApplicationID, AppGroupID, OfficeAppID, OfficeVersionID, 
                      IsAssessed, Registered, CoreContent, BrandID, CourseCategoryID, CourseTopicID)
SELECT     p.FirstSubmittedTime AS LogDate, DATEPART(Year, p.FirstSubmittedTime) AS LogYear, DATEPART(Month, p.FirstSubmittedTime) AS LogMonth, 
                      DATEPART(Quarter, p.FirstSubmittedTime) AS LogQuarter, c.CentreID, ce.CentreTypeID, ce.RegionID, p.CandidateID, ca.JobGroupID, p.CustomisationID, c.ApplicationID, a.AppGroupID, 
                      a.OfficeAppID, a.OfficeVersionID, c.IsAssessed, 1 AS Registered, a.CoreContent, a.BrandID, a.CourseCategoryID, a.CourseTopicID
FROM         Progress AS p INNER JOIN
                      Customisations AS c ON p.CustomisationID = c.CustomisationID INNER JOIN
                      Applications AS a ON c.ApplicationID = a.ApplicationID INNER JOIN
                      Centres AS ce ON c.CentreID = ce.CentreID INNER JOIN
                         Candidates AS ca ON p.CandidateID = ca.CandidateID
WHERE     (p.FirstSubmittedTime >= @StartDate) AND (p.FirstSubmittedTime < @EndDate)
-- Insert the completions:
INSERT INTO tActivityLog
                      (LogDate, LogYear, LogMonth, LogQuarter, CentreID, CentreTypeID, RegionID, CandidateID, JobGroupID, CustomisationID, ApplicationID, AppGroupID, OfficeAppID, OfficeVersionID, 
                      IsAssessed, Completed, CoreContent, BrandID, CourseCategoryID, CourseTopicID)
SELECT     p.Completed AS LogDate, DATEPART(Year, p.Completed) AS LogYear, DATEPART(Month, p.Completed) AS LogMonth, 
                      DATEPART(Quarter, p.Completed) AS LogQuarter, c.CentreID, ce.CentreTypeID, ce.RegionID, p.CandidateID, ca.JobGroupID, p.CustomisationID, c.ApplicationID, a.AppGroupID, 
                      a.OfficeAppID, a.OfficeVersionID, c.IsAssessed, 1 AS Completed, a.CoreContent, a.BrandID, a.CourseCategoryID, a.CourseTopicID
FROM         Progress AS p INNER JOIN
                      Customisations AS c ON p.CustomisationID = c.CustomisationID INNER JOIN
                      Applications AS a ON c.ApplicationID = a.ApplicationID INNER JOIN
                      Centres AS ce ON c.CentreID = ce.CentreID INNER JOIN
                         Candidates AS ca ON p.CandidateID = ca.CandidateID
WHERE     (p.Completed >= @StartDate) AND (p.Completed < @EndDate)
--Insert the evaluations:
INSERT INTO tActivityLog
                      (LogDate, LogYear, LogMonth, LogQuarter, CentreID, CentreTypeID, RegionID, CandidateID, JobGroupID, CustomisationID, ApplicationID, AppGroupID, OfficeAppID, OfficeVersionID, 
                      IsAssessed, Evaluated, CoreContent, BrandID, CourseCategoryID, CourseTopicID)
SELECT     p.Evaluated AS LogDate, DATEPART(Year, p.Evaluated) AS LogYear, DATEPART(Month, p.Evaluated) AS LogMonth, 
                      DATEPART(Quarter, p.Evaluated) AS LogQuarter, c.CentreID, ce.CentreTypeID, ce.RegionID, p.CandidateID, ca.JobGroupID, p.CustomisationID, c.ApplicationID, a.AppGroupID, 
                      a.OfficeAppID, a.OfficeVersionID, c.IsAssessed, 1 AS Evaluated, a.CoreContent, a.BrandID, a.CourseCategoryID, a.CourseTopicID
FROM         Progress AS p INNER JOIN
                      Customisations AS c ON p.CustomisationID = c.CustomisationID INNER JOIN
                      Applications AS a ON c.ApplicationID = a.ApplicationID INNER JOIN
                      Centres AS ce ON c.CentreID = ce.CentreID INNER JOIN
                         Candidates AS ca ON p.CandidateID = ca.CandidateID
WHERE     (p.Evaluated >= @StartDate) AND (p.Evaluated < @EndDate)
--Insert the Knowledge Bank Tutorial Launches:
INSERT INTO tActivityLog
                      (LogDate, LogYear, LogMonth, LogQuarter, CentreID, CentreTypeID, RegionID, CandidateID, JobGroupID, ApplicationID, AppGroupID, OfficeAppID, kbTutorialViewed, CoreContent, BrandID, CourseCategoryID, CourseTopicID)
SELECT     lt.LaunchDate AS LogDate, DATEPART(Year, lt.LaunchDate) AS LogYear, DATEPART(Month, lt.LaunchDate) AS LogMonth, DATEPART(Quarter, 
                      lt.LaunchDate) AS LogQuarter, c.CentreID, ce.CentreTypeID, ce.RegionID, lt.CandidateID, c.JobGroupID, s.ApplicationID, a.AppGroupID, a.OfficeAppID, 
                      1 AS kbTutorialViewed, a.CoreContent, a.BrandID, a.CourseCategoryID, a.CourseTopicID
FROM         Tutorials AS t INNER JOIN
                      Sections AS s ON t.SectionID = s.SectionID INNER JOIN
                      Candidates AS c INNER JOIN
                      Centres AS ce ON c.CentreID = ce.CentreID INNER JOIN
                      kbLearnTrack AS lt ON c.CandidateID = lt.CandidateID ON t.TutorialID = lt.TutorialID INNER JOIN
                      Applications AS a ON s.ApplicationID = a.ApplicationID
WHERE     (lt.LaunchDate >= @StartDate AND lt.LaunchDate < @EndDate)
--Insert the Knowledge Bank Video Views:
INSERT INTO tActivityLog
                         (LogDate, LogYear, LogMonth, LogQuarter, CentreID, CentreTypeID, RegionID, CandidateID, JobGroupID, ApplicationID, AppGroupID, OfficeAppID, kbVideoViewed, CoreContent, BrandID, CourseCategoryID, CourseTopicID)
SELECT     vt.VideoClickedDate AS LogDate, DATEPART(Year, vt.VideoClickedDate) AS LogYear, DATEPART(Month, vt.VideoClickedDate) AS LogMonth, 
                      DATEPART(Quarter, vt.VideoClickedDate) AS LogQuarter, c.CentreID, ce.CentreTypeID, ce.RegionID, vt.CandidateID, c.JobGroupID, s.ApplicationID, a.AppGroupID, 
                      a.OfficeAppID, 1 AS kbVideoViewed, a.CoreContent, a.BrandID, a.CourseCategoryID, a.CourseTopicID
FROM         Tutorials AS t INNER JOIN
                      Sections AS s ON t.SectionID = s.SectionID INNER JOIN
                      Candidates AS c INNER JOIN
                      Centres AS ce ON c.CentreID = ce.CentreID INNER JOIN
                      kbVideoTrack AS vt ON c.CandidateID = vt.CandidateID ON t.TutorialID = vt.TutorialID INNER JOIN
                      Applications AS a ON s.ApplicationID = a.ApplicationID
WHERE     (vt.VideoClickedDate >= @StartDate) AND (vt.VideoClickedDate < @EndDate)
--Insert the Knowledge Bank Searches:
INSERT INTO tActivityLog
                      (LogDate, LogYear, LogMonth, LogQuarter, CentreID, CentreTypeID, RegionID, CandidateID, JobGroupID, kbSearched)
SELECT     vt.SearchDate AS LogDate, DATEPART(Year, vt.SearchDate) AS LogYear, DATEPART(Month, vt.SearchDate) AS LogMonth, DATEPART(Quarter, 
                      vt.SearchDate) AS LogQuarter, c.CentreID, Centres.CentreTypeID, Centres.RegionID, vt.CandidateID, c.JobGroupID, 1 AS kbSearched
FROM         kbSearches AS vt INNER JOIN
                      Candidates c ON vt.CandidateID = c.CandidateID INNER JOIN
                      Centres ON c.CentreID = Centres.CentreID
WHERE     (vt.SearchDate >= @StartDate) AND (vt.SearchDate < @EndDate)
--Insert the Knowledge Bank YouTube Launches:
INSERT INTO tActivityLog
                      (LogDate, LogYear, LogMonth, LogQuarter, CentreID, CentreTypeID, RegionID, CandidateID, JobGroupID, kbYouTubeLaunched)
SELECT     vt.LaunchDateTime AS LogDate, DATEPART(Year, vt.LaunchDateTime) AS LogYear, DATEPART(Month, vt.LaunchDateTime) AS LogMonth, 
                      DATEPART(Quarter, vt.LaunchDateTime) AS LogQuarter, c.CentreID, ct.CentreTypeID, ct.RegionID, vt.CandidateID, c.JobGroupID, 
                      1 AS kbYouTube
FROM         kbYouTubeTrack AS vt INNER JOIN
                      Candidates c ON vt.CandidateID = c.CandidateID INNER JOIN
                      Centres ct ON c.CentreID = ct.CentreID
WHERE     (vt.LaunchDateTime >= @StartDate) AND (vt.LaunchDateTime < @EndDate)
END
GO
