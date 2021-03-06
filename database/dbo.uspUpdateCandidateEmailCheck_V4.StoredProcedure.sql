USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 05/04/19
-- Description:	Updates candidate details and checks for duplicate e-mail address and sorts grouping changes
-- =============================================
CREATE PROCEDURE [dbo].[uspUpdateCandidateEmailCheck_V4]
	@Original_CandidateID integer,
	@FirstName varchar(250),
	@LastName varchar(250),
	@JobGroupID integer,
	@Answer1 varchar(100),
	@Answer2 varchar(100),
	@Answer3 varchar(100),
	@Answer4 nvarchar(100),
	@Answer5 nvarchar(100),
	@Answer6 nvarchar(100),
	@EmailAddress varchar(250),
	@AliasID varchar(250),
	@Approved bit,
	@Active bit,
	@ProfileImage image
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	declare @_ReturnCode varchar(100)
	set @_ReturnCode = '-1'
	BEGIN TRY
		BEGIN TRANSACTION UpdateCandidate
		--Get CenreID:
		DECLARE @CentreID Int
			set @CentreID = (SELECT TOP(1) CentreID FROM [dbo].[Candidates] c  
									 WHERE  c.CandidateID = @Original_CandidateID)
		--
		-- Check if parameters are OK
		--
		if len(@FirstName) = 0 or len(@LastName) = 0 or @JobGroupID < 1 or @JobGroupID > (SELECT     MAX(JobGroupID) AS JobGroupID
FROM         JobGroups)
			begin
			set @_ReturnCode = -2		-- some required parameters missing
			raiserror('Error', 18, 1)			
			end
			-- The AliasID must be unique. Check if any existing record matches and if so,
		-- disallow it if the DelegateID (CandidateNumber) doesn't match.
		-- Note TABLOCK and HOLDLOCK used on Candidates table to make sure the table
		-- isn't modified until we're finished.
		--
		declare @_ExistingID as integer
		
		if LEN(@AliasID) > 0
			begin
			if exists (SELECT CandidateID FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[CentreID] = @CentreID and c.[AliasID] = @AliasID and CandidateID <> @Original_CandidateID)
				begin
				set @_ReturnCode = -3	-- Alias exists for centre for another Candidate
				raiserror('Error', 18, 1)
				end
			end
			--Check email address unique for centre:
	if LEN(@EmailAddress) > 0
			begin
			
			declare @_ExistingEmail as varchar(250)
			set @_ExistingEmail = (SELECT TOP(1) EmailAddress FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[EmailAddress] = @EmailAddress AND c.CandidateID <> @Original_CandidateID AND c.CentreID = @CentreID  AND (@EmailAddress NOT IN
                          (SELECT     ExclusionEmail
                            FROM          EmailDupExclude
                            WHERE      (ExclusionEmail = @EmailAddress))))
				if (@_ExistingEmail is not null)
				begin
				set @_ReturnCode = '-4'
				raiserror('Error', 18, 1)
				end
			end		
			--Check AliasID unique for centre
			if len(@AliasID) > 0
			begin
			
			set @_ExistingEmail = (SELECT TOP(1) EmailAddress FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[AliasID] = @AliasID AND c.CandidateID <> @Original_CandidateID AND c.CentreID = @CentreID)
				if (@_ExistingEmail is not null)
				begin
				set @_ReturnCode = '-3'
				raiserror('Error', 18, 1)
				end
			end			
			
			--Get Current Answers:
			DECLARE @_OldAnswer1 varchar(100)
			DECLARE @_OldAnswer2 varchar(100)
			DECLARE @_OldAnswer3 varchar(100)
			DECLARE @_OldAnswer4 nvarchar(100)
			DECLARE @_OldAnswer5 nvarchar(100)
			DECLARE @_OldAnswer6 nvarchar(100)
			DECLARE @_OldJobGroupID int
			DECLARE @_CentreID int
			DECLARE @_OldGroupID int
			DECLARE @_NewGroupID int
			DECLARE @_AdminID int
			DECLARE @_OldGroupDelegateID int
			SELECT @_OldAnswer1 = Answer1, @_OldAnswer2 = Answer2, @_OldAnswer3 = Answer3, @_OldAnswer4 = Answer4, @_OldAnswer5 = Answer5, @_OldAnswer6 = Answer6, @_CentreID = CentreID, @_OldJobGroupID = JobGroupID FROM Candidates WHERE CandidateID = @Original_CandidateID

			--Check for differences with answers and Job Groups:
			If @_OldAnswer1 <> @Answer1
			begin
			SELECT @_OldGroupID = COALESCE(GroupID, 0) FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 1) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @_OldAnswer1)
			if @_OldGroupID > 0
			
			begin
			SELECT @_OldGroupDelegateID = COALESCE(GroupDelegateID, 0) FROM GroupDelegates WHERE GroupID = @_OldGroupID AND DelegateID = @Original_CandidateID
			if @_OldGroupDelegateID > 0
			begin
			--We need to delete delegate from group and remove associated enrollments:
			EXEC dbo.DeleteDelegateFromGroup @_OldGroupDelegateID
			end
			end
				If exists (SELECT * FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 1) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @Answer1))
		begin
		SELECT @_AdminID = CreatedByAdminUserID, @_NewGroupID = GroupID FROM Groups WHERE (CentreID = @_CentreID) AND (SyncFieldChanges = 1)  AND (LinkedToField = 1) AND (GroupLabel LIKE '%' + @Answer1)
		EXEC dbo.GroupDelegates_Add @Original_CandidateID, @_NewGroupID, @_AdminID, @_CentreID
		end
			end
			If @_OldAnswer2 <> @Answer2
			begin
			SELECT @_OldGroupID = COALESCE(GroupID, 0) FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 2) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @_OldAnswer2)
			if @_OldGroupID > 0
			
			begin
			SELECT @_OldGroupDelegateID = COALESCE(GroupDelegateID, 0) FROM GroupDelegates WHERE GroupID = @_OldGroupID AND DelegateID = @Original_CandidateID
			if @_OldGroupDelegateID > 0
			begin
			--We need to delete delegate from group and remove associated enrollments:
			EXEC dbo.DeleteDelegateFromGroup @_OldGroupDelegateID
			end
			end
			If exists (SELECT * FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 2) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @Answer2))
		begin
		SELECT @_AdminID = CreatedByAdminUserID, @_NewGroupID = GroupID FROM Groups WHERE (CentreID = @_CentreID) AND (SyncFieldChanges = 1)  AND (LinkedToField = 2) AND (GroupLabel LIKE '%' + @Answer2)
		EXEC dbo.GroupDelegates_Add @Original_CandidateID, @_NewGroupID, @_AdminID, @_CentreID
		end
			end
			If @_OldAnswer3 <> @Answer3
			begin
			SELECT @_OldGroupID = COALESCE(GroupID, 0) FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 3) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @_OldAnswer3)
			if @_OldGroupID > 0
			
			begin
			SELECT @_OldGroupDelegateID = COALESCE(GroupDelegateID, 0) FROM GroupDelegates WHERE GroupID = @_OldGroupID AND DelegateID = @Original_CandidateID
			if @_OldGroupDelegateID > 0
			begin
			--We need to delete delegate from group and remove associated enrollments:
			EXEC dbo.DeleteDelegateFromGroup @_OldGroupDelegateID
			end
			end
			If exists (SELECT * FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 3) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @Answer3))
		begin
		SELECT @_AdminID = CreatedByAdminUserID, @_NewGroupID = GroupID FROM Groups WHERE (CentreID = @_CentreID) AND (SyncFieldChanges = 1)  AND (LinkedToField = 3) AND (GroupLabel LIKE '%' + @Answer3)
		EXEC dbo.GroupDelegates_Add @Original_CandidateID, @_NewGroupID, @_AdminID, @_CentreID
		end
			end




						If @_OldAnswer4 <> @Answer4
			begin
			SELECT @_OldGroupID = COALESCE(GroupID, 0) FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 5) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @_OldAnswer4)
			if @_OldGroupID > 0
			
			begin
			SELECT @_OldGroupDelegateID = COALESCE(GroupDelegateID, 0) FROM GroupDelegates WHERE GroupID = @_OldGroupID AND DelegateID = @Original_CandidateID
			if @_OldGroupDelegateID > 0
			begin
			--We need to delete delegate from group and remove associated enrollments:
			EXEC dbo.DeleteDelegateFromGroup @_OldGroupDelegateID
			end
			end
			If exists (SELECT * FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 5) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @Answer4))
		begin
		SELECT @_AdminID = CreatedByAdminUserID, @_NewGroupID = GroupID FROM Groups WHERE (CentreID = @_CentreID) AND (SyncFieldChanges = 1)  AND (LinkedToField = 5) AND (GroupLabel LIKE '%' + @Answer4)
		EXEC dbo.GroupDelegates_Add @Original_CandidateID, @_NewGroupID, @_AdminID, @_CentreID
		end
			end


						If @_OldAnswer5 <> @Answer5
			begin
			SELECT @_OldGroupID = COALESCE(GroupID, 0) FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 6) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @_OldAnswer5)
			if @_OldGroupID > 0
			
			begin
			SELECT @_OldGroupDelegateID = COALESCE(GroupDelegateID, 0) FROM GroupDelegates WHERE GroupID = @_OldGroupID AND DelegateID = @Original_CandidateID
			if @_OldGroupDelegateID > 0
			begin
			--We need to delete delegate from group and remove associated enrollments:
			EXEC dbo.DeleteDelegateFromGroup @_OldGroupDelegateID
			end
			end
			If exists (SELECT * FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 6) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @Answer5))
		begin
		SELECT @_AdminID = CreatedByAdminUserID, @_NewGroupID = GroupID FROM Groups WHERE (CentreID = @_CentreID) AND (SyncFieldChanges = 1)  AND (LinkedToField = 6) AND (GroupLabel LIKE '%' + @Answer5)
		EXEC dbo.GroupDelegates_Add @Original_CandidateID, @_NewGroupID, @_AdminID, @_CentreID
		end
			end


						If @_OldAnswer6 <> @Answer6
			begin
			SELECT @_OldGroupID = COALESCE(GroupID, 0) FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 7) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @_OldAnswer6)
			if @_OldGroupID > 0
			
			begin
			SELECT @_OldGroupDelegateID = COALESCE(GroupDelegateID, 0) FROM GroupDelegates WHERE GroupID = @_OldGroupID AND DelegateID = @Original_CandidateID
			if @_OldGroupDelegateID > 0
			begin
			--We need to delete delegate from group and remove associated enrollments:
			EXEC dbo.DeleteDelegateFromGroup @_OldGroupDelegateID
			end
			end
			If exists (SELECT * FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 7) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @Answer6))
		begin
		SELECT @_AdminID = CreatedByAdminUserID, @_NewGroupID = GroupID FROM Groups WHERE (CentreID = @_CentreID) AND (SyncFieldChanges = 1)  AND (LinkedToField = 7) AND (GroupLabel LIKE '%' + @Answer6)
		EXEC dbo.GroupDelegates_Add @Original_CandidateID, @_NewGroupID, @_AdminID, @_CentreID
		end
			end




			if @_OldJobGroupID <> @JobGroupID
			begin
			if exists (SELECT * FROM Groups WHERE CentreID = @_CentreID AND LinkedToField = 4)
			begin
			DECLARE @_NewJobGroup as nvarchar(50)
			DECLARE @_OldJobGroup as nvarchar(50)
		SELECT @_NewJobGroup = JobGroupName FROM JobGroups WHERE (JobGroupID = @JobGroupID)
		SELECT @_OldJobGroup = JobGroupName FROM JobGroups WHERE (JobGroupID = @_OldJobGroupID)
		SELECT @_OldGroupID = COALESCE(GroupID, 0) FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 4) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @_OldJobGroup)
			if @_OldGroupID > 0
			
			begin
			SELECT @_OldGroupDelegateID = COALESCE(GroupDelegateID, 0) FROM GroupDelegates WHERE GroupID = @_OldGroupID AND DelegateID = @Original_CandidateID
			if @_OldGroupDelegateID > 0
			begin
			--We need to delete delegate from group and remove associated enrollments:
			EXEC dbo.DeleteDelegateFromGroup @_OldGroupDelegateID
			end
			end
			If exists (SELECT * FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 4) AND (SyncFieldChanges = 1) AND (GroupLabel LIKE '%' + @_NewJobGroup))
			--we need to add the delegate to a new group based on their new answer
		Begin
		SELECT @_AdminID = CreatedByAdminUserID, @_NewGroupID = GroupID FROM Groups WHERE (CentreID = @_CentreID) AND (LinkedToField = 4) AND (SyncFieldChanges = 1)  AND (GroupLabel LIKE '%' + @_NewJobGroup)
		EXEC dbo.GroupDelegates_Add @Original_CandidateID, @_NewGroupID, @_AdminID, @_CentreID
		end
			end
			end
			
				 
			UPDATE    Candidates
SET              FirstName = @FirstName, LastName = @LastName, JobGroupID = @JobGroupID, Answer1 = @Answer1, Answer2 = @Answer2, Answer3 = @Answer3, Answer4 = @Answer4, Answer5 = @Answer5, Answer6 = @Answer6, 
                      EmailAddress = @EmailAddress, AliasID = @AliasID, active = @Active, Approved = @Approved, ProfileImage = @ProfileImage
WHERE     (CandidateID = @Original_CandidateID)
COMMIT TRANSACTION UpdateCandidate
		set @_ReturnCode = '1'
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
