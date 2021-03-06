USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelfAssessmentResults](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CandidateID] [int] NOT NULL,
	[SelfAssessmentID] [int] NOT NULL,
	[CompetencyID] [int] NOT NULL,
	[AssessmentQuestionID] [int] NOT NULL,
	[Result] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SelfAssessmentResults] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SelfAssessmentResults] ADD  CONSTRAINT [DF_SelfAssessmentResults_DateTime]  DEFAULT (getutcdate()) FOR [DateTime]
GO
ALTER TABLE [dbo].[SelfAssessmentResults]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessmentResults_AssessmentQuestionID_AssessmentQuestions_ID] FOREIGN KEY([AssessmentQuestionID])
REFERENCES [dbo].[AssessmentQuestions] ([ID])
GO
ALTER TABLE [dbo].[SelfAssessmentResults] CHECK CONSTRAINT [FK_SelfAssessmentResults_AssessmentQuestionID_AssessmentQuestions_ID]
GO
ALTER TABLE [dbo].[SelfAssessmentResults]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessmentResults_CandidateID_Candidates_CandidateID] FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
GO
ALTER TABLE [dbo].[SelfAssessmentResults] CHECK CONSTRAINT [FK_SelfAssessmentResults_CandidateID_Candidates_CandidateID]
GO
ALTER TABLE [dbo].[SelfAssessmentResults]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessmentResults_CompetencyID_Competencies_ID] FOREIGN KEY([CompetencyID])
REFERENCES [dbo].[Competencies] ([ID])
GO
ALTER TABLE [dbo].[SelfAssessmentResults] CHECK CONSTRAINT [FK_SelfAssessmentResults_CompetencyID_Competencies_ID]
GO
ALTER TABLE [dbo].[SelfAssessmentResults]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessmentResults_SelfAssessmentID_SelfAssessments_ID] FOREIGN KEY([SelfAssessmentID])
REFERENCES [dbo].[SelfAssessments] ([ID])
GO
ALTER TABLE [dbo].[SelfAssessmentResults] CHECK CONSTRAINT [FK_SelfAssessmentResults_SelfAssessmentID_SelfAssessments_ID]
GO
