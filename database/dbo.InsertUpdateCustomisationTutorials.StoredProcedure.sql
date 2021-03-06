USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 02/03/2020
-- Description:	Updates or inserts a CustomisationTutorials record  with new values
-- =============================================
CREATE PROCEDURE [dbo].[InsertUpdateCustomisationTutorials]
	-- Add the parameters for the stored procedure here
	@CustomisationID int,
	@TutorialID int,
	@Status bit,
	@DiagStatus bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--Check if CustomisationTutorials record already exists
	if exists (SELECT * FROM CustomisationTutorials WHERE     (CustomisationID = @CustomisationID) AND (TutorialID = @TutorialID))
	begin
	--It does, so update it:
	UPDATE    CustomisationTutorials
SET              Status = @Status, DiagStatus = @DiagStatus
WHERE     (CustomisationID = @CustomisationID) AND (TutorialID = @TutorialID)
end
else
begin
-- INSERT CustomisationTutorials record because it doesn't yet exist:
INSERT INTO CustomisationTutorials (CustomisationID, TutorialID, [Status], DiagStatus)
VALUES (@CustomisationID, @TutorialID, @Status, @DiagStatus)
end
-- INSERT aspProgress records for any Progress records where they don't already exist:
INSERT INTO aspProgress (TutorialID, ProgressID)
SELECT @TutorialID, ProgressID
FROM Progress WHERE (Completed IS NULL) AND (RemovedDate IS NULL) AND (CustomisationID = @CustomisationID) AND (ProgressID NOT IN (SELECT ProgressID FROM aspProgress WHERE (TutorialID = @TutorialID) AND (CustomisationID = @CustomisationID)))
END
GO
