USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Candidates](
	[CandidateID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL,
	[CentreID] [int] NOT NULL,
	[FirstName] [varchar](250) NULL,
	[LastName] [varchar](250) NOT NULL,
	[DateRegistered] [datetime] NOT NULL,
	[CandidateNumber] [varchar](250) NOT NULL,
	[JobGroupID] [int] NOT NULL,
	[Answer1] [varchar](100) NULL,
	[Answer2] [varchar](100) NULL,
	[Answer3] [varchar](100) NULL,
	[AliasID] [varchar](250) NULL,
	[Approved] [bit] NOT NULL,
	[EmailAddress] [nvarchar](255) NULL,
	[ExternalReg] [bit] NOT NULL,
	[SelfReg] [bit] NOT NULL,
	[Password] [nvarchar](250) NULL,
	[SkipPW] [bit] NOT NULL,
	[ResetHash] [nvarchar](255) NULL,
	[Answer4] [nvarchar](100) NULL,
	[Answer5] [nvarchar](100) NULL,
	[Answer6] [nvarchar](100) NULL,
	[SkypeHandle] [nvarchar](100) NULL,
	[PublicSkypeLink] [bit] NOT NULL,
	[ProfileImage] [image] NULL,
 CONSTRAINT [PK_Candidates] PRIMARY KEY CLUSTERED 
(
	[CandidateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Candidates] ADD  CONSTRAINT [DF_Candidates_Status]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Candidates] ADD  CONSTRAINT [DF_Candidates_JobGroupID]  DEFAULT ((1)) FOR [JobGroupID]
GO
ALTER TABLE [dbo].[Candidates] ADD  CONSTRAINT [DF_Candidates_Approved]  DEFAULT ((1)) FOR [Approved]
GO
ALTER TABLE [dbo].[Candidates] ADD  CONSTRAINT [DF_Candidates_ExternalReg]  DEFAULT ((0)) FOR [ExternalReg]
GO
ALTER TABLE [dbo].[Candidates] ADD  CONSTRAINT [DF_Candidates_SelfReg]  DEFAULT ((0)) FOR [SelfReg]
GO
ALTER TABLE [dbo].[Candidates] ADD  CONSTRAINT [DF_Candidates_SkipPW]  DEFAULT ((0)) FOR [SkipPW]
GO
ALTER TABLE [dbo].[Candidates] ADD  CONSTRAINT [DF_Candidates_PublicSkypeLink]  DEFAULT ((0)) FOR [PublicSkypeLink]
GO
ALTER TABLE [dbo].[Candidates]  WITH CHECK ADD  CONSTRAINT [FK_Candidates_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[Candidates] CHECK CONSTRAINT [FK_Candidates_Centres]
GO
ALTER TABLE [dbo].[Candidates]  WITH CHECK ADD  CONSTRAINT [FK_Candidates_JobGroups] FOREIGN KEY([JobGroupID])
REFERENCES [dbo].[JobGroups] ([JobGroupID])
GO
ALTER TABLE [dbo].[Candidates] CHECK CONSTRAINT [FK_Candidates_JobGroups]
GO
