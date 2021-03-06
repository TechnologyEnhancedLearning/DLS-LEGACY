USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 15/11/2018
-- Description:	Enrols delegates on refresher course and archives old progress
-- =============================================
CREATE PROCEDURE [dbo].[RefresherCourseEnrolAndArchiveProgress]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Refresh TABLE (RefreshID int not null primary key identity(1,1), ProgressID int, CandidateID int, RefreshToCustomisationID Int, CentreID Int, CompleteWithinMonths Int)
  
	INSERT INTO @Refresh (ProgressID, CandidateID, RefreshToCustomisationID, CentreID, CompleteWithinMonths)
	SELECT p.ProgressID, p.CandidateID, CASE WHEN c.RefreshToCustomisationID > 0 THEN RefreshToCustomisationID ELSE p.CustomisationID END AS RefreshToCustomisationID, 
                  c.CentreID, c.CompleteWithinMonths
FROM     Progress AS p INNER JOIN
                  Customisations AS c ON p.CustomisationID = c.CustomisationID
WHERE  (c.AutoRefresh = 1) AND (DATEADD(M, c.ValidityMonths - c.AutoRefreshMonths, p.Completed) < GETDATE()) AND (p.RemovedDate IS NULL)
DECLARE @RefreshID     int 

While exists (Select * From @Refresh) 

    Begin
	
	SELECT @RefreshID = Min(RefreshID) from @Refresh
	DECLARE @_ProgressID Int
	DECLARE @_CandidateID int
	DECLARE @_RefreshToCustomisationID Int
	DECLARE @_CentreID Int
	DECLARE @_CompleteWithinMonths Int

	SELECT @_ProgressID = ProgressID, @_CandidateID = CandidateID, @_RefreshToCustomisationID = RefreshToCustomisationID, @_CentreID = CentreID, @_CompleteWithinMonths= CompleteWithinMonths FROM @Refresh WHERE RefreshID = @RefreshID

	UPDATE Progress SET SystemRefreshed = 1, RemovedDate = getUTCDate(), RemovalMethodID = 4 WHERE ProgressID = @_ProgressID
	EXEC dbo.uspCreateProgressRecordWithCompleteWithinMonths @_CandidateID, @_RefreshToCustomisationID, @_CentreID, 4, 0, @_CompleteWithinMonths
	DELETE FROM @Refresh WHERE RefreshID = @RefreshID
end
END
GO
