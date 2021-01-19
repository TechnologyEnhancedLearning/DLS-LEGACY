USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Config](
	[ConfigID] [int] IDENTITY(1,1) NOT NULL,
	[ConfigName] [varchar](50) NOT NULL,
	[ConfigText] [varchar](max) NOT NULL,
	[IsHtml] [bit] NOT NULL CONSTRAINT [DF_Config_IsHtml]  DEFAULT ((0)),
 CONSTRAINT [PK_Config] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
