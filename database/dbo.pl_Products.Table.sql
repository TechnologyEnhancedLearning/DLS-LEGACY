USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pl_Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductHeading] [nvarchar](100) NULL,
	[ProductTagline] [nvarchar](255) NULL,
	[ProductScreenshot] [image] NULL,
	[ProductDemoVidURL] [nvarchar](255) NULL,
	[OrderByNumber] [int] NOT NULL CONSTRAINT [DF_pl_Products_OrderByNumber]  DEFAULT ((0)),
	[Active] [bit] NOT NULL CONSTRAINT [DF_pl_Products_Active]  DEFAULT ((1)),
	[ProductIconClass] [nvarchar](50) NULL,
 CONSTRAINT [PK_pl_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
