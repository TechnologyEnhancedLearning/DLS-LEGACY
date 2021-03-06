USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 06/12/2019
-- Description:	Returns custom field options for centre prompt 1
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomFieldResponsesTable]
	-- Add the parameters for the stored procedure here
	@CentreID int,
	@FieldNum int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @TBL as TABLE( ResponseID [int] IDENTITY(1,1) NOT NULL, Response nvarchar(255))
    -- Insert statements for procedure here
	INSERT INTO @TBL(Response)
	SELECT ID AS Response FROM [dbo].[tvfSplitCSV] (
   REPLACE((SELECT CASE 
   WHEN @FieldNum = 1 then F1Options 
    WHEN @FieldNum = 2 then F2Options 
	 WHEN @FieldNum = 3 then F3Options 
	  WHEN @FieldNum = 4 then F4Options 
	   WHEN @FieldNum = 5 then F5Options 
	    WHEN @FieldNum = 6 then F6Options 
   END FROM Centres WHERE CentreID = @CentreID),Char(10),','))
   SELECT * FROM @TBL
END
GO
