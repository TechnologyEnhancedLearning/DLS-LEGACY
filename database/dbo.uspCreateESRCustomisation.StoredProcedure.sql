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
CREATE PROCEDURE [dbo].[uspCreateESRCustomisation]
@ApplicationID int,
	@CentreID integer 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @_ReturnCode integer
	set @_ReturnCode = -1	
	BEGIN TRY
		BEGIN TRANSACTION AddCustomisations
		--
		-- We find all the centres that don't have a standard customisation. To enable
		-- iteration through this list we create a cursor.
		--

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
			VALUES (1, 1, @CentreID, @ApplicationID, 'ESR', dbo.GetStandardCustomisationTextByApp(@ApplicationID), '', '', '', 1, 1);
			--
			-- Move to the next centre with no customisation
			--

		END

		--
		-- All finished, commit now
		--
		COMMIT TRANSACTION AddCustomisations
		SET @_ReturnCode = SCOPE_IDENTITY()
	END TRY
	BEGIN CATCH
		if @@TRANCOUNT > 0
			ROLLBACK TRANSACTION AddCustomisations
	END CATCH
	SELECT @_ReturnCode
	RETURN @_ReturnCode
END
GO
