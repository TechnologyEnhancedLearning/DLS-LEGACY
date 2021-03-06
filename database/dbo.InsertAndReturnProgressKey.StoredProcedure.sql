USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 29/12/2016
-- Description:	Adds a progress key record to LearnerPortalProgressKeys and returns the GUID. For use in accessing ITSP services from the Learner Portal.
-- =============================================
CREATE PROCEDURE [dbo].[InsertAndReturnProgressKey] 
	-- Add the parameters for the stored procedure here
	@ProgressID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO LearnerPortalProgressKeys(ProgressID)
	VALUES (@ProgressID)
	DECLARE @_PKGUID as uniqueidentifier
	SELECT @_PKGUID = LPGUID FROM LearnerPortalProgressKeys WHERE ID = SCOPE_IDENTITY()
	SELECT @_PKGUID
	RETURN 1
END
GO
