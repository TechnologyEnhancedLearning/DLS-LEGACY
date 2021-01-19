USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OfficeApplications](
	[OfficeAppID] [int] IDENTITY(1,1) NOT NULL,
	[OfficeApplication] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_OfficeApplications_Active]  DEFAULT ((1)),
	[ImgURL] [nvarchar](255) NULL,
 CONSTRAINT [PK_OfficeApplications] PRIMARY KEY CLUSTERED 
(
	[OfficeAppID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
