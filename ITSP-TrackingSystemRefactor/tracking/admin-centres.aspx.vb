Imports DevExpress.Web.Bootstrap

Public Class admin_centres
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub



    Private Sub dsCentreDetails_Updating(sender As Object, e As ObjectDataSourceMethodEventArgs) Handles dsCentreDetails.Updating
        Dim tbIP As TextBox = fvCentreDetails.FindControl("tbIPPrefix")
        If Not tbIP Is Nothing Then
            tbIP.Text = tbIP.Text.Trim()
        End If
    End Sub

    Private Sub fvCentreDetails_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvCentreDetails.ItemCommand
        If e.CommandName = "Cancel" Then
            mvCentres.SetActiveView(vCentreList)
        End If
    End Sub

    Private Sub fvCentreDetails_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvCentreDetails.ItemInserted
        bsgvCentres.DataBind()
        mvCentres.SetActiveView(vCentreList)
        lblModalHeading.Text = "Centre Added"
        lblModalMessage.Text = "Centre registered successfully."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalConfirm", "<script>$('#messageModal').modal('show');</script>")
    End Sub

    Private Sub fvCentreDetails_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvCentreDetails.ItemUpdated
        bsgvCentres.DataBind()
        mvCentres.SetActiveView(vCentreList)
        lblModalHeading.Text = "Centre Details Updated"
        lblModalMessage.Text = "Centre details updated successfully."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalConfirmUpdates", "<script>$('#messageModal').modal('show');</script>")
    End Sub



    Private Sub lbtAddCentre_Click(sender As Object, e As EventArgs) Handles lbtAddCentre.Click
        fvCentreDetails.ChangeMode(FormViewMode.Insert)
        mvCentres.SetActiveView(vCentreAddEdit)
    End Sub
    Protected Sub EditCentre_Click(sender As Object, e As CommandEventArgs)
        Dim nCentreID = CInt(e.CommandArgument)
        hfCentreID.Value = nCentreID
        fvCentreDetails.ChangeMode(FormViewMode.Edit)
        mvCentres.SetActiveView(vCentreAddEdit)
    End Sub
    Protected Sub InactivateCentre_Click(sender As Object, e As CommandEventArgs)
        Dim taq As New ITSPTableAdapters.CentresTableAdapter
    End Sub
    'Private Sub lbtClearFilters_Click(sender As Object, e As EventArgs) Handles lbtClearFilters.Click
    '    bsgvCentres.FilterExpression = String.Empty
    '    bsgvCentres.SearchPanelFilter = String.Empty
    'End Sub
    'Private Sub lbtDownloadDelegates_Click(sender As Object, e As EventArgs) Handles lbtDownloadDelegates.Click
    '    HideColumns(True)
    '    CentresGridViewExporter.WriteXlsxToResponse()
    '    HideColumns(False)
    'End Sub
    Protected Sub HideColumns(ByVal show As Boolean)
        bsgvCentres.Columns("Edit").Visible = Not show
        'bsgvCentres.Columns("Close").Visible = Not show
    End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            HideColumns(True)
            CentresGridViewExporter.WriteXlsxToResponse()
            HideColumns(False)
        End If
        If e.Item.Name = "ExcelExportAll" Then
            Dim lHideList As List(Of String) = ShowHiddenColumns()
            HideColumns(True)
            CentresGridViewExporter.WriteXlsxToResponse()
            HideColumns(False)
            ShowHideTheseColumns(lHideList, False)
        End If
    End Sub
    Protected Function ShowHiddenColumns() As List(Of String)
        Dim arHideList As New List(Of String)

        For Each c As DevExpress.Web.Internal.IWebGridColumn In bsgvCentres.Columns
            If Not c.Visible Then
                arHideList.Add(c.Name)
                c.Visible = True

            End If
        Next
        Return arHideList
    End Function
    Protected Sub ShowHideTheseColumns(ByVal hideList As List(Of String), ByVal show As Boolean)
        For Each s As String In hideList
            bsgvCentres.Columns(s).Visible = show
        Next
    End Sub
    Private Sub fvCentreDetails_ItemCreated(sender As Object, e As EventArgs) Handles fvCentreDetails.ItemCreated
        If fvCentreDetails.CurrentMode = FormViewMode.Insert Then
            Dim cb As CheckBox = fvCentreDetails.FindControl("cbAddCourses")
            If Not cb Is Nothing Then
                cb.Checked = True
            End If
        End If
    End Sub

    Protected Sub ddContractType_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddContractType As DropDownList = TryCast(sender, DropDownList)
        If Not ddContractType Is Nothing Then
            Dim taCT As New prelogindataTableAdapters.ContractTypesTableAdapter
            Dim tCT As New prelogindata.ContractTypesDataTable
            tCT = taCT.GetByContractTypeID(ddContractType.SelectedValue)
            If tCT.Count = 1 Then
                Dim tbCMSAdministrators As TextBox = fvCentreDetails.FindControl("tbCMSAdministrators")
                Dim tbCMSManagers As TextBox = fvCentreDetails.FindControl("tbCMSManagers")
                Dim tbCCLicences As TextBox = fvCentreDetails.FindControl("tbCCLicences")
                Dim tbCustomCourses As TextBox = fvCentreDetails.FindControl("tbCustomCourses")
                Dim tbTrainers As TextBox = fvCentreDetails.FindControl("tbTrainers")
                Dim ddServerSpaceBytes As DropDownList = fvCentreDetails.FindControl("ddServerSpaceBytes")
                tbCMSAdministrators.Text = tCT.First.CMSAdministratorsInc
                tbCMSManagers.Text = tCT.First.CMSManagersInc
                tbCCLicences.Text = tCT.First.CCLicencesInc
                tbCustomCourses.Text = tCT.First.CustomCoursesInc
                tbTrainers.Text = tCT.First.Trainers
                ddServerSpaceBytes.SelectedValue = tCT.First.ServerSpaceBytesInc
            End If
        End If
    End Sub
    Protected Function NiceBytes(ByVal lBytes As Long)
        Return CCommon.BytesToString(lBytes)
    End Function

    Protected Sub bsgvCentres_HeaderFilterFillItems(sender As Object, e As BootstrapGridViewHeaderFilterEventArgs)
        If e.Column.FieldName <> "ServerSpaceBytes" Then Return
        e.Values.Clear()
        e.AddValue("(ALL)", String.Empty)
        e.AddValue("0 GB", String.Empty, "[ServerSpaceBytes] = 0")
        e.AddValue("<10GB", String.Empty, "[ServerSpaceBytes] > 0 AND [ServerSpaceBytes] < 10737418240")
        e.AddValue("10-19GB", String.Empty, "[ServerSpaceBytes] >= 10737418240 AND [ServerSpaceBytes] < 21474836480")
        e.AddValue("20-29GB", String.Empty, "[ServerSpaceBytes] >= 21474836480 AND [ServerSpaceBytes] < 32212254720")
        e.AddValue(">=30GB", String.Empty, "[ServerSpaceBytes] > 32212254720")
    End Sub

    Protected Sub lbtUpdateSpaceUsage_Command(sender As Object, e As CommandEventArgs)
        CCommon.GetCentreServerSpaceUsage(e.CommandArgument, Server.MapPath("~/cms/CMSContent/"))
        bsgvCentres.DataBind()
    End Sub
End Class