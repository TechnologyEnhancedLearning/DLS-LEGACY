USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FollowUpFeedback](
	[FUEvaluationID] [int] IDENTITY(1,1) NOT NULL,
	[JobGroupID] [int] NOT NULL,
	[CustomisationID] [int] NOT NULL,
	[Q1] [tinyint] NOT NULL,
	[Q1Comments] [nvarchar](max) NULL,
	[Q2] [tinyint] NOT NULL,
	[Q2Comments] [nvarchar](max) NULL,
	[Q3] [tinyint] NOT NULL,
	[Q3Comments] [nvarchar](max) NULL,
	[Q4] [tinyint] NOT NULL,
	[Q4Comments] [nvarchar](max) NULL,
	[Q5] [tinyint] NOT NULL,
	[Q5Comments] [nvarchar](max) NULL,
	[Q6] [tinyint] NOT NULL,
	[Q6Comments] [nvarchar](max) NULL,
	[EvaluatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_FollowUpFeedback] PRIMARY KEY CLUSTERED 
(
	[FUEvaluationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[FollowUpFeedback] ADD  CONSTRAINT [DF_FollowUpFeedback_Q1]  DEFAULT ((0)) FOR [Q1]
GO
ALTER TABLE [dbo].[FollowUpFeedback] ADD  CONSTRAINT [DF_FollowUpFeedback_Q2]  DEFAULT ((0)) FOR [Q2]
GO
ALTER TABLE [dbo].[FollowUpFeedback] ADD  CONSTRAINT [DF_FollowUpFeedback_Q3]  DEFAULT ((0)) FOR [Q3]
GO
ALTER TABLE [dbo].[FollowUpFeedback] ADD  CONSTRAINT [DF_FollowUpFeedback_Q4]  DEFAULT ((0)) FOR [Q4]
GO
ALTER TABLE [dbo].[FollowUpFeedback] ADD  CONSTRAINT [DF_FollowUpFeedback_Q5]  DEFAULT ((0)) FOR [Q5]
GO
ALTER TABLE [dbo].[FollowUpFeedback] ADD  CONSTRAINT [DF_FollowUpFeedback_Q6]  DEFAULT ((0)) FOR [Q6]
GO
ALTER TABLE [dbo].[FollowUpFeedback] ADD  CONSTRAINT [DF_FollowUpFeedback_EvaluatedDate]  DEFAULT (getutcdate()) FOR [EvaluatedDate]
GO
