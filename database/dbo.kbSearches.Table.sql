USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[kbSearches](
	[kbSearchID] [int] IDENTITY(1,1) NOT NULL,
	[CandidateID] [int] NOT NULL,
	[OfficeVersionCSV] [varchar](30) NULL,
	[ApplicationCSV] [varchar](30) NULL,
	[ApplicationGroupCSV] [varchar](30) NULL,
	[SearchTerm] [varchar](255) NULL,
	[Inadequate] [bit] NOT NULL CONSTRAINT [DF_kbSearches_Inadequate]  DEFAULT ((0)),
	[SearchDate] [datetime] NOT NULL CONSTRAINT [DF_kbSearches_SearchDate]  DEFAULT (getutcdate()),
 CONSTRAINT [PK_kbSearches] PRIMARY KEY CLUSTERED 
(
	[kbSearchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
