USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kbVideoTrack](
	[kbVideoTrackID] [int] IDENTITY(1,1) NOT NULL,
	[TutorialID] [int] NOT NULL,
	[CandidateID] [int] NOT NULL,
	[VideoClickedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tKBVideoTrack] PRIMARY KEY CLUSTERED 
(
	[kbVideoTrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[kbVideoTrack] ADD  CONSTRAINT [DF_Table_1_VideoClickDate]  DEFAULT (getutcdate()) FOR [VideoClickedDate]
GO
ALTER TABLE [dbo].[kbVideoTrack]  WITH CHECK ADD  CONSTRAINT [FK_tKBVideoTrack_Candidates] FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
GO
ALTER TABLE [dbo].[kbVideoTrack] CHECK CONSTRAINT [FK_tKBVideoTrack_Candidates]
GO
ALTER TABLE [dbo].[kbVideoTrack]  WITH CHECK ADD  CONSTRAINT [FK_tKBVideoTrack_Tutorials] FOREIGN KEY([TutorialID])
REFERENCES [dbo].[Tutorials] ([TutorialID])
GO
ALTER TABLE [dbo].[kbVideoTrack] CHECK CONSTRAINT [FK_tKBVideoTrack_Tutorials]
GO
