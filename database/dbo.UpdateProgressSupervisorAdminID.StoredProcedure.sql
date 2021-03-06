USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 08/10/2019
-- Description:	Sets supervisor for progressID and e-mails supervisor if subscribed to notification.
-- =============================================
CREATE PROCEDURE [dbo].[UpdateProgressSupervisorAdminID]
	@ProgressID Int,
	@AdminID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_bReturn as Bit = 0
    -- Insert statements for procedure here
	IF (SELECT COALESCE(SupervisorAdminID, 0) FROM Progress WHERE ProgressID = @ProgressID) <> @AdminID
	begin
	UPDATE       Progress
SET                SupervisorAdminID = @AdminID
WHERE        (ProgressID = @ProgressID)
--now clear verification requests:
UPDATE aspProgress
SET SupervisorVerificationRequested = NULL
WHERE ProgressID = @ProgressID

set @_bReturn = 1
end
SELECT @_bReturn
Return @_bReturn
END
GO
