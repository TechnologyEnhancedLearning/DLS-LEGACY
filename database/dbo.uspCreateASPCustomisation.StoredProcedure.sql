USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 15 February 2012

-- =============================================
CREATE PROCEDURE [dbo].[uspCreateASPCustomisation] 
	@ApplicationID int,
	@CentreID integer,
	@CustomisationName varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if exists (SELECT CustomisationID
FROM dbo.Customisations WHERE [ApplicationID] = @ApplicationID AND [CentreID] = @CentreID AND [CustomisationName] = @CustomisationName)
	BEGIN
	BEGIN TRY
	DELETE FROM dbo.Customisations WHERE [ApplicationID] = @ApplicationID AND [CentreID] = @CentreID AND [CustomisationName] = @CustomisationName
	END TRY
	BEGIN CATCH
	UPDATE dbo.Customisations SET [CustomisationName]= @CustomisationName + '*' WHERE [ApplicationID] = @ApplicationID AND [CentreID] = @CentreID AND [CustomisationName] = @CustomisationName
	END CATCH
	END
	declare @_ReturnCode integer
	declare @_IsAssessed as bit
	declare @_DiagThresh as integer
	SELECT @_IsAssessed = PLAssess, @_DiagThresh = Case when DiagAssess = 1 then 85 else 0 end FROM Applications WHERE ApplicationID = @ApplicationID
	set @_ReturnCode = -1	
	BEGIN TRY
		BEGIN TRANSACTION AddCustomisation
		--
			-- Insert a new customisation
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
				 [IsStandard],
				 [DiagCompletionThreshold]) 
			VALUES (1, 1, @CentreID, @ApplicationID, @CustomisationName, '', '', '', '', @_IsAssessed, 0, @_DiagThresh);

		
		declare @CustomisationID integer
		Set @CustomisationID = (SELECT SCOPE_IDENTITY())
		PRINT @CustomisationID
		-- Insert records into CustomisationTutorials
		INSERT INTO CustomisationTutorials
		(CustomisationID, TutorialID)
		(SELECT     @CustomisationID as CustomisationID, T.TutorialID
FROM         Tutorials AS T INNER JOIN
                      Sections AS S ON T.SectionID = S.SectionID 
WHERE     (S.ApplicationID = @ApplicationID) AND (T.ArchivedDate IS NULL) AND (S.ArchivedDate IS NULL))
		
		--
		-- All finished
		--
		COMMIT TRANSACTION AddCustomisation
		--
		-- Decide what the return code should be - depends on whether they
		-- need to be approved or not
		--
		set @_ReturnCode = 	@CustomisationID				-- assume that user is registered
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION AddCustomisation
	END CATCH
	--
	-- Return code indicates errors or success
	--
	SELECT @_ReturnCode
END
GO
