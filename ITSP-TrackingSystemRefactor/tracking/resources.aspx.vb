Imports System.IO

Public Class resources
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Function Numeric2Bytes(ByVal b As Long) As String
        Dim bSize(3) As String
        Dim i As Integer

        bSize(0) = "bytes"
        bSize(1) = "KB" 'Kilobytes
        bSize(2) = "MB" 'Megabytes
        bSize(3) = "GB" 'Gigabytes

        b = CDbl(b) ' Make sure var is a Double (not just variant)
        For i = UBound(bSize) To 0 Step -1
            If b >= (1024 ^ i) Then
                If i = 0 Then
                    Return CInt(b).ToString() & " " & bSize(i)
                Else
                    Return ThreeNonZeroDigits(b / (1024 ^ i)) & " " & bSize(i)
                End If
            End If
        Next
        Return "0 Bytes"
    End Function
    Private Function ThreeNonZeroDigits(ByVal value As Double) As String
        If value >= 100 Then
            ' No digits after the decimal.
            Return Format$(CInt(value))
        ElseIf value >= 10 Then
            ' One digit after the decimal.
            Return Format$(value, "0.0")
        Else
            ' Two digits after the decimal.
            Return Format$(value, "0.00")
        End If
    End Function
    Protected Function GetIconClass(ByVal sFileName As String) As String
        Dim sReturnClass As String = "fas fa-file-export-file"
        Dim sExt As String = Path.GetExtension(sFileName)
        Select Case sExt
            Case ".xls", ".xlsx", ".xlt", ".xltx"
                sReturnClass = "icon-excel"
            Case ".doc", ".docx", ".dot", ".dotx"
                sReturnClass = "icon-word"
            Case ".ppt", ".pptx", ".potx", ".pot"
                sReturnClass = "icon-powerpoint"
            Case ".zip"
                sReturnClass = "icon-zip"
            Case ".mp4", ".avi", ".wmv"
                sReturnClass = "icon-video"
            Case ".png", ".jpg", ".jpeg", ".bmp"
                sReturnClass = "icon-image"
            Case ".mp3"
                sReturnClass = "icon-audio"
            Case ".pdf"
                sReturnClass = "icon-pdf"
            Case ".exe", ".msi"
                sReturnClass = "icon-exe"
            Case ".pub", ".pubx"
                sReturnClass = "icon-publisher"
        End Select
        Return sReturnClass
    End Function
End Class