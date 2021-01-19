Public Class GetFile
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Get the file id from the query string
        Dim id As Integer = Page.Request.Item("FileID")
        ' Get the source of the request
        If Not Page.Request.Item("src") Is Nothing Then
            Dim src As String = Page.Request.Item("src")
            Dim taf As New FilesDataTableAdapters.FileDataTableAdapter
            Dim tf As FilesData.FileDataDataTable = taf.GetData(id)
            If tf.Count = 1 Then
                Dim f As FilesData.FileDataRow = tf.First
                ' Check that the request is from a valid source before downloading the file:
                Dim nProgID As Integer = 0
                Select Case src
                    Case "learn"
                        nProgID = Session("lmProgressID")
                    Case "supervise"
                        nProgID = Session("TempProgressID")
                    Case "sfbsession"
                        If Session("SkypeMeetingID") > 0 Then
                            DownloadFile(f)
                        End If
                End Select
                If nProgID > 0 Then
                    Dim taQ As New FilesDataTableAdapters.QueriesTableAdapter

                    If f.CandidateID = taQ.GetCandidateIDFromProgressID(nProgID) Then
                        'Check passed, download the file:
                        DownloadFile(f)
                    End If
                End If
            End If
        Else
            Exit Sub
        End If

    End Sub
    Protected Sub DownloadFile(f As FilesData.FileDataRow)
        Dim name As String = f.FileName
        Dim contentType As String = f.FileType
        Dim data As Byte() = f.FileData
        ' Send the file to the browser
        Response.AddHeader("Content-type", contentType)
        Response.AddHeader("Content-Disposition", Convert.ToString("attachment; filename=") & name)
        Response.BinaryWrite(data)
        Response.Flush()
        Response.[End]()
    End Sub
End Class