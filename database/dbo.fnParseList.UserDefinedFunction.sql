USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnParseList]
(
	@Delimiter CHAR,
	@Text TEXT
)
RETURNS @Result TABLE (RowID SMALLINT IDENTITY(1, 1) PRIMARY KEY, Data VARCHAR(8000))
AS
BEGIN
	DECLARE	@NextPos INT,
		@LastPos INT
	SELECT	@NextPos = CHARINDEX(@Delimiter, @Text, 1),
		@LastPos = 0
	WHILE @NextPos > 0
		BEGIN
			INSERT	@Result
				(
					Data
				)
			SELECT	SUBSTRING(@Text, @LastPos + 1, @NextPos - @LastPos - 1)
			SELECT	@LastPos = @NextPos,
				@NextPos = CHARINDEX(@Delimiter, @Text, @NextPos + 1)
		END
	IF @NextPos <= @LastPos
		INSERT	@Result
			(
				Data
			)
		SELECT	SUBSTRING(@Text, @LastPos + 1, DATALENGTH(@Text) - @LastPos)
	RETURN
END
GO
