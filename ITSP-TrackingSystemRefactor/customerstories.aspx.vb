Public Class customerstories
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Not Page.Request.Item("story") Is Nothing Then
            Dim sStory As String = TryCast(Page.Request.Item("Story"), String)
            Dim taq As New prelogindataTableAdapters.QueriesTableAdapter
            Dim nStoryID As Integer = taq.GetCaseStudyIDFromName(sStory)
            If nStoryID > 0 Then
                Session("plCaseStudyID") = nStoryID
                cstory.DataBind()
                mvStories.SetActiveView(vStory)
            End If
        Else
            mvStories.SetActiveView(vStories)
        End If
    End Sub

End Class