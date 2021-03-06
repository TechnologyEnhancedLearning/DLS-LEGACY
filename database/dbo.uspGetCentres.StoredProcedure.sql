USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 23/02/2012
-- Description:	Gets centres, filtering the list if region ID is not 0
--
-- =============================================
CREATE PROCEDURE [dbo].[uspGetCentres] 
	@RegionID as Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--
	-- These define the SQL to use
	--
	DECLARE @_SQL nvarchar(max)
	DECLARE @_SQLCentreFilter nvarchar(max)
	--
	-- Set up Dept filter clause if required
	--
	set @_SQLCentreFilter = 'Active = 1 AND NOT pwTelephone IS NULL'

	if @RegionID > 0
		begin
		set @_SQLCentreFilter = dbo.svfAnd(@_SQLCentreFilter) + 'RegionID = @RegionID'
		end
	--
	-- Set up the main query
	--
	SET @_SQL = 'SELECT CentreID, REPLACE(STR(CentreID, 3), SPACE(1), ''0'') AS CentreNumber, RegionID, CentreName, ContactForename, ContactSurname, ContactEmail, 
                      ContactTelephone, BannerText, Lat AS cLat, Long AS cLong, pwTelephone, pwEmail, pwPostCode, pwHours, pwWebURL, pwTrustsCovered, 
                      pwTrainingLocations, pwGeneralInfo, pwOffice03, pwOffice07, pwOffice10, pwClassroomDelivery, pwWorkshopDelivery, pwElearningDelivery, 
                      pwSelfStudyDelivery, pwOfficialExams, pwExternalCandidates, pwChargeExternals, LogoMimeType, LogoHeight, LogoWidth, CentreLogo
						FROM Centres  WHERE ' + @_SQLCentreFilter + 
				  ' ORDER BY CentreName'
	--
	-- Execute the query. Using sp_executesql means 
	-- that query plans are not specific for parameter values, but 
	-- just are specific for the particular combination of clauses in WHERE.
	-- Therefore there is a very good chance that the query plan will be in cache and
	-- won't have to be re-computed. Note that unused parameters are ignored.
	--
	PRINT @_SQL
	EXEC sp_executesql @_SQL, N'@RegionID Int',	@RegionID
END

GO
