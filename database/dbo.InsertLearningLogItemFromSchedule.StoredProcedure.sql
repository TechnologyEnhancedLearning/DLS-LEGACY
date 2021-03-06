USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 02/09/2019
-- Description:	Stores a LearningLogItem record and returns its ID. Logs related tutorial IDs and enrols learner on related course (if applicable).
-- =============================================
CREATE PROCEDURE [dbo].[InsertLearningLogItemFromSchedule]
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
	@CallUri nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_Duration Int
	SELECT @_Duration = DATEDIFF(minute, @StartDate, @EndDate)
    -- Insert new loearning log item:
	DECLARE @_NewLearningLogItemID Int
	BEGIN
	INSERT INTO LearningLogItems (DueDate, DurationMins, MethodID, Topic, Outcomes, LoggedByAdminID, AppointmentTypeID, LoggedByID, CallUri) 
	VALUES (@StartDate, @_Duration, 4, @Subject, @Description, @LoggedByAdminID, @Label, @LoggedByID, @CallUri)
	END
	--Get its ID
	SET @_NewLearningLogItemID = SCOPE_IDENTITY()
	-- Insert related log item progress link table records:
	BEGIN
		INSERT INTO ProgressLearningLogItems(LearningLogItemID, ProgressID)
	SELECT @_NewLearningLogItemID AS LearningLogItemID, ID AS ProgressID
	FROM [dbo].[tvfExtractXMLResourceValues] (@ResourceID)
	END	
	SELECT @_NewLearningLogItemID
	Return @_NewLearningLogItemID
END
GO
