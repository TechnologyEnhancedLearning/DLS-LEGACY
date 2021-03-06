USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pwBulletins](
	[BulletinID] [int] IDENTITY(1,1) NOT NULL,
	[BulletinName] [nvarchar](100) NOT NULL,
	[BulletinDescription] [nvarchar](max) NULL,
	[BulletinFileName] [nvarchar](100) NOT NULL,
	[BulletinDate] [date] NOT NULL,
	[BulletinImage] [image] NULL,
 CONSTRAINT [PK_pwBulletins] PRIMARY KEY CLUSTERED 
(
	[BulletinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[pwBulletins] ADD  CONSTRAINT [DF_pwBulletins_BulletinDate]  DEFAULT (getutcdate()) FOR [BulletinDate]
GO
