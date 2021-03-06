USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 23/10/2018
-- Description:	Creates the Progress and aspProgress record for a new user
-- Returns:		0 : success, progress created
--       		1 : Failed - progress already exists
--       		100 : Failed - CentreID and CustomisationID don't match
--       		101 : Failed - CentreID and CandidateID don't match

-- V3 changes include:

-- Checks that existing progress hasn't been Removed or Refreshed before returining error.
-- Adds parameters for Enrollment method and admin ID
-- =============================================
CREATE PROCEDURE [dbo].[uspCreateProgressRecordWithCompleteWithinMonths]
	@CandidateID int,
	@CustomisationID int,
	@CentreID int,
	@EnrollmentMethodID int,
	@EnrolledByAdminID int,
	@CompleteWithinMonths int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--
	-- There are various things to do so wrap this in a transaction
	-- to prevent any problems.
	--
	declare @EmailProfileName nvarchar(100)
	declare @TestOnly bit
	set @EmailProfileName = 'itsp-mail-profile'
	set @TestOnly = 1
	declare @_ReturnCode integer
	declare @_CompleteBy datetime 

	if @CompleteWithinMonths > 0
	begin
	set @_CompleteBy = dateAdd(M,@CompleteWithinMonths,getDate())
	end
	PRINT @_CompleteBy
	set @_ReturnCode = 0
	
		
		--
		-- Check if the chosen CentreID and CustomisationID match
		--
		if (SELECT COUNT(*) FROM Customisations c WHERE (c.CustomisationID = @CustomisationID) AND (c.CentreID = @CentreID)) = 0 
			begin
			set @_ReturnCode = 100
			Goto OnExit
			end
			if (SELECT COUNT(*) FROM Candidates c WHERE (c.CandidateID = @CandidateID) AND (c.CentreID = @CentreID)) = 0 
			begin
			set @_ReturnCode = 101
			Goto OnExit
			end
			-- This is being changed (18/09/2018) to check if existing progress hasn't been refreshed or removed:
			if (SELECT COUNT(*) FROM Progress WHERE (CandidateID = @CandidateID) AND (CustomisationID = @CustomisationID) AND (SystemRefreshed = 0) AND (RemovedDate IS NULL)) > 0 
			begin
			-- A record exists, should we set the Complete By Date?
			UPDATE Progress SET CompleteByDate = @_CompleteBy, EnrollmentMethodID = @EnrolledByAdminID, @EnrolledByAdminID = @EnrolledByAdminID WHERE (CandidateID = @CandidateID) AND (CustomisationID = @CustomisationID) AND (SystemRefreshed = 0) AND (RemovedDate IS NULL) AND (CompleteByDate IS NULL)
			SET @_ReturnCode = 1
			Goto OnExit
			end
		-- Insert record into progress

		INSERT INTO Progress
						(CandidateID, CustomisationID, CustomisationVersion, SubmittedTime, EnrollmentMethodID, EnrolledByAdminID, CompleteByDate)
			VALUES		(@CandidateID, @CustomisationID, (SELECT C.CurrentVersion FROM Customisations As C WHERE C.CustomisationID = @CustomisationID), 
						 GETUTCDATE(), @EnrollmentMethodID, @EnrolledByAdminID, @_CompleteBy)
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
WHERE     (C.CustomisationID = @CustomisationID) )

-- Check whether a notification is needed:
DECLARE @bodyHTML  NVARCHAR(MAX)
	 DECLARE @_EmailTo nvarchar(255)
	  DECLARE @_EmailFrom nvarchar(255)
	  DECLARE @_Subject nvarchar(255)
