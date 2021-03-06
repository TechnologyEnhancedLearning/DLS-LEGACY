USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Hugh Gibson
-- Create date: 28 January 2011
-- Description:	Creates a new candidate
-- Returns:		varchar(100) - new candidate number
--				'-1' : unexpected error
--				'-2' : some parameters not supplied
--				'-3' : failed, AliasID not unique
-- =============================================
CREATE PROCEDURE [dbo].[uspSaveNewCandidate_V6]
	@CentreID integer,
	@FirstName varchar(250),
	@LastName varchar(250),
	@JobGroupID integer,
	@Active bit,
	@Answer1 varchar(100),
	@Answer2 varchar(100),
	@Answer3 varchar(100),
	@AliasID varchar(250),
	@Approved bit,
	@Email varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--
	-- There are various things to do so wrap this in a transaction
	-- to prevent any problems.
	--
	declare @_ReturnCode varchar(100)
	declare @_NewCandidateNumber varchar(100)
	
	set @_ReturnCode = '-1'
	
	BEGIN TRY
		BEGIN TRANSACTION SaveNewCandidate
		--
		-- Check if parameters are OK
		--
		if len(@FirstName) = 0 or len(@LastName) = 0 or @JobGroupID < 1 or @JobGroupID > 13
			begin
			set @_ReturnCode = '-2'
			raiserror('Error', 18, 1)			
			end
		--
		-- The AliasID must be unique. Note that we also use TABLOCK, HOLDLOCK as hints
		-- in this query. This will place a lock on the Candidates table until the transaction
		-- finishes, preventing other users updating the table e.g. to store another new
		-- candidate.
		--
		if LEN(@AliasID) > 0 
			begin
			declare @_ExistingAliasID as varchar(250)
			set @_ExistingAliasID = (SELECT TOP(1) AliasID FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[CentreID] = @CentreID and c.[AliasID] = @AliasID)
			if (@_ExistingAliasID is not null)
				begin
				set @_ReturnCode = '-3'
				raiserror('Error', 18, 1)
				end
			end
			
			if LEN(@Email) > 0
			begin
			declare @_ExistingEmail as varchar(250)
			set @_ExistingEmail = (SELECT TOP(1) AliasID FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[CentreID] = @CentreID and c.[EmailAddress] = @Email)
				if (@_ExistingEmail is not null)
				begin
				set @_ReturnCode = '-4'
				raiserror('Error', 18, 1)
				end
			end					 
		--
		-- Get the existing maximum candidate number. Do TABLOCK and HOLDLOCK here as well in case AliasID is empty.
		--
		declare @_MaxCandidateNumber as integer
		declare @_Initials as varchar(2)
		set @_Initials = UPPER(LEFT(@FirstName, 1) + LEFT(@LastName, 1))
		set @_MaxCandidateNumber = (SELECT TOP (1) CONVERT(int, SUBSTRING(CandidateNumber, 3, 250)) AS nCandidateNumber
									FROM       Candidates WITH (TABLOCK, HOLDLOCK)
									WHERE     (LEFT(CandidateNumber, 2) = @_Initials)
									ORDER BY nCandidateNumber DESC)
		if @_MaxCandidateNumber is Null
			begin
			set @_MaxCandidateNumber = 0
			end
		set @_NewCandidateNumber = @_Initials + CONVERT(varchar(100), @_MaxCandidateNumber + 1)
		--
		-- Insert the new candidate record
		--
		INSERT INTO Candidates (Active, 
								CentreID, 
								FirstName, 
								LastName, 
								DateRegistered, 
								CandidateNumber,
								JobGroupID,
								Answer1,
								Answer2,
								Answer3,
								AliasID,
								Approved,
								EmailAddress)
				VALUES		   (@Active,
								@CentreID,
								@FirstName,
								@LastName,
								GETUTCDATE(),
								@_NewCandidateNumber,
								@JobGroupID,
								@Answer1,
								@Answer2,
								@Answer3,
								@AliasID,
								@Approved,
								@Email)
		--
		-- All finished
		--
		COMMIT TRANSACTION SaveNewCandidate
		set @_ReturnCode = @_NewCandidateNumber
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION SaveNewCandidate
	END CATCH
	--
	-- Return code indicates errors or success
	--
	SELECT @_ReturnCode
END

GO
