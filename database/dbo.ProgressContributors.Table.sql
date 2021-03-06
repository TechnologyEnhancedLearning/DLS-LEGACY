USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgressContributors](
	[ProgressContributorID] [int] IDENTITY(1,1) NOT NULL,
	[ProgressID] [int] NOT NULL,
	[CandidateID] [int] NOT NULL,
	[ContributorRoleID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[LastAccess] [datetime] NULL,
 CONSTRAINT [PK_ProgressContributors] PRIMARY KEY CLUSTERED 
(
	[ProgressContributorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProgressContributors] ADD  CONSTRAINT [DF_ProgressContributors_CandidateID]  DEFAULT ((0)) FOR [CandidateID]
GO
ALTER TABLE [dbo].[ProgressContributors] ADD  CONSTRAINT [DF_ProgressContributors_ContributorRoleID]  DEFAULT ((1)) FOR [ContributorRoleID]
GO
ALTER TABLE [dbo].[ProgressContributors] ADD  CONSTRAINT [DF_ProgressContributors_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ProgressContributors]  WITH CHECK ADD  CONSTRAINT [FK_ProgressContributors_Progress] FOREIGN KEY([ProgressID])
REFERENCES [dbo].[Progress] ([ProgressID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProgressContributors] CHECK CONSTRAINT [FK_ProgressContributors_Progress]
GO
