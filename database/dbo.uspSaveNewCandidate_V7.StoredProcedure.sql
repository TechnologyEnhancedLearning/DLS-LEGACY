USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 08/03/2019
-- Description:	Creates a new candidate
-- Returns:		varchar(100) - new candidate number
--				'-1' : unexpected error
--				'-2' : some parameters not supplied
--				'-3' : failed, AliasID not unique
--				'-4' : active candidate record for e-mail address already exists (not limited to centre as of 08/03/2019 because of move to single login / reg process)
-- =============================================
CREATE PROCEDURE [dbo].[uspSaveNewCandidate_V7]
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
	@Email varchar(250),
	@ExternalReg bit,
	@SelfReg bit
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
		if len(@FirstName) = 0 or len(@LastName) = 0 or @JobGroupID < 1 or @JobGroupID > (SELECT     MAX(JobGroupID) AS JobGroupID
FROM         JobGroups)
			begin
			set @_ReturnCode = '-2'
			raiserror('Error', 18, 1)	
			goto onexit		
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
				goto onexit
				end
			end
			-- The e-mail address must also be unique unless it is in the exclusions table
			if LEN(@Email) > 0
			begin
			declare @_ExistingEmail as varchar(250)
			set @_ExistingEmail = (SELECT     TOP (1) EmailAddress
FROM         Candidates AS c WITH (TABLOCK, HOLDLOCK)
WHERE     (Active = 1) AND (EmailAddress = @Email) AND (@Email NOT IN
                          (SELECT     ExclusionEmail
                            FROM          EmailDupExclude
                            WHERE      (ExclusionEmail = @Email))))
				if (@_ExistingEmail is not null)
				begin
				set @_ReturnCode = '-4'
				raiserror('Error', 18, 1)
				goto onexit
				end
			end	
			--begin
			--set @_ReturnCode = '-5'
			--	raiserror('Error', 18, 1)
			--	goto onexit
			--end				 
		--
		-- Get the existing maximum candidate number. Do TABLOCK and HOLDLOCK here as well in case AliasID is empty.
		--
		If CAST(@_ReturnCode AS Int) >= -1
		begin
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
								EmailAddress,
								ExternalReg,
								SelfReg)
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
								@Email,
								@ExternalReg,
								@SelfReg)
		--
		-- All finished
		set @_ReturnCode = @_NewCandidateNumber
		--Add learner default notifications:
		DECLARE @_CandidateID Int
		SELECT @_CandidateID = SCOPE_IDENTITY()
		INSERT INTO NotificationUsers (NotificationID, CandidateID)
		SELECT NR.NotificationID, @_CandidateID FROM NotificationRoles AS NR INNER JOIN Notifications AS N ON NR.NotificationID = N.NotificationID WHERE RoleID = 5 AND N.AutoOptIn = 1
		end

		--Check if learner needs adding to groups:
		DECLARE @_AdminID As Int
		DECLARE @_GroupID As Int
		if exists (SELECT * FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 4) AND (AddNewRegistrants = 1))
		begin
		DECLARE @_JobGroup as nvarchar(50)
		SELECT @_JobGroup = JobGroupName FROM JobGroups WHERE (JobGroupID = @JobGroupID)
		If exists (SELECT * FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 4) AND (AddNewRegistrants = 1) AND (GroupLabel LIKE '%' + @_JobGroup))
		Begin
		SELECT @_AdminID = CreatedByAdminUserID, @_GroupID = GroupID FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 4) AND (AddNewRegistrants = 1) AND (GroupLabel LIKE '%' + @_JobGroup)
		EXEC dbo.GroupDelegates_Add_QT @_CandidateID, @_GroupID, @_AdminID, @CentreID
		end
		end

		if @Answer1 <> ''
		if exists (SELECT * FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 1) AND (AddNewRegistrants = 1))
		begin
		If exists (SELECT * FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 1) AND (AddNewRegistrants = 1) AND (GroupLabel LIKE '%' + @Answer1))
		begin
		SELECT @_AdminID = CreatedByAdminUserID, @_GroupID = GroupID FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 1) AND (AddNewRegistrants = 1) AND (GroupLabel LIKE '%' + @Answer1)
		EXEC dbo.GroupDelegates_Add_QT @_CandidateID, @_GroupID, @_AdminID, @CentreID
		end
		end
		if @Answer2 <> ''
		if exists (SELECT * FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 2) AND (AddNewRegistrants = 1))
		begin
		If exists (SELECT * FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 2) AND (GroupLabel LIKE '%' + @Answer2))
		begin
		SELECT @_AdminID = CreatedByAdminUserID, @_GroupID = GroupID FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 2) AND (AddNewRegistrants = 1) AND (GroupLabel LIKE '%' + @Answer2)
		EXEC dbo.GroupDelegates_Add_QT @_CandidateID, @_GroupID, @_AdminID, @CentreID
		end
		end
		if @Answer3 <> ''
		if exists (SELECT * FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 3) AND (AddNewRegistrants = 1))
		begin
		If exists (SELECT * FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 3) AND (AddNewRegistrants = 1) AND (GroupLabel LIKE '%' + @Answer3))
		begin
		SELECT @_AdminID = CreatedByAdminUserID, @_GroupID = GroupID FROM Groups WHERE (CentreID = @CentreID) AND (LinkedToField = 3) AND (AddNewRegistrants = 1) AND (GroupLabel LIKE '%' + @Answer3)
		EXEC dbo.GroupDelegates_Add_QT @_CandidateID, @_GroupID, @_AdminID, @CentreID
		end
		end



		COMMIT TRANSACTION SaveNewCandidate
		
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION SaveNewCandidate
	END CATCH
	--
	-- Return code indicates errors or success
	--
	onexit:
	SELECT @_ReturnCode
	
END

GO
