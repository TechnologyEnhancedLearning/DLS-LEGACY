USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 10/10/2019
-- Description:	Moves all activity from one customisation to another (checking centre and app first)
-- =============================================
CREATE PROCEDURE [dbo].[uspMergeCustomisations]
	-- Add the parameters for the stored procedure here
	@Old_CustomisationID Int,
	@New_CustomisationID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if (SELECT        COUNT(*)
FROM            (SELECT        CentreID, ApplicationID
                          FROM            Customisations
                          WHERE        (CustomisationID = @Old_CustomisationID) OR
                                                    (CustomisationID = @New_CustomisationID)
                          GROUP BY CentreID, ApplicationID) AS q1) = 1
						  BEGIN
	UPDATE Progress
SET CustomisationID = @New_CustomisationID
WHERE CustomisationID = @Old_CustomisationID

UPDATE tActivityLog
SET CustomisationID = @New_CustomisationID
WHERE CustomisationID = @Old_CustomisationID

UPDATE [Sessions]
SET CustomisationID = @New_CustomisationID
WHERE CustomisationID = @Old_CustomisationID

UPDATE Evaluations
SET CustomisationID = @New_CustomisationID
WHERE CustomisationID = @Old_CustomisationID

UPDATE FollowUpFeedback
SET CustomisationID = @New_CustomisationID
WHERE CustomisationID = @Old_CustomisationID

UPDATE GroupCustomisations
SET CustomisationID = @New_CustomisationID
WHERE CustomisationID = @Old_CustomisationID


UPDATE Customisations
SET Active = 0
WHERE CustomisationID = @Old_CustomisationID
Return 1
END
ELSE
BEGIN
Return 0
END




END
GO
