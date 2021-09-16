Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap
Public Class coursedelegates
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack() Then
            UpdateCourseDropDown()
        End If
        Dim taCentres As New ITSPTableAdapters.CentresTableAdapter
        Dim tCentres As ITSP.CentresDataTable
        Dim nCentreID As Integer = CInt(Session("UserCentreID"))

        tCentres = taCentres.GetByCentreID(nCentreID)
        If tCentres.Count = 1 Then
            SetupCustomFieldsForBSGV(bsgvDelegatesForCustomisation, tCentres.First)
        End If
    End Sub
    Private Sub UpdateCourseDropDown()
        Dim sCustomisationID As String = ""
        If Not Page.Request.Item("CustomisationID") Is Nothing Then
            sCustomisationID = Page.Request.Item("CustomisationID")
        End If
        Dim nCustomisationID As Integer
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        ddCustomisationSelector.Items.Clear()
        Dim liAll As New ListItem
        liAll.Text = "All"
        liAll.Value = "0"
        ddCustomisationSelector.Items.Add(liAll)
        Me.ddCustomisationSelector.DataBind()       ' load the courses
        If sCustomisationID.Length > 0 Then
            Try
                nCustomisationID = CInt(sCustomisationID)
                '
                ' Select that course.
                '
                Me.ddCustomisationSelector.SelectedValue = nCustomisationID
                Session("dvCustomisationID") = nCustomisationID
            Catch ex As Exception
                ' Response.Redirect(_GetPageAndTab())
            End Try
        Else
            '
            ' Otherwise use profile settings
            '
            Dim nSelection As Integer = Profile.GetValue("CentreCourse.SelectedCustomisation")
            Dim item As ListItem = ddCustomisationSelector.Items.FindByValue(nSelection)
            If item IsNot Nothing Then
                Me.ddCustomisationSelector.SelectedValue = nSelection
            End If
            Dim bActiveOnly As Boolean = Profile.GetValue("CentreCourse.Filter.Applied")
            cbActiveOnly.Checked = bActiveOnly
            Session("dvCustomisationID") = nSelection
            SetCourseNameVis()
        End If
    End Sub
    Protected Sub SetupCustomFieldsForBSGV(ByVal bsgv As BootstrapGridView, ByVal rCentre As ITSP.CentresRow)
        If Not rCentre Is Nothing Then
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
        End If

    End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            Dim grouping = bsgvDelegatesForCustomisation.GetGroupedColumns()
            For Each c In grouping
                bsgvDelegatesForCustomisation.UnGroup(c)
            Next
            If bsgvDelegatesForCustomisation.VisibleRowCount > 50000 Then
                DelegateGridViewExporter.WriteCsvToResponse()
                For Each c In grouping
                    bsgvDelegatesForCustomisation.GroupBy(c)
                Next
            Else
                For Each c In grouping
                    bsgvDelegatesForCustomisation.GroupBy(c)
                Next
                DelegateGridViewExporter.WriteXlsxToResponse()
            End If
        End If
    End Sub

    Private Sub ddCustomisationSelector_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddCustomisationSelector.SelectedIndexChanged
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        Session("dvCustomisationID") = ddCustomisationSelector.SelectedValue
        Profile.SetValue("CentreCourse.SelectedCustomisation", Me.ddCustomisationSelector.SelectedValue())
        SetCourseNameVis()
    End Sub
    Protected Sub SetCourseNameVis()
        If ddCustomisationSelector.SelectedValue = 0 Then
            bsgvDelegatesForCustomisation.Columns("CourseName").Visible = True
            bsgvDelegatesForCustomisation.Columns("CourseAnswer1").Visible = False
            bsgvDelegatesForCustomisation.Columns("CourseAnswer2").Visible = False
            bsgvDelegatesForCustomisation.Columns("CourseAnswer3").Visible = False
            bsgvDelegatesForCustomisation.Columns("Edit").Visible = False
            bsgvDelegatesForCustomisation.GroupBy(bsgvDelegatesForCustomisation.Columns("CourseName"))
        Else
            bsgvDelegatesForCustomisation.Columns("CourseName").Visible = False
            bsgvDelegatesForCustomisation.UnGroup(bsgvDelegatesForCustomisation.Columns("CourseName"))
            setCourseAnswerVis()
        End If
    End Sub
    Protected Sub setCourseAnswerVis()
        Dim nCustID As Integer = ddCustomisationSelector.SelectedValue
        Dim taCust As New customiseTableAdapters.CustomisationsTableAdapter
        Dim tCust As New customise.CustomisationsDataTable
        Dim rCust As customise.CustomisationsRow
        tCust = taCust.GetData(nCustID)
        Dim bCustFields As Boolean = False
        If tCust.Count = 1 Then
            rCust = tCust.First
            bsgvDelegatesForCustomisation.Columns("CourseAnswer1").Caption = rCust.CField1
            bsgvDelegatesForCustomisation.Columns("CourseAnswer2").Caption = rCust.CField2
            bsgvDelegatesForCustomisation.Columns("CourseAnswer3").Caption = rCust.CField3
            If bsgvDelegatesForCustomisation.Columns("CourseAnswer1").Caption = "" Then
                bsgvDelegatesForCustomisation.Columns("CourseAnswer1").ShowInCustomizationForm = False
                bsgvDelegatesForCustomisation.Columns("CourseAnswer1").Visible = False
            Else
                bsgvDelegatesForCustomisation.Columns("CourseAnswer1").ShowInCustomizationForm = True
                bsgvDelegatesForCustomisation.Columns("CourseAnswer1").Visible = True
                bCustFields = True
            End If
            If bsgvDelegatesForCustomisation.Columns("CourseAnswer2").Caption = "" Then
                bsgvDelegatesForCustomisation.Columns("CourseAnswer2").ShowInCustomizationForm = False
                bsgvDelegatesForCustomisation.Columns("CourseAnswer2").Visible = False
            Else
                bsgvDelegatesForCustomisation.Columns("CourseAnswer2").ShowInCustomizationForm = True
                bsgvDelegatesForCustomisation.Columns("CourseAnswer2").Visible = True
                bCustFields = True
            End If
            If bsgvDelegatesForCustomisation.Columns("CourseAnswer3").Caption = "" Then
                bsgvDelegatesForCustomisation.Columns("CourseAnswer3").ShowInCustomizationForm = False
                bsgvDelegatesForCustomisation.Columns("CourseAnswer3").Visible = False
            Else
                bsgvDelegatesForCustomisation.Columns("CourseAnswer3").ShowInCustomizationForm = True
                bsgvDelegatesForCustomisation.Columns("CourseAnswer3").Visible = True
                bCustFields = True
            End If
            If bCustFields Then
                bsgvDelegatesForCustomisation.Columns("Edit").Visible = True
            Else
                bsgvDelegatesForCustomisation.Columns("Edit").Visible = False
            End If
        End If
    End Sub

    Private Sub bsgvDelegatesForCustomisation_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs) Handles bsgvDelegatesForCustomisation.HtmlRowPrepared
        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If
        If e.GetValue("RemovedDate").ToString.Length > 0 Then
            e.Row.CssClass = "text-muted"
        End If
    End Sub

    Private Sub cbActiveOnly_CheckedChanged(sender As Object, e As EventArgs) Handles cbActiveOnly.CheckedChanged
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        Profile.SetValue("CentreCourse.Filter.Applied", Me.cbActiveOnly.Checked())
        UpdateCourseDropDown()
    End Sub

    Protected Sub lbtUnlock_Command(sender As Object, e As CommandEventArgs)
        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
        taq.UnlockProgress(e.CommandArgument)
        bsgvDelegatesForCustomisation.DataBind()
    End Sub

    Protected Sub EditCustFields_Command(sender As Object, e As CommandEventArgs)
        Dim taCF As New progressTableAdapters.ProgCustFieldAnswersTableAdapter
        Dim tCF As New progress.ProgCustFieldAnswersDataTable
        tCF = taCF.GetData(e.CommandArgument)
        If tCF.Count > 0 Then
            Dim rCF As progress.ProgCustFieldAnswersRow
            rCF = tCF.First
            hfCFProgressID.Value = e.CommandArgument
            lblCFMHeading.Text = "Edit Admin Fields for " & rCF.FirstName & " " & rCF.LastName & " (" & rCF.CandidateNumber & ")"
            If rCF.CField1.Length > 0 Then
                lblCustField1.Text = rCF.CField1
                If rCF.Q1Options.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(rCF.Q1Options, ddField1)
                    tbField1.Visible = False
                    ddField1.Visible = True
                    ddField1.SelectedValue = rCF.Answer1
                Else
                    tbField1.Visible = True
                    tbField1.Text = rCF.Answer1
                    ddField1.Visible = False
                End If
            Else
                pnlField1.Visible = False
            End If
            If rCF.CField2.Length > 0 Then
                lblCustField2.Text = rCF.CField2
                If rCF.Q2Options.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(rCF.Q2Options, ddField2)
                    tbField2.Visible = False
                    ddField2.Visible = True
                    ddField2.SelectedValue = rCF.Answer2
                Else
                    tbField2.Visible = True
                    tbField2.Text = rCF.Answer2
                    ddField2.Visible = False
                End If
            Else
                pnlField2.Visible = False
            End If
            If rCF.CField3.Length > 0 Then
                lblCustField3.Text = rCF.CField3
                If rCF.Q3Options.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(rCF.Q3Options, ddField3)
                    tbField3.Visible = False
                    ddField3.Visible = True
                    ddField3.SelectedValue = rCF.Answer3
                Else
                    tbField3.Visible = True
                    tbField3.Text = rCF.Answer3
                    ddField3.Visible = False
                End If
            Else
                pnlField3.Visible = False
            End If
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowCustFieldsModal", "<script>$('#customFieldModal').modal('show');</script>")
        End If
    End Sub

    Private Sub lbtSaveCustFields_Click(sender As Object, e As EventArgs) Handles lbtSaveCustFields.Click
        Dim taq As New progressTableAdapters.QueriesTableAdapter
        Dim a1 As String = ""
        Dim a2 As String = ""
        Dim a3 As String = ""
        If tbField1.Visible Then
            a1 = tbField1.Text
        ElseIf ddField1.Visible Then
            a1 = ddField1.SelectedValue.ToString
        End If
        If tbField2.Visible Then
            a2 = tbField2.Text
        ElseIf ddField2.Visible Then
            a2 = ddField2.SelectedValue.ToString
        End If
        If tbField3.Visible Then
            a3 = tbField3.Text
        ElseIf ddField3.Visible Then
            a3 = ddField3.SelectedValue.ToString
        End If
        taq.UpdateProgressAnswers(a1, a2, a3, hfCFProgressID.Value)
        bsgvDelegatesForCustomisation.DataBind()
    End Sub
End Class