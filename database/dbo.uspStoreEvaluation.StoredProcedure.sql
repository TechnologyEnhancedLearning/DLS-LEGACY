USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 25 August 2010
-- Description:	Stores the evaluation status and creates a record. 
-- Returns:		0 for success and course assessed, 1 failure 
-- =============================================
CREATE PROCEDURE [dbo].[uspStoreEvaluation]
	@CandidateNumber varchar(250),
	@CustomisationID Integer,
	@Q1 Tinyint,
	@Q2 Tinyint,
	@Q3 Tinyint,
	@Q4 Tinyint,
	@Q5 Tinyint,
	@Q6 Tinyint,
	@Q7 Tinyint,
	@Band int,
	@DelName varchar(50),
	@DelContact varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--
	-- Update the Progress table and the Evaluations table. Do this in a transaction
	-- with proper error handling.
	--
	BEGIN TRY
		BEGIN TRANSACTION UpdateEvaluation
		--
		-- Convert the Candidate Number into an ID
		--
		declare @_CandidateID Integer
		set @_CandidateID = (SELECT CandidateID FROM Candidates WHERE CandidateNumber = @CandidateNumber)
		if @_CandidateID = Null 
			raiserror('CandidateNumberError', 18, 1)
		--
		-- Set the time that the Evaluation was carried out
		--
		UPDATE Progress 
			SET Evaluated = GetUTCDate() 
			WHERE CandidateID = @_CandidateID AND CustomisationID = @CustomisationID AND Completed IS NOT NULL AND Evaluated IS NULL
		--
		-- Should be just one Progress record affected
		--
		if @@ROWCOUNT <> 1
			raiserror('ProgressError', 18, 1)
		--
		-- Create an evaluation record using the information passed in
		--
		declare @_JobGroupID integer
		set @_JobGroupID = (SELECT JobGroupID FROM Candidates WHERE CandidateID = @_CandidateID)
		INSERT INTO Evaluations (JobGroupID, CustomisationID, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Band, delName, delContact)
			VALUES (@_JobGroupID,
					@CustomisationID,
					@Q1, @Q2, @Q3, @Q4, @Q5, @Q6, @Q7, @Band, @DelName, @DelContact)
		if @@ROWCOUNT <> 1
			raiserror('EvaluationsError', 18, 1)
					
		COMMIT TRANSACTION UpdateEvaluation
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION UpdateEvaluation
		--
		-- Indicate an error
		--
		SELECT 1
		-- Code to re-raise an error
		-- DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
		-- SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY()
		-- RAISERROR(@ErrMsg, @ErrSeverity, 1)
	END CATCH
	--
	-- All OK.
	--
	SELECT 0
END
GO
