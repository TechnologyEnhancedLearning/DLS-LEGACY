USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 07/06/19
-- Description:	Returns knoweldge bank matches using dynamic SQL - V3 reworks to use Brand, Cat and Topic fields
-- =============================================
CREATE PROCEDURE [dbo].[uspSearchKnowledgeBank_V3] 
	-- parameters
	@CentreID int,
	@CandidateID Int,
	@BrandCSV varchar(30),
	@CategoryCSV varchar(80),
	@TopicCSV varchar(180),
	@SearchTerm varchar(255)
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
	
	
    Set @_SQLFilter = 'SELECT A1.ApplicationID FROM Applications AS A1 INNER JOIN CentreApplications AS CA1 ON A1.ApplicationID = CA1.ApplicationID WHERE (A1.ArchivedDate IS NULL) AND (CA1.CentreID = ' + CAST(@CentreID as varchar) + ')' + @_SQLFilter
    if Len(@BrandCSV) > 0
	begin
		set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + 'BrandID IN (' + @BrandCSV + ')'
	end
	if Len(@CategoryCSV) > 0
	begin
		set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + 'CourseCategoryID IN (' + @CategoryCSV + ')'
	end
	if Len(@TopicCSV) > 0
	begin
		set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + 'CourseTopicID IN (' + @TopicCSV + ')'
	end
	-- 
	--Build the main query
	SET @_SQL = 'SELECT TOP (20) t.TutorialID, t.TutorialName, REPLACE(t.VideoPath, ''swf'', ''mp4'') + ''.jpg'' AS VideoPath, a.MoviePath + t.TutorialPath As TutorialPath, t.Objectives, a.AppGroupID, COALESCE(a.ShortAppName, a.ApplicationName) AS ShortAppName, t.VideoCount, COALESCE(COUNT(vr.VideoRatingID), 0) AS Rated, 
				CONVERT(Decimal(10, 1), COALESCE(AVG(vr.Rating * 1.0),0)) AS VidRating, ' + CAST(@CandidateID as varchar) + ' as CandidateID, a.hEmbedRes, a.vEmbedRes
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
	set @_SQL = @_SQL + ' WHERE (t.Active = 1) AND (a.ASPMenu = 1) AND (a.BrandID NOT IN (SELECT BrandID FROM KBCentreBrandsExcludes WHERE CentreID = ' + CAST(@CentreID as varchar) + ')) AND (a.CourseCategoryID NOT IN (SELECT CategoryID FROM KBCentreCategoryExcludes WHERE CentreID = ' + CAST(@CentreID as varchar) + ')) AND (a.ApplicationID IN (' + @_SQLFilter + ')) '
	Declare @_GroupBy nvarchar(max)
	set @_GroupBy = ''
	if Len(@SearchTerm) > 0
	begin
		SET @_GroupBy ='GROUP BY KEY_TBL.RANK, t.TutorialID, t.TutorialName, t.VideoPath, a.MoviePath + t.TutorialPath, t.Objectives, a.AppGroupID, t.VideoCount, a.ShortAppName, a.ApplicationName, a.hEmbedRes, a.vEmbedRes ORDER BY KEY_TBL.RANK DESC'
	END
	if Len(@_GroupBy) <= 0
	begin
		SET @_GroupBy = 'GROUP BY t.TutorialID, t.TutorialName, t.VideoPath, a.MoviePath + t.TutorialPath, t.Objectives, a.AppGroupID, t.VideoCount, a.ShortAppName, a.ApplicationName, a.hEmbedRes, a.vEmbedRes ORDER BY  VidRating DESC, t.VideoCount DESC, Rated DESC'
	END
	set @_SQL = @_SQL + @_GroupBy
	--For debug only (comment out in deployment code):
	PRINT @_SQL
	DECLARE @results TABLE (TutorialID int not null primary key, TutorialName varchar(255), VideoPath varchar(4000), TutorialPath varchar(255), Objectives varchar(MAX), AppGroupID int, ShortAppName varchar(100), VideoCount Int, Rated Int,  VidRating Decimal(10,1), CandidateID Int, hEmbedRes Int, vEmbedRes Int  ) 
	INSERT INTO @results EXEC sp_executesql @_SQL, 	N'@CentreID as Int,
	@CandidateID as Int,
	@BrandCSV as varchar(30),
	@CategoryCSV as varchar(80),
	@TopicCSV as varchar(180),
	@SearchTerm as varchar(255)',
					   @CentreID,
					   @CandidateID,
					   @BrandCSV,
					   @CategoryCSV,
					   @TopicCSV,
					   @SearchTerm
	SELECT * FROM @results 
END

GO
