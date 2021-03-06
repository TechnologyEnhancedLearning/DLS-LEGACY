USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 16/09/2010
-- Description:	Takes a date/time and finds the start of the period, according to the type:
--              1 = day
--				2 = week
--				3 = month
--				4 = quarter
--				5 = year
--				6 = all dates, single record
-- =============================================
CREATE FUNCTION [dbo].[svfPeriodStart]
(
	@PeriodType Integer,
	@DateInput DateTime
)
RETURNS DateTime
AS
BEGIN
	DECLARE @_PeriodStart as DateTime
	--
	-- Check if the period type is valid; if not then make it months
	--
	if @PeriodType < 1 or @PeriodType > 6
		begin
		set @PeriodType = 3    
		end
	--
	-- Get the start period
	--
	if @PeriodType = 1			-- day
		begin
		-- Don't do a thing - the cleanup below will just eliminate the time part
		Set @_PeriodStart = @DateInput
		end
	if @PeriodType = 2			-- week
		begin
		Set @_PeriodStart = DateAdd(day, -((@@DATEFIRST + DatePart(weekday, @DateInput) - 2) % 7), @DateInput)
		end
	if @PeriodType = 3			-- month
		begin
		Set @_PeriodStart = DateAdd(day, - (DAY(@DateInput) - 1), @DateInput)
		end
	if @PeriodType = 4			-- quarter
		begin
		Set @_PeriodStart = DateAdd(quarter, DateDiff(quarter, 0, @DateInput), 0)
		end
	if @PeriodType = 5			-- year
		begin
		Set @_PeriodStart = DateAdd(day, -(DatePart(dayofyear, @DateInput) - 1), @DateInput)
		end
	if @PeriodType = 6			-- all records
		begin
		if @DateInput is null
			begin
			select @_PeriodStart = Null
			end
		else
			begin
			select @_PeriodStart = '17530101'
			end
		end
	--
	-- Eliminate any time part from the date
	--
	Set @_PeriodStart = CAST(FLOOR(CAST(@_PeriodStart as DECIMAL(12, 5))) AS DATETIME)
	RETURN @_PeriodStart
END
GO
