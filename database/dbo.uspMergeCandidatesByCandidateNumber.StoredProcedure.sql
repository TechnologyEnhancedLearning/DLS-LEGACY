USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 14/03/13
-- Description:	Merges old candidate record to new and then deletes
-- =============================================
CREATE PROCEDURE [dbo].[uspMergeCandidatesByCandidateNumber]
	@CandidateNumberOLD varchar(10),
	@CandidateNumberNEW varchar(10),
	@CentreID integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	declare @_ReturnCode varchar(100)
	declare @CandidateIDOLD int
	declare @CandidateIDNEW int
	set @_ReturnCode = '-1'
	
	Begin
	--Check if candidate exists
	if (SELECT COUNT(*) FROM Candidates WHERE CandidateNumber = @CandidateNumberOLD AND CentreID = @CentreID) = 0 
	BEGIN
	-- Return 1000 if old canidate doesn't exist
	set @_ReturnCode = '1000'
	END
	ELSE
	if (SELECT COUNT(*) FROM Candidates WHERE CandidateNumber = @CandidateNumberNEW AND CentreID = @CentreID) = 0 
	BEGIN
	-- Return 1000 if new canidate doesn't exist
	set @_ReturnCode = '1001'
	END
	ELSE
	BEGIN
	-- Get the old candidate number
	set @CandidateIDOLD = (SELECT Top(1) CandidateID FROM Candidates WHERE CandidateNumber = @CandidateNumberOLD AND CentreID = @CentreID)
	-- Get the new candidate number
	set @CandidateIDNEW = (SELECT Top(1) CandidateID FROM Candidates WHERE CandidateNumber = @CandidateNumberNEW AND CentreID = @CentreID)
	-- Update session records
UPDATE    Sessions
SET              CandidateID = @CandidateIDNEW
WHERE     (CandidateID = @CandidateIDOLD)
--Update Assess Attempts
UPDATE    AssessAttempts
SET              CandidateID = @CandidateIDNEW
WHERE     (CandidateID = @CandidateIDOLD)
--Update progress records
UPDATE    Progress
SET              CandidateID = @CandidateIDNEW
WHERE     (CandidateID = @CandidateIDOLD) AND (CustomisationID NOT IN (SELECT CustomisationID from Progress AS P2 where P2.CandidateID = @CandidateIDNEW))
--Set removed date on any progress that does match
UPDATE    Progress
SET              CandidateID = @CandidateIDNEW, RemovedDate = Coalesce(RemovedDate, getDate()), RemovalMethodID= COALESCE(RemovalMethodID,4)
WHERE     (CandidateID = @CandidateIDOLD) AND (CustomisationID IN (SELECT CustomisationID from Progress AS P2 where P2.CandidateID = @CandidateIDNEW))
--UPDATE videotrack records:
UPDATE kbVideoTrack
SET CandidateID = @CandidateIDNEW
WHERE (CandidateID = @CandidateIDOLD)

-- Delete any remaining progress records
DELETE 
FROM         Progress
WHERE     (CandidateID = @CandidateIDOLD)
--Delete old candidate record
DELETE 
FROM         Candidates
WHERE     (CandidateID = @CandidateIDOLD)
set @_ReturnCode = '1'
	END
	END
	SELECT @_ReturnCode
	RETURN @_ReturnCode
END
GO
