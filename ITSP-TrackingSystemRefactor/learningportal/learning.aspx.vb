Public Class learningnt
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sCandidateID As String = Page.Request.Item("CandidateID")
        If sCandidateID Is Nothing Then
            sCandidateID = ""
        End If
        Dim sTrackerURL As String
        sTrackerURL = Request.Url.GetLeftPart(UriPartial.Authority) & Request.ApplicationPath
        If Not sTrackerURL.EndsWith("/") Then
            sTrackerURL = sTrackerURL & "/"
        End If
        sTrackerURL = sTrackerURL & "dummy.html"
        Dim lSWParams(10) As String

        lSWParams(1) = 0
        lSWParams(2) = 0
        lSWParams(3) = sCandidateID
        If Not Session("Fname") Is Nothing Then
            lSWParams(4) = Session("Fname")
        End If
        If Not Session("Lname") Is Nothing Then
            lSWParams(5) = Session("Lname")
        End If
        lSWParams(8) = sTrackerURL
        Dim sMoviePath As String = Page.Request.Item("tutpath")
        Dim sMovieW As Integer = CInt(Page.Request.Item("width"))
        Dim sMovieH As Integer = CInt(Page.Request.Item("height"))
        Me.LMMovie.Text = GetShockwaveObject(sMoviePath, lSWParams, sMovieW, sMovieH)
    End Sub
    Protected Shared Function GetShockwaveObject(ByVal sMoviePath As String, ByRef lSWParams() As String,
                                                                                        ByVal nWidth As Integer, ByVal nHeight As Integer) As String
        Dim sWidth As String = nWidth.ToString()
        Dim sHeight As String = nHeight.ToString()

        Dim nParam As Integer
        Dim sbParams As StringBuilder = New StringBuilder

        For nParam = 1 To 9
            If Not lSWParams(nParam) Is Nothing AndAlso lSWParams(nParam) <> "" Then
                sbParams.Append("<param name=""sw" & nParam.ToString() & """ value=""" & lSWParams(nParam) & """ /> ")
            End If
        Next

        Return "<!--[if IE]>" & vbCrLf &
                        "<object classid=""clsid:233C1507-6A77-46A4-9443-F871F945D258""" & vbCrLf &
                        "codebase = ""http://download.macromedia.com/pub/shockwave/cabs/director/sw.cab#version=11,5,0,593""" & vbCrLf &
                        "ID=""EITSMovie"" width=""" & sWidth & """ height=""" & sHeight & """>" & vbCrLf &
                        "<param name=""src"" value=""" & sMoviePath & """/>" & vbCrLf &
                        "<![endif]-->" & vbCrLf &
                        "<!--[if !IE]>-->" & vbCrLf &
                        "<object type=""application/x-director"" data=""" & sMoviePath & """ width=""" & sWidth & """ height=""" & sHeight & """ id=""EITSMovie"">" & vbCrLf &
                        "<!--<![endif]-->" & vbCrLf &
                        "<param name=""swRemote"" value=""swContextMenu='false' "" />" & vbCrLf &
                        "<param name=""swStretchStyle"" value=""meet"" />" & vbCrLf &
                        "<param name=""PlayerVersion"" value=""11"" />" & vbCrLf &
                        "<param name=""bgColor"" value=""#FFFFFF"" />" & vbCrLf &
                        sbParams.ToString() & vbCrLf &
                        "<p>" & vbCrLf &
                        "These learning materials require Shockwave to be installed." & vbCrLf &
                        "</p>" & vbCrLf &
                        "</object>"
    End Function
End Class