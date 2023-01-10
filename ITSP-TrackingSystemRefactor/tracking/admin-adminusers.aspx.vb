Imports DevExpress.Web.Bootstrap

Public Class admin_adminusers
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub HideColumns(ByVal show As Boolean)
        bsgvAdminUsers.Columns("Edit").Visible = Not show
        bsgvAdminUsers.Columns("Inactivate").Visible = Not show
    End Sub

    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            HideColumns(True)
            AdminUsersGridViewExporter.WriteXlsxToResponse()
            HideColumns(False)
        End If
    End Sub
End Class