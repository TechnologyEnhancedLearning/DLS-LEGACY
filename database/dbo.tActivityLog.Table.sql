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
	[CustomisationID] [int] NULL,
	[ApplicationID] [int] NULL,
	[AppGroupID] [int] NULL,
	[OfficeAppID] [int] NULL,
	[OfficeVersionID] [int] NULL,
	[IsAssessed] [bit] NULL,
	[Registered] [bit] NOT NULL,
	[Completed] [bit] NOT NULL,
	[Evaluated] [bit] NOT NULL,
	[kbTutorialViewed] [bit] NOT NULL,
	[kbVideoViewed] [bit] NOT NULL,
	[kbSearched] [bit] NOT NULL,
	[kbYouTubeLaunched] [bit] NOT NULL,
	[CoreContent] [bit] NOT NULL,
	[BrandID] [int] NOT NULL,
	[CourseCategoryID] [int] NOT NULL,
	[CourseTopicID] [int] NOT NULL,
 CONSTRAINT [PK_tActivityLog] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_CustomisationID]  DEFAULT ((-1)) FOR [CustomisationID]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_Registered]  DEFAULT ((0)) FOR [Registered]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_Completed]  DEFAULT ((0)) FOR [Completed]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_Evaluated]  DEFAULT ((0)) FOR [Evaluated]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_kbTutorialViewed]  DEFAULT ((0)) FOR [kbTutorialViewed]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_kbVideoViewed]  DEFAULT ((0)) FOR [kbVideoViewed]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_kbSearched]  DEFAULT ((0)) FOR [kbSearched]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_kbYouTubeLaunched]  DEFAULT ((0)) FOR [kbYouTubeLaunched]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_CoreContent]  DEFAULT ((0)) FOR [CoreContent]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_BrandID]  DEFAULT ((0)) FOR [BrandID]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_CourseCategoryID]  DEFAULT ((0)) FOR [CourseCategoryID]
GO
ALTER TABLE [dbo].[tActivityLog] ADD  CONSTRAINT [DF_tActivityLog_CourseTopicID]  DEFAULT ((0)) FOR [CourseTopicID]
GO
