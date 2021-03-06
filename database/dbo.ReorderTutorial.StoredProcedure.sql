USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 09/06/2015
-- Description:	Reorders the Tutorials in a given section - moving the given Tutorial up or down.
-- =============================================
CREATE PROCEDURE [dbo].[ReorderTutorial]
	-- Add the parameters for the stored procedure here
	@TutorialID int,
	@Direction nvarchar(4) = '',
	@SingleStep bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @SectionID INT
	DECLARE @TutorialNum INT
	Declare @MAX INT
	SELECT @SectionID = SectionID, @TutorialNum = OrderByNumber FROM Tutorials WHERE TutorialID = @TutorialID
	SELECT @MAX = MAX(OrderByNumber) FROM Tutorials WHERE SectionID = @SectionID
	IF @Direction = 'UP' AND @TutorialNum > 1 AND @SingleStep = 1
BEGIN
UPDATE Tutorials SET OrderByNumber = @TutorialNum WHERE (SectionID = @SectionID) AND (OrderByNumber = @TutorialNum -1)
UPDATE Tutorials SET OrderByNumber = @TutorialNum - 1 WHERE TutorialID = @TutorialID
END

IF @Direction = 'DOWN' AND @TutorialNum < @MAX AND @SingleStep = 1
BEGIN
UPDATE Tutorials SET OrderByNumber = @TutorialNum WHERE (SectionID = @SectionID) AND (OrderByNumber = @TutorialNum +1)
UPDATE Tutorials SET OrderByNumber = @TutorialNum + 1 WHERE TutorialID = @TutorialID
END

IF @Direction = 'UP' AND @TutorialNum > 1 AND @SingleStep = 0
BEGIN
UPDATE Tutorials SET OrderByNumber = OrderByNumber + 1 WHERE (SectionID = @SectionID) AND (OrderByNumber < @TutorialNum)
UPDATE Tutorials SET OrderByNumber = 1 WHERE TutorialID = @TutorialID
END

IF @Direction = 'DOWN' AND @TutorialNum < @MAX AND @SingleStep = 0
BEGIN
UPDATE Tutorials SET OrderByNumber = OrderByNumber - 1 WHERE (SectionID = @SectionID) AND (OrderByNumber > @TutorialNum)
UPDATE Tutorials SET OrderByNumber = @MAX WHERE TutorialID = @TutorialID
END
END


GO
