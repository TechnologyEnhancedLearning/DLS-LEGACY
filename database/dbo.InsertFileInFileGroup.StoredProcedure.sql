USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 03/09/2019
-- Description:	Inserts a file and adds appropriate records to link tables.
-- =============================================
CREATE PROCEDURE [dbo].[InsertFileInFileGroup] 
	-- Add the parameters for the stored procedure here
	@FileName varchar(100),
	@FileType varchar(50),
	@FileSize bigint,
	@FileData varbinary(MAX),
	@CandidateID int,
	@UserEmail nvarchar(255),
	@LearningLogItemID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @_NewFileID Int
	BEGIN
	INSERT INTO Files ([FileName], FileType, FileSize, FileData, CandidateID, UserEmail) Values (@FileName, @FileType, @FileSize, @FileData, @CandidateID, @UserEmail)
	END
	SET @_NewFileID = SCOPE_IDENTITY()
	DECLARE @_FileGroupID int
	IF NOT EXISTS (SELECT * FROM LearningLogItemFileGroups WHERE LearningLogItemID = @LearningLogItemID)
	BEGIN
	INSERT INTO LearningLogItemFileGroups (LearningLogItemID) VALUES (@LearningLogItemID)
	END
	SELECT @_FileGroupID = FileGroupID FROM LearningLogItemFileGroups WHERE LearningLogItemID = @LearningLogItemID
	INSERT INTO FileGroupFiles (FileGroupID, FileID) VALUES (@_FileGroupID, @_NewFileID)
	SELECT @_NewFileID
	RETURN @_NewFileID
END
GO
