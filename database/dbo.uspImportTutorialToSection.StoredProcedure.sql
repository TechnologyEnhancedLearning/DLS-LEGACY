USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 13/10/2015
-- Description:	Imports a tutorial to a section.
-- =============================================
CREATE PROCEDURE [dbo].[uspImportTutorialToSection]
	@TutorialID Int,
	@SectionID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Tutorials (SectionID, TutorialName, VideoPath, TutorialPath, SupportingMatsPath, ConsolidationPath, Active, Objectives, DiagAssessOutOf, VideoCount, ObjectiveNum, Keywords, OrderByNumber, OverrideTutorialMins, OriginalTutorialID, ContentTypeID, LearnerMarksCompletion, DefaultMethodID, AssessmentTypeID, EvidenceText, IncludeActionPlan, SupervisorVerify, SupervisorSuccessText, SupervisorFailText, RequireVideoPercent, RequireTutorialCompletion, RequireSupportMatsOpen, [Description]) 
	SELECT @SectionID AS SectionID, TutorialName, VideoPath, TutorialPath, SupportingMatsPath, ConsolidationPath, Active, Objectives, DiagAssessOutOf, VideoCount, ObjectiveNum, Keywords, COALESCE
                             ((SELECT        MAX(OrderByNumber) AS Expr1
                                 FROM            Tutorials
                                 WHERE        (SectionID = @SectionID)) + 1, 1), OverrideTutorialMins, CASE WHEN OriginalTutorialID > 0 then OriginalTutorialID ELSE TutorialID END, ContentTypeID, LearnerMarksCompletion, DefaultMethodID, AssessmentTypeID, EvidenceText, IncludeActionPlan, SupervisorVerify, SupervisorSuccessText, SupervisorFailText, RequireVideoPercent, RequireTutorialCompletion, RequireSupportMatsOpen, [Description]
	FROM Tutorials WHERE TutorialID = @TutorialID AND ArchivedDate IS NULL AND Active = 1
END

GO
