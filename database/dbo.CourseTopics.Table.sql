USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseTopics](
	[CourseTopicID] [int] IDENTITY(1,1) NOT NULL,
	[CentreID] [int] NOT NULL,
	[CourseTopic] [nvarchar](100) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_CourseTopics] PRIMARY KEY CLUSTERED 
(
	[CourseTopicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CourseTopics] ADD  CONSTRAINT [DF_CourseTopics_CentreID]  DEFAULT ((0)) FOR [CentreID]
GO
ALTER TABLE [dbo].[CourseTopics] ADD  CONSTRAINT [DF_CourseTopics_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[CourseTopics]  WITH NOCHECK ADD  CONSTRAINT [FK_CourseTopics_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
ON UPDATE SET DEFAULT
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[CourseTopics] NOCHECK CONSTRAINT [FK_CourseTopics_Centres]
GO
