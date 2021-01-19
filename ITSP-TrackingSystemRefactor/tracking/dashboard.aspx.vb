Public Class dashboard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Session("MessagesShown") Is Nothing Then
                Session("MessagesShown") = False
            End If
            SetupRegions()
        End If
        Dim taq As New NotificationsTableAdapters.QueriesTableAdapter
        If Not Session("MessagesShown") Then
            If taq.GetNumberOfNotificationsForAU(Session("UserAdminID")) > 0 Then
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMessage", "<script>$('#messagesModal').modal('show');</script>")
                Session("MessagesShown") = True
            End If

        End If
        UpdateAll()
    End Sub
    Protected Sub UpdateAll()
        UpdateActivityChart()
        '
    End Sub
    Protected Sub UpdateActivityChart()
        Dim taRegComp As New ITSPStatsTableAdapters.uspGetRegCompNewTableAdapter
        Dim tRegComp As New ITSPStats.uspGetRegCompNewDataTable

        Dim strScript As StringBuilder = New StringBuilder()
        Try
            tRegComp = taRegComp.GetFilteredNew(3, -1, -1, -1, -1, -1, Session("UserCentreID"), -1, Session("AdminCategoryID"), Date.Now.AddYears(-1), Date.Now(), -1)
            If tRegComp.Rows.Count > 0 Then
                strScript.Append("<script type='text/javascript'>
                            google.charts.load('current', {'packages':['corechart']});
                            google.charts.setOnLoadCallback(drawUsageStats);
                            function drawUsageStats() {         
                            var data = google.visualization.arrayToDataTable([  
                            ['', 'Registrations', 'Completions', 'Evaluations'],")
                For Each row As DataRow In tRegComp.Rows
                    strScript.Append("[new Date(" & row("period").ToString & ")," & row("registrations").ToString & "," & row("completions").ToString & "," & row("evaluations").ToString & "],")
                Next

                strScript.Remove(strScript.Length - 1, 1)
                strScript.Append("]);")
                strScript.Append("
                                            var options = {
        animation:{ duration: 1000, easing: 'out', startup: true},
        explorer: {actions: ['dragToZoom', 'rightClickToReset'],
                    axis: 'horizontal',
                    keepInBounds: true
                    },
        chartArea: {'width': '95%', 'height': '80%'},
        legend: { position: 'bottom', textStyle: {fontSize:9}},
        hAxis: {slantedTextAngle:90,  textStyle: {color: '#333', fontSize:8}},
        vAxis: {textStyle: {color: '#333', fontSize:8}, minValue:0, viewWindow:{min:0}},
        pointSize: 3,
        curveType: 'function'
                };

               var chart = new google.visualization.LineChart(document.getElementById('activity-chart'));
                chart.draw(data, options);}")
                strScript.Append(" </script>")
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "usagechart", strScript.ToString())
            End If
        Catch ex As Exception

        Finally
            tRegComp.Dispose()
            strScript.Clear()
        End Try

    End Sub
    Protected Sub SetupRegions()
        '
        ' Add a catch-all setting first off
        '
        Dim li As New WebControls.ListItem("All", -1)

        Me.ddRegionID.ClearSelection()
        li.Selected = True
        Me.ddRegionID.Items.Add(li)

        Dim taRegions As New ITSPTableAdapters.RegionsTableAdapter
        Dim tblRegions As ITSP.RegionsDataTable

        tblRegions = taRegions.GetData()
        For Each rowRegion As ITSP.RegionsRow In tblRegions
            li = New WebControls.ListItem(rowRegion.RegionName, rowRegion.RegionID)
            li.Selected = False
            Me.ddRegionID.Items.Add(li)
        Next
    End Sub

    Private Sub gridviewTopTenList_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gridviewTopTenList.RowDataBound
        If e.Row.Cells.Count > 0 Then
            If Not Session("UserSummaryReports") Then
                e.Row.Cells(2).CssClass = "hidden"
            End If
        End If
    End Sub

    Protected Sub UpdateCentreRanking()
        '
        ' Show the ranking for this centre
        '
        Dim taCentreRank As New ITSPStatsTableAdapters.uspGetCentreRankTableAdapter
        Dim tRank As ITSPStats.uspGetCentreRankDataTable
        Dim sRankMsg As String

        tRank = taCentreRank.GetData(Session("UserCentreID"), Me.ddDaysBack.SelectedValue)
        If tRank.Count = 0 Then
            sRankMsg = "Your centre overall rank: no activity"
        Else
            sRankMsg = "Your centre overall rank: " & tRank.First.Rank.ToString
            If CBool(Session("UserSummaryReports")) Then
                sRankMsg = sRankMsg & " (score " & tRank.First.Count.ToString & ")"
            End If
        End If
        Me.lblCentreRanking.Text = sRankMsg
    End Sub

    Private Sub gridviewTopTenList_DataBound(sender As Object, e As EventArgs) Handles gridviewTopTenList.DataBound
        UpdateCentreRanking()
    End Sub
    Protected Sub Acknowledge_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        Session("MessagesShown") = False
        Dim nNotID As Integer = e.CommandArgument
        Dim nAdminID As Integer = Session("UserAdminID")
        Dim taNots As New NotificationsTableAdapters.SANotificationAcknowledgementsTableAdapter
        taNots.InsertQuery(nNotID, nAdminID)
        bscvMessages.DataBind()
    End Sub
    Protected Sub CloseMsgs_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        Session("MessagesShown") = True
    End Sub
    Protected Function NiceBytes(ByVal lBytes As Long) As String
        Return CCommon.BytesToString(lBytes)
    End Function

End Class