USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 20/08/2019
-- Description:	Submits a self assessment rating and archives old values where necessary
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAspProgressForCompetency_V2]
	-- Add the parameters for the stored procedure here
	@aspProgressID int,
	@AssessmentTypeDescriptorID int,
	@OutcomeEvidenceText nvarchar(MAX),
	@CandidateID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF (SELECT SupervisorVerifiedDate FROM aspProgress WHERE aspProgressID = @aspProgressID) IS NOT NULL
	--Add an entry to the SelfAssessLog
	BEGIN

INSERT INTO [dbo].[aspSelfAssessLog]
           ([aspProgressID]
           ,[AssessDescriptorID]
           ,[OutcomesEvidence]
           ,[SupervisorVerifiedID]
           ,[SupervisorVerifiedDate]
           ,[SupervisorOutcome]
           ,[SupervisorVerifiedComments]
           ,[LastReviewed]
		   ,[ReviewedByCandidateID])
     SELECT aspProgressID, AssessDescriptorID, OutcomesEvidence, SupervisorVerifiedID, SupervisorVerifiedDate, SupervisorOutcome, SupervisorVerifiedComments, LastReviewed, ReviewedByCandidateID FROM aspProgress WHERE aspProgressID = @aspProgressID
         	
	END
	--Clear supervisor verification info and add new values:
	DECLARE @ReqSV bit
	
	SELECT   @ReqSV = t.SupervisorVerify
FROM            aspProgress AS ap INNER JOIN
                         Tutorials AS t ON ap.TutorialID = t.TutorialID
WHERE        (ap.aspProgressID = @aspProgressID)
DECLARE @_TutStat int = 1
IF @ReqSV = 0
begin
set @_TutStat = 2
end
			UPDATE aspProgress
			SET AssessDescriptorID = @AssessmentTypeDescriptorID, TutStat = CASE WHEN TutStat < @_TutStat THEN @_TutStat ELSE TutStat END, [OutcomesEvidence] = @OutcomeEvidenceText, SupervisorOutcome = NULL, SupervisorVerifiedComments = NULL, SupervisorVerifiedDate = NULL, SupervisorVerifiedID = NULL, LastReviewed = GetDate(), ReviewedByCandidateID = @CandidateID
			WHERE aspProgressID = @aspProgressID
END
GO
