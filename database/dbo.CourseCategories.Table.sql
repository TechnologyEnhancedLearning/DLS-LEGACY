USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseCategories](
	[CourseCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CentreID] [int] NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[CategoryContactEmail] [nvarchar](255) NULL,
	[CategoryContactPhone] [nvarchar](20) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_CourseCategories] PRIMARY KEY CLUSTERED 
(
	[CourseCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CourseCategories] ADD  CONSTRAINT [DF_CourseCategories_CentreID]  DEFAULT ((0)) FOR [CentreID]
GO
ALTER TABLE [dbo].[CourseCategories] ADD  CONSTRAINT [DF_CourseCategories_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[CourseCategories]  WITH NOCHECK ADD  CONSTRAINT [FK_CourseCategories_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
ON UPDATE SET DEFAULT
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[CourseCategories] NOCHECK CONSTRAINT [FK_CourseCategories_Centres]
GO
