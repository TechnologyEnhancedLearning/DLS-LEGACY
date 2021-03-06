USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 16/09/2010
-- Description:	This function returns a table of periods from 
--				today going back some periods according to the type:
--              1 = day
--				2 = week
--				3 = month
--				4 = quarter
--				5 = year
--				6 = all dates, single record
-- =============================================

CREATE FUNCTION [dbo].[tvfGetPeriodTable]
(
	@PeriodType Integer,
	@PeriodCount Integer
)
RETURNS @PeriodTable TABLE 
(
	PeriodStart DateTime,
	PeriodEnd DateTime
)

AS	  
BEGIN
	Declare @_PeriodStart DateTime

	Set @_PeriodStart = dbo.svfPeriodStart(@PeriodType, GetUTCDate())
	--
	-- Check if the period type is valid; if not then make it months
	--
	if @PeriodType < 1 or @PeriodType > 6
		begin
		set @PeriodType = 3    
		end
	--
	-- If it's option 6 then include all dates as a single record
	--	
	if @PeriodType = 6
		begin
			Declare @_PeriodEnd DateTime

			select @_PeriodEnd = '99991231'			-- max date allowed
			INSERT INTO @PeriodTable VALUES (@_PeriodStart, @_PeriodEnd)
		end
	else
		begin
		While (@PeriodCount > 0)
			Begin
			if @PeriodType = 1
				begin
				INSERT INTO @PeriodTable VALUES (DateAdd(day, 1 - @PeriodCount, @_PeriodStart), DateAdd(day, 2 - @PeriodCount, @_PeriodStart))
				end
			if @PeriodType = 2
				begin
				INSERT INTO @PeriodTable VALUES (DateAdd(week, 1 - @PeriodCount, @_PeriodStart), DateAdd(week, 2 - @PeriodCount, @_PeriodStart))
				end
			if @PeriodType = 3
				begin
				INSERT INTO @PeriodTable VALUES (DateAdd(month, 1 - @PeriodCount, @_PeriodStart), DateAdd(month, 2 - @PeriodCount, @_PeriodStart))
				end
			if @PeriodType = 4
				begin
				INSERT INTO @PeriodTable VALUES (DateAdd(quarter, 1 - @PeriodCount, @_PeriodStart), DateAdd(quarter, 2 - @PeriodCount, @_PeriodStart))
				end
			if @PeriodType = 5
				begin
				INSERT INTO @PeriodTable VALUES (DateAdd(year, 1 - @PeriodCount, @_PeriodStart), DateAdd(year, 2 - @PeriodCount, @_PeriodStart))
				end
				Set @PeriodCount = @PeriodCount - 1
			End
		End
	Return
END
GO
