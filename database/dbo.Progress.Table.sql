USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[ModifierID] [int] NOT NULL,
	[FirstSubmittedTime] [datetime] NOT NULL,
	[DiagnosticScore] [int] NULL,
	[FollowUpEvalID] [uniqueidentifier] NULL,
	[FollupUpEvaluated] [datetime] NULL,
	[IncompleteEvalID] [uniqueidentifier] NULL,
	[IncompleteEvaluated] [datetime] NULL,
	[NonCompletedFeedbackGUID] [uniqueidentifier] NULL,
	[PLLocked] [bit] NOT NULL,
	[CompleteByDate] [datetime] NULL,
	[EnrollmentMethodID] [int] NOT NULL,
	[EnrolledByAdminID] [int] NULL,
	[OneMonthReminderSent] [bit] NOT NULL,
	[ExpiredReminderSent] [bit] NOT NULL,
	[RemovedDate] [datetime] NULL,
	[RemovalMethodID] [int] NOT NULL,
	[SystemRefreshed] [bit] NOT NULL,
	[LoginCount] [int] NOT NULL,
	[Duration] [int] NOT NULL,
	[SupervisorAdminID] [int] NOT NULL,
 CONSTRAINT [PK_Progress] PRIMARY KEY CLUSTERED 
(
	[ProgressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Progress] ADD  CONSTRAINT [DF_Progress_ModifierID]  DEFAULT ((0)) FOR [ModifierID]
GO
ALTER TABLE [dbo].[Progress] ADD  CONSTRAINT [DF_Progress_FirstSubmittedTime]  DEFAULT (getutcdate()) FOR [FirstSubmittedTime]
GO
ALTER TABLE [dbo].[Progress] ADD  CONSTRAINT [DF_Progress_PLLocked]  DEFAULT ((0)) FOR [PLLocked]
GO
ALTER TABLE [dbo].[Progress] ADD  CONSTRAINT [DF_Progress_EnrollmentMethodID]  DEFAULT ((1)) FOR [EnrollmentMethodID]
GO
ALTER TABLE [dbo].[Progress] ADD  CONSTRAINT [DF_Progress_OneMonthReminderSent]  DEFAULT ((0)) FOR [OneMonthReminderSent]
GO
ALTER TABLE [dbo].[Progress] ADD  CONSTRAINT [DF_Progress_ExpiredReminderSent]  DEFAULT ((0)) FOR [ExpiredReminderSent]
GO
ALTER TABLE [dbo].[Progress] ADD  CONSTRAINT [DF_Progress_RemovalMethodID]  DEFAULT ((0)) FOR [RemovalMethodID]
GO
ALTER TABLE [dbo].[Progress] ADD  CONSTRAINT [DF_Progress_SystemRefreshed]  DEFAULT ((0)) FOR [SystemRefreshed]
GO
ALTER TABLE [dbo].[Progress] ADD  DEFAULT ((0)) FOR [LoginCount]
GO
ALTER TABLE [dbo].[Progress] ADD  DEFAULT ((0)) FOR [Duration]
GO
ALTER TABLE [dbo].[Progress] ADD  CONSTRAINT [DF_Progress_SupervisorAdminID]  DEFAULT ((0)) FOR [SupervisorAdminID]
GO
ALTER TABLE [dbo].[Progress]  WITH CHECK ADD  CONSTRAINT [FK_Progress_Candidates] FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Progress] CHECK CONSTRAINT [FK_Progress_Candidates]
GO
ALTER TABLE [dbo].[Progress]  WITH CHECK ADD  CONSTRAINT [FK_Progress_Customisations] FOREIGN KEY([CustomisationID])
REFERENCES [dbo].[Customisations] ([CustomisationID])
GO
ALTER TABLE [dbo].[Progress] CHECK CONSTRAINT [FK_Progress_Customisations]
GO
