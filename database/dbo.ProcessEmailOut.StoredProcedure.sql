USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 16/11/2018
-- Description:	Sends items in EmailOut table and marks them as sent. Then deletes items that are more than 6 months old.
-- =============================================
CREATE PROCEDURE [dbo].[ProcessEmailOut]
	-- Add the parameters for the stored procedure here
	@Urgent bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @EmailID Int
	DECLARE @MaxProcess AS Int = 5000
	IF @Urgent = 1
	BEGIN
	SET @MaxProcess = 200
	END
	DECLARE @Processed Int
	SET @Processed = 0
	WHILE exists (Select * From EmailOut WHERE ([Sent] is null) AND ([DeliverAfter] < GETUTCDATE()) AND (Urgent = @Urgent)) AND @Processed <= @MaxProcess
	begin
	SET @Processed = @Processed + 1
	SELECT @EmailID = Min(EmailID) FROM EmailOut  WHERE ([Sent] is null) AND ([DeliverAfter] < GETUTCDATE()) AND (Urgent = @Urgent)
    -- Insert statements for procedure here
	DECLARE @bodyHTML  NVARCHAR(MAX)
	 DECLARE @_EmailTo nvarchar(255)
	  DECLARE @_EmailFrom nvarchar(255)
	  DECLARE @_Subject nvarchar(255)
	  SELECT @bodyHTML = BodyHTML, @_EmailTo = EmailTo, @_EmailFrom = EmailFrom, @_Subject = [Subject] FROM EmailOut  WHERE EmailID = @EmailID
	  
	EXEC msdb.dbo.sp_send_dbmail @profile_name='', @recipients=@_EmailTo, @from_address=@_EmailFrom, @subject=@_Subject, @body = @bodyHTML, @body_format = 'HTML' ;
	 UPDATE EmailOut SET [Sent] = getUTCDate() WHERE EmailID = @EmailID
	 end
	 DELETE FROM EmailOut WHERE DATEADD(M, 6, [Sent])<GETUTCDATE()

END
GO
