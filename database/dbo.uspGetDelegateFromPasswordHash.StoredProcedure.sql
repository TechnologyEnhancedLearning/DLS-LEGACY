USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 25/03/2019
-- Description:	Extract password given reminder hash
-- Returns:		Candidate ID.
--              If < 1, there was a problem.
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDelegateFromPasswordHash]
	@Hash nvarchar(36),
	@Email nvarchar(255)
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--
	-- There are various things to do so wrap this in a transaction
	-- to prevent any problems.
	--
	declare @_ReturnCode int
	set @_ReturnCode = -1
	BEGIN TRY
		BEGIN TRANSACTION GetPassword

		declare @_CandidateID as int
		set @_CandidateID = -1
		--
		-- Check if anything has been passed in
		--
		if len(@Hash) != 36 
			begin
			raiserror('Error', 18, 1)			
			end
		--
		-- Get the password.
		--
		set @_CandidateID = (SELECT TOP 1 CandidateID 
						  FROM Candidates 
						  WHERE	(ResetHash = @Hash) and (EmailAddress = @Email))
		--
		-- Reset the flags for that record, ignoring the 2 hour rule. 
		-- That way we keep the data clean.
		--
		--UPDATE Candidates SET 
		--					  ResetHash = Null 
		--		WHERE CandidateID = @_CandidateID
		--
		-- All finished
		--
		COMMIT TRANSACTION GetPassword
		set @_ReturnCode = @_CandidateID
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION GetPassword
	END CATCH
	--
	-- Return code indicates errors or success
	--
	SELECT @_ReturnCode
END
GO
