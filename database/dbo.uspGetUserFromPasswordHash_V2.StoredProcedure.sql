USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 11/03/2019
-- Description:	Extract password given reminder hash
-- Returns:		string: password.
--              If empty, there was a problem.
--				V2 Checks against e-mail address too to prevent hacking.
-- =============================================
CREATE PROCEDURE [dbo].[uspGetUserFromPasswordHash_V2]
	@Hash nvarchar(64),
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

		declare @_AdminID as int
		set @_AdminID = -1
		--
		-- Check if anything has been passed in
		--
		if len(@Hash) != 64 
			begin
			raiserror('Error', 18, 1)			
			end
		--
		-- Get the password.
		--
		set @_AdminID = (SELECT TOP 1 AdminID 
						  FROM AdminUsers 
						  WHERE	(PasswordReminderHash = @Hash) and (Email = @Email))
		--
		-- Reset the flags for that record, ignoring the 2 hour rule. 
		-- That way we keep the data clean.
		--
		--UPDATE AdminUsers SET PasswordReminder = 0, 
		--					  PasswordReminderHash = Null, 
		--					  PasswordReminderDate = Null 
		--		WHERE AdminID = @_AdminID
		--
		-- All finished
		--
		COMMIT TRANSACTION GetPassword
		set @_ReturnCode = @_AdminID
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
