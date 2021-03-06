USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 17th March 2011
-- Description:	Gets top 10 centres
-- =============================================
CREATE PROCEDURE [dbo].[uspGetTopTen]
	@DaysBack as Integer,
	@RegionID as Integer = -1
AS
BEGIN
	SET NOCOUNT ON
	--
	-- Work out how far to go back
	--
	DECLARE @_dtCutoff as DateTime
	
	SET @_dtCutoff = DATEADD(DAY, -@DaysBack, GetUtcDate())
	--
	-- The inner query gets the top 10 centres where there
	-- is activity in the time period.
	-- The outer query derives a rank (which can have duplicate values if counts are equal)
	-- and adds centre name by joining with centres.
	--
	SELECT 
		RANK() over (ORDER BY tc.CentreIDCount DESC) as [Rank],
		c.CentreName as [Centre],
		tc.CentreIDCount as [Count]
		From 
			( 
			SELECT top 10 Count(c.CentreID) as CentreIDCount, c.CentreID
			FROM [Sessions] s inner Join Candidates c on s.CandidateID = c.CandidateID INNER JOIN Centres ct on c.CentreID = ct.CentreID
			WHERE s.LoginTime > @_dtCutoff AND c.CentreID <> 101 AND (ct.RegionID = @RegionID OR @RegionID = -1)
			GROUP BY c.CentreID
			ORDER by CentreIDCount Desc) as tc 
		INNER JOIN Centres c ON tc.CentreID = c.CentreID
END
--/****** Object:  StoredProcedure [dbo].[uspGetCentreRank]    Script Date: 10/04/2014 16:25:16 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		Hugh Gibson
---- Create date: 17th March 2011
---- Description:	Gets activity rank for a given centre
---- =============================================
--ALTER PROCEDURE [dbo].[uspGetCentreRank]
--	@CentreID as Integer,
--	@DaysBack as Integer,
--	@RegionID as Integer = -1
--AS
--BEGIN
--	SET NOCOUNT ON
--	--
--	-- Work out how far to go back
--	--
--	DECLARE @_dtCutoff as DateTime
	
--	SET @_dtCutoff = DATEADD(DAY, -@DaysBack, GetUtcDate())
--	--
--	-- The inner query 'tc' gets the centres where there
--	-- is activity in the time period.
--	-- The outer query 'rtc' derives a rank (which can have duplicate values if counts are equal)
--	-- and adds centre name by joining with centres.
--	-- The final query selects the rank for the given centre.
--	--
--	select rtc.[Rank],
--		   rtc.CentreIDCount AS [Count]	
--	FROM 
--		(Select tc.CentreID, 
--				RANK() OVER (ORDER BY tc.CentreIDCount Desc) as [Rank],
--				CentreIDCount
--			From 
--			( 
--			SELECT Count(c.CentreID) as CentreIDCount, c.CentreID
--			FROM [Sessions] s inner Join Candidates c on s.CandidateID = c.CandidateID INNER JOIN Centres ct on c.CentreID = ct.CentreID
--			WHERE s.LoginTime > @_dtCutoff  AND (ct.RegionID = @RegionID OR @RegionID = -1)
--			GROUP BY c.CentreID) as tc ) as rtc
--	WHERE rtc.CentreID = @CentreID
--END
GO
