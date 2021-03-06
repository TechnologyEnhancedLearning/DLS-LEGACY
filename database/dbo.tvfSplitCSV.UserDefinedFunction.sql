USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 27/01/2011
-- Description:	This function returns a table of values from 
--				a CSV list. 
-- =============================================

CREATE FUNCTION [dbo].[tvfSplitCSV] (@string NVARCHAR(MAX))
RETURNS @parsedString TABLE (ID NVARCHAR(MAX))
AS 
BEGIN
	DECLARE @position int
	DECLARE @nextpos int
	set @position = 1
	if substring(@string, len(@string), 1) <> ','
		begin
		set @string = @string + ','
		end
	set @nextpos = charindex(',', @string, @position)
	WHILE @nextpos > 0
		BEGIN
		INSERT into @parsedString SELECT substring(@string, @position, @nextpos - @position)
		set @position = @nextpos + 1
		set @nextpos = charindex(',', @string, @position)
		END
	RETURN
END
GO
