Imports System.Globalization
Imports System.IO
Imports DevExpress.Web.Bootstrap

Public Class admin_resources
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub fvResource_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvResource.ItemCommand
        If e.CommandName = "UploadResource" Then
            Dim fPath As String = Server.MapPath("~/downloadfiles/")
            Dim fup As FileUpload
            Dim fName As String
            Dim tb As TextBox
            Dim tbSize As TextBox = fvResource.FindControl("tbFileSize")
            Dim tbDate As TextBox = fvResource.FindControl("tbAddedDate")
            fup = fvResource.FindControl("fupResource")
            tb = fvResource.FindControl("ResourceTextBox")
            tbSize.Text = fup.PostedFile.ContentLength
            Dim sDate As String = DateTime.Now.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture)
            tbDate.Text = sDate
            If Not Directory.Exists(fPath) Then
                Directory.CreateDirectory(fPath)
            End If
            fName = System.IO.Path.GetFileName(fup.PostedFile.FileName)
            fPath = fPath + fName
            fup.SaveAs(fPath)
            tb.Text = fName
        ElseIf e.CommandName = "Cancel" Then
            mvResources.SetActiveView(vResourcesList)
        End If
    End Sub



    Private Sub lbtAddNewResource_Click(sender As Object, e As EventArgs) Handles lbtAddNewResource.Click
        fvResource.ChangeMode(FormViewMode.Insert)
        mvResources.SetActiveView(vAddEditResource)
    End Sub

    Private Sub fvResource_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvResource.ItemInserted
        mvResources.SetActiveView(vResourcesList)
        bsgvDownloads.DataBind()
    End Sub

    Private Sub fvResource_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvResource.ItemUpdated
        mvResources.SetActiveView(vResourcesList)
        bsgvDownloads.DataBind()
    End Sub

    Private Sub fvResource_PreRender(sender As Object, e As EventArgs) Handles fvResource.PreRender
        If fvResource.CurrentMode = FormViewMode.Insert Then
            Dim cbActive As CheckBox = fvResource.FindControl("cbActive")
            cbActive.Checked = True
        End If
        Dim ta As New ITSPTableAdapters.DownloadsCatsTableAdapter
        Dim dt As New ITSP.DownloadCatsDataTable
        dt = ta.GetData()
        Dim sArray As String() = dt.Rows.OfType(Of DataRow)().[Select](Function(k) k(0).ToString()).ToArray()
        Dim sJSArray As String = String.Join(",", sArray)
        sJSArray = "'" & sJSArray.Replace(",", "','") & "'"
        Dim sJS As String = "$( function() {$('.auto-category').autocomplete({source: [" & sJSArray & "]});});"
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "autoCategory", "<script>" & sJS & "</script>")
    End Sub
    Protected Sub EditResource_Click(sender As Object, e As CommandEventArgs)
        Dim nDownloadID As Integer = CInt(e.CommandArgument)
        dsAddEditResource.SelectParameters(0).DefaultValue = nDownloadID
        fvResource.ChangeMode(FormViewMode.Edit)
        fvResource.DataBind()
        mvResources.SetActiveView(vAddEditResource)
    End Sub
    Protected Sub RemoveResource_Click(sender As Object, e As CommandEventArgs)
        Dim nDownloadID As Integer = CInt(e.CommandArgument)
        Dim fPath As String = Server.MapPath("~/downloadfiles/")
        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
        Dim fName As String = taq.GetFileNameForDownloadID(nDownloadID)
        If File.Exists(fPath + fName) Then
            File.Delete(fPath + fName)
        End If
        Dim taDL As New ITSPTableAdapters.DownloadsTableAdapter
        taDL.Delete(nDownloadID)
        bsgvDownloads.DataBind()
    End Sub
    'Private Sub lbtDownloadFAQs_Click(sender As Object, e As EventArgs) Handles lbtDownloadResources.Click
    '    HideColumns(True)
    '    DownloadsGridViewExporter.WriteXlsxToResponse()
    '    HideColumns(False)
    'End Sub
    Protected Sub HideColumns(ByVal show As Boolean)
        bsgvDownloads.Columns("Edit").Visible = Not show
        bsgvDownloads.Columns("Delete").Visible = Not show
    End Sub
    'Private Sub lbtClearFilters_Click(sender As Object, e As EventArgs) Handles lbtClearFilters.Click
    '    bsgvDownloads.FilterExpression = String.Empty
    '    bsgvDownloads.SearchPanelFilter = String.Empty
    'End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            HideColumns(True)
            DownloadsGridViewExporter.WriteXlsxToResponse()
            HideColumns(False)
        End If
    End Sub
End Class