USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 17th March 2011
-- Description:	Gets activity rank for a given centre
-- =============================================
CREATE PROCEDURE [dbo].[uspGetCentreRank]
	@CentreID as Integer,
	@DaysBack as Integer
AS
BEGIN
	SET NOCOUNT ON
	--
	-- Work out how far to go back
	--
	DECLARE @_dtCutoff as DateTime
	
	SET @_dtCutoff = DATEADD(DAY, -@DaysBack, GetUtcDate())
	--
	-- The inner query 'tc' gets the centres where there
	-- is activity in the time period.
	-- The outer query 'rtc' derives a rank (which can have duplicate values if counts are equal)
	-- and adds centre name by joining with centres.
	-- The final query selects the rank for the given centre.
	--
	select rtc.[Rank],
		   rtc.CentreIDCount AS [Count]	
	FROM 
		(Select tc.CentreID, 
				RANK() OVER (ORDER BY tc.CentreIDCount Desc) as [Rank],
				CentreIDCount
			From 
			( 
			SELECT Count(c.CentreID) as CentreIDCount, CentreID
			FROM [Sessions] s inner Join Candidates c on s.CandidateID = c.CandidateID
			WHERE s.LoginTime > @_dtCutoff
			GROUP BY c.CentreID) as tc ) as rtc
	WHERE rtc.CentreID = @CentreID
END
GO
