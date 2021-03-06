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
-- Returns:		0 : success, password reminder on its way
--				1 : failed to find username
--				2 : failed to find email
--				3 : if both specified, failed to find matching record
--				100 : unexpected error
--				101 : need either username or email
-- =============================================
CREATE PROCEDURE [dbo].[uspPasswordReminder]
	@Email varchar(250),
	@Username varchar(250)
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
			set @_ReturnCode = 101
			raiserror('Error', 18, 1)			
			end
		--
		-- Select the administration record appropriately
		--
		if len(@Email) > 0 and len(@Username) > 0
			begin
			set @_AdminUserID = (SELECT AdminID FROM AdminUsers WHERE lower(Email) = lower(@Email) and lower(Login) = lower(@Username))
			set @_FailureCode = 3
			end
		else
			begin
			if len(@Email) > 0 
				begin
				set @_AdminUserID = (SELECT AdminID FROM AdminUsers WHERE lower(Email) = lower(@Email))
				set @_FailureCode = 2
				end
			else
				begin
				set @_AdminUserID = (SELECT AdminID FROM AdminUsers WHERE lower(login) = lower(@Username))
				set @_FailureCode = 1
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
		-- Set the password reminder flag for that user
		--
		UPDATE AdminUsers SET PasswordReminder = 1 WHERE AdminID = @_AdminUserID
		--
		-- All finished
		--
		COMMIT TRANSACTION PasswordReminder
		set @_ReturnCode = 0
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
