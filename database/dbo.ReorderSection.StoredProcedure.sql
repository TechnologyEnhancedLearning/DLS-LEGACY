USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 18/05/2015
-- Description:	Reorders the sections in a given course - moving the given section up or down.
-- =============================================
CREATE PROCEDURE [dbo].[ReorderSection]
	-- Add the parameters for the stored procedure here
	@SectionID int,
	@Direction nvarchar(4) = '',
	@SingleStep bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @CourseID INT
	DECLARE @SectionNum INT
	Declare @MAX INT
	SELECT @CourseID = ApplicationID, @SectionNum = SectionNumber FROM Sections WHERE SectionID = @SectionID
	SELECT @MAX = MAX(SectionNumber) FROM Sections WHERE ApplicationID = @CourseID
	IF @Direction = 'UP' AND @SectionNum > 1 AND @SingleStep = 1
BEGIN
UPDATE Sections SET SectionNumber = @SectionNum WHERE (ApplicationID = @CourseID) AND (SectionNumber = @SectionNum -1)
UPDATE Sections SET SectionNumber = @SectionNum - 1 WHERE SectionID = @SectionID
END

IF @Direction = 'DOWN' AND @SectionNum < @MAX AND @SingleStep = 1
BEGIN
UPDATE Sections SET SectionNumber = @SectionNum WHERE (ApplicationID = @CourseID) AND (SectionNumber = @SectionNum +1)
UPDATE Sections SET SectionNumber = @SectionNum + 1 WHERE SectionID = @SectionID
END
IF @Direction = 'UP' AND @SectionNum > 1 AND @SingleStep = 0
BEGIN
UPDATE Sections SET SectionNumber = (SectionNumber + 1) WHERE (ApplicationID = @CourseID) AND SectionNumber < @SectionNum
UPDATE Sections SET SectionNumber = 1 WHERE SectionID = @SectionID
END

IF @Direction = 'DOWN' AND @SectionNum < @MAX AND @SingleStep = 0
BEGIN
UPDATE Sections SET SectionNumber = (SectionNumber - 1) WHERE (ApplicationID = @CourseID) AND SectionNumber > @SectionNum
UPDATE Sections SET SectionNumber = @MAX WHERE SectionID = @SectionID
END
END

GO
