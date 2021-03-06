USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pl_Features](
	[FeatureID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[FeatureHeading] [nvarchar](100) NOT NULL,
	[FeatureDescription] [nvarchar](max) NULL,
	[FeatureIconClass] [nvarchar](50) NULL,
	[FeatureColourClass] [nvarchar](50) NULL,
	[FeatureScreenshot] [image] NULL,
	[FeatureVideoURL] [nvarchar](255) NULL,
	[Active] [bit] NOT NULL,
	[OrderByNumber] [int] NOT NULL,
 CONSTRAINT [PK_pl_Features] PRIMARY KEY CLUSTERED 
(
	[FeatureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[pl_Features] ADD  CONSTRAINT [DF_pl_Features_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[pl_Features] ADD  CONSTRAINT [DF_pl_Features_OrderByNumber]  DEFAULT ((0)) FOR [OrderByNumber]
GO
ALTER TABLE [dbo].[pl_Features]  WITH CHECK ADD  CONSTRAINT [FK_pl_Features_pl_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[pl_Products] ([ProductID])
GO
ALTER TABLE [dbo].[pl_Features] CHECK CONSTRAINT [FK_pl_Features_pl_Products]
GO
