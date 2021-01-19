Public Class logout
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CCommon.AdminUserLogout()

        Page.Response.Redirect("~/home")
    End Sub

End Class