USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[BrandID] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [nvarchar](50) NOT NULL,
	[BrandDescription] [nvarchar](500) NULL,
	[BrandImage] [image] NULL,
	[ImageFileType] [nvarchar](50) NULL,
	[IncludeOnLanding] [bit] NOT NULL,
	[ContactEmail] [nvarchar](255) NULL,
	[OwnerOrganisationID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[OrderByNumber] [int] NOT NULL,
	[BrandLogo] [image] NULL,
	[PopularityHigh] [int] NOT NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[BrandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Brands] ADD  CONSTRAINT [DF_Brands_IncludeOnLanding]  DEFAULT ((0)) FOR [IncludeOnLanding]
GO
ALTER TABLE [dbo].[Brands] ADD  CONSTRAINT [DF_Brands_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Brands] ADD  CONSTRAINT [DF_Brands_OrderByNumber]  DEFAULT ((0)) FOR [OrderByNumber]
GO
ALTER TABLE [dbo].[Brands] ADD  CONSTRAINT [DF_Brands_PopularityHigh]  DEFAULT ((100)) FOR [PopularityHigh]
GO
