USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 25th October 2011
-- Description:	Gets tickets raised report data
-- =============================================
CREATE PROCEDURE [dbo].[uspTicketsOverTime]
	@PeriodType as Integer,
	@PeriodCount as Integer
AS
BEGIN
	SET NOCOUNT ON
	--
	-- Work out how far to go back
	--
	SELECT     PeriodStart, Tickets
FROM         (SELECT     m.PeriodStart, COUNT(Q1.RaisedDatePeriodStart) AS Tickets
                       FROM          dbo.tvfGetPeriodTable(@PeriodType, @PeriodCount) AS m LEFT OUTER JOIN
                                                  (SELECT     dbo.svfPeriodStart(@PeriodType, RaisedDate) AS RaisedDatePeriodStart
                                                    FROM          dbo.Tickets AS p) AS Q1 ON m.PeriodStart = Q1.RaisedDatePeriodStart
                       GROUP BY m.PeriodStart) AS Q2
END
GO
