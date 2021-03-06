USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationName] [varchar](250) NOT NULL,
	[ApplicationInfo] [nvarchar](4000) NULL,
	[MoviePath] [varchar](250) NOT NULL,
	[hEmbedRes] [int] NOT NULL,
	[vEmbedRes] [int] NOT NULL,
	[ASPMenu] [bit] NOT NULL,
	[AppGroupID] [int] NOT NULL,
	[DiagAssess] [bit] NOT NULL,
	[PLAssess] [bit] NOT NULL,
	[Debug] [bit] NOT NULL,
	[ShortAppName] [varchar](100) NULL,
	[LaunchedAssess] [bit] NOT NULL,
	[OfficeAppID] [int] NOT NULL,
	[OfficeVersionID] [int] NOT NULL,
	[CreatedByID] [int] NOT NULL,
	[CreatedByCentreID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ArchivedDate] [datetime] NULL,
	[ArchivedBy] [int] NULL,
	[AssessAttempts] [int] NOT NULL,
	[PLAPassThreshold] [int] NOT NULL,
	[CoreContent] [bit] NOT NULL,
	[BrandID] [int] NOT NULL,
	[CourseCategoryID] [int] NOT NULL,
	[CourseTopicID] [int] NOT NULL,
	[CourseImage] [image] NULL,
	[IncludeLearningLog] [bit] NOT NULL,
	[CustomContent] [bit] NOT NULL,
	[ServerSpace] [bigint] NOT NULL,
	[IncludeCertification] [bit] NOT NULL,
	[DefaultContentTypeID] [int] NOT NULL,
	[DisplayFormatID] [int] NOT NULL,
	[ShowSummaryPanel] [bit] NOT NULL,
	[CMSReportDetail] [bit] NOT NULL,
	[CourseSettings] [nvarchar](max) NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF__Applicati__Movie__4C6B5938]  DEFAULT ('') FOR [MoviePath]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_hEmbedRes]  DEFAULT ((800)) FOR [hEmbedRes]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_vEmbedRes]  DEFAULT ((600)) FOR [vEmbedRes]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_ASPMenu]  DEFAULT ((0)) FOR [ASPMenu]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_AppGroupID]  DEFAULT ((5)) FOR [AppGroupID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_DiagAssess]  DEFAULT ((0)) FOR [DiagAssess]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_PLAssess]  DEFAULT ((0)) FOR [PLAssess]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_Debug]  DEFAULT ((0)) FOR [Debug]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF__Applicati__Launc__69C6B1F5]  DEFAULT ((1)) FOR [LaunchedAssess]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF__Applicati__Offic__6ABAD62E]  DEFAULT ((8)) FOR [OfficeAppID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF__Applicati__Offic__6BAEFA67]  DEFAULT ((5)) FOR [OfficeVersionID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_CreatedByID]  DEFAULT ((1)) FOR [CreatedByID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_CreatedByCentreID]  DEFAULT ((101)) FOR [CreatedByCentreID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_AssessAttempts]  DEFAULT ((0)) FOR [AssessAttempts]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_PLAPassThreshold]  DEFAULT ((85)) FOR [PLAPassThreshold]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_CoreContent]  DEFAULT ((0)) FOR [CoreContent]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_BrandID]  DEFAULT ((6)) FOR [BrandID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_CourseCategoryID]  DEFAULT ((1)) FOR [CourseCategoryID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_CourseTopicID]  DEFAULT ((1)) FOR [CourseTopicID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF__Applicati__Inclu__7A8B2256]  DEFAULT ((0)) FOR [IncludeLearningLog]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_CustomContent]  DEFAULT ((0)) FOR [CustomContent]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_ServerSpace]  DEFAULT ((0)) FOR [ServerSpace]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_IncludeCertification]  DEFAULT ((0)) FOR [IncludeCertification]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_DefaultContentTypeID]  DEFAULT ((1)) FOR [DefaultContentTypeID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_DisplayFormatID]  DEFAULT ((1)) FOR [DisplayFormatID]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_HideSummaryPanel]  DEFAULT ((1)) FOR [ShowSummaryPanel]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_CMSReportDetail]  DEFAULT ((0)) FOR [CMSReportDetail]
GO
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_ApplicationGroups] FOREIGN KEY([AppGroupID])
REFERENCES [dbo].[ApplicationGroups] ([AppGroupID])
GO
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_ApplicationGroups]
GO
ALTER TABLE [dbo].[Applications]  WITH NOCHECK ADD  CONSTRAINT [FK_Applications_Brands] FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([BrandID])
GO
ALTER TABLE [dbo].[Applications] NOCHECK CONSTRAINT [FK_Applications_Brands]
GO
ALTER TABLE [dbo].[Applications]  WITH NOCHECK ADD  CONSTRAINT [FK_Applications_CourseCategories] FOREIGN KEY([CourseCategoryID])
REFERENCES [dbo].[CourseCategories] ([CourseCategoryID])
GO
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_CourseCategories]
GO
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_CourseTopics] FOREIGN KEY([CourseTopicID])
REFERENCES [dbo].[CourseTopics] ([CourseTopicID])
GO
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_CourseTopics]
GO
