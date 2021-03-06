USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 27/11/2015
-- Description:	Checks if an assessment fail threshold has been set and locks the progress record if it has been reached
-- =============================================
CREATE PROCEDURE [dbo].[uspAssessAttemptsCheckAndLockIfExceeded]
	-- Add the parameters for the stored procedure here
	@CandidateID int,
	@CustomisationID int,
	@SectionNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @_Fails AS Int
	SELECT @_Fails = COUNT(AssessAttemptID)
	FROM            AssessAttempts
	WHERE        (CandidateID = @CandidateID) AND (CustomisationID = @CustomisationID) AND (SectionNumber = @SectionNumber) AND (Status = 0)

	DECLARE @_AssessAttempts AS Int
	SELECT TOP(1) @_AssessAttempts = AssessAttempts FROM Applications AS A INNER JOIN Customisations AS C ON A.ApplicationID = C.ApplicationID

	IF @_AssessAttempts > 0
	BEGIN
	IF @_AssessAttempts <= @_Fails
		BEGIN
			UPDATE Progress
			SET PLLocked = 1
			WHERE CandidateID = @CandidateID AND CustomisationID = @CustomisationID AND Completed IS NULL
		END
	END

END
GO
