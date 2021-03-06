USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pl_CaseStudies](
	[CaseStudyID] [int] IDENTITY(1,1) NOT NULL,
	[CaseHeading] [nvarchar](100) NULL,
	[CaseSubHeading] [nvarchar](500) NULL,
	[CaseDate] [datetime] NULL,
	[ProductID] [int] NULL,
	[BrandID] [int] NULL,
	[Active] [bit] NOT NULL,
	[CaseImage] [image] NULL,
	[CaseStudyGroup] [nvarchar](100) NULL,
 CONSTRAINT [PK_pl_CaseStudies] PRIMARY KEY CLUSTERED 
(
	[CaseStudyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[pl_CaseStudies] ADD  CONSTRAINT [DF_pl_CaseStudies_CaseDate]  DEFAULT (getutcdate()) FOR [CaseDate]
GO
ALTER TABLE [dbo].[pl_CaseStudies] ADD  CONSTRAINT [DF_pl_CaseStudies_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[pl_CaseStudies]  WITH CHECK ADD  CONSTRAINT [FK_pl_CaseStudies_Brands] FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([BrandID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[pl_CaseStudies] CHECK CONSTRAINT [FK_pl_CaseStudies_Brands]
GO
ALTER TABLE [dbo].[pl_CaseStudies]  WITH CHECK ADD  CONSTRAINT [FK_pl_CaseStudies_pl_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[pl_Products] ([ProductID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[pl_CaseStudies] CHECK CONSTRAINT [FK_pl_CaseStudies_pl_Products]
GO
