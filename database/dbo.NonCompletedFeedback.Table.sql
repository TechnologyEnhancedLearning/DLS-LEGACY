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
	[WhyNotComplete] [tinyint] NOT NULL CONSTRAINT [DF_NonCompletedFeedback_WhyNotComplete]  DEFAULT ((0)),
	[R1_Style] [bit] NOT NULL CONSTRAINT [DF_NonCompletedFeedback_R1_Style]  DEFAULT ((0)),
	[R2_PreferF2F] [bit] NOT NULL CONSTRAINT [DF_NonCompletedFeedback_R2_PreferF2F]  DEFAULT ((0)),
	[R3_NotEnjoy] [bit] NOT NULL CONSTRAINT [DF_NonCompletedFeedback_R3_NotEnjoy]  DEFAULT ((0)),
	[R4_KnewItAll] [bit] NOT NULL CONSTRAINT [DF_NonCompletedFeedback_R4_KnewItAll]  DEFAULT ((0)),
	[R5_TooHard] [bit] NOT NULL CONSTRAINT [DF_NonCompletedFeedback_R5_TooHard]  DEFAULT ((0)),
	[R6_TechIssue] [bit] NOT NULL CONSTRAINT [DF_NonCompletedFeedback_R6_TechIssue]  DEFAULT ((0)),
	[R7_DislikeComputers] [bit] NOT NULL CONSTRAINT [DF_NonCompletedFeedback_R7_DislikeComputers]  DEFAULT ((0)),
 CONSTRAINT [PK_NonCompletedFeedback] PRIMARY KEY CLUSTERED 
(
	[NonCompletedFeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
