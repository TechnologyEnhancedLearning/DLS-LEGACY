Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap
Imports System.Data.SqlClient
Public Class reportfwa

    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Get centre data:
            Dim taCentres As New ITSPTableAdapters.CentresTableAdapter
            Dim tCentres As ITSP.CentresDataTable
            Dim nCentreID As Integer = CInt(Session("UserCentreID"))

            tCentres = taCentres.GetByCentreID(nCentreID)
            If tCentres.Count = 1 Then

                Dim dr As ITSP.CentresRow = tCentres.First
                '
                ' Change the titles of the columns to reflect the questions

                bsgvSAReport.Columns("Answer1").Caption = dr.F1Name.ToString()
                bsgvSAReport.Columns("Answer2").Caption = dr.F2Name.ToString()
                bsgvSAReport.Columns("Answer3").Caption = dr.F3Name.ToString()
                bsgvSAReport.Columns("Answer4").Caption = dr.F4Name.ToString()
                bsgvSAReport.Columns("Answer5").Caption = dr.F5Name.ToString()
                bsgvSAReport.Columns("Answer6").Caption = dr.F6Name.ToString()
                'set visibility of columns and availability in customise form:
                If bsgvSAReport.Columns("Answer1").Caption = "" Then
                    bsgvSAReport.Columns("Answer1").ShowInCustomizationForm = False
                    bsgvSAReport.Columns("Answer1").Visible = False
                End If
                If bsgvSAReport.Columns("Answer2").Caption = "" Then
                    bsgvSAReport.Columns("Answer2").ShowInCustomizationForm = False
                    bsgvSAReport.Columns("Answer2").Visible = False
                End If
                If bsgvSAReport.Columns("Answer3").Caption = "" Then
                    bsgvSAReport.Columns("Answer3").ShowInCustomizationForm = False
                    bsgvSAReport.Columns("Answer3").Visible = False
                End If
                If bsgvSAReport.Columns("Answer4").Caption = "" Then
                    bsgvSAReport.Columns("Answer4").ShowInCustomizationForm = False
                    bsgvSAReport.Columns("Answer4").Visible = False
                End If
                If bsgvSAReport.Columns("Answer5").Caption = "" Then
                    bsgvSAReport.Columns("Answer5").ShowInCustomizationForm = False
                    bsgvSAReport.Columns("Answer5").Visible = False
                End If
                If bsgvSAReport.Columns("Answer6").Caption = "" Then
                    bsgvSAReport.Columns("Answer6").ShowInCustomizationForm = False
                    bsgvSAReport.Columns("Answer6").Visible = False
                End If

                LoadCustomQuestions()
                DrawDashboard(True)
            End If
        End If

    End Sub
    Protected Sub LoadCustomQuestions()
        Dim taCentres As New ITSPTableAdapters.CentresTableAdapter
        Dim tCentres As ITSP.CentresDataTable
        Dim nCentreID As Integer = CInt(Session("UserCentreID"))

        tCentres = taCentres.GetByCentreID(nCentreID)
        If tCentres.Count = 1 Then

            Dim dr As ITSP.CentresRow = tCentres.First
            Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
            'set label names and load options for dashboard filters:
            LoadOptions(pnlAnswer1, lblA1, dr.F1Name, dr.F1Options)
            LoadOptions(pnlAnswer2, lblA2, dr.F2Name, dr.F2Options)
            LoadOptions(pnlAnswer3, lblA3, dr.F3Name, dr.F3Options)
            LoadOptions(pnlAnswer4, lblA4, dr.F4Name, dr.F4Options)
            LoadOptions(pnlAnswer5, lblA5, dr.F5Name, dr.F5Options)
            LoadOptions(pnlAnswer6, lblA6, dr.F6Name, dr.F6Options)
            tbStartDate.Text = Profile.GetValue("ReportFWA.tbStartDate")
            tbEndDate.Text = Profile.GetValue("ReportFWA.tbEndDate")
            cbSVVerified.Checked = Profile.GetValue("ReportFWA.cbSVVerified")
            cbStacked.Checked = Profile.GetValue("ReportFWA.cbStacked")
            cbPies.Checked = Profile.GetValue("ReportFWA.cbPies")
        End If
    End Sub
    Protected Sub LoadOptions(ByVal pnl As Panel, ByVal lbl As Label, ByVal sPrompt As String, ByVal sOptions As String)

        If sOptions.Length = 0 Or sPrompt.Length = 0 Then
            pnl.Visible = False
        Else
            pnl.Visible = True
            lbl.Text = sPrompt & ":"

        End If
    End Sub

    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            bsgvExporter.WriteXlsxToResponse()
        End If
    End Sub

    Protected Sub DrawDashboard(Optional ByVal bLoadFromProfile As Boolean = False)
        Dim taq As New ITSPStatsTableAdapters.QueriesTableAdapter
        Dim dStart As Date = Date.Parse("01/01/1900")
        Dim dEnd As Date = DateTime.MaxValue
        Dim bFilterDate As Boolean = True
        If Not tbStartDate.Text = "" Then
            dStart = Date.Parse(Me.tbStartDate.Text)
        Else
            bFilterDate = False
        End If
        If Not tbEndDate.Text = "" Then
            dEnd = Date.Parse(Me.tbEndDate.Text)
        Else
            bFilterDate = False
        End If
        Dim sA1 As String
        Dim sA2 As String
        Dim sA3 As String
        Dim sA4 As String
        Dim sA5 As String
        Dim sA6 As String
        Dim nBrandID As Integer
        Dim nCategoryID As Integer
        Dim nTopicID As Integer
        Dim nApplicationID As Integer
        Dim sSection As String
        Dim sSkill As String
        Dim nJobGroupID As Integer
        If bLoadFromProfile Then
            Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
            sA1 = Profile.GetValue("ReportFWA.sAnswer1")
            sA2 = Profile.GetValue("ReportFWA.sAnswer2")
            sA3 = Profile.GetValue("ReportFWA.sAnswer3")
            sA4 = Profile.GetValue("ReportFWA.sAnswer4")
            sA5 = Profile.GetValue("ReportFWA.sAnswer5")
            sA6 = Profile.GetValue("ReportFWA.sAnswer6")
            nBrandID = Profile.GetValue("ReportFWA.ddBrand")
            nCategoryID = Profile.GetValue("ReportFWA.ddCategory")
            nTopicID = Profile.GetValue("ReportFWA.ddTopic")
            nApplicationID = Profile.GetValue("ReportFWA.ddApplication")
            sSection = Profile.GetValue("ReportFWA.ddSection")
            sSkill = Profile.GetValue("ReportFWA.ddSkill")
            nJobGroupID = Profile.GetValue("ReportFWA.ddJobGroupID")
        Else
            sA1 = ddAnswer1.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
            sA2 = ddAnswer2.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
            sA3 = ddAnswer3.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
            sA4 = ddAnswer4.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
            sA5 = ddAnswer5.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
            sA6 = ddAnswer6.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
            nBrandID = ddBrand.SelectedValue
            nCategoryID = ddCategory.SelectedValue
            nTopicID = ddTopic.SelectedValue
            nApplicationID = ddApplication.SelectedValue
            sSection = ddSection.SelectedValue
            sSkill = ddSkill.SelectedValue
            nJobGroupID = ddJobGroupID.SelectedValue
        End If
        Dim nMatchCount As Integer = taq.GetFilteredCountDeelegatesForSA(Session("UserCentreID"), nBrandID, nCategoryID, nTopicID, nApplicationID, sSection, sSkill, sA1, sA2, sA3, sA4, sA5, sA6, nJobGroupID)
        lblMatchingDelegates.Text = nMatchCount.ToString & " <small>Delegates Enroled on Framework Assessments Matching Filter Criteria</small>"

        Dim cmd As New SqlCommand("GetSelfAssessmentDashboardDataPivot")
        cmd.Parameters.AddWithValue("@CentreID", Session("UserCentreID"))
        cmd.Parameters.AddWithValue("@BrandID", nBrandID)
        cmd.Parameters.AddWithValue("@Category", nCategoryID)
        cmd.Parameters.AddWithValue("@Topic", nTopicID)
        cmd.Parameters.AddWithValue("@ApplicationID", nApplicationID)
        cmd.Parameters.AddWithValue("@SectionName", sSection)
        cmd.Parameters.AddWithValue("@TutorialName", sSkill)
        cmd.Parameters.AddWithValue("@Answer1", sA1)
        cmd.Parameters.AddWithValue("@Answer2", sA2)
        cmd.Parameters.AddWithValue("@Answer3", sA3)
        cmd.Parameters.AddWithValue("@Answer4", sA4)
        cmd.Parameters.AddWithValue("@Answer5", sA5)
        cmd.Parameters.AddWithValue("@Answer6", sA6)
        cmd.Parameters.AddWithValue("@FilterDate", bFilterDate)
        cmd.Parameters.AddWithValue("@StartDate", dStart)
        cmd.Parameters.AddWithValue("@EndDate", dEnd)
        cmd.Parameters.AddWithValue("@VerifiedOnly", cbSVVerified.Checked)
        cmd.Parameters.AddWithValue("@JobGroupID", nJobGroupID)
        Dim ds As DataSet = ExecuteCMD(cmd)
        If ds.Tables.Count > 0 Then
            Dim DT As DataTable = ExecuteCMD(cmd).Tables(0)
            If DT.Rows.Count > 0 Then
                'setup the outer javascript with chart package loading and callback registration of the functions
                Dim strScript As StringBuilder = New StringBuilder
                strScript.Append("<script type='text/javascript'>
                    google.charts.load('current', {'packages':['corechart']});")

                'Create a stacked bar chart:
                Dim nCol As Integer = 1
                Dim nRow As Integer = 1
                Try
                    If cbStacked.Checked Then
                        pnlStacked.Visible = True
                        Dim strStackedOptions As String = "var stoptions = {chartArea: {'width': '50%', 'height': '75%'}, isStacked:'percent', legend: { position: 'bottom', textStyle: {fontSize:9}}};"
                        Dim strStackedOptions2 As String = "var stoptions = {colors: ['#833333', '#338333'], chartArea: {'width': '50%', 'height': '75%'}, isStacked:'percent', legend: { position: 'bottom', textStyle: {fontSize:9}}};"
                        Dim strStackedOptions3 As String = "var stoptions = {colors: ['#833333', '#F1C232', '#338333'], chartArea: {'width': '50%', 'height': '75%'}, isStacked:'percent', legend: { position: 'bottom', textStyle: {fontSize:9}}};"
                        Dim strStackedOptions4 As String = "var stoptions = {colors: ['#833333','#c38632', '#b3cc37', '#338333'], chartArea: {'width': '50%', 'height': '75%'}, isStacked:'percent', legend: { position: 'bottom', textStyle: {fontSize:9}}};"
                        Dim strStackedOptions6 As String = "var stoptions = {colors: ['#833333', '#9e5733', '#d59036', '#dfd835', '#76b137', '#338333'], chartArea: {'width': '50%', 'height': '75%'}, isStacked:'percent', legend: { position: 'bottom', textStyle: {fontSize:9}}};"
                        Dim strStackedOptions10 As String = "var stoptions = {colors: ['#833333', '#954236', '#a85337', '#cc8237', '#e8b034', '#dfd835', '#b3cc37', '#76b137', '#499536', '#338333'], chartArea: {'width': '50%', 'height': '75%'}, isStacked:'percent', legend: { position: 'bottom', textStyle: {fontSize:9}}};"
                        strScript.Append("google.charts.setOnLoadCallback(drawStackedChart);")


                        Select Case DT.Columns.Count - 1
                            Case 2
                                strScript.Append(strStackedOptions2)
                            Case 3
                                strScript.Append(strStackedOptions3)
                            Case 4
                                strScript.Append(strStackedOptions4)
                            Case 6
                                strScript.Append(strStackedOptions6)
                            Case 10
                                strScript.Append(strStackedOptions10)
                            Case Else
                                strScript.Append(strStackedOptions)
                        End Select
                        strScript.Append("function drawStackedChart() {var stdata = google.visualization.arrayToDataTable([['Descriptor', ")

                        For Each c As DataColumn In DT.Columns

                            If Not c.ColumnName = "Skill" Then
                                If nCol > 1 Then
                                    strScript.Append(",")
                                End If
                                strScript.Append("'" & c.ColumnName & "'")
                                nCol = nCol + 1
                            End If
                        Next
                        strScript.Append(", { role: 'annotation' } ],")

                        For Each r As DataRow In DT.Rows
                            If nRow > 1 Then
                                strScript.Append(",")
                            End If
                            strScript.Append("[")
                            nCol = 1
                            For Each c As DataColumn In DT.Columns
                                If c.ColumnName = "Skill" Then
                                    strScript.Append("'" & r(c).ToString & "',")
                                Else
                                    If nCol > 1 Then
                                        strScript.Append(",")
                                    End If
                                    strScript.Append(r(c).ToString)
                                    nCol = nCol + 1
                                End If
                            Next
                            strScript.Append(", '']")
                            nRow = nRow + 1
                        Next
                        strScript.Append("]);")
                        strScript.Append("var stchart = new google.visualization.BarChart(document.getElementById('sa-stacked'));stchart.draw(stdata, stoptions);}")
                    Else
                        pnlStacked.Visible = False
                    End If

                    If cbPies.Checked Then
                        rptPies.Visible = True
                        Dim ta As New ITSPStatsTableAdapters.tvfGetSelfAssessmentDashboardDataTableAdapter
                        Dim t As ITSPStats.tvfGetSelfAssessmentDashboardDataDataTable = ta.GetData(Session("UserCentreID"), nBrandID, nCategoryID, nTopicID, nApplicationID, sSection, sSkill, sA1, sA2, sA3, sA4, sA5, sA6, bFilterDate, dStart, dEnd, cbSVVerified.Checked, nJobGroupID)
                        rptPies.DataSource = t
                        rptPies.DataBind()


                        'Create the pie charts
                        Dim strOptions As String = "var options = {pieHole: 0.4, chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
                        Dim strOptions2 As String = "var options = {pieHole: 0.4, colors: ['#833333', '#338333'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
                        Dim strOptions3 As String = "var options = {pieHole: 0.4, colors: ['#833333', '#F1C232', '#338333'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
                        Dim strOptions4 As String = "var options = {pieHole: 0.4, colors: ['#833333','#c38632', '#b3cc37', '#338333'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
                        Dim strOptions6 As String = "var options = {pieHole: 0.4, colors: ['#833333', '#9e5733', '#d59036', '#dfd835', '#76b137', '#338333'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"
                        Dim strOptions10 As String = "var options = {pieHole: 0.4, colors: ['#833333', '#954236', '#a85337', '#cc8237', '#e8b034', '#dfd835', '#b3cc37', '#76b137', '#499536', '#338333'], chartArea: {'width': '90%', 'height': '75%'}, legend: { position: 'none', textStyle: {fontSize:9}}};"

                        'setup the outer javascript with chart package loading and callback registration of the functions


                        Select Case DT.Columns.Count - 1
                            Case 2
                                strScript.Append(strOptions2)
                            Case 3
                                strScript.Append(strOptions3)
                            Case 4
                                strScript.Append(strOptions4)
                            Case 6
                                strScript.Append(strOptions6)
                            Case 10
                                strScript.Append(strOptions10)
                            Case Else
                                strScript.Append(strOptions)
                        End Select

                        nRow = 1
                        For Each r As DataRow In DT.Rows
                            sSkill = r(0).ToString
                            Dim sFName As String = "drawDashDonut" & StripChars(sSkill)
                            strScript.Append("google.charts.setOnLoadCallback(" & sFName & ");")
                            strScript.Append("function " & sFName & "() {         
                    var data = google.visualization.arrayToDataTable([['Descriptor','Respondents'],")
                            nCol = 1
                            For Each c As DataColumn In DT.Columns

                                If Not c.ColumnName = "Skill" Then
                                    If nCol > 1 Then
                                        strScript.Append(",")
                                    End If
                                    strScript.Append("['" & c.ColumnName & "'," & r(c).ToString & "]")
                                    nCol = nCol + 1
                                End If
                            Next
                            strScript.Append("]);")
                            strScript.Append("var chart" & nRow.ToString & " = new google.visualization.PieChart(document.getElementById('eval-chart-" & StripChars(sSkill) & "'));chart" & nRow.ToString & ".draw(data, options);}")
                            nRow = nRow + 1
                        Next
                    Else
                        rptPies.Visible = False
                    End If
                    strScript.Append("</script>")
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "dashChartsScript", strScript.ToString())

                Catch ex As Exception

                Finally
                    DT.Dispose()
                    strScript.Clear()
                End Try
            End If
        End If
    End Sub
    Function ExecuteCMD(ByRef CMD As SqlCommand) As DataSet
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("ITSP_TrackingSystemRefactor.My.MySettings.csITSPDB").ConnectionString
        Dim ds As New DataSet()

        Try
            Dim connection As New SqlConnection(connectionString)
            CMD.Connection = connection

            'Assume that it's a stored procedure command type if there is no space in the command text. Example: "sp_Select_Customer" vs. "select * from Customers"
            If CMD.CommandText.Contains(" ") Then
                CMD.CommandType = CommandType.Text
            Else
                CMD.CommandType = CommandType.StoredProcedure
            End If

            Dim adapter As New SqlDataAdapter(CMD)
            adapter.SelectCommand.CommandTimeout = 300

            'fill the dataset
            adapter.Fill(ds)
            connection.Close()

        Catch ex As Exception
            ' The connection failed. Display an error message.
            Throw New Exception("Database Error: " & ex.Message)
        End Try

        Return ds
    End Function
    Protected Function StripChars(ByVal sInput As String) As String
        Return CCommon.TidyID(sInput)
    End Function

    Private Sub dd_DataBound(sender As Object, e As EventArgs) Handles ddApplication.DataBound, ddBrand.DataBound, ddCategory.DataBound, ddJobGroupID.DataBound, ddTopic.DataBound, ddAnswer1.DataBound, ddAnswer2.DataBound, ddAnswer3.DataBound, ddAnswer4.DataBound, ddAnswer5.DataBound, ddAnswer6.DataBound
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        Dim DD As DropDownList = TryCast(sender, DropDownList)
        If Not DD Is Nothing Then
            DD.SelectedValue = CInt(Profile.GetValue("ReportFWA." & DD.ID))
        End If
    End Sub
    Private Sub ddText_DataBound(sender As Object, e As EventArgs) Handles ddSkill.DataBound, ddSection.DataBound
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
        Dim DD As DropDownList = TryCast(sender, DropDownList)
        DD.ClearSelection()
        If Not DD Is Nothing Then
            For Each i As ListItem In DD.Items
                If i.Text = Profile.GetValue("ReportFWA." & DD.ID).ToString Then
                    i.Selected = True
                    Exit For
                End If
            Next
        End If
    End Sub

    Private Sub lbtUpdateDashFilter_Command(sender As Object, e As CommandEventArgs) Handles lbtUpdateDashFilter.Command
        If e.CommandName = "Filter" Then
            Dim Profile As CEITSProfile = CEITSProfile.GetProfile(Session)
            Profile.SetValue("ReportFWA.ddJobGroupID", ddJobGroupID.SelectedValue)
            Profile.SetValue("ReportFWA.ddAnswer1", ddAnswer1.SelectedValue)

            Profile.SetValue("ReportFWA.ddAnswer2", ddAnswer2.SelectedValue)

            Profile.SetValue("ReportFWA.ddAnswer3", ddAnswer3.SelectedValue)

            Profile.SetValue("ReportFWA.ddAnswer4", ddAnswer4.SelectedValue)

            Profile.SetValue("ReportFWA.ddAnswer5", ddAnswer5.SelectedValue)

            Profile.SetValue("ReportFWA.ddAnswer6", ddAnswer6.SelectedValue)
            Profile.SetValue("ReportFWA.sAnswer1", ddAnswer1.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim())

            Profile.SetValue("ReportFWA.sAnswer2", ddAnswer2.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim())

            Profile.SetValue("ReportFWA.sAnswer3", ddAnswer3.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim())

            Profile.SetValue("ReportFWA.sAnswer4", ddAnswer4.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim())

            Profile.SetValue("ReportFWA.sAnswer5", ddAnswer5.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim())

            Profile.SetValue("ReportFWA.sAnswer6", ddAnswer6.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim())
            Profile.SetValue("ReportFWA.ddBrand", ddBrand.SelectedValue)
            Profile.SetValue("ReportFWA.ddCategory", ddCategory.SelectedValue)
            Profile.SetValue("ReportFWA.ddApplication", ddApplication.SelectedValue)
            Profile.SetValue("ReportFWA.ddSection", ddSection.SelectedValue)
            Profile.SetValue("ReportFWA.ddSkill", ddSkill.SelectedValue)
            Profile.SetValue("ReportFWA.tbStartDate", tbStartDate.Text)
            Profile.SetValue("ReportFWA.tbEndDate", tbEndDate.Text)
            Profile.SetValue("ReportFWA.cbSVVerified", cbSVVerified.Checked)
            Profile.SetValue("ReportFWA.cbStacked", cbStacked.Checked)
            Profile.SetValue("ReportFWA.cbPies", cbPies.Checked)
            LoadCustomQuestions()
            DrawDashboard()
        End If
    End Sub

    Private Sub lbtExportDashStats_Command(sender As Object, e As CommandEventArgs) Handles lbtExportDashStats.Command
        Dim dStart As Date = Date.Parse("01/01/1900")
        Dim dEnd As Date = DateTime.MaxValue
        Dim bFilterDate As Boolean = True
        If Not tbStartDate.Text = "" Then
            dStart = Date.Parse(Me.tbStartDate.Text)
        Else
            bFilterDate = False
        End If
        If Not tbEndDate.Text = "" Then
            dEnd = Date.Parse(Me.tbEndDate.Text)
        Else
            bFilterDate = False
        End If
        Dim sA1 As String = ddAnswer1.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
        Dim sA2 As String = ddAnswer2.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
        Dim sA3 As String = ddAnswer3.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
        Dim sA4 As String = ddAnswer4.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
        Dim sA5 As String = ddAnswer5.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
        Dim sA6 As String = ddAnswer6.SelectedItem.Text.Replace(vbCr, "").Replace(vbLf, "").Trim()
        Dim taSP As New ITSPStatsTableAdapters.GetSelfAssessmentDashboardDataFullTableAdapter
        Dim tsp As ITSPStats.GetSelfAssessmentDashboardDataFullDataTable = taSP.GetData(Session("UserCentreID"), ddBrand.SelectedValue, ddCategory.SelectedValue, ddTopic.SelectedValue, ddApplication.SelectedValue, ddSection.SelectedValue, ddSkill.SelectedValue, sA1, sA2, sA3, sA4, sA5, sA6, bFilterDate, dStart, dEnd, cbSVVerified.Checked, ddJobGroupID.SelectedValue)
        Dim tF As New DataTable
        tF.Columns.Add("Filter Option")
        tF.Columns.Add("Value")
        tF.TableName = "Filters Applied"
        NewRow(tF, "Brand", ddBrand.SelectedItem.Text)
        NewRow(tF, "Category", ddCategory.SelectedItem.Text)
        NewRow(tF, "Topic", ddTopic.SelectedItem.Text)
        NewRow(tF, "Course", ddApplication.SelectedItem.Text)
        NewRow(tF, "Section", ddSection.SelectedItem.Text)
        NewRow(tF, "Skill", ddSkill.SelectedItem.Text)
        NewRow(tF, "DLS Job Group", ddJobGroupID.SelectedItem.Text)
        Dim taCentres As New ITSPTableAdapters.CentresTableAdapter
        Dim tCentres As ITSP.CentresDataTable
        Dim nCentreID As Integer = CInt(Session("UserCentreID"))

        tCentres = taCentres.GetByCentreID(nCentreID)
        If tCentres.Count = 1 Then

            Dim dr As ITSP.CentresRow = tCentres.First
            If Not dr.F1Options.Length = 0 And Not dr.F1Name.Length = 0 Then
                NewRow(tF, dr.F1Name, sA1)
            End If
            If Not dr.F2Options.Length = 0 And Not dr.F2Name.Length = 0 Then
                NewRow(tF, dr.F2Name, sA2)
            End If
            If Not dr.F3Options.Length = 0 And Not dr.F3Name.Length = 0 Then
                NewRow(tF, dr.F3Name, sA3)
            End If
            If Not dr.F4Options.Length = 0 And Not dr.F4Name.Length = 0 Then
                NewRow(tF, dr.F4Name, sA4)
            End If
            If Not dr.F5Options.Length = 0 And Not dr.F5Name.Length = 0 Then
                NewRow(tF, dr.F5Name, sA5)
            End If
            If Not dr.F6Options.Length = 0 And Not dr.F6Name.Length = 0 Then
                NewRow(tF, dr.F6Name, sA6)
            End If
        End If

        If bFilterDate Then
            NewRow(tF, "Start Date", tbStartDate.Text)
            NewRow(tF, "End Date", tbEndDate.Text)
        End If

        NewRow(tF, "Supervisor Verified Only", cbSVVerified.Checked.ToString())
        tsp.TableName = "Response Detail"

        'Get pivot table:
        Dim ta As New ITSPStatsTableAdapters.tvfGetSelfAssessmentDashboardDataTableAdapter
        Dim t As ITSPStats.tvfGetSelfAssessmentDashboardDataDataTable = ta.GetData(Session("UserCentreID"), ddBrand.SelectedValue, ddCategory.SelectedValue, ddTopic.SelectedValue, ddApplication.SelectedValue, ddSection.SelectedValue, ddSkill.SelectedValue, sA1, sA2, sA3, sA4, sA5, sA6, bFilterDate, dStart, dEnd, cbSVVerified.Checked, ddJobGroupID.SelectedValue)
        rptPies.DataSource = t
        rptPies.DataBind()
        Dim cmd As New SqlCommand("GetSelfAssessmentDashboardDataPivot")
        cmd.Parameters.AddWithValue("@CentreID", Session("UserCentreID"))
        cmd.Parameters.AddWithValue("@BrandID", ddBrand.SelectedValue)
        cmd.Parameters.AddWithValue("@Category", ddCategory.SelectedValue)
        cmd.Parameters.AddWithValue("@Topic", ddTopic.SelectedValue)
        cmd.Parameters.AddWithValue("@ApplicationID", ddApplication.SelectedValue)
        cmd.Parameters.AddWithValue("@SectionName", ddSection.SelectedValue)
        cmd.Parameters.AddWithValue("@TutorialName", ddSkill.SelectedValue)
        cmd.Parameters.AddWithValue("@Answer1", sA1)
        cmd.Parameters.AddWithValue("@Answer2", sA2)
        cmd.Parameters.AddWithValue("@Answer3", sA3)
        cmd.Parameters.AddWithValue("@Answer4", sA4)
        cmd.Parameters.AddWithValue("@Answer5", sA5)
        cmd.Parameters.AddWithValue("@Answer6", sA6)
        cmd.Parameters.AddWithValue("@FilterDate", bFilterDate)
        cmd.Parameters.AddWithValue("@StartDate", dStart)
        cmd.Parameters.AddWithValue("@EndDate", dEnd)
        cmd.Parameters.AddWithValue("@VerifiedOnly", cbSVVerified.Checked)
        cmd.Parameters.AddWithValue("@JobGroupID", ddJobGroupID.SelectedValue)
        Dim ds As DataSet = ExecuteCMD(cmd)
        If ds.Tables.Count > 0 Then
            Dim DT As DataTable = ExecuteCMD(cmd).Tables(0)
            DT.TableName = "Response Summary"
            ds.Tables.Add(tsp)
            ds.Tables.Add(tF)
            XMLExport.ExportToExcel(ds, "DLS Self Assessment Response Data " & Date.Now.Year.ToString & "-" & Date.Now.Month.ToString & "-" & Date.Now.Day.ToString & ".xlsx", Page.Response)
        End If

    End Sub
    Protected Sub NewRow(ByRef t As DataTable, ByVal sc1 As String, ByVal sc2 As String)
        Dim r As DataRow = t.NewRow
        r(0) = sc1
        r(1) = sc2
        t.Rows.Add(r)
    End Sub



End Class