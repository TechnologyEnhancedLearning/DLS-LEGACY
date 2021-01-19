Partial Public Class CEitsLM
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HttpContext.Current.Response.AddHeader("p3p", "CP=""IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT""")
        '
        ' Set up the parameters for the learning materials from the query string parameters
        '
        'ClientScript.RegisterStartupScript(Me.GetType(), "RefreshParent", "<script type='text/javascript'>var mpe = window.parent.document.getElementById('mpeLearning');</script>")
        Dim sCentreID As String = Page.Request.Item("CentreID")
        If sCentreID = "" Then
            sCentreID = 0
        End If
        If sCentreID > 0 Then
            Dim taCentre As New ITSPTableAdapters.CentresTableAdapter
            Dim tCtre As New ITSP.CentresDataTable
            tCtre = taCentre.GetByCentreID(CInt(sCentreID))
            If tCtre.First.Active = False Then
                Response.Redirect("~/CentreInactive")
            End If
        End If
        Dim sCustomisationID As String = Page.Request.Item("CustomisationID")
        If sCustomisationID Is Nothing Then
            sCustomisationID = ""
        End If
        Dim sVersion As String = Page.Request.Item("Version")
        If sVersion Is Nothing Then
            sVersion = ""
        End If
        Dim sSectionID As String = Page.Request.Item("SectionID")
        If sSectionID Is Nothing Then
            sSectionID = ""
        End If
        Dim sCandidateID As String = Page.Request.Item("CandidateID")
        If sCandidateID Is Nothing Then
            sCandidateID = ""
        End If
        Dim sTrackerURL As String
        sTrackerURL = My.Settings.ITSPTrackingURL
        If Not sTrackerURL.EndsWith("/") Then
            sTrackerURL = sTrackerURL & "/"
        End If
        sTrackerURL = sTrackerURL & "tracker"

        Dim lSWParams(10) As String

        lSWParams(1) = sCentreID
        lSWParams(2) = sCustomisationID
        lSWParams(3) = sCandidateID
        If Not Session("UserForename") Is Nothing Then
            lSWParams(4) = Session("UserForename")
        End If
        If Not Session("UserSurname") Is Nothing Then
            lSWParams(5) = Session("UserSurname")
        End If
        Dim sDiagObjs As String = Page.Request.Item("objlist")
        If Not sDiagObjs Is Nothing Then
            lSWParams(6) = sDiagObjs
        End If
        lSWParams(7) = sVersion
        lSWParams(8) = sTrackerURL
        lSWParams(9) = sSectionID
        '
        ' Get the path to the movie if customisation specified
        '
        Dim sMoviePath As String = "shockwave/nhselite.dcr"
        Dim tutMP As String = Page.Request.Item("tutpath")
        If Not tutMP Is Nothing Then
            sMoviePath = tutMP
        End If
        Dim sMovieW As Integer = 800
        Dim sMovieH As Integer = 600
        If sCustomisationID.Length > 0 Then
            Try
                Dim taApplications As New ITSPTableAdapters.ApplicationsTableAdapter
                Dim tApplications As ITSP.ApplicationsDataTable
                Dim sColor As String = "#446AA4"

                tApplications = taApplications.GetForCustomisation(CInt(sCustomisationID))
                If sMoviePath = "shockwave/nhselite.dcr" Then
                    sMoviePath = tApplications.First.MoviePath
                End If

                sMovieW = tApplications.First.hEmbedRes
                sMovieH = tApplications.First.vEmbedRes
                Dim AppG As Integer = tApplications.First.AppGroupID
                Select Case AppG

                    Case 1
                        sColor = "#3B1979"
                    Case 2
                        sColor = "#B5006A"
                    Case 3
                        sColor = "#11AF52"
                    Case 4
                        sColor = "#009DCA"
                End Select
                LMBody.Attributes("bgcolor") = sColor
            Catch ex As Exception
                '
                ' Leave path to movie as the default value
                '
            End Try
        End If
        '
        ' Set up LMs
        '
        Me.LMMovie.Text = CCommon.GetShockwaveObject(Session, sMoviePath, lSWParams, sMovieW, sMovieH)
    End Sub
  Public Function GetBG() As String
    Dim sColor As String = "#446AA4"
    Dim sCustomisationID As String = Page.Request.Item("CustomisationID")
        Dim taApplications As New ITSPTableAdapters.ApplicationsTableAdapter
        Dim tApplications As ITSP.ApplicationsDataTable
        If sCustomisationID.Length > 0 Then
      Try
        tApplications = taApplications.GetForCustomisation(CInt(sCustomisationID))
        Dim AppG As Integer = tApplications.First.AppGroupID
        Select Case AppG

          Case 1
            sColor = "#3B1979"
          Case 2
            sColor = "#B5006A"
          Case 3
            sColor = "#11AF52"
          Case 4
            sColor = "#009DCA"
        End Select
      Catch ex As Exception
        '
        ' Leave path to movie as the default value
        '
      End Try
    End If
        Return sColor
  End Function
End Class