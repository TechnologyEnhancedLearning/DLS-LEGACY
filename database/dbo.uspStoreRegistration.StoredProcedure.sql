USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 1 September 2010
-- Description:	Creates the registration record for a new user
-- Returns:		0 : success, registered and approved
--				1 : success but account needs to be approved by MBHT
--				2 : success but account needs to be approved by Centre Manager
--				100 : Unknown database error
--				101 : Username is not unique
--				102 : Email is not unique
-- =============================================
CREATE PROCEDURE [dbo].[uspStoreRegistration]
	@Forename varchar(250),
	@Surname varchar(250),
	@Email varchar(250),
	@Username varchar(250),
	@Password varchar(250),
	@CentreID integer
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
		BEGIN TRANSACTION AddUser
		--
		-- Check if the chosen username is unique
		--
		if (SELECT COUNT(*) FROM AdminUsers a WHERE lower(a.Login) = lower(@Username)) > 0 
			begin
			set @_ReturnCode = 101
			raiserror('Error', 18, 1)
			end
		--
		-- Check if the chosen email is unique
		--
		if (SELECT COUNT(*) FROM AdminUsers a WHERE lower(a.Email) = lower(@Email)) > 0 
			begin
			set @_ReturnCode = 102
			raiserror('Error', 18, 1)
			end
		--
		-- Find if the registration is for a centre manager
		--
		declare @_AutoRegisterManagerEmail varchar(250)
		declare @_AutoRegistered bit
		declare @_CentreManagersRegistered integer
		
		set @_AutoRegistered = 0
		--
		-- Test if there is a centre manager registered already for this centre.
		--
		set @_CentreManagersRegistered = (SELECT COUNT(*) FROM AdminUsers
											 WHERE CentreID = @CentreID and IsCentreManager = 1)
		--
		-- Test if we should register a centre manager automatically.
		-- This happens when there are no centre managers for this centre already,
		-- and the email address matches the one given.
		--
		if @_CentreManagersRegistered = 0 and 
			(SELECT Count(*) FROM Centres c 
				WHERE	c.CentreID = @CentreID and 
					    lower(c.AutoRegisterManagerEmail) = lower(@Email) and 
						c.AutoRegistered = 0) =  1
			begin
			--
			-- User matches auto-register for the centre so mark them as auto-registered
			--
			UPDATE Centres SET AutoRegistered = 1 WHERE CentreID = @CentreID
			set @_AutoRegistered = 1
			end
		--
		-- Create the user appropriately. We mark them as approved if they are auto-registered
		-- and also make them the centre manager.
		--
		INSERT INTO AdminUsers
						(Login, Password, CentreID, CentreAdmin, ConfigAdmin, SummaryReports, UserAdmin, 
						 Forename, Surname, Email, 
						 IsCentreManager, Approved)
			VALUES		(@Username, @Password, @CentreID, 1, 0, 0, 0, 
						 @Forename, @Surname, @Email, 
						 @_AutoRegistered, @_AutoRegistered)
		--
		-- All finished
		--
		COMMIT TRANSACTION AddUser
		--
		-- Decide what the return code should be - depends on whether they
		-- need to be approved or not
		--
		set @_ReturnCode = 0					-- assume that user is registered
		if @_AutoRegistered = 0
			begin
			set @_ReturnCode = (case when @_CentreManagersRegistered = 0 then 1 else 2 end)
			end
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION AddUser
	END CATCH
	--
	-- Return code indicates errors or success
	--
	SELECT @_ReturnCode
END
GO
