USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TicketComments](
	[TicketCommentID] [int] IDENTITY(1,1) NOT NULL,
	[TicketID] [int] NOT NULL,
	[TCDate] [datetime] NOT NULL CONSTRAINT [DF_TicketComments_TCDate]  DEFAULT (getutcdate()),
	[TCText] [nvarchar](max) NOT NULL,
	[TCActive] [bit] NOT NULL CONSTRAINT [DF_TicketComments_TCActive]  DEFAULT ((1)),
	[TCAdminUserID] [int] NOT NULL,
	[TCAttachment] [varbinary](max) NULL,
 CONSTRAINT [PK_TicketComments] PRIMARY KEY CLUSTERED 
(
	[TicketCommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TicketComments]  WITH CHECK ADD  CONSTRAINT [FK_TicketComments_AdminUsers] FOREIGN KEY([TCAdminUserID])
REFERENCES [dbo].[AdminUsers] ([AdminID])
GO
ALTER TABLE [dbo].[TicketComments] CHECK CONSTRAINT [FK_TicketComments_AdminUsers]
GO
ALTER TABLE [dbo].[TicketComments]  WITH CHECK ADD  CONSTRAINT [FK_TicketComments_Tickets] FOREIGN KEY([TicketID])
REFERENCES [dbo].[Tickets] ([TicketID])
GO
ALTER TABLE [dbo].[TicketComments] CHECK CONSTRAINT [FK_TicketComments_Tickets]
GO
