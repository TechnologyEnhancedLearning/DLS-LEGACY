USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilteredSeniorityMapping](
	[CompetencyGroupID] [int] NOT NULL,
	[SeniorityID] [int] NOT NULL,
 CONSTRAINT [PK_FilteredSeniorityMapping] PRIMARY KEY CLUSTERED 
(
	[CompetencyGroupID] ASC,
	[SeniorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FilteredSeniorityMapping]  WITH CHECK ADD  CONSTRAINT [FK_FilteredSeniorityMapping_CompetencyGroupID_CompetencyGroups_ID] FOREIGN KEY([CompetencyGroupID])
REFERENCES [dbo].[CompetencyGroups] ([ID])
GO
ALTER TABLE [dbo].[FilteredSeniorityMapping] CHECK CONSTRAINT [FK_FilteredSeniorityMapping_CompetencyGroupID_CompetencyGroups_ID]
GO
