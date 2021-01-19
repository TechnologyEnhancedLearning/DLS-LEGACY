USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notifications](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[NotificationName] [varchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[AutoOptIn] [bit] NOT NULL CONSTRAINT [DF_isp_Notifications_AutoOptIn]  DEFAULT ((1)),
	[Active] [bit] NOT NULL CONSTRAINT [DF_isp_Notifications_Active]  DEFAULT ((1)),
 CONSTRAINT [PK_isp_Notifications] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
