USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 02/12/2019
-- Description:	Gets anonymous filtered self assessment outcome data for dashboard reports
-- =============================================
CREATE PROCEDURE [dbo].[GetSelfAssessmentDashboardDataPivot]
	-- Add the parameters for the stored procedure here
	@CentreID Int,
	@BrandID Int,
	@Category Int,
	@Topic Int,
	@ApplicationID int,
	@SectionName nvarchar(255),
	@TutorialName nvarchar(255),
	@Answer1 nvarchar(100),
	@Answer2 nvarchar(100),
	@Answer3 nvarchar(100),
	@Answer4 nvarchar(100),
	@Answer5 nvarchar(100),
	@Answer6 nvarchar(100),
	@FilterDate bit,
	@StartDate datetime,
	@EndDate datetime,
	@VerifiedOnly bit,
	@JobGroupID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.	
	SET NOCOUNT ON;
	--create temp table with filtered values:

	DECLARE 
	-- create columns list and generate dynamic sql
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';

	--populate columns list
SET @columns = STUFF((SELECT distinct ',' + QUOTENAME([DescriptorText]
) AS Expr1
            FROM tvfGetSelfAssessmentDashboardData(@CentreID,
	@BrandID,
	@Category,
	@Topic,
	@ApplicationID,
	@SectionName,
	@TutorialName,
	@Answer1,
	@Answer2,
	@Answer3,
	@Answer4,
	@Answer5,
	@Answer6,
	@FilterDate,
	@StartDate,
	@EndDate,
	@VerifiedOnly,
	@JobGroupID) ORDER BY Expr1
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')



PRINT @columns
-- construct dynamic SQL
SET @sql ='SELECT TutorialName AS Skill, ' + @columns + ' FROM   
(
  SELECT 

        TutorialName, DescriptorText, aspProgressID
FROM            tvfGetSelfAssessmentDashboardData(@CentreID,
	@BrandID,
	@Category,
	@Topic,
	@ApplicationID,
	@SectionName,
	@TutorialName,
	@Answer1,
	@Answer2,
	@Answer3,
	@Answer4,
	@Answer5,
	@Answer6,
	@FilterDate,
	@StartDate,
	@EndDate,
	@VerifiedOnly,
	@JobGroupID)
) t 
PIVOT(
    COUNT(aspProgressID) 
    FOR DescriptorText IN ('+ @columns +')
	) p';
 
-- execute the dynamic SQL
EXECUTE sp_executesql @sql, 
  N'@CentreID Int,
	@BrandID Int,
	@Category Int,
	@Topic Int,
	@ApplicationID Int,
	@SectionName nvarchar(255),
	@TutorialName nvarchar(255),
	@Answer1 nvarchar(100),
	@Answer2 nvarchar(100),
	@Answer3 nvarchar(100),
	@Answer4 nvarchar(100),
	@Answer5 nvarchar(100),
	@Answer6 nvarchar(100),
	@FilterDate bit,
	@StartDate datetime,
	@EndDate datetime,
	@VerifiedOnly bit,
	@JobGroupID int', 
	@CentreID,
	@BrandID,
	@Category,
	@Topic,
	@ApplicationID,
	@SectionName,
	@TutorialName,
	@Answer1,
	@Answer2,
	@Answer3,
	@Answer4,
	@Answer5,
	@Answer6,
	@FilterDate,
	@StartDate,
	@EndDate,
	@VerifiedOnly,
	@JobGroupID;
END
GO
