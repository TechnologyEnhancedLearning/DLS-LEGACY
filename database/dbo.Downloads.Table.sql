USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Downloads](
	[DownloadID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Downloads_Active]  DEFAULT ((1)),
	[UploadDTT] [datetime] NOT NULL CONSTRAINT [DF_Downloads_Date]  DEFAULT (getutcdate()),
	[Filename] [varchar](250) NOT NULL,
	[Tag] [varchar](250) NOT NULL,
	[CentreManagers] [bit] NOT NULL CONSTRAINT [DF_Downloads_CentreManagers]  DEFAULT ((1)),
	[Description] [varchar](1000) NULL,
	[ContentType] [varchar](50) NULL,
	[FileSize] [int] NOT NULL CONSTRAINT [DF_Downloads_FileSize]  DEFAULT ((0)),
	[DLCount] [int] NOT NULL CONSTRAINT [DF_Downloads_DLCount]  DEFAULT ((0)),
	[Category] [varchar](100) NOT NULL CONSTRAINT [DF_Downloads_Category]  DEFAULT ('Not specified'),
 CONSTRAINT [PK_Downloads] PRIMARY KEY CLUSTERED 
(
	[DownloadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
