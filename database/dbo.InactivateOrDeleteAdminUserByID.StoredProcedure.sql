USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 21/11/2019
-- Description:	Checks whether any AdminSessions exist for admin user, inactivates adminuser record if so and deletes adminuser record if not
-- =============================================
CREATE PROCEDURE [dbo].[InactivateOrDeleteAdminUserByID]
	-- Add the parameters for the stored procedure here
	@AdminUserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @_ReturnVal Int = 0
	SET NOCOUNT ON;
	if exists (select * from AdminSessions where AdminID = @AdminUserID)
	begin
	SET @_ReturnVal = 1
	UPDATE AdminUsers
SET Active = 0
WHERE AdminID = @AdminUserID
	end
	else
	begin
	SET @_ReturnVal = 2
	Delete from AdminUsers 
	where AdminID = @AdminUserID
	end
	SELECT @_ReturnVal
	Return @_ReturnVal
END
GO
