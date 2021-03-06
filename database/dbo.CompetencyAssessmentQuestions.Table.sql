USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompetencyAssessmentQuestions](
	[CompetencyID] [int] NOT NULL,
	[AssessmentQuestionID] [int] NOT NULL,
 CONSTRAINT [PK_CompetencyAssessmentQuestions] PRIMARY KEY CLUSTERED 
(
	[CompetencyID] ASC,
	[AssessmentQuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompetencyAssessmentQuestions]  WITH CHECK ADD  CONSTRAINT [FK_CompetencyAssessmentQuestions_AssessmentQuestionID_Competencies_ID] FOREIGN KEY([AssessmentQuestionID])
REFERENCES [dbo].[Competencies] ([ID])
GO
ALTER TABLE [dbo].[CompetencyAssessmentQuestions] CHECK CONSTRAINT [FK_CompetencyAssessmentQuestions_AssessmentQuestionID_Competencies_ID]
GO
ALTER TABLE [dbo].[CompetencyAssessmentQuestions]  WITH CHECK ADD  CONSTRAINT [FK_CompetencyAssessmentQuestions_CompetencyID_Competencies_ID] FOREIGN KEY([CompetencyID])
REFERENCES [dbo].[Competencies] ([ID])
GO
ALTER TABLE [dbo].[CompetencyAssessmentQuestions] CHECK CONSTRAINT [FK_CompetencyAssessmentQuestions_CompetencyID_Competencies_ID]
GO
