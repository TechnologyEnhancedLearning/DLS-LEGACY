USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssessAttempts](
	[AssessAttemptID] [int] IDENTITY(1,1) NOT NULL,
	[CandidateID] [int] NOT NULL,
	[CustomisationID] [int] NOT NULL,
	[CustomisationVersion] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[AssessInstance] [int] NOT NULL,
	[SectionNumber] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[ProgressID] [int] NOT NULL,
 CONSTRAINT [PK_AssessAttempts] PRIMARY KEY CLUSTERED 
(
	[AssessAttemptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AssessAttempts] ADD  DEFAULT ((0)) FOR [ProgressID]
GO
ALTER TABLE [dbo].[AssessAttempts]  WITH CHECK ADD  CONSTRAINT [FK_AssessAttempts_Candidates] FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
GO
ALTER TABLE [dbo].[AssessAttempts] CHECK CONSTRAINT [FK_AssessAttempts_Candidates]
GO
ALTER TABLE [dbo].[AssessAttempts]  WITH CHECK ADD  CONSTRAINT [FK_AssessAttempts_Customisations] FOREIGN KEY([CustomisationID])
REFERENCES [dbo].[Customisations] ([CustomisationID])
GO
ALTER TABLE [dbo].[AssessAttempts] CHECK CONSTRAINT [FK_AssessAttempts_Customisations]
GO
ALTER TABLE [dbo].[AssessAttempts]  WITH CHECK ADD  CONSTRAINT [FK_AssessAttempts_Progress] FOREIGN KEY([ProgressID])
REFERENCES [dbo].[Progress] ([ProgressID])
GO
ALTER TABLE [dbo].[AssessAttempts] CHECK CONSTRAINT [FK_AssessAttempts_Progress]
GO
