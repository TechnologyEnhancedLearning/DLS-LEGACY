Imports DevExpress.Web.Bootstrap

Public Class reports
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Private Sub lbtUsageTrend_Click(sender As Object, e As EventArgs) Handles lbtUsageTrend.Click
        mvStats.SetActiveView(vUsageChart)
    End Sub
    Private Sub lbtEvaluationTab_Click(sender As Object, e As EventArgs) Handles lbtEvaluationTab.Click
        mvStats.SetActiveView(vEvaluation)
    End Sub
    Protected Sub clearClasses()
        lbtEvaluationTab.CssClass = "nav-link"
        lbtUsageTrend.CssClass = "nav-link"
    End Sub
    Private Sub vUsageChart_Activate(sender As Object, e As EventArgs) Handles vUsageChart.Activate
        If Not Session("UserAdminID") Is Nothing Then
            clearClasses()
            lbtUsageTrend.CssClass = "nav-link active"
            Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
            Dim taQ As New ITSPTableAdapters.QueriesTableAdapter
            Dim dStart As Date
            Dim dEnd As Date = Date.Now()
            If Profile.GetValue("CentreReports.tbStartDate") = "" Then

                dStart = taQ.getFirstCentreDelegateLoginDate(CInt(Session("UserCentreID")))
                tbStartDate.Text = dStart.Date.ToShortDateString()
            Else
                tbStartDate.Text = Profile.GetValue("CentreReports.tbStartDate")
                dStart = Date.Parse(Profile.GetValue("CentreReports.tbStartDate"))
            End If
            tbEndDate.Text = dEnd.Date.ToShortDateString()

            Dim nCustomisationID As Integer = -1
            If Not Page.Request.Item("CustomisationID") Is Nothing Then
                nCustomisationID = CInt(Page.Request.Item("CustomisationID").ToString())
                Profile.SetValue("CentreReports.ddCustomisation", nCustomisationID)
            End If
            SetupDropDowns(nCustomisationID)
            '
            ' Set up defaults from profile when page is being loaded initially
            '
            'Me.ddPeriodCount.SelectedValue = Profile.GetValue("Reports.ddPeriodCount")
            'Me.ddPeriodType.SelectedValue = Profile.GetValue("Reports.ddPeriodType")

            Dim item As ListItem = ddJobGroupID.Items.FindByValue(Profile.GetValue("CentreReports.ddJobGroupID"))
            If item IsNot Nothing Then
                Me.ddJobGroupID.SelectedValue = Profile.GetValue("CentreReports.ddJobGroupID")
            End If
            Me.ddAssessed.SelectedValue = Profile.GetValue("CentreReports.ddAssessed")


            'Show the activity graph:
            'UpdateActivityChart()
        End If
    End Sub

    Protected Sub SetupDropDowns(ByVal nSelectedCustomisationID As Integer)
        SetupCustomisations(nSelectedCustomisationID, ddCustomisationID)
        SetupJobGroups(ddJobGroupID)
    End Sub
    Protected Sub SetupEvalDropDowns()
        SetupJobGroups(ddEvalJobGroupID)
        SetupCustomisations(0, ddEvalCustomisationID)
    End Sub
    Protected Sub SetupCustomisations(ByVal nSelectedCustomisationID As Integer, ByVal ddList As DropDownList)
        '
        ' Add a catch-all setting first off
        '
        Dim li As New WebControls.ListItem("All", -1)

        ddList.ClearSelection()
        li.Selected = True
        ddList.Items.Add(li)

        Dim taCustomisations As New ITSPTableAdapters.CustomisationsTableAdapter
        Dim tblCustomisations As ITSP.CustomisationsDataTable

        tblCustomisations = taCustomisations.GetByCentre2(CInt(Session("UserCentreID")), False, Session("AdminCategoryID"))
        For Each rowCust As ITSP.CustomisationsRow In tblCustomisations
            If rowCust.Active Then
                li = New WebControls.ListItem(rowCust.CustomisationName, rowCust.CustomisationID)
                li.Selected = False
                ddList.Items.Add(li)
            End If

        Next
        For Each rowCust As ITSP.CustomisationsRow In tblCustomisations
            If Not rowCust.Active Then
                li = New WebControls.ListItem("INACTIVE - " & rowCust.CustomisationName, rowCust.CustomisationID)
                li.Selected = False
                ddList.Items.Add(li)
            End If
        Next
        '
        ' Override default selection if a value supplied
        '
        If nSelectedCustomisationID > 0 Then
            Dim item As ListItem = ddList.Items.FindByValue(nSelectedCustomisationID)
            If item IsNot Nothing Then
                ddList.SelectedValue = nSelectedCustomisationID
            End If
        End If
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
        'Dim Anno As System.Web.UI.DataVisualization.Charting.Annotation
        'Anno = RegCompCourseGraph.Annotations.FindByName("NoData")
        'If Not Anno Is Nothing Then
        '	RegCompCourseGraph.Annotations.Remove(Anno)
        'End If
        Dim dStart As Date
        Dim dEnd As Date
        dStart = Date.Parse(Me.tbStartDate.Text)
        dEnd = Date.Parse(Me.tbEndDate.Text)

        Dim taRegComp As New ITSPStatsTableAdapters.uspGetRegCompNewTableAdapter
        Dim tRegComp As New ITSPStats.uspGetRegCompNewDataTable

        Dim strScript As StringBuilder = New StringBuilder()
        Try
            tRegComp = taRegComp.GetFilteredNew(ddPeriodType.SelectedValue, ddJobGroupID.SelectedValue, -1, ddCustomisationID.SelectedValue, -1, -1, Session("UserCentreID"), ddAssessed.SelectedValue, ddCourseCategory.SelectedValue, tbStartDate.Text, tbEndDate.Text, -1)
            If tRegComp.Rows.Count > 0 Then
                strScript.Append("<script type='text/javascript'>
                    google.charts.load('current', {'packages':['corechart']});
                    google.charts.setOnLoadCallback(drawUsageStats);
                    function drawUsageStats() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['', 'Registrations', 'Completions', 'Evaluations', 'Knowledge Bank Searches', 'Knowledge Bank Tutorials Launched', 'Knowledge Bank Videos Viewed'],")
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
            End If
        Catch ex As Exception

        Finally
            tRegComp.Dispose()
            strScript.Clear()
        End Try
    End Sub
    Protected Sub btnUpdateGraphs_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnUpdateGraphs.Click
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        '
        ' Store profile values. Only changes are stored.
        '
        Profile.SetValue("CentreReports.ddCustomisation", Me.ddCustomisationID.SelectedValue)
        Profile.SetValue("CentreReports.ddJobGroupID", Me.ddJobGroupID.SelectedValue)
        Profile.SetValue("CentreReports.ddAssessed", Me.ddAssessed.SelectedValue)
        Profile.SetValue("CentreReports.ddCourseGroup", Me.ddCourseCategory.SelectedValue)
        Profile.SetValue("CentreReports.tbStartDate", Me.tbStartDate.Text)
        Profile.SetValue("CentreReports.tbEndDate", Me.tbEndDate.Text)
        '
        ' Create evaluation charts
        '
        UpdateActivityChart()
        'UpdateActivityChart()
    End Sub
    Protected Sub DrawEvalCharts()
        Dim dStart As Date
        Dim dEnd As Date
        dStart = Date.Parse(Me.tbEvalStartDate.Text)
        dEnd = Date.Parse(Me.tbEvalEndDate.Text)

        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)

        Dim taEval As New ITSPStatsTableAdapters.uspEvaluationSummaryDateRangeV4TableAdapter
        Dim tEval As New ITSPStats.uspEvaluationSummaryDateRangeV4DataTable
        tEval = taEval.GetData(ddEvalJobGroupID.SelectedValue, -1, ddEvalCustomisationID.SelectedValue, -1, -1, Session("UserCentreID"), ddEvalAssessed.SelectedValue, dStart, dEnd, ddEvalCourseCategory.SelectedValue, False)
        If tEval.First.TotalResponses = 0 Then
            Exit Sub
        End If
        Dim strOptions As String = "var options = {pieHole: 0.4, colors: ['#0f9d58', '#db4437', '#aaaaaa'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
        Dim strOptions2 As String = "var options2 = {pieHole: 0.4, colors: ['#0f9d58', '#f4b400', '#db4437', '#aaaaaa'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
        Dim strOptions3 As String = "var options3 = {pieHole: 0.4, colors: ['#a60100', '#bc2900', '#df6800', '#f79400', '#977c00', '#005700', '#aaaaaa'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
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

    Private Sub vEvaluation_Activate(sender As Object, e As EventArgs) Handles vEvaluation.Activate
        clearClasses()
        lbtEvaluationTab.CssClass = "nav-link active"
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        Dim taQ As New ITSPTableAdapters.QueriesTableAdapter
        Dim dStart As Date
        Dim dEnd As Date = Date.Now()
        If Profile.GetValue("CentreReports.tbStartDate") = "" Then

            dStart = taQ.getFirstCentreDelegateLoginDate(CInt(Session("UserCentreID")))
            tbEvalStartDate.Text = dStart.Date.ToShortDateString()
        Else
            tbEvalStartDate.Text = Profile.GetValue("CentreReports.tbStartDate")
            dStart = Date.Parse(Profile.GetValue("CentreReports.tbStartDate"))
        End If
        tbEvalEndDate.Text = dEnd.Date.ToShortDateString()

        SetupEvalDropDowns()
        '
        ' Set up defaults from profile when page is being loaded initially
        '
        'Me.ddPeriodCount.SelectedValue = Profile.GetValue("Reports.ddPeriodCount")
        'Me.ddPeriodType.SelectedValue = Profile.GetValue("Reports.ddPeriodType")

        Dim item As ListItem = ddEvalJobGroupID.Items.FindByValue(Profile.GetValue("CentreReports.ddJobGroupID"))
        If item IsNot Nothing Then
            Me.ddEvalJobGroupID.SelectedValue = Profile.GetValue("CentreReports.ddJobGroupID")
        End If
        Me.ddEvalAssessed.SelectedValue = Profile.GetValue("CentreReports.ddAssessed")
        'DrawEvalCharts()
    End Sub

    Private Sub lbtUpdateEvalFilter_Click(sender As Object, e As EventArgs) Handles lbtUpdateEvalFilter.Click
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        '
        ' Store profile values. Only changes are stored.
        '
        Profile.SetValue("CentreReports.ddCustomisation", Me.ddEvalCustomisationID.SelectedValue)
        Profile.SetValue("CentreReports.ddJobGroupID", Me.ddEvalJobGroupID.SelectedValue)
        Profile.SetValue("CentreReports.ddAssessed", Me.ddEvalAssessed.SelectedValue)
        Profile.SetValue("CentreReports.ddCourseGroup", Me.ddEvalCourseCategory.SelectedValue)
        Profile.SetValue("CentreReports.tbStartDate", Me.tbEvalStartDate.Text)
        Profile.SetValue("CentreReports.tbEndDate", Me.tbEvalEndDate.Text)
        '
        ' Create evaluation charts
        '
        DrawEvalCharts()
    End Sub

    Private Sub lbtExportEvalStats_Click(sender As Object, e As EventArgs) Handles lbtExportEvalStats.Click
        Dim taEval As New ITSPStatsTableAdapters.uspEvaluationSummaryDateRangeV4TableAdapter
        Dim tEval As New ITSPStats.uspEvaluationSummaryDateRangeV4DataTable
        Dim dStart As Date = Date.Parse(Me.tbEvalStartDate.Text)
        Dim dEnd As Date = Date.Parse(Me.tbEvalEndDate.Text)
        tEval = taEval.GetData(ddEvalJobGroupID.SelectedValue, -1, ddEvalCustomisationID.SelectedValue, -1, -1, Session("UserCentreID"), ddEvalAssessed.SelectedValue, dStart, dEnd, ddEvalCourseCategory.SelectedValue, False)
        tEval.TableName = "Evaluation Stats"
        Dim DS_Export As New DataSet("ITSP Evaluation Stats")
        DS_Export.Tables.Add(tEval)
        XMLExport.ExportToExcel(DS_Export, "ITSP Evaluation Stats " & CCommon.sCurrentDate & ".xlsx", Page.Response)

    End Sub
    Private Sub lbtExportActivityChartDataToExcel_Click(sender As Object, e As EventArgs) Handles lbtExportActivityChartDataToExcel.Click
        Dim dStart As Date
        Dim dEnd As Date
        dStart = Date.Parse(Me.tbStartDate.Text)
        dEnd = Date.Parse(Me.tbEndDate.Text)
        Dim taRegComp As New ITSPStatsTableAdapters.uspGetRegCompNewTableAdapter
        Dim tRegComp As New ITSPStats.uspGetRegCompNewDataTable
        Try
            tRegComp = taRegComp.GetFiltered(ddPeriodType.SelectedValue, ddJobGroupID.SelectedValue, -1, ddCustomisationID.SelectedValue, -1, -1, Session("UserCentreID"), ddAssessed.SelectedValue, ddCourseCategory.SelectedValue, tbStartDate.Text, tbEndDate.Text)
        Catch ex As Exception
        End Try
        tRegComp.TableName = "Usage Stats"
        Dim DS_Export As New DataSet("Stats Export")
        DS_Export.Tables.Add(tRegComp)
        XMLExport.ExportToExcel(DS_Export, "ITSP Usage Stats " & CCommon.sCurrentDate & ".xlsx", Page.Response)
    End Sub

    Private Sub ddCourseCategory_DataBound(sender As Object, e As EventArgs) Handles ddCourseCategory.DataBound
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        Dim nCatID As Integer = Profile.GetValue("CentreReports.ddCourseGroup")
        If Session("AdminCategoryID") > 0 Then
            nCatID = Session("AdminCategoryID")
        End If
        Dim item As ListItem = ddCourseCategory.Items.FindByValue(nCatID)
        If item IsNot Nothing Then
            Me.ddCourseCategory.SelectedValue = nCatID
            If Session("AdminCategoryID") > 0 Then
                ddCourseCategory.Enabled = False
            End If
        End If
        UpdateActivityChart()
    End Sub

    Private Sub ddEvalCourseCategory_DataBound(sender As Object, e As EventArgs) Handles ddEvalCourseCategory.DataBound
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        Dim nCatID As Integer = Profile.GetValue("CentreReports.ddCourseGroup")
        If Session("AdminCategoryID") > 0 Then
            nCatID = Session("AdminCategoryID")
        End If
        Dim item As ListItem = ddEvalCourseCategory.Items.FindByValue(nCatID)
        If item IsNot Nothing Then
            Me.ddEvalCourseCategory.SelectedValue = nCatID
            If Session("AdminCategoryID") > 0 Then
                ddEvalCourseCategory.Enabled = False
            End If
        End If
        DrawEvalCharts()
    End Sub


End Class