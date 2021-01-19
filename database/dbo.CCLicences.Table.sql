USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CCLicences](
	[LicenceID] [int] IDENTITY(1,1) NOT NULL,
	[LicenceText] [nchar](18) NULL,
	[AssignedUserID] [int] NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_CCLicences_Active]  DEFAULT ((1)),
	[ActivatedDate] [datetime] NULL,
	[ActivationCount] [int] NOT NULL CONSTRAINT [DF_CCLicences_ActivationCount]  DEFAULT ((0)),
	[ActivationLimit] [int] NOT NULL CONSTRAINT [DF_CCLicences_Unlimited]  DEFAULT ((3)),
	[LatestVersionInstalled] [nvarchar](15) NOT NULL CONSTRAINT [DF_CCLicences_LatestVersionInstalled]  DEFAULT ((1.0)),
 CONSTRAINT [PK_CCLicences] PRIMARY KEY CLUSTERED 
(
	[LicenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
