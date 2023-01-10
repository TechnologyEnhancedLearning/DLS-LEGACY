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

    Protected Sub HideColumns(ByVal show As Boolean)
        bsgvCentreDelegates.Columns("Edit").Visible = Not show
        bsgvCentreDelegates.Columns("Status").Visible = Not show
    End Sub


    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As Bootstrap.BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            HideColumns(True)
            DelegateGridViewExporter.WriteXlsxToResponse()
            HideColumns(False)
        ElseIf e.Item.Name = "EnrolOnCourse" Then
            bsppEnrolOnCourse.ShowOnPageLoad = True
            bsppEnrolOnCourse2.ShowOnPageLoad = False
        End If
    End Sub
    Protected Sub detailGrid_DataSelect(sender As Object, e As EventArgs)
        Session("dvCandidateID") = TryCast(sender, BootstrapGridView).GetMasterRowKeyValue()
    End Sub

#Region "BulkUpload"

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

End Class
#End Region