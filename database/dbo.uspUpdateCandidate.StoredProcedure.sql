USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 1 February 2011
-- Description:	Update candidate information
-- Returns:		integer - status
--				0 : updated values
--				1 : no values changed
--				2 : AliasID didn't exist so must create new candidate
--				'-1' : unexpected error
--				'-2' : some parameters not supplied
--				'-3' : failed, AliasID not unique
--				'-4' : failed, existing Candidate not found on DelegateID
-- =============================================
CREATE PROCEDURE [dbo].[uspUpdateCandidate]
	@CentreID integer,
	@DelegateID varchar(250),
	@FirstName varchar(250),
	@LastName varchar(250),
	@JobGroupID integer,
	@Active bit,
	@Answer1 varchar(100),
	@Answer2 varchar(100),
	@Answer3 varchar(100),
	@AliasID varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--
	-- There are various things to do so wrap this in a transaction
	-- to prevent any problems.
	--
	declare @_ReturnCode integer
	set @_ReturnCode = -1
	
	BEGIN TRY
		BEGIN TRANSACTION UpdateCandidate
		--
		-- Check if parameters are OK
		--
		if len(@FirstName) = 0 or len(@LastName) = 0 or @JobGroupID < 1 or @JobGroupID > 13 or (LEN(@DelegateID) = 0 and LEN(@AliasID) = 0)
			begin
			set @_ReturnCode = -2		-- some required parameters missing
			raiserror('Error', 18, 1)			
			end
		--
		-- The AliasID must be unique. Check if any existing record matches and if so,
		-- disallow it if the DelegateID (CandidateNumber) doesn't match.
		-- Note TABLOCK and HOLDLOCK used on Candidates table to make sure the table
		-- isn't modified until we're finished.
		--
		declare @_ExistingDelegateID as varchar(250)
		declare @_ExistingID as integer
		
		if LEN(@AliasID) > 0 and LEN(@DelegateID) > 0
			begin
			set @_ExistingDelegateID = (SELECT TOP(1) CandidateNumber FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[CentreID] = @CentreID and c.[AliasID] = @AliasID)
			if (@_ExistingDelegateID is not null and @_ExistingDelegateID <> @DelegateID)
				begin
				set @_ReturnCode = -3	-- Alias exists for centre for another Candidate
				raiserror('Error', 18, 1)
				end
			end
		--
		-- Check if candidate exists. This also gives us the identity column value
		-- for the candidate if there already.
		-- There are two cases depending on whether the DelegateID is being used to 
		-- select the candidate or the AliasID. DelegateID takes precedence.
		--
		if LEN(@DelegateID) > 0
			begin
			set @_ExistingID = (SELECT TOP(1) CandidateID FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[CentreID] = @CentreID and c.[CandidateNumber] = @DelegateID)
			if (@_ExistingID is null)
				begin
				set @_ReturnCode = -4	-- CandidateNumber not found
				raiserror('Error', 18, 1)
				end
			--
			-- Check if any updates necessary
			--
			set @_ExistingDelegateID = (SELECT TOP(1) CandidateNumber FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE	c.[CentreID] = @CentreID and
											c.[CandidateNumber] = @DelegateID and
											COALESCE(c.[FirstName], '') = @FirstName and
											c.[LastName] = @LastName and
											c.[JobGroupID] = @JobGroupID and
											c.[Active] = @Active and
											COALESCE(c.[Answer1], '') = @Answer1 and
											COALESCE(c.[Answer2], '') = @Answer2 and
											COALESCE(c.[Answer3], '') = @Answer3 and
											COALESCE(c.[AliasID], '') = @AliasID)
			if (@_ExistingDelegateID is not null)
				begin
				set @_ReturnCode = 1	-- no changes to data
				raiserror('Error', 18, 1)
				end
			end
		else 
			begin
			--
			-- AliasID must be used to identify the record. It must be non-empty due to
			-- check on parameters at the start of the SP.
			--
			set @_ExistingID = (SELECT TOP(1) CandidateID FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[CentreID] = @CentreID and c.[AliasID] = @AliasID)
			if (@_ExistingID is null)
				begin
				set @_ReturnCode = 2	-- AliasID not found, must create new record
				raiserror('Error', 18, 1)
				end
			--
			-- Check if any updates necessary
			--
			set @_ExistingDelegateID = (SELECT TOP(1) CandidateNumber FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE	c.[CentreID] = @CentreID and
											c.[AliasID] = @AliasID and
											COALESCE(c.[FirstName], '') = @FirstName and
											c.[LastName] = @LastName and
											c.[JobGroupID] = @JobGroupID and
											c.[Active] = @Active and
											COALESCE(c.[Answer1], '') = @Answer1 and
											COALESCE(c.[Answer2], '') = @Answer2 and
											COALESCE(c.[Answer3], '') = @Answer3)
			if (@_ExistingDelegateID is not null)
				begin
				set @_ReturnCode = 1	-- no changes to data
				raiserror('Error', 18, 1)
				end
			end
		
		--
		-- OK, we have some changes so do it
		--
		UPDATE Candidates SET
				[FirstName] = @FirstName,
				[LastName] = @LastName,
				[JobGroupID] = @JobGroupID,
				[Active] = @Active,
				[Answer1] = @Answer1,
				[Answer2] = @Answer2,
				[Answer3] = @Answer3,
				[AliasID] = @AliasID
		WHERE	[CandidateID] = @_ExistingID
		--
		-- All finished
		--
		COMMIT TRANSACTION UpdateCandidate
		set @_ReturnCode = 0	-- data updated
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION UpdateCandidate
	END CATCH
	--
	-- Return code indicates errors or success
	--
	SELECT @_ReturnCode
END
GO
