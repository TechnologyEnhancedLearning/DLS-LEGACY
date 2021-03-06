USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 16/10/2018
-- Description:	Removes a group and its delegates, courses etc and related enrollments if checked
-- =============================================
CREATE PROCEDURE [dbo].[CascadeDeleteGroupAndRelatedData]
	-- Add the parameters for the stored procedure here
	@GroupID int,
	@RemoveEnrollments bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @_LinkedField int
	SELECT @_LinkedField = LinkedToField FROM Groups where GroupID = @GroupID
	-- Check if the group contains delegates:
	IF Exists (SELECT * FROM GroupDelegates WHERE GroupID = @GroupID)
	BEGIN
	-- They exist, should we check for and remove enrollments?
	If @RemoveEnrollments = 1
	BEGIN
	if exists(SELECT * FROM Progress AS P INNER JOIN GroupDelegates AS GD ON P.CandidateID = GD.DelegateID INNER JOIN GroupCustomisations AS GC ON P.CustomisationID = GC.CustomisationID WHERE (p.Completed IS NULL) AND (p.EnrollmentMethodID  = 3) AND (GC.GroupID = @GroupID) AND (GD.GroupID = @GroupID) AND (P.RemovedDate IS NULL))
	BEGIN
	--Enrollments exist, lets delete them:
	UPDATE Progress SET RemovedDate = getUTCDate(), RemovalMethodID = 3 WHERE ProgressID IN (SELECT ProgressID FROM Progress AS P INNER JOIN GroupDelegates AS GD ON P.CandidateID = GD.DelegateID INNER JOIN GroupCustomisations AS GC ON P.CustomisationID = GC.CustomisationID WHERE (p.Completed IS NULL) AND (p.EnrollmentMethodID  = 3) AND (GC.GroupID = @GroupID) AND (GD.GroupID = @GroupID) AND (P.RemovedDate IS NULL))
	END
	END
	--Delete the delegates from the group:
	DELETE FROM GroupDelegates WHERE GroupID = @GroupID

	END
	-- Delete any related GroupCustomisation records
	DELETE FROM GroupCustomisations WHERE GroupID = @GroupID
	--Finally delete the group
	DELETE FROM Groups WHERE GroupID = @GroupID
END

GO
