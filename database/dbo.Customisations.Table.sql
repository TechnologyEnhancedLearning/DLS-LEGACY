USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customisations](
	[CustomisationID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Customisations_Status]  DEFAULT ((1)),
	[CurrentVersion] [int] NOT NULL CONSTRAINT [DF_Customisations_CurrentVersion]  DEFAULT ((1)),
	[CentreID] [int] NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[CustomisationName] [varchar](250) NOT NULL,
	[CustomisationText] [varchar](max) NULL,
	[Question1] [varchar](100) NULL,
	[Question2] [varchar](100) NULL,
	[Question3] [varchar](100) NULL,
	[IsAssessed] [bit] NOT NULL CONSTRAINT [DF_Customisations_IsAssessed]  DEFAULT ((0)),
	[IsStandard] [bit] NOT NULL CONSTRAINT [DF_Customisations_IsStandard]  DEFAULT ((0)),
	[Password] [nvarchar](50) NULL,
	[SelfRegister] [bit] NOT NULL CONSTRAINT [DF_Customisations_SelfRegister]  DEFAULT ((1)),
	[Q1Mandatory] [bit] NOT NULL CONSTRAINT [DF_Customisations_Q1Mandatory]  DEFAULT ((0)),
	[Q1Options] [varchar](1000) NULL,
	[Q2Mandatory] [bit] NOT NULL CONSTRAINT [DF_Customisations_Q2Mandatory]  DEFAULT ((0)),
	[Q2Options] [varchar](1000) NULL,
	[Q3Mandatory] [bit] NOT NULL CONSTRAINT [DF_Customisations_Q3Mandatory]  DEFAULT ((0)),
	[Q3Options] [varchar](1000) NULL,
	[TutCompletionThreshold] [int] NOT NULL CONSTRAINT [DF_Customisations_TutCompletionThreshold]  DEFAULT ((100)),
	[DiagCompletionThreshold] [int] NOT NULL CONSTRAINT [DF__Customisa__DiagC__6D9742D9]  DEFAULT ((85)),
	[DiagObjSelect] [bit] NOT NULL CONSTRAINT [DF__Customisa__DiagO__6E8B6712]  DEFAULT ((1)),
	[HideInLearnerPortal] [bit] NOT NULL CONSTRAINT [DF_Customisations_HideInLearnerPortal]  DEFAULT ((0)),
	[LearningTimeMins] [nvarchar](20) NOT NULL CONSTRAINT [DF_Customisations_LearningTimeMins]  DEFAULT ('N/A'),
	[CompleteWithinMonths] [int] NOT NULL CONSTRAINT [DF_Customisations_CompleteWithinMonths]  DEFAULT ((0)),
	[Mandatory] [bit] NOT NULL CONSTRAINT [DF__Customisa__Manda__3B3776EC]  DEFAULT ((0)),
	[ValidityMonths] [int] NOT NULL CONSTRAINT [DF__Customisa__Valid__3C2B9B25]  DEFAULT ((0)),
	[AutoRefresh] [bit] NOT NULL CONSTRAINT [DF__Customisa__AutoR__3D1FBF5E]  DEFAULT ((0)),
	[RefreshToCustomisationID] [int] NOT NULL CONSTRAINT [DF_Customisations_RefreshToCustomisationID]  DEFAULT ((0)),
	[AutoRefreshMonths] [int] NOT NULL CONSTRAINT [DF__Customisa__AutoR__3E13E397]  DEFAULT ((0)),
 CONSTRAINT [PK_Customisations] PRIMARY KEY CLUSTERED 
(
	[CustomisationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Customisations]  WITH CHECK ADD  CONSTRAINT [FK_Customisations_Applications] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[Customisations] CHECK CONSTRAINT [FK_Customisations_Applications]
GO
ALTER TABLE [dbo].[Customisations]  WITH CHECK ADD  CONSTRAINT [FK_Customisations_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[Customisations] CHECK CONSTRAINT [FK_Customisations_Centres]
GO
