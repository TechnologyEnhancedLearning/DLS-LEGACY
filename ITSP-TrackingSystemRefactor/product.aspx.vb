Public Class product1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sProduct As String = TryCast(Page.Request.Item("product"), String)
        Dim taq As New prelogindataTableAdapters.QueriesTableAdapter
        Dim nProductID As Integer = taq.GetProductIDFromName(sProduct)
        If nProductID > 0 Then
            Session("plProductID") = nProductID
            product.DataBind()
        End If
    End Sub

End Class