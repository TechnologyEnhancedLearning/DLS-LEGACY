USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Whittaker, Kevin
-- Create date: 24/08/2010
-- Description:	Returns evaluation response data with optional parameters
-- =============================================
CREATE PROCEDURE [dbo].[uspEvaluationSummaryDateRangeV2]
	@JobGroupID Integer = -1,
	@ApplicationID Integer = -1,
	@CustomisationID Integer = -1,
	@RegionID Integer = -1,
	@CentreTypeID Integer = -1,
	@CentreID Integer = -1,
	@IsAssessed Integer = -1,
	@StartDate Date,
	@EndDate Date,
	@CourseGroup integer = -1
AS
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @SQL nvarchar(4000)
	
	SELECT @SQL = 'SELECT COUNT(e.Q1) AS TotalResponses,
						SUM(case when e.Q1 = 0 then 1 else 0 end) AS Q1No,
						SUM(case when e.Q1 = 1 then 1 else 0 end) AS Q1Yes,
						SUM(case when e.Q1 = 255 then 1 else 0 end) AS Q1NoAnswer,
						
						SUM(case when e.Q2 = 0 then 1 else 0 end) AS Q2No,
						SUM(case when e.Q2 = 1 then 1 else 0 end) AS Q2Yes,
						SUM(case when e.Q2 = 255 then 1 else 0 end) AS Q2NoAnswer,

						SUM(case when e.Q3 = 0 then 1 else 0 end) AS Q3No,
						SUM(case when e.Q3 = 1 then 1 else 0 end) AS Q3Yes,
						SUM(case when e.Q3 = 255 then 1 else 0 end) AS Q3NoAnswer,
						
						SUM(case when e.Q3 = 0 then 1 else 0 end) AS Q40,
						SUM(case when ((e.Q3 = 1 or e.Q3 = 255) and e.Q4 = 1) then 1 else 0 end) AS Q4lt1,
						SUM(case when ((e.Q3 = 1 or e.Q3 = 255) and e.Q4 = 2) then 1 else 0 end) AS Q41to2,
						SUM(case when ((e.Q3 = 1 or e.Q3 = 255) and e.Q4 = 3) then 1 else 0 end) AS Q42to4,
						SUM(case when ((e.Q3 = 1 or e.Q3 = 255) and e.Q4 = 4) then 1 else 0 end) AS Q44to6,
						SUM(case when ((e.Q3 = 1 or e.Q3 = 255) and e.Q4 = 5) then 1 else 0 end) AS Q4gt6,
						SUM(case when ((e.Q3 = 1 or e.Q3 = 255) and e.Q4 = 255) then 1 else 0 end) AS Q4NoAnswer,
						
						SUM(case when e.Q5 = 0 then 1 else 0 end) AS Q5No,
						SUM(case when e.Q5 = 1 then 1 else 0 end) AS Q5Yes,
						SUM(case when e.Q5 = 255 then 1 else 0 end) AS Q5NoAnswer,
						
						SUM(case when e.Q6 = 0 then 1 else 0 end) AS Q6NA,
						SUM(case when e.Q6 = 1 then 1 else 0 end) AS Q6No,
						SUM(case when e.Q6 = 3 then 1 else 0 end) AS Q6YesInd,
						SUM(case when e.Q6 = 2 then 1 else 0 end) AS Q6YesDir,
						SUM(case when e.Q6 = 255 then 1 else 0 end) AS Q6NoAnswer,
						
						SUM(case when e.Q7 = 0 then 1 else 0 end) AS Q7No,
						SUM(case when e.Q7 = 1 then 1 else 0 end) AS Q7Yes,
						SUM(case when e.Q7 = 255 then 1 else 0 end) AS Q7NoAnswer '
	--
	-- Construct appropriate FROM clause depending on 
	-- values passed in. -1 means to ignore the value.
	--
	DECLARE @SQLFromClause nvarchar(4000)
	SELECT @SQLFromClause = 'FROM dbo.Evaluations e '
	if @ApplicationID >= 0 or @CentreID >= 0 or @RegionID >= 0 or @IsAssessed >= 0 or @CourseGroup >= 0 OR @CentreTypeID >= 0
 		begin
		SELECT @SQLFromClause = @SQLFromClause + 'INNER JOIN dbo.Customisations c ON e.CustomisationID = c.CustomisationID '
		if @RegionID >= 0 OR @CentreTypeID >= 0
 			begin
			SELECT @SQLFromClause = @SQLFromClause + 'INNER JOIN dbo.Centres ce ON c.CentreID = ce.CentreID '
			end
		end
		if @CourseGroup >= 0
		begin
		SELECT @SQLFromClause = @SQLFromClause + 'INNER JOIN Applications a ON a.ApplicationID = c.ApplicationID '
		end
	SELECT @SQL = @SQL + @SQLFromClause
	--
	-- Construct appropriate WHERE clause depending on 
	-- values passed in. -1 means to ignore the value
	--
	DECLARE @SQLWhereClause nvarchar(4000)
	SELECT @SQLWhereClause = ''
	IF @IsAssessed >= 0 
		begin
		SELECT @SQLWhereClause = dbo.svfAnd(@SQLWhereClause) + 'c.IsAssessed = @IsAssessed'
		end
	IF @ApplicationID >= 0 
		begin
		SELECT @SQLWhereClause = dbo.svfAnd(@SQLWhereClause) + 'c.ApplicationID = @ApplicationID'
		end
	IF @CentreID >= 0
		begin
		SELECT @SQLWhereClause = dbo.svfAnd(@SQLWhereClause) + 'c.CentreID = @CentreID'
		end
		if @CentreTypeID >= 0
		begin
		set @SQLWhereClause = dbo.svfAnd(@SQLWhereClause) + 'ce.CentreTypeID = @CentreTypeID'
		end
	IF @CustomisationID >= 0
		begin
		SELECT @SQLWhereClause = dbo.svfAnd(@SQLWhereClause) + 'e.CustomisationID = @CustomisationID'
		end
	IF @JobGroupID >= 0
		begin
		SELECT @SQLWhereClause = dbo.svfAnd(@SQLWhereClause) + 'e.JobGroupID = @JobGroupID'
		end
	IF @RegionID >= 0
		begin 
		SELECT @SQLWhereClause = dbo.svfAnd(@SQLWhereClause) + 'ce.RegionID = @RegionID'
		end
		IF @CourseGroup >= 0
		begin
		SELECT @SQLWhereClause = dbo.svfAnd(@SQLWhereClause) + 'a.AppGroupID = @CourseGroup'
		end
		SELECT @SQLWhereClause = dbo.svfAnd(@SQLWhereClause) + 'e.EvaluatedDate >= @StartDate AND e.EvaluatedDate <= @EndDate'
	--
	-- If the where clause is not empty then
	-- add it to the overall query.
	--
	if LEN(@SQLWhereClause) > 0
		begin
		SELECT @SQL = @SQL + @SQLWhereClause
		end
	--
	-- Execute the query. Using sp_executesql means 
	-- that query plans are not specific for parameter values, but 
	-- just are specific for the particular combination of clauses in WHERE.
	-- Therefore there is a very good chance that the query plan will be in cache and
	-- won't have to be re-computed. Note that unused parameters are ignored.
	-- 
	print @SQL
	EXEC sp_executesql @SQL, 	N'@JobGroupID Integer,
								  @ApplicationID Integer,
								  @CustomisationID Integer,
								  @RegionID Integer,
								  @CentreTypeID Integer,
								  @CentreID Integer,
								  @IsAssessed Integer,
								  @StartDate Date,
								  @EndDate Date,
								  @CourseGroup Integer',
					   @JobGroupID, @ApplicationID, @CustomisationID, @RegionID,
								@CentreTypeID, @CentreID, @IsAssessed, @StartDate, @EndDate, @CourseGroup
end


GO
