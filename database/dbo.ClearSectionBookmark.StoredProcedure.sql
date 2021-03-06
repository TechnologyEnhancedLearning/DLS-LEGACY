USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Whittaker, Kevin
-- Create date: 23/02/2015
-- Description:	Clears progress field for candidate / customisation when error message happening.
-- =============================================
CREATE PROCEDURE [dbo].[ClearSectionBookmark]
	-- Add the parameters for the stored procedure here
	@DelegateID varchar(10),
	@CustomisationID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
UPDATE    Progress
SET              ProgressText = NULL
FROM         Candidates INNER JOIN
                      Progress ON Candidates.CandidateID = Progress.CandidateID
WHERE     (Progress.CustomisationID = @CustomisationID) AND (Candidates.CandidateNumber = @DelegateID)
END
GO
