USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Progress](
	[ProgressID] [int] IDENTITY(1,1) NOT NULL,
	[CandidateID] [int] NOT NULL,
	[CustomisationID] [int] NOT NULL,
	[CustomisationVersion] [int] NOT NULL,
	[SubmittedTime] [datetime] NOT NULL,
	[Completed] [datetime] NULL,
	[ProgressText] [varchar](max) NULL,
	[Answer1] [varchar](100) NULL,
	[Answer2] [varchar](100) NULL,
	[Answer3] [varchar](100) NULL,
	[Evaluated] [datetime] NULL,
	[ModifierID] [int] NOT NULL CONSTRAINT [DF_Progress_ModifierID]  DEFAULT ((0)),
	[FirstSubmittedTime] [datetime] NOT NULL CONSTRAINT [DF_Progress_FirstSubmittedTime]  DEFAULT (getutcdate()),
	[DiagnosticScore] [int] NULL,
	[FollowUpEvalID] [uniqueidentifier] NULL,
	[FollupUpEvaluated] [datetime] NULL,
	[IncompleteEvalID] [uniqueidentifier] NULL,
	[IncompleteEvaluated] [datetime] NULL,
	[NonCompletedFeedbackGUID] [uniqueidentifier] NULL,
	[PLLocked] [bit] NOT NULL CONSTRAINT [DF_Progress_PLLocked]  DEFAULT ((0)),
	[CompleteByDate] [datetime] NULL,
	[EnrollmentMethodID] [int] NOT NULL CONSTRAINT [DF__Progress__Enroll__3F0807D0]  DEFAULT ((1)),
	[EnrolledByAdminID] [int] NULL,
	[OneMonthReminderSent] [bit] NOT NULL CONSTRAINT [DF__Progress__OneMon__3FFC2C09]  DEFAULT ((0)),
	[ExpiredReminderSent] [int] NOT NULL CONSTRAINT [DF__Progress__Expire__40F05042]  DEFAULT ((0)),
	[RemovedDate] [datetime] NULL,
	[RemovalMethodID] [int] NOT NULL CONSTRAINT [DF_Progress_RemovalMethodID]  DEFAULT ((0)),
	[SystemRefreshed] [bit] NOT NULL CONSTRAINT [DF_Progress_SystemRefreshed]  DEFAULT ((0)),
	[LoginCount] [int] NOT NULL DEFAULT ((0)),
	[Duration] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_Progress] PRIMARY KEY CLUSTERED 
(
	[ProgressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Progress]  WITH CHECK ADD  CONSTRAINT [FK_Progress_Candidates] FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
GO
ALTER TABLE [dbo].[Progress] CHECK CONSTRAINT [FK_Progress_Candidates]
GO
ALTER TABLE [dbo].[Progress]  WITH CHECK ADD  CONSTRAINT [FK_Progress_Customisations] FOREIGN KEY([CustomisationID])
REFERENCES [dbo].[Customisations] ([CustomisationID])
GO
ALTER TABLE [dbo].[Progress] CHECK CONSTRAINT [FK_Progress_Customisations]
GO
