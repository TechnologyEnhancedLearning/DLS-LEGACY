USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 26/11/2018
-- Description:	Removes a delegate from a group and closed related enrollments.
-- =============================================
CREATE PROCEDURE [dbo].[DeleteDelegateFromGroup]
	-- Add the parameters for the stored procedure here
	@Original_GroupDelegateID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @GroupID int
	DECLARE @DelegateID int
	SELECT @GroupID = GroupID, @DelegateID = DelegateID FROM GroupDelegates WHERE GroupDelegateID = @Original_GroupDelegateID
	--Check if related enrollments exist:
	PRINT @GroupID
	PRINT @DelegateID
	DECLARE @_ReturnVal as Int
	SELECT @_ReturnVal = Count(ProgressID) FROM Progress AS P INNER JOIN GroupCustomisations AS GC ON P.CustomisationID = GC.CustomisationID WHERE (p.Completed IS NULL) AND (p.EnrollmentMethodID  = 3) AND (GC.GroupID = @GroupID) AND (p.CandidateID = @DelegateID) AND (P.RemovedDate IS NULL)
IF @_ReturnVal > 0
	BEGIN
	--Enrollments exist, lets delete them:
	UPDATE Progress SET RemovedDate = getUTCDate(), RemovalMethodID = 3 WHERE ProgressID IN (SELECT ProgressID FROM Progress AS P INNER JOIN GroupCustomisations AS GC ON P.CustomisationID = GC.CustomisationID WHERE (p.Completed IS NULL) AND (p.EnrollmentMethodID  = 3) AND (GC.GroupID = @GroupID) AND (p.CandidateID = @DelegateID) AND (P.RemovedDate IS NULL))
	END

	--Delete the delegate from the group:
	DELETE FROM GroupDelegates WHERE GroupDelegateID = @Original_GroupDelegateID
	SELECT @_ReturnVal
	Return @_ReturnVal
END


GO
