USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 04/09/2018
-- Description:	Returns bulleted list of roles for notification ID
-- =============================================
CREATE FUNCTION [dbo].[RolesForNotificationCSV]
(
	-- Add the parameters for the function here
	@NotificationID int
)
RETURNS varchar(8000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar varchar(8000)

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultVar = COALESCE(@ResultVar + '<li>', '<li>') + Q1.Role  + '</li>'
FROM            (SELECT      DISTINCT  r.Role
FROM            NotificationRoles AS nr INNER JOIN
                         UserRoles AS r ON nr.RoleID = r.RoleID
WHERE        (nr.NotificationID = @NotificationID)) AS Q1

	-- Return the result of the function
	RETURN @ResultVar

END



GO
