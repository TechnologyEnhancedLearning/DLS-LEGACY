USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomisationTutorials](
	[CusTutID] [int] IDENTITY(1,1) NOT NULL,
	[CustomisationID] [int] NOT NULL,
	[TutorialID] [int] NOT NULL,
	[Status] [bit] NOT NULL CONSTRAINT [DF_CustomisationTutorials_Status]  DEFAULT ((1)),
	[DiagStatus] [bit] NOT NULL CONSTRAINT [DF_CustomisationTutorials_DiagStatus]  DEFAULT ((1)),
 CONSTRAINT [PK_CustomisationTutorials] PRIMARY KEY CLUSTERED 
(
	[CusTutID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
