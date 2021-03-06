USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupDelegates](
	[GroupDelegateID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[DelegateID] [int] NOT NULL,
	[AddedDate] [datetime] NOT NULL,
	[AddedByFieldLink] [bit] NOT NULL,
 CONSTRAINT [PK_GroupDelegates] PRIMARY KEY CLUSTERED 
(
	[GroupDelegateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GroupDelegates] ADD  CONSTRAINT [DF_GroupDelegates_AddedDate]  DEFAULT (getutcdate()) FOR [AddedDate]
GO
ALTER TABLE [dbo].[GroupDelegates] ADD  CONSTRAINT [DF_GroupDelegates_AddedByFieldLink]  DEFAULT ((1)) FOR [AddedByFieldLink]
GO
ALTER TABLE [dbo].[GroupDelegates]  WITH NOCHECK ADD  CONSTRAINT [FK_GroupDelegates_Candidates] FOREIGN KEY([DelegateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GroupDelegates] NOCHECK CONSTRAINT [FK_GroupDelegates_Candidates]
GO
ALTER TABLE [dbo].[GroupDelegates]  WITH CHECK ADD  CONSTRAINT [FK_GroupDelegates_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([GroupID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GroupDelegates] CHECK CONSTRAINT [FK_GroupDelegates_Groups]
GO
