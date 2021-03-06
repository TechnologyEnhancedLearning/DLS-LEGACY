USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pwCaseStudies](
	[CaseStudyID] [int] IDENTITY(1,1) NOT NULL,
	[CaseStudyName] [nvarchar](100) NOT NULL,
	[CaseStudyDesc] [nvarchar](500) NOT NULL,
	[CaseStudyImage] [nvarchar](255) NULL,
	[CaseStudyURL] [nvarchar](255) NULL,
	[CaseStudyGroup] [nvarchar](100) NULL,
 CONSTRAINT [PK_pwCaseStudies] PRIMARY KEY CLUSTERED 
(
	[CaseStudyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
