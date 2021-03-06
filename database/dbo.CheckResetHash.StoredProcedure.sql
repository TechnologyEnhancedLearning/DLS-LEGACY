USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 07/07/17
-- Description:	Checks delegate ID and Reset Hash and returns 1 if matched
-- =============================================
CREATE PROCEDURE [dbo].[CheckResetHash]
	-- Add the parameters for the stored procedure here
	@DelegateID Int,
	@ResetHash nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @ReturnVal as Integer
set @ReturnVal = -1
    -- Insert statements for procedure here
	if exists(select CandidateID from Candidates WHERE CandidateID=@DelegateID and ResetHash = @ResetHash)
	begin
	update Candidates set ResetHash=NULL WHERE CandidateID = @DelegateID
	set @ReturnVal = 1
	
	end
	select @ReturnVal
	Return @ReturnVal
END

GO
