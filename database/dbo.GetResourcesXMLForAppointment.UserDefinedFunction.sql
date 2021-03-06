USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 18/11/2019
-- Description:	Gets the XML list of attendees (Resources) for a scheduler appointment (learning log item)
-- =============================================
CREATE FUNCTION [dbo].[GetResourcesXMLForAppointment]
(
	-- Add the parameters for the function here
	@LogItemID int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar nvarchar(MAX)
	SET @ResultVar = '<ResourceIds>'+char(10)
	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultVar = COALESCE(@ResultVar + '<ResourceId Type="System.Int32" Value="','<ResourceId Type="Sysem.Int32" Value="')+ CAST(ProgressID AS nvarchar) + '" />'+char(10)
	FROM ProgressLearningLogItems
	WHERE LearningLogItemID =@LogItemID
	SET @ResultVar = @ResultVar + '</ResourceIds>'
	-- Return the result of the function
	RETURN @ResultVar

END
GO
