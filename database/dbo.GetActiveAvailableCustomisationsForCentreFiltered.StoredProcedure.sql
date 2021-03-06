USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 22/12/2016
-- Description:	Returns active available customisations for centre
-- =============================================
CREATE PROCEDURE [dbo].[GetActiveAvailableCustomisationsForCentreFiltered]
	-- Add the parameters for the stored procedure here
	@CentreID as Int = 0,
	@OfficeVersionCSV as varchar(30),
	@ApplicationCSV as varchar(30),
	@ApplicationGroupCSV as varchar(30),
	@CandidateID as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_SQL nvarchar(max)
	DECLARE @_SQLFilter nvarchar(max)
	-- Build application filter string
	Set @_SQLFilter = ' WHERE (cu.CentreID = @CentreID) AND (cu.Active = 1) AND (cu.HideInLearnerPortal = 0) AND (a.ASPMenu = 1) AND (a.ArchivedDate IS NULL) AND (dbo.CheckDelegateStatusForCustomisation(cu.CustomisationID, @CandidateID) IN (0,1,4)) '
	if Len(@OfficeVersionCSV) > 0
	begin
		set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + 'OfficeVersionID IN (' + @OfficeVersionCSV + ')'
	end
	if Len(@ApplicationCSV) > 0
	begin
		set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + 'OfficeAppID IN (' + @ApplicationCSV + ')'
	end
	if Len(@ApplicationGroupCSV) > 0
	begin
		set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + 'AppGroupID IN (' + @ApplicationGroupCSV + ')'
	end
   set @_SQLFilter = dbo.svfAnd(@_SQLFilter) + '(cu.CustomisationName <> ''ESR'')'
    -- Insert statements for procedure here
	--Build the main query
	SET @_SQL = 'SELECT cu.CustomisationID, cu.Active, cu.CurrentVersion, cu.CentreID, cu.ApplicationID, a.ApplicationName + '' - '' + cu.CustomisationName AS CourseName, cu.CustomisationText, 
               cu.IsAssessed, dbo.CheckCustomisationSectionHasDiagnostic(cu.CustomisationID, 0) AS HasDiagnostic, 
               dbo.CheckCustomisationSectionHasLearning(cu.CustomisationID, 0) AS HasLearning, a.AppGroupID, a.OfficeAppID, a.OfficeVersionID, (SELECT ApplicationGroup FROM ApplicationGroups WHERE AppGroupID = a.AppGroupID) AS Level, (SELECT OfficeApplication FROM OfficeApplications WHERE OfficeAppID = a.OfficeAppID) AS Application, (SELECT OfficeVersion FROM OfficeVersions WHERE OfficeVersionID = a.OfficeVersionID) AS OfficeVers, dbo.CheckDelegateStatusForCustomisation(cu.CustomisationID, @CandidateID) AS DelegateStatus
FROM  Customisations AS cu INNER JOIN
               Applications AS a ON cu.ApplicationID = a.ApplicationID' + @_SQLFilter + ' ORDER BY a.ApplicationName + '' - '' + cu.CustomisationName'
PRINT @_SQL
EXEC sp_executesql @_SQL, 	N'@CentreID Int,
	@OfficeVersionCSV varchar(30),
	@ApplicationCSV varchar(30),
	@ApplicationGroupCSV varchar(30),
	@CandidateID int',
					   @CentreID,
	@OfficeVersionCSV,
	@ApplicationCSV,
	@ApplicationGroupCSV,
	@CandidateID
END
GO
