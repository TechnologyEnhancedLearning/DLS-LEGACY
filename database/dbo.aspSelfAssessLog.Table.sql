USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspSelfAssessLog](
	[SelfAssessLogID] [int] IDENTITY(1,1) NOT NULL,
	[aspProgressID] [int] NOT NULL,
	[AssessDescriptorID] [int] NOT NULL,
	[OutcomesEvidence] [nvarchar](max) NULL,
	[SupervisorVerifiedID] [int] NULL,
	[SupervisorVerifiedDate] [datetime] NULL,
	[SupervisorOutcome] [bit] NULL,
	[SupervisorVerifiedComments] [nvarchar](max) NULL,
	[LastReviewed] [datetime] NULL,
	[ReviewedByCandidateID] [int] NOT NULL,
 CONSTRAINT [PK_aspSelfAssessLog] PRIMARY KEY CLUSTERED 
(
	[SelfAssessLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspSelfAssessLog] ADD  CONSTRAINT [DF_aspSelfAssessLog_TutStat]  DEFAULT ((0)) FOR [AssessDescriptorID]
GO
ALTER TABLE [dbo].[aspSelfAssessLog] ADD  CONSTRAINT [DF_aspSelfAssessLog_ReviewedByCandidateID]  DEFAULT ((0)) FOR [ReviewedByCandidateID]
GO
