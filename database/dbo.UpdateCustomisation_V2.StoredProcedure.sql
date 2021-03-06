USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 28/02/2020
-- Description:	Updates a customisation based on form values
-- V2 Adds @CCEmail
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCustomisation_V2]
	-- Add the parameters for the stored procedure here
	@CustomisationID As Int,
	@Active as bit,
	@CustomisationName as nvarchar(250),
	@Password as nvarchar(50),
	@SelfRegister as bit,
	@TutCompletionThreshold as int,
	@IsAssessed as bit,
	@DiagCompletionThreshold as int,
	@DiagObjSelect as bit,
	@HideInPortal as bit,
	@CompleteWithinMonths as int,
	@Mandatory as bit,
	@ValidityMonths as int,
	@AutoRefresh as bit,
	@RefreshToCustomisationID as int,
	@AutoRefreshMonths as int,
	@Q1Options as nvarchar(1000),
	@Q2Options as nvarchar(1000),
	@Q3Options as nvarchar(1000),
	@CourseField1PromptID as int,
	@CourseField2PromptID as int,
	@CourseField3PromptID as int,
	@InviteContributors as bit,
	@CCEmail as nvarchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_ReturnCode Int
	if exists (SELECT CustomisationID FROM dbo.Customisations WHERE [ApplicationID] = (SELECT ApplicationID FROM Customisations AS C2 WHERE C2.CustomisationID = @CustomisationID) AND [CentreID] = (SELECT CentreID FROM Customisations AS C3 WHERE C3.CustomisationID = @CustomisationID) AND [CustomisationName] = @CustomisationName and [CustomisationID] <> @CustomisationID)
	BEGIN
	--another customisation exists with the same name
	set @_ReturnCode = -1	
	goto OnExit
	end
    -- Insert statements for procedure here
	UPDATE       Customisations
SET                
Active = @Active, 
CustomisationName = @CustomisationName, 
Password = @Password, 
SelfRegister = @SelfRegister, 
CurrentVersion = CurrentVersion + 1, 
TutCompletionThreshold = @TutCompletionThreshold, 
IsAssessed = @IsAssessed, 
DiagCompletionThreshold = @DiagCompletionThreshold, 
DiagObjSelect = @DiagObjSelect, 
HideInLearnerPortal = @HideInPortal, 
CompleteWithinMonths = @CompleteWithinMonths, 
Mandatory = @Mandatory, 
ValidityMonths = @ValidityMonths, 
AutoRefresh = @AutoRefresh, 
RefreshToCustomisationID = @RefreshToCustomisationID, 
AutoRefreshMonths = @AutoRefreshMonths, 
Q1Options = @Q1Options, 
Q2Options = @Q2Options, 
Q3Options = @Q3Options, 
CourseField1PromptID = @CourseField1PromptID, 
CourseField2PromptID = @CourseField2PromptID, 
CourseField3PromptID = @CourseField3PromptID,
InviteContributors = @InviteContributors,
NotificationEmails = @CCEmail
WHERE        (CustomisationID = @CustomisationID)
SET @_ReturnCode = @CustomisationID
OnExit:
SELECT @_ReturnCode
Return @_ReturnCode
END
GO
