USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 21 March 2013
-- Description:	Increments consolidation count by 1
-- =============================================
CREATE PROCEDURE [dbo].[uspIncrementConsolidationCount]
	@SectionID integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--
	-- There are various things to do so wrap this in a transaction
	-- to prevent any problems.
	--
	
	declare @_Count as integer
	set @_Count = (SELECT TOP (1) ConsolidationCount FROM Sections WHERE SectionID = @SectionID) 
	set @_Count = @_Count + 1
	UPDATE Sections
	SET ConsolidationCount=@_Count
	WHERE SectionID = @SectionID
	--
	-- Return code indicates errors or success
	--
	SELECT @_Count
	RETURN @_Count
END
GO
