USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CandidateAssessments](
	[CandidateID] [int] NOT NULL,
	[SelfAssessmentID] [int] NOT NULL,
	[StartedDate] [datetime] NOT NULL,
	[LastAccessed] [datetime] NULL,
	[CompleteByDate] [datetime] NULL,
	[UserBookmark] [nvarchar](100) NULL,
	[UnprocessedUpdates] [bit] NOT NULL,
	[LaunchCount] [int] NOT NULL,
	[CompletedDate] [datetime] NULL,
	[RemovedDate] [datetime] NULL,
	[RemovalMethodID] [int] NOT NULL,
	[EnrolmentMethodId] [int] NOT NULL,
	[EnrolledByAdminId] [int] NULL,
	[SupervisorAdminId] [int] NULL,
	[OneMonthReminderSent] [bit] NOT NULL,
	[ExpiredReminderSent] [bit] NOT NULL,
 CONSTRAINT [PK_CandidateAssessments] PRIMARY KEY CLUSTERED 
(
	[CandidateID] ASC,
	[SelfAssessmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CandidateAssessments] ADD  CONSTRAINT [DF_CandidateAssessments_StartedDate]  DEFAULT (getdate()) FOR [StartedDate]
GO
ALTER TABLE [dbo].[CandidateAssessments] ADD  CONSTRAINT [DF_CandidateAssessments_UnprocessedUpdates]  DEFAULT ((1)) FOR [UnprocessedUpdates]
GO
ALTER TABLE [dbo].[CandidateAssessments] ADD  CONSTRAINT [DF_CandidateAssessments_LaunchCount]  DEFAULT ((0)) FOR [LaunchCount]
GO
ALTER TABLE [dbo].[CandidateAssessments] ADD  CONSTRAINT [DF_CandidateAssessments_RemovalMethodID]  DEFAULT ((1)) FOR [RemovalMethodID]
GO
ALTER TABLE [dbo].[CandidateAssessments] ADD  CONSTRAINT [DF_CandidateAssessments_EnrolmentMethodId]  DEFAULT ((1)) FOR [EnrolmentMethodId]
GO
ALTER TABLE [dbo].[CandidateAssessments] ADD  CONSTRAINT [DF_CandidateAssessments_OneMonthReminderSent]  DEFAULT ((0)) FOR [OneMonthReminderSent]
GO
ALTER TABLE [dbo].[CandidateAssessments] ADD  CONSTRAINT [DF_CandidateAssessments_ExpiredReminderSent]  DEFAULT ((0)) FOR [ExpiredReminderSent]
GO
ALTER TABLE [dbo].[CandidateAssessments]  WITH CHECK ADD  CONSTRAINT [FK_CandidateAssessments_CandidateID_Candidates_CandidateID] FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
GO
ALTER TABLE [dbo].[CandidateAssessments] CHECK CONSTRAINT [FK_CandidateAssessments_CandidateID_Candidates_CandidateID]
GO
ALTER TABLE [dbo].[CandidateAssessments]  WITH CHECK ADD  CONSTRAINT [FK_CandidateAssessments_SelfAssessmentID_SelfAssessments_ID] FOREIGN KEY([SelfAssessmentID])
REFERENCES [dbo].[SelfAssessments] ([ID])
GO
ALTER TABLE [dbo].[CandidateAssessments] CHECK CONSTRAINT [FK_CandidateAssessments_SelfAssessmentID_SelfAssessments_ID]
GO
