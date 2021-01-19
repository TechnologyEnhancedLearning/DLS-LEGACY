USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 17/08/2018
-- Description:	Uses DB mail to send reminders to delegates on courses with a TBC date within 1 month.
-- =============================================
CREATE PROCEDURE [dbo].[SendExpiredTBCReminders]
	-- Add the parameters for the stored procedure here
	@EmailProfileName nvarchar(100),
	@TestOnly bit,
	@MarkSent bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Create the temporary table to hold the reminder records:
    DECLARE @Reminders TABLE (ReminderID int not null primary key identity(1,1), ProgressID int, CustomisationID int, StartedDate datetime, LastAccessed datetime, CompleteByDate datetime, EnrolledBy nvarchar(255),
    EnrolledByAdminID int, CentreID int, Course nvarchar(255), DelegateName nvarchar(100), EmailAddress nvarchar(255), CentreName nvarchar(255), ContactEmail nvarchar(255), ContactTelephone nvarchar(20))
    -- Add the reminder records to the table:
    INSERT INTO @Reminders (ProgressID, CustomisationID, StartedDate, LastAccessed, CompleteByDate, EnrolledBy, EnrolledByAdminID, CentreID, Course, DelegateName, EmailAddress, CentreName, ContactEmail, ContactTelephone)
    SELECT p.ProgressID, p.CustomisationID, p.FirstSubmittedTime, p.SubmittedTime, p.CompleteByDate, 
               CASE WHEN p.EnrollmentMethodID = 1 THEN 'You enrolled on this course yourself.' WHEN p.EnrollmentMethodID = 3 THEN 'You were enrolled on this course by the automatic course chaining / refresher system.'
                WHEN p.EnrollmentMethodID = 2 THEN 'You were enrolled on this course by a centre administrator.' END AS EnrolledBy, p.EnrolledByAdminID, c.CentreID, 
               a.ApplicationName + ' - ' + cu.CustomisationName AS Course, c.FirstName + ' ' + c.LastName AS DelegateName, c.EmailAddress, ct.CentreName, 
               ct.ContactEmail, ct.ContactTelephone
FROM  Progress AS p INNER JOIN
               Candidates AS c ON p.CandidateID = c.CandidateID INNER JOIN
               Customisations AS cu ON p.CustomisationID = cu.CustomisationID INNER JOIN
               Applications AS a ON cu.ApplicationID = a.ApplicationID INNER JOIN
               Centres AS ct ON c.CentreID = ct.CentreID INNER JOIN NotificationUsers AS NU ON NU.CandidateID = C.CandidateID
WHERE (ct.Active = 1) AND (c.Active= 1) AND (cu.Active = 1) AND (NU.NotificationID=9) AND (p.Completed IS NULL) AND (p.FirstSubmittedTime < DATEADD(M, - 1, GETDATE())) AND (((p.ExpiredReminderSent = 0) AND (p.CompleteByDate BETWEEN DATEADD(M, -1, 
               GETDATE()) AND GETDATE())) OR ((p.ExpiredReminderSent = 1) AND (p.CompleteByDate BETWEEN DATEADD(M, -2, 
               GETDATE()) AND DATEADD(M, -1, 
               GETDATE())))
               OR ((p.ExpiredReminderSent = 2) AND (p.CompleteByDate BETWEEN DATEADD(M, -3, 
               GETDATE()) AND DATEADD(M, -2, 
               GETDATE())))
               OR ((p.ExpiredReminderSent = 3) AND (p.CompleteByDate BETWEEN DATEADD(M, -4, 
               GETDATE()) AND DATEADD(M, -3, 
               GETDATE())))
               OR ((p.ExpiredReminderSent = 4) AND (p.CompleteByDate BETWEEN DATEADD(M, -5, 
               GETDATE()) AND DATEADD(M, -4, 
               GETDATE())))
               OR ((p.ExpiredReminderSent = 5) AND (p.CompleteByDate BETWEEN DATEADD(M, -6, 
               GETDATE()) AND DATEADD(M, -5, 
               GETDATE())))
               )
               --setup variables to be used in email loop:
           DECLARE @ReminderID     int 
DECLARE @bodyHTML  NVARCHAR(MAX)
	 DECLARE @_EmailTo nvarchar(255)
	  DECLARE @_EmailFrom nvarchar(255)
	  DECLARE @_Subject nvarchar(255)
