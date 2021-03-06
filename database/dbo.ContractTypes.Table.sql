USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContractTypes](
	[ContractTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ContractType] [nvarchar](50) NOT NULL,
	[ContractDescription] [nvarchar](100) NOT NULL,
	[TSAccess] [bit] NOT NULL,
	[Administrators] [int] NOT NULL,
	[Trainers] [int] NOT NULL,
	[Learners] [int] NOT NULL,
	[CMSAdministratorsInc] [int] NOT NULL,
	[CMSManagersInc] [int] NOT NULL,
	[CustomCoursesInc] [int] NOT NULL,
	[ServerSpaceBytesInc] [bigint] NOT NULL,
	[CCLicencesInc] [int] NOT NULL,
	[WebinarSupportHours] [int] NOT NULL,
	[FaceToFaceSupportDays] [int] NOT NULL,
	[TechnicalSupport] [bit] NOT NULL,
	[LearnerSupport] [bit] NOT NULL,
	[AnnualCost] [int] NOT NULL,
	[SetupFee] [int] NOT NULL,
	[CategoriesLimit] [int] NOT NULL,
	[DelegateUploadSpace] [bigint] NOT NULL,
	[Supervisors] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_ContractTypes] PRIMARY KEY CLUSTERED 
(
	[ContractTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_TSAccess]  DEFAULT ((1)) FOR [TSAccess]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_Administrators]  DEFAULT ((-1)) FOR [Administrators]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_Trainers]  DEFAULT ((0)) FOR [Trainers]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_Learners]  DEFAULT ((-1)) FOR [Learners]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_Table_1_CMSAdministratorsIncluded]  DEFAULT ((5)) FOR [CMSAdministratorsInc]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_CMSManagersInc]  DEFAULT ((0)) FOR [CMSManagersInc]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_Table_1_ServerSpaceBytes]  DEFAULT ((0)) FOR [ServerSpaceBytesInc]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_CCLicencesInc]  DEFAULT ((0)) FOR [CCLicencesInc]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_WebinarSupportHours]  DEFAULT ((1)) FOR [WebinarSupportHours]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_FaceToFaceSupportDays]  DEFAULT ((0)) FOR [FaceToFaceSupportDays]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_TechnicalSupport]  DEFAULT ((1)) FOR [TechnicalSupport]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_LearnerSupport]  DEFAULT ((0)) FOR [LearnerSupport]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_AnnualCost]  DEFAULT ((0)) FOR [AnnualCost]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_SetupFee]  DEFAULT ((0)) FOR [SetupFee]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_CategoriesLimit]  DEFAULT ((0)) FOR [CategoriesLimit]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_DelegateUploadSpace]  DEFAULT ((0)) FOR [DelegateUploadSpace]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_Supervisors]  DEFAULT ((-1)) FOR [Supervisors]
GO
ALTER TABLE [dbo].[ContractTypes] ADD  CONSTRAINT [DF_ContractTypes_Active]  DEFAULT ((1)) FOR [Active]
GO
