USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdminUsers](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](250) NOT NULL,
	[Password] [varchar](250) NOT NULL,
	[CentreID] [int] NOT NULL,
	[CentreAdmin] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_CentreAdmin]  DEFAULT ((0)),
	[ConfigAdmin] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_ConfigAdmin]  DEFAULT ((0)),
	[SummaryReports] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_SummaryReports]  DEFAULT ((0)),
	[UserAdmin] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_UserAdmin]  DEFAULT ((0)),
	[Forename] [varchar](250) NOT NULL CONSTRAINT [DF_AdminUsers_Forename]  DEFAULT (''),
	[Surname] [varchar](250) NOT NULL CONSTRAINT [DF_AdminUsers_Surname]  DEFAULT (''),
	[Email] [varchar](250) NULL,
	[IsCentreManager] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_CentreManager]  DEFAULT ((0)),
	[Approved] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_Approved]  DEFAULT ((0)),
	[PasswordReminder] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_PasswordReminder]  DEFAULT ((0)),
	[EITSProfile] [varchar](max) NOT NULL DEFAULT (''),
	[PasswordReminderHash] [varchar](64) NULL,
	[PasswordReminderDate] [datetime] NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_Active]  DEFAULT ((1)),
	[ContentManager] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_ContentManager]  DEFAULT ((0)),
	[PublishToAll] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_PublishToAll]  DEFAULT ((0)),
	[ImportOnly] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_ImportOnly]  DEFAULT ((0)),
	[TCAgreed] [datetime] NULL CONSTRAINT [DF_AdminUsers_TCAgreed]  DEFAULT (getutcdate()),
	[ContentCreator] [bit] NOT NULL CONSTRAINT [DF_AdminUsers_ContentCreator]  DEFAULT ((0)),
	[FailedLoginCount] [int] NOT NULL CONSTRAINT [DF_AdminUsers_FailedLoginCount]  DEFAULT ((0)),
	[ProfileImage] [image] NULL,
 CONSTRAINT [PK_AdminUsers] PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[AdminUsers]  WITH CHECK ADD  CONSTRAINT [FK_AdminUsers_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[AdminUsers] CHECK CONSTRAINT [FK_AdminUsers_Centres]
GO
