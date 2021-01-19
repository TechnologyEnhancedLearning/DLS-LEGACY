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
	[LaunchDate] [datetime] NOT NULL CONSTRAINT [DF_kbLearnTrack_LaunchDate]  DEFAULT (getutcdate()),
 CONSTRAINT [PK_kbLearnTrack] PRIMARY KEY CLUSTERED 
(
	[kbLearnTrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
