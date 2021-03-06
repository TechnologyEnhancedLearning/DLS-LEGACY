USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 05/10/2018
-- Description:	Returns active available customisations for centre V2 simplified to remove filters ready for dx bootstrap gridview use.
-- =============================================
CREATE PROCEDURE [dbo].[GetActiveAvailableCustomisationsForCentreFiltered_V3]
	-- Add the parameters for the stored procedure here
	@CentreID as Int = 0,
	@CandidateID as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT cu.CustomisationID, cu.Active, cu.CurrentVersion, cu.CentreID, cu.ApplicationID, a.ApplicationName + ' - ' + cu.CustomisationName AS CourseName, cu.CustomisationText, 
               cu.IsAssessed, dbo.CheckCustomisationSectionHasDiagnostic(cu.CustomisationID, 0) AS HasDiagnostic, 
               dbo.CheckCustomisationSectionHasLearning(cu.CustomisationID, 0) AS HasLearning, (SELECT BrandName FROM Brands WHERE BrandID = a.BrandID) AS Brand, (SELECT CategoryName FROM CourseCategories WHERE CourseCategoryID = a.CourseCategoryID) AS Category, (SELECT CourseTopic FROM CourseTopics WHERE CourseTopicID = a.CourseTopicID) AS Topic, dbo.CheckDelegateStatusForCustomisation(cu.CustomisationID, @CandidateID) AS DelegateStatus
FROM  Customisations AS cu INNER JOIN
               Applications AS a ON cu.ApplicationID = a.ApplicationID WHERE (cu.CentreID = @CentreID) AND (cu.Active = 1) AND (cu.HideInLearnerPortal = 0) AND (a.ASPMenu = 1) AND (a.ArchivedDate IS NULL) AND (dbo.CheckDelegateStatusForCustomisation(cu.CustomisationID, @CandidateID) IN (0,1,4)) AND (cu.CustomisationName <> 'ESR') ORDER BY a.ApplicationName + ' - ' + cu.CustomisationName

END


GO
