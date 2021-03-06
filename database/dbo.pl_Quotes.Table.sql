USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pl_Quotes](
	[QuoteID] [int] IDENTITY(1,1) NOT NULL,
	[QuoteText] [nvarchar](500) NOT NULL,
	[AttrIndividual] [nvarchar](100) NULL,
	[AttrOrganisation] [nvarchar](100) NULL,
	[QuoteDate] [datetime] NOT NULL,
	[ProductID] [int] NULL,
	[BrandID] [int] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_pl_Quotes] PRIMARY KEY CLUSTERED 
(
	[QuoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[pl_Quotes] ADD  CONSTRAINT [DF_pl_Quotes_QuoteDate]  DEFAULT (getutcdate()) FOR [QuoteDate]
GO
ALTER TABLE [dbo].[pl_Quotes] ADD  CONSTRAINT [DF_pl_Quotes_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[pl_Quotes]  WITH CHECK ADD  CONSTRAINT [FK_pl_Quotes_Brands] FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([BrandID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[pl_Quotes] CHECK CONSTRAINT [FK_pl_Quotes_Brands]
GO
ALTER TABLE [dbo].[pl_Quotes]  WITH CHECK ADD  CONSTRAINT [FK_pl_Quotes_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[pl_Products] ([ProductID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[pl_Quotes] CHECK CONSTRAINT [FK_pl_Quotes_Products]
GO
