USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationGroups](
	[AppGroupID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationGroup] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_ApplicationGroups] PRIMARY KEY CLUSTERED 
(
	[AppGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ApplicationGroups]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationGroups_ApplicationGroups] FOREIGN KEY([AppGroupID])
REFERENCES [dbo].[ApplicationGroups] ([AppGroupID])
GO
ALTER TABLE [dbo].[ApplicationGroups] CHECK CONSTRAINT [FK_ApplicationGroups_ApplicationGroups]
GO
