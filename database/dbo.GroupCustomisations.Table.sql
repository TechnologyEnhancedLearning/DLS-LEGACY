USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupCustomisations](
	[GroupCustomisationID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[CustomisationID] [int] NOT NULL,
	[AddedDate] [datetime] NOT NULL,
	[AddedByAdminUserID] [int] NOT NULL,
	[CompleteWithinMonths] [int] NOT NULL,
	[InactivatedDate] [datetime] NULL,
	[CohortLearners] [bit] NOT NULL,
	[SupervisorAdminID] [int] NULL,
 CONSTRAINT [PK_GroupCustomisations] PRIMARY KEY CLUSTERED 
(
	[GroupCustomisationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GroupCustomisations] ADD  CONSTRAINT [DF_GroupCustomisations_AddedDate]  DEFAULT (getutcdate()) FOR [AddedDate]
GO
ALTER TABLE [dbo].[GroupCustomisations] ADD  CONSTRAINT [DF_GroupCustomisations_CompleteWithinMonths]  DEFAULT ((0)) FOR [CompleteWithinMonths]
GO
ALTER TABLE [dbo].[GroupCustomisations] ADD  CONSTRAINT [DF_GroupCustomisations_CohortLearners]  DEFAULT ((0)) FOR [CohortLearners]
GO
ALTER TABLE [dbo].[GroupCustomisations]  WITH CHECK ADD  CONSTRAINT [FK_GroupCustomisations_AdminUsers] FOREIGN KEY([AddedByAdminUserID])
REFERENCES [dbo].[AdminUsers] ([AdminID])
GO
ALTER TABLE [dbo].[GroupCustomisations] CHECK CONSTRAINT [FK_GroupCustomisations_AdminUsers]
GO
ALTER TABLE [dbo].[GroupCustomisations]  WITH CHECK ADD  CONSTRAINT [FK_GroupCustomisations_Customisations] FOREIGN KEY([CustomisationID])
REFERENCES [dbo].[Customisations] ([CustomisationID])
GO
ALTER TABLE [dbo].[GroupCustomisations] CHECK CONSTRAINT [FK_GroupCustomisations_Customisations]
GO
ALTER TABLE [dbo].[GroupCustomisations]  WITH CHECK ADD  CONSTRAINT [FK_GroupCustomisations_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([GroupID])
GO
ALTER TABLE [dbo].[GroupCustomisations] CHECK CONSTRAINT [FK_GroupCustomisations_Groups]
GO
