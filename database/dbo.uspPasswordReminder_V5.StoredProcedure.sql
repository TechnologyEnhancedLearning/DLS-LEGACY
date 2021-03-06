USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 1 September 2010
-- Description:	Sets up a password reminder
-- Returns:		>0 : success, password reminder on its way to user with this AdminID
--				-1 : failed to find username
--				-2 : failed to find email
--				-3 : if both specified, failed to find matching record
--				-4 : password reminder sent in last 30 minutes
--				-100 : unexpected error
--				-101 : need either username or email
--				-102 : Hash not supplied
--				-103 : Hash not unique
-- =============================================
CREATE PROCEDURE [dbo].[uspPasswordReminder_V5]
	@Email varchar(250),
	@Username varchar(250),
	@Hash varchar(64)
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
	set @_ReturnCode = 100
	BEGIN TRY
		BEGIN TRANSACTION PasswordReminder

		declare @_AdminUserID as Integer
		declare @_FailureCode as Integer
		
		set @_FailureCode = 0

		--
		-- Check if anything has been passed in
		--
		if len(@Email) = 0 and len(@Username) = 0
			begin
			set @_ReturnCode = -101
			raiserror('Error', 18, 1)			
			end
		if len(@Hash) != 64 
			begin
			set @_ReturnCode = -102
			raiserror('Error', 18, 1)			
			end
		--
		-- Check if hash code is unique
		--
		declare @_Password as varchar(250)
		--
		-- See if anything exists 
		--
		set @_Password = (SELECT TOP 1 [Password] 
						  FROM AdminUsers 
						  WHERE	PasswordReminderHash = @Hash)
		if @_Password is not null 
			begin
			set @_ReturnCode = -103
			raiserror('Error', 18, 1)			
			end
		--
		-- Select the administration record appropriately
		--
		if len(@Email) > 0 and len(@Username) > 0
			begin
			set @_AdminUserID = (SELECT AdminID FROM AdminUsers WHERE lower(Email) = lower(@Email) and lower(Login) = lower(@Username))
			set @_FailureCode = -3
			end
		else
			begin
			if len(@Email) > 0 
				begin
				set @_AdminUserID = (SELECT AdminID FROM AdminUsers WHERE lower(Email) = lower(@Email))
				set @_FailureCode = -2
				end
			else
				begin
				set @_AdminUserID = (SELECT AdminID FROM AdminUsers WHERE lower(login) = lower(@Username))
				set @_FailureCode = -1
				end
			end
		-- 
		-- Look at the record ID that matches. If there's no matching record, give the corresponding failure code
		--
		if @_AdminUserID is null 
			begin
			set @_ReturnCode = @_FailureCode
			raiserror('Error', 18, 1)			
			end
		--
		-- Check if a reminder has been sent in the last 30 minutes. 
		--
		DECLARE @_LastReminder as DateTime
		SELECT @_LastReminder = PasswordReminderDate FROM AdminUsers WHERE AdminID = @_AdminUserID
		if not @_LastReminder is null
			begin
			if @_LastReminder > DATEADD(MINUTE, -30, GETUTCDATE())
				begin
				set @_ReturnCode = -4
				raiserror('Error', 18, 1)			
				end
			end
		--
		-- Set the password reminder flag for that user
		--
		UPDATE AdminUsers SET PasswordReminder = 1, 
							  PasswordReminderHash = @Hash, 
							  PasswordReminderDate = GetUTCDate() 
				WHERE AdminID = @_AdminUserID
		--
		-- All finished
		--
		COMMIT TRANSACTION PasswordReminder
		set @_ReturnCode = @_AdminUserID
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION PasswordReminder
	END CATCH
	--
	-- Return code indicates errors or success
	--
	SELECT @_ReturnCode
END
GO
