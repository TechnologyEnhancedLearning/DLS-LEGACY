USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAQs](
	[FAQID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_FAQs_CreatedDate]  DEFAULT (getutcdate()),
	[Weighting] [float] NOT NULL CONSTRAINT [DF_FAQs_Weighting]  DEFAULT ((100.0)),
	[QAnchor] [nvarchar](50) NOT NULL,
	[QText] [nvarchar](255) NOT NULL,
	[AHTML] [nvarchar](max) NOT NULL,
	[Published] [bit] NOT NULL CONSTRAINT [DF_FAQs_Published]  DEFAULT ((0)),
	[TargetGroup] [int] NOT NULL CONSTRAINT [DF_FAQs_TargetGroup]  DEFAULT ((0)),
 CONSTRAINT [PK_FAQs] PRIMARY KEY CLUSTERED 
(
	[FAQID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
