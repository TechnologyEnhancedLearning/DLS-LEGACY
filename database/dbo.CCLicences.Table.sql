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
	[Active] [bit] NOT NULL,
	[ActivatedDate] [datetime] NULL,
	[ActivationCount] [int] NOT NULL,
	[ActivationLimit] [int] NOT NULL,
	[LatestVersionInstalled] [nvarchar](15) NULL,
 CONSTRAINT [PK_CCLicences] PRIMARY KEY CLUSTERED 
(
	[LicenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CCLicences] ADD  CONSTRAINT [DF_CCLicences_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[CCLicences] ADD  CONSTRAINT [DF_CCLicences_ActivationCount]  DEFAULT ((0)) FOR [ActivationCount]
GO
ALTER TABLE [dbo].[CCLicences] ADD  CONSTRAINT [DF_CCLicences_ActivationLimit]  DEFAULT ((3)) FOR [ActivationLimit]
GO
