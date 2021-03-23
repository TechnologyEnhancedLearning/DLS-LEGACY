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
        Dim sBrand As String = TryCast(Page.Request.Item("brand"), String)
        Dim taq As New prelogindataTableAdapters.QueriesTableAdapter
        Dim nBrandID As Integer = taq.GetBrandIDFromName(sBrand)
        If nBrandID > 0 Then
            Session("plBrandID") = nBrandID
            brand.DataBind()
        End If
    End Sub

End Class