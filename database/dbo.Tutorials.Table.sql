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
	[Description] [nvarchar](500) NULL,
	[VideoPath] [nvarchar](255) NULL,
	[TutorialPath] [nvarchar](255) NULL,
	[SupportingMatsPath] [nvarchar](255) NULL,
	[ConsolidationPath] [nvarchar](255) NULL,
	[Active] [bit] NOT NULL,
	[Objectives] [nvarchar](max) NULL,
	[DiagAssessOutOf] [int] NOT NULL,
	[VideoCount] [int] NOT NULL,
	[ObjectiveNum] [int] NOT NULL,
	[KBVideoCount] [int] NOT NULL,
	[Keywords] [nvarchar](255) NULL,
	[ArchivedDate] [datetime] NULL,
	[ArchivedByID] [int] NULL,
	[OrderByNumber] [int] NOT NULL,
	[CMIInteractionIDs] [nvarchar](150) NULL,
	[OverrideTutorialMins] [int] NOT NULL,
	[AverageTutMins] [int] NOT NULL,
	[OriginalTutorialID] [int] NOT NULL,
	[ExamAreaID] [int] NULL,
	[ContentTypeID] [int] NOT NULL,
	[LearnerMarksCompletion] [bit] NOT NULL,
	[DefaultMethodID] [int] NOT NULL,
	[AssessmentTypeID] [int] NOT NULL,
	[EvidenceText] [nvarchar](max) NULL,
	[IncludeActionPlan] [bit] NOT NULL,
	[SupervisorVerify] [bit] NOT NULL,
	[SupervisorSuccessText] [nvarchar](50) NULL,
	[SupervisorFailText] [nvarchar](50) NULL,
	[RequireVideoPercent] [int] NULL,
	[RequireTutorialCompletion] [bit] NULL,
	[RequireSupportMatsOpen] [bit] NULL,
	[AllowPreview] [bit] NOT NULL,
 CONSTRAINT [PK_Tutorials] PRIMARY KEY CLUSTERED 
(
	[TutorialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF_Tutorials_DiagOutOf]  DEFAULT ((0)) FOR [DiagAssessOutOf]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF_Tutorials_VideoCount]  DEFAULT ((0)) FOR [VideoCount]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Objec__6F7F8B4B]  DEFAULT ((0)) FOR [ObjectiveNum]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF_Tutorials_KBVideoCount]  DEFAULT ((0)) FOR [KBVideoCount]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF_Tutorials_OrderByNumber]  DEFAULT ((0)) FOR [OrderByNumber]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF_Tutorials_OverrideTutorialMins]  DEFAULT ((0)) FOR [OverrideTutorialMins]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF_Tutorials_AverageTutMins]  DEFAULT ((0)) FOR [AverageTutMins]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF_Tutorials_OriginalTutorialID]  DEFAULT ((0)) FOR [OriginalTutorialID]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Tutor__43C4FD51]  DEFAULT ((1)) FOR [ContentTypeID]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Learn__44B9218A]  DEFAULT ((0)) FOR [LearnerMarksCompletion]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Defau__45AD45C3]  DEFAULT ((0)) FOR [DefaultMethodID]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Asses__46A169FC]  DEFAULT ((0)) FOR [AssessmentTypeID]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Inclu__47958E35]  DEFAULT ((0)) FOR [IncludeActionPlan]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Super__4889B26E]  DEFAULT ((0)) FOR [SupervisorVerify]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Requi__4F36AFFD]  DEFAULT ((0)) FOR [RequireVideoPercent]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Requi__502AD436]  DEFAULT ((0)) FOR [RequireTutorialCompletion]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF__Tutorials__Requi__511EF86F]  DEFAULT ((0)) FOR [RequireSupportMatsOpen]
GO
ALTER TABLE [dbo].[Tutorials] ADD  CONSTRAINT [DF_Tutorials_AllowPreview]  DEFAULT ((0)) FOR [AllowPreview]
GO
ALTER TABLE [dbo].[Tutorials]  WITH CHECK ADD  CONSTRAINT [FK_Tutorials_Sections] FOREIGN KEY([SectionID])
REFERENCES [dbo].[Sections] ([SectionID])
GO
ALTER TABLE [dbo].[Tutorials] CHECK CONSTRAINT [FK_Tutorials_Sections]
GO
