USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspProgressLearningLogItems](
	[LinkLearningLogID] [int] IDENTITY(1,1) NOT NULL,
	[aspProgressID] [int] NOT NULL,
	[LearningLogItemID] [int] NOT NULL,
 CONSTRAINT [PK_aspProgressLearningLogItems] PRIMARY KEY CLUSTERED 
(
	[LinkLearningLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspProgressLearningLogItems]  WITH CHECK ADD  CONSTRAINT [FK_aspProgressLearningLogItems_aspProgress] FOREIGN KEY([aspProgressID])
REFERENCES [dbo].[aspProgress] ([aspProgressID])
GO
ALTER TABLE [dbo].[aspProgressLearningLogItems] CHECK CONSTRAINT [FK_aspProgressLearningLogItems_aspProgress]
GO
