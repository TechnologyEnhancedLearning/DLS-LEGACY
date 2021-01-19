Public Class statsdetail
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub vOverallStats_Activate(sender As Object, e As EventArgs) Handles vOverallStats.Activate
        clearClasses()
        lbtUsageTab.Attributes.Add("class", "nav-link active")
        BindOverallActivityChart()
    End Sub
    Private Sub BindOverallActivityChart()
        Dim strScript As StringBuilder = New StringBuilder()
        Dim taCompsByGroup As New ITSPStatsTableAdapters.CompsByGroupTableAdapter
        Dim tCompByGroup As New ITSPStats.CompsByGroupDataTable
        tCompByGroup = taCompsByGroup.GetData()
        If tCompByGroup.Rows.Count > 0 Then
            Try
                strScript.Append("<script type='text/javascript'>
                    google.charts.load('current', {'packages':['corechart']});
                    google.charts.setOnLoadCallback(drawOverallStats);
                    function drawOverallStats() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['', 'Registrations', 'Completions'],")
                For Each row As DataRow In tCompByGroup.Rows
                    strScript.Append("['" & row("appgroup").ToString & "'," & row("registrations").ToString & "," & row("completions").ToString & "],")
                Next

                strScript.Remove(strScript.Length - 1, 1)
                strScript.Append("]);")
                strScript.Append("
                                    var options = {

colors: ['#0b62a4', '#7a92a3'],
animation:{ duration: 1000, easing: 'out', startup: true},
explorer: {actions: ['dragToZoom', 'rightClickToReset'],
            axis: 'horizontal',
            keepInBounds: true
            },
 chartArea: {'width': '90%', 'height': '80%'},
legend: { position: 'bottom', textStyle: {fontSize:9}},
hAxis: {slantedTextAngle:90,  textStyle: {color: '#333', fontSize:8}},
vAxis: {textStyle: {color: '#333', fontSize:8}, minValue:0, viewWindow:{min:0}},
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('activity-by-level'));
        chart.draw(data, options);}")
                strScript.Append(" </script>")
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "activitychart", strScript.ToString())
            Catch ex As Exception

            Finally
                tCompByGroup.Dispose()
                strScript.Clear()
            End Try
        End If
    End Sub
    Protected Sub clearClasses()
        lbtUsageTab.Attributes.Remove("class")
        lbtUsageTrend.Attributes.Remove("class")
        lbtEvaluationTab.Attributes.Remove("class")
        lbtHelpDeskTab.Attributes.Remove("class")
        lbtDigitalCapabilityTab.Attributes.Remove("class")
        lbtUsageTab.Attributes.Add("class", "nav-link")
        lbtUsageTrend.Attributes.Add("class", "nav-link")
        lbtEvaluationTab.Attributes.Add("class", "nav-link")
        lbtHelpDeskTab.Attributes.Add("class", "nav-link")
        lbtDigitalCapabilityTab.Attributes.Add("class", "nav-link")
    End Sub

    Private Sub vUsageChart_Activate(sender As Object, e As EventArgs) Handles vUsageChart.Activate
        clearClasses()
        lbtUsageTrend.Attributes.Add("class", "nav-link active")
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        Dim taQ As New ITSPTableAdapters.QueriesTableAdapter
        Dim dStart As Date
        Dim dEnd As Date = Date.Now()
        If Profile.GetValue("CentreReports.tbStartDate") = "" Then

            dStart = taQ.getFirstCentreDelegateLoginDate(CInt(Session("UserCentreID")))
            tbStartDate.Text = dStart.Date.ToShortDateString()
        Else
            tbStartDate.Text = Profile.GetValue("Reports.tbStartDate")
            dStart = Date.Parse(Profile.GetValue("Reports.tbStartDate"))
        End If
        tbEndDate.Text = dEnd.Date.ToShortDateString()

        SetupDropDowns()
        Me.ddRegionID.SelectedValue = Profile.GetValue("Reports.ddRegion")
        Dim item As ListItem = ddApplicationID.Items.FindByValue(Profile.GetValue("Reports.ddApplication"))
        If item IsNot Nothing Then
            Me.ddApplicationID.SelectedValue = Profile.GetValue("Reports.ddApplication")
        End If
        item = ddJobGroupID.Items.FindByValue(Profile.GetValue("Reports.ddJobGroupID"))
        If item IsNot Nothing Then
            Me.ddJobGroupID.SelectedValue = Profile.GetValue("Reports.ddJobGroupID")
        End If
        Me.ddAssessed.SelectedValue = Profile.GetValue("Reports.ddAssessed")
        item = ddCourseCategory.Items.FindByValue(Profile.GetValue("Reports.ddCourseGroup"))
        If item IsNot Nothing Then
            Me.ddCourseCategory.SelectedValue = Profile.GetValue("Reports.ddCourseGroup")
        End If
        item = ddCentreType.Items.FindByValue(Profile.GetValue("Reports.ddCentreType"))
        If item IsNot Nothing Then
            Me.ddCentreType.SelectedValue = Profile.GetValue("Reports.ddCentreType")
        End If
        item = ddCoreContent.Items.FindByValue(Profile.GetValue("Reports.ddCoreContent"))
        If item IsNot Nothing Then
            Me.ddCoreContent.SelectedValue = Profile.GetValue("Reports.ddCoreContent")
        End If
        'Show the activity graph:
        UpdateActivityChart()
    End Sub

    Private Sub vEvaluation_Activate(sender As Object, e As EventArgs) Handles vEvaluation.Activate
        clearClasses()
        lbtEvaluationTab.Attributes.Add("class", "nav-link active")
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        Dim taQ As New ITSPTableAdapters.QueriesTableAdapter
        Dim dStart As Date
        Dim dEnd As Date = Date.Now()
        If Profile.GetValue("CentreReports.tbStartDate") = "" Then

            dStart = taQ.getFirstCentreDelegateLoginDate(CInt(Session("UserCentreID")))
            tbEvalStartDate.Text = dStart.Date.ToShortDateString()
        Else
            tbEvalStartDate.Text = Profile.GetValue("Reports.tbStartDate")
            dStart = Date.Parse(Profile.GetValue("Reports.tbStartDate"))
        End If
        tbEvalEndDate.Text = dEnd.Date.ToShortDateString()
        SetupEvalDropDowns()
        Me.ddEvalRegionID.SelectedValue = Profile.GetValue("Reports.ddRegion")
        Dim item As ListItem = ddEvalApplicationID.Items.FindByValue(Profile.GetValue("Reports.ddApplication"))
        If item IsNot Nothing Then
            Me.ddEvalApplicationID.SelectedValue = Profile.GetValue("Reports.ddApplication")
        End If
        item = ddEvalJobGroupID.Items.FindByValue(Profile.GetValue("Reports.ddJobGroupID"))
        If item IsNot Nothing Then
            Me.ddEvalJobGroupID.SelectedValue = Profile.GetValue("Reports.ddJobGroupID")
        End If
        Me.ddEvalAssessed.SelectedValue = Profile.GetValue("Reports.ddAssessed")
        item = ddEvalCourseCategory.Items.FindByValue(Profile.GetValue("Reports.ddCourseGroup"))
        If item IsNot Nothing Then
            Me.ddEvalCourseCategory.SelectedValue = Profile.GetValue("Reports.ddCourseGroup")
        End If
        item = ddEvalCentreType.Items.FindByValue(Profile.GetValue("Reports.ddCentreType"))
        If item IsNot Nothing Then
            Me.ddEvalCentreType.SelectedValue = Profile.GetValue("Reports.ddCentreType")
        End If

        DrawEvalCharts()
    End Sub

    Private Sub vHelpdesk_Activate(sender As Object, e As EventArgs) Handles vHelpdesk.Activate
        clearClasses()
        lbtHelpDeskTab.Attributes.Add("class", "nav-link active")
        DrawHelpdeskDonut(1)
        UpdateHelpdeskChart()
    End Sub

    Private Sub lbtEvaluationTab_Click(sender As Object, e As EventArgs) Handles lbtEvaluationTab.Click
        mvStats.SetActiveView(vEvaluation)
    End Sub

    Private Sub lbtHelpDeskTab_Click(sender As Object, e As EventArgs) Handles lbtHelpDeskTab.Click
        mvStats.SetActiveView(vHelpdesk)
    End Sub

    Private Sub lbtUsageTab_Click(sender As Object, e As EventArgs) Handles lbtUsageTab.Click
        mvStats.SetActiveView(vOverallStats)
    End Sub

    Private Sub lbtUsageTrend_Click(sender As Object, e As EventArgs) Handles lbtUsageTrend.Click
        mvStats.SetActiveView(vUsageChart)
    End Sub
    Private Sub lbtDigitalCapabilityTab_Click(sender As Object, e As EventArgs) Handles lbtDigitalCapabilityTab.Click
        mvStats.SetActiveView(vDigitalCapability)
    End Sub
    Protected Sub SetupDropDowns()
        SetupRegions(ddRegionID)
        SetupJobGroups(ddJobGroupID)
        SetupApplications(ddApplicationID)
        SetupCentreTypes(ddCentreType)
    End Sub
    Protected Sub SetupEvalDropDowns()
        SetupRegions(ddEvalRegionID)
        SetupJobGroups(ddEvalJobGroupID)
        SetupApplications(ddEvalApplicationID)
        SetupCentreTypes(ddEvalCentreType)
    End Sub

    Protected Sub SetupRegions(ByVal dd As DropDownList)
        '
        ' Add a catch-all setting first off
        '
        dd.Items.Clear()
        Dim li As New WebControls.ListItem("All", -1)

        dd.ClearSelection()
        li.Selected = True
        dd.Items.Add(li)

        Dim taRegions As New ITSPTableAdapters.RegionsTableAdapter
        Dim tblRegions As ITSP.RegionsDataTable

        tblRegions = taRegions.GetData()
        For Each rowRegion As ITSP.RegionsRow In tblRegions
            li = New WebControls.ListItem(rowRegion.RegionName, rowRegion.RegionID)
            li.Selected = False
            dd.Items.Add(li)
        Next
    End Sub
    Protected Sub SetupCentreTypes(ByVal dd As DropDownList)
        dd.Items.Clear()
        Dim li As New WebControls.ListItem("All", -1)
        dd.ClearSelection()
        li.Selected = True
        dd.Items.Add(li)
        Dim taCentreTypes As New ITSPTableAdapters.CentreTypesTableAdapter
        Dim tCentreTypes As New ITSP.CentreTypesDataTable
        tCentreTypes = taCentreTypes.GetData()
        For Each rowCT As ITSP.CentreTypesRow In tCentreTypes
            li = New WebControls.ListItem(rowCT.CentreType, rowCT.CentreTypeID)
            li.Selected = False
            dd.Items.Add(li)
        Next
    End Sub
    Protected Sub SetupApplications(ByVal dd As DropDownList)
        '
        ' Add a catch-all setting first off
        '
        dd.Items.Clear()
        Dim li As New WebControls.ListItem("All", -1)

        dd.ClearSelection()
        li.Selected = True
        dd.Items.Add(li)

        Dim taApplications As New ITSPTableAdapters.ApplicationsTableAdapter
        Dim tblApplications As ITSP.ApplicationsDataTable

        tblApplications = taApplications.GetLiveCentralCourses()
        For Each rowApplication As ITSP.ApplicationsRow In tblApplications
            li = New WebControls.ListItem(rowApplication.ApplicationName, rowApplication.ApplicationID)
            li.Selected = False
            dd.Items.Add(li)
        Next
    End Sub

    Protected Sub SetupJobGroups(ByVal dd As DropDownList)

        '
        ' Add a catch-all setting first off
        '
        dd.Items.Clear()
        Dim li As New WebControls.ListItem("All", -1)

        dd.ClearSelection()
        li.Selected = True
        dd.Items.Add(li)

        Dim taJobGroups As New ITSPTableAdapters.JobGroupsTableAdapter
        Dim tblJobGroups As ITSP.JobGroupsDataTable

        tblJobGroups = taJobGroups.GetData()
        For Each rowJobGroup As ITSP.JobGroupsRow In tblJobGroups
            li = New WebControls.ListItem(rowJobGroup.JobGroupName, rowJobGroup.JobGroupID)
            li.Selected = False
            dd.Items.Add(li)
        Next
    End Sub
    Protected Sub UpdateActivityChart()
        Try
            BindUsageChart()
        Catch ex As Exception
        End Try
    End Sub
    Private Sub BindUsageChart()
        Dim dStart As Date
        Dim dEnd As Date
        dStart = Date.Parse(Me.tbStartDate.Text)
        dEnd = Date.Parse(Me.tbEndDate.Text)
        Dim strScript As StringBuilder = New StringBuilder()
        Dim taRegComp As New ITSPStatsTableAdapters.uspGetRegCompNewTableAdapter
        Dim tRegComp As New ITSPStats.uspGetRegCompNewDataTable

        tRegComp = taRegComp.GetFilteredNew(ddPeriodType.SelectedValue, ddJobGroupID.SelectedValue, ddApplicationID.SelectedValue, -1, ddRegionID.SelectedValue, ddCentreType.SelectedValue, -1, ddAssessed.SelectedValue, ddCourseCategory.SelectedValue, dStart, dEnd, ddCoreContent.SelectedValue)
        If tRegComp.Rows.Count > 0 Then
            Try
                strScript.Append("<script type='text/javascript'>
                    google.charts.load('current', {'packages':['corechart']});
                    google.charts.setOnLoadCallback(drawUsageStats);
                    function drawUsageStats() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['', 'Registrations', 'Completions', 'Evaluations', 'KB Searches', 'KB Tutorials Launched', 'KB Videos Viewed'],")
                For Each row As DataRow In tRegComp.Rows
                    strScript.Append("[new Date(" & row("period").ToString & ")," & row("registrations").ToString & "," & row("completions").ToString & "," & row("evaluations").ToString & "," & row("kbsearches").ToString & "," & row("kbtutorials").ToString & "," & row("kbvideos").ToString & "," & "],")
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
            Catch ex As Exception

            Finally
                tRegComp.Dispose()
                strScript.Clear()
            End Try
        End If
    End Sub
    Private Sub btnUpdateGraphs_Click(sender As Object, e As EventArgs) Handles btnUpdateGraphs.Click
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        '
        ' Store profile values when update button clicked. Only changes are stored.
        '
        Profile.SetValue("Reports.ddRegion", Me.ddRegionID.SelectedValue)
        Profile.SetValue("Reports.ddApplication", Me.ddApplicationID.SelectedValue)
        Profile.SetValue("Reports.ddJobGroupID", Me.ddJobGroupID.SelectedValue)
        Profile.SetValue("Reports.ddCentreType", Me.ddCentreType.SelectedValue)
        Profile.SetValue("Reports.ddAssessed", Me.ddAssessed.SelectedValue)

        Profile.SetValue("Reports.ddCourseGroup", Me.ddCourseCategory.SelectedValue)
        Profile.SetValue("Reports.tbStartDate", Me.tbStartDate.Text)
        Profile.SetValue("Reports.tbEndDate", Me.tbEndDate.Text)
        Profile.SetValue("Reports.ddCoreContent", ddCoreContent.SelectedValue)
        UpdateActivityChart()
    End Sub
    Private Sub lbtUpdateEvalFilter_Click(sender As Object, e As EventArgs) Handles lbtUpdateEvalFilter.Click
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        '
        ' Store profile values when update button clicked. Only changes are stored.
        '
        Profile.SetValue("Reports.ddRegion", Me.ddEvalRegionID.SelectedValue)
        Profile.SetValue("Reports.ddApplication", Me.ddEvalApplicationID.SelectedValue)
        Profile.SetValue("Reports.ddJobGroupID", Me.ddEvalJobGroupID.SelectedValue)
        Profile.SetValue("Reports.ddCentreType", Me.ddEvalCentreType.SelectedValue)
        Profile.SetValue("Reports.ddAssessed", Me.ddEvalAssessed.SelectedValue)

        Profile.SetValue("Reports.ddCourseGroup", Me.ddEvalCourseCategory.SelectedValue)
        Profile.SetValue("Reports.tbStartDate", Me.tbEvalStartDate.Text)
        Profile.SetValue("Reports.tbEndDate", Me.tbEvalEndDate.Text)
        DrawEvalCharts()
    End Sub
    Protected Sub UpdateHelpdeskChart()
        Dim nMonths As Integer = CInt(ddMonths.SelectedValue)
        Dim ta As New ITSPStatsTableAdapters.HelpdeskStatsTableAdapter
        Dim dt As New ITSPStats.HelpdeskStatsDataTable
        dt = ta.GetData(nMonths)
        Dim strScript As StringBuilder = New StringBuilder
        If dt.Rows.Count > 0 Then
            Try
                strScript.Append("<script type='text/javascript'>
                    google.charts.load('current', {'packages':['corechart']});
                    google.charts.setOnLoadCallback(drawHelpdeskStats);
                    function drawHelpdeskStats() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['', 'Compliant Tickets', 'Non-compliant Tickets'],")
                For Each row As DataRow In dt.Rows
                    strScript.Append("['" & row("period").ToString & "'," & row("SLACompliant").ToString & "," & row("NonCompliant").ToString & "],")
                Next

                strScript.Remove(strScript.Length - 1, 1)
                strScript.Append("]);")
                strScript.Append("
                                    var options = {
colors: ['#0f9d58', '#db4437'],
animation:{ duration: 1000, easing: 'out', startup: true},
explorer: {actions: ['dragToZoom', 'rightClickToReset'],
            axis: 'horizontal',
            keepInBounds: true
            },
chartArea: {'width': '90%', 'height': '75%'},
legend: { position: 'bottom', textStyle: {fontSize:9}},
hAxis: {slantedTextAngle:90,  textStyle: {color: '#333', fontSize:8}},
vAxis: {textStyle: {color: '#333', fontSize:8}, minValue:0, viewWindow:{min:0}},
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('helpdesk-chart'));
        chart.draw(data, options);}")
                strScript.Append(" </script>")
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "activitychart", strScript.ToString())
            Catch ex As Exception

            Finally
                dt.Dispose()
                strScript.Clear()
            End Try
        End If
        'Dim sJSONString As String = CCommon.ConvertDataTabletoString(dt)
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "helpdeskchart", "<script>doHelpdeskChart('helpdesk-chart', " & sJSONString & ");</script>")
    End Sub
    Protected Sub DrawHelpdeskDonut(ByVal monthsback As Integer)
        Dim ta As New ITSPStatsTableAdapters.HelpdeskStatsTableAdapter
        Dim dt As New ITSPStats.HelpdeskStatsDataTable
        dt = ta.GetData(monthsback)
        Dim strScript As StringBuilder = New StringBuilder
        If dt.Rows.Count > 0 Then
            Try
                strScript.Append("<script type='text/javascript'>
                    google.charts.load('current', {'packages':['corechart']});
                    google.charts.setOnLoadCallback(drawHelpdeskDonut);
                    function drawHelpdeskDonut() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['SLA Status','Tickets'],")
                strScript.Append("['Compliant'," & dt.First.SLACompliant.ToString & "],['Non-compliant'," & dt.First.NonCompliant.ToString & "],")


                strScript.Remove(strScript.Length - 1, 1)
                strScript.Append("]);")
                strScript.Append("
                                    var options = {
pieHole: 0.5,
colors: ['#0f9d58', '#db4437'],
chartArea: {'width': '90%', 'height': '75%'},
legend: { position: 'bottom', textStyle: {fontSize:9}},

        };

        var chart = new google.visualization.PieChart(document.getElementById('helpdesk-donut'));
        chart.draw(data, options);}")
                strScript.Append(" </script>")
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "helpdeskdonutchart", strScript.ToString())
            Catch ex As Exception

            Finally
                dt.Dispose()
                strScript.Clear()
            End Try
        End If
        '    Dim sDataString As String = "[{label:'Compliant', value: " & dt.First.SLACompliant & "},"
        'sDataString = sDataString & "{label:'Non-compliant', value: " & dt.First.NonCompliant & "}]"
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "helpdeskdonut", "<script>doHelpdeskDonut('helpdesk-donut', " & sDataString & ");</script>")
    End Sub
    Protected Sub DrawEvalCharts()
        Dim dStart As Date
        Dim dEnd As Date
        dStart = Date.Parse(Me.tbEvalStartDate.Text)
        dEnd = Date.Parse(Me.tbEvalEndDate.Text)
        Dim strOptions As String = "var options = {pieHole: 0.4, colors: ['#0f9d58', '#db4437', '#aaaaaa'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
        Dim strOptions2 As String = "var options2 = {pieHole: 0.4, colors: ['#0f9d58', '#f4b400', '#db4437', '#aaaaaa'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
        Dim strOptions3 As String = "var options3 = {pieHole: 0.4, colors: ['#a60100', '#bc2900', '#df6800', '#f79400', '#977c00', '#005700', '#aaaaaa'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"

        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        '
        ' Create the graph in code as it is very complex!
        '
        Dim taEval As New ITSPStatsTableAdapters.uspEvaluationSummaryDateRangeV4TableAdapter
        Dim tEval As New ITSPStats.uspEvaluationSummaryDateRangeV4DataTable
        tEval = taEval.GetData(ddEvalJobGroupID.SelectedValue, ddEvalApplicationID.SelectedValue, -1, ddEvalRegionID.SelectedValue, ddEvalCentreType.SelectedValue, -1, ddEvalAssessed.SelectedValue, dStart, dEnd, ddEvalCourseCategory.SelectedValue, True)
        Dim strScript As StringBuilder = New StringBuilder
        If tEval.Rows.Count > 0 Then
            Try
                'setup the outer javascript with chart package loading and callback registration of the functions
                strScript.Append("<script type='text/javascript'>
                    google.charts.load('current', {'packages':['corechart']});
                    google.charts.setOnLoadCallback(drawHelpdeskDonutQ1);
google.charts.setOnLoadCallback(drawHelpdeskDonutQ2);
google.charts.setOnLoadCallback(drawHelpdeskDonutQ3);
google.charts.setOnLoadCallback(drawHelpdeskDonutQ4);
google.charts.setOnLoadCallback(drawHelpdeskDonutQ5);
google.charts.setOnLoadCallback(drawHelpdeskDonutQ6);
google.charts.setOnLoadCallback(drawHelpdeskDonutQ7);")
                strScript.Append(strOptions)
                strScript.Append(strOptions2)
                strScript.Append(strOptions3)
                'draw Q1 donut:
                strScript.Append("function drawHelpdeskDonutQ1() {         
                    var data = google.visualization.arrayToDataTable([['Response','Respondents'],")
                strScript.Append("['Yes'," & tEval.First.Q1Yes.ToString & "],['No'," & tEval.First.Q1No.ToString & "],['No response'," & tEval.First.Q1NoAnswer.ToString & "]]);")

                strScript.Append("var chart = new google.visualization.PieChart(document.getElementById('eval-chart-Q1'));chart.draw(data, options);}")
                'draw Q2 donut:
                strScript.Append("function drawHelpdeskDonutQ2() {         
                    var data2 = google.visualization.arrayToDataTable([['Response','Respondents'],")
                strScript.Append("['Yes'," & tEval.First.Q2Yes.ToString & "],['No'," & tEval.First.Q2No.ToString & "],['No response'," & tEval.First.Q2NoAnswer.ToString & "]]);")
                strScript.Append("var chart2 = new google.visualization.PieChart(document.getElementById('eval-chart-Q2'));chart2.draw(data2, options);}")

                'draw Q3 donut:
                strScript.Append("function drawHelpdeskDonutQ3() {         
                    var data3 = google.visualization.arrayToDataTable([['Response','Respondents'],")
                strScript.Append("['Yes'," & tEval.First.Q3Yes.ToString & "],['No'," & tEval.First.Q3No.ToString & "],['No response'," & tEval.First.Q3NoAnswer.ToString & "]]);")
                strScript.Append("var chart3 = new google.visualization.PieChart(document.getElementById('eval-chart-Q3'));chart3.draw(data3, options);}")

                'draw Q4 Donut:
                strScript.Append("function drawHelpdeskDonutQ4() { 
                var data4 = google.visualization.arrayToDataTable([['Response','Respondents'],")
                strScript.Append("['0 hrs'," & tEval.First.Q40.ToString & "],['<1 hrs'," & tEval.First.Q4lt1.ToString & "],['1-2 hrs'," & tEval.First.Q41to2.ToString & "],['2-4 hrs'," & tEval.First.Q42to4.ToString & "],['4-6 hrs'," & tEval.First.Q44to6.ToString & "],['>6 hrs'," & tEval.First.Q4gt6.ToString & "],['No response'," & tEval.First.Q4NoAnswer.ToString & "]]);")
                strScript.Append("var chart4 = new google.visualization.PieChart(document.getElementById('eval-chart-Q4'));chart4.draw(data4, options3);}")

                'draw Q5 donut:
                strScript.Append("function drawHelpdeskDonutQ5() {         
                    var data5 = google.visualization.arrayToDataTable([['Response','Respondents'],")
                strScript.Append("['Yes'," & tEval.First.Q5Yes.ToString & "],['No'," & tEval.First.Q5No.ToString & "],['No response'," & tEval.First.Q5NoAnswer.ToString & "]]);")
                strScript.Append("var chart5 = new google.visualization.PieChart(document.getElementById('eval-chart-Q5'));chart5.draw(data5, options);}")

                'draw Q6 donut:
                strScript.Append("function drawHelpdeskDonutQ6() {         
                    var data6 = google.visualization.arrayToDataTable([['Response','Respondents'],")
                strScript.Append("['Yes directly'," & tEval.First.Q6YesDir.ToString & "],['Yes indirectly'," & tEval.First.Q6YesInd.ToString & "],['No'," & tEval.First.Q6No.ToString & "],['No response'," & tEval.First.Q6NoAnswer.ToString & "]]);")
                strScript.Append("var chart6 = new google.visualization.PieChart(document.getElementById('eval-chart-Q6'));chart6.draw(data6, options2);}")


                'draw Q7 donut:
                strScript.Append("function drawHelpdeskDonutQ7() {         
                    var data7 = google.visualization.arrayToDataTable([['Response','Respondents'],")
                strScript.Append("['Yes'," & tEval.First.Q7Yes.ToString & "],['No'," & tEval.First.Q7No.ToString & "],['No response'," & tEval.First.Q7NoAnswer.ToString & "]]);")
                strScript.Append("var chart7 = new google.visualization.PieChart(document.getElementById('eval-chart-Q7'));chart7.draw(data7, options);}")

                'close  script tag and register as startup script:
                strScript.Append("</script>")
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "evalChartsScript", strScript.ToString())

            Catch ex As Exception

            Finally
                tEval.Dispose()
                strScript.Clear()
            End Try
        End If

    End Sub
    Private Sub lbtUpdateHDStats_Click(sender As Object, e As EventArgs) Handles lbtUpdateHDStats.Click
        UpdateHelpdeskChart()
        DrawHelpdeskDonut(1)
    End Sub

    Private Sub lbtDownloadHelpdeskStats_Click(sender As Object, e As EventArgs) Handles lbtDownloadHelpdeskStats.Click
        Dim nMonths As Integer = CInt(ddMonths.SelectedValue)
        Dim DS_Export As New DataSet("Stats Export")
        Dim ta As New ITSPStatsTableAdapters.HelpdeskStatsTableAdapter
        Dim dt As New ITSPStats.HelpdeskStatsDataTable
        dt = ta.GetData(nMonths)

        dt.TableName = "Helpdesk Stats"
        DS_Export.Tables.Add(dt)
        XMLExport.ExportToExcel(DS_Export, "ITSP Helpdesk Stats " & CCommon.sCurrentDate & ".xlsx", Page.Response)
    End Sub

    Private Sub lbtExportActivityChartDataToExcel_Click(sender As Object, e As EventArgs) Handles lbtExportActivityChartDataToExcel.Click
        Dim dStart As Date
        Dim dEnd As Date
        dStart = Date.Parse(Me.tbStartDate.Text)
        dEnd = Date.Parse(Me.tbEndDate.Text)
        Dim taRegComp As New ITSPStatsTableAdapters.uspGetRegCompNewTableAdapter
        Dim tRegComp As New ITSPStats.uspGetRegCompNewDataTable
        Try
            tRegComp = taRegComp.GetFiltered(ddPeriodType.SelectedValue, ddJobGroupID.SelectedValue, ddApplicationID.SelectedValue, -1, ddRegionID.SelectedValue, ddCentreType.SelectedValue, -1, ddAssessed.SelectedValue, ddCourseCategory.SelectedValue, tbStartDate.Text, tbEndDate.Text)
        Catch ex As Exception
        End Try
        tRegComp.TableName = "Usage Stats"
        Dim DS_Export As New DataSet("Stats Export")
        DS_Export.Tables.Add(tRegComp)
        XMLExport.ExportToExcel(DS_Export, "ITSP Usage Stats " & CCommon.sCurrentDate & ".xlsx", Page.Response)
    End Sub

    Private Sub lbtExportUsageOverview_Click(sender As Object, e As EventArgs) Handles lbtExportUsageOverview.Click
        Dim ta As New ITSPStatsTableAdapters.OverviewStatsTableAdapter
        Dim dt As New ITSPStats.OverviewStatsDataTable
        dt = ta.GetData()
        dt.TableName = "Usage Overview"
        Dim DS_Export As New DataSet("Usage Overview")
        DS_Export.Tables.Add(dt)
        XMLExport.ExportToExcel(DS_Export, "ITSP Usage Overview " & CCommon.sCurrentDate & ".xlsx", Page.Response)
    End Sub

    Private Sub lbtExportActivityByLevel_Click(sender As Object, e As EventArgs) Handles lbtExportActivityByLevel.Click
        Dim taCompsByGroup As New ITSPStatsTableAdapters.CompsByGroupTableAdapter
        Dim tCompByGroup As New ITSPStats.CompsByGroupDataTable
        tCompByGroup = taCompsByGroup.GetData()
        tCompByGroup.TableName = "Usage Overview by Level"
        Dim DS_Export As New DataSet("Usage by Level")
        DS_Export.Tables.Add(tCompByGroup)
        XMLExport.ExportToExcel(DS_Export, "ITSP Usage by Level " & CCommon.sCurrentDate & ".xlsx", Page.Response)
    End Sub

    Private Sub lbtExportEvalStats_Click(sender As Object, e As EventArgs) Handles lbtExportEvalStats.Click
        Dim taEval As New ITSPStatsTableAdapters.uspEvaluationSummaryDateRangeV4TableAdapter
        Dim tEval As New ITSPStats.uspEvaluationSummaryDateRangeV4DataTable
        Dim dStart As Date = Date.Parse(Me.tbEvalStartDate.Text)
        Dim dEnd As Date = Date.Parse(Me.tbEvalEndDate.Text)
        tEval = taEval.GetData(ddEvalJobGroupID.SelectedValue, ddEvalApplicationID.SelectedValue, -1, ddEvalRegionID.SelectedValue, ddEvalCentreType.SelectedValue, -1, ddEvalAssessed.SelectedValue, dStart, dEnd, ddEvalCourseCategory.SelectedValue, True)
        tEval.TableName = "Evaluation Stats"
        Dim DS_Export As New DataSet("ITSP Evaluation Stats")
        DS_Export.Tables.Add(tEval)
        XMLExport.ExportToExcel(DS_Export, "ITSP Evaluation Stats " & CCommon.sCurrentDate & ".xlsx", Page.Response)
    End Sub

    Private Sub vDigitalCapability_Activate(sender As Object, e As EventArgs) Handles vDigitalCapability.Activate
        clearClasses()
        lbtDigitalCapabilityTab.Attributes.Add("class", "nav-link active")
        Dim taSummary As New ITSPStatsTableAdapters.DigitalCapabilitySummaryTableAdapter
        Dim tSummary As ITSPStats.DigitalCapabilitySummaryDataTable = taSummary.GetData()
        If tSummary.Count = 1 Then
            lblDCSACompleted.Text = tSummary.First.Submitted.ToString + " Submitted"
            lblDCSAReviewing.Text = tSummary.First.Reviewing.ToString + " Reviewing"
            lblDCSAIncomplete.Text = tSummary.First.Incomplete.ToString + " Incomplete"
        End If
    End Sub

    Private Sub lbtDownloadDCSAReport_Click(sender As Object, e As EventArgs) Handles lbtDownloadDCSAReport.Click
        Dim taDCSA As New ITSPStatsTableAdapters.DigitalCapabilitySATableAdapter
        Dim tDCSA As ITSPStats.DigitalCapabilitySADataTable = taDCSA.GetData()
        tDCSA.TableName = "DCSA Outcome Summary"
        Dim DS_Export As New DataSet("Digital Capability Self Assessment Report")
        DS_Export.Tables.Add(tDCSA)
        XMLExport.ExportToExcel(DS_Export, "DLS DCSA Report " & CCommon.sCurrentDate & ".xlsx", Page.Response)
    End Sub
End Class