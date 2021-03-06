USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 02/03/2011
-- Description:	Verify that ticket ID is valid for user
-- Rreturns:	1 if OK, 0 if not OK
-- =============================================
CREATE PROCEDURE [dbo].[uspVerifyTicketID] 
	@AdminUserID as Int,
	@TicketID as Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @_ReturnCode integer
	set @_ReturnCode = 0
	BEGIN TRY
		--
		-- Look at user and determine if it's OK
		--
		DECLARE @_UserAdmin bit
		DECLARE @_CentreManager bit
		DECLARE @_CentreID int
		DECLARE @_FoundTicketID int
		
		select @_UserAdmin = SummaryReports, @_CentreManager = IsCentreManager, @_CentreID = CentreID FROM AdminUsers WHERE AdminID = @AdminUserID
		
		if @_UserAdmin = 1 
			begin
			select @_FoundTicketID = t.TicketID -- allow all tickets - but have to exist
					FROM Tickets t 
					WHERE t.TicketID = @TicketID			
			end
		else if @_CentreManager = 1		-- find tickets for admin users in this centre
			begin
			select @_FoundTicketID = t.TicketID 
					FROM Tickets t 
					WHERE t.AdminUserID IN (SELECT AdminID FROM AdminUsers WHERE CentreID = @_CentreID) 
						AND t.TicketID = @TicketID
			end
		else
			begin						-- find my own tickets
			select @_FoundTicketID = t.TicketID 
					FROM Tickets t 
					WHERE t.AdminUserID = @AdminUserID 
						AND t.TicketID = @TicketID
			end
		--
		-- If we found the matching ticket then we can view it
		--
		if @_FoundTicketID = @TicketID 
			begin
			set @_ReturnCode = 1
			end
	END TRY
	BEGIN CATCH
		set @_ReturnCode = 0
	END CATCH
	--
	-- Return code indicates errors or success
	--
	SELECT @_ReturnCode
END
GO
