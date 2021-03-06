USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 10 Sep 2010
-- Description:	Returns either 'WHERE ' if the 
-- input is empty, or the input string + ' AND ' if it's non-empty.
-- Use this to build up a WHERE clause in dynamic SQL.
-- =============================================
CREATE FUNCTION [dbo].[svfAnd]
(
	@Clause varchar(max)
)
RETURNS varchar(max)
AS
BEGIN
	DECLARE @ResultVar varchar(max)
		
	if LEN(@Clause) > 0
		begin
		return @Clause + ' AND '
		end
	return ' WHERE '
END
GO
