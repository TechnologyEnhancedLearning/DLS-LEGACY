Imports Google.Apis.Services
Imports Google.Apis.YouTube.v3
Imports System.Threading.Tasks

Public Class KnowledgeBank
    Inherits System.Web.UI.Page
    Protected Property preselectOffice As Boolean = False
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            preselectOffice = True
            divYouTube.Visible = Session("kbYouTube")
        End If
    End Sub
    Protected Function GetSelectedValuesFromListBox(lb As ListBox)
        Dim spParams As String = ""
        For Each lstItem As ListItem In lb.Items
            If lstItem.Selected Then
                If spParams <> "" Then
                    spParams += ","
                End If
                spParams += lstItem.Value
            End If
        Next
        Return spParams
    End Function
    Private Sub dsSearchResults_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsSearchResults.Selected
        If e.Exception Is Nothing Then
            Dim sCount As String = DirectCast(e.ReturnValue, DataTable).Rows.Count.ToString()
            If bstbSearchString.Text.Length > 0 Then
                'Log the search and retrieve SearchID as session variable:
                Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
                Dim nSearchID As Integer = taq.uspLogKnowledgeBankSearch(Session("learnCandidateID"), dsSearchResults.SelectParameters.Item(2).DefaultValue, dsSearchResults.SelectParameters.Item(3).DefaultValue, dsSearchResults.SelectParameters.Item(4).DefaultValue, bstbSearchString.Text, 0)
                Session("SearchID") = nSearchID
                lblSearchResultHeader.Text = "Search results"
                divAwol.Visible = True
            Else
                lblSearchResultHeader.Text = "Top rated"
                divAwol.Visible = False
            End If
            If sCount = "20" Then
                sCount = "20 +"
            End If
            lblSearchResultHeader.Text += " (" + sCount + " matches)"
        End If
    End Sub
    Protected Sub lbtClearFilters_Click(sender As Object, e As EventArgs) Handles lbtClearFilters.Click
        For Each li As ListItem In listBrand.Items
            li.Selected = False
        Next
        For Each li As ListItem In listCategory.Items
            li.Selected = False
        Next
        For Each li As ListItem In listTopic.Items
            li.Selected = False
        Next
        UpdateSearch()

    End Sub
    Protected Sub UpdateSearch()
        Dim sBrands As String = GetSelectedValuesFromListBox(listBrand)
        Dim sCategories As String = GetSelectedValuesFromListBox(listCategory)
        Dim sTopics As String = GetSelectedValuesFromListBox(listTopic)
        Dim ds As ObjectDataSource = dsSearchResults
        ds.SelectParameters.Item(2).DefaultValue = sBrands
        ds.SelectParameters.Item(3).DefaultValue = sCategories
        ds.SelectParameters.Item(4).DefaultValue = sTopics
        rptTopRated.DataBind()
    End Sub
    Private Sub lbtNotHappy_Click(sender As Object, e As EventArgs) Handles lbtNotHappy.Click
        If Not Session("SearchID") Is Nothing Then
            If Session("SearchID") > 0 Then
                Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
                taq.MarkSearchResultsInadequate(Session("SearchID"))
                Dim htmlModal As String =
                ScriptManager.RegisterClientScriptBlock(sender, sender.GetType(), "logAWOL", "window.onload=function(){doModal('Thank you for logging your search as unsatisfactory.<BR/>We will use this feedback to improve the knowledge bank for future users.');};", True)
            End If
        End If
    End Sub
    Private Sub rptTopRated_DataBinding(sender As Object, e As EventArgs) Handles rptTopRated.DataBinding, btnDontTube.Click
        YouTubeRes.Visible = False
        YouSearch.Visible = True
    End Sub
    Private Sub lbtSearch_Click(sender As Object, e As EventArgs) Handles lbtSearch.Click
        UpdateSearch()
    End Sub

    Protected Async Sub btnDoTube_Click(sender As Object, e As EventArgs)
        Dim task As Task(Of Data.SearchListResponse) = GetYoutubeREesults()
        Dim ds As New DataSet()
        Dim dt As New DataTable()
        dt.Columns.Add(New DataColumn("VideoName", GetType(String)))
        dt.Columns.Add(New DataColumn("VideoID", GetType(String)))
        dt.Columns.Add(New DataColumn("ThumbURL", GetType(String)))
        dt.Columns.Add(New DataColumn("Description", GetType(String)))
        dt.Columns.Add(New DataColumn("CandidateID", GetType(Integer)))
        Dim searchListResponse As Data.SearchListResponse = Await task
        For Each r In searchListResponse.Items
            Dim dr As DataRow = dt.NewRow()
            dr("VideoName") = r.Snippet.Title
            dr("VideoID") = r.Id.VideoId
            dr("ThumbURL") = r.Snippet.Thumbnails.Default__.Url
            dr("Description") = r.Snippet.Description
            dr("CandidateID") = Session("learnCandidateID")
            dt.Rows.Add(dr)
        Next
        rptYoutubeRes.DataSource = dt
        rptYoutubeRes.DataBind()
        YouSearch.Visible = False
        YouTubeRes.Visible = True
    End Sub
    'Private Async Sub Search()
    '    Try
    '        Await Run()
    '    Catch ex As Exception
    '        Console.WriteLine("Error: " & ex.Message)
    '    End Try
    'End Sub
    Private Async Function GetYoutubeREesults() As Task(Of Data.SearchListResponse)
        Dim sYTSearchString As String = ""
        Dim index As Integer = 0
        For Each item As ListItem In listCategory.Items
            index += 1
            If item.Selected Then
                sYTSearchString += " " + item.Text
            End If
        Next
        index = 0
        For Each item As ListItem In listTopic.Items
            index += 1
            If item.Selected Then
                sYTSearchString += " " + item.Text
            End If
        Next
        sYTSearchString += " " + bstbSearchString.Text
        lblSearchCriteria.Text = sYTSearchString
        Dim youtubeService = New YouTubeService(New BaseClientService.Initializer() With {
            .ApiKey = "AIzaSyChRVpjEZbrnmVhVcP_DebdexWPpmdgsBk",
            .ApplicationName = Me.[GetType]().ToString()
        })
        Dim searchListRequest = youtubeService.Search.List("snippet")
        searchListRequest.Q = sYTSearchString
        searchListRequest.MaxResults = 20
        searchListRequest.Type = "Video"
        searchListRequest.Execute()
        Dim searchListResponse As Data.SearchListResponse = Await searchListRequest.ExecuteAsync
        Return searchListResponse

    End Function
End Class