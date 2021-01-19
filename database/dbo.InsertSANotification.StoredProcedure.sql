USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 11/09/2018
-- Description:	Adds SA notification and sends e-mails to appropriate subscribed users
-- =============================================
CREATE PROCEDURE [dbo].[InsertSANotification]
	-- Add the parameters for the stored procedure here
	@SubjectLine NVARCHAR(100)
	,@BodyHTML NVARCHAR(MAX)
	,@ExpiryDate DATETIME NULL
	,@TargetUserRoleID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @_NotID INT

	-- Insert statements for procedure here
	INSERT INTO SANotifications (
		SubjectLine
		,BodyHTML
		,ExpiryDate
		,TargetUserRoleID
		)
	VALUES (
		@SubjectLine
		,@BodyHTML
		,@ExpiryDate
		,@TargetUserRoleID
		)

	DECLARE @_Role AS NVARCHAR(100)

	SELECT @_NotID = SCOPE_IDENTITY()
	SELECT @_NotID
	Return @_NotID
	--SELECT @_Role = [Role]
	--FROM UserRoles
	--WHERE RoleID = @TargetUserRoleID

	--DECLARE @Subs TABLE (
	--	ID INT NOT NULL PRIMARY KEY identity(1, 1)
	--	,AdminID INT
	--	,Forename NVARCHAR(250)
	--	,Surname NVARCHAR(250)
	--	,Email NVARCHAR(250)
	--	)

	--INSERT INTO @Subs (
	--	AdminID
	--	,Forename
	--	,Surname
	--	,Email
	--	)
	--SELECT AdminID
	--	,Forename
	--	,Surname
	--	,Email
	--FROM AdminUsers AS AU
	--INNER JOIN NotificationUsers NU ON AU.AdminID = NU.AdminUserID
	--WHERE NU.NotificationID = 1 AND AU.Active = 1
	--	AND (
	--		(@TargetUserRoleID = 1)
	--		OR (
	--			AU.IsCentreManager = 1
	--			AND @TargetUserRoleID = 2
	--			)
	--		OR (
	--			AU.ContentManager = 1
	--			AND @TargetUserRoleID = 3
	--			)
	--		OR (
	--			AU.ContentCreator = 1
	--			AND @TargetUserRoleID = 4
	--			)
	--		)

	--DECLARE @ID INT
	--DECLARE @bodyHTMLEmail NVARCHAR(MAX)
	--DECLARE @_EmailFrom NVARCHAR(255)
	--DECLARE @_Subject NVARCHAR(320)
	--DECLARE @_EmailTo NVARCHAR(255)
	--SET @_EmailFrom = N'IT Skills Pathway Notifications <noreply@itskills.nhs.uk>'
	--SET @_Subject = N'IT Skills Pathway Notifice - ' + @SubjectLine
	--DECLARE @_ReturnVal as Int
	--SELECT @_ReturnVal = Count(*) FROM @Subs
	--WHILE EXISTS (
	--		SELECT *
	--		FROM @Subs
	--		)
	--BEGIN
	--	SELECT @ID = Min(ID)
	--	FROM @Subs

	--	SELECT @bodyHTML = N'<p>Dear ' + Forename + N'</p>' + '<p>This is a notification published to the IT Skills Pathway Tracking System for the attention of users with the role ' + @_Role + ':</p><hr/>' + @BodyHTML,
	--	@_EmailTo = Email
	--	FROM @Subs
	--	WHERE ID = @ID
		 
	-- EXEC msdb.dbo.sp_send_dbmail @profile_name='ITSPMailProfile', @recipients=@_EmailTo, @from_address=@_EmailFrom, @subject=@_Subject, @body = @bodyHTML, @body_format = 'HTML' ;	
	-- DELETE FROM @Subs WHERE ID = @ID
	--END
	--SELECT @_ReturnVal
	--Return @_ReturnVal
END

GO
