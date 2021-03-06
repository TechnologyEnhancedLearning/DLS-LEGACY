USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssessmentTypeDescriptors](
	[AssessmentTypeDescriptorID] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentTypeID] [int] NOT NULL,
	[DescriptorText] [nvarchar](100) NOT NULL,
	[DescriptorDetail] [nvarchar](max) NULL,
	[WeightingScore] [int] NOT NULL,
 CONSTRAINT [PK_AssessmentTypeDescriptors] PRIMARY KEY CLUSTERED 
(
	[AssessmentTypeDescriptorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[AssessmentTypeDescriptors] ADD  CONSTRAINT [DF_AssessmentTypeDescriptors_WeightingScore]  DEFAULT ((1)) FOR [WeightingScore]
GO
