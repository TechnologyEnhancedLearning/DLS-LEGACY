USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tActivityLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[LogDate] [datetime] NOT NULL,
	[LogYear] [int] NOT NULL,
	[LogMonth] [int] NOT NULL,
	[LogQuarter] [int] NOT NULL,
	[CentreID] [int] NOT NULL,
	[CentreTypeID] [int] NOT NULL,
	[RegionID] [int] NOT NULL,
	[CandidateID] [int] NOT NULL,
	[JobGroupID] [int] NOT NULL,
	[CustomisationID] [int] NULL CONSTRAINT [DF_tActivityLog_CustomisationID]  DEFAULT ((-1)),
	[ApplicationID] [int] NULL,
	[AppGroupID] [int] NULL,
	[OfficeAppID] [int] NULL,
	[OfficeVersionID] [int] NULL,
	[IsAssessed] [bit] NULL,
	[Registered] [bit] NOT NULL CONSTRAINT [DF_tActivityLog_Registered]  DEFAULT ((0)),
	[Completed] [bit] NOT NULL CONSTRAINT [DF_tActivityLog_Completed]  DEFAULT ((0)),
	[Evaluated] [bit] NOT NULL CONSTRAINT [DF_tActivityLog_Evaluated]  DEFAULT ((0)),
	[kbTutorialViewed] [bit] NOT NULL CONSTRAINT [DF_tActivityLog_kbTutorialViewed]  DEFAULT ((0)),
	[kbVideoViewed] [bit] NOT NULL CONSTRAINT [DF_tActivityLog_kbVideoViewed]  DEFAULT ((0)),
	[kbSearched] [bit] NOT NULL CONSTRAINT [DF_tActivityLog_kbSearched]  DEFAULT ((0)),
	[kbYouTubeLaunched] [bit] NOT NULL CONSTRAINT [DF_tActivityLog_kbYouTubeLaunched]  DEFAULT ((0)),
	[CoreContent] [bit] NOT NULL CONSTRAINT [DF_tActivityLog_CoreContent]  DEFAULT ((0)),
	[BrandID] [int] NOT NULL CONSTRAINT [DF_tActivityLog_BrandID]  DEFAULT ((0)),
	[CourseCategoryID] [int] NOT NULL CONSTRAINT [DF_tActivityLog_CourseCategoryID]  DEFAULT ((0)),
	[CourseTopicID] [int] NOT NULL CONSTRAINT [DF_tActivityLog_CourseTopicID]  DEFAULT ((0)),
 CONSTRAINT [PK_tActivityLog] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
