USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 14/03/13
-- Description:	Deletes all traces of a candidate
-- =============================================
CREATE PROCEDURE [dbo].[uspDeleteCandidateByCandNumber]
	@CandidateNumber varchar(10),
	@CentreID integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	declare @_ReturnCode varchar(100)
	declare @CandidateID int
	set @_ReturnCode = '-1'
	
	Begin
	--Check if candidate exists
	if (SELECT COUNT(*) FROM Candidates WHERE CandidateNumber = @CandidateNumber AND CentreID = @CentreID) = 0 
	BEGIN
	-- Return 1000 if canidate doesn't exist
	set @_ReturnCode = '1000'
	END
	ELSE
	BEGIN
	-- Get the candidate number
	set @CandidateID = (SELECT Top(1) CandidateID FROM Candidates WHERE CandidateNumber = @CandidateNumber AND CentreID = @CentreID)
	-- Delete session records
	DELETE 
FROM         Sessions
WHERE     (CandidateID = @CandidateID)
--Delete asp progress records
DELETE 
FROM         aspProgress
FROM         aspProgress INNER JOIN
                      Progress ON aspProgress.ProgressID = Progress.ProgressID
WHERE     (Progress.CandidateID = @CandidateID)
--Delete Assess Attempts
DELETE 
FROM         AssessAttempts
WHERE     (CandidateID = @CandidateID)


--Delete progress records
DELETE 
FROM         Progress
WHERE     (CandidateID = @CandidateID)

--Delete candidate record
DELETE 
FROM         Candidates
WHERE     (CandidateID = @CandidateID)
set @_ReturnCode = '1'
	End
	SELECT @_ReturnCode
	RETURN @_ReturnCode
END
END
GO
