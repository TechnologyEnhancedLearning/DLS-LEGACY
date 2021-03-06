USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Hugh Gibson
-- Create date: 27/07/2010
-- Description:	This function returns a table of months from today going back 6 months
-- =============================================

CREATE FUNCTION [dbo].[GetMonthTable]
(
	@PeriodCount Integer
)
RETURNS @PeriodTable TABLE 
(
	PeriodStart DateTime,
	PeriodEnd DateTime
)

AS	  
BEGIN
	Declare @_MonthStart DateTime

	Set @_MonthStart = GetUTCDate()
	Set @_MonthStart = CAST(FLOOR(CAST(@_MonthStart AS DECIMAL(12, 5))) - (DAY(@_MonthStart) - 1) AS DATETIME)
	
	While (@PeriodCount > 0)
		Begin
			INSERT INTO @PeriodTable VALUES (DateAdd(Month, 1 - @PeriodCount, @_MonthStart), DateAdd(Month, 2 - @PeriodCount, @_MonthStart))
			Set @PeriodCount = @PeriodCount - 1
		End

	Return
END

GO
