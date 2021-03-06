USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminUsers](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](250) NULL,
	[Password] [varchar](250) NOT NULL,
	[CentreID] [int] NOT NULL,
	[CentreAdmin] [bit] NOT NULL,
	[ConfigAdmin] [bit] NOT NULL,
	[SummaryReports] [bit] NOT NULL,
	[UserAdmin] [bit] NOT NULL,
	[Forename] [varchar](250) NOT NULL,
	[Surname] [varchar](250) NOT NULL,
	[Email] [varchar](250) NULL,
	[IsCentreManager] [bit] NOT NULL,
	[Approved] [bit] NOT NULL,
	[PasswordReminder] [bit] NOT NULL,
	[EITSProfile] [varchar](max) NOT NULL,
	[PasswordReminderHash] [varchar](64) NULL,
	[PasswordReminderDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[ContentManager] [bit] NOT NULL,
	[PublishToAll] [bit] NOT NULL,
	[ImportOnly] [bit] NOT NULL,
	[TCAgreed] [datetime] NULL,
	[ContentCreator] [bit] NOT NULL,
	[FailedLoginCount] [int] NOT NULL,
	[ProfileImage] [image] NULL,
	[Supervisor] [bit] NOT NULL,
	[Trainer] [bit] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[SkypeHandle] [nvarchar](100) NULL,
	[PublicSkypeLink] [bit] NOT NULL,
 CONSTRAINT [PK_AdminUsers] PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_CentreAdmin]  DEFAULT ((0)) FOR [CentreAdmin]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_ConfigAdmin]  DEFAULT ((0)) FOR [ConfigAdmin]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_SummaryReports]  DEFAULT ((0)) FOR [SummaryReports]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_UserAdmin]  DEFAULT ((0)) FOR [UserAdmin]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_Forename]  DEFAULT ('') FOR [Forename]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_Surname]  DEFAULT ('') FOR [Surname]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_CentreManager]  DEFAULT ((0)) FOR [IsCentreManager]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_Approved]  DEFAULT ((0)) FOR [Approved]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_PasswordReminder]  DEFAULT ((0)) FOR [PasswordReminder]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF__AdminUser__EITSP__5224328E]  DEFAULT ('') FOR [EITSProfile]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_ContentManager]  DEFAULT ((0)) FOR [ContentManager]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_PublishToAll]  DEFAULT ((0)) FOR [PublishToAll]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_ImportOnly]  DEFAULT ((0)) FOR [ImportOnly]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_TCAgreed]  DEFAULT (getutcdate()) FOR [TCAgreed]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_ContentCreator]  DEFAULT ((0)) FOR [ContentCreator]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_FailedLoginCount]  DEFAULT ((0)) FOR [FailedLoginCount]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  DEFAULT ((0)) FOR [Supervisor]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  DEFAULT ((0)) FOR [Trainer]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  DEFAULT ((0)) FOR [CategoryID]
GO
ALTER TABLE [dbo].[AdminUsers] ADD  CONSTRAINT [DF_AdminUsers_PublicSkypeLink]  DEFAULT ((0)) FOR [PublicSkypeLink]
GO
ALTER TABLE [dbo].[AdminUsers]  WITH CHECK ADD  CONSTRAINT [FK_AdminUsers_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[AdminUsers] CHECK CONSTRAINT [FK_AdminUsers_Centres]
GO
