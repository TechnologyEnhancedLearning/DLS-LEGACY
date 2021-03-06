USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Hugh Gibson
-- Create date: 16 Mar 2011
-- Description:	Extract password from customisation
-- =============================================
CREATE FUNCTION [dbo].[svfGetCustomisationPassword]
(
	@Customisation varchar(max)
)
RETURNS varchar(max)
AS
BEGIN
	DECLARE @_PasswordLoc bigint
	DECLARE @_Password varchar(max)
	
	--
	-- Match the pattern for a password. Password itself must be
	-- enclosed in double quotes.
	--
	set @_PasswordLoc = PATINDEX ('%#Password: "%"%', @Customisation)
	--
	-- If nothing found then give no password
	--
	if @_PasswordLoc = 0
		begin
		set @_Password = ''
		end
	else
		begin
		--
		-- Find the start of the password, fixed format.
		-- End depends on where the closing double quote is.
		--	
		set @_Password = substring(@Customisation, @_PasswordLoc + 12, len(@Customisation))
		set @_Password = left(@_Password, charindex('"', @_Password) - 1)
		end
	return @_Password
END
GO
