USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sections](
	[SectionID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[SectionNumber] [int] NOT NULL,
	[SectionName] [varchar](250) NOT NULL,
	[ConsolidationPath] [varchar](250) NULL,
	[DiagAssessPath] [varchar](250) NULL,
	[PLAssessPath] [varchar](250) NULL,
	[ConsolidationCount] [int] NOT NULL CONSTRAINT [DF_Sections_ConsolidationCount]  DEFAULT ((0)),
	[CreatedByID] [int] NOT NULL CONSTRAINT [DF_Sections_CreatedByID]  DEFAULT ((1)),
	[CreatedByCentreID] [int] NOT NULL CONSTRAINT [DF_Sections_CreatedByCentreID]  DEFAULT ((101)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Sections_CreatedDate]  DEFAULT (getdate()),
	[ArchivedDate] [datetime] NULL,
	[ArchivedByID] [int] NULL,
	[AverageSectionMins] [int] NOT NULL CONSTRAINT [DF_Sections_AverageSectionMins]  DEFAULT ((0)),
 CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED 
(
	[SectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sections]  WITH CHECK ADD  CONSTRAINT [FK_Sections_Applications] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[Sections] CHECK CONSTRAINT [FK_Sections_Applications]
GO
