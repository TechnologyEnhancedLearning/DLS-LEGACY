USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 23/01/2019
-- Description:	Built to test issue descrbed in http://itskillssql.uksouth.cloudapp.azure.com/trackingrefactor/ticket/173
-- =============================================
CREATE FUNCTION [dbo].[ReturnCompletionStatusForProgressID]
(
	-- Add the parameters for the function here
	@ProgressID int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @_IsAssess Bit
DECLARE @_TutCompletionThreshold Int
DECLARE @_DiagCompletionThreshold Int
DECLARE @_PLAssess Bit
DECLARE @_LaunchedAssess Bit
DECLARE @_BetaTesting Bit
DECLARE @_LaunchedDiag Bit
SELECT     @_TutCompletionThreshold = c.TutCompletionThreshold, @_DiagCompletionThreshold = c.DiagCompletionThreshold, @_IsAssess = c.IsAssessed, @_PLAssess = Applications.PLAssess, @_LaunchedDiag = Applications.DiagAssess, @_LaunchedAssess = Applications.LaunchedAssess, @_BetaTesting = ct.BetaTesting
FROM         Customisations AS c INNER JOIN
					  Progress AS p ON c.CustomisationID = p.CustomisationID INNER JOIN
					  Applications ON c.ApplicationID = Applications.ApplicationID INNER JOIN
					  Centres AS ct ON c.CentreID = ct.CentreID
WHERE     (p.ProgressID = @ProgressID)
--Check PL assessments are available
--IF @_BetaTesting = 1 OR @_LaunchedAssess = 1
--BEGIN
--Check assessments are switched on in customisation
DECLARE @_RetVal Int
	SET @_RetVal = 1
	IF @_IsAssess = 1
	BEGIN
-- Check if all assessments are have been passed and return 1 if so or 0 if not and then exit
	DECLARE @_SectionsPassed Int
	DECLARE @_Sections Int
		BEGIN
			SELECT    @_SectionsPassed =  COUNT(Passes)
FROM         (SELECT     DISTINCT(aa.SectionNumber) AS Passes
FROM            Progress AS p INNER JOIN
                         Customisations AS c ON p.CustomisationID = c.CustomisationID INNER JOIN
                         AssessAttempts AS aa ON p.ProgressID = aa.ProgressID
WHERE        (aa.Status = 1) AND (p.ProgressID = @ProgressID)) AS sq1
		END
		BEGIN
			SELECT     @_Sections = COUNT(s.SectionID) 
			FROM         Sections AS s INNER JOIN
					  Applications AS a ON s.ApplicationID = a.ApplicationID INNER JOIN
					  Customisations AS c ON a.ApplicationID = c.ApplicationID INNER JOIN
					  Progress AS p ON c.CustomisationID = p.CustomisationID
			WHERE     (p.ProgressID = @ProgressID) AND (NOT (s.PLAssessPath IS NULL)) AND (s.ArchivedDate IS NULL)
		END
	If @_SectionsPassed < @_Sections OR @_Sections = 0 OR @_SectionsPassed = 0
		BEGIN
		-- PL Assessments not passed - course not complete - return 0:
	SET @_RetVal = 0
		END
		ELSE
		BEGIN
		--Return value = 2 for post learning assessment passed (make cert available):
		SET @_RetVal = 2
		END
	END
	ELSE
	BEGIN
	--PL Assessments are not switched on - check diagnostic
	
	IF @_DiagCompletionThreshold > 0 AND (@_LaunchedDiag = 1)
		BEGIN
			DECLARE @_DiagnosticScore Int
				SELECT   @_DiagnosticScore =  CAST((SUM(ap.DiagHigh) * 1.0) / (SUM(t.DiagAssessOutOf) * 1.0) * 100 AS Int)
				FROM         aspProgress AS ap INNER JOIN
					  Progress AS p ON ap.ProgressID = p.ProgressID INNER JOIN
					  Customisations AS c ON p.CustomisationID = c.CustomisationID INNER JOIN
					  CustomisationTutorials AS ct ON ap.TutorialID = ct.TutorialID AND c.CustomisationID = ct.CustomisationID INNER JOIN
					  Tutorials AS t ON ct.TutorialID = t.TutorialID
				WHERE     (ap.ProgressID = @ProgressID) AND (ct.DiagStatus = 1)
				IF @_DiagnosticScore < @_DiagCompletionThreshold
				BEGIN
				-- Diagnostic threshold not met - course not complete - return 0:				
					SET @_RetVal = 0
				END
		END
		
	IF @_TutCompletionThreshold > 0
		BEGIN
			DECLARE @_Done Int
			DECLARE @_Outof Int
			SELECT     @_Done = SUM(aspProgress.TutStat) / 2
FROM         aspProgress INNER JOIN
					  Progress ON aspProgress.ProgressID = Progress.ProgressID INNER JOIN
					  Customisations ON Progress.CustomisationID = Customisations.CustomisationID INNER JOIN
					  CustomisationTutorials ON Customisations.CustomisationID = CustomisationTutorials.CustomisationID AND 
					  aspProgress.TutorialID = CustomisationTutorials.TutorialID
WHERE     (CustomisationTutorials.Status = 1) AND (aspProgress.ProgressID = @ProgressID)
SELECT     @_Outof = COUNT(aspProgress.aspProgressID)
FROM         aspProgress INNER JOIN
					  Progress ON aspProgress.ProgressID = Progress.ProgressID INNER JOIN
					  Customisations ON Progress.CustomisationID = Customisations.CustomisationID INNER JOIN
					  CustomisationTutorials ON Customisations.CustomisationID = CustomisationTutorials.CustomisationID AND 
					  aspProgress.TutorialID = CustomisationTutorials.TutorialID
WHERE     (CustomisationTutorials.Status = 1) AND (aspProgress.ProgressID = @ProgressID)
IF @_Done < (@_TutCompletionThreshold*1.0/100)*(@_Outof*1.0)
BEGIN
-- Learning threshold not met - course not complete - return 0:
SET @_RetVal = 0
END
			END
			END
			if @ProgressID < 1
	BEGIN
	SET @_RetVal = 0
	END
		
		Return (SELECT @_RetVal)

END

GO
