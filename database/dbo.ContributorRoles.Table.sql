USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContributorRoles](
	[ContributorRoleID] [int] IDENTITY(1,1) NOT NULL,
	[ContributorRole] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ContributorRoles] PRIMARY KEY CLUSTERED 
(
	[ContributorRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
