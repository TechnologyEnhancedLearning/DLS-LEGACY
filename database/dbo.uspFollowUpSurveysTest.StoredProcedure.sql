USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin.Whittaker
-- Create date: 15/05/2014
-- Description:	Sends follow up feedback invites
-- =============================================
CREATE PROCEDURE [dbo].[uspFollowUpSurveysTest]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @ID     int 
--Setup variables for each progress record details
	 DECLARE @_FirstName varchar(100)
	 DECLARE @_LastName varchar(100)
	 DECLARE @_CandidateNum varchar(50)
	 DECLARE @_FollowUpEvalID uniqueidentifier
	 DECLARE @_Course varchar(50)
	 DECLARE @_Completed varchar
	 DECLARE @_EmailTo varchar(100)
	 DECLARE @bodyHTML  NVARCHAR(MAX)
DECLARE @_EmailProfile varchar(100)
SET @_EmailProfile = N'ITSPMailProfile'
--SET @_EmailProfile = N'ORBS Mail'
--setup table to hold progressIDs:
DECLARE @ids TABLE (RowID int not null primary key identity(1,1), col1 int )   
--Insert progress ids:
BEGIN
INSERT into @ids (col1)
--Top 2 needs removing after testing: 
SELECT        TOP(1)ProgressID
FROM            Progress
WHERE        (Completed > DATEADD(m, - 3, getUTCDATE())) AND (Evaluated IS NOT NULL) AND (FollowUpEvalID IS NULL)
END
--Loop through progress IDs
While exists (Select * From @ids) 

    Begin
	 Select @ID = Min(col1) from @ids 
	 PRINT @ID
	 --Update Progress record to insert [FollowUpEvalID] 
	 BEGIN
	 Update Progress
	 SET [FollowUpEvalID] = NEWID()
	 WHERE ProgressID = @ID
	 END
	 
	 --Get details for progress id @ID
	 SELECT        @_FirstName = Candidates.FirstName, @_LastName = Candidates.LastName, @_CandidateNum = Candidates.CandidateNumber, @_FollowUpEvalID = Progress.FollowUpEvalID, @_Course = Applications.ApplicationName, 
                         @_Completed = CONVERT(varchar(50), Progress.Completed, 103), @_EmailTo = Candidates.EmailAddress
FROM            Progress INNER JOIN
                         Customisations ON Progress.CustomisationID = Customisations.CustomisationID INNER JOIN
                         Applications ON Customisations.ApplicationID = Applications.ApplicationID INNER JOIN
                         Candidates ON Progress.CandidateID = Candidates.CandidateID
WHERE        (Progress.ProgressID = @ID)
	 -- The following are over-ride settings for testing purposes and need deleting after publishing
	 SET @_EmailTo = N'kevin.whittaker@mbhci.nhs.uk'
	 
	 --Set up the e-mail body
	 
	 SET @bodyHTML = N'<body style=''font-family: Calibri; font-size: small;''><p>Dear ' + @_FirstName + '</p>' +
	N'<p>A few months ago, you completed the IT Skills Pathway ' + @_Course + ' course. ' +
	N'We hope that the learning has proved worthwhile and that it has helped you to do new things and work more efficiently.' +
	N'<p>If you have five minutes to spare, please answer a few questions about what you learned and how much (or little!) it has helped you. We will use your feedback to improve the experience for yourself and other learners in the future.</p>' +
	N'<p>Please <a href=''https://www.itskills.nhs.uk/tracking/followupfeedback.aspx?cid=' + @_CandidateNum + '&fid=' + CONVERT(varchar(50), @_FollowUpEvalID) + '''>click here</a> to share your views with us.</p>' +
	N'<p>Your feedback will be stored and processed anonymously.</p>' +
	N'<p>Many thanks</p>' +
	N'<p>The <a href=''https://www.itskills.nhs.uk''>IT Skills Pathway</a> Team</p></body>';
    PRINT @bodyHTML;
--Send em an e-mail
	BEGIN

	--The @from_address in the following may need changing to nhselite.org if the server doesn't allow sending from itskills.nhs.uk

	EXEC msdb.dbo.sp_send_dbmail @profile_name=@_EmailProfile, @recipients=@_EmailTo, @from_address = 'ITSP Feedback Requests <noreply@itskills.nhs.uk>', @subject = 'IT Skills Pathway - how are you getting along?', @body = @bodyHTML, @body_format = 'HTML' ;	
	
	END
	Delete @ids Where col1 = @ID
END 
END
GO
