USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreSelfAssessments](
	[CentreID] [int] NOT NULL,
	[SelfAssessmentID] [int] NOT NULL,
	[AllowEnrolment] [bit] NOT NULL,
 CONSTRAINT [PK_CentreSelfAssessments] PRIMARY KEY CLUSTERED 
(
	[CentreID] ASC,
	[SelfAssessmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CentreSelfAssessments] ADD  CONSTRAINT [DF_CentreSelfAssessments_AllowEnrolment]  DEFAULT ((0)) FOR [AllowEnrolment]
GO
ALTER TABLE [dbo].[CentreSelfAssessments]  WITH CHECK ADD  CONSTRAINT [FK_CentreSelfAssessments_CentreID_Centres_CentreID] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[CentreSelfAssessments] CHECK CONSTRAINT [FK_CentreSelfAssessments_CentreID_Centres_CentreID]
GO
ALTER TABLE [dbo].[CentreSelfAssessments]  WITH CHECK ADD  CONSTRAINT [FK_CentreSelfAssessments_SelfAssessmentID_SelfAssessments_ID] FOREIGN KEY([SelfAssessmentID])
REFERENCES [dbo].[SelfAssessments] ([ID])
GO
ALTER TABLE [dbo].[CentreSelfAssessments] CHECK CONSTRAINT [FK_CentreSelfAssessments_SelfAssessmentID_SelfAssessments_ID]
GO
