USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelfAssessments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[UseFilteredApi] [bit] NOT NULL,
	[BrandID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[TopicID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedByCentreID] [int] NOT NULL,
	[CreatedByAdminID] [int] NOT NULL,
	[ArchivedDate] [datetime] NULL,
	[ArchivedByAdminID] [int] NULL,
 CONSTRAINT [PK_SelfAssessments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SelfAssessments] ADD  CONSTRAINT [DF_SelfAssessments_UseFilteredApi]  DEFAULT ((0)) FOR [UseFilteredApi]
GO
ALTER TABLE [dbo].[SelfAssessments] ADD  CONSTRAINT [DF_SelfAssessments_BrandID]  DEFAULT ((6)) FOR [BrandID]
GO
ALTER TABLE [dbo].[SelfAssessments] ADD  CONSTRAINT [DF_SelfAssessments_CategoryID]  DEFAULT ((1)) FOR [CategoryID]
GO
ALTER TABLE [dbo].[SelfAssessments] ADD  CONSTRAINT [DF_SelfAssessments_TopicID]  DEFAULT ((1)) FOR [TopicID]
GO
ALTER TABLE [dbo].[SelfAssessments] ADD  CONSTRAINT [DF_SelfAssessments_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SelfAssessments] ADD  CONSTRAINT [DF_SelfAssessments_CreatedByCentreID]  DEFAULT ((101)) FOR [CreatedByCentreID]
GO
ALTER TABLE [dbo].[SelfAssessments] ADD  CONSTRAINT [DF_SelfAssessments_CreatedByAdminID]  DEFAULT ((1)) FOR [CreatedByAdminID]
GO
ALTER TABLE [dbo].[SelfAssessments]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessments_BrandID_Brands_BrandID] FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([BrandID])
GO
ALTER TABLE [dbo].[SelfAssessments] CHECK CONSTRAINT [FK_SelfAssessments_BrandID_Brands_BrandID]
GO
ALTER TABLE [dbo].[SelfAssessments]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessments_CategoryID_CourseCategories_CourseCategoryID] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CourseCategories] ([CourseCategoryID])
GO
ALTER TABLE [dbo].[SelfAssessments] CHECK CONSTRAINT [FK_SelfAssessments_CategoryID_CourseCategories_CourseCategoryID]
GO
ALTER TABLE [dbo].[SelfAssessments]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessments_CreatedByAdminID_AdminUsers_AdminID] FOREIGN KEY([CreatedByAdminID])
REFERENCES [dbo].[AdminUsers] ([AdminID])
GO
ALTER TABLE [dbo].[SelfAssessments] CHECK CONSTRAINT [FK_SelfAssessments_CreatedByAdminID_AdminUsers_AdminID]
GO
ALTER TABLE [dbo].[SelfAssessments]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessments_CreatedByCentreID_Centres_CentreID] FOREIGN KEY([CreatedByCentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[SelfAssessments] CHECK CONSTRAINT [FK_SelfAssessments_CreatedByCentreID_Centres_CentreID]
GO
ALTER TABLE [dbo].[SelfAssessments]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessments_TopicID_CourseTopics_CourseTopicID] FOREIGN KEY([TopicID])
REFERENCES [dbo].[CourseTopics] ([CourseTopicID])
GO
ALTER TABLE [dbo].[SelfAssessments] CHECK CONSTRAINT [FK_SelfAssessments_TopicID_CourseTopics_CourseTopicID]
GO
