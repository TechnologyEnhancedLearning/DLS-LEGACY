USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LearningLogItems](
	[LearningLogItemID] [int] IDENTITY(1,1) NOT NULL,
	[LoggedDate] [datetime] NOT NULL,
	[LoggedByID] [int] NOT NULL,
	[DueDate] [datetime] NULL,
	[CompletedDate] [datetime] NULL,
	[DurationMins] [int] NOT NULL,
	[MethodID] [int] NULL,
	[MethodOther] [nvarchar](255) NULL,
	[Topic] [nvarchar](255) NULL,
	[Outcomes] [nvarchar](max) NULL,
	[LinkedCustomisationID] [int] NOT NULL,
	[VerifiedByID] [int] NULL,
	[VerifierComments] [nvarchar](max) NULL,
	[ArchivedDate] [datetime] NULL,
	[ArchivedByID] [int] NULL,
	[ICSGUID] [uniqueidentifier] NOT NULL,
	[LoggedByAdminID] [int] NOT NULL,
	[AppointmentTypeID] [int] NOT NULL,
	[CallUri] [nvarchar](255) NULL,
	[SeqInt] [smallint] NULL,
 CONSTRAINT [PK_LearningLogItems] PRIMARY KEY CLUSTERED 
(
	[LearningLogItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LearningLogItems] ADD  CONSTRAINT [DF_LearningLogItems_LoggedDate]  DEFAULT (getdate()) FOR [LoggedDate]
GO
ALTER TABLE [dbo].[LearningLogItems] ADD  CONSTRAINT [DF_LearningLogItems_AddedByID]  DEFAULT ((0)) FOR [LoggedByID]
GO
ALTER TABLE [dbo].[LearningLogItems] ADD  CONSTRAINT [DF_LearningLogItems_DurationMins]  DEFAULT ((0)) FOR [DurationMins]
GO
ALTER TABLE [dbo].[LearningLogItems] ADD  CONSTRAINT [DF_LearningLogItems_LinkedCustomisationID]  DEFAULT ((0)) FOR [LinkedCustomisationID]
GO
ALTER TABLE [dbo].[LearningLogItems] ADD  CONSTRAINT [DF_LearningLogItems_GUID]  DEFAULT (newid()) FOR [ICSGUID]
GO
ALTER TABLE [dbo].[LearningLogItems] ADD  CONSTRAINT [DF_LearningLogItems_LoggedByAdminID]  DEFAULT ((0)) FOR [LoggedByAdminID]
GO
ALTER TABLE [dbo].[LearningLogItems] ADD  CONSTRAINT [DF_LearningLogItems_AppointmentTypeID]  DEFAULT ((6)) FOR [AppointmentTypeID]
GO
ALTER TABLE [dbo].[LearningLogItems] ADD  CONSTRAINT [DF_LearningLogItems_SeqInt]  DEFAULT ((0)) FOR [SeqInt]
GO
ALTER TABLE [dbo].[LearningLogItems]  WITH CHECK ADD  CONSTRAINT [FK_LearningLogItems_AdminUsers] FOREIGN KEY([AppointmentTypeID])
REFERENCES [dbo].[AppointmentTypes] ([ApptTypeID])
GO
ALTER TABLE [dbo].[LearningLogItems] CHECK CONSTRAINT [FK_LearningLogItems_AdminUsers]
GO
ALTER TABLE [dbo].[LearningLogItems]  WITH CHECK ADD  CONSTRAINT [FK_LearningLogItems_Methods] FOREIGN KEY([MethodID])
REFERENCES [dbo].[Methods] ([MethodID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[LearningLogItems] CHECK CONSTRAINT [FK_LearningLogItems_Methods]
GO
