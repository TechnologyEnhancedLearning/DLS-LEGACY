USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 20/01/2020
-- Description:	Increments and returns the sequence number of a log item for calendar invite purposes
-- =============================================
CREATE PROCEDURE [dbo].[IncrementAndReturnLogItemSequenceNumber]
	-- Add the parameters for the stored procedure here
	@GUID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT SeqInt FROM LearningLogItems WHERE ICSGUID = @GUID
    -- Insert statements for procedure here
	UPDATE LearningLogItems
	SET SeqInt = SeqInt+1
	WHERE ICSGUID = @GUID

	
END
GO
