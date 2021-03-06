USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoursePrompts](
	[CoursePromptID] [int] IDENTITY(1,1) NOT NULL,
	[CoursePrompt] [nvarchar](100) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_CoursePrompts] PRIMARY KEY CLUSTERED 
(
	[CoursePromptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CoursePrompts] ADD  CONSTRAINT [DF_CoursePrompts_Active]  DEFAULT ((1)) FOR [Active]
GO
