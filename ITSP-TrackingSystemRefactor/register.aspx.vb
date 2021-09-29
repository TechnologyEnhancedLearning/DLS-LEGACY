Imports System.Globalization
Imports Microsoft.Owin.Security
Imports Microsoft.Owin.Security.Cookies
Imports Microsoft.Owin.Security.OpenIdConnect

Public Class register
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.Request.Item("app") Is Nothing Then
            Select Case Page.Request.Item("app")
                Case "lp", "learn"
                    lblRegText.Text = "Register to access Digital Learning Solutions learning content below."
                Case "ts", "cms"
                    lblRegText.Text = "Register to access Digital Learning Solutions systems as a centre administrator below."
            End Select
        End If
        btnRegister.Attributes.Add("onclick", "return validateRegFields();")
        lbtRegisterCustom.Attributes.Add("onclick", "return validateCustomFields();")
    End Sub

    Protected Sub CheckForCustomFields()
        'Check for custom organisation fields and present
        Dim taq As New AuthenticateTableAdapters.QueriesTableAdapter
        If taq.GetDelegateCountByEmailCentre(tbEmailReg.Text.Trim(), ddCentre.SelectedValue) > 0 Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowDupDelegateModal", "<script>$('#duplicateEmailModal').modal('show');</script>", False)
            Exit Sub
        End If
        Dim UserIP As String = Request.ServerVariables("REMOTE_ADDR").ToString()
        Session("lmUserIP") = UserIP
        Dim bHasCustom As Boolean = False
        Dim taCentre As New LearnMenuTableAdapters.CentresTableAdapter()
        Dim tCentre As New LearnMenu.CentresDataTable
        tCentre = taCentre.GetData(ddCentre.SelectedValue)
        If tCentre.Count > 0 Then
            Session("lmNotifyEmail") = tCentre.First.NotifyEmail
            Dim lblField1 As String = tCentre.First.F1Name
            If lblField1.Length > 0 Then
                bHasCustom = True
                lblCustField1.Text = lblField1

                Dim ddChoicesFld1 As String = tCentre.First.F1Options
                If ddChoicesFld1.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld1, ddField1)
                    ddField1.Visible = True
                    tbField1.Visible = False
                Else
                    tbField1.Visible = True
                    ddField1.Visible = False
                End If
                If tCentre.First.F1Mandatory Then
                    If ddChoicesFld1.Length > 0 Then
                        hfField1Mand.Value = 2
                    Else
                        hfField1Mand.Value = 1
                    End If

                End If
            Else
                pnlField1.Visible = False
            End If
            Dim lblField2 As String = tCentre.First.F2Name
            If lblField2.Length > 0 Then
                bHasCustom = True
                lblCustField2.Text = lblField2

                Dim ddChoicesFld2 As String = tCentre.First.F2Options
                If ddChoicesFld2.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld2, ddField2)
                    tbField2.Visible = False
                Else
                    ddField2.Visible = False
                End If
                If tCentre.First.F2Mandatory Then
                    If ddChoicesFld2.Length > 0 Then
                        hfField2Mand.Value = 2
                    Else
                        hfField2Mand.Value = 1
                    End If
                End If
            Else
                pnlField2.Visible = False
            End If
            Dim lblField3 As String = tCentre.First.F3Name
            If lblField3.Length > 0 Then
                bHasCustom = True
                lblCustField3.Text = lblField3

                Dim ddChoicesFld3 As String = tCentre.First.F3Options
                If ddChoicesFld3.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld3, ddField3)
                    tbField3.Visible = False
                Else
                    ddField3.Visible = False
                End If
                If tCentre.First.F3Mandatory Then
                    If ddChoicesFld3.Length > 0 Then
                        hfField3Mand.Value = 2
                    Else
                        hfField3Mand.Value = 1
                    End If
                End If
            Else
                pnlField3.Visible = False
            End If
            Dim lblField4 As String = tCentre.First.F4Name
            If lblField4.Length > 0 Then
                bHasCustom = True
                lblCustField4.Text = lblField4

                Dim ddChoicesFld4 As String = tCentre.First.F4Options
                If ddChoicesFld4.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld4, ddField4)
                    tbField4.Visible = False
                Else
                    ddField4.Visible = False
                End If
                If tCentre.First.F4Mandatory Then
                    If ddChoicesFld4.Length > 0 Then
                        hfField4Mand.Value = 2
                    Else
                        hfField4Mand.Value = 1
                    End If
                End If
            Else
                pnlField4.Visible = False
            End If
            Dim lblField5 As String = tCentre.First.F5Name
            If lblField5.Length > 0 Then
                bHasCustom = True
                lblCustField5.Text = lblField5

                Dim ddChoicesFld5 As String = tCentre.First.F5Options
                If ddChoicesFld5.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld5, ddField5)
                    tbField5.Visible = False
                Else
                    ddField5.Visible = False
                End If
                If tCentre.First.F5Mandatory Then
                    If ddChoicesFld5.Length > 0 Then
                        hfField5Mand.Value = 2
                    Else
                        hfField5Mand.Value = 1
                    End If
                End If
            Else
                pnlField5.Visible = False
            End If
            Dim lblField6 As String = tCentre.First.F6Name
            If lblField6.Length > 0 Then
                bHasCustom = True
                lblCustField6.Text = lblField6

                Dim ddChoicesFld6 As String = tCentre.First.F6Options
                If ddChoicesFld6.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld6, ddField6)
                    tbField6.Visible = False
                Else
                    ddField6.Visible = False
                End If
                If tCentre.First.F6Mandatory Then
                    If ddChoicesFld6.Length > 0 Then
                        hfField6Mand.Value = 2
                    Else
                        hfField6Mand.Value = 1
                    End If
                End If
            Else
                pnlField6.Visible = False
            End If
        End If

        Session("learnRegApprove") = False
        Dim listIPs() As String
        listIPs = tCentre.First.IPPrefix.ToString.Split(New String() {","c}, StringSplitOptions.RemoveEmptyEntries)
        For Each ip In listIPs
            If Session("lmUserIP") Like ip.ToString.Trim + "*" Then
                Session("learnRegApprove") = True
            End If
        Next
        If Session("lmUserIP") = "::1" Then
            Session("learnRegApprove") = True
        End If
        If Session("learnRegApprove") = False Then
            pnlIPAlert.Visible = True
        Else
            pnlIPAlert.Visible = False
        End If

        'Register as a delegate if none
        If Not bHasCustom Then
            RegisterDelegate()
        Else
            mvRegister.SetActiveView(vCustomQuestions)
        End If
    End Sub
    Protected Function IsGroupValid(ByVal sValidationGroup As String) As Boolean
        For Each validator As BaseValidator In Page.Validators

            If validator.ValidationGroup = sValidationGroup Then
                Dim fValid As Boolean = validator.IsValid

                If fValid Then
                    validator.Validate()
                    fValid = validator.IsValid
                    validator.IsValid = True
                End If

                If Not fValid Then Return False
            End If
        Next

        Return True
    End Function
    Public Function AddRequiredFieldValidator(ByVal pControlToValidate, ByVal pControlToAddTo, ByVal pInitialValue, ByVal sValidationGroup)
        Dim rfv As New RequiredFieldValidator()
        rfv.ErrorMessage = "Required"
        rfv.Display = ValidatorDisplay.Dynamic
        rfv.Text = "*"
        If pInitialValue.Length > 0 Then
            rfv.InitialValue = pInitialValue
        End If
        rfv.ControlToValidate = pControlToValidate
        rfv.EnableClientScript = True
        rfv.ValidationGroup = sValidationGroup.ToString()
        rfv.Enabled = True
        rfv.EnableViewState = True
        rfv.ToolTip = rfv.ErrorMessage
        rfv.Visible = True
        rfv.ID = "rfv" + pControlToValidate
        rfv.SetFocusOnError = True
        pControlToAddTo.Controls.Add(rfv)
        Return True
    End Function
    Protected Sub RegisterDelegate()
        Dim strAnswer1 As String = ""
        Dim strAnswer2 As String = ""
        Dim strAnswer3 As String = ""
        Dim strAnswer4 As String = ""
        Dim strAnswer5 As String = ""
        Dim strAnswer6 As String = ""
        If tbField1.Visible Then
            strAnswer1 = tbField1.Text.Trim()
        ElseIf ddField1.Visible Then
            strAnswer1 = ddField1.SelectedValue
        End If
        If tbField2.Visible Then
            strAnswer2 = tbField2.Text.Trim()
        ElseIf ddField2.Visible Then
            strAnswer2 = ddField2.SelectedValue
        End If
        If tbField3.Visible Then
            strAnswer3 = tbField3.Text.Trim()
        ElseIf ddField3.Visible Then
            strAnswer3 = ddField3.SelectedValue
        End If

        If tbField4.Visible Then
            strAnswer4 = tbField4.Text.Trim()
        ElseIf ddField4.Visible Then
            strAnswer4 = ddField4.SelectedValue
        End If
        If tbField5.Visible Then
            strAnswer5 = tbField5.Text.Trim()
        ElseIf ddField5.Visible Then
            strAnswer5 = ddField5.SelectedValue
        End If
        If tbField6.Visible Then
            strAnswer6 = tbField6.Text.Trim()
        ElseIf ddField6.Visible Then
            strAnswer6 = ddField6.SelectedValue
        End If

        Dim bApproved As Boolean = CBool(Session("learnRegApprove"))
        Dim bExternal As Boolean = True
        If bApproved Or Page.Request.Item("ApplicationID") IsNot Nothing Then
            bExternal = False
        End If
        Dim sCandidateNumber As String = ""
        Dim pwText As String = tbPasswordReg.Text.Trim()
        Try
            sCandidateNumber = CCommon.SaveNewCandidate(ddCentre.SelectedValue, tbFNameReg.Text.Trim(), tbLNameReg.Text.Trim(), ddJobGroup.SelectedValue, True, strAnswer1, strAnswer2, strAnswer3, strAnswer4, strAnswer5, strAnswer6, "", Session("learnRegApprove"), tbEmailReg.Text.Trim(), bExternal, True, DateTime.Today())
        Catch ex As CCommon.CandidateException
            lblConfirmTitle.Text = "Delegate Registration Error"
            lblConfirmMessage.Text = ex.Message
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowModalMsg", "<script>$('#confirmModal').modal('show');</script>", False)
            Exit Sub
        End Try
        Dim taCandidates As New AuthenticateTableAdapters.CandidatesTableAdapter
        Dim tCandidates As New Authenticate.CandidatesDataTable
        tCandidates = taCandidates.GetData(sCandidateNumber, ddCentre.SelectedValue)
        If tCandidates.Count > 0 Then
            taCandidates.SetPassword(hfTemp.Value, tCandidates.First.CandidateID)
        End If
        If Session("learnRegApprove") = False And Not sCandidateNumber = "-4" Then
            Dim service As New ts.services.services
            service.SendDelegateRegRequiresApprovalNotification(tbFNameReg.Text, tbLNameReg.Text, ddCentre.SelectedValue)
            divRegNotApproved.Visible = True

        Else
            divRegNotApproved.Visible = False


            If tCandidates.Count > 0 Then
                'go through each and look for matches:
                For Each r As DataRow In tCandidates.Rows
                    'Populate name, e-mail etc beccause it wasn't populated from admin user:
                    Session("UserForename") = r.Item("FirstName")
                    Session("UserSurname") = r.Item("LastName")
                    Session("UserEmail") = r.Item("EmailAddress")
                    Session("UserCentreID") = r.Item("CentreID")
                    Session("learnCandidateID") = r.Item("CandidateID")
                    Session("learnCandidateNumber") = r.Item("CandidateNumber")
                    Session("learnUserAuthenticated") = True
                    'lbtAccount.Visible = False
                    'lbtAppSelect.Visible = True
                    Exit For
                Next
            End If
            CCommon.LoginFromSession(False, Session, Request, Context)
        End If
        Dim taDelegate As New LearnMenuTableAdapters.CandidatesTableAdapter
        Dim tDelegate As New LearnMenu.CandidatesDataTable
        Dim taQ As New itspdbTableAdapters.QueriesTableAdapter
        Session("LearningPortalUrl") = CCommon.GetLPURL(Session("UserAdminID"), Session("UserCentreID"))
        If sCandidateNumber = "-4" Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowDupDelegateModal", "<script>$('#duplicateEmailModal').modal('show');</script>", False)
        Else
            tDelegate = taDelegate.GetData(ddCentre.SelectedValue, sCandidateNumber, sCandidateNumber)

            If tDelegate.Count() = 1 Then
                Session("learnCandidateID") = tDelegate.First.CandidateID
            End If

            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowDelegateModal", "<script>$('#delegateRegisteredModal').modal('show');$('#delNumber').text('" & sCandidateNumber & "');</script>", False)
            'Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowDelegateModal", "<script>$('#delegateRegisteredModal').modal('show');</script>")
        End If
    End Sub
    Private Sub btnContinue_Click(sender As Object, e As EventArgs) Handles btnContinue.Click
        If Not Page.Request.Item("returnurl") Is Nothing Then
            Page.Response.Redirect(Page.Request.Item("returnurl") & "&redirected=1")
        ElseIf Not Page.Request.Item("app") Is Nothing Then
            Select Case Page.Request.Item("app")
                Case "learn"
                    If divRegNotApproved.Visible Then
                        Page.Response.Redirect("~/home")
                    Else
                        If Not Page.Request.Item("customisationid") Is Nothing Then
                            Page.Response.Redirect(CCommon.GetConfigString("V2AppBaseUrl") & "LearningMenu/" & Page.Request.Item("customisationid"))
                        Else
                            Page.Response.Redirect("~/home?action=appselect")
                        End If
                    End If
                Case "ts"
                    If Not Session("UserAdminSessionID") Is Nothing Then
                        Page.Response.Redirect("~/tracking/dashboard")
                    Else
                        Page.Response.Redirect("~/home?action=appselect")
                    End If
                Case "lp"
                    If divRegNotApproved.Visible Then
                        Page.Response.Redirect("~/home")
                    Else
                        Page.Response.Redirect(Session("LearningPortalUrl"))
                    End If

                Case "cms"
                    If Not Session("UserAdminSessionID") Is Nothing Then
                        Page.Response.Redirect("~/cms/courses")
                    Else
                        Page.Response.Redirect("~/home?action=appselect")
                    End If
                Case Else
                    Page.Response.Redirect("~/home?action=appselect")
            End Select
        Else
            If divRegNotApproved.Visible Then
                Page.Response.Redirect("~/home")
            Else
                Page.Response.Redirect("~/home?action=appselect")
            End If
        End If
    End Sub

    Private Sub btnReturn_Click(sender As Object, e As EventArgs) Handles btnReturn.Click
        Dim sQ As String = Request.Url.Query
        If sQ.Length > 0 Then
            sQ = sQ.Replace("?action=reg&", "?").Replace("?", "?action=login&")
        Else
            sQ = "?action=login"
        End If
        Response.Redirect("~/Home" & sQ)
    End Sub

    Private Sub btnSendReminder_Click(sender As Object, e As EventArgs) Handles btnReset.Click
        Response.Redirect("~/Home?action=reset&email=" & tbEmailReg.Text)
    End Sub

    Private Sub ddCentre_DataBound(sender As Object, e As EventArgs) Handles ddCentre.DataBound
        Dim nCentreID As Integer
        If Not Page.Request.Item("centreid") Is Nothing Then
            nCentreID = Page.Request.Item("centreid")
        ElseIf Not Page.RouteData.Values("centre") Is Nothing Then
            Dim taq As New ITSPTableAdapters.QueriesTableAdapter
            nCentreID = taq.GetCentreIDFromShortnameORID(Page.RouteData.Values("centre"))
        End If
        If nCentreID > 0 Then
            Dim item As ListItem = ddCentre.Items.FindByValue(nCentreID)
            If item IsNot Nothing Then
                ddCentre.SelectedValue = nCentreID
                ddCentre.Enabled = False
            End If
        End If
        If Request.IsAuthenticated Then
            Dim sEmailClaim As String = ConfigurationManager.AppSettings("ida:EmailClaim")
            tbEmailReg.Text = System.Security.Claims.ClaimsPrincipal.Current.FindFirst(sEmailClaim).Value
            tbEmailReg.Enabled = False
            Dim sNameClaim As String = ConfigurationManager.AppSettings("ida:NameClaim")
            Dim fName As String = ""
            Dim lName As String = ""
            If Not System.Security.Claims.ClaimsPrincipal.Current.FindFirst(sNameClaim) Is Nothing Then
                Dim sName As String = System.Security.Claims.ClaimsPrincipal.Current.FindFirst(sNameClaim).Value

                If sName.Contains(", ") And sName.Contains("(") Then
                    lName = sName.Substring(0, sName.IndexOf(",")).Trim()
                    fName = sName.Substring(sName.LastIndexOf(",") + 2, sName.LastIndexOf("(") - (sName.LastIndexOf(",") + 2)).Trim()
                    Dim sOrgName As String = sName.Substring(sName.IndexOf("(") + 1, (sName.IndexOf(")") - sName.IndexOf("(") - 1)).Trim()
                    For Each item As ListItem In ddCentre.Items
                        If item.Text.ToLower.Contains(sOrgName.ToLower) Then
                            ddCentre.SelectedValue = item.Value
                            Exit For
                        End If
                    Next

                ElseIf sName.Contains(" ") Then
                    fName = sName.Substring(0, sName.IndexOf(" ")).Trim()
                    lName = sName.Substring(sName.LastIndexOf(" ")).Trim()
                End If
            End If
            tbFNameReg.Text = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(fName.ToLower)
            tbLNameReg.Text = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(lName.ToLower)
            pnlPassword.Visible = False
        End If
    End Sub

    Private Sub lbtRegisterCustom_Click(sender As Object, e As EventArgs) Handles lbtRegisterCustom.Click
        Page.Validate()
        If IsGroupValid("vgRegister2") Then
            RegisterDelegate()
        End If
    End Sub

    Private Sub btnRegister_Click(sender As Object, e As EventArgs) Handles btnRegister.Click
        If IsGroupValid("vgRegister") Then
            'get recaptcha response
            Dim Captcha As GoogleReCaptcha.GoogleReCaptcha = ctrlRegisterReCaptcha
            If Not Captcha.Validate() Then
                lblConfirmTitle.Text = "Registration Failed"
                lblConfirmMessage.Text = "You must prove you are not a robot using the reCaptcha check box to register."

                Page.ClientScript.RegisterStartupScript(Me.GetType(), "HideModalUpdateDetails", "<script>$('#confirmModal').modal('show');</script>")
                Exit Sub
            End If
            If Not cbTerms.Checked Then
                pnlTermsAlert.Visible = True
                Exit Sub
            End If
            hfTemp.Value = Crypto.HashPassword(tbPasswordReg.Text)
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
            CheckForCustomFields()
        End If
    End Sub
End Class