USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailOut](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[EmailTo] [nvarchar](255) NOT NULL,
	[EmailFrom] [nvarchar](255) NOT NULL,
	[Subject] [nvarchar](255) NOT NULL,
	[BodyHTML] [nvarchar](max) NOT NULL,
	[AddedByProcess] [nvarchar](255) NULL,
	[Added] [datetime] NOT NULL,
	[Sent] [datetime] NULL,
 CONSTRAINT [PK_EmailOut] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[EmailOut] ADD  CONSTRAINT [DF_EmailOut_Added]  DEFAULT (getutcdate()) FOR [Added]
GO
