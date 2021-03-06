USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 09/06/2015
-- Description:	Reorders the Brands in a given section - moving the given Brand up or down.
-- =============================================
CREATE PROCEDURE [dbo].[ReorderBrand]
	-- Add the parameters for the stored procedure here
	@BrandID int,
	@Direction nvarchar(4) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	DECLARE @BrandNum INT
	Declare @MAX INT
	SELECT  @BrandNum = OrderByNumber FROM Brands WHERE BrandID = @BrandID
	SELECT @MAX = MAX(OrderByNumber) FROM Brands
	IF @Direction = 'UP' AND @BrandNum > 1
BEGIN
UPDATE Brands SET OrderByNumber = @BrandNum WHERE (OrderByNumber = @BrandNum -1)
UPDATE Brands SET OrderByNumber = @BrandNum - 1 WHERE BrandID = @BrandID
END

IF @Direction = 'DOWN' AND @BrandNum < @MAX
BEGIN
UPDATE Brands SET OrderByNumber = @BrandNum WHERE (OrderByNumber = @BrandNum +1)
UPDATE Brands SET OrderByNumber = @BrandNum + 1 WHERE BrandID = @BrandID
END


END


GO
