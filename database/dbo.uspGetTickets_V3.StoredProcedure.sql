USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 29/09/2017
-- Description:	Gets tickets appropriate for the user
-- =============================================
CREATE PROCEDURE [dbo].[uspGetTickets_V3] 
	@AdminUserID as Int,
	@ShowArchivedTickets as bit
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
	DECLARE @_SortExpression nvarchar(max)
	set @_SQLWhere = ' '
	--
	-- Set up Where clause
	--
	DECLARE @_UserAdmin bit
	DECLARE @_CentreManager bit
	DECLARE @_CentreID int
	
	select @_UserAdmin = UserAdmin, @_CentreManager = IsCentreManager, @_CentreID = CentreID FROM AdminUsers WHERE AdminID = @AdminUserID
	
	if @_UserAdmin = 1 
		begin
		
		if @ShowArchivedTickets = 1
			begin
			set @_SQLWhere = @_SQLWhere
			end
		else
			begin
			if @_SQLWhere = ' '
			begin
			set @_SQLWhere = ' WHERE t.ArchivedDate is NULL '
			end
			else
			begin
			set @_SQLWhere = @_SQLWhere + ' AND t.ArchivedDate is NULL '
			end
			
			end
		end
	else if @_CentreManager = 1		-- find tickets for admin users in this centre
		begin
		set @_SQLWhere = ' WHERE t.AdminUserID IN (SELECT AdminID FROM AdminUsers WHERE CentreID = @_CentreID) '
		end
	else
		begin
		set @_SQLWhere = ' WHERE t.AdminUserID = @AdminUserID ' -- default is my own tickets
		end
		if @_UserAdmin = 0 AND @ShowArchivedTickets = 0
		begin
		if @_SQLWhere = ' '
			begin
			set @_SQLWhere = ' WHERE t.ArchivedDate is NULL '
			end
			else
			begin
			set @_SQLWhere = @_SQLWhere + ' AND t.ArchivedDate is NULL '
			end
		end
	--
	-- Set up sort clause. Combine user selection with defaults.
	--
	
	--
	-- Set up the main query
	--
	SET @_SQL = 'SELECT
					t.TicketID, 
					a.Surname + '', '' + a.Forename AS ReporterName, 
					c.CentreName,
					t.RaisedDate, 
					t.QuerySubject, 
					(SELECT TStatus FROM TicketStatus WHERE TStatusID = t.TStatusID) AS TStatus, 
					t.TStatusID,
					CASE t.AssignedToID 
					   WHEN NULL THEN '''' 
					   ELSE 
						  (SELECT Surname + '', '' + Forename FROM AdminUsers WHERE AdminID = t.AssignedToID) 
					   END AS AssignedToName, 
					CASE t.AssignedToID 
					   WHEN NULL THEN '''' 
					   ELSE 
						  (SELECT Email FROM AdminUsers WHERE AdminID = t.AssignedToID) 
					   END AS AssignedToEmail, 
					t.ArchivedDate,
					(SELECT TOP 1 TCDate FROM TicketComments tc WHERE tc.TicketID = t.TicketID ORDER BY tc.TicketCommentID DESC) AS LastActivityDate,
					a.Forename,
					a.Email,
                      (SELECT TicketType
                       FROM      TicketTypes
                       WHERE   (TicketTypeID = t.TicketTypeID)) AS Type,
                      (SELECT TicketCategory
                       FROM      TicketCategories
                       WHERE   (TicketCategoryID = t.TicketCategoryID)) AS Category, t.ResolveInDays, DATEADD(D, t.ResolveInDays, t.RaisedDate) AS ResolveBy
				FROM Tickets t 
					INNER JOIN AdminUsers a ON a.AdminID = t.AdminUserID
					INNER JOIN Centres c ON a.CentreID = c.CentreID ' + @_SQLWhere + ' ORDER BY RaisedDate Desc'
	--
	-- Execute the query. Using sp_executesql means 
	-- that query plans are not specific for parameter values, but 
	-- just are specific for the particular combination of clauses in WHERE.
	-- Therefore there is a very good chance that the query plan will be in cache and
	-- won't have to be re-computed. Note that unused parameters are ignored.
	--
	PRINT @_SQL
	EXEC sp_executesql @_SQL, 	N'@_CentreID Int,
								  @AdminUserID Int',
					   @_CentreID,
					   @AdminUserID
END


/****** Object:  StoredProcedure [dbo].[uspVerifyTicketID]    Script Date: 03/11/2014 11:16:31 ******/
SET ANSI_NULLS ON
GO
