USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilteredComptenencyMapping](
	[CompetencyID] [int] NOT NULL,
	[FilteredCompetencyID] [int] NOT NULL,
 CONSTRAINT [PK_FilteredComptenencyMapping] PRIMARY KEY CLUSTERED 
(
	[CompetencyID] ASC,
	[FilteredCompetencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FilteredComptenencyMapping]  WITH CHECK ADD  CONSTRAINT [FK_FilteredComptenencyMapping_CompetencyID_Competencies_ID] FOREIGN KEY([CompetencyID])
REFERENCES [dbo].[Competencies] ([ID])
GO
ALTER TABLE [dbo].[FilteredComptenencyMapping] CHECK CONSTRAINT [FK_FilteredComptenencyMapping_CompetencyID_Competencies_ID]
GO
