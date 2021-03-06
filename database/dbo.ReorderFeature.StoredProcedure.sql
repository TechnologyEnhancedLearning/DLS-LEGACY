USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 07/12/2018
-- Description:	Reorders the Features in a given Product - moving the given Feature up or down.
-- =============================================
CREATE PROCEDURE [dbo].[ReorderFeature]
	-- Add the parameters for the stored procedure here
	@FeatureID int,
	@Direction nvarchar(4) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @ProductID INT
	DECLARE @FeatureNum INT
	Declare @MAX INT
	SELECT @ProductID = ProductID, @FeatureNum = OrderByNumber FROM pl_Features WHERE FeatureID = @FeatureID
	SELECT @MAX = MAX(OrderByNumber) FROM pl_Features WHERE ProductID = @ProductID
	IF @Direction = 'UP' AND @FeatureNum > 1
BEGIN
UPDATE pl_Features SET OrderByNumber = @FeatureNum WHERE (ProductID = @ProductID) AND (OrderByNumber = @FeatureNum -1)
UPDATE pl_Features SET OrderByNumber = @FeatureNum - 1 WHERE FeatureID = @FeatureID
END

IF @Direction = 'DOWN' AND @FeatureNum < @MAX
BEGIN
UPDATE pl_Features SET OrderByNumber = @FeatureNum WHERE (ProductID = @ProductID) AND (OrderByNumber = @FeatureNum +1)
UPDATE pl_Features SET OrderByNumber = @FeatureNum + 1 WHERE FeatureID = @FeatureID
END

END


GO