--the email prefix and other variables will be the same for each e-mail so set them before we loop:
SET @_EmailFrom =  N'IT Skills Pathway Notifications <noreply@itskills.nhs.uk>'
SET @bodyHTML = ''
SET @_Subject = N'New Learning Portal Course Enrollment'   
if @EnrollmentMethodID = 2
begin
if exists (Select * FROM NotificationUsers WHERE NotificationID = 10 AND CandidateID = @CandidateID)
-- we need to e-mail delegate:
begin
SELECT @bodyHTML = N'<p>Dear ' +  ca.FirstName + ' ' + ca.LastName  + N'</p>'+
	'<p>This is an automated message from the IT Skills Pathway to notify you that you have been enrolled on the course <b>' + a.ApplicationName + ' - ' + cu.CustomisationName + N'</b> by a system administrator (either as an individual or as a member of a group).</p>'+
	N'<p>To login to the course directly <a href="https://www.itskills.nhs.uk/tracking/learn?centreid=' + CAST(ca.CentreID AS nvarchar) +'&customisationid='+ CAST(cu.CustomisationID AS nvarchar) +'">click here</a>.</p>'+ 
	N'<p>To login to the Learning Portal to access and complete your course <a href="https://www.itskills.nhs.uk/learningportal?centreid=' + CAST(ca.CentreID AS nvarchar) +'">click here</a>.</p>' + CASE WHEN CompleteByDate IS NOT NULL Then '<p>The date the course should be completed by is ' + CONVERT(VARCHAR(10), CompleteByDate, 103) + N'.</p>' ELSE '' END,
	@_EmailTo = EmailAddress
	FROM Candidates AS ca INNER JOIN
                  Progress AS p ON ca.CandidateID = p.CandidateID INNER JOIN
                  Customisations AS cu ON p.CustomisationID = cu.CustomisationID INNER JOIN
                  Applications AS a ON cu.ApplicationID = a.ApplicationID
WHERE  (p.ProgressID = @ProgressID)
end

end
if @EnrollmentMethodID = 3
begin
if exists (Select * FROM NotificationUsers WHERE NotificationID = 14 AND CandidateID = @CandidateID AND NOT @_EmailTo IS NULL)
-- we need to e-mail delegate:
begin
SELECT @bodyHTML = N'<p>Dear ' +  ca.FirstName + ' ' + ca.LastName  + N'</p>'+
	'<p>This is an automated message from the IT Skills Pathway to notify you that you have been enrolled on the course <b>' + a.ApplicationName + ' - ' + cu.CustomisationName + N'</b> by the system because a previous course completion has expired.</p>'+
	N'<p>To login to the course directly <a href="https://www.itskills.nhs.uk/tracking/learn?centreid=' + CAST(ca.CentreID AS nvarchar) +'&customisationid='+ CAST(cu.CustomisationID AS nvarchar) +'">click here</a>.</p>'+ 
	N'<p>To login to the Learning Portal to access and complete your course <a href="https://www.itskills.nhs.uk/learningportal?centreid=' + CAST(ca.CentreID AS nvarchar) +'">click here</a>.</p>' + CASE WHEN CompleteByDate IS NOT NULL Then '<p>The date the course should be completed by is ' + CONVERT(VARCHAR(10), CompleteByDate, 103) + N'.</p>' ELSE '' END,
	@_EmailTo = EmailAddress
	FROM Candidates AS ca INNER JOIN
                  Progress AS p ON ca.CandidateID = p.CandidateID INNER JOIN
                  Customisations AS cu ON p.CustomisationID = cu.CustomisationID INNER JOIN
                  Applications AS a ON cu.ApplicationID = a.ApplicationID
WHERE  (p.ProgressID = @ProgressID)
end
end
if LEN(@bodyHTML) > 0 AND NOT @_EmailTo IS NULL
begin
--Now send the e-mail:
	 	 --Now add the e-mail to the e-mail out table:

INSERT INTO [dbo].[EmailOut]
           ([EmailTo]
           ,[EmailFrom]
           ,[Subject]
           ,[BodyHTML]
           ,[AddedByProcess])
     VALUES
           (@_EmailTo
		   ,@_EmailFrom
		   ,@_Subject
		   ,@bodyHTML
		   ,'uspCreateProgressRecordWithCompleteWithinMonths')

end
	--
	-- Return code indicates errors or success
	--
	OnExit:
	SELECT @_ReturnCode
END

GO
