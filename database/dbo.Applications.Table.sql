USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationName] [varchar](250) NOT NULL,
	[ApplicationInfo] [nvarchar](4000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[Applications] ADD [MoviePath] [varchar](250) NOT NULL DEFAULT ('')
ALTER TABLE [dbo].[Applications] ADD [hEmbedRes] [int] NOT NULL CONSTRAINT [DF_Applications_hEmbedRes]  DEFAULT ((800))
ALTER TABLE [dbo].[Applications] ADD [vEmbedRes] [int] NOT NULL CONSTRAINT [DF_Applications_vEmbedRes]  DEFAULT ((600))
ALTER TABLE [dbo].[Applications] ADD [ASPMenu] [bit] NOT NULL CONSTRAINT [DF_Applications_ASPMenu]  DEFAULT ((0))
ALTER TABLE [dbo].[Applications] ADD [AppGroupID] [int] NULL
ALTER TABLE [dbo].[Applications] ADD [DiagAssess] [bit] NOT NULL CONSTRAINT [DF_Applications_DiagAssess]  DEFAULT ((0))
ALTER TABLE [dbo].[Applications] ADD [PLAssess] [bit] NOT NULL CONSTRAINT [DF_Applications_PLAssess]  DEFAULT ((0))
ALTER TABLE [dbo].[Applications] ADD [Debug] [bit] NOT NULL CONSTRAINT [DF_Applications_Debug]  DEFAULT ((0))
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Applications] ADD [ShortAppName] [varchar](100) NULL
ALTER TABLE [dbo].[Applications] ADD [LaunchedAssess] [bit] NOT NULL CONSTRAINT [DF__Applicati__Launc__69C6B1F5]  DEFAULT ((1))
ALTER TABLE [dbo].[Applications] ADD [OfficeAppID] [int] NOT NULL DEFAULT ((1))
ALTER TABLE [dbo].[Applications] ADD [OfficeVersionID] [int] NOT NULL DEFAULT ((1))
ALTER TABLE [dbo].[Applications] ADD [CreatedByID] [int] NOT NULL CONSTRAINT [DF_Applications_CreatedByID]  DEFAULT ((1))
ALTER TABLE [dbo].[Applications] ADD [CreatedByCentreID] [int] NOT NULL CONSTRAINT [DF_Applications_CreatedByCentreID]  DEFAULT ((101))
ALTER TABLE [dbo].[Applications] ADD [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Applications_CreatedDate]  DEFAULT (getdate())
ALTER TABLE [dbo].[Applications] ADD [ArchivedDate] [datetime] NULL
ALTER TABLE [dbo].[Applications] ADD [ArchivedBy] [int] NULL
ALTER TABLE [dbo].[Applications] ADD [AssessAttempts] [int] NOT NULL CONSTRAINT [DF_Applications_AssessAttempts]  DEFAULT ((0))
ALTER TABLE [dbo].[Applications] ADD [PLAPassThreshold] [int] NOT NULL CONSTRAINT [DF_Applications_PLAPassThreshold]  DEFAULT ((85))
ALTER TABLE [dbo].[Applications] ADD [CoreContent] [bit] NOT NULL CONSTRAINT [DF_Applications_CoreContent]  DEFAULT ((0))
ALTER TABLE [dbo].[Applications] ADD [BrandID] [int] NOT NULL CONSTRAINT [DF_Applications_BrandID]  DEFAULT ((6))
ALTER TABLE [dbo].[Applications] ADD [CourseCategoryID] [int] NOT NULL CONSTRAINT [DF_Applications_CourseCategoryID]  DEFAULT ((1))
ALTER TABLE [dbo].[Applications] ADD [CourseTopicID] [int] NOT NULL CONSTRAINT [DF_Applications_CourseTopicID]  DEFAULT ((1))
ALTER TABLE [dbo].[Applications] ADD [CourseImage] [image] NULL
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
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
ALTER TABLE [dbo].[Applications] NOCHECK CONSTRAINT [FK_Applications_CourseCategories]
GO
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_CourseTopics] FOREIGN KEY([CourseTopicID])
REFERENCES [dbo].[CourseTopics] ([CourseTopicID])
GO
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_CourseTopics]
GO
