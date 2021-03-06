USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KBCentreBrandsExcludes](
	[KBCentreBrandExcludeID] [int] IDENTITY(1,1) NOT NULL,
	[CentreID] [int] NOT NULL,
	[BrandID] [int] NOT NULL,
 CONSTRAINT [PK_KBCentreBrandsExcludes] PRIMARY KEY CLUSTERED 
(
	[KBCentreBrandExcludeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KBCentreBrandsExcludes]  WITH CHECK ADD  CONSTRAINT [FK_KBCentreBrandsExcludes_Brands] FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([BrandID])
GO
ALTER TABLE [dbo].[KBCentreBrandsExcludes] CHECK CONSTRAINT [FK_KBCentreBrandsExcludes_Brands]
GO
ALTER TABLE [dbo].[KBCentreBrandsExcludes]  WITH CHECK ADD  CONSTRAINT [FK_KBCentreBrandsExcludes_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[KBCentreBrandsExcludes] CHECK CONSTRAINT [FK_KBCentreBrandsExcludes_Centres]
GO
