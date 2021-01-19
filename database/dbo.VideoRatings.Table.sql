USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VideoRatings](
	[VideoRatingID] [int] IDENTITY(1,1) NOT NULL,
	[TutorialID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[RateDate] [datetime] NOT NULL CONSTRAINT [DF_VideoRatings_RateDate]  DEFAULT (getutcdate()),
	[KBRate] [bit] NOT NULL CONSTRAINT [DF_VideoRatings_KBRate]  DEFAULT ((0)),
	[CentreID] [int] NOT NULL CONSTRAINT [DF_VideoRatings_CentreID]  DEFAULT ((0)),
 CONSTRAINT [PK_VideoRatings] PRIMARY KEY CLUSTERED 
(
	[VideoRatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[VideoRatings]  WITH CHECK ADD  CONSTRAINT [FK_VideoRatings_Tutorials] FOREIGN KEY([TutorialID])
REFERENCES [dbo].[Tutorials] ([TutorialID])
GO
ALTER TABLE [dbo].[VideoRatings] CHECK CONSTRAINT [FK_VideoRatings_Tutorials]
GO
