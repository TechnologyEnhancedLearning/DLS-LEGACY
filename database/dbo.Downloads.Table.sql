USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Downloads](
	[DownloadID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL,
	[UploadDTT] [datetime] NOT NULL,
	[Filename] [varchar](250) NOT NULL,
	[Tag] [varchar](250) NOT NULL,
	[CentreManagers] [bit] NOT NULL,
	[Description] [varchar](1000) NULL,
	[ContentType] [varchar](50) NULL,
	[FileSize] [int] NOT NULL,
	[DLCount] [int] NOT NULL,
	[Category] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Downloads] PRIMARY KEY CLUSTERED 
(
	[DownloadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Downloads] ADD  CONSTRAINT [DF_Downloads_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Downloads] ADD  CONSTRAINT [DF_Downloads_Date]  DEFAULT (getutcdate()) FOR [UploadDTT]
GO
ALTER TABLE [dbo].[Downloads] ADD  CONSTRAINT [DF_Downloads_CentreManagers]  DEFAULT ((1)) FOR [CentreManagers]
GO
ALTER TABLE [dbo].[Downloads] ADD  CONSTRAINT [DF_Downloads_FileSize]  DEFAULT ((0)) FOR [FileSize]
GO
ALTER TABLE [dbo].[Downloads] ADD  CONSTRAINT [DF_Downloads_DLCount]  DEFAULT ((0)) FOR [DLCount]
GO
ALTER TABLE [dbo].[Downloads] ADD  CONSTRAINT [DF_Downloads_Category]  DEFAULT ('Not specified') FOR [Category]
GO
