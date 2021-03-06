USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Competencies](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CompetencyGroupID] [int] NOT NULL,
 CONSTRAINT [PK_Competencies] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Competencies]  WITH CHECK ADD  CONSTRAINT [FK_Competencies_CompetencyGroupID_CompetencyGroups_ID] FOREIGN KEY([CompetencyGroupID])
REFERENCES [dbo].[CompetencyGroups] ([ID])
GO
ALTER TABLE [dbo].[Competencies] CHECK CONSTRAINT [FK_Competencies_CompetencyGroupID_CompetencyGroups_ID]
GO
