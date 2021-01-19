USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kbYouTubeTrack](
	[YouTubeTrackID] [int] IDENTITY(1,1) NOT NULL,
	[CandidateID] [int] NOT NULL,
	[YouTubeURL] [nvarchar](256) NOT NULL,
	[VidTitle] [nvarchar](100) NOT NULL,
	[LaunchDateTime] [datetime] NOT NULL CONSTRAINT [DF_kbYouTubeTrack_LaunchDateTime]  DEFAULT (getutcdate()),
 CONSTRAINT [PK_kbYouTubeTrack] PRIMARY KEY CLUSTERED 
(
	[YouTubeTrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
