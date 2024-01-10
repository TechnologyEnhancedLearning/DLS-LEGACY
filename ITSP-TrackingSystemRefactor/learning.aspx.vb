Public Class learning
    Inherits System.Web.UI.Page
    Private Sub me_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        If Not Page.Request.Item("nonav") Is Nothing Then
            MasterPageFile = "~/nonav.Master"
        Else
            MasterPageFile = "~/Landing.Master"
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class