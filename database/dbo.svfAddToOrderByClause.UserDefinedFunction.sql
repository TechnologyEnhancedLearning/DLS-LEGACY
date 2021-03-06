USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 19 Jan 2011
-- Description:	Create an order by clause. Precludes duplicate field entries.
-- =============================================
CREATE FUNCTION [dbo].[svfAddToOrderByClause]
(
	@OrderByClause varchar(max),
	@NewField varchar(100)
)
RETURNS varchar(max)
AS
BEGIN
	DECLARE @ResultVar varchar(max)
	DECLARE @SortDir varchar(20)

	set @ResultVar = @OrderByClause
	set @SortDir = ''
	if CharIndex('DESC', Upper(@OrderByClause)) <> 0
		begin
		set @SortDir = 'DESC'
		end
	--
	-- Only add the new field if it's not already in there. It may have been selected
    -- by the user for sorting in a grid view.
	--
	if CharIndex(@NewField, @ResultVar) = 0
		begin
		--
		-- If there's any pre-existing fields then add a comma
		--
		if len(@ResultVar) > 0
			begin
			set @ResultVar = @ResultVar + ','
			end
		--
		-- Add the new field
		--
		set @ResultVar = @ResultVar + ' ' + @NewField + ' ' + @SortDir
		end

	return @ResultVar
END
GO
