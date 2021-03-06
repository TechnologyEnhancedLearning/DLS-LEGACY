USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 18/11/2019
-- Description:	Gets the XML list of attendees (Resources) for a scheduler appointment (learning log item)
-- =============================================
CREATE FUNCTION [dbo].[GetSipsCSVForAppointment]
(
	-- Add the parameters for the function here
	@LogItemID int,
	@MyEmail nvarchar(255)
)
RETURNS nvarchar(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar nvarchar(MAX)
	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultVar = COALESCE(@ResultVar + ',','')+ Q2.Email
	FROM 
	(SELECT DISTINCT Email
FROM            (SELECT        ca.EmailAddress AS Email
                          FROM            Candidates AS ca INNER JOIN
                                                    Progress AS p ON ca.CandidateID = p.CandidateID INNER JOIN
                                                    ProgressLearningLogItems AS pli ON p.ProgressID = pli.ProgressID
                          WHERE        (pli.LearningLogItemID = @LogItemID)
                          UNION
                          SELECT        au.Email AS Expr1
                          FROM            AdminUsers AS au INNER JOIN
                                                   LearningLogItems AS li ON au.AdminID = li.LoggedByAdminID
                          WHERE        (li.LearningLogItemID = @LogItemID)) AS Q1
WHERE        (Email <> '')) AS Q2 WHERE Email <> @MyEmail
	--SET @ResultVar = @ResultVar + '"'
	-- Return the result of the function
	RETURN @ResultVar

END
GO
