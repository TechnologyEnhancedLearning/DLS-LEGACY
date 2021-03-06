USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 23 February 2011
-- Description:	Extract password given reminder hash
-- Returns:		string: password.
--              If empty, there was a problem.
-- =============================================
CREATE PROCEDURE [dbo].[uspGetPassword]
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
	declare @_ReturnCode varchar(250)
	set @_ReturnCode = ''
	BEGIN TRY
		BEGIN TRANSACTION GetPassword

		declare @_Password as varchar(250)
		set @_Password = ''
		--
		-- Check if anything has been passed in
		--
		if len(@Hash) != 64 
			begin
			raiserror('Error', 18, 1)			
			end
		--
		-- Get the password. Apply the 2 hour rule.
		--
		set @_Password = (SELECT TOP 1 [Password] 
						  FROM AdminUsers 
						  WHERE	PasswordReminderHash = @Hash and 
								PasswordReminderDate > DateAdd(hour, -2, GETUTCDATE()))
		--
		-- Reset the flags for that record, ignoring the 2 hour rule. 
		-- That way we keep the data clean.
		--
		UPDATE AdminUsers SET PasswordReminder = 0, 
							  PasswordReminderHash = Null, 
							  PasswordReminderDate = Null 
				WHERE PasswordReminderHash = @Hash
		--
		-- All finished
		--
		COMMIT TRANSACTION GetPassword
		set @_ReturnCode = @_Password
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
