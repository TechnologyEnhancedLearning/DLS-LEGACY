USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pwNews](
	[NewsID] [int] IDENTITY(1,1) NOT NULL,
	[NewsDate] [date] NOT NULL,
	[NewsTitle] [nvarchar](255) NULL,
	[NewsDetail] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
	[ProductID] [int] NULL,
	[BrandID] [int] NULL,
 CONSTRAINT [PK_pwNews] PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[pwNews] ADD  CONSTRAINT [DF_pwNews_NewsDate]  DEFAULT (getutcdate()) FOR [NewsDate]
GO
ALTER TABLE [dbo].[pwNews] ADD  CONSTRAINT [DF_pwNews_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[pwNews]  WITH CHECK ADD  CONSTRAINT [FK_pwNews_Brands] FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([BrandID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[pwNews] CHECK CONSTRAINT [FK_pwNews_Brands]
GO
ALTER TABLE [dbo].[pwNews]  WITH CHECK ADD  CONSTRAINT [FK_pwNews_pl_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[pl_Products] ([ProductID])
GO
ALTER TABLE [dbo].[pwNews] CHECK CONSTRAINT [FK_pwNews_pl_Products]
GO
