USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 11/06/2018
-- Description:	Deletes delegate records for a centre where no progress exists for delegate
-- =============================================
CREATE PROCEDURE [dbo].[PurgeDelegatesForCentre]
	-- Add the parameters for the stored procedure here
	@CentreID Int,
	@TestOnly bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Check how many records meet criteria
SELECT COUNT(CandidateID) FROM Candidates WHERE (SelfReg = 0) AND (CentreID = @CentreID) AND (CandidateID NOT IN (SELECT CandidateID FROM Progress))AND (CandidateID NOT IN (SELECT CandidateID FROM Sessions))
    -- If not test only then delete them
    IF @TestOnly = 0
    BEGIN
	DELETE FROM Candidates WHERE (SelfReg = 0) AND (CentreID = @CentreID) AND (CandidateID NOT IN (SELECT CandidateID FROM Progress))AND (CandidateID NOT IN (SELECT CandidateID FROM Sessions))
	END
END

GO
