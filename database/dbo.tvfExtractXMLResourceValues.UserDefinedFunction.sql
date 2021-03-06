USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 19/11/2019
-- Description:	This function returns a table of values from 
--				a Resources XML list for use with scheduler. 
-- =============================================

CREATE FUNCTION [dbo].[tvfExtractXMLResourceValues] (@string NVARCHAR(MAX))
RETURNS @parsedString TABLE (ID INT)
AS 
BEGIN
declare @doc xml
SET @doc=@string

	INSERT INTO @parsedString (ID)
	SELECT Y.i.value('@Value[1]', 'int')
	FROM
	@doc.nodes('ResourceIds/ResourceId') AS Y(i)
	RETURN
END
GO
