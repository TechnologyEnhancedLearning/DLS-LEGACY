USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgressLearningLogItems](
	[LearningLogID] [int] IDENTITY(1,1) NOT NULL,
	[ProgressID] [int] NOT NULL,
	[LearningLogItemID] [int] NOT NULL,
 CONSTRAINT [PK_ProgressLearningLogItems] PRIMARY KEY CLUSTERED 
(
	[LearningLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProgressLearningLogItems]  WITH CHECK ADD  CONSTRAINT [FK_ProgressLearningLogItems_Progress] FOREIGN KEY([ProgressID])
REFERENCES [dbo].[Progress] ([ProgressID])
GO
ALTER TABLE [dbo].[ProgressLearningLogItems] CHECK CONSTRAINT [FK_ProgressLearningLogItems_Progress]
GO
