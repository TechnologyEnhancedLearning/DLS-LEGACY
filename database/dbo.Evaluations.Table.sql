USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Evaluations](
	[EvaluationID] [int] IDENTITY(1,1) NOT NULL,
	[JobGroupID] [int] NOT NULL,
	[CustomisationID] [int] NOT NULL,
	[Q1] [tinyint] NOT NULL CONSTRAINT [DF_Evaluations_Q1]  DEFAULT ((255)),
	[Q2] [tinyint] NOT NULL CONSTRAINT [DF_Evaluations_Q2]  DEFAULT ((255)),
	[Q3] [tinyint] NOT NULL CONSTRAINT [DF_Evaluations_Q3]  DEFAULT ((255)),
	[Q4] [tinyint] NOT NULL CONSTRAINT [DF_Evaluations_Q4]  DEFAULT ((255)),
	[Q5] [tinyint] NOT NULL CONSTRAINT [DF_Evaluations_Q5]  DEFAULT ((255)),
	[Q6] [tinyint] NOT NULL CONSTRAINT [DF_Evaluations_Q6]  DEFAULT ((255)),
	[Q7] [tinyint] NOT NULL CONSTRAINT [DF_Evaluations_Q7]  DEFAULT ((255)),
	[EvaluatedDate] [date] NOT NULL CONSTRAINT [DF_Evaluations_EvaluatedDate]  DEFAULT (getutcdate()),
	[Band] [int] NOT NULL CONSTRAINT [DF_Evaluations_Band]  DEFAULT ((0)),
	[delName] [nvarchar](50) NULL,
	[delContact] [nvarchar](250) NULL,
 CONSTRAINT [PK_Evaluations] PRIMARY KEY CLUSTERED 
(
	[EvaluationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Evaluations]  WITH CHECK ADD  CONSTRAINT [FK_Evaluations_Customisations] FOREIGN KEY([CustomisationID])
REFERENCES [dbo].[Customisations] ([CustomisationID])
GO
ALTER TABLE [dbo].[Evaluations] CHECK CONSTRAINT [FK_Evaluations_Customisations]
GO
ALTER TABLE [dbo].[Evaluations]  WITH CHECK ADD  CONSTRAINT [FK_Evaluations_JobGroups] FOREIGN KEY([JobGroupID])
REFERENCES [dbo].[JobGroups] ([JobGroupID])
GO
ALTER TABLE [dbo].[Evaluations] CHECK CONSTRAINT [FK_Evaluations_JobGroups]
GO
