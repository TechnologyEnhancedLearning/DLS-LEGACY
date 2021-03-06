USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 16/10/2018
-- Description:	Adds a new linked group and, if necessary, the registered delegates to the group based on registration field response
-- =============================================
CREATE PROCEDURE [dbo].[AddGroupAndDelegatesFromRegistrationField]
	-- Add the parameters for the stored procedure here
	@CentreID int,
	@GroupLabel nvarchar(100),
	@Option nvarchar(100),
	@OptionID int,
	@LinkedToField int,
	@SyncFieldChanges bit,
	@AddNewRegistrants bit,
	@PopulateExisting bit,
	@CreatedByAdminUserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Groups
                         (CentreID, GroupLabel, LinkedToField, SyncFieldChanges, AddNewRegistrants, PopulateExisting, CreatedByAdminUserID)
VALUES        (@CentreID, @GroupLabel, @LinkedToField, @SyncFieldChanges, @AddNewRegistrants, @PopulateExisting, @CreatedByAdminUserID)
DECLARE @_GroupID AS Int
SET @_GroupID = SCOPE_IDENTITY()
IF @PopulateExisting = 1
BEGIN

INSERT INTO GroupDelegates (GroupID,DelegateID,AddedByFieldLink)
SELECT @_GroupID, CandidateID, @LinkedToField
FROM Candidates
WHERE (CentreID = @CentreID) AND (Active = 1) AND ((Answer1 = @Option AND @LinkedToField = 1) OR (Answer2 = @Option AND @LinkedToField = 2) OR (Answer3 = @Option AND @LinkedToField = 3) OR (JobGroupID = @OptionID AND @LinkedToField = 4) OR (Answer4 = @Option AND @LinkedToField = 5) OR (Answer5 = @Option AND @LinkedToField = 6) OR (Answer6 = @Option AND @LinkedToField = 7)) 
END

END



GO
