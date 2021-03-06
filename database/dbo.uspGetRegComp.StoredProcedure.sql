USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Hugh Gibson
-- Create date: 15/09/2010
-- Description:	Returns registrations and completions according to the parameters
-- PeriodType values are:
--              1 = day
--				2 = week
--				3 = month
--				4 = quarter
--				5 = year
-- =============================================
CREATE PROCEDURE [dbo].[uspGetRegComp]
	@PeriodType Integer,
	@JobGroupID Integer = -1,
	@ApplicationID Integer = -1,
	@CustomisationID Integer = -1,
	@RegionID Integer = -1,
	@CentreTypeID Integer = -1,
	@CentreID Integer = -1,
	@IsAssessed Integer = -1,
	@ApplicationGroup Integer = -1,
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
	if @CustomisationID >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + 'p.CustomisationID = @CustomisationID'
		end
	if @CentreID >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + 'cu.CentreID = @CentreID'
		end
	if @CentreTypeID >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + 'ce.CentreTypeID = @CentreTypeID'
		end
	if @IsAssessed >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + 'cu.IsAssessed = @IsAssessed'
		end
	if @ApplicationID >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + 'cu.ApplicationID = @ApplicationID'
		end
	if @RegionID >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + 'ce.RegionID = @RegionID'
		end
	if @ApplicationGroup >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + 'ap.AppGroupID = @ApplicationGroup'
		end
		set @_SQLProgressFilterEnv = @_SQLProgressFilter
	if @JobGroupID >= 0
		begin
		set @_SQLProgressFilter = dbo.svfAnd(@_SQLProgressFilter) + 'ca.JobGroupID = @JobGroupID'
		end
		
	--
	-- Set up appropriate clause for joining
	--
	if @CentreID >=0 or @IsAssessed >= 0 or @ApplicationID >= 0 or @RegionID >= 0 or @ApplicationGroup >= 0 OR @CentreTypeID >= 0
		begin
		set @_SQLProgressJoin = @_SQLProgressJoin + ' INNER JOIN dbo.Customisations AS cu ON p.CustomisationID = cu.CustomisationID'
		if @RegionID >= 0 OR @CentreTypeID >= 0
			begin
			set @_SQLProgressJoin = @_SQLProgressJoin + ' INNER JOIN dbo.Centres AS ce ON ce.CentreID = cu.CentreID'
			end
		end
		If @ApplicationGroup >= 0
		begin
		set @_SQLProgressJoin = @_SQLProgressJoin + ' INNER JOIN dbo.Applications AS ap ON ap.ApplicationID = cu.ApplicationID'
		end
		set @_SQLProgressJoinEv = @_SQLProgressJoin
		
	if @JobGroupID >= 0
		begin
		set @_SQLProgressJoin = @_SQLProgressJoin + ' LEFT OUTER JOIN dbo.Candidates AS ca ON p.CandidateID = ca.CandidateID'
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
		SELECT	Q2.PeriodStart,
				Q2.Registrations,
				Q4.Completions,
				Q6.Evaluations
				FROM
				(SELECT     PeriodStart,
							Count(Q1.FirstSubmittedTimePeriodStart) as Registrations
				 FROM		dbo.tvfGetPeriodTableVarEnd(@PeriodType, @StartDate, @EndDate) m 
							LEFT OUTER JOIN             
					(SELECT     dbo.svfPeriodStart(@PeriodType, p.FirstSubmittedTime) as FirstSubmittedTimePeriodStart
							FROM        dbo.Progress p '
										+ @_SQLProgressJoin +
							+ dbo.svfAnd(@_SQLProgressFilter) + ' (p.FirstSubmittedTime>=@StartDate) AND (p.FirstSubmittedTime<=@EndDate)) as Q1 
					ON m.PeriodStart = Q1.FirstSubmittedTimePeriodStart
				GROUP BY m.PeriodStart) AS Q2 
				
				JOIN 
				(SELECT     PeriodStart,
							Count(Q3.CompletedPeriodStart) as Completions
				FROM        dbo.tvfGetPeriodTableVarEnd(@PeriodType, @StartDate, @EndDate) m 
							LEFT OUTER JOIN             
					(SELECT     dbo.svfPeriodStart(@PeriodType, p.Completed) as CompletedPeriodStart
							FROM        dbo.Progress p '
										+ @_SQLProgressJoin +
							+ dbo.svfAnd(@_SQLProgressFilter) + ' (p.Completed>=@StartDate) AND (p.Completed<=@EndDate)) as Q3
					ON m.PeriodStart = Q3.CompletedPeriodStart
				GROUP BY m.PeriodStart) AS Q4 
				ON Q2.PeriodStart = Q4.PeriodStart
				JOIN 
				(SELECT     PeriodStart,
							Count(Q5.EvaluatedPeriodStart) as Evaluations
				FROM        dbo.tvfGetPeriodTableVarEnd(@PeriodType, @StartDate, @EndDate) m 
							LEFT OUTER JOIN             
					(SELECT     dbo.svfPeriodStart(@PeriodType, p.EvaluatedDate) as EvaluatedPeriodStart
							FROM        dbo.Evaluations p '
										+ @_SQLProgressJoinEv +
							+ dbo.svfAnd(@_SQLProgressFilterEnv) + ' (p.EvaluatedDate>=@StartDate) AND (p.EvaluatedDate<=@EndDate)) as Q5
					ON m.PeriodStart = Q5.EvaluatedPeriodStart
				GROUP BY m.PeriodStart) AS Q6
			ON Q2.PeriodStart = Q6.PeriodStart'
			
	--
	-- Execute the query. Using sp_executesql means 
	-- that query plans are not specific for parameter values, but 
	-- just are specific for the particular combination of clauses in WHERE.
	-- Therefore there is a very good chance that the query plan will be in cache and
	-- won't have to be re-computed. Note that unused parameters are ignored.
	-- 
	print @_SQL
	EXEC sp_executesql @_SQL, 	N'@PeriodType Integer,
								  @CustomisationID Integer,
								  @CentreID Integer,
								  @IsAssessed Integer,
								  @ApplicationID Integer,
								  @RegionID Integer,
								  @CentreTypeID Integer,
								  @JobGroupID Integer,
								  @ApplicationGroup Integer,
								  @StartDate Date,
								  @EndDate Date',
								@PeriodType, 
								@CustomisationID,
								@CentreID,
								@IsAssessed,
								@ApplicationID,
								@RegionID,
								@CentreTypeID,
								@JobGroupID,
								@ApplicationGroup,
								  @StartDate,
								  @EndDate
end


/****** Object:  StoredProcedure [dbo].[uspGetRegCompChrt]    Script Date: 26/11/2014 13:00:37 ******/
SET ANSI_NULLS ON

GO
