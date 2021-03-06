USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LearningLogItemTutorials](
	[LearningLogItemTutorialID] [int] IDENTITY(1,1) NOT NULL,
	[LearningLogItemID] [int] NOT NULL,
	[TutorialID] [int] NOT NULL,
	[AssociatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_LearningLogItemTutorials] PRIMARY KEY CLUSTERED 
(
	[LearningLogItemTutorialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LearningLogItemTutorials] ADD  CONSTRAINT [DF_LearningLogItemTutorials_AssociatedDate]  DEFAULT (getutcdate()) FOR [AssociatedDate]
GO
