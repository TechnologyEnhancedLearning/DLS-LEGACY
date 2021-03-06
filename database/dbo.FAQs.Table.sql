USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAQs](
	[FAQID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Weighting] [float] NOT NULL,
	[QAnchor] [nvarchar](50) NOT NULL,
	[QText] [nvarchar](255) NOT NULL,
	[AHTML] [nvarchar](max) NOT NULL,
	[Published] [bit] NOT NULL,
	[TargetGroup] [int] NOT NULL,
	[ShortAHTML] [nvarchar](max) NULL,
 CONSTRAINT [PK_FAQs] PRIMARY KEY CLUSTERED 
(
	[FAQID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[FAQs] ADD  CONSTRAINT [DF_FAQs_CreatedDate]  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[FAQs] ADD  CONSTRAINT [DF_FAQs_Weighting]  DEFAULT ((100.0)) FOR [Weighting]
GO
ALTER TABLE [dbo].[FAQs] ADD  CONSTRAINT [DF_FAQs_Published]  DEFAULT ((0)) FOR [Published]
GO
ALTER TABLE [dbo].[FAQs] ADD  CONSTRAINT [DF_FAQs_TargetGroup]  DEFAULT ((0)) FOR [TargetGroup]
GO
