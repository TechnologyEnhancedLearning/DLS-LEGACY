USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kbSearches](
	[kbSearchID] [int] IDENTITY(1,1) NOT NULL,
	[CandidateID] [int] NOT NULL,
	[OfficeVersionCSV] [varchar](30) NULL,
	[ApplicationCSV] [varchar](30) NULL,
	[ApplicationGroupCSV] [varchar](30) NULL,
	[SearchTerm] [varchar](255) NULL,
	[Inadequate] [bit] NOT NULL,
	[SearchDate] [datetime] NOT NULL,
	[BrandCSV] [varchar](30) NULL,
	[CategoryCSV] [varchar](80) NULL,
	[TopicCSV] [varchar](180) NULL,
 CONSTRAINT [PK_kbSearches] PRIMARY KEY CLUSTERED 
(
	[kbSearchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[kbSearches] ADD  CONSTRAINT [DF_kbSearches_Inadequate]  DEFAULT ((0)) FOR [Inadequate]
GO
ALTER TABLE [dbo].[kbSearches] ADD  CONSTRAINT [DF_kbSearches_SearchDate]  DEFAULT (getutcdate()) FOR [SearchDate]
GO
