USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NonCompletedFeedback](
	[NonCompletedFeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[JobGroupID] [int] NOT NULL,
	[CustomisationID] [int] NOT NULL,
	[WhyNotComplete] [tinyint] NOT NULL,
	[R1_Style] [bit] NOT NULL,
	[R2_PreferF2F] [bit] NOT NULL,
	[R3_NotEnjoy] [bit] NOT NULL,
	[R4_KnewItAll] [bit] NOT NULL,
	[R5_TooHard] [bit] NOT NULL,
	[R6_TechIssue] [bit] NOT NULL,
	[R7_DislikeComputers] [bit] NOT NULL,
	[EvalDate] [datetime] NOT NULL,
 CONSTRAINT [PK_NonCompletedFeedback] PRIMARY KEY CLUSTERED 
(
	[NonCompletedFeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NonCompletedFeedback] ADD  CONSTRAINT [DF_NonCompletedFeedback_WhyNotComplete]  DEFAULT ((0)) FOR [WhyNotComplete]
GO
ALTER TABLE [dbo].[NonCompletedFeedback] ADD  CONSTRAINT [DF_NonCompletedFeedback_R1_Style]  DEFAULT ((0)) FOR [R1_Style]
GO
ALTER TABLE [dbo].[NonCompletedFeedback] ADD  CONSTRAINT [DF_NonCompletedFeedback_R2_PreferF2F]  DEFAULT ((0)) FOR [R2_PreferF2F]
GO
ALTER TABLE [dbo].[NonCompletedFeedback] ADD  CONSTRAINT [DF_NonCompletedFeedback_R3_NotEnjoy]  DEFAULT ((0)) FOR [R3_NotEnjoy]
GO
ALTER TABLE [dbo].[NonCompletedFeedback] ADD  CONSTRAINT [DF_NonCompletedFeedback_R4_KnewItAll]  DEFAULT ((0)) FOR [R4_KnewItAll]
GO
ALTER TABLE [dbo].[NonCompletedFeedback] ADD  CONSTRAINT [DF_NonCompletedFeedback_R5_TooHard]  DEFAULT ((0)) FOR [R5_TooHard]
GO
ALTER TABLE [dbo].[NonCompletedFeedback] ADD  CONSTRAINT [DF_NonCompletedFeedback_R6_TechIssue]  DEFAULT ((0)) FOR [R6_TechIssue]
GO
ALTER TABLE [dbo].[NonCompletedFeedback] ADD  CONSTRAINT [DF_NonCompletedFeedback_R7_DislikeComputers]  DEFAULT ((0)) FOR [R7_DislikeComputers]
GO
ALTER TABLE [dbo].[NonCompletedFeedback] ADD  CONSTRAINT [DF_NonCompletedFeedback_EvalDate]  DEFAULT (getutcdate()) FOR [EvalDate]
GO
