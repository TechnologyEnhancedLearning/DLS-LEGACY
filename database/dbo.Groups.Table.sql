USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[CentreID] [int] NOT NULL,
	[GroupLabel] [nvarchar](100) NOT NULL,
	[GroupDescription] [nvarchar](max) NULL,
	[LinkedToField] [int] NOT NULL,
	[SyncFieldChanges] [bit] NOT NULL,
	[AddNewRegistrants] [bit] NOT NULL,
	[PopulateExisting] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedByAdminUserID] [int] NOT NULL,
	[RemovedDate] [datetime] NULL,
	[RemovedByAdminUserID] [int] NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Table_1_LinkedTo]  DEFAULT ((0)) FOR [LinkedToField]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_SyncFieldChanges]  DEFAULT ((1)) FOR [SyncFieldChanges]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_AddNewRegistrants]  DEFAULT ((1)) FOR [AddNewRegistrants]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_PopulateExisting]  DEFAULT ((1)) FOR [PopulateExisting]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_CreatedDate]  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_AdminUsers] FOREIGN KEY([CreatedByAdminUserID])
REFERENCES [dbo].[AdminUsers] ([AdminID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_AdminUsers]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Centres]
GO
