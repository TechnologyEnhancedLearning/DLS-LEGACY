USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 19/11/2019
-- Description:	Updates a LearningLogItem record. Adds and removes attendees from ResourceID XML parameter.
-- =============================================
CREATE PROCEDURE [dbo].[UpdateLearningLogItemFromSchedule]
	@UniqueID int,
	@StartDate datetime,
	@EndDate datetime,
	@Subject nvarchar(255),
	@Description nvarchar(MAX),
	@ResourceID nvarchar(MAX),
	@LoggedByAdminID int,
	@Label int,
	@RecurrenceInfo nvarchar(MAX),
	@ReminderInfo nvarchar(max),
	@Location nvarchar(255),
	@Type int,
	@Status int,
	@AllDay bit,
	@LoggedByID int,
	@CallUri nvarchar(255),
	@original_UniqueID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert new loearning log item:
	BEGIN
	DECLARE @_Duration Int
	SELECT @_Duration = DATEDIFF(minute, @StartDate, @EndDate)

	UPDATE LearningLogItems SET LoggedByID=@LoggedByID, DueDate=@StartDate, DurationMins=@_Duration, Topic=@Subject, Outcomes=@Description, AppointmentTypeID = @Label, CallUri = @CallUri 
	WHERE LearningLogItemID = @UniqueID
	END

	-- Insert related progress log item link table records where they don't already exist:
	BEGIN
	INSERT INTO ProgressLearningLogItems(LearningLogItemID, ProgressID)
	SELECT @UniqueID AS LearningLogItemID, ID AS ProgressID
	FROM [dbo].[tvfExtractXMLResourceValues] (@ResourceID)
	WHERE @UniqueID NOT IN (SELECT LearningLogItemID FROM ProgressLearningLogItems WHERE LearningLogItemID = @UniqueID AND ProgressID = ID)

		-- And remove any that are no longer required:
		DELETE FROM ProgressLearningLogItems
		WHERE LearningLogItemID = @UniqueID AND ProgressID NOT IN (SELECT ID AS ProgressID FROM [dbo].[tvfExtractXMLResourceValues] (@ResourceID))

END
END
GO
