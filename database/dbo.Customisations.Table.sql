USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customisations](
	[CustomisationID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL,
	[CurrentVersion] [int] NOT NULL,
	[CentreID] [int] NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[CustomisationName] [varchar](250) NOT NULL,
	[CustomisationText] [varchar](max) NULL,
	[IsAssessed] [bit] NOT NULL,
	[IsStandard] [bit] NOT NULL,
	[Password] [nvarchar](50) NULL,
	[SelfRegister] [bit] NOT NULL,
	[Q1Mandatory] [bit] NOT NULL,
	[Q1Options] [varchar](1000) NULL,
	[Q2Mandatory] [bit] NOT NULL,
	[Q2Options] [varchar](1000) NULL,
	[Q3Mandatory] [bit] NOT NULL,
	[Q3Options] [varchar](1000) NULL,
	[TutCompletionThreshold] [int] NOT NULL,
	[DiagCompletionThreshold] [int] NOT NULL,
	[DiagObjSelect] [bit] NOT NULL,
	[HideInLearnerPortal] [bit] NOT NULL,
	[LearningTimeMins] [nvarchar](20) NOT NULL,
	[CompleteWithinMonths] [int] NOT NULL,
	[Mandatory] [bit] NOT NULL,
	[ValidityMonths] [int] NOT NULL,
	[AutoRefresh] [bit] NOT NULL,
	[RefreshToCustomisationID] [int] NOT NULL,
	[AutoRefreshMonths] [int] NOT NULL,
	[CourseField1PromptID] [int] NOT NULL,
	[CourseField2PromptID] [int] NOT NULL,
	[CourseField3PromptID] [int] NOT NULL,
	[DisableCompletion] [bit] NOT NULL,
	[AllCentres] [bit] NOT NULL,
	[InviteContributors] [bit] NOT NULL,
	[NotificationEmails] [nvarchar](500) NULL,
	[DefaultSupervisorAdminID] [int] NOT NULL,
	[DefaultAppointmentTypeID] [int] NOT NULL,
	[ApplyLPDefaultsToSelfEnrol] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Customisations] PRIMARY KEY CLUSTERED 
(
	[CustomisationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_Status]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_CurrentVersion]  DEFAULT ((1)) FOR [CurrentVersion]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_IsAssessed]  DEFAULT ((0)) FOR [IsAssessed]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_IsStandard]  DEFAULT ((0)) FOR [IsStandard]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_SelfRegister]  DEFAULT ((1)) FOR [SelfRegister]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_Q1Mandatory]  DEFAULT ((0)) FOR [Q1Mandatory]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_Q2Mandatory]  DEFAULT ((0)) FOR [Q2Mandatory]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_Q3Mandatory]  DEFAULT ((0)) FOR [Q3Mandatory]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_TutCompletionThreshold]  DEFAULT ((100)) FOR [TutCompletionThreshold]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF__Customisa__DiagC__6D9742D9]  DEFAULT ((85)) FOR [DiagCompletionThreshold]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF__Customisa__DiagO__6E8B6712]  DEFAULT ((1)) FOR [DiagObjSelect]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_HideInLearnerPortal]  DEFAULT ((0)) FOR [HideInLearnerPortal]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_LearningTimeMins]  DEFAULT ('N/A') FOR [LearningTimeMins]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_CompleteWithinMonths]  DEFAULT ((0)) FOR [CompleteWithinMonths]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF__Customisa__Manda__73FD5501]  DEFAULT ((0)) FOR [Mandatory]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF__Customisa__Valid__74F1793A]  DEFAULT ((0)) FOR [ValidityMonths]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF__Customisa__AutoR__75E59D73]  DEFAULT ((0)) FOR [AutoRefresh]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_RefreshToCustomisationID]  DEFAULT ((0)) FOR [RefreshToCustomisationID]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF__Customisa__AutoR__76D9C1AC]  DEFAULT ((0)) FOR [AutoRefreshMonths]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_CourseField1PromptID]  DEFAULT ((0)) FOR [CourseField1PromptID]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_CourseField2PromptID]  DEFAULT ((0)) FOR [CourseField2PromptID]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_CourseField3PromptID]  DEFAULT ((0)) FOR [CourseField3PromptID]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_DisableCompletion]  DEFAULT ((0)) FOR [DisableCompletion]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_AllCentres]  DEFAULT ((0)) FOR [AllCentres]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF__Customisa__Invit__2EE9DBFC]  DEFAULT ((0)) FOR [InviteContributors]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_DefaultSupervisorAdminID]  DEFAULT ((0)) FOR [DefaultSupervisorAdminID]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_DefaultSupervisionTool]  DEFAULT ((0)) FOR [DefaultAppointmentTypeID]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_ApplyLPDefaultsToSelfEnrol]  DEFAULT ((0)) FOR [ApplyLPDefaultsToSelfEnrol]
GO
ALTER TABLE [dbo].[Customisations] ADD  CONSTRAINT [DF_Customisations_CreatedDate]  DEFAULT (getutcdate()) FOR [CreatedDate]
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
