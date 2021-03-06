USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 12/06/14
-- Description:	Returns knoweldge bank matches using dynamic SQL
-- =============================================
CREATE PROCEDURE [dbo].[uspSearchKnowledgeBankByLevel] 
	-- parameters
	@CandidateID as Int = 0,
	@OfficeVersionCSV as varchar(30),
	@ApplicationCSV as varchar(30),
	@ApplicationGroupCSV as varchar(30),
	@SearchTerm as varchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF 1=0 BEGIN
    SET FMTONLY OFF
END
    --
	-- These define the SQL to use
	--
	DECLARE @_SQL nvarchar(max)
	DECLARE @_SQLFilter nvarchar(max)
	DECLARE @_SQLJoin nvarchar(max)
	DECLARE @_SQLCompletedFilterDeclaration nvarchar(max)
	
	-- Build application filter string
	Set @_SQLFilter = ''
	if Len(@OfficeVersionCSV) > 0
	begin
		set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + 'OfficeVersionID IN (' + @OfficeVersionCSV + ')'
	end
	if Len(@ApplicationCSV) > 0
	begin
		set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + 'OfficeAppID IN (' + @ApplicationCSV + ')'
	end
	if Len(@ApplicationGroupCSV) > 0
	begin
		set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + 'AppGroupID IN (' + @ApplicationGroupCSV + ')'
	end
    Set @_SQLFilter = 'SELECT ApplicationID FROM Applications ' + @_SQLFilter
	-- 
	--Build the main query
	SET @_SQL = 'SELECT TOP (20) t.TutorialID, t.TutorialName, REPLACE(t.VideoPath, ''swf'', ''mp4'') + ''.jpg'' AS VideoPath, a.MoviePath + t.TutorialPath As TutorialPath, t.Objectives, a.AppGroupID, a.ShortAppName, t.VideoCount, COALESCE(COUNT(vr.VideoRatingID), 0) AS Rated, 
				CONVERT(Decimal(10, 1), COALESCE(AVG(vr.Rating * 1.0),0)) AS VidRating, @CandidateID as CandidateID, a.hEmbedRes, a.vEmbedRes
				FROM     VideoRatings AS vr RIGHT OUTER JOIN 
				Tutorials AS t ON vr.TutorialID = t.TutorialID INNER JOIN 
				Sections AS s ON t.SectionID = s.SectionID INNER JOIN 
				Applications AS a ON s.ApplicationID = a.ApplicationID '
	--If a search term has been given, create the join to the freetexttable
	set @_SQLJoin = ''
	if Len(@SearchTerm) > 0
	begin
		set @_SQLJoin = ' INNER JOIN FREETEXTTABLE(dbo.Tutorials, (Objectives,Keywords), ''' + @SearchTerm + ''') AS KEY_TBL ON t.TutorialID = KEY_TBL.[KEY]'
		SET @_SQL = @_SQL + @_SQLJoin
	end
	-- Finish off the query adding the where clause with the application filter
	set @_SQL = @_SQL + ' WHERE (t.Active = 1) AND (t.VideoPath IS NOT NULL) AND a.ApplicationID IN (' + @_SQLFilter + ') '
	Declare @_GroupBy nvarchar(max)
	set @_GroupBy = ''
	if Len(@SearchTerm) > 0
	begin
		SET @_GroupBy ='GROUP BY KEY_TBL.RANK, t.TutorialID, t.TutorialName, t.VideoPath, a.MoviePath + t.TutorialPath, t.Objectives, a.AppGroupID, t.VideoCount, a.ShortAppName, a.hEmbedRes, a.vEmbedRes ORDER BY AppGroupID, KEY_TBL.RANK DESC'
	END
	if Len(@_GroupBy) <= 0
	begin
		SET @_GroupBy = 'GROUP BY t.TutorialID, t.TutorialName, t.VideoPath, a.MoviePath + t.TutorialPath, t.Objectives, a.AppGroupID, t.VideoCount, a.ShortAppName, a.hEmbedRes, a.vEmbedRes ORDER BY  VidRating DESC, t.VideoCount DESC, Rated DESC'
	END
	set @_SQL = @_SQL + @_GroupBy
	--For debug only (comment out in deployment code):
	PRINT @_SQL
	DECLARE @results TABLE (TutorialID int not null primary key, TutorialName varchar(255), VideoPath varchar(4000), TutorialPath varchar(255), Objectives varchar(MAX), AppGroupID int, ShortAppName varchar(100), VideoCount Int, Rated Int,  VidRating Decimal(10,1), CandidateID Int, hEmbedRes Int, vEmbedRes Int  ) 
	INSERT INTO @results EXEC sp_executesql @_SQL, 	N'@CandidateID as Int,
	@OfficeVersionCSV as varchar(30),
	@ApplicationCSV as varchar(30),
	@ApplicationGroupCSV as varchar(30),
	@SearchTerm as varchar(255)',
					   @CandidateID,
					   @OfficeVersionCSV,
					   @ApplicationCSV,
					   @ApplicationGroupCSV,
					   @SearchTerm
	SELECT * FROM @results ORDER BY  AppGroupID, VidRating DESC, VideoCount DESC, Rated DESC
END
GO
