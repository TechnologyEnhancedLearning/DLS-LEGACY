USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 24/09/2018
-- Description:	Inserts an assessment attempt as long as it isn't a duplicate.
-- =============================================
CREATE PROCEDURE [dbo].[InsertAssessAttempt]
	-- Add the parameters for the stored procedure here
	@CandidateID int,
	@CustomisationID int,
	@CustomisationVersion int,
	@Date datetime,
	@SectionNumber int,
	@Score int,
	@Status bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- Get the current progressID
	DECLARE @_ProgID Int
	SELECT @_ProgID = MAX(ProgressID) FROM Progress WHERE (CustomisationID = @CustomisationID) AND (CandidateID = @CandidateID) AND (RemovedDate IS NULL)
	--Check we are not inserting a duplicate
	if not exists (SELECT * FROM AssessAttempts AS aa WHERE ProgressID = @_ProgID AND SectionNumber = @SectionNumber AND Score = @Score and (DATEADD(mi, DATEDIFF(mi, 0, [Date]), 0) = DATEADD(mi, DATEDIFF(mi, 0, @Date), 0)))
	begin
	--Insert the assessment attempt including the old CustomisationID and CandidateID fields for integrity sake:
	INSERT INTO AssessAttempts
                  (CandidateID, CustomisationID, CustomisationVersion, Date, AssessInstance, SectionNumber, Score, Status, ProgressID)
VALUES (@CandidateID,@CustomisationID,@CustomisationVersion,@Date,1,@SectionNumber,@Score,@Status, @_ProgID)

--Lock the progress record if this was a fail and if necessary:
IF @Status = 0
BEGIN
DECLARE @AssessAttempts Int

SELECT @AssessAttempts = AssessAttempts FROM Applications AS a INNER JOIN Customisations AS c ON a.ApplicationID = c.ApplicationID WHERE c.CustomisationID = @CustomisationID
IF @AssessAttempts > 0
--We need to count attempts and lock if necessary:
BEGIN
IF (SELECT Count(*) FROM AssessAttempts AS aa WHERE ProgressID = @_ProgID AND SectionNumber = @SectionNumber AND Status = 0) >= @AssessAttempts
BEGIN
--Lock progress:
Update Progress SET PLLocked = 1 WHERE ProgressID = @_ProgID
end
END
END
END
END
GO
