USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANotifications](
	[SANotificationID] [int] IDENTITY(1,1) NOT NULL,
	[SubjectLine] [nvarchar](100) NOT NULL,
	[BodyHTML] [nvarchar](max) NULL,
	[ExpiryDate] [datetime] NULL,
	[DateAdded] [datetime] NOT NULL,
	[TargetUserRoleID] [int] NOT NULL,
 CONSTRAINT [PK_SANotifications] PRIMARY KEY CLUSTERED 
(
	[SANotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SANotifications] ADD  CONSTRAINT [DF_SANotifications_DateAdded]  DEFAULT (getutcdate()) FOR [DateAdded]
GO
ALTER TABLE [dbo].[SANotifications] ADD  CONSTRAINT [DF_SANotifications_TargetUserRoleID]  DEFAULT ((1)) FOR [TargetUserRoleID]
GO
