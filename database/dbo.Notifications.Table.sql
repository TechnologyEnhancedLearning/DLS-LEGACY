USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[NotificationName] [varchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[AutoOptIn] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_isp_Notifications] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Notifications] ADD  CONSTRAINT [DF_isp_Notifications_AutoOptIn]  DEFAULT ((1)) FOR [AutoOptIn]
GO
ALTER TABLE [dbo].[Notifications] ADD  CONSTRAINT [DF_isp_Notifications_Active]  DEFAULT ((1)) FOR [Active]
GO
