Imports DevExpress.Web.Bootstrap

Public Class admin_adminusers
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub



    Private Sub fvEditUser_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvEditUser.ItemCommand
        If e.CommandName = "Cancel" Then
            mvAdminUsers.SetActiveView(vAdminUserList)
        End If
    End Sub

    Private Sub fvEditUser_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvEditUser.ItemUpdated
        bsgvAdminUsers.DataBind()
        mvAdminUsers.SetActiveView(vAdminUserList)
    End Sub

    Protected Sub EditUser_Click(sender As Object, e As CommandEventArgs)
        Dim nAdminID As Integer = CInt(e.CommandArgument)
        hfEditUserID.Value = nAdminID
        fvEditUser.DataBind()
        mvAdminUsers.SetActiveView(vEditAdminUser)
    End Sub
    Protected Sub InactivateUser_Click(sender As Object, e As CommandEventArgs)
        Dim nAdminID As Integer = CInt(e.CommandArgument)
        Dim taAdminUsers As New ITSPTableAdapters.AdminUsersTableAdapter
        Dim nRes As Integer = taAdminUsers.InactivateUserByID(nAdminID)
        If nRes = 1 Then
            lblModalHeading.Text = "User Inactivated"
            lblModalMessage.Text = "The user's account has been inactivated. They will no longer be able to login."
        ElseIf nRes = 2 Then
            lblModalHeading.Text = "Admin User Account Deleted"
            lblModalMessage.Text = "The user's account has been deleted because they have never logged in."
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalConfirm", "<script>$('#messageModal').modal('show');</script>")
        bsgvAdminUsers.DataBind()
    End Sub
    'Private Sub lbtDownloadAdminUsers_Click(sender As Object, e As EventArgs) Handles lbtDownloadAdminUsers.Click
    '    HideColumns(True)
    '    AdminUsersGridViewExporter.WriteXlsxToResponse()
    '    HideColumns(False)
    'End Sub
    Protected Sub HideColumns(ByVal show As Boolean)
        bsgvAdminUsers.Columns("Edit").Visible = Not show
        bsgvAdminUsers.Columns("Inactivate").Visible = Not show
    End Sub
    'Private Sub lbtClearFilters_Click(sender As Object, e As EventArgs) Handles lbtClearFilters.Click
    '    bsgvAdminUsers.FilterExpression = String.Empty
    '    bsgvAdminUsers.SearchPanelFilter = String.Empty
    'End Sub
    Protected Sub Unlock_Click(sender As Object, e As CommandEventArgs)
        Dim nAdminUserID As Integer = e.CommandArgument
        If nAdminUserID > 0 Then
            Dim taq As New ITSPTableAdapters.AdminUsersTableAdapter
            taq.ResetFailCount(nAdminUserID)
            bsgvAdminUsers.DataBind()
        End If
    End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            HideColumns(True)
            AdminUsersGridViewExporter.WriteXlsxToResponse()
            HideColumns(False)
        End If
    End Sub
End Class