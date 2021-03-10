Imports System.Security.Claims
Imports DevExpress.Web.Bootstrap
Imports Microsoft.Owin.Security
Imports Microsoft.Owin.Security.Cookies
Imports Microsoft.Owin.Security.OpenIdConnect

Public Class usermxmodals
    Inherits System.Web.UI.UserControl
    Private Sub usermxmodals_Load(sender As Object, e As EventArgs) Handles Me.Load
        lbtSignIn.Visible = My.Settings.AllowAzureSSO
        If Not Session("LearningPortalUrl") Is Nothing Then
            lnkLearningPortal.HRef = Session("LearningPortalUrl")
        End If
        If Not Page.Request.Item("app") Is Nothing Then
            Select Case Page.Request.Item("app")
                Case "lp"
                    lblLoginHeader.Text = "Learning Portal"
                Case "cms"
                    lblLoginHeader.Text = "Content Management System"
                Case "ts"
                    lblLoginHeader.Text = "Tracking System"
            End Select
        End If
        If Not Page.Request.Item("action") Is Nothing Then
            Select Case Page.Request.Item("action")
                Case "login"
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAccount", "<script>$('#pnlAccount').modal('show');</script>")
                Case "signout"
                    CCommon.AdminUserLogout()
                    Page.Response.Redirect("~/home")
                Case "appselect"
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowAppSelect", "<script>$('#pnlAppSelect').modal('show');</script>")
                Case "mxdelegate"
                    PopulateDelegateDetails()
                    rptDelNotifications.DataBind()
                    bspDelegateDetails.ShowOnPageLoad = True
                    'Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalUpdateDetails", "<script>$('#modalDelegateDetails').modal('show');</script>")
                Case "mxadmin"
                    PopulateMyDetails()
                    rptNotifications.DataBind()
                    bspAdminDetails.ShowOnPageLoad = True
                Case "reset"
                    If Not Page.Request.Item("email") Is Nothing Then
                        bstbResetEmail.Text = Page.Request.Item("email")
                    End If
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowResetTab", "<script>$('#pnlAccount').modal('show');$('#recoverLink').trigger('click');</script>")
            End Select
        End If
        If Not Page.Request.Item("centreid") Is Nothing Then
            Dim taq As New AuthenticateTableAdapters.QueriesTableAdapter
            Dim sUsername As String = taq.GetLoginPromptForCentre(Page.Request.Item("centreid"))
            If Not sUsername Is Nothing Then
                If sUsername.Length > 0 Then
                    lblUserName.Text = sUsername
                End If
            End If
        End If
        If Session("UserAdminID") Is Nothing And Session("learnUserAuthenticated") Is Nothing Then
            If Request.IsAuthenticated Then
                Dim sEmailClaim As String = ConfigurationManager.AppSettings("ida:EmailClaim")
                If Not System.Security.Claims.ClaimsPrincipal.Current.FindFirst(sEmailClaim) Is Nothing Then
                    Dim sEmail As String = System.Security.Claims.ClaimsPrincipal.Current.FindFirst(sEmailClaim).Value
                    If sEmail.Contains("@") Then
                        Dim taq As New AuthenticateTableAdapters.QueriesTableAdapter
                        Dim nCentreID As Integer = taq.GetCentreIDForEmail(sEmail)
                        If nCentreID = 0 Then
                            If Session("PromptReg") Is Nothing Then

                                'user isn't currently registered to DLS - offer to register:

                                Session("PromptReg") = True
                                Dim sNameClaim As String = ConfigurationManager.AppSettings("ida:NameClaim")
                                If Not ClaimsPrincipal.Current.FindFirst(sNameClaim) Is Nothing Then
                                    Dim sName As String = ClaimsPrincipal.Current.FindFirst(sNameClaim).Value
                                    lblCompleteMSReg.Text = "<p>Welcome <b>" & sName & "</b>.</p><p>You are not currently registered at a Digital Learning Solutions centre. Would you like to register now?"
                                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowRegModal", "<script>$('#registerMSUserModal').modal('show');</script>")
                                End If
                            End If
                        Else
                            LogIn(sEmail, nCentreID, "")
                        End If
                    End If
                End If
            End If
        End If
    End Sub
    Private Sub usermxmodals_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        If Not Session("UserAdminID") Is Nothing Or Not Session("learnUserAuthenticated") Is Nothing Then
            If Session("UserAdminID") > 0 And Session("UserCentreAdmin") Then
                pnlTracking.Visible = True
                pnlSupervise.Visible = False
                lbtMxAdminAccount.Visible = True
                lblAdm.Visible = True
            ElseIf Session("UserAdminID") > 0 And Session("IsSupervisor") Then
                pnlTracking.Visible = False
                pnlSupervise.Visible = True
                lbtMxAdminAccount.Visible = True
                lblAdm.Visible = True
            Else
                pnlSupervise.Visible = False
                pnlTracking.Visible = False
                lbtMxAdminAccount.Visible = False
                lblAdm.Visible = False
            End If

            If Session("learnUserAuthenticated") Then
                pnlLP.Visible = True
                lbtMxLearningAccount.Visible = True
                lblDel.Visible = True
            Else
                pnlLP.Visible = False
                lbtMxLearningAccount.Visible = False
                lblDel.Visible = False
            End If
            pnlCMS.Visible = Session("UserAuthenticatedCM")
            pnlCC.Visible = Session("UserCentreManager")
            pnlFrameworkDeveloper.Visible = Session("IsFrameworkDeveloper")
            If Session("IsFrameworkDeveloper") Then
                lnkFrameworkDeveloper.HRef = CCommon.GetConfigString("V2AppBaseUrl") & "Frameworks/MyFrameworks"
            End If
        End If

    End Sub

    Private Sub lbtLogout_Click(sender As Object, e As EventArgs) Handles lbtLogout.Click
        CCommon.AdminUserLogout()
        Page.Response.Redirect("~/home")
    End Sub
    Protected Function getPageUrl() As String
        Dim sURL As String = Request.RawUrl
        If sURL.Contains("?") Then
            sURL = sURL.Substring(0, sURL.IndexOf("?"))
        End If
        Return sURL
    End Function
    Private Sub lbtMxAdminAccount_Click(sender As Object, e As EventArgs) Handles lbtMxAdminAccount.Click
        PopulateMyDetails()
        rptNotifications.DataBind()
        bspAdminDetails.ShowOnPageLoad = True
    End Sub
    Protected Sub bsbtnSaveAdminDetails_Command(sender As Object, e As CommandEventArgs)
        Dim AdminUserAdapter As New ITSPTableAdapters.AdminUsersTableAdapter()
        Dim AdminUserTable As ITSP.AdminUsersDataTable
        Dim AdminUserRow As ITSP.AdminUsersRow
        Dim nAdminID As Integer = CInt(Session("UserAdminID"))
        Dim sPassword As String

        AdminUserTable = AdminUserAdapter.GetByAdminID(nAdminID)
        '
        ' Get details for the user
        '
        If AdminUserTable.Count() <> 1 Then
            lblConfirmTitle.Text = "Failed to Save Changes"
            lblConfirmMessage.Text = "There is a problem with your account. Please contact dls@hee.nhs.uk with your details."
            bspAdminDetails.ShowOnPageLoad = False
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "HideModalUpdateDetails", "<script>$('#confirmModal').modal('show');</script>")
            Exit Sub
        End If
        '
        ' First off, check if the password is correct. 
        ' Warn them if not.
        '
        AdminUserRow = AdminUserTable.First()
        If Not Crypto.VerifyHashedPassword(AdminUserRow.Password, bstbPassword.Text.Trim) Then
            '
            ' Password is not OK, tell the user.
            '
            lblConfirmTitle.Text = "Failed to Save Changes"
            lblConfirmMessage.Text = "Incorrect password. Please enter your existing password if making any changes."
            bspAdminDetails.ShowOnPageLoad = False
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "HideModalUpdateDetails", "<script>$('#confirmModal').modal('show');</script>")
            Exit Sub
        End If
        '
        ' Check if user has entered new passwords, and if so, if they are the same
        '
        If Me.bstbNewPassword.Text.Trim.Length > 0 Or Me.bstbConfirmPassword.Text.Trim.Length > 0 Then
            If Me.bstbNewPassword.Text.Trim <> Me.bstbConfirmPassword.Text.Trim Then
                lblConfirmTitle.Text = "Failed to Save Changes"
                lblConfirmMessage.Text = "New passwords do not match. Please enter the same password in both fields."
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "HideModalUpdateDetails", "<script>$('#confirmModal').modal('show');</script>")
                bspAdminDetails.ShowOnPageLoad = False
                Exit Sub
            End If
            sPassword = Me.bstbNewPassword.Text.Trim     ' change to new password
        Else
            sPassword = Me.bstbPassword.Text.Trim     ' retain old password
        End If
        '
        ' Check if other fields are present
        '
        If Me.bstbFName.Text.Trim.Length = 0 Or Me.bstbLName.Text.Trim.Length = 0 Or Me.bstbEmail.Text.Trim.Length = 0 Then
            lblConfirmTitle.Text = "Failed to Save Changes"
            lblConfirmMessage.Text = "Forename, surname and email are required."
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "HideModalUpdateDetails", "$('#confirmModal').modal('show');</script>")
            bspAdminDetails.ShowOnPageLoad = False
            Exit Sub
        End If
        '
        ' All OK now, so proceed with storing new data
        '
        Try

            AdminUserAdapter.UpdateMyDetails(Crypto.HashPassword(sPassword), Me.bstbFName.Text.Trim, Me.bstbLName.Text.Trim, Me.bstbEmail.Text.Trim, bsimgProfileImage.Value, nAdminID)
        Catch ex As Exception
            lblConfirmTitle.Text = "Failed to Save Changes"
            lblConfirmMessage.Text = "The e-mail provided is already associated with another Digital Learning Solutions admin user login. Each admin user must have a unique e-mail address."
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "HideModalUpdateDetails", "<script>$('#confirmModal').modal('show');</script>")
            bspAdminDetails.ShowOnPageLoad = False
            Exit Sub
        End Try
        Try
            Dim taNotifUsers As New NotificationsTableAdapters.NotificationUsersTableAdapter
            For Each i As RepeaterItem In rptNotifications.Items
                Dim cbYN As HtmlInputCheckBox = i.FindControl("cbYesNo")
                Dim hf As HiddenField = i.FindControl("hfNotificationID")
                If cbYN.Checked Then
                    taNotifUsers.InsertAdminUserNotificationIfNotExists(nAdminID, hf.Value)
                Else
                    taNotifUsers.DeleteByAdminUserID(hf.Value, nAdminID)
                End If
            Next
        Catch ex As Exception
            lblConfirmTitle.Text = "Failed to Save Notification Preferences"
            lblConfirmMessage.Text = "Your details were updated successfully but there was a problem updating your notification preferences. If this problem persists, please raise a support ticket."
            bspAdminDetails.ShowOnPageLoad = False
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "HideModalUpdateDetails", "<script>$('#confirmModal').modal('show');</script>")
            Exit Sub
        End Try

        Session("UserForename") = Me.bstbFName.Text
        Session("UserSurname") = Me.bstbLName.Text
        Session("UserEmail") = Me.bstbEmail.Text
        'If Not bstbNewPassword.Text.Trim = "" Then
        'End If
        Me.bstbPassword.Text = ""
        PopulateMyDetails()
        bspAdminDetails.ShowOnPageLoad = False
    End Sub
    Protected Sub PopulateMyDetails()
        Me.bstbFName.Text = Session("UserForename")
        Me.bstbLName.Text = Session("UserSurname")
        Me.bstbEmail.Text = Session("UserEmail")
        Dim AdminUserAdapter As New ITSPTableAdapters.AdminUsersTableAdapter()
        Dim AdminUserTable As ITSP.AdminUsersDataTable
        AdminUserTable = AdminUserAdapter.GetByAdminID(Session("UserAdminID"))
        bsimgProfileImage.Value = AdminUserTable.First.ProfileImage
        bsimgProfileImage.Width = 150
        bsimgProfileImage.Height = 150
    End Sub
    Protected Sub PopulateDelegateDetails()
        Dim nCandidateID As Integer = CInt(Session("learnCandidateID"))
        If nCandidateID <= 0 Then
            Exit Sub
        End If
        Dim taCandidate As New LearnerPortalTableAdapters.CandidateDetailsTableAdapter
        Dim tCandidate As New LearnerPortal.CandidateDetailsDataTable
        tCandidate = taCandidate.GetData(nCandidateID)
        If tCandidate.Count > 0 Then
            hfActive.Value = tCandidate.First.Active
            hfApproved.Value = tCandidate.First.Approved
            hfAlias.Value = tCandidate.First.AliasID
            bstbDelFName.Text = tCandidate.First.FirstName
            bstbDelLName.Text = tCandidate.First.LastName
            bstbDelEmail.Text = tCandidate.First.EmailAddress
            cbxJobGroup.Value = tCandidate.First.JobGroupID
            If cbxJobGroup.SelectedIndex < 0 Then
                cbxJobGroup.Value = Nothing
            End If
        End If
        bsimgDelProfileImage.Value = tCandidate.First.ProfileImage
        bsimgDelProfileImage.Width = 150
        bsimgDelProfileImage.Height = 150
        Dim taCentre As New LearnerPortalTableAdapters.CentresTableAdapter()
        Dim tCtre As New LearnerPortal.CentresDataTable
        tCtre = taCentre.GetByCentreID(CInt(Session("UserCentreID")))
        Dim lblField1 As String = tCtre.First.F1Name
        If lblField1.Length > 0 Then
            lblCustField1.Text = lblField1 + ":"

            Dim ddChoicesFld1 As String = tCtre.First.F1Options
            If ddChoicesFld1.Length > 0 Then
                PopCBXFromReturnSeparatedString(ddChoicesFld1, cbxField1)
                cbxField1.Visible = True
                bstbField1.Visible = False
                If ddChoicesFld1.Contains(tCandidate.First.Answer1) Then
                    cbxField1.Value = tCandidate.First.Answer1
                    If cbxField1.SelectedIndex < 0 Then
                        cbxField1.Value = Nothing
                    End If
                End If
            Else
                bstbField1.Visible = True
                cbxField1.Visible = False
                bstbField1.Text = tCandidate.First.Answer1
            End If
            If tCtre.First.F1Mandatory Then
                If ddChoicesFld1.Length > 0 Then
                    AddRequiredFieldValidator(cbxField1, "vgUpdateDelDetails")
                Else
                    AddRequiredFieldValidator(bstbField1, "vgUpdateDelDetails")
                End If
            End If
        Else
            trCustField1.Visible = False
        End If
        Dim lblField2 As String = tCtre.First.F2Name
        If lblField2.Length > 0 Then
            lblCustField2.Text = lblField2 + ":"

            Dim ddChoicesFld2 As String = tCtre.First.F2Options
            If ddChoicesFld2.Length > 0 Then
                PopCBXFromReturnSeparatedString(ddChoicesFld2, cbxField2)
                bstbField2.Visible = False
                If ddChoicesFld2.Contains(tCandidate.First.Answer2) Then
                    cbxField2.Value = tCandidate.First.Answer2
                    If cbxField2.SelectedIndex < 0 Then
                        cbxField2.Value = Nothing
                    End If
                End If
            Else
                cbxField2.Visible = False
                bstbField2.Text = tCandidate.First.Answer2
            End If
            If tCtre.First.F2Mandatory Then
                If ddChoicesFld2.Length > 0 Then
                    AddRequiredFieldValidator(cbxField2, "vgUpdateDelDetails")
                Else
                    AddRequiredFieldValidator(bstbField2, "vgUpdateDelDetails")
                End If
            End If
        Else
            trCustField2.Visible = False
        End If
        Dim lblField3 As String = tCtre.First.F3Name
        If lblField3.Length > 0 Then
            lblCustField3.Text = lblField3 + ":"

            Dim ddChoicesFld3 As String = tCtre.First.F3Options
            If ddChoicesFld3.Length > 0 Then
                PopCBXFromReturnSeparatedString(ddChoicesFld3, cbxField3)
                bstbField3.Visible = False
                If ddChoicesFld3.Contains(tCandidate.First.Answer3) Then
                    cbxField3.Value = tCandidate.First.Answer3
                    If cbxField3.SelectedIndex < 0 Then
                        cbxField3.Value = Nothing
                    End If
                End If
            Else
                cbxField3.Visible = False
                bstbField3.Text = tCandidate.First.Answer3
            End If
            If tCtre.First.F3Mandatory Then
                If ddChoicesFld3.Length > 0 Then
                    AddRequiredFieldValidator(cbxField3, "vgUpdateDetails")
                Else
                    AddRequiredFieldValidator(bstbField3, "vgUpdateDetails")
                End If
            End If
        Else
            trCustField3.Visible = False
        End If
        Dim lblField4 As String = tCtre.First.F4Name
        If lblField4.Length > 0 Then
            lblCustField4.Text = lblField4 + ":"

            Dim ddChoicesFld4 As String = tCtre.First.F4Options
            If ddChoicesFld4.Length > 0 Then
                PopCBXFromReturnSeparatedString(ddChoicesFld4, cbxField4)
                bstbField4.Visible = False
                If ddChoicesFld4.Contains(tCandidate.First.Answer4) Then
                    cbxField4.Value = tCandidate.First.Answer4
                    If cbxField4.SelectedIndex < 0 Then
                        cbxField4.Value = Nothing
                    End If
                End If
            Else
                cbxField4.Visible = False
                bstbField4.Text = tCandidate.First.Answer4
            End If
            If tCtre.First.F4Mandatory Then
                If ddChoicesFld4.Length > 0 Then
                    AddRequiredFieldValidator(cbxField4, "vgUpdateDetails")
                Else
                    AddRequiredFieldValidator(bstbField4, "vgUpdateDetails")
                End If
            End If
        Else
            trCustField4.Visible = False
        End If
        Dim lblField5 As String = tCtre.First.F5Name
        If lblField5.Length > 0 Then
            lblCustField5.Text = lblField5 + ":"

            Dim ddChoicesFld5 As String = tCtre.First.F5Options
            If ddChoicesFld5.Length > 0 Then
                PopCBXFromReturnSeparatedString(ddChoicesFld5, cbxField5)
                bstbField5.Visible = False
                If ddChoicesFld5.Contains(tCandidate.First.Answer5) Then
                    cbxField5.Value = tCandidate.First.Answer5
                    If cbxField5.SelectedIndex < 0 Then
                        cbxField5.Value = Nothing
                    End If
                End If
            Else
                cbxField5.Visible = False
                bstbField5.Text = tCandidate.First.Answer5
            End If
            If tCtre.First.F5Mandatory Then
                If ddChoicesFld5.Length > 0 Then
                    AddRequiredFieldValidator(cbxField5, "vgUpdateDetails")
                Else
                    AddRequiredFieldValidator(bstbField5, "vgUpdateDetails")
                End If
            End If
        Else
            trCustField5.Visible = False
        End If
        Dim lblField6 As String = tCtre.First.F6Name
        If lblField6.Length > 0 Then
            lblCustField6.Text = lblField6 + ":"

            Dim ddChoicesFld6 As String = tCtre.First.F6Options
            If ddChoicesFld6.Length > 0 Then
                PopCBXFromReturnSeparatedString(ddChoicesFld6, cbxField6)
                bstbField6.Visible = False
                If ddChoicesFld6.Contains(tCandidate.First.Answer6) Then
                    cbxField6.Value = tCandidate.First.Answer6
                    If cbxField6.SelectedIndex < 0 Then
                        cbxField6.Value = Nothing
                    End If
                End If
            Else
                cbxField6.Visible = False
                bstbField6.Text = tCandidate.First.Answer6
            End If
            If tCtre.First.F6Mandatory Then
                If ddChoicesFld6.Length > 0 Then
                    AddRequiredFieldValidator(cbxField6, "vgUpdateDetails")
                Else
                    AddRequiredFieldValidator(bstbField6, "vgUpdateDetails")
                End If
            End If
        Else
            trCustField6.Visible = False
        End If
        If Not Session("lpUserPass") Is Nothing Then
            If Not Session("lpUserPass") = "" Then
                divOldPW.Visible = True
                lblChangePWBtn.Text = "Change password"
            End If
        End If
        rptDelNotifications.DataBind()
    End Sub
    Public Property bImageUpdated = True
    Private Sub bimgProfileImage_ValueChanged(sender As Object, e As EventArgs) Handles bsimgProfileImage.ValueChanged, bsimgDelProfileImage.ValueChanged
        Dim bsimg As BootstrapBinaryImage = TryCast(sender, BootstrapBinaryImage)
        If Not bsimg.Value Is Nothing And bImageUpdated Then
            Dim myMemStream As New IO.MemoryStream(CType(bsimg.Value, Byte()))
            myMemStream = CCommon.squareImageFromMemoryStream(myMemStream)
            bsimg.Value = CCommon.resizeImageFromMemoryStream(myMemStream, 300, 300).ToArray()
            bsimg.Width = 300
            bsimg.Height = 300
            bImageUpdated = False
        Else
            bImageUpdated = True
        End If
    End Sub

    Private Sub lbtMxLearningAccount_Click(sender As Object, e As EventArgs) Handles lbtMxLearningAccount.Click
        PopulateDelegateDetails()
        rptDelNotifications.DataBind()
        bspDelegateDetails.ShowOnPageLoad = True
        'Response.Redirect(getPageUrl() & "?action=mxdelegate")

    End Sub

    Public Function PopCBXFromReturnSeparatedString(ByVal sListString, ByVal cDDList)
        cDDList.Items.Add(New BootstrapListEditItem("--Select--", "0"))
        Dim ddFieldArray() As String
        ddFieldArray = sListString.Split(New String() {Environment.NewLine, vbCr & vbLf, vbLf}, StringSplitOptions.None)
        For Each ch In ddFieldArray
            cDDList.Items.Add(New BootstrapListEditItem(ch, ch))
        Next
        Return True
    End Function
    Public Sub AddRequiredFieldValidator(ByVal pControlToValidate, ByVal sValidationGroup)
        pControlToValidate.ValidationSettings.RequiredField.IsRequired = True
        pControlToValidate.ValidationSettings.RequiredField.ErrorText = "Required"
        pControlToValidate.ValidationSettings.ValidationGroup = sValidationGroup
    End Sub
    Protected Sub bsbtnSaveDelDetails_Command(sender As Object, e As CommandEventArgs)

        Dim taQ As New LearnerPortalTableAdapters.QueriesTableAdapter
        Dim nCandidateID As Integer = CInt(Session("learnCandidateID"))
        If nCandidateID <= 0 Then
            Exit Sub
        End If
        Dim sFirstName As String = bstbDelFName.Text
        Dim sLastName As String = bstbDelLName.Text
        Dim sEmail As String = bstbDelEmail.Text
        Dim nJobGroupID As Integer = cbxJobGroup.Value
        Dim sAnswer1 As String
        Dim sAnswer2 As String
        Dim sAnswer3 As String
        Dim sAnswer4 As String
        Dim sAnswer5 As String
        Dim sAnswer6 As String
        If cbxField1.Visible Then
            sAnswer1 = cbxField1.Value
        Else
            sAnswer1 = bstbField1.Text
        End If
        If cbxField2.Visible Then
            sAnswer2 = cbxField2.Value
        Else
            sAnswer2 = bstbField2.Text
        End If
        If cbxField3.Visible Then
            sAnswer3 = cbxField3.Value
        Else
            sAnswer3 = bstbField3.Text
        End If
        If cbxField4.Visible Then
            sAnswer4 = cbxField4.Value
        Else
            sAnswer4 = bstbField4.Text
        End If
        If cbxField5.Visible Then
            sAnswer5 = cbxField5.Value
        Else
            sAnswer5 = bstbField5.Text
        End If
        If cbxField6.Visible Then
            sAnswer6 = cbxField6.Value
        Else
            sAnswer6 = bstbField6.Text
        End If
        Dim sRes As String = taQ.uspUpdateCandidateEmailCheck(nCandidateID, sFirstName, sLastName, nJobGroupID, sAnswer1, sAnswer2, sAnswer3, sAnswer4, sAnswer5, sAnswer6, sEmail, hfAlias.Value, hfApproved.Value, hfActive.Value, bsimgDelProfileImage.Value)
        If sRes = "-4" Then
            lblConfirmTitle.Text = "Details Not Updated"
            lblConfirmMessage.Text = "Your details could not be updated. Another delegate record exists with the e-mail address provided. The e-mail address must be unique to the delegate."
        Else
            Dim taNotifUsers As New LearnerPortalTableAdapters.NotificationUsersTableAdapter
            For Each i As RepeaterItem In rptDelNotifications.Items
                Dim cbYN As HtmlInputCheckBox = i.FindControl("cbYesNo")
                Dim hf As HiddenField = i.FindControl("hfNotificationID")
                If cbYN.Checked Then
                    taNotifUsers.InsertCandidateNotificationIfNotExists(Session("learnCandidateID"), hf.Value)
                Else
                    taNotifUsers.DeleteByCandidateID(hf.Value, Session("learnCandidateID"))
                End If
            Next
            bspDelegateDetails.ShowOnPageLoad = False
            lblConfirmTitle.Text = "Details Updated"
            lblConfirmMessage.Text = "Your details have been updated successfully."
        End If
        'let's see if we need to update the user's password:
        If bstbNewPassword1.Text <> "" Then
            'and check existing password matches if set:
            If Not Session("lpUserPass") Is Nothing Then
                If Not Session("lpUserPass") = "" Then
                    If Not Crypto.VerifyHashedPassword(Session("lpUserPass"), bstbOldPassword.Text.Trim) Then
                        lblConfirmTitle.Text = "Old Password Doesn't Match"
                        lblConfirmMessage.Text = "Your details were not updated. The old password supplied was incorrect."
                        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#confirmModal').modal('show');</script>")
                        Exit Sub
                    End If
                End If
            End If
            'now update the password:
            Dim taCandidates As New LearnerPortalTableAdapters.CandidatesTableAdapter
            taCandidates.SetPassword(Crypto.HashPassword(bstbNewPassword1.Text.Trim), Session("learnCandidateID"))
            bspDelegateDetails.ShowOnPageLoad = False
            lblConfirmTitle.Text = "Details Updated and Password Set"
            lblConfirmMessage.Text = "Your details and password have been updated successfully. Remember to use your new password when you next login."
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#confirmModal').modal('show');</script>")
    End Sub

    Private Sub lbtRegLink_Click(sender As Object, e As EventArgs) Handles lbtRegLink.Click, lbtRegLink2.Click, lbtRegLink3.Click
        Dim sQ As String = Request.Url.Query
        If Not sQ.Contains("action=login") Then
            sQ = ""
        End If
        sQ = sQ.Replace("action=login", "action=reg")
        Response.Redirect("~/register" & sQ)
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
    Private Sub LogIn(ByVal sUsername As String, ByVal nCentreID As Integer, ByVal sPassword As String)
        'Setup variables requiring defaults:
        If sUsername.Length > 0 Then

            Session("UserCentreID") = 0
            Session("UserCentreManager") = False
            Session("UserCentreAdmin") = False
            Session("UserUserAdmin") = False
            Session("UserContentCreator") = False
            Session("UserAuthenticatedCM") = False
            Session("UserPublishToAll") = False
            Session("UserImportOnly") = False
            Session("UserCentreReports") = False
            Session("learnCandidateID") = 0
            Session("learnUserAuthenticated") = False
            Session("AdminCategoryID") = 0
            Session("IsSupervisor") = False
            Session("IsTrainer") = False
            Session("IsFrameworkDeveloper") = False
            GetAdminRecord(sUsername, nCentreID, sPassword)
            GetDelegateRecord(sUsername, nCentreID, sPassword)
            If Session("UserAdminID") Is Nothing And Session("learnUserAuthenticated") Then
                GetAdminRecord(Session("UserEmail"), Session("UserCentreID"), sPassword)
            End If
            Session("LearningPortalUrl") = CCommon.GetLPURL(Session("UserAdminID"), Session("UserCentreID"))
            If Not Session("UserEmail") Is Nothing Then
                    Dim claims = New List(Of Claim)()
                    claims.Add(New Claim(ClaimTypes.Email, Session("UserEmail")))
                    claims.Add(New Claim("UserCentreID", Session("UserCentreID")))
                    claims.Add(New Claim("UserCentreManager", Session("UserCentreManager")))
                    claims.Add(New Claim("UserCentreAdmin", Session("UserCentreAdmin")))
                    claims.Add(New Claim("UserUserAdmin", Session("UserUserAdmin")))
                    claims.Add(New Claim("UserContentCreator", Session("UserContentCreator")))
                    claims.Add(New Claim("UserAuthenticatedCM", Session("UserAuthenticatedCM")))
                    claims.Add(New Claim("UserPublishToAll", Session("UserPublishToAll")))
                    claims.Add(New Claim("UserCentreReports", Session("UserCentreReports")))
                    claims.Add(New Claim("learnCandidateID", Session("learnCandidateID")))
                    claims.Add(New Claim("learnUserAuthenticated", Session("learnUserAuthenticated")))
                    claims.Add(New Claim("AdminCategoryID", Session("AdminCategoryID")))
                    claims.Add(New Claim("IsSupervisor", Session("IsSupervisor")))
                claims.Add(New Claim("IsTrainer", Session("IsTrainer")))
                claims.Add(New Claim("IsFrameworkDeveloper", Session("IsFrameworkDeveloper")))
                If Not Session("learnCandidateNumber") Is Nothing Then
                        claims.Add(New Claim("learnCandidateNumber", Session("learnCandidateNumber"), ""))
                    End If
                    If Not Session("UserForename") Is Nothing Then
                        claims.Add(New Claim("UserForename", Session("UserForename"), ""))
                        claims.Add(New Claim("UserSurname", Session("UserSurname"), ""))
                    End If
                    If Not Session("UserCentreName") Is Nothing Then
                        claims.Add(New Claim("UserCentreName", Session("UserCentreName"), ""))
                    End If
                    If Not Session("UserAdminID") Is Nothing Then
                        claims.Add(New Claim("UserAdminID", Session("UserAdminID"), ""))
                    End If
                    Dim identity = New ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationType)

                    If Request.IsAuthenticated Then
                        Dim cp As ClaimsPrincipal = HttpContext.Current.User
                        If Not cp.HasClaim(Function(c) c.Type = "UserCentreID") Then
                            cp.AddIdentity(identity)
                        End If
                    Else
                        Context.GetOwinContext().Authentication.SignIn(New AuthenticationProperties() With {
                       .IsPersistent = cbRememberMe.Checked
                   }, identity)
                    End If
                End If
                If Session("UserCentreID") > 0 Then
                    Dim taCentre As New ITSPTableAdapters.CentresTableAdapter
                    Dim tCtre As New ITSP.CentresDataTable
                    tCtre = taCentre.GetByCentreID(CInt(Session("UserCentreID")))
                    If tCtre.First.Active = False Then
                        Response.Redirect("~/CentreInactive")
                    End If
                    Session("kbYouTube") = tCtre.First.kbYouTube
                    Session("kbOfficeVersion") = tCtre.First.kbDefaultOfficeVersion
                    Session("BannerText") = tCtre.First.BannerText
                    Dim nHeight As Integer = tCtre.First.LogoHeight
                    If nHeight = 0 Then
                        Session("logoVisible") = False
                    Else
                        Dim nWidth As Integer = tCtre.First.LogoWidth
                        Dim nNewWidth As Integer = nWidth
                        Dim nNewHeight As Integer = nHeight
                        If nNewHeight > 96 Then
                            nNewWidth = CInt((CSng(96) / CSng(nHeight)) * CSng(nWidth))
                            nNewHeight = 96
                        End If
                        If nNewWidth > 300 Then
                            nNewHeight = CInt((CSng(300) / CSng(nNewWidth)) * CSng(nNewHeight))
                            nNewWidth = 300
                        End If

                        Session("logoHeight") = nNewHeight
                        Session("logoWidth") = nNewWidth
                        Session("logoVisible") = True
                    End If
                    If Not Page.Request.Item("returnurl") Is Nothing Then
                        Dim sURL As String = Page.Request.Item("returnurl") & "&redirected=1"
                        If sURL.Contains("&redirected=1") And Not sURL.Contains("?") Then
                            sURL = sURL.Replace("&redirected=1", "?redirected=1")
                        End If
                        Page.Response.Redirect(sURL)
                    ElseIf Not Page.Request.Item("app") Is Nothing Then
                        Select Case Page.Request.Item("app")
                            Case "ts"
                                If Session("IsSupervisor") And Not Session("UserAdminID") Is Nothing Then
                                    Page.Response.Redirect("~/tracking/supervise")
                                ElseIf Not Session("UserAdminID") Is Nothing Then
                                    Page.Response.Redirect("~/tracking/dashboard")
                                Else
                                    Page.Response.Redirect("~/home?action=appselect")
                                End If
                            Case "lp"
                                Page.Response.Redirect(Session("LearningPortalUrl"))
                            Case "cms"
                                If Session("UserAuthenticatedCM") Then
                                    Page.Response.Redirect("~/cms/courses")
                                Else
                                    Page.Response.Redirect("~/home?action=appselect")
                                End If

                            Case "learn"
                                If Not Page.Request.Item("customisationid") Is Nothing Then
                                Page.Response.Redirect(CCommon.GetConfigString("V2AppBaseUrl") & "LearningMenu/" & Page.Request.Item("customisationid"))
                            Else
                                    Page.Response.Redirect("~/home?action=appselect")
                                End If
                            Case Else
                                Page.Response.Redirect("~/home?action=appselect")
                        End Select
                    Else
                        Page.Response.Redirect("~/home?action=appselect")
                    End If

                Else
                    If Session("delUnapproved") Is Nothing Then
                        lblConfirmTitle.Text = "Login Failed"
                        lblConfirmMessage.Text = "There was a problem with your username and / or password. Please use the recover tab to reset your password."
                        Page.ClientScript.RegisterStartupScript(Me.GetType(), "errorrecover", "<script>$('#pnlAccount').modal('hide');$('#confirmModal').modal('show');</script>")
                    Else
                        lblConfirmTitle.Text = "Error: Registration not yet Approved"
                        lblConfirmMessage.Text = "Your registration has not yet been approved by your centre administrators. You should receive an email notification once approved."
                        Page.ClientScript.RegisterStartupScript(Me.GetType(), "errorunapproved", "<script>$('#pnlAccount').modal('hide');$('#confirmModal').modal('show');</script>")
                    End If
                End If

            End If
    End Sub
    Private Sub bsbtnLogin_Click(sender As Object, e As EventArgs) Handles bsbtnLogin.Click
        'Get username and password entered:
        If Page.IsValid Then
            Dim sUsername As String = bstbUserName.Text.Trim
            Dim sPassword As String = bstbUserPassword.Text.Trim
            Dim nCentreID As Integer = 0
            If sUsername.Length > 0 And sPassword.Length > 0 Then
                If Not Page.Request.Item("centreid") Is Nothing Then
                    nCentreID = CInt(nCentreID)
                End If

                'login:
                LogIn(sUsername, nCentreID, sPassword)
            End If
        End If
    End Sub
    Private Sub GetAdminRecord(ByVal sUsername As String, ByVal nCentreID As Integer, ByVal sPassword As String)
        'Check for a matching Admin Record:
        Dim taAdminUsers As New AuthenticateTableAdapters.AdminUsersTableAdapter
        Dim tAdminUsers As New Authenticate.AdminUsersDataTable
        tAdminUsers = taAdminUsers.GetData(sUsername, nCentreID)
        If tAdminUsers.Count > 0 Then
            'go through each record looking for a match:
            For Each r As DataRow In tAdminUsers.Rows
                If Crypto.VerifyHashedPassword(CStr(r.Item("Password")), sPassword) Or Session("learnUserAuthenticated") Or Request.IsAuthenticated Then
                    Session("UserForename") = r.Item("Forename")
                    Session("UserSurname") = r.Item("Surname")
                    Session("UserEmail") = r.Item("Email")
                    Session("UserCentreID") = r.Item("CentreID")
                    Session("UserCentreName") = r.Item("CentreName")
                    Session("UserCentreManager") = r.Item("IsCentreManager")
                    Session("UserCentreAdmin") = r.Item("CentreAdmin")
                    Session("UserUserAdmin") = r.Item("UserAdmin")
                    Session("UserAdminID") = r.Item("AdminID")
                    Session("UserContentCreator") = r.Item("ContentCreator")
                    Session("UserAuthenticatedCM") = r.Item("ContentManager")
                    Session("UserPublishToAll") = r.Item("PublishToAll")
                    Session("UserImportOnly") = r.Item("ImportOnly")
                    Session("UserAdminSessionID") = CCommon.CreateAdminUserSession(Session("UserAdminID"))
                    Session("AdminCategoryID") = r.Item("CategoryID")
                    Session("IsSupervisor") = r.Item("Supervisor")
                    Session("IsTrainer") = r.Item("Trainer")
                    Session("UserCentreReports") = r.Item("SummaryReports")
                    Session("IsFrameworkDeveloper") = r.Item("IsFrameworkDeveloper")
                    CEITSProfile.LoadProfileFromString(r.Item("EITSProfile")).SetProfile(Session)
                    'lbtAccount.Visible = False
                    'lbtAppSelect.Visible = True
                    Exit For
                End If
            Next
        End If
    End Sub
    Private Sub GetDelegateRecord(ByVal sUsername As String, ByVal nCentreID As Integer, ByVal sPassword As String)
        'Now check for a matching learner record:
        Dim taCandidates As New AuthenticateTableAdapters.CandidatesTableAdapter
        Dim tCandidates As New Authenticate.CandidatesDataTable
        If Session("UserCentreID") > 0 Then
            tCandidates = taCandidates.GetData(Session("UserEmail"), Session("UserCentreID"))
        Else
            tCandidates = taCandidates.GetData(sUsername, nCentreID)
        End If

        If tCandidates.Count > 0 Then
            'go through each and look for matches:
            For Each r As DataRow In tCandidates.Rows
                If r.Item("Approved") Then
                    'Check that the password matches or an admin user at the same centre has already authenticated:
                    If (Session("UserCentreID") > 0 And r.Item("CentreID") = Session("UserCentreID")) Then
                        Session("learnCandidateID") = r.Item("CandidateID")
                        Session("learnCandidateNumber") = r.Item("CandidateNumber")
                        Session("learnUserAuthenticated") = True
                        'lbtAccount.Visible = False
                        'lbtAppSelect.Visible = True
                        Exit For
                    ElseIf Not IsDBNull(r.Item("Password")) Then
                        If Crypto.VerifyHashedPassword(CStr(r.Item("Password")), sPassword) Or Request.IsAuthenticated Then
                            'Populate name, e-mail etc beccause it wasn't populated from admin user:
                            Session("UserForename") = r.Item("FirstName")
                            Session("UserSurname") = r.Item("LastName")
                            Session("UserEmail") = r.Item("EmailAddress")
                            Session("UserCentreID") = r.Item("CentreID")
                            Session("UserCentreName") = r.Item("CentreName")
                            Session("learnCandidateID") = r.Item("CandidateID")
                            Session("learnCandidateNumber") = r.Item("CandidateNumber")
                            Session("learnUserAuthenticated") = True
                            Exit For
                        End If

                    End If
                Else
                    Session("delUnapproved") = True
                End If
            Next
        End If
    End Sub

    Private Sub bsbtnResetPW_Click(sender As Object, e As EventArgs) Handles bsbtnResetPW.Click
        lblConfirmMessage.Text = String.Empty
        lblConfirmTitle.Text = "Password Reset Error"
        Dim sTxtUsername As String = bstbResetEmail.Text.Trim
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
        Dim taAdmin As New AuthenticateTableAdapters.AdminUsersTableAdapter
        Dim tAdmin As New Authenticate.AdminUsersDataTable
        tAdmin = taAdmin.GetData(sTxtUsername, 0)
        If tAdmin.Count > 0 Then
            While bTryAgain
                '
                ' Get a hash value for the hotlink.
                '
                nAttempt += 1
                sSeed.Append(Now().ToString("MMMM ss mm"))
                sSeed.Append(sTxtUsername)
                sSeed.Append(nAttempt.ToString)
                sSeed.Append(sTxtUsername)
                sSeed.Append("Digital Learning Solutions")  ' add a bit more randomness
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
                        sMsg = "Password reset failed. There was an unexpected problem. Please contact the site administrators at it.skills@nhs.uk with your details."

                    Case -103
                        bTryAgain = True            ' oops, hash not unique, generate another one
                End Select
            End While

            If sMsg <> String.Empty Then            ' show error if one present

                Me.lblConfirmMessage.Text = sMsg
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalResetError", "<script>$('#pnlAccount').modal('hide');$('#confirmModal').modal('show');</script>")
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
                sMsg = "There was a problem generating your password reset email. Please contact the site administrators at dls@hee.nhs.uk"
                Me.lblConfirmMessage.Text = sMsg
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalResetError", "<script>$('#pnlAccount').modal('hide');$('#confirmModal').modal('show');</script>")
                Exit Sub
            End If
            AdminUserRow = AdminUserTable.First()
            '
            ' Create the email
            '
            Dim sbBody As New StringBuilder
            Dim sPageName As String = Request.Url.Scheme & "://" & Request.Url.Authority &
                                          "/reset?action=getpassword&pwdr=" & sHash & "&email=" & AdminUserRow.Email

            sbBody.Append("Dear " & AdminUserRow.Forename & "," & vbCrLf)
            sbBody.Append(vbCrLf)
            sbBody.Append("A request has been made to reset the password for your Digital Learning Solutions account." & vbCrLf)
            sbBody.Append(vbCrLf)
            sbBody.Append("To reset your password please follow this link: " & sPageName & vbCrLf)
            sbBody.Append("Note that this link can only be used once." & vbCrLf)
            sbBody.Append(vbCrLf)
            sbBody.Append("Please don't reply to this email as it has been automatically generated." & vbCrLf)
            '
            ' And try to send the email
            '
            If CCommon.SendEmail(AdminUserRow.Email, "Digital Learning Solutions Tracking System Password Reset", sbBody.ToString(), False) Then

                lblConfirmTitle.Text = "Password Reset Email Sent"
                Me.lblConfirmMessage.Text = "An email has been sent to you giving details of how to reset your password."
            Else

                Me.lblConfirmMessage.Text = "There was a problem sending you an email. Please contact your centre administrators at dls@hee.nhs.uk to ask about your password reset."
            End If
        Else
            Dim taCand As New AuthenticateTableAdapters.CandidatesTableAdapter
            Dim tCand As New Authenticate.CandidatesDataTable
            tCand = taCand.GetMatchesForReset(sTxtUsername)
            If tCand.Count > 0 Then
                'we have a candidate match use it:
                Dim nCandidateID As Integer = tCand.First.CandidateID

                Dim sResetHash As String = (Guid.NewGuid()).ToString()
                Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
                taq.SetPWResetHash(sResetHash, nCandidateID)
                'Setup and send a reset e-mail here:
                Dim sbBody As New StringBuilder
                Dim sPageName As String = My.Settings.MyURL
                sPageName = sPageName & "reset" & "?pwdr=" & sResetHash & "&email=" & tCand.First.EmailAddress
                sbBody.Append("Dear " & tCand.First.FirstName & "," & vbCrLf)
                sbBody.Append(vbCrLf)
                sbBody.Append("A request has been made to reset the password for your Digital Learning Solutions account." & vbCrLf)
                sbBody.Append(vbCrLf)
                sbBody.Append("To reset your password please follow this link: " & sPageName & vbCrLf)
                sbBody.Append("Note that this link can only be used once." & vbCrLf)
                sbBody.Append(vbCrLf)
                sbBody.Append("Please don't reply to this email as it has been automatically generated." & vbCrLf)
                If CCommon.SendEmail(tCand.First.EmailAddress, "Digital Learning Solutions Tracking System Password Reset", sbBody.ToString(), False) Then
                    lblConfirmMessage.Text = "<p>An email has been sent to the address you registered with, containing a link to reset your password.</p><p>Following the link will remove the password associated with your login, allowing you to set a new one.</p><p><b>Note:</b> The link will only work once.</p>"
                    lblConfirmTitle.Text = "Password Reset E-mail Sent"
                Else
                    lblConfirmMessage.Text = "There was a problem sending you an email. The e-mail associated with your account is invalid. Please contact your centre administrator or centre manager for assistance. Use our <a href='findyourcentre' target='_blank'>Find Your Centre</a> page if you aren't sure who to contact."
                End If
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#messageModal').modal('show');</script>")
            Else
                lblConfirmMessage.Text = "There was a problem sending you an email. The e-mail associated with your account is invalid. Please contact your centre administrator or centre manager for assistance. Use our <a href='findyourcentre' target='_blank'>Find Your Centre</a> page if you aren't sure who to contact."
            End If
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalPWChanged", "<script>$('#pnlAccount').modal('hide');$('#confirmModal').modal('show');</script>")
    End Sub

    Private Sub lbtSignIn_Command(sender As Object, e As CommandEventArgs) Handles lbtSignIn.Command
        If Not Request.IsAuthenticated Then
            Context.GetOwinContext().Authentication.Challenge(New AuthenticationProperties, OpenIdConnectAuthenticationDefaults.AuthenticationType)
        End If
    End Sub
End Class