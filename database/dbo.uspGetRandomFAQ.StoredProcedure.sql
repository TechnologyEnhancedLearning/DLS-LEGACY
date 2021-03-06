USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 8th March 2011
-- Description:	Selects a FAQ based on a random number
-- =============================================
CREATE PROCEDURE [dbo].[uspGetRandomFAQ]
AS
BEGIN
	SET NOCOUNT ON
	--
	-- Calculate the total weighting of all FAQs. We then scale the
	-- random value to that total weighting. Then we iterate through
	-- the FAQs and find the point where the sum of weightings to that point exceeds
	-- the random value. This will give us an FAQ which is selected
	-- based on its weighting. 
	--
	-- As an example, if there are two FAQs with the same weighting of 50 then
	-- the random number is scaled to 0-100. If the result is less than 50 we will 
	-- choose the first FAQ. If more than 50 we will choose the second. So they have 
	-- an equal probability. If the first one has a 
	-- weighting of 1 and the other of 999, then the original random number would have to
	-- be less than 0.001 to select the first one. Therefore it's a lot less likely that
	-- the first one will be selected.
	--
	DECLARE @_TotalWeighting AS float
	DECLARE @_TargetWeighting AS float
	
	set @_TotalWeighting = (SELECT SUM(Weighting) FROM [dbo].[FAQs] WHERE Published = 1 AND TargetGroup = 3)
	set @_TargetWeighting = RAND() * @_TotalWeighting
	
	DECLARE FAQList CURSOR LOCAL FAST_FORWARD FOR
		SELECT FAQID, Weighting FROM dbo.FAQs WHERE Published = 1 AND TargetGroup = 3 ORDER BY FAQID
	OPEN FAQList
	
	DECLARE @_FAQID as integer
	DECLARE @_Weighting as float
	FETCH NEXT FROM FAQList INTO @_FAQID, @_Weighting
	--
	-- Iterate through FAQs until target weighting goes below 0
	--
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @_TargetWeighting = @_TargetWeighting - @_Weighting
		if @_TargetWeighting < 0
			begin
			CLOSE FAQList
			SELECT QAnchor, QText, AHTML FROM [dbo].[FAQs] WHERE FAQID = @_FAQID
			RETURN
			end
		--
		-- Move to the next FAQ
		--
		FETCH NEXT FROM FAQList INTO @_FAQID, @_Weighting
	END
	CLOSE FAQList
	--
	-- If we didn't hit it, must mean that the random number
	-- was too big. Just put in the last FAQ.
	--
	SELECT TOP 1 QAnchor, QText, AHTML FROM [dbo].[FAQs] WHERE Published = 1 AND TargetGroup = 3 ORDER BY FAQID DESC
END
GO
