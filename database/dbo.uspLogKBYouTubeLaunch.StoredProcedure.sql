USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 27/10/14
-- Description:	Logs knowledge bank YouTube video launch
-- =============================================
CREATE PROCEDURE [dbo].[uspLogKBYouTubeLaunch] 
	-- parameters
	@CandidateID as Int = 0,
	@URL as varchar(256),
	@Title AS varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--	IF 1=0 BEGIN
--    SET FMTONLY OFF
--END
DECLARE @_Result Int
	BEGIN
	INSERT INTO [dbo].[kbYouTubeTrack]
           ([CandidateID]
           ,[YouTubeURL]
           ,[VidTitle])
     VALUES
           (@CandidateID
           ,@URL
		   ,@Title)
	Set @_Result = SCOPE_IDENTITY()
	PRINT @_Result
	
	END
	
	SELECT @_Result
	RETURN @_Result
	END
GO
