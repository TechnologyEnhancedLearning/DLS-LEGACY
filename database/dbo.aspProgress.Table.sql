USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspProgress](
	[aspProgressID] [int] IDENTITY(1,1) NOT NULL,
	[TutorialID] [int] NOT NULL,
	[TutStat] [tinyint] NOT NULL,
	[TutTime] [int] NOT NULL,
	[ProgressID] [int] NOT NULL,
	[DiagAttempts] [int] NOT NULL,
	[DiagHigh] [int] NOT NULL,
	[DiagLast] [int] NOT NULL,
	[DiagLow] [int] NOT NULL,
	[CompletedDate] [datetime] NULL,
	[DurationMins] [int] NOT NULL,
	[MethodID] [int] NOT NULL,
	[MethodOther] [nvarchar](255) NULL,
	[OutcomesEvidence] [nvarchar](max) NULL,
	[SupervisorVerifiedID] [int] NULL,
	[SupervisorVerifiedDate] [datetime] NULL,
	[SupervisorOutcome] [bit] NULL,
	[SupervisorVerifiedComments] [nvarchar](max) NULL,
	[StartedDate] [datetime] NULL,
	[VideoLaunched] [bit] NOT NULL,
	[VideoWatchedPercentage] [int] NOT NULL,
	[MaterialsOpened] [datetime] NULL,
	[LastReviewed] [datetime] NULL,
	[AssessDescriptorID] [int] NOT NULL,
	[SupervisorVerificationRequested] [datetime] NULL,
	[ReviewedByCandidateID] [int] NOT NULL,
 CONSTRAINT [PK_aspProgress] PRIMARY KEY CLUSTERED 
(
	[aspProgressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF_aspProgress_TutStat]  DEFAULT ((0)) FOR [TutStat]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF_aspProgress_TutTime]  DEFAULT ((0)) FOR [TutTime]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF_aspProgress_ProgressID]  DEFAULT ((0)) FOR [ProgressID]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF_aspProgress_DiagAttempts]  DEFAULT ((0)) FOR [DiagAttempts]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF_aspProgress_DiagHigh]  DEFAULT ((0)) FOR [DiagHigh]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF_aspProgress_DiagLast]  DEFAULT ((0)) FOR [DiagLast]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF_aspProgress_DiagLow]  DEFAULT ((0)) FOR [DiagLow]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF__aspProgre__Durat__4B661F19]  DEFAULT ((0)) FOR [DurationMins]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF__aspProgre__Metho__4C5A4352]  DEFAULT ((0)) FOR [MethodID]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF__aspProgre__Video__4D4E678B]  DEFAULT ((0)) FOR [VideoLaunched]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF__aspProgre__Video__4E428BC4]  DEFAULT ((0)) FOR [VideoWatchedPercentage]
GO
ALTER TABLE [dbo].[aspProgress] ADD  CONSTRAINT [DF_aspProgress_AssessDescriptorID]  DEFAULT ((0)) FOR [AssessDescriptorID]
GO
ALTER TABLE [dbo].[aspProgress] ADD  DEFAULT ((0)) FOR [ReviewedByCandidateID]
GO
ALTER TABLE [dbo].[aspProgress]  WITH CHECK ADD  CONSTRAINT [FK_aspProgress_Progress] FOREIGN KEY([ProgressID])
REFERENCES [dbo].[Progress] ([ProgressID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[aspProgress] CHECK CONSTRAINT [FK_aspProgress_Progress]
GO
