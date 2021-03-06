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
CREATE PROCEDURE [dbo].[uspUpdateCandidateEmailCheck]
	@CandidateID integer,
	@FirstName varchar(250),
	@LastName varchar(250),
	@JobGroupID integer,
	@Answer1 varchar(100),
	@Answer2 varchar(100),
	@Answer3 varchar(100),
	@Email varchar(250)
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
	if LEN(@Email) > 0
			begin
			declare @_ExistingEmail as varchar(250)
			set @_ExistingEmail = (SELECT TOP(1) AliasID FROM [dbo].[Candidates] c  
									 WITH (TABLOCK, HOLDLOCK)
									 WHERE c.[EmailAddress] = @Email AND c.CandidateID <> @CandidateID)
				if (@_ExistingEmail is not null)
				begin
				set @_ReturnCode = '-4'
				raiserror('Error', 18, 1)
				end
			end					 
			UPDATE    Candidates
SET              FirstName = @FirstName, LastName = @LastName, JobGroupID = @JobGroupID, Answer1 = @Answer1, Answer2 = @Answer2, Answer3 = @Answer3, 
                      EmailAddress = @Email
WHERE     (CandidateID = @CandidateID)
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
