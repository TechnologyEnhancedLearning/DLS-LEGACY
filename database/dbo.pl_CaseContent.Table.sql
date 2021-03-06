USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pl_CaseContent](
	[CaseContentID] [int] IDENTITY(1,1) NOT NULL,
	[CaseStudyID] [int] NOT NULL,
	[ContentHeading] [nvarchar](100) NULL,
	[ContentText] [nvarchar](max) NULL,
	[ContentImage] [image] NULL,
	[ContentQuoteText] [nvarchar](max) NULL,
	[ContentQuoteAttr] [nvarchar](100) NULL,
	[OrderByNumber] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[ImageWidth] [int] NOT NULL,
 CONSTRAINT [PK_pl_CaseContent] PRIMARY KEY CLUSTERED 
(
	[CaseContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[pl_CaseContent] ADD  CONSTRAINT [DF_pl_CaseContent_OrderByNumber]  DEFAULT ((0)) FOR [OrderByNumber]
GO
ALTER TABLE [dbo].[pl_CaseContent] ADD  CONSTRAINT [DF_pl_CaseContent_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[pl_CaseContent] ADD  CONSTRAINT [DF_pl_CaseContent_ImageWidth]  DEFAULT ((33)) FOR [ImageWidth]
GO
ALTER TABLE [dbo].[pl_CaseContent]  WITH CHECK ADD  CONSTRAINT [FK_pl_CaseContent_pl_CaseStudies] FOREIGN KEY([CaseStudyID])
REFERENCES [dbo].[pl_CaseStudies] ([CaseStudyID])
GO
ALTER TABLE [dbo].[pl_CaseContent] CHECK CONSTRAINT [FK_pl_CaseContent_pl_CaseStudies]
GO
