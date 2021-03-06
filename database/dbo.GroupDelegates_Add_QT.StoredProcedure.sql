USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 19/10/2018
-- Description:	Adds a delegate to a group and applies all course enrollments to delegate record.
-- =============================================
CREATE PROCEDURE [dbo].[GroupDelegates_Add_QT]
	-- Add the parameters for the stored procedure here
	@DelegateID int, 
	@GroupID int,
	@AdminUserID int,
	@CentreID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Check the group delegate record doesn't already exist:
	If not exists (SELECT * FROM GroupDelegates WHERE GroupID = @GroupID AND DelegateID = @DelegateID)
	BEGIN
	-- Go ahead and insert:
	INSERT INTO [dbo].[GroupDelegates]
           ([GroupID]
           ,[DelegateID]
           ,[AddedByFieldLink])
     VALUES
           (@GroupID
           ,@DelegateID
           ,0)

		   -- Now go ahead and enrol delegate on GroupCustomisations:
		   DECLARE @_CustCount int
		   SELECT @_CustCount = Count(CustomisationID) FROM GroupCustomisations WHERE GroupID = @GroupID AND InactivatedDate IS NULL

		   If @_CustCount > 0
		   begin
		   DECLARE @_CustID Int
		   SET @_CustID = 0
		   DECLARE @_CompleteWithinMonths AS Int
		   declare @_CompleteBy datetime 
	DECLARE @_EnrolCount int
	SET @_EnrolCount = 0
		   declare @_ReturnCode integer
		   WHILE @_CustID < (SELECT MAX(CustomisationID) FROM GroupCustomisations WHERE GroupID = @GroupID AND InactivatedDate IS NULL)
		   begin
		   SELECT @_CustID = Min(GC.CustomisationID) FROM GroupCustomisations AS GC INNER JOIN Customisations AS C On GC.CustomisationID = C.CustomisationID WHERE (GroupID = @GroupID) AND (GC.InactivatedDate IS NULL) AND (GC.CustomisationID  > @_CustID) AND (C.Active = 1)
		   SELECT @_CompleteWithinMonths = GC.CompleteWithinMonths FROM GroupCustomisations AS GC INNER JOIN Customisations AS C On GC.CustomisationID = C.CustomisationID WHERE (GC.GroupID = @GroupID) AND (GC.CustomisationID = @_CustID) AND (C.Active = 1)
		   if @_CompleteWithinMonths > 0
	begin
	set @_CompleteBy = dateAdd(M,@_CompleteWithinMonths,getDate())
	end
	set @_ReturnCode = 0


if (SELECT COUNT(*) FROM Customisations c WHERE (c.CustomisationID = @_CustID) AND ((c.CentreID = @CentreID) OR (c.AllCentres = 1)) AND (Active =1)) = 0 
			begin
			set @_ReturnCode = 100
			
			end
			if (SELECT COUNT(*) FROM Candidates c WHERE (c.CandidateID = @DelegateID) AND (c.CentreID = @CentreID) AND (Active =1)) = 0 
			begin
			set @_ReturnCode = 101
			
			end
			-- This is being changed (18/09/2018) to check if existing progress hasn't been refreshed or removed:
			if (SELECT COUNT(*) FROM Progress WHERE (CandidateID = @DelegateID) AND (CustomisationID = @_CustID) AND (SystemRefreshed = 0) AND (RemovedDate IS NULL)) > 0 
			begin
			-- A record exists, should we set the Complete By Date?
			UPDATE Progress SET CompleteByDate = @_CompleteBy WHERE (CandidateID = @DelegateID) AND (CustomisationID = @_CustID) AND (SystemRefreshed = 0) AND (RemovedDate IS NULL) AND (CompleteByDate IS NULL)
			set @_ReturnCode = 102
		
			end
		-- Insert record into progress
		if @_ReturnCode = 0
		begin
INSERT INTO Progress
						(CandidateID, CustomisationID, CustomisationVersion, SubmittedTime, EnrollmentMethodID, EnrolledByAdminID, CompleteByDate)
			VALUES		(@DelegateID, @_CustID, (SELECT C.CurrentVersion FROM Customisations As C WHERE C.CustomisationID = @_CustID), 
						 GETUTCDATE(), 3, @AdminUserID, @_CompleteBy)
		-- Get progressID
		declare @ProgressID integer
		Set @ProgressID = (SELECT SCOPE_IDENTITY())
		-- Insert records into aspProgress
		INSERT INTO aspProgress
		(TutorialID, ProgressID)
		(SELECT     T.TutorialID, @ProgressID as ProgressID
FROM         Customisations AS C INNER JOIN
                      Applications AS A ON C.ApplicationID = A.ApplicationID INNER JOIN
                      Sections AS S ON A.ApplicationID = S.ApplicationID INNER JOIN
                      Tutorials AS T ON S.SectionID = T.SectionID
WHERE     (C.CustomisationID = @_CustID) )
 SET @_EnrolCount = @_EnrolCount+1
		end
		   
		   end
		   end



	END
END


GO
