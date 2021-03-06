USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 13/10/2015
-- Description:	Takes an @SectionID and inserts a new section with the same details and then creates copies of all of the tutorials beneath it.
-- =============================================
CREATE PROCEDURE [dbo].[uspImportSectionToCourse]
	-- Add the parameters for the stored procedure here
	@SectionID Int,
	@CourseID Int,
	@CreatedByID Int,
	@createdByCentreID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @_NewSectionID as Int = 0
    -- Insert statements for procedure here
	INSERT INTO dbo.Sections (ApplicationID, SectionName, SectionNumber, ConsolidationPath, DiagAssessPath, PLAssessPath, CreatedByID, CreatedByCentreID) SELECT TOP(1) @CourseID AS CourseID, SectionName, COALESCE
                             ((SELECT        MAX(SectionNumber) AS Expr1
                                 FROM            Sections
                                 WHERE        (ApplicationID = @CourseID)) + 1, 1) AS SectionNumber, ConsolidationPath, DiagAssessPath, PLAssessPath, @CreatedByID AS CreatedByID, @createdByCentreID AS CreatedByCentreID
								 FROM dbo.Sections WHERE SectionID = @SectionID
	SET @_NewSectionID = SCOPE_IDENTITY()
	INSERT INTO dbo.Tutorials (SectionID, TutorialName, VideoPath, TutorialPath, SupportingMatsPath, ConsolidationPath, Active, Objectives, DiagAssessOutOf, VideoCount, ObjectiveNum, Keywords, OrderByNumber, OverrideTutorialMins, OriginalTutorialID) 
	SELECT @_NewSectionID AS SectionID, TutorialName, VideoPath, TutorialPath, SupportingMatsPath, ConsolidationPath, Active, Objectives, DiagAssessOutOf, VideoCount, ObjectiveNum, Keywords, OrderByNumber, OverrideTutorialMins, CASE WHEN OriginalTutorialID > 0 then OriginalTutorialID ELSE TutorialID END
	FROM Tutorials WHERE SectionID = @SectionID AND ArchivedDate IS NULL AND Active = 1


END

GO
