USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 05/07/12
-- Description:	Updates candidate details and checks for duplicate e-mail address
-- =============================================
CREATE PROCEDURE [dbo].[uspUpdateCandidateEmailCheck_V2]
	@Original_CandidateID integer,
	@FirstName varchar(250),
	@LastName varchar(250),
	@JobGroupID integer,
	@Answer1 varchar(100),
	@Answer2 varchar(100),
	@Answer3 varchar(100),
	@EmailAddress varchar(250),
	@AliasID varchar(250),
	@Approved bit,
	@Active bit
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
	if LEN(@EmailAddress) > 0
			begin
			declare @_ExistingEmail as varchar(250)
			set @_ExistingEmail = (SELECT TOP(1) EmailAddress FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[EmailAddress] = @EmailAddress AND c.CandidateID <> @Original_CandidateID)
				if (@_ExistingEmail is not null)
				begin
				set @_ReturnCode = '-4'
				raiserror('Error', 18, 1)
				end
			end		
			if len(@AliasID) > 0
			begin
			DECLARE @CentreID Int
			set @CentreID = (SELECT TOP(1) CentreID FROM [dbo].[Candidates] c  
									 WHERE  c.CandidateID = @Original_CandidateID)
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
			DECLARE @_OldJobGroupID int
			DECLARE @_CentreID int
			DECLARE @_OldGroupID int
			DECLARE @_NewGroupID int
			DECLARE @_AdminID int
			DECLARE @_OldGroupDelegateID int
			SELECT @_OldAnswer1 = Answer1, @_OldAnswer2 = Answer2, @_OldAnswer3 = Answer3, @_CentreID = CentreID, @_OldJobGroupID = JobGroupID FROM Candidates WHERE CandidateID = @Original_CandidateID

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
SET              FirstName = @FirstName, LastName = @LastName, JobGroupID = @JobGroupID, Answer1 = @Answer1, Answer2 = @Answer2, Answer3 = @Answer3, 
                      EmailAddress = @EmailAddress, AliasID = @AliasID, active = @Active, Approved = @Approved
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
