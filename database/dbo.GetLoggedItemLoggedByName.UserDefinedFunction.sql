USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 04/11/2019
-- Description:	Gets the name of the user who added a log item
-- =============================================
CREATE FUNCTION [dbo].[GetLoggedItemLoggedByName]
(
	-- Add the parameters for the function here
	@LogItemID int
)
RETURNS nvarchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar nvarchar(255)

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultVar = CASE WHEN LoggedByAdminID > 0 THEN ((SELECT        Forename + ' ' + Surname
                               FROM            AdminUsers
                               WHERE        AdminID = li.LoggedByAdminID) ) ELSE (SELECT        FirstName + ' ' + LastName 
                               FROM            Candidates
                               WHERE        (CandidateID = li.LoggedByID)) END
	FROM LearningLogItems AS li
	WHERE	LearningLogItemID = @LogItemID

	-- Return the result of the function
	RETURN @ResultVar

END
GO
