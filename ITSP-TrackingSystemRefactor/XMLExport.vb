Imports DocumentFormat.OpenXml
Imports ClosedXML.Excel

Public Class XMLExport
    Public Shared Sub ExportToExcel(ByVal ds As DataSet, ByVal fn As String, ByVal response As HttpResponse)
        ' Uses the ClosedXML framework to output the dataset to an Excel Workbook
        Dim wb = New XLWorkbook
        wb.Worksheets.Add(ds)
        response.Clear()
        response.ContentType = "application/octet-stream"
        response.AddHeader("content-disposition", "attachment;filename=""" & fn & "")
        ' Flush the workbook to the Response.OutputStream
        Using memoryStream As New IO.MemoryStream()
            wb.SaveAs(memoryStream)
            response.AddHeader("Content-Length", memoryStream.Length.ToString())
            memoryStream.WriteTo(response.OutputStream)
            memoryStream.Close()
        End Using

        response.[End]()
    End Sub
End Class
