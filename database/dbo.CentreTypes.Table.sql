USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreTypes](
	[CentreTypeID] [int] IDENTITY(1,1) NOT NULL,
	[CentreType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CentreTypes] PRIMARY KEY CLUSTERED 
(
	[CentreTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
