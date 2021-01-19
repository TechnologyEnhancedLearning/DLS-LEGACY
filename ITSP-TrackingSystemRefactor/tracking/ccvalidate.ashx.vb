Imports System.Web
Imports System.Web.Services

Public Class ccvalidate
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim sn As String = context.Request.Item("sn")
        Dim username As String = context.Request.Item("username")
        Dim Version As String = context.Request.Item("version")

        Dim sReturnMessage As String = "Unknown error."
        Dim sReturnCode As String = "602"

        Dim taVal As New ITSPTableAdapters.ValidateCCSerialTableAdapter
        Dim tVal As New ITSP.ValidateCCSerialDataTable
        tVal = taVal.GetData(sn, username, Version)
        If tVal.Count > 0 Then
            sReturnCode = tVal.First.ValidationCode.ToString
            sReturnMessage = tVal.First.ValidationMessage
        End If
        context.Response.ContentType = "text/plain"
        If sReturnCode = "601" Then
            context.Response.Write(sReturnCode)
        Else
            context.Response.Write(sReturnCode & Environment.NewLine & sReturnMessage)
        End If


    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class