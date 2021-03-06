USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 04/05/2017
-- Description:	Returns SLA compliance helpdesk stats for a number of months
-- =============================================
CREATE PROCEDURE [dbo].[GetHelpDeskStats]
	-- Add the parameters for the stored procedure here
	@Months int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CAST(DATEPART(Year, PeriodStart) AS varchar) + '-' + RIGHT('00' + CAST(DATEPART(Month, PeriodStart) AS VarChar), 2) AS period, Tickets, COALESCE(SLACompliant, 0) AS SLACompliant, COALESCE(Tickets - SLACompliant, 0) AS NonCompliant,
               (SLACompliant * 1.0) / (Tickets * 1.0) * 100 AS Compliance
FROM  (SELECT TOP (100) PERCENT CONVERT(DateTime, PeriodStart) AS PeriodStart,
                                  (SELECT COUNT(TicketID) AS Tickets
                                   FROM   (SELECT TicketID,
                                                                      (SELECT TOP (1) TCDate
                                                                       FROM   TicketComments
                                                                       WHERE (TicketID = T.TicketID)) AS RaisedDate
                                                   FROM   Tickets AS T
                                                   WHERE (AdminUserID NOT IN
                                                                      (SELECT AdminID
                                                                       FROM   AdminUsers
                                                                       WHERE (CentreID = 101)))) AS Q1
                                   WHERE (RaisedDate >= GetMonthTable_1.PeriodStart) AND (RaisedDate < GetMonthTable_1.PeriodEnd)) AS Tickets,
                                  (SELECT SUM(SLAStatus) AS Tickets
                                   FROM   (SELECT TicketID,
                                                                      (SELECT TOP (1) TCDate
                                                                       FROM   TicketComments AS TicketComments_4
                                                                       WHERE (TicketID = T.TicketID)) AS RaisedDate,
                                                                      (SELECT     COUNT(TicketID) AS SLA
                                                                                                         FROM          Tickets
                                                                                                         WHERE      (TicketID = T.TicketID) AND
                                                                                                                                    (((SELECT     dbo.DateDiffWeekdays
                                                                                                                                                                  ((SELECT     TOP (1) TCDate
                                                                                                                                                                      FROM         TicketComments AS TicketComments_3
                                                                                                                                                                      WHERE     (TicketID = T.ticketID)),
                                                                                                                                                                  (SELECT     TOP (1) TCDate
                                                                                                                                                                    FROM          TicketComments AS TicketComments_2
                                                                                                                                                                    WHERE      (TicketID = T.ticketID) AND (TicketCommentID >
                                                                                                                                                                                               (SELECT     TOP (1) TicketCommentID
                                                                                                                                                                                                 FROM          TicketComments AS TicketComments_1
                                                                                                                                                                                                 WHERE      (TicketID = T.ticketID))))) AS Expr1) < 3)OR(
																																																 dbo.DateDiffWeekdays
                                                                                                                                                                  (T.RaisedDate, T.ArchivedDate) < 3
																																																 ))) AS SLAStatus
                                                   FROM   Tickets AS T
                                                   WHERE (AdminUserID NOT IN
                                                                      (SELECT AdminID
                                                                       FROM   AdminUsers AS AdminUsers_1
                                                                       WHERE (CentreID = 101)))) AS Q2
                                   WHERE (RaisedDate >= GetMonthTable_1.PeriodStart) AND (RaisedDate < GetMonthTable_1.PeriodEnd)) AS SLACompliant
               FROM   dbo.GetMonthTable(@Months) AS GetMonthTable_1
               ORDER BY PeriodStart) AS OuterSub
END
GO
