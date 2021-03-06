USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sections](
	[SectionID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[SectionNumber] [int] NOT NULL,
	[SectionName] [varchar](250) NOT NULL,
	[ConsolidationPath] [varchar](250) NULL,
	[DiagAssessPath] [varchar](250) NULL,
	[PLAssessPath] [varchar](250) NULL,
	[ConsolidationCount] [int] NOT NULL,
	[CreatedByID] [int] NOT NULL,
	[CreatedByCentreID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ArchivedDate] [datetime] NULL,
	[ArchivedByID] [int] NULL,
	[AverageSectionMins] [int] NOT NULL,
 CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED 
(
	[SectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sections] ADD  CONSTRAINT [DF_Sections_ConsolidationCount]  DEFAULT ((0)) FOR [ConsolidationCount]
GO
ALTER TABLE [dbo].[Sections] ADD  CONSTRAINT [DF_Sections_CreatedByID]  DEFAULT ((1)) FOR [CreatedByID]
GO
ALTER TABLE [dbo].[Sections] ADD  CONSTRAINT [DF_Sections_CreatedByCentreID]  DEFAULT ((101)) FOR [CreatedByCentreID]
GO
ALTER TABLE [dbo].[Sections] ADD  CONSTRAINT [DF_Sections_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Sections] ADD  CONSTRAINT [DF_Sections_AverageSectionMins]  DEFAULT ((0)) FOR [AverageSectionMins]
GO
ALTER TABLE [dbo].[Sections]  WITH CHECK ADD  CONSTRAINT [FK_Sections_Applications] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[Sections] CHECK CONSTRAINT [FK_Sections_Applications]
GO
