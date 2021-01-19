Public Partial Class sco
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.Request.Item("tutpath") Is Nothing Then
            Dim sTrackerURL As String
            sTrackerURL = My.Settings.ITSPTrackingURL
            If Not sTrackerURL.EndsWith("/") Then
                sTrackerURL = sTrackerURL & "/"
            End If
            sTrackerURL = sTrackerURL & "tracker"
            hftrackurl.Value = sTrackerURL
            Dim sCustomisationID As String = Page.Request.Item("CustomisationID")
            If sCustomisationID Is Nothing Then
                sCustomisationID = "1"
            End If
            Dim sContentType As String = Page.Request.Item("Type")
            If sContentType Is Nothing Then
                sContentType = "learn"
            End If
            Dim sVersion As String = Page.Request.Item("Version")
            If sVersion Is Nothing Then
                sVersion = "2"
            End If
            Dim sSectionID As String = Page.Request.Item("SectionID")
            If sSectionID Is Nothing Then
                sSectionID = "3"
            End If
            Dim sCandidateID As String = Page.Request.Item("CandidateID")
            If sCandidateID Is Nothing Then
                sCandidateID = "4"
            End If
            Dim sTutorialID As String = Page.Request.Item("TutorialID")
            If sTutorialID Is Nothing Then
                sTutorialID = "0"
            End If
            Dim sProgressID As String = ""
            If Not Session("lmProgressID") Is Nothing Then
                sProgressID = Session("lmProgressID")
            Else
                Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
                sProgressID = taq.GetProgressID(CInt(sCandidateID), CInt(sCustomisationID))
            End If
            hfcandidate.Value = sCandidateID
            hfcustomisation.Value = sCustomisationID
            hfsection.Value = sSectionID
            hfversion.Value = sVersion
            hfprog.Value = sProgressID
            hfTutorialId.Value = sTutorialID
            hfContentType.Value = sContentType
            Dim sScript As String = "<script>"
            sScript = sScript + "$(document).ready(function() {"
            sScript = sScript + "Run.ManifestByURL('" & Page.Request.Item("tutpath")
            sScript = sScript + "', false);});</script>"
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "LoadSco", sScript)
        End If
    End Sub

End Class