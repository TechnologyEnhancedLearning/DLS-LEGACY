Public Class download
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '
        ' Connect to the database and get file required
        '
        Dim DownloadsTA As New ITSPTableAdapters.DownloadsTableAdapter
        Dim tblDownloads As ITSP.DownloadsDataTable = Nothing
        Dim iStream As System.IO.Stream = Nothing
        Try
            '
            ' What tag are they downloading?
            '
            If Page.Request.Item("content") Is Nothing Then
                Throw New ApplicationException("Content tag missing")
            End If
            Dim sTag As String = Page.Request.Item("content")
            '
            ' Check if we have a record for that tag?
            '
            tblDownloads = DownloadsTA.GetByTag(sTag)
            If tblDownloads.Count <> 1 Then
                Throw New ApplicationException("No download record found for tag " & sTag)
            End If
            '
            ' Check whether this file can be downloaded.
            '
            If tblDownloads.First.Active = False And Session("UserConfigAdmin") Is Nothing Then
                Throw New ApplicationException("File isn't Active so can't be downloaded - tag " & sTag)
            End If
            If tblDownloads.First.CentreManagers = True AndAlso Session("UserCentreID") Is Nothing Then
                Throw New ApplicationException("File is for Centre Managers only - tag " & sTag)
            End If
            Response.ContentType = tblDownloads.First.ContentType
            '
            ' Buffer to read 10K bytes in chunk:
            '
            Dim buffer(10000) As Byte
            Dim length As Integer
            Dim dataToRead As Long
            '
            ' Identify the file to download including its path.
            '
            Dim filepath As String = Server.MapPath("~/downloadfiles/" & tblDownloads.First.Filename)
            '
            ' Identify the file name.
            '
            Dim filename As String = System.IO.Path.GetFileName(filepath)
            '
            ' Open the file and get size
            '
            iStream = New System.IO.FileStream(filepath, System.IO.FileMode.Open,
                                                   IO.FileAccess.Read, IO.FileShare.Read)
            dataToRead = iStream.Length

            Response.ContentType = "application/octet-stream"
            Response.AddHeader("Content-Disposition", "attachment; filename=" & filename)
            Response.AddHeader("Content-Length", dataToRead.ToString)
            Response.BufferOutput = False
            '
            ' Read the bytes and send them in blocks. Don't keep on sending if the client 
            ' isn't connected any more.
            '
            While dataToRead > 0
                If Response.IsClientConnected Then
                    '
                    ' Read the data in buffer.
                    ' Write it out.
                    '
                    length = iStream.Read(buffer, 0, 10000)
                    Response.OutputStream.Write(buffer, 0, length)
                    '
                    ' Flush the data to the HTML output.
                    '
                    Response.Flush()

                    ReDim buffer(10000) ' Clear the buffer
                    dataToRead = dataToRead - length
                Else
                    dataToRead = -1             ' prevent infinite loop if user disconnects
                End If
            End While
            If dataToRead = 0 Then
                DownloadsTA.SetDLCount(tblDownloads.First.DLCount + 1, tblDownloads.First.DownloadID)
            End If
            Response.Close()
        Catch ex As Exception
            '
            ' Ignore errors where the remote host closed the connection. The error code is 0x800704CD.
            '
            If Not ex.Message().Contains("0x800704CD") Then
                '
                ' Log bad download request
                '
                'CCommon.LogErrorToDatabase(1, "404", ex.Message(), Request)
            End If
            '
            ' Give a 404 code. If content headers have been sent then this will fail, so just
            ' do nothing in that case.
            '
            Try
                Response.StatusCode = 404
                Response.SuppressContent = True
                Response.AddHeader("Content-Length", "0")
                HttpContext.Current.ApplicationInstance.CompleteRequest()
            Catch ex2 As Exception
            End Try

        Finally
            '
            ' Close the file if it's open
            '
            If IsNothing(iStream) = False Then
                iStream.Close()
            End If
        End Try
    End Sub

End Class