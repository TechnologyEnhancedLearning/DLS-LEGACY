Public Class pricing
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Function NiceBytes(ByVal nBytes As Long) As String
        Return CCommon.BytesToString(nBytes)
    End Function
End Class