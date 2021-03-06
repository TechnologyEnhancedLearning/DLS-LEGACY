USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Hugh Gibson
-- Create date: 10/09/2010
-- Description:	Gets candidates for a customisation,
--				applying filter values
-- =============================================
CREATE PROCEDURE [dbo].[uspCandidatesForAllCustomisations] 
	@ApplyFilter as Bit,
	@FirstNameLike as varchar(250),
	@LastNameLike as varchar(250),
	@CandidateNumberLike as varchar(250),
	@AliasLike as varchar(250),
	@Status as Int,
	@RegisteredHighDate as varchar(20),
	@RegisteredLowDate as varchar(20),
	@LastUpdateHighDate as varchar(20),
	@LastUpdateLowDate as varchar(20),
	@CompletedHighDate as varchar(20),
	@CompletedLowDate as varchar(20),
	@LoginsHigh as varchar(20),
	@LoginsLow as varchar(20),
	@DurationHigh as varchar(20),
	@DurationLow as varchar(20),
	@PassesHigh as varchar(20),
	@PassesLow as varchar(20),
	@PassRateHigh as varchar(20),
	@PassRateLow as varchar(20),
	@DiagScoreHigh as varchar(20),
	@DiagScoreLow as varchar(20),
	@SortExpression as varchar(250),
	@CentreID as int
AS
BEGIN
IF 1=0 BEGIN
    SET FMTONLY OFF
