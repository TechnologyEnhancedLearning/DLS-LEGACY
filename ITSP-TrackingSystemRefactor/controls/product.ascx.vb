Public Class product
    Inherits System.Web.UI.UserControl
    Public ReadOnly Property productid As Integer
        Get
            Return Session("plProductID")
        End Get
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        newstimeline.ProductID = productid
        quotes.ProductID = productid
    End Sub

End Class