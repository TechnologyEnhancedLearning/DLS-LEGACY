USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KBCentreCategoryExcludes](
	[KBCentreCategoryExcludeID] [int] IDENTITY(1,1) NOT NULL,
	[CentreID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_KBCentreCategoryExcludes] PRIMARY KEY CLUSTERED 
(
	[KBCentreCategoryExcludeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KBCentreCategoryExcludes]  WITH CHECK ADD  CONSTRAINT [FK_KBCentreCategoryExcludes_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[KBCentreCategoryExcludes] CHECK CONSTRAINT [FK_KBCentreCategoryExcludes_Centres]
GO
ALTER TABLE [dbo].[KBCentreCategoryExcludes]  WITH CHECK ADD  CONSTRAINT [FK_KBCentreCategoryExcludes_CourseCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CourseCategories] ([CourseCategoryID])
GO
ALTER TABLE [dbo].[KBCentreCategoryExcludes] CHECK CONSTRAINT [FK_KBCentreCategoryExcludes_CourseCategories]
GO
