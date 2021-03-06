USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 07/12/2018
-- Description:	Reorders the Products in pl_Products - moving the given Product up or down.
-- =============================================
CREATE PROCEDURE [dbo].[ReorderProduct]
	-- Add the parameters for the stored procedure here
	@ProductID int,
	@Direction nvarchar(4) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	DECLARE @ProductNum INT
	Declare @MAX INT
	SELECT  @ProductNum = OrderByNumber FROM pl_Products WHERE ProductID = @ProductID
	SELECT @MAX = MAX(OrderByNumber) FROM pl_Products
	IF @Direction = 'UP' AND @ProductNum > 1
BEGIN
UPDATE pl_Products SET OrderByNumber = @ProductNum WHERE (OrderByNumber = @ProductNum -1)
UPDATE pl_Products SET OrderByNumber = @ProductNum - 1 WHERE ProductID = @ProductID
END

IF @Direction = 'DOWN' AND @ProductNum < @MAX
BEGIN
UPDATE pl_Products SET OrderByNumber = @ProductNum WHERE (OrderByNumber = @ProductNum +1)
UPDATE pl_Products SET OrderByNumber = @ProductNum + 1 WHERE ProductID = @ProductID
END


END


GO
