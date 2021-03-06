USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 14/03/13
-- Description:	Merges tw centres and then inactivates one
-- =============================================
CREATE PROCEDURE [dbo].[uspMergeCentresAndCloseOne]
	@NewCentreName varchar(250),
	@OldCentreID integer,
	@NewCentreID integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	declare @_ReturnCode varchar(100)
	set @_ReturnCode = '0'
	BEGIN
	UPDATE      AdminUsers
SET                CentreID = @NewCentreID
WHERE        (CentreID = @OldCentreID)
END
BEGIN
UPDATE       Customisations
SET                CentreID = @NewCentreID, CustomisationName = CustomisationName + ' (' + CAST(@OldCentreID AS VARCHAR) + ')'
WHERE        (CentreID = @OldCentreID)
END
BEGIN
UPDATE       Candidates
SET                CentreID = @NewCentreID
WHERE        (CentreID = @OldCentreID)
END
BEGIN
UPDATE       Centres
SET                Active = 0, CentreName = 'Closed_' + CentreName, Deleted = 1
WHERE        (CentreID = @OldCentreID)
END
BEGIN
UPDATE       Centres
SET                CentreName = @NewCentreName
WHERE        (CentreID = @NewCentreID)
set @_ReturnCode = '1'
	END
	SELECT @_ReturnCode
	RETURN @_ReturnCode
END
GO
