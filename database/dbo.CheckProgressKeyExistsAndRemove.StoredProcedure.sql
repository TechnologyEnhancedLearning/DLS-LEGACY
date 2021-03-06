USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 29/12/2016
-- Description:	Checks if valid Progress Key exists in LearnerPortalProgressKeys and deletes and returns 1 if so, returns 0 if not
-- =============================================
CREATE PROCEDURE [dbo].[CheckProgressKeyExistsAndRemove]
	-- Add the parameters for the stored procedure here
	@LPGUID uniqueidentifier,
	@ProgressID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @ReturnVal int
SET @ReturnVal = 0

	if exists(SELECT ID FROM LearnerPortalProgressKeys WHERE ProgressID = @ProgressID and LPGUID = @LPGUID)
	Begin
	set @ReturnVal = 1
	DELETE FROM LearnerPortalProgressKeys WHERE ProgressID = @ProgressID and LPGUID = @LPGUID
	end
	if @ReturnVal = 0
	begin
	if exists(SELECT ID FROM ProgressKeyCheckLog WHERE ProgressID = @ProgressID and LPGUID = @LPGUID and ReturnVal = 1)
	begin
	set @ReturnVal = 1
	DELETE FROM ProgressKeyCheckLog WHERE ProgressID = @ProgressID and LPGUID = @LPGUID and ReturnVal = 1
	end
	end
	INSERT INTO ProgressKeyCheckLog(LPGUID,ProgressID,ReturnVal) VALUES (@LPGUID, @ProgressID, @ReturnVal)
	SELECT @ReturnVal
	Return @ReturnVal
END
GO
