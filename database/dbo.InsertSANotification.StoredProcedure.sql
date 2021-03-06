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
	
END
GO
