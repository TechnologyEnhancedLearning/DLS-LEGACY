Public Class pricing
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
    Protected Function NiceBytes(ByVal nBytes As Long) As String
        Return CCommon.BytesToString(nBytes)
    End Function
    Public Function GetTarget() As String
        If MasterPageFile = "/nonav.Master" Then
            Return "_blank"
        Else
            Return "_self"
        End If
    End Function
End Class