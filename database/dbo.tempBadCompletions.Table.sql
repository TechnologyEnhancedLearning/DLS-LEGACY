USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempBadCompletions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ProgressID] [int] NOT NULL,
	[Processed] [bit] NOT NULL,
 CONSTRAINT [PK_tempBadCompletions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tempBadCompletions] ADD  CONSTRAINT [DF_tempBadCompletions_Processed]  DEFAULT ((0)) FOR [Processed]
GO
