Partial Public Class centrelogo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '
        ' Connect to the database and bring back the image contents & MIME type for the specified centre
        '
        Dim CentresTA As New ITSPTableAdapters.CentresTableAdapter
        Dim tblCentres As ITSP.CentresDataTable = Nothing
        Dim nCentreID As Integer = 0
        Try
            '
            ' Check if there is a centre manager logged in
            '

            If Not Session("UserCentreID") Is Nothing Then
                nCentreID = Session("UserCentreID")
            ElseIf Not Page.Request.Item("centreid") Is Nothing Then
                nCentreID = Page.Request.Item("centreid")
            End If
            If nCentreID > 0 Then
                tblCentres = CentresTA.GetByCentreID(nCentreID)
            Else
                '
                ' If there are parameters check if we can get the centreID validated
                '
                If Not Page.Request.Item("id1") Is Nothing And
                   Not Page.Request.Item("id2") Is Nothing And
                   Not Page.Request.Item("id3") Is Nothing Then
                    Dim sCentreID As String = Page.Request.Item("id1")
                    Dim sCustomisationID As String = Page.Request.Item("id2")
                    Dim sSessionID As String = Page.Request.Item("id3")
                    nCentreID = CInt(sCentreID)
                    Dim nCustomisationID As Integer = CInt(sCustomisationID)
                    Dim nSessionID As Integer = CInt(sSessionID)

                    tblCentres = CentresTA.GetForSignature(nCentreID, nCustomisationID, nSessionID)
                End If
            End If

            '
            ' Did we get a table?
            '
            If Not tblCentres Is Nothing Then
                    If tblCentres.Count = 1 AndAlso
                       tblCentres.First.LogoWidth > 0 AndAlso
                       tblCentres.First.LogoHeight > 0 Then
                        Response.ContentType = tblCentres.First.LogoMimeType
                        Response.BinaryWrite(tblCentres.First.CentreLogo)
                        Response.End()

                    End If
                Else

                End If
        Catch ex As Exception

        End Try
    End Sub

End Class