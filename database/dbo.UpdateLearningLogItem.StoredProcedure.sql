USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 10/09/2019
-- Description:	Updates a LearningLogItem record. Logs related tutorial IDs and enrols learner on related course (if applicable).
-- =============================================
CREATE PROCEDURE [dbo].[UpdateLearningLogItem]
	@LearningLogItemID int,
	@LoggedByID Int,
	@DueDate datetime,
	@CompletedDate datetime,
	@DurationMins int,
	@MethodID int,
	@MethodOther nvarchar(255),
	@Topic nvarchar(255),
	@Outcomes nvarchar(MAX),
	@CentreID int,
	@LinkedCustomisationID int,
	@LinkedProgressIDsCSV nvarchar(255),
	@LinkedTutorialIDsCSV nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert new loearning log item:
	BEGIN
	UPDATE LearningLogItems SET LoggedByID=@LoggedByID, DueDate=@DueDate, CompletedDate=@CompletedDate, DurationMins=@DurationMins, MethodID=@MethodID, MethodOther=@MethodOther, Topic=@Topic, Outcomes=@Outcomes, LinkedCustomisationId=@LinkedCustomisationId 
	WHERE LearningLogItemID = @LearningLogItemID
	END

	-- Insert related log item tutorial link table records:
	BEGIN
		INSERT INTO LearningLogItemTutorials(LearningLogItemID, TutorialID)
		SELECT @LearningLogItemID as LearningLogItemID, ID AS TutorialID
		FROM [dbo].[tvfSplitCSV] (@LinkedTutorialIDsCSV) WHERE @LearningLogItemID NOT IN (SELECT LearningLogItemID FROM LearningLogItemTutorials WHERE LearningLogItemID = @LearningLogItemID AND TutorialID = ID)
		END
		-- And remove any that are no longer required:
		DELETE FROM LearningLogItemTutorials
		WHERE LearningLogItemID = @LearningLogItemID AND TutorialID NOT IN (SELECT ID AS TutorialID FROM [dbo].[tvfSplitCSV] (@LinkedTutorialIDsCSV))

		-- Check for candidate enrollment on course and update or enrol where necessary:
		 DECLARE @_tblProgressIDs TABLE (ID int not null primary key identity(1,1), ProgressID int)
		 INSERT INTO @_tblProgressIDs(ProgressID)
		 SELECT ID AS ProgressID
	FROM [dbo].[tvfSplitCSV] (@LinkedProgressIDsCSV)
	DECLARE @_ID     int 
	DECLARE @_CandidateID int
	While exists (Select * From @_tblProgressIDs)
	begin
	SELECT @_ID = Min(ID) from @_tblProgressIDs
	SELECT @_CandidateID = COALESCE(CandidateID, 0) FROM Progress WHERE ProgressID = (SELECT ProgressID FROM @_tblProgressIDs WHERE ID = @_ID)
	IF @_CandidateID > 0
	BEGIN
	if @DueDate > getDate() AND @CompletedDate IS NULL
	begin

EXECUTE [dbo].[uspCreateProgressRecordWithCompleteBy_Quiet] 
   @_CandidateID
  ,@LinkedCustomisationID
  ,@CentreID
  ,1
  ,0
  ,@DueDate
  ,0


	end
	else
	begin
	
-- TODO: Set parameter values here.

EXECUTE [dbo].[uspCreateProgressRecord_Quiet] 
   @_CandidateID
  ,@LinkedCustomisationID
  ,@CentreID
  ,1
  ,0

	end


	END
	DELETE FROM @_tblProgressIDs WHERE ID = @_ID
	end
END
GO
