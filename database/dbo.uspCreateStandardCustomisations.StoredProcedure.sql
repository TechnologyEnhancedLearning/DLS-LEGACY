USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 8th September 2010
-- Description:	Creates standard customisations for all centres if not created.
-- =============================================
CREATE PROCEDURE [dbo].[uspCreateStandardCustomisations] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @_ReturnCode integer
	set @_ReturnCode = 100	
	BEGIN TRY
		BEGIN TRANSACTION AddCustomisations
		--
		-- We find all the centres that don't have a standard customisation. To enable
		-- iteration through this list we create a cursor.
		--
		DECLARE @_CentreID AS Int
		DECLARE CentreList CURSOR LOCAL FAST_FORWARD FOR
			SELECT c.CentreID FROM dbo.Centres c WHERE c.CentreID not in (Select distinct cu.CentreID from dbo.Customisations cu)
		OPEN CentreList
		FETCH NEXT FROM CentreList INTO @_CentreID
		--
		-- Iterate through centres with no standard customisation
		--
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--
			-- Insert a standard customisation
			--
			INSERT INTO dbo.Customisations 
				([Active], 
				 [CurrentVersion], 
				 [CentreID], 
				 [ApplicationID], 
				 [CustomisationName], 
				 [CustomisationText], 
				 [Question1], 
				 [Question2], 
				 [Question3], 
				 [IsAssessed],
				 [IsStandard]) 
			VALUES (1, 1, @_CentreID, 1, 'Standard', dbo.GetStandardCustomisationText(), '', '', '', 1, 1);
			INSERT INTO dbo.CentreApplications
			([CentreID],
			[ApplicationID])
			SELECT @_CentreID as CentreID, ApplicationID FROM
			dbo.Applications WHERE Debug = 0 AND CreatedByCentreID = 101 AND CreatedByID = 1
			
			--
			-- Move to the next centre with no customisation
			--
			FETCH NEXT FROM CentreList INTO @_CentreID
		END
		CLOSE CentreList
		--
		-- All finished, commit now
		--
		COMMIT TRANSACTION AddCustomisations
		SET @_ReturnCode = 0
	END TRY
	BEGIN CATCH
		if @@TRANCOUNT > 0
			ROLLBACK TRANSACTION AddCustomisations
	END CATCH
	SELECT @_ReturnCode
END
GO
