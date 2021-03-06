USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[AdminUserID] [int] NOT NULL,
	[RaisedDate] [datetime] NOT NULL,
	[QuerySubject] [varchar](255) NOT NULL,
	[TStatusID] [int] NOT NULL,
	[AssignedToID] [int] NULL,
	[ArchivedDate] [datetime] NULL,
	[TicketTypeID] [int] NOT NULL,
	[TicketCategoryID] [int] NOT NULL,
	[BrowserID] [int] NOT NULL,
	[BrowserVersion] [nvarchar](10) NULL,
	[OperatingSystemID] [int] NOT NULL,
	[DeviceTypeID] [int] NOT NULL,
	[CourseID] [int] NULL,
	[DelegateID] [nvarchar](10) NULL,
	[CategoryOther] [nvarchar](50) NULL,
	[ResolveInDays] [int] NOT NULL,
	[ShockwaveInfo] [nvarchar](100) NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_RaisedDate]  DEFAULT (getutcdate()) FOR [RaisedDate]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_TStatusID]  DEFAULT ((1)) FOR [TStatusID]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_TicketTypeID]  DEFAULT ((1)) FOR [TicketTypeID]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_TicketCategoryID]  DEFAULT ((1)) FOR [TicketCategoryID]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_BrowserID]  DEFAULT ((1)) FOR [BrowserID]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_OperatingSystemID]  DEFAULT ((1)) FOR [OperatingSystemID]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_DeviceTypeID]  DEFAULT ((1)) FOR [DeviceTypeID]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_CourseID]  DEFAULT ((0)) FOR [CourseID]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_ResolveInDays]  DEFAULT ((7)) FOR [ResolveInDays]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_AdminUsers] FOREIGN KEY([AdminUserID])
REFERENCES [dbo].[AdminUsers] ([AdminID])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_AdminUsers]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_AdminUsers_AssignedToID] FOREIGN KEY([AssignedToID])
REFERENCES [dbo].[AdminUsers] ([AdminID])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_AdminUsers_AssignedToID]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_TicketStatus] FOREIGN KEY([TStatusID])
REFERENCES [dbo].[TicketStatus] ([TStatusID])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_TicketStatus]
GO
