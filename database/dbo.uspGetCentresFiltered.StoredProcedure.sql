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
CREATE PROCEDURE [dbo].[uspGetCentresFiltered] 
	@CentreName as nvarchar(250),
	@ContactEmail as nvarchar(250),
	@ShowOnlyActive as bit
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
	set @_SQLCentreFilter = ''

	if Len(@CentreName) > 0
		begin
		set @_SQLCentreFilter = dbo.svfAnd(@_SQLCentreFilter) + '(CentreName LIKE ''%' + @CentreName + '%'') '
		end
		if Len(@ContactEmail) > 0
		begin
		set @_SQLCentreFilter = dbo.svfAnd(@_SQLCentreFilter) + '(ContactEmail LIKE ''%' + @ContactEmail + '%'') '
		end
		if @ShowOnlyActive = 1
		begin
		set @_SQLCentreFilter = dbo.svfAnd(@_SQLCentreFilter) + '(Active = 1)'
		end
		
	--
	-- Set up the main query
	--
	SET @_SQL = 'SELECT CentreID, Active, RegionID, CentreName, ContactForename, ContactSurname, ContactEmail, ContactTelephone, PriorCandidates, AutoRegistered, BannerText,  COALESCE((SELECT CustomPrompt FROM CustomPrompts WHERE CustomPromptID = c.CustomField1PromptID), '') AS F1Name, 
                  F1Mandatory, F1Options,  COALESCE((SELECT CustomPrompt FROM CustomPrompts WHERE CustomPromptID = c.CustomField2PromptID), '') AS F2Name, F2Mandatory, F2Options,  COALESCE((SELECT CustomPrompt FROM CustomPrompts WHERE CustomPromptID = c.CustomField3PromptID), '') AS F3Name, F3Mandatory, F3Options, AutoRegisterManagerEmail,
                      (SELECT RegionName
                       FROM      Regions
                       WHERE   (RegionID = c.RegionID)) AS RegionName, SignatureMimeType, SignatureImage, SignatureWidth, SignatureHeight, CentreLogo, LogoWidth, LogoHeight, 
                  LogoMimeType, BetaTesting, CentreTypeID,
                      (SELECT CentreType
                       FROM      CentreTypes
                       WHERE   (CentreTypeID = c.CentreTypeID)) AS CentreType, IPPrefix, CentreCreated
FROM     Centres as c ' + @_SQLCentreFilter + 
				  ' ORDER BY CentreName'
	--
	-- Execute the query. Using sp_executesql means 
	-- that query plans are not specific for parameter values, but 
	-- just are specific for the particular combination of clauses in WHERE.
	-- Therefore there is a very good chance that the query plan will be in cache and
	-- won't have to be re-computed. Note that unused parameters are ignored.
	--
	PRINT @_SQL
	EXEC sp_executesql @_SQL, N'@CentreName nvarchar(255), @ContactEmail nvarchar(255), @ShowOnlyActive bit',	@CentreName, @ContactEmail, @ShowOnlyActive
END
GO
