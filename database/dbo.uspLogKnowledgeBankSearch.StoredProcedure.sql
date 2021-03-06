USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 18/07/14
-- Description:	Logs knowledge bank searches
-- =============================================
CREATE PROCEDURE [dbo].[uspLogKnowledgeBankSearch] 
	-- parameters
	@CandidateID as Int = 0,
	@OfficeVersionCSV as varchar(30),
	@ApplicationCSV as varchar(30),
	@ApplicationGroupCSV as varchar(30),
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
           ,[OfficeVersionCSV]
           ,[ApplicationCSV]
           ,[ApplicationGroupCSV]
           ,[SearchTerm])
     VALUES
           (@CandidateID
           ,@OfficeVersionCSV
		   ,@ApplicationCSV
		   ,@ApplicationGroupCSV
		   ,@SearchTerm)
	Set @kbSearchID = SCOPE_IDENTITY()
	PRINT @kbSearchID
	
	END
	RETURN @kbSearchID
	END
GO
