USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 07/12/2018
-- Description:	Reorders the CaseContents in a given CaseStudy - moving the given CaseContent up or down.
-- =============================================
CREATE PROCEDURE [dbo].[ReorderCaseContent]
	-- Add the parameters for the stored procedure here
	@CaseContentID int,
	@Direction nvarchar(4) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @CaseStudyID INT
	DECLARE @CaseContentNum INT
	Declare @MAX INT
	SELECT @CaseStudyID = CaseStudyID, @CaseContentNum = OrderByNumber FROM pl_CaseContent WHERE CaseContentID = @CaseContentID
	SELECT @MAX = MAX(OrderByNumber) FROM pl_CaseContent WHERE CaseStudyID = @CaseStudyID
	IF @Direction = 'UP' AND @CaseContentNum > 1
BEGIN
UPDATE pl_CaseContent SET OrderByNumber = @CaseContentNum WHERE (CaseStudyID = @CaseStudyID) AND (OrderByNumber = @CaseContentNum -1)
UPDATE pl_CaseContent SET OrderByNumber = @CaseContentNum - 1 WHERE CaseContentID = @CaseContentID
END

IF @Direction = 'DOWN' AND @CaseContentNum < @MAX
BEGIN
UPDATE pl_CaseContent SET OrderByNumber = @CaseContentNum WHERE (CaseStudyID = @CaseStudyID) AND (OrderByNumber = @CaseContentNum +1)
UPDATE pl_CaseContent SET OrderByNumber = @CaseContentNum + 1 WHERE CaseContentID = @CaseContentID
END

END


GO
