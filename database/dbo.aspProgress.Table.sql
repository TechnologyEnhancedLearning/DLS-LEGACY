USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspProgress](
	[aspProgressID] [int] IDENTITY(1,1) NOT NULL,
	[TutorialID] [int] NOT NULL,
	[TutStat] [tinyint] NOT NULL CONSTRAINT [DF_aspProgress_TutStat]  DEFAULT ((0)),
	[TutTime] [int] NOT NULL CONSTRAINT [DF_aspProgress_TutTime]  DEFAULT ((0)),
	[ProgressID] [int] NOT NULL CONSTRAINT [DF_aspProgress_ProgressID]  DEFAULT ((0)),
	[DiagAttempts] [int] NOT NULL CONSTRAINT [DF_aspProgress_DiagAttempts]  DEFAULT ((0)),
	[DiagHigh] [int] NOT NULL CONSTRAINT [DF_aspProgress_DiagHigh]  DEFAULT ((0)),
	[DiagLast] [int] NOT NULL CONSTRAINT [DF_aspProgress_DiagLast]  DEFAULT ((0)),
	[DiagLow] [int] NOT NULL CONSTRAINT [DF_aspProgress_DiagLow]  DEFAULT ((0)),
 CONSTRAINT [PK_aspProgress] PRIMARY KEY CLUSTERED 
(
	[aspProgressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
