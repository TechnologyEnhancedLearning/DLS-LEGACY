USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CentreID] [int] NOT NULL,
	[OrderNotes] [varchar](250) NULL,
	[OrderDate] [datetime] NOT NULL,
	[SentDate] [datetime] NULL,
	[OrderStatus] [int] NOT NULL,
	[DelName] [varchar](100) NULL,
	[DelAddress1] [varchar](100) NULL,
	[DelAddress2] [varchar](100) NULL,
	[DelAddress3] [varchar](100) NULL,
	[DelAddress4] [varchar](100) NULL,
	[DelPostcode] [varchar](10) NULL,
	[DelTownCity] [varchar](100) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_OrderDate]  DEFAULT (getutcdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_OrderStatus]  DEFAULT ((1)) FOR [OrderStatus]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Centres] FOREIGN KEY([CentreID])
REFERENCES [dbo].[Centres] ([CentreID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Centres]
GO
