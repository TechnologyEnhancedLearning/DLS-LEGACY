USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilteredSectorsMapping](
	[JobGroupID] [int] NOT NULL,
	[SectorID] [int] NOT NULL,
 CONSTRAINT [PK_FilteredSectorsMapping] PRIMARY KEY CLUSTERED 
(
	[JobGroupID] ASC,
	[SectorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FilteredSectorsMapping]  WITH CHECK ADD  CONSTRAINT [FK_FilteredSectorsMapping_JobGroupID_JobGroups_JobGroupID] FOREIGN KEY([JobGroupID])
REFERENCES [dbo].[JobGroups] ([JobGroupID])
GO
ALTER TABLE [dbo].[FilteredSectorsMapping] CHECK CONSTRAINT [FK_FilteredSectorsMapping_JobGroupID_JobGroups_JobGroupID]
GO
