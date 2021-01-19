Public Class cstories
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Function GetTruncatedString(ByVal sSource As String, ByVal MaxLength As Integer) As String
        Dim sReturn As String = CCommon.GetTruncatedString(sSource, MaxLength)
        Return sReturn
    End Function
End Class