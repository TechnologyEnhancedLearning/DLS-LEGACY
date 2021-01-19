USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Centres](
	[CentreID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Centres_Status]  DEFAULT ((1)),
	[RegionID] [int] NOT NULL,
	[CentreName] [varchar](250) NOT NULL,
	[ContactForename] [varchar](250) NULL,
	[ContactSurname] [varchar](250) NULL,
	[ContactEmail] [varchar](250) NULL,
	[ContactTelephone] [varchar](250) NULL,
	[PriorCandidates] [int] NOT NULL CONSTRAINT [DF_Centres_PriorCandidates]  DEFAULT ((0)),
	[AutoRegisterManagerEmail] [varchar](250) NULL,
	[AutoRegistered] [bit] NOT NULL CONSTRAINT [DF_Centres_AutoRegistered]  DEFAULT ((0)),
	[SignatureMimeType] [varchar](50) NOT NULL CONSTRAINT [DF_Centres_SignatureMimeType]  DEFAULT (''),
	[SignatureImage] [image] NULL,
	[SignatureWidth] [int] NOT NULL CONSTRAINT [DF_Centres_SignatureWidth]  DEFAULT ((0)),
	[SignatureHeight] [int] NOT NULL CONSTRAINT [DF_Centres_SignatureHeight]  DEFAULT ((0)),
	[Invite] [int] NOT NULL CONSTRAINT [DF_Centres_Invite]  DEFAULT ((1)),
	[BannerText] [varchar](250) NULL,
	[F1Name] [varchar](250) NULL,
	[F1Mandatory] [bit] NOT NULL CONSTRAINT [DF__Centres__F1Manda__4D5F7D71]  DEFAULT ((0)),
	[F1Options] [nvarchar](max) NULL,
	[F2Name] [varchar](250) NULL,
	[F2Mandatory] [bit] NOT NULL CONSTRAINT [DF__Centres__F2Manda__4E53A1AA]  DEFAULT ((0)),
	[F2Options] [nvarchar](max) NULL,
	[F3Name] [varchar](250) NULL,
	[F3Mandatory] [bit] NOT NULL CONSTRAINT [DF__Centres__F3Manda__4F47C5E3]  DEFAULT ((0)),
	[F3Options] [nvarchar](max) NULL,
	[LastChecked] [date] NOT NULL CONSTRAINT [DF_Centres_LastChecked]  DEFAULT (dateadd(month,(-3),getutcdate())),
	[Long] [float] NULL,
	[Lat] [float] NULL,
	[IPPrefix] [nvarchar](20) NULL CONSTRAINT [DF_Centres_IPPrefix]  DEFAULT ('194.176.105'),
	[pwTelephone] [nvarchar](100) NULL,
	[pwEmail] [nvarchar](100) NULL,
	[pwPostCode] [nvarchar](10) NULL,
	[pwHours] [nvarchar](100) NULL,
	[pwWebURL] [nvarchar](100) NULL,
	[pwTrustsCovered] [nvarchar](max) NULL,
	[pwTrainingLocations] [nvarchar](max) NULL,
	[pwGeneralInfo] [nvarchar](max) NULL,
	[CentreLogo] [image] NULL,
	[LogoWidth] [int] NULL CONSTRAINT [DF_Centres_LogoWidth]  DEFAULT ((0)),
	[LogoHeight] [int] NULL CONSTRAINT [DF_Centres_LogoHeight]  DEFAULT ((0)),
	[pwOffice03] [bit] NOT NULL CONSTRAINT [DF_Centres_pwOffice03]  DEFAULT ((0)),
	[pwOffice07] [bit] NOT NULL CONSTRAINT [DF_Centres_pwOffice07]  DEFAULT ((0)),
	[pwOffice10] [bit] NOT NULL CONSTRAINT [DF_Centres_pwOffice10]  DEFAULT ((0)),
	[pwExternalCandidates] [bit] NOT NULL CONSTRAINT [DF_Centres_pwExternalCandidates]  DEFAULT ((0)),
	[pwChargeExternals] [bit] NOT NULL CONSTRAINT [DF_Centres_pwChargeExternals]  DEFAULT ((0)),
	[pwClassroomDelivery] [bit] NOT NULL CONSTRAINT [DF_Centres_pwClassroomDelivery]  DEFAULT ((0)),
	[pwWorkshopDelivery] [bit] NOT NULL CONSTRAINT [DF_Centres_pwWorkshopDelivery]  DEFAULT ((0)),
	[pwElearningDelivery] [bit] NOT NULL CONSTRAINT [DF_Centres_pwElearningDelivery]  DEFAULT ((0)),
	[pwSelfStudyDelivery] [bit] NOT NULL CONSTRAINT [DF_Centres_pwSelfStudyDelivery]  DEFAULT ((0)),
	[pwOfficialExams] [bit] NOT NULL CONSTRAINT [DF_Centres_pwOfficialExams]  DEFAULT ((0)),
	[LogoMimeType] [varchar](50) NOT NULL CONSTRAINT [DF_Centres_LogoMimeType]  DEFAULT (''),
	[Deleted] [bit] NOT NULL CONSTRAINT [DF_Centres_Deleted]  DEFAULT ((0)),
	[CentreCreated] [datetime] NOT NULL CONSTRAINT [DF_Centres_CentreCreated]  DEFAULT (getutcdate()),
	[BetaTesting] [bit] NOT NULL CONSTRAINT [DF__Centres__BetaTes__6CA31EA0]  DEFAULT ((0)),
	[CentreTypeID] [int] NOT NULL CONSTRAINT [DF__Centres__CentreT__2882FE7D]  DEFAULT ((1)),
	[NotifyEmail] [varchar](250) NULL,
	[kbPassword] [nvarchar](12) NULL,
	[kbLoginPrompt] [nvarchar](50) NULL,
	[kbSelfRegister] [bit] NOT NULL CONSTRAINT [DF__Centres__kbSelfR__5649C92D]  DEFAULT ((1)),
	[kbContact] [nvarchar](50) NULL,
	[kbYouTube] [bit] NOT NULL CONSTRAINT [DF__Centres__kbYouTu__573DED66]  DEFAULT ((0)),
	[kbDefaultOfficeVersion] [int] NOT NULL CONSTRAINT [DF__Centres__kbDefau__5832119F]  DEFAULT ((0)),
	[CustomField1PromptID] [int] NOT NULL CONSTRAINT [DF_Centres_CustomField1PromptID]  DEFAULT ((0)),
	[CustomField2PromptID] [int] NOT NULL CONSTRAINT [DF_Centres_CustomField2PromptID]  DEFAULT ((0)),
	[CustomField3PromptID] [int] NOT NULL CONSTRAINT [DF_Centres_CustomField3PromptID]  DEFAULT ((0)),
 CONSTRAINT [PK_Centres] PRIMARY KEY CLUSTERED 
(
	[CentreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Centres]  WITH CHECK ADD  CONSTRAINT [FK_Centres_CentreTypes] FOREIGN KEY([CentreTypeID])
REFERENCES [dbo].[CentreTypes] ([CentreTypeID])
GO
ALTER TABLE [dbo].[Centres] CHECK CONSTRAINT [FK_Centres_CentreTypes]
GO
ALTER TABLE [dbo].[Centres]  WITH CHECK ADD  CONSTRAINT [FK_Centres_Regions] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Regions] ([RegionID])
GO
ALTER TABLE [dbo].[Centres] CHECK CONSTRAINT [FK_Centres_Regions]
GO
