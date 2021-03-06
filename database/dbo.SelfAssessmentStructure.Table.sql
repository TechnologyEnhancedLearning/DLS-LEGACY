USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelfAssessmentStructure](
	[SelfAssessmentID] [int] NOT NULL,
	[CompetencyID] [int] NOT NULL,
 CONSTRAINT [PK_SelfAssessmentStructure] PRIMARY KEY CLUSTERED 
(
	[SelfAssessmentID] ASC,
	[CompetencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SelfAssessmentStructure]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessmentStructure_CompetencyID_Competencies_ID] FOREIGN KEY([CompetencyID])
REFERENCES [dbo].[Competencies] ([ID])
GO
ALTER TABLE [dbo].[SelfAssessmentStructure] CHECK CONSTRAINT [FK_SelfAssessmentStructure_CompetencyID_Competencies_ID]
GO
ALTER TABLE [dbo].[SelfAssessmentStructure]  WITH CHECK ADD  CONSTRAINT [FK_SelfAssessmentStructure_SelfAssessmentID_SelfAssessments_ID] FOREIGN KEY([SelfAssessmentID])
REFERENCES [dbo].[SelfAssessments] ([ID])
GO
ALTER TABLE [dbo].[SelfAssessmentStructure] CHECK CONSTRAINT [FK_SelfAssessmentStructure_SelfAssessmentID_SelfAssessments_ID]
GO
