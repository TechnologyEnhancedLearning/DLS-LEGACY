USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 19/11/2019
-- Description:	Archives a learning log item and removes all related evidence file data.
-- =============================================
CREATE PROCEDURE [dbo].[ArchiveLogItemAndRemoveFileData]
	-- Add the parameters for the stored procedure here
	@UniqueID int,
	@CandidateID int,
	@original_UniqueID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @UniqueID <1
	begin
	set @UniqueID = @original_UniqueID
	end
    -- Insert statements for procedure here
	UPDATE       LearningLogItems
SET                ArchivedDate = GETDATE(), ArchivedByID = @CandidateID
WHERE        (LearningLogItemID = @UniqueID)

UPDATE       Files
SET                FileSize = 0, FileData = (0x)
FROM            Files INNER JOIN
                         FileGroupFiles AS fgf ON Files.FileID = fgf.FileID INNER JOIN
                         LearningLogItemFileGroups AS lifg ON fgf.FileGroupID = lifg.FileGroupID
WHERE        (lifg.LearningLogItemID = @UniqueID)

END
GO
