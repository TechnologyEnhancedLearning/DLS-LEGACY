Public Class _Default
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Response.Redirect("~/Home?action=login&app=ts", True)
        'If Not Page.IsPostBack() Then
        '    '
        '    ' Decide which view to show
        '    '
        '    Dim sActionValue As String = Page.Request.Item("action")

        '    Dim oActiveView As Global.System.Web.UI.WebControls.View = Me.vLogin
        '    Page.Title = "Digital Learning Solutions Tracking System Login"
        '    Me.tbUserName.Focus()

        '    If Not sActionValue Is Nothing Then
        '        Select Case sActionValue.ToLower()
        '            Case "logout"
        '                oActiveView = Me.vLogin
        '                CCommon.AdminUserLogout()

        '            Case "login"
        '                oActiveView = Me.vLogin

        '            Case "registration"
        '                oActiveView = Me.vRegister
        '                'Me.CentreIDDropDown.Focus()
        '                Page.Title = "Digital Learning Solutions Tracking System Registration"

        '            Case "reminder"
        '                oActiveView = Me.vRegister
        '                Me.tbUserName.Focus()
        '                Page.Title = "Digital Learning Solutions Tracking System Password Reminder"

        '            Case "getpassword"
        '                oActiveView = Me.vPassswordReminder
        '                Me.btnPasswordOK.Focus()
        '                _SetupPassword()

        '            Case Else
        '                Response.Redirect("~/Home?action=login&app=ts", True)
        '                Exit Sub
        '        End Select
        '    End If
        '    If Not Me.mvDefault.GetActiveView() Is oActiveView Then
        '        Me.mvDefault.SetActiveView(oActiveView)
        '    End If
        '    '
        '    ' Set up Login message
        '    '
        '    CCommon.ConfigMessage("LoginMessage", Me.txtLoginMessage)
        'End If
    End Sub
    Protected Sub _SetupPassword()
        'Dim sHash As String = Page.Request.Item("pwdr")
        ''
        '' Sanity check the hash code
        ''
        'If sHash Is Nothing OrElse sHash.Length <> 64 Then
        '    Response.Redirect("~/Home?action=login&app=ts")
        'End If
        ''
        '' Let the stored procedure get the information about the password.
        ''
        'Dim taQueries As New ITSPTableAdapters.QueriesTableAdapter
        'Dim nAdminID As Integer = taQueries.uspGetUserFromPasswordHash(sHash)

        'If nAdminID <= 0 Then
        '    mvDefault.SetActiveView(vLogin)
        '    Me.lblModalMessage.Text = "There was a problem retrieving your Password. Either you have already accessed it, or it is more than two hours since you requested a password reminder. Please try again."
        '    Me.lblModalHeading.Text = "Error "
        '    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalPWChangError", "<script>$('#messageModal').modal('show');</script>")
        'Else
        '    Session("pwRequestUserID") = nAdminID
        'End If
    End Sub

    ''' <summary>
    ''' Calculate SHA256 hash of string
    ''' </summary>
    ''' <param name="sClearText">String to get hash of</param>
    ''' <returns>64 character hexadecimal encoded hash</returns>
    ''' <remarks></remarks>
    Protected Function GetHash(ByVal sClearText As String) As String
        Dim sha As New System.Security.Cryptography.SHA256Managed
        Dim inputbytes As Byte() = UTF8Encoding.UTF8.GetBytes(sClearText)

        Return GetHex(sha.ComputeHash(inputbytes))
    End Function

    ''' <summary>
    ''' Convert byte array to hexadecimal string
    ''' </summary>
    ''' <param name="byteValue">Byte array to convert</param>
    ''' <returns>hex string</returns>
    ''' <remarks></remarks>
    Protected Function GetHex(ByVal byteValue As Byte()) As String
        Dim sb As New StringBuilder

        For i As Integer = 0 To byteValue.Length - 1
            sb.Append(byteValue(i).ToString("x2"))
        Next
        Return sb.ToString()
    End Function
    Protected Sub btnlogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        lblLoginError.Text = String.Empty
        Dim sTxtUsername As String = tbUserName.Text.Trim
        Dim sTxtPassword As String = tbPassword.Text.Trim

        If sTxtUsername.Count > 0 And sTxtPassword.Count > 0 Then
            Dim AdminUserAdapter As New ITSPTableAdapters.AdminUsersTableAdapter()
            Dim AdminUserTable As ITSP.AdminUsersDataTable
            Dim AdminUserRow As ITSP.AdminUsersRow
            '
            ' Use login name first to find user
            '
            AdminUserTable = AdminUserAdapter.GetByLogin(sTxtUsername)
            '
            ' No hits, try the password
            '
            If AdminUserTable.Count() = 0 Then
                AdminUserTable = AdminUserAdapter.GetByEmail(sTxtUsername)
            End If

            If AdminUserTable.Count() = 1 Then
                AdminUserRow = AdminUserTable.First()
                If AdminUserRow.FailedLoginCount > 4 Then
                    AccountLocked()
                    Exit Sub
                End If
                If Crypto.VerifyHashedPassword(AdminUserRow.Password, tbPassword.Text.Trim) Then
                    'check pw meets policy criteria:
                    Dim regex As Regex = New Regex("(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*")
                    Dim match As Match = regex.Match(tbPassword.Text.Trim)
                    If Not match.Success Then
                        lblSetPWTitle.Text = "Choose a Safer Password"
                        lblSetPWText.Text = "Your password no longer meets the minimum security requirements. Please choose a new, stronger one."
                        Session("UserAdminID") = AdminUserRow.AdminID
                        mvDefault.SetActiveView(vPassswordReminder)
                        Exit Sub
                    Else
                        ' Session("UserName") = AdminUserRow.Login
                        Session("UserForename") = AdminUserRow.Forename
                        Session("UserSurname") = AdminUserRow.Surname
                        Session("UserEmail") = AdminUserRow.Email
                        Session("UserCentreID") = AdminUserRow.CentreID
                        Session("TestingCentre") = AdminUserRow.BetaTesting
                        Session("UserCentreName") = AdminUserRow.CentreName
                        Session("UserCentreManager") = AdminUserRow.IsCentreManager
                        Session("UserCentreAdmin") = AdminUserRow.CentreAdmin
                        Session("UserConfigAdmin") = AdminUserRow.ConfigAdmin
                        Session("UserSummaryReports") = AdminUserRow.ConfigAdmin
                        Session("UserUserAdmin") = AdminUserRow.ConfigAdmin
                        Session("UserAdminID") = AdminUserRow.AdminID
                        Session("UserAdminSessionID") = CCommon.CreateAdminUserSession(AdminUserRow.AdminID)
                        '
                        ' Set up user profile
                        '
                        CEITSProfile.LoadProfileFromString(AdminUserRow.EITSProfile).SetProfile(Session)
                        '
                        ' If they had followed a link but weren't logged in then navigate to that
                        ' entry after login.
                        '
                        Dim taCentre As New ITSPTableAdapters.CentresTableAdapter
                        Dim tCtre As New ITSP.CentresDataTable
                        tCtre = taCentre.GetByCentreID(Session("UserCentreID"))
                        If tCtre.First.Active = False Then
                            Response.Redirect("~/CentreInactive")
                        End If
                        If AdminUserRow.FailedLoginCount > 0 Then
                            AdminUserAdapter.ResetFailCount(AdminUserRow.AdminID)
                        End If
                        If Not Session("NavigateTo") Is Nothing Then
                            Dim sNavigateTo As String = Session("NavigateTo")

                            Session.Remove("NavigateTo")
                            Response.Redirect(sNavigateTo, True)
                        Else
                            '
                            ' Otherwise open the home page
                            '
                            Response.Redirect("dashboard", True)
                        End If

                    End If
                Else
                    AdminUserAdapter.IncrementFailCount(AdminUserRow.AdminID)
                    If AdminUserRow.FailedLoginCount >= 4 Then
                        AccountLocked()
                    Else
                        lblModalHeading.Text = "Login Failure: Username and password do not match."
                        Me.lblModalMessage.Text = "<p>You have had " & (AdminUserRow.FailedLoginCount + 1).ToString & " failed login attempts. Your account will be locked after 5.</P><p>Your password had a minimum of 8 characters with at least 1 letter, 1 number and 1 symbol.</p><p>Please reset your password if you have forgotten it.</p>"
                        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalLoginFail", "<script>$('#messageModal').modal('show');</script>")

                        '
                        ' Clear the session cookie and kill off the session, so that there is no attempt to
                        ' reuse the session
                        '
                        If Not Page.Request.Cookies("ASP.NET_SessionId") Is Nothing Then
                            Response.Cookies("ASP.NET_SessionId").Expires = DateTime.Now.AddYears(-30)
                        End If
                        Session.Abandon()
                    End If

                    Exit Sub
                End If

                lblLoginError.Text = "Login Failure: Wrong username or password or your login has not yet been approved by your centre manager."
                pnlLoginError.Visible = True
                tbUserName.Focus()
                '
                ' Clear the session cookie and kill off the session, so that there is no attempt to
                ' reuse the session
                '
                If Not Page.Request.Cookies("ASP.NET_SessionId") Is Nothing Then
                    Response.Cookies("ASP.NET_SessionId").Expires = DateTime.Now.AddYears(-30)
                End If
                Session.Abandon()
            Else
                lblLoginError.Text = "Login Failure: Username and Password are required. Please try again."
                pnlLoginError.Visible = True
            End If
        End If
    End Sub
    Protected Sub AccountLocked()
        lblModalHeading.Text = "Login Failure: Account Locked."
        Me.lblModalMessage.Text = "<p>Because there have been 5 failed login attempts for this account since the last successful login, the account is locked. Contact your centre manager to unlock your account.</p>"
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalLoginFail", "<script>$('#messageModal').modal('show');</script>")


        '
        ' Clear the session cookie and kill off the session, so that there is no attempt to
        ' reuse the session
        '
        If Not Page.Request.Cookies("ASP.NET_SessionId") Is Nothing Then
            Response.Cookies("ASP.NET_SessionId").Expires = DateTime.Now.AddYears(-30)
        End If
        Session.Abandon()
    End Sub
    Protected Sub btnRegister_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRegister.Click
        Me.lblModalMessage.Text = String.Empty
        Dim sTxtForename As String = Me.tbFName.Text.Trim
        Dim sTxtSurname As String = Me.tbLName.Text.Trim
        Dim sTxtEmail As String = Me.tbEmail.Text.Trim
        Dim sTxtUsername As String = Me.tbRegUsername.Text.Trim
        Dim sTxtPassword1 As String = Me.tbRegPassword.Text.Trim
        Dim sTxtPassword2 As String = Me.tbRegPassword2.Text.Trim
        Dim nCentreID As Integer = Me.CentreIDDropDown.SelectedValue()

        '
        ' Validate the input
        '
        If CInt(CentreIDDropDown.SelectedValue) = 0 Then
            Me.lblRegisterMessage.Text = "Registration failure: Please select your centre."
            pnlRegisterError.Visible = True
            Exit Sub
        End If
        If sTxtForename.Count = 0 Or sTxtSurname.Count = 0 Or sTxtEmail.Count = 0 Or
           sTxtUsername.Count = 0 Or sTxtPassword1.Count = 0 Or sTxtPassword1.Count = 0 Then
            Me.lblRegisterMessage.Text = "Registration failure: all fields are required. Please try again."
            pnlRegisterError.Visible = True
            Exit Sub
        End If
        If sTxtPassword1 <> sTxtPassword2 Then
            Me.lblRegisterMessage.Text = "Registration failure: passwords don't match. Please try again."
            pnlRegisterError.Visible = True
            Exit Sub
        End If
        If cbTerms.Checked = False Then
            Me.lblRegisterMessage.Text = "Registration failure: you must confirm that you agree to the Terms and Conditions."
            pnlRegisterError.Visible = True
            Exit Sub
        End If
        '
        ' Use a stored procedure for handling the registration.
        '
        Dim QueriesAdapter As New ITSPTableAdapters.QueriesTableAdapter
        Dim nResult As Integer = QueriesAdapter.uspStoreRegistration(sTxtForename, sTxtSurname, sTxtEmail, sTxtUsername, Crypto.HashPassword(sTxtPassword1), nCentreID)
        '
        ' Show the result as appropriate
        '
        Select Case nResult
            Case 0
                lblModalHeading.Text = "Registration succeeded"
                Me.lblModalMessage.Text = "Your email address matched details stored with the Centre, so your account has been marked as Centre Manager. You may proceed with login."

            Case 1
                lblModalHeading.Text = "Registration succeeded"
                Me.lblModalMessage.Text = "Your email address did not match details stored with the Centre and there are no prior accounts associated with the Centre. Therefore your account will have to be enabled by the site administrators. Please contact them at elearning@mbhci.nhs.uk with your details."

            Case 2
                Dim taNU As New NotificationsTableAdapters.UsersForNotificationTableAdapter
                Dim tNU As New Notifications.UsersForNotificationDataTable
                tNU = taNU.GetByCentre(2, nCentreID)
                If tNU.Count > 0 Then
                    Dim SbBody As New StringBuilder
                    SbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")
                    SbBody.Append("<p>An administrator, " & sTxtForename & " " & sTxtSurname & ", has registered against your Digital Learning Solutions centre and requires approval before they can access the Tracking System.</p>")

                    SbBody.Append("<p>To approve or reject their registration please, click <a href=""https://www.dls.nhs.uk/tracking/centrelogins"">here</a>.</p>")
                    SbBody.Append("<p>Please contact them to let them know when you have processed this request. <a href='mailto:" & sTxtEmail & "'>Click here</a> to contact them by e-mail.</p>")

                    SbBody.Append("</body>")

                    'Now send to any subscribed admin users at centre:
                    For Each r As DataRow In tNU.Rows
                        CCommon.SendEmail(r.Item("Email"), "Digital Learning Solutions Administrator Registration Requires Approval - " & sTxtForename & " " & sTxtSurname, SbBody.ToString(), True)
                    Next
                    lblModalHeading.Text = "Registration succeeded"
                    Me.lblModalMessage.Text = "Your Centre Manager should have received an e-mail requesting their approval of your registration."
                Else
                    lblModalHeading.Text = "Registration succeeded"
                    Me.lblModalMessage.Text = "Please contact your Centre Manager to have your account enabled."
                End If


            Case 101
                lblModalHeading.Text = "Registration failed"
                Me.lblModalMessage.Text = "Registration failed. The username you entered is already in use. Please choose another username."

            Case 102
                lblModalHeading.Text = "Registration failed"
                Me.lblModalMessage.Text = "The email address you entered is already in use. Please create only one account for accessing the Elite website. If you need a reminder of your password please use the Password Reminder form."

            Case Else
                lblModalHeading.Text = "Registration failed"
                Me.lblModalMessage.Text = "There was an unexpected problem. Please contact the site administrators at elearning@mbhci.nhs.uk with your details."

        End Select
        If Me.lblModalMessage.Text.Length > 0 Then
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalRegistered", "<script>$('#messageModal').modal('show');</script>")
        End If
    End Sub

    Protected Sub btnPasswordOK_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnPasswordOK.Click
        Dim nUserID As Integer = CInt(Session("pwRequestUserID"))
        If nUserID = 0 Then
            nUserID = Session("UserAdminID")
        End If
        Dim taAdminUsers As New ITSPTableAdapters.AdminUsersTableAdapter
        taAdminUsers.UpdatePasswordHash(Crypto.HashPassword(tbNewPassword1.Text), nUserID)
        lblModalHeading.Text = "Password Reset Successful"
        Me.lblModalMessage.Text = "Your password has been changed. You will be able to use your new password to login to all of your Digital Learning Solutions centre services." ' everything matches!
        Me.mvDefault.SetActiveView(vLogin)
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalPWChanged", "<script>$('#messageModal').modal('show');</script>")
    End Sub

    Private Sub lbtReminder_Click(sender As Object, e As EventArgs) Handles lbtReminder.Click
        'NOW PASSWORD RESET
        lblModalMessage.Text = String.Empty
        lblModalHeading.Text = "Password Reset Error"
        Dim sTxtUsername As String = Me.tbUserName.Text.Trim
        Dim sSeed As New StringBuilder
        Dim sHash As String = String.Empty
        Dim bTryAgain As Boolean = True
        Dim nAttempt As Integer = 0
        Dim sMsg As String = String.Empty
        Dim nResult As Integer
        '
        ' Loop getting hash value and setting up the reminder.
        ' If the hash value is not unique then we try again.
        '
        While bTryAgain
            '
            ' Get a hash value for the hotlink.
            '
            nAttempt += 1
            sSeed.Append(Now().ToString("MMMM ss mm"))
            sSeed.Append(sTxtUsername)
            sSeed.Append(nAttempt.ToString)
            sSeed.Append(sTxtUsername)
            sSeed.Append("Kevin Erin Nicola Hugh")  ' add a bit more randomness
            sSeed.Append(Now().ToString("ffffff HH"))
            sHash = GetHash(sSeed.ToString)
            '
            ' Use a stored procedure for handling the password reminder
            '
            Dim QueriesAdapter As New ITSPTableAdapters.QueriesTableAdapter
            nResult = QueriesAdapter.uspPasswordReminder_V6(sTxtUsername, sTxtUsername, sHash)

            '
            ' Show error result if that is what happened.
            ' If >=0 then the result is the AdminID of the user.
            '
            bTryAgain = False                   ' expect that we will finish
            Select Case nResult
                Case -1, -2, -3
                    sMsg = "Password reset failed. Please try again or contact your Centre Manager."

                Case -4
                    sMsg = "A reset email has been sent in the last 30 minutes. Please wait for this to arrive, then follow the instructions."

                Case -101
                    sMsg = "Password reset failed. Please supply either the username, email, or both."

                Case -100, -102
                    sMsg = "Password reset failed. There was an unexpected problem. Please contact the site administrators at elearning@mbhci.nhs.uk with your details."

                Case -103
                    bTryAgain = True            ' oops, hash not unique, generate another one
            End Select
        End While

        If sMsg <> String.Empty Then            ' show error if one present

            Me.lblModalMessage.Text = sMsg
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalResetError", "<script>$('#messageModal').modal('show');</script>")
            Exit Sub
        End If
        '
        ' OK, request has been set in the database. Now we send an email.
        ' Find the user's details first.
        '
        Dim AdminUserAdapter As New ITSPTableAdapters.AdminUsersTableAdapter()
        Dim AdminUserTable As ITSP.AdminUsersDataTable
        Dim AdminUserRow As ITSP.AdminUsersRow

        AdminUserTable = AdminUserAdapter.GetByAdminID(nResult)
        If AdminUserTable.Count() <> 1 Then
            sMsg = "There was a problem generating your password reset email. Please contact the site administrators at elearning@mbhci.nhs.uk."
            Me.lblModalMessage.Text = sMsg
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalResetError", "<script>$('#messageModal').modal('show');</script>")
            Exit Sub
        End If
        AdminUserRow = AdminUserTable.First()
        '
        ' Create the email
        '
        Dim sbBody As New StringBuilder
        Dim sPageName As String = Request.Url.Scheme & "://" & Request.Url.Authority & Request.Url.AbsolutePath &
                                  "?action=getpassword&pwdr=" & sHash
        Dim tExpire As DateTime = Now().AddHours(2)

        sbBody.Append("Dear " & AdminUserRow.Forename & "," & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("A request has been made to reset the password for your account at " & vbCrLf)
        sbBody.Append("the Digital Learning Solutions Tracking website at https://www.dls.nhs.uk ." & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("To reset your password please follow this link: " & sPageName & vbCrLf)
        sbBody.Append("Note that this link can only be used once, and must be accessed before " & tExpire.ToString("HH:mm") & " on " & tExpire.ToString("dd/MM/yyyy") & "." & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("Please don't reply to this email as it has been automatically generated." & vbCrLf)
        '
        ' And try to send the email
        '
        If CCommon.SendEmail(AdminUserRow.Email, "Digital Learning Solutions Tracking System Password Reset", sbBody.ToString(), False) Then

            lblModalHeading.Text = "Password Reset Email Sent"
            Me.lblModalMessage.Text = "An email has been sent to you giving details of how to reset your password."
        Else

            Me.lblModalMessage.Text = "There was a problem sending you an email. Please contact the site administrators at dls@hee.nhs.uk to ask about your password reset."
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalPWChanged", "<script>$('#messageModal').modal('show');</script>")
    End Sub
End Class