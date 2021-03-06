USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreApplications](
	[CentreApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[CentreID] [int] NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_CentreApplications] PRIMARY KEY CLUSTERED 
(
	[CentreApplicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CentreApplications] ADD  CONSTRAINT [DF_CentreApplications_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[CentreApplications]  WITH CHECK ADD  CONSTRAINT [FK_CentreApplications_Applications] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[CentreApplications] CHECK CONSTRAINT [FK_CentreApplications_Applications]
GO
ALTER TABLE [dbo].[CentreApplications]  WITH CHECK ADD  CONSTRAINT [FK_CentreApplications_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[CentreApplications] CHECK CONSTRAINT [FK_CentreApplications_Centres]
GO
