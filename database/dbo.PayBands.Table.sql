USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayBands](
	[BandID] [int] IDENTITY(0,1) NOT NULL,
	[Band] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PayBands] PRIMARY KEY CLUSTERED 
(
	[BandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
