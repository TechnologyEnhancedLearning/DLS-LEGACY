Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap
Imports System.IO
Imports ClosedXML.Excel

Public Class delegates
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            Session("dvCandidateID") = 0

        End If
        Dim taCentres As New ITSPTableAdapters.CentresTableAdapter
        Dim tCentres As ITSP.CentresDataTable
            Dim nCentreID As Integer = CInt(Session("UserCentreID"))

            tCentres = taCentres.GetByCentreID(nCentreID)
            If tCentres.Count = 1 Then
                Dim rc As ITSP.CentresRow = tCentres.First
                '
                ' Change the titles of the columns to reflect the questions
                '
                SetupCustomFieldsForBSGV(bsgvCentreDelegates, rc)
                SetupCustomFieldsForBSGV(bsgvWelcomeDelegates, rc)
            End If
    End Sub
    Protected Sub SetupCustomFieldsForBSGV(ByVal bsgv As BootstrapGridView, ByVal rCentre As ITSP.CentresRow)
        bsgv.Columns("Answer1").Caption = rCentre.F1Name
        bsgv.Columns("Answer2").Caption = rCentre.F2Name
        bsgv.Columns("Answer3").Caption = rCentre.F3Name
        bsgv.Columns("Answer4").Caption = rCentre.F4Name
        bsgv.Columns("Answer5").Caption = rCentre.F5Name
        bsgv.Columns("Answer6").Caption = rCentre.F6Name
        If bsgv.Columns("Answer1").Caption = "" Then
            bsgv.Columns("Answer1").ShowInCustomizationForm = False
            bsgv.Columns("Answer1").Visible = False
        End If
        If bsgv.Columns("Answer2").Caption = "" Then
            bsgv.Columns("Answer2").ShowInCustomizationForm = False
            bsgv.Columns("Answer2").Visible = False
        End If
        If bsgv.Columns("Answer3").Caption = "" Then
            bsgv.Columns("Answer3").ShowInCustomizationForm = False
            bsgv.Columns("Answer3").Visible = False
        End If
        If bsgv.Columns("Answer4").Caption = "" Then
            bsgv.Columns("Answer4").ShowInCustomizationForm = False
            bsgv.Columns("Answer4").Visible = False
        End If
        If bsgv.Columns("Answer5").Caption = "" Then
            bsgv.Columns("Answer5").ShowInCustomizationForm = False
            bsgv.Columns("Answer5").Visible = False
        End If
        If bsgv.Columns("Answer6").Caption = "" Then
            bsgv.Columns("Answer6").ShowInCustomizationForm = False
            bsgv.Columns("Answer6").Visible = False
        End If
    End Sub


    Protected Sub EditDelegate_ClickCommand(sender As Object, e As CommandEventArgs)
        Dim nCandidateID As Integer = e.CommandArgument
        _ShowDetailView(nCandidateID)
    End Sub
    Protected Sub _ShowDetailView(ByVal nCandidateID As Integer)
        If nCandidateID >= 1 Then
            Session("dvCandidateID") = nCandidateID
            dsCandidate.SelectParameters("CandidateID").DefaultValue = nCandidateID
            fvDelegateDetails.ChangeMode(FormViewMode.Edit)
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalEditDel", "<script>$('#DelegateDetailModal').modal('show');</script>")
            '  Response.Redirect(_GetPageAndTab() & "&CID=" & nCandidateID.ToString())
        End If
    End Sub


    Protected Sub HideColumns(ByVal show As Boolean)
        bsgvCentreDelegates.Columns("Edit").Visible = Not show
        bsgvCentreDelegates.Columns("Status").Visible = Not show
    End Sub


    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As Bootstrap.BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            HideColumns(True)
            DelegateGridViewExporter.WriteXlsxToResponse()
            HideColumns(False)
        ElseIf e.Item.Name = "Register" Then
            fvDelegateDetails.ChangeMode(FormViewMode.Insert)
            Dim taCentres As New ITSPTableAdapters.CentresTableAdapter
            Dim tCentres As ITSP.CentresDataTable
            Dim nCentreID As Integer = CInt(Session("UserCentreID"))

            tCentres = taCentres.GetByCentreID(nCentreID)
            If tCentres.Count = 1 Then
                Dim drCentre As DataRow = tCentres.First ' convert to raw DataRow so we can get untyped access to fields
                LoadNewCandidateQuestionsAndOptions(drCentre)
            End If
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalRegisterDel", "<script>$('#DelegateRegisterModal').modal('show');</script>")
        ElseIf e.Item.Name = "DownloadDelegates" Then
            Dim taCandidates As New BulkImportTableAdapters.CandidatesBulkUploadTableAdapter
            Dim tblExport As New BulkImport.CandidatesBulkUploadDataTable
            tblExport = taCandidates.GetByCentreID(Session("UserCentreID"))
            Dim DS_Export As New DataSet("ITSP Delegates")
            DS_Export.Tables.Add(tblExport)
            XMLExport.ExportToExcel(DS_Export, "ITSP Delegates for Bulk Update " & CCommon.sCurrentDate & ".xlsx", Page.Response)
        ElseIf e.Item.Name = "JobGroupsList" Then
            Dim taJobGroups As New ITSPTableAdapters.JobGroupsTableAdapter
            Dim tJG As New ITSP.JobGroupsDataTable
            tJG = taJobGroups.GetByID()
            Dim DS_Export As New DataSet("ITSP Job Groups")
            DS_Export.Tables.Add(tJG)
            XMLExport.ExportToExcel(DS_Export, "ITSP Job Groups " & CCommon.sCurrentDate & ".xlsx", Page.Response)
        ElseIf e.Item.Name = "EnrolOnCourse" Then
            bsppEnrolOnCourse.ShowOnPageLoad = True
            bsppEnrolOnCourse2.ShowOnPageLoad = False
        ElseIf e.Item.Name = "SendWelcomeMsgs" Then
            bsgvWelcomeDelegates.DataBind()
            bsppSendWelcomes.ShowOnPageLoad = True
        End If
    End Sub
    Protected Sub detailGrid_DataSelect(sender As Object, e As EventArgs)
        Session("dvCandidateID") = TryCast(sender, BootstrapGridView).GetMasterRowKeyValue()
    End Sub
    'Protected Sub subDetailGrid_DataSelect(sender As Object, e As EventArgs)
    '    Session("dvCustomisationID") = TryCast(sender, BootstrapGridView).GetMasterRowKeyValue()
    '    fvProgDetail.DataBind()
    'End Sub
    'Protected Sub fvProgressDetail_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
    '    Dim fv As FormView = CType(sender, FormView)
    '    fvProgDetail = fv
    'End Sub

    Private Sub fvDelegateDetails_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvDelegateDetails.ItemUpdated
        bsgvCentreDelegates.DataBind()

        'Response.Redirect("delegates")

    End Sub

    Private Sub btnRegister_Click(sender As Object, e As EventArgs) Handles btnRegister.Click
        Dim sNewCandidateNumber As String = String.Empty
        Dim bSendLater As Boolean = False
        Dim d1 As Date = Date.Now()
        Dim d2 As Date = bsdeDeliverAfterReg.Date
        If d1 <= d2 Then
            bSendLater = True
        End If

        If Me.FirstNameTextBox.Text.Length = 0 Or Me.LastNameTextBox.Text.Length = 0 Then
            _RegisterError("First name and last name must not be empty.")
        ElseIf Me.AliasIDTextBox.Text.Contains(",") Then
            _RegisterError("Alias must not contain a comma.")
        ElseIf Me.FirstNameTextBox.Text.Contains(",") Then
            _RegisterError("First name must not contain a comma.")
        ElseIf Me.LastNameTextBox.Text.Contains(",") Then
            _RegisterError("Last name must not contain a comma.")
        Else
            Try
                sNewCandidateNumber = CCommon.SaveNewCandidate(CInt(Session("UserCentreID")),
                                         Me.FirstNameTextBox.Text,
                                         Me.LastNameTextBox.Text,
                                         CInt(Me.ddJobGroupInsert.SelectedValue),
                                         CBool(Me.ActiveCheckBox.Checked),
                                         GetAnswer(Me.txtAnswer1, Me.Answer1DropDown),
                                         GetAnswer(Me.txtAnswer2, Me.Answer2DropDown),
                                         GetAnswer(Me.txtAnswer3, Me.Answer3DropDown),
                                          GetAnswer(Me.txtAnswer4, Me.Answer4DropDown),
                                         GetAnswer(Me.txtAnswer5, Me.Answer5DropDown),
                                         GetAnswer(Me.txtAnswer6, Me.Answer6DropDown),
                                         Me.AliasIDTextBox.Text,
                                         True, Me.EmailAddressTextBox.Text, False, False, bsdeDeliverAfterReg.Date, bSendLater)
            Catch ex As CCommon.CandidateException
                If ex.Type = -3 Then
                    _RegisterError("The Alias is a duplicate. Please enter a unique Alias.")
                ElseIf ex.Type = -4 Then
                    _RegisterError("The email address is a duplicate. Please enter a unique email address.")
                Else
                    _RegisterError("Problem: " & ex.Message)
                End If
                Exit Sub
            Catch ex As Exception
                _RegisterError("Problem: " & ex.Message)
                Exit Sub
            End Try
            If Not sNewCandidateNumber = "-4" Then

                Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
                Dim nCandidateID As Integer = taq.GetCandidateIDFromNumber(sNewCandidateNumber)
                If EmailCheckBox.Checked And Not bSendLater Then
                    SendWelcomeEmail(nCandidateID, sNewCandidateNumber)
                ElseIf tbSetPassword.Text.Length > 6 Then
                    Dim taCandidates As New AuthenticateTableAdapters.CandidatesTableAdapter
                    taCandidates.SetPassword(Crypto.HashPassword(tbSetPassword.Text.Trim), nCandidateID)
                    lblModalMessage.Text = "The delegate's password has been set to <b>" & tbSetPassword.Text.Trim & "</b>. You should contact the delegate to inform them of their login details and recommend that they change their password using the <b>Application Selector / My Delegate Details</b> interface after login."
                    lblModalHeading.Text = "Delegate " & sNewCandidateNumber & " Registered"
                ElseIf Not bSendLater Then
                    lblModalMessage.Text = "The delegate has been registered but no welcome email has been sent. You can send the welcome e-mail at a later date from the <b>All Delegates</b> interface using the <b>Send Welcome Emails</b> button."
                    lblModalHeading.Text = "Delegate " & sNewCandidateNumber & " Registered"
                Else
                    lblModalMessage.Text = "A welcome message will be sent to the e-mail address provided, on the date specified, inviting the delegate to set their password and confirm their registration."
                    lblModalHeading.Text = "Delegate " & sNewCandidateNumber & " Registered"
                End If

                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#messageModal').modal('show');</script>")
                FirstNameTextBox.Text = ""
                LastNameTextBox.Text = ""
                'ddJobGroupInsert.SelectedIndex = 0
                ActiveCheckBox.Checked = True
                txtAnswer1.Text = ""
                txtAnswer2.Text = ""
                txtAnswer3.Text = ""
                txtAnswer4.Text = ""
                txtAnswer5.Text = ""
                txtAnswer6.Text = ""
                AliasIDTextBox.Text = ""
                EmailAddressTextBox.Text = ""
                EmailCheckBox.Checked = True
            End If

        End If

    End Sub
    Protected Sub SendWelcomeEmail(ByVal nCandidateID As Integer, ByVal sCandidateNumber As String)
        Dim sFrom As String = "Digital Learning Solutions Notifications <noreply@dls.nhs.uk>"
        Dim sSubject As String = "Welcome to Digital Learning Solutions - Verify your Registration"
        Dim sResetHash As String = (Guid.NewGuid()).ToString()
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        taq.SetPWResetHash(sResetHash, nCandidateID)
        'Setup and send a reset e-mail here:
        Dim taCand As New LearnMenuTableAdapters.CandidatesTableAdapter
        Dim tCand As New LearnMenu.CandidatesDataTable
        tCand = taCand.GetByCandidateID(nCandidateID)
        Dim sbBody As New StringBuilder
        Dim sPageName As String = My.Settings.MyURL
        sPageName = sPageName & "reset" & "?pwdr=" & sResetHash & "&email=" & tCand.First.EmailAddress
        sbBody.Append("<p>Dear " & tCand.First.FirstName & " " & tCand.First.LastName & ",</p>")
        sbBody.Append("<p>An administrator has registered your details to give you access to the Digital Learning Solutions (DLS) platform under the centre " & Session("UserCentreName") & ".</p>")
        sbBody.Append("<p>You have been assigned the unique DLS delegate number <b>" & sCandidateNumber & "</b>.</p>")
        sbBody.Append("<p>To complete your registration and access your Digital Learning Solutions content, please click <a href='" & sPageName & "'>this link</a>.</p>")
        sbBody.Append("<p>Note that this link can only be used once.</p>")
        sbBody.Append("<p>Please don't reply to this email as it has been automatically generated.</p>")
        If CCommon.SendEmail(tCand.First.EmailAddress, sSubject, sbBody.ToString(), True) Then
            lblModalMessage.Text = "A welcome message has been sent to the e-mail address provided for the candidate inviting them to set their password and confirm their registration."
            lblModalHeading.Text = "Delegate " & sCandidateNumber & " Registered"
        Else
            lblModalMessage.Text = "There was a problem sending an email to the address registered. Please contact the site administrators at it.skill@nhs.net for advice on resolving this."
            lblModalHeading.Text = "Delegate " & sCandidateNumber & " Registered"
        End If
    End Sub
    Protected Sub _RegisterError(ByVal sMessage As String, Optional sTitle As String = "User Registration Error")
        lblModalHeading.Text = sTitle
        lblModalMessage.Text = sMessage
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalConfirm", "<script>$('#messageModal').modal('show');</script>")
    End Sub
    Protected Sub LoadNewCandidateQuestionsAndOptions(ByRef drCentre As DataRow)
        '
        ' Set up the questions for new candidates
        '
        LoadQuestion(Me.lblAnswer1TextInsert, Me.txtAnswer1, drCentre("F1Name").ToString())
        LoadQuestion(Me.lblAnswer2TextInsert, Me.txtAnswer2, drCentre("F2Name").ToString())
        LoadQuestion(Me.lblAnswer3TextInsert, Me.txtAnswer3, drCentre("F3Name").ToString())
        LoadQuestion(Me.lblAnswer4TextInsert, Me.txtAnswer4, drCentre("F4Name").ToString())
        LoadQuestion(Me.lblAnswer5TextInsert, Me.txtAnswer5, drCentre("F5Name").ToString())
        LoadQuestion(Me.lblAnswer6TextInsert, Me.txtAnswer6, drCentre("F6Name").ToString())
        LoadQuestion(Me.lblAnswer1TextInsert, Me.Answer1DropDown, drCentre("F1Name").ToString())
        LoadQuestion(Me.lblAnswer2TextInsert, Me.Answer2DropDown, drCentre("F2Name").ToString())
        LoadQuestion(Me.lblAnswer3TextInsert, Me.Answer3DropDown, drCentre("F3Name").ToString())
        LoadQuestion(Me.lblAnswer4TextInsert, Me.Answer4DropDown, drCentre("F4Name").ToString())
        LoadQuestion(Me.lblAnswer5TextInsert, Me.Answer5DropDown, drCentre("F5Name").ToString())
        LoadQuestion(Me.lblAnswer6TextInsert, Me.Answer6DropDown, drCentre("F6Name").ToString())
        '
        ' The answers might be a text box or a list of options. If they are
        ' options then we need to change the text box to a drop-down.
        '
        LoadOptions(drCentre("F1Options").ToString(), Me.txtAnswer1, Me.Answer1DropDown)
        LoadOptions(drCentre("F2Options").ToString(), Me.txtAnswer2, Me.Answer2DropDown)
        LoadOptions(drCentre("F3Options").ToString(), Me.txtAnswer3, Me.Answer3DropDown)
        LoadOptions(drCentre("F4Options").ToString(), Me.txtAnswer4, Me.Answer4DropDown)
        LoadOptions(drCentre("F5Options").ToString(), Me.txtAnswer5, Me.Answer5DropDown)
        LoadOptions(drCentre("F6Options").ToString(), Me.txtAnswer6, Me.Answer6DropDown)
        '
        ' Set the mandatory status of custom fields for JS validation:
        '
        If drCentre("F1Mandatory") Then
            If drCentre("F1Options").ToString.Length > 0 Then
                hfField1Mand.Value = 2
            Else
                hfField1Mand.Value = 1
            End If

        End If
        If drCentre("F2Mandatory") Then
            If drCentre("F2Options").ToString.Length > 0 Then
                hfField2Mand.Value = 2
            Else
                hfField2Mand.Value = 1
            End If

        End If
        If drCentre("F3Mandatory") Then
            If drCentre("F3Options").ToString.Length > 0 Then
                hfField3Mand.Value = 2
            Else
                hfField3Mand.Value = 1
            End If

        End If
        If drCentre("F4Mandatory") Then
            If drCentre("F4Options").ToString.Length > 0 Then
                hfField4Mand.Value = 2
            Else
                hfField4Mand.Value = 1
            End If

        End If
        If drCentre("F5Mandatory") Then
            If drCentre("F5Options").ToString.Length > 0 Then
                hfField5Mand.Value = 2
            Else
                hfField5Mand.Value = 1
            End If

        End If
        If drCentre("F6Mandatory") Then
            If drCentre("F6Options").ToString.Length > 0 Then
                hfField6Mand.Value = 2
            Else
                hfField6Mand.Value = 1
            End If

        End If
    End Sub
    Protected Sub LoadEditCandidateQuestionsAndOptions(ByRef drCentre As DataRow)
        '
        ' Set up the questions for new candidates
        '
        Dim a1lbl As Label = fvDelegateDetails.FindControl("lblAnswer1TextEdit_U")
        Dim a2lbl As Label = fvDelegateDetails.FindControl("lblAnswer2TextEdit_U")
        Dim a3lbl As Label = fvDelegateDetails.FindControl("lblAnswer3TextEdit_U")
        Dim a4lbl As Label = fvDelegateDetails.FindControl("lblAnswer4TextEdit_U")
        Dim a5lbl As Label = fvDelegateDetails.FindControl("lblAnswer5TextEdit_U")
        Dim a6lbl As Label = fvDelegateDetails.FindControl("lblAnswer6TextEdit_U")
        Dim a1txt As TextBox = fvDelegateDetails.FindControl("txtAnswer1_U")
        Dim a2txt As TextBox = fvDelegateDetails.FindControl("txtAnswer2_U")
        Dim a3txt As TextBox = fvDelegateDetails.FindControl("txtAnswer3_U")
        Dim a4txt As TextBox = fvDelegateDetails.FindControl("txtAnswer4_U")
        Dim a5txt As TextBox = fvDelegateDetails.FindControl("txtAnswer5_U")
        Dim a6txt As TextBox = fvDelegateDetails.FindControl("txtAnswer6_U")

        Dim a1dd As DropDownList = fvDelegateDetails.FindControl("Answer1DropDown_U")
        Dim a2dd As DropDownList = fvDelegateDetails.FindControl("Answer2DropDown_U")
        Dim a3dd As DropDownList = fvDelegateDetails.FindControl("Answer3DropDown_U")
        Dim a4dd As DropDownList = fvDelegateDetails.FindControl("Answer4DropDown_U")
        Dim a5dd As DropDownList = fvDelegateDetails.FindControl("Answer5DropDown_U")
        Dim a6dd As DropDownList = fvDelegateDetails.FindControl("Answer6DropDown_U")
        LoadQuestion(a1lbl, a1txt, drCentre("F1Name").ToString())
        LoadQuestion(a2lbl, a2txt, drCentre("F2Name").ToString())
        LoadQuestion(a3lbl, a3txt, drCentre("F3Name").ToString())
        LoadQuestion(a4lbl, a4txt, drCentre("F4Name").ToString())
        LoadQuestion(a5lbl, a5txt, drCentre("F5Name").ToString())
        LoadQuestion(a6lbl, a6txt, drCentre("F6Name").ToString())
        LoadQuestion(a1lbl, a1dd, drCentre("F1Name").ToString())
        LoadQuestion(a2lbl, a2dd, drCentre("F2Name").ToString())
        LoadQuestion(a3lbl, a3dd, drCentre("F3Name").ToString())
        LoadQuestion(a4lbl, a4dd, drCentre("F4Name").ToString())
        LoadQuestion(a5lbl, a5dd, drCentre("F5Name").ToString())
        LoadQuestion(a6lbl, a6dd, drCentre("F6Name").ToString())
        '
        ' The answers might be a text box or a list of options. If they are
        ' options then we need to change the text box to a drop-down.
        '
        LoadOptions(drCentre("F1Options").ToString(), a1txt, a1dd, True)
        LoadOptions(drCentre("F2Options").ToString(), a2txt, a2dd, True)
        LoadOptions(drCentre("F3Options").ToString(), a3txt, a3dd, True)
        LoadOptions(drCentre("F4Options").ToString(), a4txt, a4dd, True)
        LoadOptions(drCentre("F5Options").ToString(), a5txt, a5dd, True)
        LoadOptions(drCentre("F6Options").ToString(), a6txt, a6dd, True)
        '
        ' Set the mandatory status of custom fields for JS validation:
        '
        Dim hf1 As HiddenField = fvDelegateDetails.FindControl("hfField1Mand_U")
        Dim hf2 As HiddenField = fvDelegateDetails.FindControl("hfField2Mand_U")
        Dim hf3 As HiddenField = fvDelegateDetails.FindControl("hfField3Mand_U")
        Dim hf4 As HiddenField = fvDelegateDetails.FindControl("hfField4Mand_U")
        Dim hf5 As HiddenField = fvDelegateDetails.FindControl("hfField5Mand_U")
        Dim hf6 As HiddenField = fvDelegateDetails.FindControl("hfField6Mand_U")
        If Not hf1 Is Nothing Then
            If drCentre("F1Mandatory") Then
                If drCentre("F1Options").ToString.Length > 0 Then
                    hf1.Value = 2
                Else
                    hf1.Value = 1
                End If

            End If
            If drCentre("F2Mandatory") Then
                If drCentre("F2Options").ToString.Length > 0 Then
                    hf2.Value = 2
                Else
                    hf2.Value = 1
                End If

            End If
            If drCentre("F3Mandatory") Then
                If drCentre("F3Options").ToString.Length > 0 Then
                    hf3.Value = 2
                Else
                    hf3.Value = 1
                End If

            End If
            If drCentre("F4Mandatory") Then
                If drCentre("F4Options").ToString.Length > 0 Then
                    hf4.Value = 2
                Else
                    hf4.Value = 1
                End If

            End If
            If drCentre("F5Mandatory") Then
                If drCentre("F5Options").ToString.Length > 0 Then
                    hf5.Value = 2
                Else
                    hf5.Value = 1
                End If

            End If
            If drCentre("F6Mandatory") Then
                If drCentre("F6Options").ToString.Length > 0 Then
                    hf6.Value = 2
                Else
                    hf6.Value = 1
                End If

            End If
        End If
    End Sub
    Protected Sub LoadQuestion(ByVal lblQuestion As Label, ByVal AnswerDropDown As Control,
                               ByVal sQuestion As String)
        If Not (lblQuestion Is Nothing Or AnswerDropDown Is Nothing) Then
            If sQuestion.Length = 0 Then
                lblQuestion.Visible = False
                AnswerDropDown.Visible = False
            Else
                lblQuestion.Visible = True
                AnswerDropDown.Visible = True
                lblQuestion.Text = sQuestion
            End If
        End If
    End Sub
    Protected Sub LoadOptions(ByRef sOptions As String, ByVal AnswerTextBox As TextBox, ByVal AnswerDropDown As DropDownList, Optional ByVal HideInsteadOfInvis As Boolean = False)
        '
        ' If there are no options then show the text box and hide the drop down.
        '
        If Not AnswerTextBox Is Nothing Then
            If AnswerTextBox.Visible Then       ' if the question exists
                If sOptions.Length = 0 Then
                    AnswerTextBox.Visible = True
                    If HideInsteadOfInvis Then
                        AnswerDropDown.CssClass = "d-none"
                    Else
                        AnswerDropDown.Visible = False
                    End If

                Else
                    If HideInsteadOfInvis Then
                        AnswerTextBox.CssClass = "d-none"
                    Else
                        AnswerTextBox.Visible = False
                    End If

                    AnswerDropDown.Visible = True
                    '
                    ' Parse the options and set up the drop-down list
                    '
                    AnswerDropDown.Items.Clear()
                    Dim lsOptions As String() = sOptions.Trim.Split(CChar(vbLf))

                    For Each sOption As String In lsOptions
                        AnswerDropDown.Items.Add(sOption.Trim())
                    Next
                End If
            End If
        End If
    End Sub
    Protected Sub LoadAnswers(ByRef AnswerDropDown As DropDownList, ByVal nWhich As Integer)
        '
        ' Always put in the default selection so that this will be the default
        ' entry selected. This is required even if the field is hidden so that the
        ' stored procedure that applies the filter knows to not filter on this field.
        '
        AnswerDropDown.Items.Clear()
        AnswerDropDown.Items.Add("[All answers]")
        '
        ' If the drop down has been hidden then there is no question so don't load the answers
        '
        If AnswerDropDown.Visible = False Then
            Return
        End If
        Dim taCandidatesAnswers As New ITSPTableAdapters.CandidatesAnswerTableAdapter
        Dim rsAnswers As ITSP.CandidatesAnswerDataTable
        Dim nCentreID As Integer = CInt(Session("UserCentreID"))

        Select Case nWhich
            Case 1
                rsAnswers = taCandidatesAnswers.GetAnswer1(nCentreID)
            Case 2
                rsAnswers = taCandidatesAnswers.GetAnswer2(nCentreID)
            Case 3
                rsAnswers = taCandidatesAnswers.GetAnswer3(nCentreID)
            Case 4
                rsAnswers = taCandidatesAnswers.GetAnswer4(nCentreID)
            Case 5
                rsAnswers = taCandidatesAnswers.GetAnswer5(nCentreID)
            Case Else
                rsAnswers = taCandidatesAnswers.GetAnswer6(nCentreID)
        End Select
        '
        ' Add data
        '
        For Each rowAnswer As ITSP.CandidatesAnswerRow In rsAnswers
            AnswerDropDown.Items.Add(rowAnswer.Answer)
        Next
    End Sub
    Protected Function GetAnswer(ByVal AnswerTextBox As TextBox, ByVal AnswerDropDown As DropDownList) As String
        If AnswerTextBox.Visible Then
            Return AnswerTextBox.Text
        Else
            Return AnswerDropDown.SelectedValue
        End If
    End Function
