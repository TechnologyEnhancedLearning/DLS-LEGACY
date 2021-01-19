USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminSessions](
	[AdminSessionID] [int] IDENTITY(1,1) NOT NULL,
	[AdminID] [int] NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[Duration] [int] NOT NULL CONSTRAINT [DF_AdminSessions_Duration]  DEFAULT ((0)),
	[Active] [bit] NOT NULL CONSTRAINT [DF_AdminSessions_Active]  DEFAULT ((1)),
 CONSTRAINT [PK_AdminSessions] PRIMARY KEY CLUSTERED 
(
	[AdminSessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[AdminSessions]  WITH CHECK ADD  CONSTRAINT [FK_AdminSessions_AdminUsers] FOREIGN KEY([AdminID])
REFERENCES [dbo].[AdminUsers] ([AdminID])
GO
ALTER TABLE [dbo].[AdminSessions] CHECK CONSTRAINT [FK_AdminSessions_AdminUsers]
GO
