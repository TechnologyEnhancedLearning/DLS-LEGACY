USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssessmentTypes](
	[AssessmentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentType] [nvarchar](100) NOT NULL,
	[LayoutHZ] [bit] NOT NULL,
	[SelfAssessPrompt] [nvarchar](500) NULL,
	[IncludeComments] [bit] NOT NULL,
	[MandatoryComments] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AssessmentTypes] ADD  CONSTRAINT [DF_AssessmentTypes_LayoutHZ]  DEFAULT ((0)) FOR [LayoutHZ]
GO
ALTER TABLE [dbo].[AssessmentTypes] ADD  CONSTRAINT [DF_AssessmentTypes_IncludeComments]  DEFAULT ((1)) FOR [IncludeComments]
GO
ALTER TABLE [dbo].[AssessmentTypes] ADD  CONSTRAINT [DF_AssessmentTypes_MandatoryComments]  DEFAULT ((0)) FOR [MandatoryComments]
GO