#Region "BulkUpload"


    Private Sub lbtBulkUpload_Click(sender As Object, e As EventArgs) Handles lbtBulkUpload.Click
        Dim fup As FileUpload = fupResource
        Dim nMaxKB As Integer = 5000             ' max KB size of file
        ' Make sure a file has been successfully uploaded
        If fup.PostedFile Is Nothing Or String.IsNullOrEmpty(fup.PostedFile.FileName) Or fup.PostedFile.InputStream Is Nothing Then
            _RegisterError("Please select an Excel file to upload (max " + nMaxKB.ToString() + "KB).", "Bulk Upload Failed")
            Exit Sub
        End If
        ' Make sure we are dealing with an Excel file:
        Dim sFilename As String = Path.GetFileName(fup.PostedFile.FileName)
        Dim sExtension As String = Path.GetExtension(fup.PostedFile.FileName).ToLower()
        If Not sExtension = ".xlsx" Then
            _RegisterError(sFilename + " is not a valid file format for bulk delegate uploads. Please select an Excel file to upload (max " + nMaxKB.ToString() + "KB).", "Bulk Upload Failed")
            Exit Sub
        End If
        ' See how big the file is. We don't process very large files:
        If fup.PostedFile.InputStream.Length = 0 Then
            _RegisterError(sFilename + " has nothing in it.", "Bulk Upload Failed")
            Exit Sub
        End If
        If fup.PostedFile.InputStream.Length > nMaxKB * 1024 Then
            _RegisterError(sFilename + " is too big. Maximum file size is " + nMaxKB.ToString() + "KB.", "Bulk Upload Failed")
            Exit Sub
        End If
        Dim fPath As String = Server.MapPath("~/tempfiles/")
        If Not Directory.Exists(fPath) Then
            Directory.CreateDirectory(fPath)
        End If
        fPath = fPath + sFilename
        fup.SaveAs(fPath)
        'Try processing the file:
        Try
            Dim wb As New XLWorkbook(fPath)
            Dim ws As IXLWorksheet = wb.Worksheet(1)
            Dim currentrow As IXLRow = ws.FirstRowUsed
            'Check the correct column headings are in place and move to row two if so:
            If currentrow.Cell(1).GetString() = "LastName" And currentrow.Cell(2).GetString() = "FirstName" And currentrow.Cell(3).GetString() = "DelegateID" And currentrow.Cell(4).GetString() = "AliasID" And currentrow.Cell(5).GetString() = "JobGroupID" And currentrow.Cell(6).GetString() = "Answer1" And currentrow.Cell(7).GetString() = "Answer2" And currentrow.Cell(8).GetString() = "Answer3" And currentrow.Cell(9).GetString() = "Answer4" And currentrow.Cell(10).GetString() = "Answer5" And currentrow.Cell(11).GetString() = "Answer6" And currentrow.Cell(12).GetString() = "Active" And currentrow.Cell(13).GetString() = "Approved" And currentrow.Cell(14).GetString() = "EmailAddress" Then
                currentrow = currentrow.RowBelow
            Else
                _RegisterError("<p>" & sFilename + " does not have the correct column headers on the first row.</p><p>Ensure that you have downloaded the template using the 'Download Centre Delegates for Bulk Upload' link before adding / amending delegates and uploading.", "Bulk Upload Failed")
                Exit Sub
            End If
            'Set up variables for processing
            Dim nNewCandidates As Integer = 0
            Dim nChangedCandidates As Integer = 0
            Dim nUnchangedCandidates As Integer = 0
            Dim nErrorCount As Integer = 0
            Dim sErrors As String = "<div class='alert alert-danger' role='alert'><p>The uploaded Excel worksheet contained the following errors:</p><ul>"
            Dim nLineNumber = 1
            'Start processing rows:
            While Not currentrow.IsEmpty
                'Do all the gubbins here!!!!:
                nLineNumber += 1
                'Get the mandatory fields from the current line:
                Dim sDelegateID As String = currentrow.Cell(3).GetString().Trim()
                Dim sAliasID As String = currentrow.Cell(4).GetString().Trim()
                Dim sLastName As String = currentrow.Cell(1).GetString().Trim()
                Dim sFirstName As String = currentrow.Cell(2).GetString().Trim()
                Dim sEmailAddress As String = currentrow.Cell(14).GetString().Trim()
                Dim sActive As String = currentrow.Cell(12).GetString()
                Dim bActive As Boolean
                Dim sApproved As String = currentrow.Cell(13).GetString()
                Dim bApproved As Boolean
                If Not IsNumeric(currentrow.Cell(5).GetString()) Then
                    nErrorCount += 1
                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Job group ID was not valid. Please ensure a valid Job Group ID number is provided (use the 'Download Job Groups and IDs' option for a list of valid IDs).</li>"
                ElseIf CInt(currentrow.Cell(5).GetString()) > 39 Or CInt(currentrow.Cell(5).GetString()) <= 0 Then
                    nErrorCount += 1
                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Job group ID was not between 1 and 34. Please ensure a valid Job Group ID number is provided (use the 'Download Job Groups and IDs' option for a list of valid IDs).</li>"
                ElseIf sLastName = "" Then
                    nErrorCount += 1
                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Last name was not provided. Last name is a required field and cannot be left blank.</li>"
                ElseIf sFirstName = "" Then
                    nErrorCount += 1
                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: First name was not provided. First name is a required field and cannot be left blank.</li>"
                    'ElseIf sEmailAddress = "" Then
                    '    nErrorCount += 1
                    '    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Email address was not provided. Email address is a required field and cannot be left blank.</li>"

                ElseIf Not Boolean.TryParse(sActive, bActive) Then
                    nErrorCount += 1
                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Active field could not be read. The Active field should contain 'True' or 'False'.</li>"
                ElseIf Not Boolean.TryParse(sApproved, bApproved) Then
                    nErrorCount += 1
                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Approved field could not be read. The Approved field should contain 'True' or 'False'.</li>"
                Else
                    'All tests passed, decide whether to insert or update:
                    Dim bMustCreate As Boolean = False
                    If sDelegateID <> String.Empty Or sAliasID <> String.Empty Then
                        '
                        ' Existing DelegateID or AliasID means we have to update the record.
                        ' If there are no changes we get a special return code
                        ' If the DelegateID is empty and AliasID is supplied but it doesn't
                        ' match an existing record then we have to create the candidate.
                        '
                        Dim nResult As Integer
                        Dim taSP As New BulkImportTableAdapters.SP
                        Dim nCandidateID As Integer
                        If sDelegateID.Length > 2 Then
                            nCandidateID = taSP.GetCandidateNumberFromID(sDelegateID, Session("UserCentreID"))
                        Else
                            nCandidateID = taSP.GetCandidateNumberFromID(sAliasID, Session("UserCentreID"))
                        End If
                        If nCandidateID < 1 Then
                            If sDelegateID.Length > 2 Then
                                nErrorCount += 1
                                sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: No existing delegate record was found with the DelegateID provided.</li>"
                            Else
                                bMustCreate = True
                            End If
                        Else
                            nResult = taSP.uspUpdateCandidate(
                                                                         nCandidateID,
                                                                         sFirstName,
                                                                         sLastName,
                                                                         CInt(currentrow.Cell(5).GetString().Trim()),
                                                                         currentrow.Cell(6).GetString().Trim(),
                                                                         currentrow.Cell(7).GetString().Trim(),
                                                                         currentrow.Cell(8).GetString().Trim(),
                                                                         currentrow.Cell(9).GetString().Trim(),
                                                                         currentrow.Cell(10).GetString().Trim(),
                                                                         currentrow.Cell(11).GetString().Trim(),
                                                                         sEmailAddress,
                                                                         sAliasID, bApproved,
                                                    bActive
                                        )
                            Select Case nResult
                                Case 0
                                    nChangedCandidates += 1
                                Case 1
                                    nUnchangedCandidates += 1
                                Case 2
                                    bMustCreate = True          ' AliasID didn't match anything, must be a new delegate
                    '
                    ' All of the following errors should have been picked up in 
                    ' the first pass of processing, but the database might have
                    ' changed since that. Give error messages with pass 2 code P2.
                    '
                                Case -1
                                    nErrorCount += 1
                                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Unexpected error when updating Delegate details.</li>"
                                'Throw New ApplicationException("Unexpected error when updating Delegate details (code P2).")
                                Case -2
                                    nErrorCount += 1
                                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Parameter error when updating Delegate details.</li>"
                                'Throw New ApplicationException("Parameter error when updating Delegate details (code P2).")
                                Case -3
                                    nErrorCount += 1
                                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: The AliasID is already in use by another delegate.</li>"
                                'Throw New ApplicationException("The AliasID is already in use by another delegate (code P2).")
                                Case -4
                                    nErrorCount += 1
                                    sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: The Email address is already in use by another delegate.</li>"




                            End Select
                        End If

                    End If
                    If bMustCreate Or (sDelegateID = String.Empty And sAliasID = String.Empty) Then
                        Dim nInsertResult As String = CCommon.SaveNewCandidate(CInt(Session("UserCentreID")),
                                             sFirstName,
                                             sLastName,
                                             CInt(currentrow.Cell(5).GetString().Trim()),
                                             bActive,
                                             currentrow.Cell(6).GetString().Trim(),
                                             currentrow.Cell(7).GetString().Trim(),
                                             currentrow.Cell(8).GetString().Trim(),
                                             currentrow.Cell(9).GetString().Trim(),
                                             currentrow.Cell(10).GetString().Trim(),
                                             currentrow.Cell(11).GetString().Trim(),
                                             sAliasID,
            bApproved,
                                             sEmailAddress, False, False, bsdeDeliverAfterDate.Date, cbEmailBulk.Checked, False)
                        Select Case nInsertResult
                            Case "-1"
                                nErrorCount += 1
                                sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Unexpected error trying to insert new delegate.</li>"
                            Case "-2"
                                nErrorCount += 1
                                sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: FirstName, LastName and JobGroupID are required. JobGroupID must be between 1 and 39.</li>"
                            Case "-3"
                                nErrorCount += 1
                                sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: AliasID already in use at Centre.</li>"
                            Case "-4"
                                nErrorCount += 1
                                sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: E-mail address already in use at Centre.</li>"
                            Case "-5"
                                nErrorCount += 1
                                sErrors = sErrors + "<li><b>Line " & nLineNumber.ToString() & "</b>: Email address was not provided for new candidate. Email address is a required field for new candidates and cannot be left blank.</li>"
                            Case Else
                                nNewCandidates += 1
                        End Select

                    End If
                End If

                'move to next row:
                currentrow = currentrow.RowBelow
            End While
            If nErrorCount > 0 Then
                sErrors = sErrors + "</ul><p>The lines listed above were skipped during processing.</p></div>"
            End If
            Dim sMessage As String = ""
            sMessage += "<p>Summary of results:</p><ul>"
            sMessage += "<li>" + (nLineNumber - 1).ToString + " lines processed.</li>"
            sMessage += "<li>" + nNewCandidates.ToString + " new delegates registered.</li>"
            sMessage += "<li>" + nChangedCandidates.ToString + " delegate records updated.</li>"
            sMessage += "<li>" + nUnchangedCandidates.ToString + " delegate records skipped (no changes).</li>"
            sMessage += "<li>" + nErrorCount.ToString + " lines skipped due to errors.</li></ul>"
            If nErrorCount > 0 Then
                sMessage += sErrors
            End If
            _RegisterError(sMessage, "Bulk Upload Complete")
        Catch ex As Exception

        End Try
    End Sub



    Private Sub fvDelegateDetails_DataBound(sender As Object, e As EventArgs) Handles fvDelegateDetails.DataBound
        If fvDelegateDetails.CurrentMode = FormViewMode.Edit Then
            Dim nCentreID As Integer = CInt(Session("UserCentreID"))
            Dim taCentres As New ITSPTableAdapters.CentresTableAdapter
            Dim tCentres As ITSP.CentresDataTable
            tCentres = taCentres.GetByCentreID(nCentreID)
            If tCentres.Count = 1 Then
                Dim drCentre As DataRow = tCentres.First ' convert to raw DataRow so we can get untyped access to fields
                LoadEditCandidateQuestionsAndOptions(drCentre)
            End If
            Dim fv As FormView = TryCast(sender, FormView)
            Dim txt1 As TextBox = fv.FindControl("txtAnswer1_U")
            Dim dd1 As DropDownList = fv.FindControl("Answer1DropDown_U")
            If Not txt1 Is Nothing And Not dd1 Is Nothing Then
                If Not dd1.Items.FindByText(txt1.Text) Is Nothing Then
                    dd1.SelectedValue = txt1.Text
                End If
            End If
            Dim txt2 As TextBox = fv.FindControl("txtAnswer2_U")
            Dim dd2 As DropDownList = fv.FindControl("Answer2DropDown_U")
            If Not txt2 Is Nothing And Not dd2 Is Nothing Then
                If Not dd2.Items.FindByText(txt2.Text) Is Nothing Then
                    dd2.SelectedValue = txt2.Text
                End If
            End If
            Dim txt3 As TextBox = fv.FindControl("txtAnswer3_U")
            Dim dd3 As DropDownList = fv.FindControl("Answer3DropDown_U")
            If Not txt3 Is Nothing And Not dd3 Is Nothing Then
                If Not dd3.Items.FindByText(txt3.Text) Is Nothing Then
                    dd3.SelectedValue = txt3.Text
                End If
            End If
            Dim txt4 As TextBox = fv.FindControl("txtAnswer4_U")
            Dim dd4 As DropDownList = fv.FindControl("Answer4DropDown_U")
            If Not txt4 Is Nothing And Not dd4 Is Nothing Then
                If Not dd4.Items.FindByText(txt4.Text) Is Nothing Then
                    dd4.SelectedValue = txt4.Text
                End If
            End If
            Dim txt5 As TextBox = fv.FindControl("txtAnswer5_U")
            Dim dd5 As DropDownList = fv.FindControl("Answer5DropDown_U")
            If Not txt5 Is Nothing And Not dd5 Is Nothing Then
                If Not dd5.Items.FindByText(txt5.Text) Is Nothing Then
                    dd5.SelectedValue = txt5.Text
                End If
            End If
            Dim txt6 As TextBox = fv.FindControl("txtAnswer6_U")
            Dim dd6 As DropDownList = fv.FindControl("Answer6DropDown_U")
            If Not txt6 Is Nothing And Not dd6 Is Nothing Then
                If Not dd6.Items.FindByText(txt6.Text) Is Nothing Then
                    dd6.SelectedValue = txt6.Text
                End If
            End If
        End If
    End Sub


    Protected Sub bsgvCandidateProgress_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If
        If e.GetValue("RemovedDate").ToString.Length > 0 Then
            e.Row.CssClass = "text-muted"
        End If
    End Sub

    Protected Sub lbtEnrolNext_Command(sender As Object, e As CommandEventArgs)
        Dim nCustID As Integer = 0

        For Each i As Object In bsgvCusomisationsAdd.GetSelectedFieldValues("CustomisationID")
            nCustID = CInt(i)
        Next

        If nCustID > 0 Then
            hfCustomisationID.Value = nCustID
            Dim taCust As New customiseTableAdapters.CustomisationsTableAdapter
            Dim tCust As New customise.CustomisationsDataTable
            tCust = taCust.GetData(nCustID)
            If tCust.Count > 0 Then
                tbCourseNameToAdd.Text = tCust.First.AppName & " - " & tCust.First.CustomisationName
                cbMandatory.Checked = tCust.First.Mandatory
                cbAutoRefresh.Checked = tCust.First.AutoRefresh
                spinCompleteWithinMonths.Number = tCust.First.CompleteWithinMonths
                spinValidityMonths.Number = tCust.First.ValidityMonths
                bsppEnrolOnCourse.ShowOnPageLoad = False
                bsppEnrolOnCourse2.ShowOnPageLoad = True
            End If

        End If
    End Sub

    Protected Sub lbtEnrolConfirm_Command(sender As Object, e As CommandEventArgs)
        Dim taProgress As New LearnMenuTableAdapters.uspCreateProgressRecordTableAdapter
        Dim nRes As Integer = taProgress.uspCreateProgressRecordWithCompleteWithinMonths(Session("dvCandidateID"), hfCustomisationID.Value, Session("UserCentreID"), 2, Session("UserAdminID"), spinCompleteWithinMonths.Number, ddSupervisor.SelectedValue)
        bsppEnrolOnCourse2.ShowOnPageLoad = False
        bsgvCentreDelegates.DataBind()
    End Sub

    Private Sub dsCandidate_Updated(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsCandidate.Updated
        Dim nRet As Integer = CInt(e.ReturnValue)
        If nRet < 0 Then
            If nRet = -3 Then
                _RegisterError("The Alias is a duplicate. Please enter a unique Alias.", "Update Error")
            ElseIf nRet = -4 Then
                _RegisterError("The record could not be updated. The email address is a duplicate. Please enter a unique email address.", "Update Error")
            Else
                _RegisterError("Unknown error", "Update Error")
            End If
        End If
    End Sub


    Protected Sub lbtManagePW_Command(sender As Object, e As CommandEventArgs)
        hfManagePWCandidateID.Value = e.CommandArgument
        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
        lblCandNum.Text = taq.GetCandidateNumberByID(e.CommandArgument)
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowManageModal", "<script>$('#manageModal').modal('show');</script>")
    End Sub

    Protected Sub lbtResendWelcome_Click(sender As Object, e As EventArgs)
        Dim nCandidateID As Integer = hfManagePWCandidateID.Value
        SendWelcomeEmail(nCandidateID, lblCandNum.Text)
        bsgvCentreDelegates.DataBind()
        lblModalHeading.Text = "Welcome Message Sent to Delegate " & lblCandNum.Text
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#messageModal').modal('show');</script>")
    End Sub

    'Protected Sub lbtClearPassword_Click(sender As Object, e As EventArgs)
    '    Dim nCandidateID As Integer = hfManagePWCandidateID.Value
    '    If nCandidateID > 0 Then
    '        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
    '        taq.ClearCandidatePassword(nCandidateID)
    '        lblModalMessage.Text = "The delegate's password has been cleared. They will need to use the  <b>Recover</b> facility to set a new password. Alternately, you can send them a 'Welcome' e-mail using the <b>Manage Password</b> modal with a link to set their password."
    '        lblModalHeading.Text = lblCandNum.Text & " Password Cleared"
    '        bsgvCentreDelegates.DataBind()
    '        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#messageModal').modal('show');</script>")
    '    End If
    'End Sub

    Protected Sub btnSetPW_Click(sender As Object, e As EventArgs)
        Dim nCandidateID As Integer = hfManagePWCandidateID.Value
        Dim taCandidates As New AuthenticateTableAdapters.CandidatesTableAdapter
        taCandidates.SetPassword(Crypto.HashPassword(tbSetPassword1.Text.Trim), nCandidateID)
        lblModalMessage.Text = "The delegate's password has been set to <b>" & tbSetPassword1.Text.Trim & "</b>. You should contact the delegate to inform them of their login details and recommend that they change their password using the <b>Application Selector / My Delegate Details</b> interface after login."
        lblModalHeading.Text = "Delegate " & lblCandNum.Text & " Password Changed"
        bsgvCentreDelegates.DataBind()
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#messageModal').modal('show');</script>")
    End Sub

    Protected Sub lbtPromoteToAdmin_Command(sender As Object, e As CommandEventArgs)
        hfCandidateID.Value = e.CommandArgument
        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
        tbUserEmail.Text = taq.GetEmailByCandidateID(e.CommandArgument)
        Dim taContractDash As New ITSPTableAdapters.ContractUsageDashTableAdapter
        Dim tCD As New ITSP.ContractUsageDashDataTable
        tCD = taContractDash.GetData(Session("UserCentreID"))
        If tCD.Count = 1 Then
            Dim cdr As ITSP.ContractUsageDashRow = tCD.First
            'Okay let's check limits and restrict controls accordingly
            'First CC Licences:
            If Not cbCCLicence.Checked Then
                If cdr.CCLicencesLimit > -1 And cdr.CCLicences >= cdr.CCLicencesLimit Then
                    'lock it!
                    cbCCLicence.Enabled = False
                    If cdr.CustomCoursesLimit > 0 Then
                        cbCCLicence.ToolTip = "All of your " & cdr.CustomCoursesLimit.ToString & " Content Creator licences are assigned"
                    Else
                        cbCCLicence.ToolTip = "No Content Creator licences at centre"
                    End If

                End If
            End If
            'Now trainers:
            If Not cbTrainer.Checked Then
                If cdr.TrainersLimit > -1 And cdr.Trainers >= cdr.TrainersLimit Then
                    cbTrainer.Enabled = False
                    If cdr.TrainersLimit > 0 Then
                        cbTrainer.ToolTip = "All of your " & cdr.TrainersLimit.ToString & " Trainer roles are assigned"
                    Else
                        cbTrainer.ToolTip = "No Trainer roles at centre"
                    End If
                End If
            End If
            'Now CMS admins:
            ddCMSRole.ToolTip = ""
            If Not ddCMSRole.SelectedValue = 1 Then
                If cdr.CMSAdministratorsLimit > -1 And cdr.CMSAdmins >= cdr.CMSAdministratorsLimit Then
                    For Each i As ListItem In ddCMSRole.Items
                        If i.Value = 1 Then
                            i.Enabled = False
                            ddCMSRole.ToolTip = "No free CMS admin roles at centre"
                        End If
                    Next
                End If

            End If
            'Finally CMS managers:
            If Not ddCMSRole.SelectedValue = 2 Then
                If cdr.CMSManagersLimit > -1 And cdr.CMSManagers >= cdr.CMSManagersLimit Then
                    For Each i As ListItem In ddCMSRole.Items
                        If i.Value = 2 Then
                            i.Enabled = False
                            ddCMSRole.ToolTip = ddCMSRole.ToolTip & "No free CMS manager roles at centre. "
                        End If
                    Next
                End If

            End If
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMessage", "<script>$('#promoteUserModal').modal('show');</script>")
    End Sub

    Protected Sub lbtPromoteToAdminSubmit_Command(sender As Object, e As CommandEventArgs)
        Dim nCandidateID As Integer = hfCandidateID.Value

        Dim taq As New AuthenticateTableAdapters.QueriesTableAdapter
        If taq.InsertAdminAccountFromDelegate(nCandidateID, ddCategory.SelectedValue, cbCentreAdmin.Checked, cbSupervisor.Checked, cbTrainer.Checked, ddCMSRole.SelectedValue, cbCCLicence.Checked) > 0 Then
            lblModalMessage.Text = "The delegate has been assigned the admin / supervisor / content manager permissions selected and will be able to access the appropriate areas of the DLS system next time they login."
            lblModalHeading.Text = "Delegate Account Elevated to Admin"
            bsgvCentreDelegates.DataBind()
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#messageModal').modal('show');</script>")
        End If

    End Sub

    Protected Sub bsdeDeliverAfterDate_Init(sender As Object, e As EventArgs)
        Dim bsde As BootstrapDateEdit = TryCast(sender, BootstrapDateEdit)
        bsde.MinDate = DateTime.Today()
        Dim dtFormat As String = "dd/MM/yyyy"
        bsde.Date = DateTime.Today()
        bsde.Text = DateTime.Today.ToString(dtFormat)
    End Sub

    Protected Sub lbtSendWelcomes_Command(sender As Object, e As CommandEventArgs)
        Dim bsgv As BootstrapGridView = bsgvWelcomeDelegates
        Dim taGD As New centrecandidatesTableAdapters.QueriesTableAdapter
        Dim nCandidates As Integer = 0
        For Each i As Object In bsgv.GetSelectedFieldValues("CandidateID")
            nCandidates += 1
            taGD.SendWelcomeEmail(i, bsdeSendWelcomeDeliverDate.Date)
        Next
        lblModalHeading.Text = "Delegate Welcome Emails Cued for Delivery"
        If nCandidates > 0 Then
            lblModalMessage.Text = "<p>All " + nCandidates.ToString() + " selected delegates have been sent an enrolment email due for delivery on or after the date specified.</p>"
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAdded", "<script>$('#messageModal').modal('show');</script>")
        bsppSendWelcomes.ShowOnPageLoad = False
    End Sub
End Class
#End Region