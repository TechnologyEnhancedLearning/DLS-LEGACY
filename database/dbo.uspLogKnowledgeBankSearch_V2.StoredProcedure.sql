USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 07/06/19
-- Description:	Logs knowledge bank searches
--				V2 updates to use brand, cat and topic csv fields
-- =============================================
CREATE PROCEDURE [dbo].[uspLogKnowledgeBankSearch_V2] 
	-- parameters
	@CandidateID as Int = 0,
	@BrandCSV as varchar(30),
	@CategoryCSV as varchar(80),
	@TopicCSV as varchar(180),
	@SearchTerm as varchar(255),
	@kbSearchID AS Int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--	IF 1=0 BEGIN
--    SET FMTONLY OFF
--END

	IF @SearchTerm <> N'' 
	BEGIN
	INSERT INTO [dbo].[kbSearches]
           ([CandidateID]
           ,[BrandCSV]
           ,[CategoryCSV]
           ,[TopicCSV]
           ,[SearchTerm])
     VALUES
           (@CandidateID
           ,@BrandCSV
		   ,@CategoryCSV
		   ,@TopicCSV
		   ,@SearchTerm)
	Set @kbSearchID = SCOPE_IDENTITY()
	PRINT @kbSearchID
	
	END
	RETURN @kbSearchID
	END
GO
