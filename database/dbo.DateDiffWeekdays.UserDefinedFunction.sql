USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 05/04/2013
-- Description:	Return the difference between two dates, weekdays only.
-- =============================================
CREATE FUNCTION [dbo].[DateDiffWeekdays]
(
	@StartDate datetime,
	@EndDate datetime
)
RETURNS Int
AS
BEGIN
	Return (SELECT
   (DATEDIFF(dd, @StartDate, @EndDate) + 1)
  -(DATEDIFF(wk, @StartDate, @EndDate) * 2)
  -(CASE WHEN DATENAME(dw, @StartDate) = 'Sunday' THEN 1 ELSE 0 END)
  -(CASE WHEN DATENAME(dw, @EndDate) = 'Saturday' THEN 1 ELSE 0 END)-1)
END

GO
