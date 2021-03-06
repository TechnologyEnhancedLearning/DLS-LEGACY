USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 15/10/2019
-- Description:	Creates a new admin record (with role options) from a candidate record
-- =============================================
CREATE PROCEDURE [dbo].[InsertAdminAccountFromDelegate]
	-- Add the parameters for the stored procedure here
	@CandidateID int,
	@CategoryID int,
	@CentreAdmin bit,
	@Supervisor bit,
	@Trainer bit,
	@CMSRole int,
	@ContentCreator bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @_AdminID Int = 0
	DECLARE @_ImportOnly bit = 0
	DECLARE @_CMS bit = 0
	if @CMSRole > 0
	begin
	set @_CMS = 1
	end
	if @CMSRole = 1
	begin
	set @_ImportOnly = 1
	end

	DECLARE @_Email as nvarchar(255)
	SELECT @_Email = COALESCE(EmailAddress, '') FROM Candidates WHERE CandidateID = @CandidateID
	if @_Email = '' OR Exists (SELECT * FROM AdminUsers WHERE Email = @_Email)
	begin
	GoTo OnExit
	end

	INSERT INTO AdminUsers	([Password], CentreID, Forename, Surname, Email, Approved, CentreAdmin, CategoryID, ContentManager, ImportOnly, ContentCreator, Supervisor)
	(SELECT [Password], CentreID, FirstName, LastName, EmailAddress, 1, @CentreAdmin, @CategoryID, @_CMS, @_ImportOnly, @ContentCreator, @Supervisor FROM Candidates WHERE CandidateID = @CandidateID)
		
	SET @_AdminID = SCOPE_IDENTITY()
	If @_AdminID > 0 AND @ContentCreator = 1
	begin
	if not exists (SELECT * FROM CCLicences WHERE AssignedUserID = @_AdminID AND Active = 1)
	begin
	if exists (SELECT * FROM CCLicences WHERE AssignedUserID = @_AdminID AND Active = 0)
	begin 
	--reactivate:
	UPDate CCLicences SET Active = 1 WHERE AssignedUserID = @_AdminID
	end
	else
	begin
	-- assign next unassigned:
	UPDate TOP(1) CCLicences SET Active = 1, AssignedUserID = @_AdminID WHERE AssignedUserID IS NULL
	end
	end
	end
	OnExit:
	SELECT @_AdminID
	Return @_AdminID
END
GO
