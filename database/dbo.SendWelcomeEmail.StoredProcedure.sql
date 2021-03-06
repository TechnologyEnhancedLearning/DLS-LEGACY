USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 08/03/2019
-- Description:	Sets reset hash and sends welcome message to a new candidate
-- =============================================
CREATE PROCEDURE [dbo].[SendWelcomeEmail]
	@CandidateID int,
	@NotifyDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--
	-- There are various things to do so wrap this in a transaction
	-- to prevent any problems.
	--
	
		DECLARE @_BodyHtml nvarchar(Max)
		--Setup Random string:
		
			declare @sLength tinyint
declare @randomString varchar(50)
declare @counter tinyint
declare @nextChar char(1)
declare @rnd as float

set @sLength = 36
set @counter = 1
set @randomString = ''

while @counter <= @sLength
begin
    -- crypt_gen_random produces a random number. We need a random    
    -- float.
    select @rnd = cast(cast(cast(crypt_gen_random(2) AS int) AS float) /    
         65535  as float)  
    select @nextChar = char(48 + convert(int, (122-48+1) * @rnd))
    if ascii(@nextChar) not in (58,59,60,61,62,63,64,91,92,93,94,95,96)
    begin
        select @randomString = @randomString + @nextChar
        set @counter = @counter + 1
    end
 end
 UPDATE Candidates SET ResetHash = @randomString WHERE CandidateID = @CandidateID
			

			DECLARE @Email nvarchar(255)
			
			DECLARE @_EmailFrom nvarchar(255)
			SET @_EmailFrom = N'Digital Learning Solutions Notifications <noreply@dls.nhs.uk>'
			DECLARE @_Subject AS nvarchar(255)
			SET @_Subject = 'Welcome to Digital Learning Solutions - Verify your Registration'
			DECLARE @_link as nvarchar(500)
			Select @_link = configtext from Config WHERE ConfigName = 'PasswordResetURL'
			SET @_link = @_link + '&pwdr=' + @randomString + '&email='
			Declare @_CentreName as nvarchar(250)

		Select @_BodyHtml = '<p>Dear ' + ca.FirstName + ' ' + ca.LastName + ',</p>' +
		'<p>An administrator has registered your details to give you access to the Digital Learning Solutions platform under the centre ' + ct.CentreName + '.</p>' +
		'<p>You have been assigned the unique DLS delegate number <b>' + ca.CandidateNumber + '</b>.</p>'+
		'<p>To complete your registration and access your Digital Learning Solutions content, please click <a href="' + @_link + ca.EmailAddress +'">this link</a>.</p>' +
		'<p>Note that this link can only be used once.</p>' +
		'<p>Please don''t reply to this email as it has been automatically generated.</p>', @Email = ca.EmailAddress
		FROM Candidates as ca INNER JOIN Centres AS ct ON Ca.CentreID = ct.CentreID
		WHERE ca.CandidateID = @CandidateID
		
		Insert Into EmailOut (EmailTo, EmailFrom, [Subject], BodyHTML, AddedByProcess, DeliverAfter)
		Values (@Email, @_EmailFrom, @_Subject,@_BodyHtml,'SendWelcomeEmail', @NotifyDate)

		END
GO
