USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Centres](
	[CentreID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL,
	[RegionID] [int] NOT NULL,
	[CentreName] [varchar](250) NOT NULL,
	[ContactForename] [varchar](250) NULL,
	[ContactSurname] [varchar](250) NULL,
	[ContactEmail] [varchar](250) NULL,
	[ContactTelephone] [varchar](250) NULL,
	[PriorCandidates] [int] NOT NULL,
	[AutoRegisterManagerEmail] [varchar](250) NULL,
	[AutoRegistered] [bit] NOT NULL,
	[SignatureMimeType] [varchar](50) NOT NULL,
	[SignatureImage] [image] NULL,
	[SignatureWidth] [int] NOT NULL,
	[SignatureHeight] [int] NOT NULL,
	[Invite] [int] NOT NULL,
	[BannerText] [varchar](250) NULL,
	[F1Name] [varchar](250) NULL,
	[F1Mandatory] [bit] NOT NULL,
	[F1Options] [nvarchar](max) NULL,
	[F2Name] [varchar](250) NULL,
	[F2Mandatory] [bit] NOT NULL,
	[F2Options] [nvarchar](max) NULL,
	[F3Name] [varchar](250) NULL,
	[F3Mandatory] [bit] NOT NULL,
	[F3Options] [nvarchar](max) NULL,
	[LastChecked] [date] NOT NULL,
	[Long] [float] NULL,
	[Lat] [float] NULL,
	[IPPrefix] [nvarchar](100) NULL,
	[pwTelephone] [nvarchar](100) NULL,
	[pwEmail] [nvarchar](100) NULL,
	[pwPostCode] [nvarchar](10) NULL,
	[pwHours] [nvarchar](100) NULL,
	[pwWebURL] [nvarchar](100) NULL,
	[pwTrustsCovered] [nvarchar](max) NULL,
	[pwTrainingLocations] [nvarchar](max) NULL,
	[pwGeneralInfo] [nvarchar](max) NULL,
	[CentreLogo] [image] NULL,
	[LogoWidth] [int] NULL,
	[LogoHeight] [int] NULL,
	[pwOffice03] [bit] NOT NULL,
	[pwOffice07] [bit] NOT NULL,
	[pwOffice10] [bit] NOT NULL,
	[pwExternalCandidates] [bit] NOT NULL,
	[pwChargeExternals] [bit] NOT NULL,
	[pwClassroomDelivery] [bit] NOT NULL,
	[pwWorkshopDelivery] [bit] NOT NULL,
	[pwElearningDelivery] [bit] NOT NULL,
	[pwSelfStudyDelivery] [bit] NOT NULL,
	[pwOfficialExams] [bit] NOT NULL,
	[LogoMimeType] [varchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CentreCreated] [datetime] NOT NULL,
	[BetaTesting] [bit] NOT NULL,
	[CentreTypeID] [int] NOT NULL,
	[NotifyEmail] [varchar](250) NULL,
	[kbPassword] [nvarchar](12) NULL,
	[kbLoginPrompt] [nvarchar](50) NULL,
	[kbSelfRegister] [bit] NOT NULL,
	[kbContact] [nvarchar](50) NULL,
	[kbYouTube] [bit] NOT NULL,
	[kbDefaultOfficeVersion] [int] NOT NULL,
	[lpAvailableCourses] [bit] NOT NULL,
	[CustomField1PromptID] [int] NOT NULL,
	[CustomField2PromptID] [int] NOT NULL,
	[CustomField3PromptID] [int] NOT NULL,
	[ServerSpaceBytes] [bigint] NOT NULL,
	[CustomField4PromptID] [int] NOT NULL,
	[F4Options] [nvarchar](max) NULL,
	[F4Mandatory] [bit] NOT NULL,
	[CustomField5PromptID] [int] NOT NULL,
	[F5Options] [nvarchar](max) NULL,
	[F5Mandatory] [bit] NOT NULL,
	[CustomField6PromptID] [int] NOT NULL,
	[F6Options] [nvarchar](max) NULL,
	[F6Mandatory] [bit] NOT NULL,
	[CMSAdministrators] [int] NOT NULL,
	[CMSManagers] [int] NOT NULL,
	[CustomCourses] [int] NOT NULL,
	[CCLicences] [int] NOT NULL,
	[Trainers] [int] NOT NULL,
	[ContractTypeID] [int] NOT NULL,
	[ContractReviewDate] [date] NULL,
	[ServerSpaceUsed] [bigint] NOT NULL,
	[CandidateByteLimit] [bigint] NOT NULL,
	[ShortName] [nvarchar](20) NULL,
	[LearningPortalUrl] [nvarchar](100) NULL,
 CONSTRAINT [PK_Centres] PRIMARY KEY CLUSTERED 
(
	[CentreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_Status]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_PriorCandidates]  DEFAULT ((0)) FOR [PriorCandidates]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_AutoRegistered]  DEFAULT ((0)) FOR [AutoRegistered]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_SignatureMimeType]  DEFAULT ('') FOR [SignatureMimeType]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_SignatureWidth]  DEFAULT ((0)) FOR [SignatureWidth]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_SignatureHeight]  DEFAULT ((0)) FOR [SignatureHeight]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_Invite]  DEFAULT ((1)) FOR [Invite]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__F1Manda__4D5F7D71]  DEFAULT ((0)) FOR [F1Mandatory]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__F2Manda__4E53A1AA]  DEFAULT ((0)) FOR [F2Mandatory]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__F3Manda__4F47C5E3]  DEFAULT ((0)) FOR [F3Mandatory]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_LastChecked]  DEFAULT (dateadd(month,(-3),getutcdate())) FOR [LastChecked]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_IPPrefix]  DEFAULT ('194.176.105') FOR [IPPrefix]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_LogoWidth]  DEFAULT ((0)) FOR [LogoWidth]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_LogoHeight]  DEFAULT ((0)) FOR [LogoHeight]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwOffice03]  DEFAULT ((0)) FOR [pwOffice03]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwOffice07]  DEFAULT ((0)) FOR [pwOffice07]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwOffice10]  DEFAULT ((0)) FOR [pwOffice10]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwExternalCandidates]  DEFAULT ((0)) FOR [pwExternalCandidates]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwChargeExternals]  DEFAULT ((0)) FOR [pwChargeExternals]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwClassroomDelivery]  DEFAULT ((0)) FOR [pwClassroomDelivery]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwWorkshopDelivery]  DEFAULT ((0)) FOR [pwWorkshopDelivery]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwElearningDelivery]  DEFAULT ((0)) FOR [pwElearningDelivery]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwSelfStudyDelivery]  DEFAULT ((0)) FOR [pwSelfStudyDelivery]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_pwOfficialExams]  DEFAULT ((0)) FOR [pwOfficialExams]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_LogoMimeType]  DEFAULT ('') FOR [LogoMimeType]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_CentreCreated]  DEFAULT (getutcdate()) FOR [CentreCreated]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__BetaTes__6CA31EA0]  DEFAULT ((0)) FOR [BetaTesting]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__CentreT__2882FE7D]  DEFAULT ((1)) FOR [CentreTypeID]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__kbSelfR__5649C92D]  DEFAULT ((1)) FOR [kbSelfRegister]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__kbYouTu__573DED66]  DEFAULT ((0)) FOR [kbYouTube]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__kbDefau__5832119F]  DEFAULT ((0)) FOR [kbDefaultOfficeVersion]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_lpAvailableCourses]  DEFAULT ((1)) FOR [lpAvailableCourses]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__CustomF__3C974627]  DEFAULT ((0)) FOR [CustomField1PromptID]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__CustomF__3D8B6A60]  DEFAULT ((0)) FOR [CustomField2PromptID]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF__Centres__CustomF__3E7F8E99]  DEFAULT ((0)) FOR [CustomField3PromptID]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_ServerSpaceBytes]  DEFAULT ((0)) FOR [ServerSpaceBytes]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_CustomField4PromptID]  DEFAULT ((0)) FOR [CustomField4PromptID]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_F4Mandatory]  DEFAULT ((0)) FOR [F4Mandatory]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_CustomField5PromptID]  DEFAULT ((0)) FOR [CustomField5PromptID]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_F5Mandatory]  DEFAULT ((0)) FOR [F5Mandatory]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_CustomField6PromptID]  DEFAULT ((0)) FOR [CustomField6PromptID]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_F6Mandatory]  DEFAULT ((0)) FOR [F6Mandatory]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_CMSAdministrators]  DEFAULT ((5)) FOR [CMSAdministrators]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_CMSManagers]  DEFAULT ((0)) FOR [CMSManagers]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_CustomCourses]  DEFAULT ((0)) FOR [CustomCourses]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_CCLicences]  DEFAULT ((0)) FOR [CCLicences]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_Trainers]  DEFAULT ((0)) FOR [Trainers]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_ContractType]  DEFAULT ((1)) FOR [ContractTypeID]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_ServerSpaceUsed]  DEFAULT ((0)) FOR [ServerSpaceUsed]
GO
ALTER TABLE [dbo].[Centres] ADD  CONSTRAINT [DF_Centres_CandidateByteLimit]  DEFAULT ((0)) FOR [CandidateByteLimit]
GO
ALTER TABLE [dbo].[Centres]  WITH CHECK ADD  CONSTRAINT [FK_Centres_CentreTypes] FOREIGN KEY([CentreTypeID])
REFERENCES [dbo].[CentreTypes] ([CentreTypeID])
GO
ALTER TABLE [dbo].[Centres] CHECK CONSTRAINT [FK_Centres_CentreTypes]
GO
ALTER TABLE [dbo].[Centres]  WITH CHECK ADD  CONSTRAINT [FK_Centres_ContractTypes] FOREIGN KEY([ContractTypeID])
REFERENCES [dbo].[ContractTypes] ([ContractTypeID])
GO
ALTER TABLE [dbo].[Centres] CHECK CONSTRAINT [FK_Centres_ContractTypes]
GO
ALTER TABLE [dbo].[Centres]  WITH CHECK ADD  CONSTRAINT [FK_Centres_Regions] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Regions] ([RegionID])
GO
ALTER TABLE [dbo].[Centres] CHECK CONSTRAINT [FK_Centres_Regions]
GO
