USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 21 March 2013
-- Description:	Increments video count by 1
-- =============================================
CREATE PROCEDURE [dbo].[uspIncrementVideoCountKB]
	@TutorialID integer,
	@CandidateID as integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--
	-- There are various things to do so wrap this in a transaction
	-- to prevent any problems.
	--
	INSERT INTO [kbVideoTrack] ([TutorialID],[CandidateID])
	Values (@TutorialID, @CandidateID)

	declare @_Count as integer
	declare @_KBCount as integer
	SELECT TOP (1) @_Count = VideoCount, @_KBCount = KBVideoCount  FROM Tutorials WHERE TutorialID = @TutorialID
	set @_Count = @_Count + 1
	set @_KBCount = @_KBCount + 1
	UPDATE Tutorials
	SET VideoCount=@_Count, KBVideoCount = @_KBCount
	WHERE TutorialID = @TutorialID
	--
	-- Return code indicates errors or success
	--
	SELECT @_Count
	RETURN @_Count
END

GO
