Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap
Imports DevExpress.Web.Data

Public Class delegategroups
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim taCentres As New ITSPTableAdapters.CentresTableAdapter
            Dim tCentres As ITSP.CentresDataTable
            Dim nCentreID As Integer = CInt(Session("UserCentreID"))
            Dim bsgv As BootstrapGridView = bsgvAddDelegates
            tCentres = taCentres.GetByCentreID(nCentreID)
            If tCentres.Count = 1 Then
                '
                ' Change the titles of the columns to reflect the questions
                '
                Dim drCentre As DataRow = tCentres.First ' convert to raw DataRow so we can get untyped access to fields

                Dim lColumns As Bootstrap.BootstrapGridViewColumnCollection = bsgv.Columns
                bsgv.Columns("Answer1").Caption = drCentre("F1Name").ToString()
                bsgv.Columns("Answer2").Caption = drCentre("F2Name").ToString()
                bsgv.Columns("Answer3").Caption = drCentre("F3Name").ToString()
                bsgv.Columns("Answer4").Caption = drCentre("F4Name").ToString()
                bsgv.Columns("Answer5").Caption = drCentre("F5Name").ToString()
                bsgv.Columns("Answer6").Caption = drCentre("F6Name").ToString()
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
        End If
    End Sub

    Private Sub bsgvGroups_BeforeGetCallbackResult(sender As Object, e As EventArgs) Handles bsgvGroups.BeforeGetCallbackResult
        Dim bsgv As BootstrapGridView = TryCast(sender, BootstrapGridView)
        If Not bsgv Is Nothing Then
            If bsgv.IsNewRowEditing Then
                bsgv.SettingsText.PopupEditFormCaption = "Add Group"
                bsgv.SettingsCommandButton.UpdateButton.Text = "Add"
            Else
                bsgv.SettingsText.PopupEditFormCaption = "Edit Group"
                bsgv.SettingsCommandButton.UpdateButton.Text = "Update"
            End If
        End If
    End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As Bootstrap.BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            GroupsGridViewExporter.WriteXlsxToResponse()
        ElseIf e.Item.Name = "AddDelegates" Then
            bsgvAddDelegates.DataBind()
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAddDels", "<script>$('#AddDelegatesModal').modal('show');</script>")
        ElseIf e.Item.Name = "AddCourse" Then
            bsgvCusomisationsAdd.DataBind()
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAddCourses", "<script>$('#AddCustomisationModal').modal('show');</script>")
        End If

    End Sub

    Private Sub lbtGenerateGroups_Click(sender As Object, e As EventArgs) Handles lbtGenerateGroups.Click
        Dim taq As New centrecandidatesTableAdapters.QueriesTableAdapter

        Dim nField As Integer = ddRegField.SelectedValue
        Dim sPrefix As String = ddRegField.SelectedItem.Text
        Dim nSkipped As Integer = 0
        Dim bSkip As Boolean = False
        Dim sGroupLabel As String
        If nField <> 4 Then
            Dim sOpts As String
            Dim ddFieldArray() As String
            sOpts = taq.GetCustomFieldOptions(nField, Session("UserCentreID"))
            ddFieldArray = sOpts.Split(New String() {vbCr & vbLf, vbLf}, StringSplitOptions.None)
            For Each ch In ddFieldArray
                bSkip = False

                If cbIncludePrefix.Checked Then
                    sGroupLabel = sPrefix & " - " & ch
                Else
                    sGroupLabel = ch
                End If
                If cbSkipDuplicates.Checked Then
                    If taq.CheckGroupExistsForCentre(Session("UserCentreID"), sGroupLabel) Then
                        nSkipped += 1
                        bSkip = True
                    End If
                End If
                If Not bSkip Then
                    taq.AddGroupAndDelegatesFromRegistrationField(Session("UserCentreID"), sGroupLabel, ch, 0, nField, cbSyncChanges.Checked, cbAddNew.Checked, cbAddExisting.Checked, Session("UserAdminID"))

                End If
            Next
        Else
            Dim taJG As New ITSPTableAdapters.JobGroupsTableAdapter
            Dim tJG As New ITSP.JobGroupsDataTable
            Dim nOptionID As Integer
            tJG = taJG.GetData()
            For Each r As DataRow In tJG.Rows
                bSkip = False
                nOptionID = r.Item("JobGroupID")
                sGroupLabel = r.Item("JobGroupName")
                If cbIncludePrefix.Checked Then
                    sGroupLabel = sPrefix & " - " & sGroupLabel
                End If
                If cbSkipDuplicates.Checked Then
                    If taq.CheckGroupExistsForCentre(Session("UserCentreID"), sGroupLabel) Then
                        nSkipped += 1
                        bSkip = True
                    End If
                End If
                If Not bSkip Then
                    taq.AddGroupAndDelegatesFromRegistrationField(Session("UserCentreID"), sGroupLabel, "", nOptionID, nField, cbSyncChanges.Checked, cbAddNew.Checked, cbAddExisting.Checked, Session("UserAdminID"))

                End If
            Next
        End If
        bsgvGroups.DataBind()
    End Sub
    Protected Sub detailGrid_DataSelect(sender As Object, e As EventArgs)
        Session("dvGroupID") = TryCast(sender, BootstrapGridView).GetMasterRowKeyValue()
    End Sub

    Protected Sub lbtDeleteGroup_Command(sender As Object, e As CommandEventArgs)
        Dim nGroupID As Integer = e.CommandArgument
        hfDeleteGroupID.Value = nGroupID
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowConfirmModal", "<script>$('#confirmDeleteGroupModal').modal('show');</script>")
    End Sub

    Private Sub lbtConfirmDeleteGroup_Click(sender As Object, e As EventArgs) Handles lbtConfirmDeleteGroup.Click
        Dim taq As New centrecandidatesTableAdapters.QueriesTableAdapter
        taq.CascadeDeleteGroupAndRelatedData(hfDeleteGroupID.Value, cbRemoveEnrollments.Checked)
        bsgvGroups.DataBind()
    End Sub

    Private Sub lbtConfirmAddDelegates_Click(sender As Object, e As EventArgs) Handles lbtConfirmAddDelegates.Click
        Dim bsgv As BootstrapGridView = bsgvAddDelegates
        Dim taGD As New centrecandidatesTableAdapters.GroupDelegatesTableAdapter
        Dim nEnrolled As Integer = 0
        Dim nCandidates As Integer = 0
        For Each i As Object In bsgv.GetSelectedFieldValues("CandidateID")
            nCandidates += 1
            nEnrolled += taGD.GroupDelegates_Add(i, Session("dvGroupID"), Session("UserAdminID"), Session("UserCentreID"))
        Next
        lblModalHeading.Text = "Delegates Added to Group"
        lblModalMessage.Text = "<p>The " + nCandidates.ToString + " selected  delegates have been added to the selected group.</p>"
        If nEnrolled > 0 Then
            lblModalMessage.Text += "<p>All delegates have been enrolled on the courses associated with this group (if they were not already). This resulted in " & nEnrolled & " new enrolments.</p>"
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAdded", "<script>$('#messageModal').modal('show');</script>")
        bsgvGroups.DataBind()
    End Sub

    Protected Sub bsgvGroupDelegates_Init(sender As Object, e As EventArgs)
        Dim bsgv As BootstrapGridView = TryCast(sender, BootstrapGridView)
        bsgv.DataBind()
    End Sub

    Private Sub bsgvCusomisationsAdd_SelectionChanged(sender As Object, e As EventArgs) Handles bsgvCusomisationsAdd.SelectionChanged
        Dim nCustID As Integer

        For Each i As Object In bsgvCusomisationsAdd.GetSelectedFieldValues("CustomisationID")
            nCustID = CInt(i)
        Next
        If nCustID > 0 Then

        End If
    End Sub

    Private Sub lbtNextAddCourse_Click(sender As Object, e As EventArgs) Handles lbtNextAddCourse.Click
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
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAddCourses2", "<script>$('#AddCustomisation2Modal').modal('show');</script>")
            End If
        Else
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAddCourses", "<script>$('#AddCustomisationModal').modal('show');</script>")
        End If
    End Sub

    Private Sub lbtAddCourseConfirm_Click(sender As Object, e As EventArgs) Handles lbtAddCourseConfirm.Click
        Dim taq As New centrecandidatesTableAdapters.QueriesTableAdapter
        Dim nEnrolled As Integer = taq.GroupCustomisation_Add(Session("dvGroupID"), hfCustomisationID.Value, Session("UserCentreID"), spinCompleteWithinMonths.Number, Session("UserAdminID"), cbCohortLearners.Checked, ddSupervisor.SelectedValue)
        lblModalHeading.Text = "Course Added to Group"
        lblModalMessage.Text = "<p>The course " & tbCourseNameToAdd.Text & " has been added to the selected group.</p>"
        If nEnrolled > 0 Then
            lblModalMessage.Text += "<p>All delegates already in the group have been enrolled on the course (if they were not already). This resulted in " & nEnrolled & " new enrolments.</p>"
        End If
        lblModalMessage.Text += "<p>All delegates subsequently added to the group will be enrolled on this course automatically.</p>"
        If spinCompleteWithinMonths.Number > 0 Then
            lblModalMessage.Text += "<p>All delegates enrolled on the course because they belong to this group will have " & spinCompleteWithinMonths.Number.ToString & " months to complete the course from the date of enrolment.</p>"
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAdded", "<script>$('#messageModal').modal('show');</script>")
        bsgvGroups.DataBind()
    End Sub

    Protected Sub lbtInactivateGroupCustomisation_Command(sender As Object, e As CommandEventArgs)
        Dim taGroupCust As New customiseTableAdapters.GroupCustomisationsTableAdapter
        taGroupCust.InactivateGroupCustomisation(e.CommandArgument)
        bsgvGroups.DataBind()
    End Sub

    Protected Sub bsgvGroupCustomisations_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If
        If e.GetValue("InactivatedDate").ToString.Length > 0 Then
            e.Row.CssClass = "text-muted"
            e.Row.ToolTip = "Group customisation inactivated " & e.GetValue("InactivatedDate").ToString()
        End If
    End Sub
End Class