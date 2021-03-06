USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 15/09/2010
-- Description:	Gets candidates for a centre,
--				applying filter values
-- =============================================
CREATE PROCEDURE [dbo].[uspCandidatesForCentre_V5] 
	@CentreID as Int,
	@ApplyFilter as Bit,
	@FirstNameLike as varchar(250),
	@LastNameLike as varchar(250),
	@JobGroupID as int,
	@LoginLike as varchar(250),
	@AliasLike as varchar(250),
	@Status as Int,
	@RegisteredHighDate as varchar(20),
	@RegisteredLowDate as varchar(20),
	@Answer1 as varchar(250),
	@Answer2 as varchar(250),
	@Answer3 as varchar(250),
	@BulkDownload as Bit,
	@SortExpression as varchar(250)
AS
BEGIN
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
	--
	-- Set up Candidate filter clause if required
	--
	set @_SQLCandidateFilter = ' (CentreID = @CentreID) '
	
	if @ApplyFilter = 1
		begin
		if Len(@FirstNameLike) > 0
			begin
			set @FirstNameLike = '%' + @FirstNameLike + '%'
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'FirstName LIKE @FirstNameLike'
			end
		if Len(@LastNameLike) > 0
			begin
			set @LastNameLike = '%' + @LastNameLike + '%'
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'LastName LIKE @LastNameLike'
			end
		if Len(@LoginLike) > 0
			begin
			set @LoginLike = '%' + @LoginLike + '%'
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'CandidateNumber LIKE @LoginLike'
			end
		if Len(@AliasLike) > 0
			begin
			set @AliasLike = '%' + @AliasLike + '%'
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'AliasID LIKE @AliasLike'
			end
		if @Status = 1
			begin
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'Active = 1'
			end
		if @Status = 2
			begin
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'Active = 0'
			end
		if LEN(@RegisteredLowDate) > 0 
			begin try
				set @_dtRegisteredLowDate = CONVERT(DateTime, @RegisteredLowDate, 103)
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'DateRegistered >= @_dtRegisteredLowDate'
			end try
			begin catch
			end catch
		if LEN(@RegisteredHighDate) > 0 
			begin try
				set @_dtRegisteredHighDate = CONVERT(DateTime, @RegisteredHighDate, 103)
				set @_dtRegisteredHighDate = DateAdd(day, 1, @_dtRegisteredHighDate)
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'DateRegistered < @_dtRegisteredHighDate'
			end try
			begin catch
			end catch
		if @JobGroupID > 0
			begin
			set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'JobGroupID = @JobGroupID'
			end
		if @Answer1 <> '[All answers]'
			begin
			if LEN(@Answer1) = 0
				begin
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + '(Answer1 = '' or Answer1 is Null)'
				end
			else
				begin
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'Answer1 = @Answer1'
				end
			end
		if @Answer2 <> '[All answers]' 
			begin
			if LEN(@Answer2) = 0
				begin
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + '(Answer2 = '' or Answer2 is Null)'
				end
			else
				begin
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'Answer2 = @Answer2'
				end
			end
		if @Answer3 <> '[All answers]' 
			begin
			if LEN(@Answer3) = 0
				begin
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + '(Answer3 = '' or Answer3 is Null)'
				end
			else
				begin
				set @_SQLCandidateFilter = dbo.svfAnd(@_SQLCandidateFilter) + 'Answer3 = @Answer3'
				end
			end			
		end
	--
	-- Set up sort clause. Combine user selection with defaults.
	--
	set @_SortExpression = ''
	if Len(@SortExpression) > 0					-- user selection?
		begin
		set @_SortExpression = @SortExpression	-- use it
		end
	set @_SortExpression = dbo.svfAddToOrderByClause(@_SortExpression, 'LastName')
	set @_SortExpression = dbo.svfAddToOrderByClause(@_SortExpression, 'FirstName')
	--
	-- Decide which fields to get
	--
	Declare @_Fields as varchar(1000)
	Set @_Fields = 'Active, 
					CandidateID, 
					CandidateNumber, 
					CentreID, 
					DateRegistered, 
					FirstName, 
					LastName,
					JobGroupID,
					Answer1,
					Answer2,
					Answer3,
					AliasID,
					(SELECT JobGroupName FROM JobGroups WHERE (JobGroupID = Candidates.JobGroupID)) AS JobGroupName'
	
	if @BulkDownload = 1
		begin
		Set @_Fields = 'LastName,
						FirstName, 
						CandidateNumber as DelegateID,
						AliasID,
						JobGroupID,
						Answer1,
						Answer2,
						Answer3,
						Active'		
		end
	--
	-- Set up the main query
	--
	
	SET @_SQL = 'SELECT ' + @_Fields + '
				 FROM Candidates 
				 WHERE ' + @_SQLCandidateFilter + ' 
				 ORDER BY ' + @_SortExpression
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
								  @LoginLike varchar(250),
								  @AliasLike varchar(250),
								  @_dtRegisteredLowDate DateTime,
								  @_dtRegisteredHighDate DateTime,
								  @JobGroupID Int,
								  @Answer1 varchar(250),
								  @Answer2 varchar(250),
								  @Answer3 varchar(250)',
					   @CentreID,
					   @FirstNameLike,
					   @LastNameLike,
					   @LoginLike,
					   @AliasLike,
					   @_dtRegisteredLowDate,
					   @_dtRegisteredHighDate,
					   @JobGroupID,
					   @Answer1,
					   @Answer2,
					   @Answer3
END
GO