END
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--
	-- These define the SQL to use
	--
	DECLARE @_SQL nvarchar(max)
	DECLARE @_SQLCandidateFilter nvarchar(max)
	DECLARE @_SQLOutputFilter nvarchar(max)
	DECLARE @_SQLCompletedFilterDeclaration nvarchar(max)
	DECLARE @_SortExpression nvarchar(max)
	
	DECLARE @_dtRegisteredHighDate as DateTime
	DECLARE @_dtRegisteredLowDate as DateTime
	DECLARE @_dtLastUpdateHighDate as DateTime
	DECLARE @_dtLastUpdateLowDate as DateTime
	DECLARE @_dtCompletedHighDate as DateTime
	DECLARE @_dtCompletedLowDate as DateTime
	DECLARE @_nLoginsHigh As Int
	DECLARE @_nLoginsLow As Int
	DECLARE @_nDurationHigh As Int
	DECLARE @_nDurationLow As Int
	DECLARE @_nPassesHigh As Int
	DECLARE @_nPassesLow As Int
	DECLARE @_nPassRateHigh As float
	DECLARE @_nPassRateLow As float
	DECLARE @_nDiagScoreHigh As Int
	DECLARE @_nDiagScoreLow As Int
	--
	-- Set up Candidate filter clause if required
	--
	set @_SQLCandidateFilter = ' WHERE (c.CentreID = @CentreID)'
	set @_SQLOutputFilter = ''
	set @_SQLCompletedFilterDeclaration = ''
	
	if @ApplyFilter = 1
		begin
		if Len(@FirstNameLike) > 0
			begin
			set @FirstNameLike = '%' + @FirstNameLike + '%'
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'c.FirstName LIKE @FirstNameLike'
			end
		if Len(@LastNameLike) > 0
			begin
			set @LastNameLike = '%' + @LastNameLike + '%'
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'c.LastName LIKE @LastNameLike'
			end
		if Len(@CandidateNumberLike) > 0
			begin
			set @CandidateNumberLike = '%' + @CandidateNumberLike + '%'
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'c.CandidateNumber LIKE @CandidateNumberLike'
			end
		if Len(@AliasLike) > 0
			begin
			set @AliasLike = '%' + @AliasLike + '%'
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'c.AliasID LIKE @AliasLike'
			end
		if @Status = 1
			begin
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'c.Active = 1'
			end
		if @Status = 2
			begin
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'c.Active = 0'
			end
		if LEN(@RegisteredLowDate) > 0 
			begin try
				set @_dtRegisteredLowDate = CONVERT(DateTime, @RegisteredLowDate, 103)
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'p.FirstSubmittedTime >= @_dtRegisteredLowDate'
			end try
			begin catch
			end catch
		if LEN(@RegisteredHighDate) > 0 
			begin try
				set @_dtRegisteredHighDate = CONVERT(DateTime, @RegisteredHighDate, 103)
				set @_dtRegisteredHighDate = DateAdd(day, 1, @_dtRegisteredHighDate)
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'p.FirstSubmittedTime < @_dtRegisteredHighDate'
			end try
			begin catch
			end catch
		if LEN(@LastUpdateLowDate) > 0 
			begin try
				set @_dtLastUpdateLowDate = CONVERT(DateTime, @LastUpdateLowDate, 103)
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'p.SubmittedTime >= @_dtLastUpdateLowDate'
			end try
			begin catch
			end catch
		if LEN(@LastUpdateHighDate) > 0 
			begin try
				set @_dtLastUpdateHighDate = CONVERT(DateTime, @LastUpdateHighDate, 103)
				set @_dtLastUpdateHighDate = DateAdd(day, 1, @_dtLastUpdateHighDate)
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'p.SubmittedTime < @_dtLastUpdateHighDate'
			end try
			begin catch
			end catch
		if LEN(@CompletedLowDate) > 0 
			begin try
				set @_dtCompletedLowDate = CONVERT(DateTime, @CompletedLowDate, 103)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.CompletedFilter >= @_dtCompletedLowDate'
				set @_SQLCompletedFilterDeclaration = ', case when q1.Completed is Null then CONVERT(DateTime, ''01/01/9999'', 103) else q1.Completed end as CompletedFilter'
			end try
			begin catch
			end catch
		if LEN(@CompletedHighDate) > 0 
			begin try
				set @_dtCompletedHighDate = CONVERT(DateTime, @CompletedHighDate, 103)
				set @_dtCompletedHighDate = DateAdd(day, 1, @_dtCompletedHighDate)
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'p.Completed < @_dtCompletedHighDate'
			end try
			begin catch
			end catch
		if LEN(@LoginsLow) > 0 
			begin try
				set @_nLoginsLow = CONVERT(Integer, @LoginsLow)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.Logins >= @_nLoginsLow'
			end try
			begin catch
			end catch
		if LEN(@LoginsHigh) > 0 
			begin try
				set @_nLoginsHigh = CONVERT(Integer, @LoginsHigh)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.Logins <= @_nLoginsHigh'
			end try
			begin catch
			end catch
		if LEN(@DurationLow) > 0 
			begin try
				set @_nDurationLow = CONVERT(Integer, @DurationLow)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.Duration >= @_nDurationLow'
			end try
			begin catch
			end catch
		if LEN(@DurationHigh) > 0 
			begin try
				set @_nDurationHigh = CONVERT(Integer, @DurationHigh)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.Duration <= @_nDurationHigh'
			end try
			begin catch
			end catch
		if LEN(@PassesLow) > 0 
			begin try
				set @_nPassesLow = CONVERT(Integer, @PassesLow)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.Passes >= @_nPassesLow'
			end try
			begin catch
			end catch
		if LEN(@PassesHigh) > 0 
			begin try
				set @_nPassesHigh = CONVERT(Integer, @PassesHigh)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.Passes <= @_nPassesHigh'
			end try
			begin catch
			end catch
		if LEN(@PassRateLow) > 0 
			begin try
				set @_nPassRateLow = CONVERT(float, @PassRateLow)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.PassRate >= @_nPassRateLow'
			end try
			begin catch
			end catch
		if LEN(@PassRateHigh) > 0 
			begin try
				set @_nPassRateHigh = CONVERT(float, @PassRateHigh)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.PassRate <= @_nPassRateHigh'
			end try
			begin catch
			end catch
		if LEN(@DiagScoreLow) > 0 
			begin try
				set @_nDiagScoreLow = CONVERT(Integer, @DiagScoreLow)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + 'q2.DiagnosticScore >= @_nDiagScoreLow'
			end try
			begin catch
			end catch
		if LEN(@DiagScoreHigh) > 0 
			begin try
				set @_nDiagScoreHigh = CONVERT(Integer, @DiagScoreHigh)
				set @_SQLOutputFilter = dbo.svfAnd(@_SQLOutputFilter) + '(q2.DiagnosticScore <= @_nDiagScoreHigh OR q2.DiagnosticScore is NULL)'
			end try
			begin catch
			end catch
		end
	--
	-- Set up sort clause. Combine user selection with defaults.
	--
	set @_SortExpression = ''
	if Len(@SortExpression) > 0					-- user selection?
		begin
		set @_SortExpression = 'q2.' + @SortExpression	-- use it
		end
	set @_SortExpression = dbo.svfAddToOrderByClause(@_SortExpression, 'q2.LastName')
	set @_SortExpression = dbo.svfAddToOrderByClause(@_SortExpression, 'q2.FirstName')
	--
	-- To find the data we have to run nested queries.
	-- The first one, Q1, grabs the raw data, which is then converted to a PassRate.
	-- Q2 selects from this query and is able to have a filter applied depending on the 
	-- parameters passed in.
	-- We create WHERE clauses based on the parameters. If they apply to the candidate then
	-- the filter is applied on the internal SELECT; otherwise it's applied to the outer SELECT.
	--
	SET @_SQL = 'SELECT q2.ProgressID, q2.CustomisationName, q2.CourseActive, q2.FirstName, q2.LastName, q2.Email, q2.SelfReg, q2.DateRegistered, q2.CandidateNumber, q2.SubmittedTime AS LastUpdated, q2.Active, q2.AliasID, q2.JobGroupID, q2.Completed, 
	   q2.Answer1, q2.Answer2, q2.Answer3, q2.Logins, q2.Duration, q2.Passes, 
	   CASE WHEN q2.Attempts = 0 THEN NULL ELSE q2.PassRate END as PassRatio,
	   q2.DiagnosticScore
	   FROM
	(SELECT q1.ProgressID, q1.CustomisationName, q1.CourseActive, q1.FirstName, q1.LastName, q1.Email, q1.SelfReg, q1.DateRegistered, q1.CandidateNumber, q1.SubmittedTime, q1.Active, q1.AliasID, q1.JobGroupID, q1.Completed, 
	   q1.Answer1, q1.Answer2, q1.Answer3, q1.Logins, q1.Duration, q1.Attempts, q1.Passes,
	   case when q1.Attempts = 0 then 0.0 else 100.0 * CAST(q1.Passes as float) / CAST(q1.Attempts as float) end as PassRate,
	   q1.DiagnosticScore'
	   + @_SQLCompletedFilterDeclaration + '
	 FROM (SELECT     p.ProgressID, a.ApplicationName + '' - '' + cu.CustomisationName AS CustomisationName, cu.Active AS CourseActive, c.FirstName, c.LastName, c.EmailAddress AS Email, c.SelfReg, p.FirstSubmittedTime as DateRegistered, c.CandidateNumber, c.Active, c.AliasID, c.JobGroupID, p.SubmittedTime, p.Completed, 
                      p.Answer1, p.Answer2, p.Answer3, p.DiagnosticScore,
					 p.LoginCount AS Logins,
					 p.Duration,
					 (SELECT COUNT(*) FROM AssessAttempts a 
						WHERE a.CandidateID = p.CandidateID and a.CustomisationID = p.CustomisationID) as Attempts,
					 (SELECT Sum(CAST(a1.Status as int)) 
						FROM AssessAttempts a1 WHERE a1.CandidateID = p.CandidateID and a1.CustomisationID = p.CustomisationID) as Passes
	FROM         Progress p INNER JOIN Candidates c
                       ON p.CandidateID = c.CandidateID INNER JOIN Customisations as cu on p.CustomisationID = cu.CustomisationID INNER JOIN Applications a on cu.ApplicationID = a.ApplicationID ' + @_SQLCandidateFilter + ') as q1) as q2 ' + @_SQLOutputFilter +
      ' ORDER BY ' + @_SortExpression
	--
	-- Execute the query. Using sp_executesql means 
	-- that query plans are not specific for parameter values, but 
	-- just are specific for the particular combination of clauses in WHERE.
	-- Therefore there is a very good chance that the query plan will be in cache and
	-- won't have to be re-computed. Note that unused parameters are ignored.
	--
	EXEC sp_executesql @_SQL, 	N'@CentreID Int,
	@FirstNameLike varchar(250),
								  @LastNameLike varchar(250),
								  @CandidateNumberLike varchar(250),
								  @AliasLike varchar(250),
								  @_dtRegisteredLowDate DateTime,
								  @_dtRegisteredHighDate DateTime,
								  @_dtLastUpdateHighDate DateTime,
								  @_dtLastUpdateLowDate DateTime,
								  @_dtCompletedHighDate DateTime,
								  @_dtCompletedLowDate DateTime,
								  @_nLoginsHigh Int,
								  @_nLoginsLow Int,
								  @_nDurationHigh Int,
								  @_nDurationLow Int,
								  @_nPassesHigh Int,
								  @_nPassesLow Int,
								  @_nPassRateHigh Int,
								  @_nPassRateLow Int,
								  @_nDiagScoreHigh Int,
								  @_nDiagScoreLow Int',
					   @CentreID,
					   @FirstNameLike,
					   @LastNameLike,
					   @CandidateNumberLike,
					   @AliasLike,
					   @_dtRegisteredLowDate,
					   @_dtRegisteredHighDate,
					   @_dtLastUpdateHighDate,
					   @_dtLastUpdateLowDate,
					   @_dtCompletedHighDate,
					   @_dtCompletedLowDate,
					   @_nLoginsHigh,
					   @_nLoginsLow,
					   @_nDurationHigh,
					   @_nDurationLow,
					   @_nPassesHigh,
					   @_nPassesLow,
					   @_nPassRateHigh,
					   @_nPassRateLow,
					   @_nDiagScoreHigh,
					   @_nDiagScoreLow

END



GO
