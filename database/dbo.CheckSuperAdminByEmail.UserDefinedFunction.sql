USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 12/10/2017
-- Description:	Returns True if the e-mail address is a Super Admin False if not.
-- =============================================
CREATE FUNCTION [dbo].[CheckSuperAdminByEmail]
(
	-- Add the parameters for the function here
	@Email as nVarChar(255)
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar bit
set @ResultVar = 0
	-- Add the T-SQL statements to compute the return value here
	if exists (SELECT * FROM AdminUsers WHERE Email = @Email AND UserAdmin = 1)
	begin
	set @ResultVar = 1
	end

	-- Return the result of the function
	RETURN @ResultVar

END

GO
