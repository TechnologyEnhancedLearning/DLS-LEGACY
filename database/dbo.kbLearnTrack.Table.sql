USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kbLearnTrack](
	[kbLearnTrackID] [int] IDENTITY(1,1) NOT NULL,
	[TutorialID] [int] NOT NULL,
	[CandidateID] [int] NOT NULL,
	[LaunchDate] [datetime] NOT NULL,
 CONSTRAINT [PK_kbLearnTrack] PRIMARY KEY CLUSTERED 
(
	[kbLearnTrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[kbLearnTrack] ADD  CONSTRAINT [DF_kbLearnTrack_LaunchDate]  DEFAULT (getutcdate()) FOR [LaunchDate]
GO
