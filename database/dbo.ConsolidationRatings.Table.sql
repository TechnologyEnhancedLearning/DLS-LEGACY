USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConsolidationRatings](
	[ConsolidationRatingID] [int] IDENTITY(1,1) NOT NULL,
	[SectionID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[RateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ConsolidationRatings] PRIMARY KEY CLUSTERED 
(
	[ConsolidationRatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsolidationRatings] ADD  CONSTRAINT [DF_ConsolidationRatings_RateDate]  DEFAULT (getutcdate()) FOR [RateDate]
GO
ALTER TABLE [dbo].[ConsolidationRatings]  WITH CHECK ADD  CONSTRAINT [FK_ConsolidationRatings_Sections] FOREIGN KEY([SectionID])
REFERENCES [dbo].[Sections] ([SectionID])
GO
ALTER TABLE [dbo].[ConsolidationRatings] CHECK CONSTRAINT [FK_ConsolidationRatings_Sections]
GO
