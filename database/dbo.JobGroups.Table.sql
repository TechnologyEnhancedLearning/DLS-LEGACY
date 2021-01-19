USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobGroups](
	[JobGroupID] [int] IDENTITY(1,1) NOT NULL,
	[JobGroupName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_JobGroups] PRIMARY KEY CLUSTERED 
(
	[JobGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
