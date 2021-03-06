USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 31/12/2014
-- Description:	Returns registrations and completions according to the parameters. Returns in a format appropriate for conversion to JSon for Morris.js chart display.
-- PeriodType values are:
--              1 = day
--				2 = week
--				3 = month
--				4 = quarter
--				5 = year
-- =============================================
CREATE PROCEDURE [dbo].[uspGetStatsByCourse]
	@PeriodType Integer,
	@ApplicationID Integer = -1,
	@CentreID Integer = -1,
	@StartDate Date,
	@EndDate Date
AS
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @_SQL nvarchar(max)
	DECLARE @_SQLProgressFilter nvarchar(max)
	DECLARE @_SQLProgressFilterEnv nvarchar(max)
	DECLARE @_SQLProgressJoin nvarchar(max)
	DECLARE @_SQLProgressJoinEv nvarchar(max)
	--
	-- Set to empty string to avoid Null propagation killing the result!
	--
	set @_SQLProgressFilter = ''
	set @_SQLProgressFilterEnv = ''
	set @_SQLProgressJoin = ''
	set @_SQLProgressJoinEv = ''
	--
	-- Set up progress filter clause if required
	--
	if @CentreID >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + 'CentreID = @CentreID'
		end
	if @ApplicationID >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + '(ApplicationID = @ApplicationID OR kbYouTubeLaunched = 1)'
		end
	Declare @_SQLDateSelect As varchar(max)
	if @PeriodType = 1
				begin
				SET @_SQLDateSelect = 'LEFT(CONVERT(VARCHAR, LogDate, 120), 10)'
				end
			if @PeriodType = 2
				begin
				SET @_SQLDateSelect = 'CAST(LogYear AS varchar) + '' W'' + RIGHT(''00'' + CAST(DATEPART(week, LogDate) AS varchar), 2)'
				end
			if @PeriodType = 3
				begin
				SET @_SQLDateSelect = 'CAST(LogYear AS varchar) + ''-'' + RIGHT(''00'' + CAST(LogMonth AS VarChar), 2)'
				end
			if @PeriodType = 4
				begin
				SET @_SQLDateSelect = 'CAST(LogYear AS varchar) + '' Q'' + CAST(LogQuarter AS VarChar)'
				end
			if @PeriodType = 5
				begin
				SET @_SQLDateSelect = 'CAST(LogYear AS varchar)'
				end
				if @PeriodType = 6
				begin
				SET @_SQLDateSelect = 'NULL'
				end
	--
	-- This query is to get registrations and completions per time period.
	-- We depend on a function which returns a table of periods, as PeriodStart and PeriodEnd.
	-- The query is split into two halves - Q2 and Q4 - which are joined on PeriodStart.
	-- The reason for this is to avoid scanning the whole table of Progress for each time period,
	-- which is what happens when a subselect is used.
	--
	-- The component parts of the query follow the same model. An inner query - Q1 and Q3 - 
	-- changes the date of interest (FirstSubmittedTime and Completed) into the PeriodStart values.
	-- This inner query is also where we apply any WHERE clauses to filter the Progress records
	-- according to the parameters.
	-- If we are looking at months, the dates are changed to the start of the month, using
	-- the same function as is used when getting the periods. This is important, because we join from the 
	-- modified date to the PeriodStart value. Grouping by PeriodStart and counting the records that match
	-- gives us a count of the records that fall within the period. Doing a LEFT OUTER JOIN means that we
	-- get 0 counts for periods that had no matching records.
	--
	
	SELECT @_SQL = '
		SELECT ' + @_SQLDateSelect + ' AS period, 
                         SUM(CAST(Registered AS Int)) AS registrations, SUM(CAST(Completed AS Int)) AS completions, SUM(CAST(Evaluated AS Int)) AS evaluations, SUM(CAST(kbSearched AS Int)) AS kbsearches, SUM(CAST(kbTutorialViewed AS Int)) AS kbtutorials, 
                         SUM(CAST(kbVideoViewed AS Int)) AS kbvideos, SUM(CAST(kbYouTubeLaunched AS Int)) AS kbyoutubeviews
FROM            tActivityLog'
							+ dbo.svfAnd(@_SQLProgressFilter) + ' (LogDate>=@StartDate) AND (LogDate<=@EndDate)'
			if @PeriodType < 6
				begin
				SET @_SQL = @_SQL +				
				'GROUP BY ' + @_SQLDateSelect + ' ORDER BY Period'
			end	
	--
	-- Execute the query. Using sp_executesql means 
	-- that query plans are not specific for parameter values, but 
	-- just are specific for the particular combination of clauses in WHERE.
	-- Therefore there is a very good chance that the query plan will be in cache and
	-- won't have to be re-computed. Note that unused parameters are ignored.
	-- 
	print @_SQL
	EXEC sp_executesql @_SQL, 	N'@PeriodType Integer,
								  @CentreID Integer,
								  @ApplicationID Integer,
								  @StartDate Date,
								  @EndDate Date',
								@PeriodType, 
								@CentreID,
								@ApplicationID,
								  @StartDate,
								  @EndDate
end








GO
