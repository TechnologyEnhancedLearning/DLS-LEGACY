USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Products_Active]  DEFAULT ((1)),
	[ProductName] [varchar](100) NOT NULL,
	[ProductDescription] [varchar](250) NULL,
	[InStock] [bit] NOT NULL CONSTRAINT [DF_Products_InStock]  DEFAULT ((1)),
	[QuantityLimit] [int] NOT NULL CONSTRAINT [DF_Products_QuantityLimit]  DEFAULT ((10)),
	[ExpectedDate] [datetime] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
