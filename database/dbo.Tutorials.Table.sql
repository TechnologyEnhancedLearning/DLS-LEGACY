USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tutorials](
	[TutorialID] [int] IDENTITY(1,1) NOT NULL,
	[SectionID] [int] NOT NULL,
	[TutorialName] [nvarchar](255) NOT NULL,
	[ExamAreaID] [int] NULL,
	[VideoPath] [nvarchar](255) NULL,
	[TutorialPath] [nvarchar](255) NULL,
	[SupportingMatsPath] [nvarchar](255) NULL,
	[ConsolidationPath] [nvarchar](255) NULL,
	[Active] [bit] NOT NULL,
	[Objectives] [nvarchar](max) NULL,
	[DiagAssessOutOf] [int] NOT NULL CONSTRAINT [DF_Tutorials_DiagOutOf]  DEFAULT ((0)),
	[VideoCount] [int] NOT NULL CONSTRAINT [DF_Tutorials_VideoCount]  DEFAULT ((0)),
	[ObjectiveNum] [int] NOT NULL DEFAULT ((0)),
	[KBVideoCount] [int] NOT NULL CONSTRAINT [DF_Tutorials_KBVideoCount]  DEFAULT ((0)),
	[Keywords] [nvarchar](255) NULL,
	[ArchivedDate] [datetime] NULL,
	[ArchivedByID] [int] NULL,
	[OrderByNumber] [int] NOT NULL CONSTRAINT [DF_Tutorials_OrderByNumber]  DEFAULT ((0)),
	[CMIInteractionIDs] [nvarchar](150) NULL,
	[OverrideTutorialMins] [int] NOT NULL CONSTRAINT [DF_Tutorials_OverrideTutorialMins]  DEFAULT ((0)),
	[AverageTutMins] [int] NOT NULL CONSTRAINT [DF_Tutorials_AverageTutMins]  DEFAULT ((0)),
	[OriginalTutorialID] [int] NOT NULL CONSTRAINT [DF_Tutorials_OriginalTutorialID]  DEFAULT ((0)),
 CONSTRAINT [PK_Tutorials] PRIMARY KEY CLUSTERED 
(
	[TutorialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Tutorials]  WITH CHECK ADD  CONSTRAINT [FK_Tutorials_Sections] FOREIGN KEY([SectionID])
REFERENCES [dbo].[Sections] ([SectionID])
GO
ALTER TABLE [dbo].[Tutorials] CHECK CONSTRAINT [FK_Tutorials_Sections]
GO
