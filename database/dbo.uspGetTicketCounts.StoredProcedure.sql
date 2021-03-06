USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 24/02/2011
-- Description:	Gets ticket counts appropriate for the user
-- =============================================
CREATE PROCEDURE [dbo].[uspGetTicketCounts] 
	@AdminUserID as Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--
	-- These define the SQL to use
	--
	DECLARE @_SQL nvarchar(max)
	DECLARE @_SQLWhere nvarchar(max)
	DECLARE @_SQLResponseWhere nvarchar(max)
	
	--
	-- Set up Where clause
	--
	DECLARE @_UserAdmin bit
	DECLARE @_CentreManager bit
	DECLARE @_CentreID int
	
	select @_UserAdmin = UserAdmin, @_CentreManager = IsCentreManager, @_CentreID = CentreID FROM AdminUsers WHERE AdminID = @AdminUserID
	
	if @_UserAdmin = 1 
		begin
		set @_SQLWhere = ' '
		set @_SQLResponseWhere = ' t.TStatusID in (1, 2)'
		end
	else if @_CentreManager = 1		-- find tickets for admin users in this centre
		begin
		set @_SQLWhere = ' AND t.AdminUserID IN (SELECT AdminID FROM AdminUsers WHERE CentreID = @_CentreID) AND t.ArchivedDate is NULL '
		set @_SQLResponseWhere = ' t.TStatusID = 3 '
		end
	else
		begin
		set @_SQLWhere = ' AND t.AdminUserID = @AdminUserID AND t.ArchivedDate is NULL ' -- default is my own tickets
		set @_SQLResponseWhere = ' t.TStatusID = 3 '
		end
	--
	-- Set up the main query
	--
	SET @_SQL = 'SELECT
					(SELECT Count(t.TicketID) FROM Tickets t WHERE t.TStatusID in (1, 2, 3) ' + @_SQLWhere + ') AS OpenTickets,
					(SELECT Count(t.TicketID) FROM Tickets t WHERE ' + @_SQLResponseWhere + @_SQLWhere + ') AS ResponseTickets'
	--
	-- Execute the query. Using sp_executesql means 
	-- that query plans are not specific for parameter values, but 
	-- just are specific for the particular combination of clauses in WHERE.
	-- Therefore there is a very good chance that the query plan will be in cache and
	-- won't have to be re-computed. Note that unused parameters are ignored.
	--
	EXEC sp_executesql @_SQL, 	N'@_CentreID Int,
								  @AdminUserID Int',
					   @_CentreID,
					   @AdminUserID
END
GO