--the email prefix and other variables will be the same for each e-mail so set them before we loop:
SET @_EmailFrom =  N'IT Skills Pathway Reminders <noreply@itskills.nhs.uk>'
SET @_Subject = N'Course completion overdue'    
   --Loop through table, sending reminder emails:
While exists (Select * From @Reminders) 

    Begin
	DECLARE @sCC nvarchar(255)
	DECLARE @ProgressID Int
	SELECT @ProgressID = ProgressID FROM @Reminders WHERE ReminderID = @ReminderID
	SELECT @ReminderID = Min(ReminderID) from @Reminders
	SELECT @sCC = COALESCE(Q1.Email, '') FROM (SELECT TOP(1) au.Email
FROM     AdminUsers AS au INNER JOIN
                  Progress AS p ON au.AdminID = p.EnrolledByAdminID INNER JOIN
                  NotificationUsers AS nu ON au.AdminID = nu.AdminUserID
WHERE  (nu.NotificationID = 7) AND (p.ProgressID = @ProgressID)) AS Q1
	--Now setup the e-mail full body text, populating info from the reminders table and prepending prefix and appending suffix:
	SELECT @bodyHTML = N'<p>Dear ' + DelegateName + N'</p>'+
	'<p>This is an automated reminder message from the IT Skills Pathway that completion of the course <b>' + Course + N'</b> is <b>overdue</b>. The date the course should have been completed by was ' + CONVERT(VARCHAR(10), CompleteByDate, 103) + N'.</p>'+
	N'<p>You started this course on ' + CONVERT(VARCHAR(10), StartedDate , 103) + N' and last accessed it on ' + CONVERT(VARCHAR(10), LastAccessed , 103) + N'. '+ EnrolledBy +'</p>'+
	N'<p>To login to the course directly <a href="https://www.itskills.nhs.uk/tracking/learn?centreid=' + CAST(CentreID AS nvarchar) +'&customisationid='+ CAST(CustomisationID AS nvarchar) +'">click here</a>.</p>'+ 
	N'<p>To login to the Learning Portal to access and complete your course <a href="https://www.itskills.nhs.uk/learningportal?centreid=' + CAST(CentreID AS nvarchar) +'">click here</a>.</p>',
	
	@_EmailTo = EmailAddress
	 FROM @Reminders where ReminderID = @ReminderID 
	 if @sCC <> ''
	begin
	SET @bodyHTML = @bodyHTML + '<p><b>Note:</b> This message has been copied to the administrator who enrolled you on this course for their information.</p>'
	end
	 --Now send the e-mail:
	 if @TestOnly = 0
	 begin
	 EXEC msdb.dbo.sp_send_dbmail @profile_name=@EmailProfileName, @recipients=@_EmailTo, @copy_recipients=@sCC, @from_address=@_EmailFrom, @subject=@_Subject, @body = @bodyHTML, @body_format = 'HTML' ;	
	 end
	 else
	 begin
	 print @_EmailTo
	 print @_EmailFrom
	 print @_Subject
	 print @bodyHTML
	 end
	--Now delete this record from @Reminders
	DELETE FROM @Reminders WHERE ReminderID = @ReminderID

end

--Mark Porogress reminders sent:
if @MarkSent = 1 
begin
UPDATE       Progress
SET                ExpiredReminderSent = ExpiredReminderSent+1
WHERE         (Completed IS NULL) AND (FirstSubmittedTime < DATEADD(M, - 1, GETDATE())) AND (((ExpiredReminderSent = 0) AND (CompleteByDate BETWEEN DATEADD(M, -1, 
               GETDATE()) AND GETDATE())) OR ((ExpiredReminderSent = 1) AND (CompleteByDate BETWEEN DATEADD(M, -2, 
               GETDATE()) AND DATEADD(M, -1, 
               GETDATE())))
               OR ((ExpiredReminderSent = 2) AND (CompleteByDate BETWEEN DATEADD(M, -3, 
               GETDATE()) AND DATEADD(M, -2, 
               GETDATE())))
               OR ((ExpiredReminderSent = 3) AND (CompleteByDate BETWEEN DATEADD(M, -4, 
               GETDATE()) AND DATEADD(M, -3, 
               GETDATE())))
               OR ((ExpiredReminderSent = 4) AND (CompleteByDate BETWEEN DATEADD(M, -5, 
               GETDATE()) AND DATEADD(M, -4, 
               GETDATE())))
               OR ((ExpiredReminderSent = 5) AND (CompleteByDate BETWEEN DATEADD(M, -6, 
               GETDATE()) AND DATEADD(M, -5, 
               GETDATE()))))
								 end            
END
GO
