USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentTypes](
	[ApptTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeLabel] [nvarchar](50) NOT NULL,
	[TypeCaption] [nvarchar](50) NULL,
	[Active] [bit] NOT NULL,
	[ColourString] [nvarchar](10) NOT NULL,
	[IconClass] [nvarchar](50) NULL,
	[BtnColourClass] [nvarchar](10) NOT NULL,
	[SchedulerOrderNum] [int] NOT NULL,
 CONSTRAINT [PK_AppointmentTypes] PRIMARY KEY CLUSTERED 
(
	[ApptTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AppointmentTypes] ADD  CONSTRAINT [DF_AppointmentTypes_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[AppointmentTypes] ADD  CONSTRAINT [DF_AppointmentTypes_ColourString]  DEFAULT ('#FFFFFF') FOR [ColourString]
GO
ALTER TABLE [dbo].[AppointmentTypes] ADD  CONSTRAINT [DF_AppointmentTypes_BtnColourClass]  DEFAULT (N'secondary') FOR [BtnColourClass]
GO
ALTER TABLE [dbo].[AppointmentTypes] ADD  CONSTRAINT [DF_AppointmentTypes_IncludeInScheduler]  DEFAULT ((1)) FOR [SchedulerOrderNum]
GO
