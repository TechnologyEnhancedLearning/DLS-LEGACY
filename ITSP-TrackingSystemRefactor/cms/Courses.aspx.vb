Imports System.IO
Imports DevExpress.Web

Public Class Courses
    Inherits System.Web.UI.Page
    Public Property bAllowNewCourse As Boolean = True
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        cbFilterForCentre.Visible = Session("UserPublishToAll")
        If Not Page.IsPostBack Then
            UpdateUsageDisplay()
        End If
        If Not bAllowNewCourse Then
            lbtAdd.Enabled = False
            lbtAdd.CssClass = lbtAdd.CssClass & " disabled"
        End If
    End Sub
    Protected ReadOnly Property sCurrentDate As String
        Get
            Return Date.Now.Year.ToString & "-" & Date.Now.Month.ToString & "-" & Date.Now.Day.ToString
        End Get
    End Property

    Protected Sub EditDetails_Click(sender As Object, e As CommandEventArgs)
        Dim nCourseID As Integer = e.CommandArgument
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        CourseSettings.LoadSettingsFromString(taq.GetCourseSettings(nCourseID)).SetSettings(Session)
        Dim ods As ObjectDataSource = Me.dsCourseDetails
        ods.SelectParameters(0).DefaultValue = nCourseID
        fvCourseDetail.ChangeMode(FormViewMode.Edit)
        Me.mvCourses.SetActiveView(Me.vCourseDetails)
    End Sub
    Protected Sub ManageContent_Click(sender As Object, e As CommandEventArgs)
        Dim nCourseID As Integer = e.CommandArgument
        Response.Redirect("~/cms/ManageContent.aspx?courseid=" & nCourseID.ToString())
    End Sub
    'Protected Sub ViewStats_Click(sender As Object, e As CommandEventArgs)
    '    Dim nCourseID As Integer = e.CommandArgument
    '    Dim taApp As New itspdbTableAdapters.ApplicationsTableAdapter
    '    Dim tApp As New itspdb.ApplicationsDataTable
    '    tApp = taApp.GeByApplicationID(nCourseID)
    '    Dim sAppTitle As String = tApp.First.ApplicationName
    '    lblUsageChartHeading.Text = sAppTitle & " - Course Usage Chart"
    '    Dim taRegComp As New itspdbTableAdapters.uspGetRegCompNewTableAdapter
    '    Dim tRegComp As New itspdb.uspGetRegCompNewDataTable
    '    Try
    '        tRegComp = taRegComp.GetFiltered(3, -1, nCourseID, -1, -1, -1, -1, -1, -1, Date.Now.AddYears(-1), Date.Now())
    '    Catch ex As Exception

    '    End Try
    '    Dim sJSONString As String = CCommon.ConvertDataTabletoString(tRegComp)
    '    'Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalRequestAdded", "<script>$('#modalMessage').modal('show');</script>")
    '    Page.ClientScript.RegisterStartupScript(Me.Page.GetType(), "activitychart", "doActivityChart('activity-chart', " & sJSONString & ");", True)
    '    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalStats", "$('#modalStats').modal('show');", True)
    'End Sub
    Protected Sub Publish_Click(sender As Object, e As CommandEventArgs)
        Dim nCourseID As Integer = e.CommandArgument
        Response.Redirect("~/cms/Publish.aspx?courseid=" & nCourseID.ToString())
    End Sub
    Protected Sub Archive_Click(sender As Object, e As CommandEventArgs)
        Dim nCourseID As Integer = e.CommandArgument
        hfArchiveCourseID.Value = e.CommandArgument
        Dim taApp As New itspdbTableAdapters.ApplicationsTableAdapter
        Dim tApp As New itspdb.ApplicationsDataTable
        tApp = taApp.GeByApplicationID(nCourseID)
        hfCourseTitle.Value = tApp.First.ApplicationName
        lblArchiveCourse.Text = "Archive " & tApp.First.ApplicationName
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalArchiveConfirm", "<script>$('#modalArchiveConfirm').modal('show');</script>")
        UpdateUsageDisplay()
    End Sub

    Protected Sub ExportStats_Click(sender As Object, e As CommandEventArgs)
        Dim nCourseID As Integer = e.CommandArgument
        Dim taApp As New itspdbTableAdapters.ApplicationsTableAdapter
        Dim tApp As New itspdb.ApplicationsDataTable
        tApp = taApp.GeByApplicationID(nCourseID)
        Dim sAppTitle As String = tApp.First.ApplicationName
        Dim DS_Export As New DataSet("Stats Export")
        Dim ta As New itspdbTableAdapters.CourseStatsTableAdapter
        Dim dt As New itspdb.CourseStatsDataTable
        dt = ta.GetData(nCourseID)
        dt.TableName = "Overall Activity"
        Dim ta2 As New itspdbTableAdapters.CourseStatsByCentreTableAdapter
        Dim dt2 As New itspdb.CourseStatsByCentreDataTable
        dt2 = ta2.GetData(nCourseID)
        dt2.TableName = "Activity by Centre"
        Dim ta3 As New itspdbTableAdapters.CourseAssessmentStatsTableAdapter
        Dim dt3 As New itspdb.CourseAssessmentStatsDataTable
        dt3 = ta3.GetData(nCourseID)
        dt3.TableName = "Assessment Outcomes"
        Dim ta4 As New itspdbTableAdapters.CourseDetailForAppTableAdapter
        Dim dt4 As New itspdb.CourseDetailForAppDataTable
        dt4 = ta4.GetData(nCourseID)
        dt4.TableName = "Delegate Progress Detail"
        DS_Export.Tables.Add(dt)
        DS_Export.Tables.Add(dt2)
        DS_Export.Tables.Add(dt3)
        If dt4.Count > 0 Then
            DS_Export.Tables.Add(dt4)
        End If
        XMLExport.ExportToExcel(DS_Export, "DLS " & sAppTitle & " Stats " & sCurrentDate & ".xlsx", Page.Response)
    End Sub

    Private Sub fvCourseDetail_DataBound(sender As Object, e As EventArgs) Handles fvCourseDetail.DataBound
        If fvCourseDetail.CurrentMode = FormViewMode.Insert Then
            Dim hEmbedResTextBox As TextBox = fvCourseDetail.FindControl("hEmbedResTextBox")
            Dim tbvEmbedRes As TextBox = fvCourseDetail.FindControl("tbvEmbedRes")
            Dim DebugCheckBox As CheckBox = fvCourseDetail.FindControl("DebugCheckBox")
            Dim hfcentreid As HiddenField = fvCourseDetail.FindControl("hfCreatedByCentreID")
            Dim hfcreatedbyid As HiddenField = fvCourseDetail.FindControl("hfCreatedByID")
            Dim tbCreatedBy As TextBox = fvCourseDetail.FindControl("CreatedByTextBox")
            Dim tbCentre As TextBox = fvCourseDetail.FindControl("CreatedByCentreIDTextBox")
            Dim ddBrand As DropDownList = fvCourseDetail.FindControl("ddBrand")
            Dim ddCategory As DropDownList = fvCourseDetail.FindControl("ddCategory")
            Dim ddTopic As DropDownList = fvCourseDetail.FindControl("ddTopic")
            Dim spinThresh As Bootstrap.BootstrapSpinEdit = fvCourseDetail.FindControl("bspinAssessPassThreshold")
            Dim spinAttempts As Bootstrap.BootstrapSpinEdit = fvCourseDetail.FindControl("bspinAssessAttempts")
            If Not hEmbedResTextBox Is Nothing Then
                hEmbedResTextBox.Text = 1024
            End If
            If Not tbvEmbedRes Is Nothing Then
                tbvEmbedRes.Text = 768
            End If
            If Not DebugCheckBox Is Nothing Then
                DebugCheckBox.Checked = True
            End If
            If Not tbCentre Is Nothing Then
                tbCentre.Text = Session("UserCentreName")
            End If
            If Not tbCreatedBy Is Nothing Then
                tbCreatedBy.Text = Session("UserForename") & " " & Session("UserSurname")
            End If
            If Not hfcentreid Is Nothing Then
                hfcentreid.Value = Session("UserCentreID")
            End If
            If Not hfcreatedbyid Is Nothing Then
                hfcreatedbyid.Value = Session("UserAdminID")
            End If
            If Not spinAttempts Is Nothing Then
                spinAttempts.Text = 0
            End If
            If Not spinThresh Is Nothing Then
                spinThresh.Number = 85
            End If
            If Not ddCategory Is Nothing Then
                For Each i As ListItem In ddCategory.Items
                    If i.Text = "Undefined" Then
                        i.Selected = True
                    End If
                Next
            End If
            If Not ddTopic Is Nothing Then
                For Each i As ListItem In ddTopic.Items
                    If i.Text = "Undefined" Then
                        i.Selected = True
                    End If
                Next
            End If
            If Not ddBrand Is Nothing Then
                Dim taq As New itspdbTableAdapters.QueriesTableAdapter
                Dim nBrandID As Integer = taq.GetBrandForCentre(Session("UserCentreID"))
                ddBrand.SelectedValue = nBrandID
                If Not Session("UserPublishToAll") Then
                    ddBrand.Enabled = False
                End If
            End If
        End If
    End Sub

    Private Sub fvCourseDetail_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvCourseDetail.ItemCommand
        If e.CommandName = "Cancel" Then
            'fvCourseDetail.ChangeMode(FormViewMode.Edit)
            'fvCourseDetail.DataBind()
            Me.mvCourses.SetActiveView(Me.vCourseList)
        End If
    End Sub

    Private Sub fvCourseDetail_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvCourseDetail.ItemInserted
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        Dim nappid As Integer = taq.GetMaxAppIDForAdmin(Session("UserAdminID"))
        CourseSettings.LoadSettingsFromString(taq.GetCourseSettings(nappid)).SetSettings(Session)
        StoreCourseSettings(nappid)
        bsgvCourses.DataBind()
        Me.mvCourses.SetActiveView(Me.vCourseList)
        fvCourseDetail.ChangeMode(FormViewMode.Edit)
        lblModalHeading.Text = "Course Added"
        lblModalText.Text = "Course details were successfully saved."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalRequestAdded", "<script>$('#modalMessage').modal('show');</script>")
        UpdateUsageDisplay()
    End Sub

    Private Sub fvCourseDetail_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvCourseDetail.ItemUpdated
        Dim nApplicationID As Integer = fvCourseDetail.DataKey.Value
        StoreCourseSettings(nApplicationID)
        bsgvCourses.DataBind()
        Me.mvCourses.SetActiveView(Me.vCourseList)
        lblModalHeading.Text = "Course Details Updated"
        lblModalText.Text = "Course details were successfully updated."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalRequest", "<script>$('#modalMessage').modal('show');</script>")
        UpdateUsageDisplay()
    End Sub
    Private Sub StoreCourseSettings(ByVal nApplicationID As Integer)
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        Dim Settings As CourseSettings = CourseSettings.GetSettings(Session)
        If Not Settings Is Nothing Then
            ' We've got settings. If dirty then save to the Applications table.
            Dim tbSupervisor As TextBox = fvCourseDetail.FindControl("tbSupervisor")
            Dim tbVerification As TextBox = fvCourseDetail.FindControl("tbVerification")
            Dim tbSupportingInformation As TextBox = fvCourseDetail.FindControl("tbSupportingInformation")
            Dim tbConsolidationExercise As TextBox = fvCourseDetail.FindControl("tbConsolidationExercise")
            Dim tbReview As TextBox = fvCourseDetail.FindControl("tbReview")
            Dim tbSkills As TextBox = fvCourseDetail.FindControl("tbSkills")
            Dim tbDevelopmentLog As TextBox = fvCourseDetail.FindControl("tbDevelopmentLog")
            Dim tbPlanned As TextBox = fvCourseDetail.FindControl("tbPlanned")
            Dim tbCompleted As TextBox = fvCourseDetail.FindControl("tbCompleted")
            Dim tbAddPlanned As TextBox = fvCourseDetail.FindControl("tbAddPlanned")
            Dim tbAddCompleted As TextBox = fvCourseDetail.FindControl("tbAddCompleted")
            Dim tbExpectedOutcomes As TextBox = fvCourseDetail.FindControl("tbExpectedOutcomes")
            Dim cbShowDLSCourses As CheckBox = fvCourseDetail.FindControl("cbShowDLSCourses")
            Dim cbShowMethod As CheckBox = fvCourseDetail.FindControl("cbShowMethod")
            Dim cbShowFileUpload As CheckBox = fvCourseDetail.FindControl("cbShowFileUpload")
            Dim tbRecordPlannedDevelopmentActivity As TextBox = fvCourseDetail.FindControl("tbRecordPlannedDevelopmentActivity")
            Dim tbRecordCompletedDevelopmentActivityEvidence As TextBox = fvCourseDetail.FindControl("tbRecordCompletedDevelopmentActivityEvidence")
            Dim tbMethod As TextBox = fvCourseDetail.FindControl("tbMethod")
            Dim tbActivity As TextBox = fvCourseDetail.FindControl("tbActivity")
            Dim tbDueDateTime As TextBox = fvCourseDetail.FindControl("tbDueDateTime")
            Dim tbCompletedDate As TextBox = fvCourseDetail.FindControl("tbCompletedDate")
            Dim tbDuration As TextBox = fvCourseDetail.FindControl("tbDuration")
            Dim cbShowPercentage As CheckBox = fvCourseDetail.FindControl("cbShowPercentage")
            Dim cbShowTime As CheckBox = fvCourseDetail.FindControl("cbShowTime")
            Dim cbShowLearnStatus As CheckBox = fvCourseDetail.FindControl("cbShowLearnStatus")
            Dim cbShowSkillMapping As CheckBox = fvCourseDetail.FindControl("cbShowSkillMapping")
            Dim cbShowPlanned As CheckBox = fvCourseDetail.FindControl("cbShowPlanned")
            Dim cbShowCompleted As CheckBox = fvCourseDetail.FindControl("cbShowCompleted")
            Dim cbReflectiveAccount As CheckBox = fvCourseDetail.FindControl("cbReflectiveAccount")
            Settings.SetValue("LearnMenu.ShowPercentage", cbShowPercentage.Checked)
            Settings.SetValue("LearnMenu.ShowTime", cbShowTime.Checked)
            Settings.SetValue("LearnMenu.ShowLearnStatus", cbShowLearnStatus.Checked)
            Settings.SetValue("LearnMenu.Supervisor", tbSupervisor.Text)
            Settings.SetValue("LearnMenu.Verification", tbVerification.Text)
            Settings.SetValue("LearnMenu.SupportingInformation", tbSupportingInformation.Text)
            Settings.SetValue("LearnMenu.ConsolidationExercise", tbConsolidationExercise.Text)
            Settings.SetValue("LearnMenu.Review", tbReview.Text)
            Settings.SetValue("DevelopmentLog.ShowPlanned", cbShowPlanned.Checked)
            Settings.SetValue("DevelopmentLog.ShowCompleted", cbShowCompleted.Checked)
            Settings.SetValue("DevelopmentLog.IncludeReflectiveAccount", cbReflectiveAccount.Checked)
            Settings.SetValue("DevelopmentLogForm.Skill", tbSkills.Text)
            Settings.SetValue("DevelopmentLog.DevelopmentLog", tbDevelopmentLog.Text)
            Settings.SetValue("DevelopmentLog.Planned", tbPlanned.Text)
            Settings.SetValue("DevelopmentLog.Completed", tbCompleted.Text)
            Settings.SetValue("DevelopmentLog.AddPlanned", tbAddPlanned.Text)
            Settings.SetValue("DevelopmentLog.AddCompleted", tbAddCompleted.Text)
            Settings.SetValue("DevelopmentLog.ExpectedOutcomes", tbExpectedOutcomes.Text)
            Settings.SetValue("DevelopmentLogForm.ShowDLSCourses", cbShowDLSCourses.Checked)
            Settings.SetValue("DevelopmentLogForm.ShowMethod", cbShowMethod.Checked)
            Settings.SetValue("DevelopmentLogForm.ShowFileUpload", cbShowFileUpload.Checked)
            Settings.SetValue("DevelopmentLogForm.ShowSkillMapping", cbShowSkillMapping.Checked)
            Settings.SetValue("DevelopmentLogForm.RecordPlannedDevelopmentActivity", tbRecordPlannedDevelopmentActivity.Text)
            Settings.SetValue("DevelopmentLogForm.RecordCompletedDevelopmentActivityEvidence", tbRecordCompletedDevelopmentActivityEvidence.Text)
            Settings.SetValue("DevelopmentLogForm.Method", tbMethod.Text)
            Settings.SetValue("DevelopmentLogForm.Activity", tbActivity.Text)
            Settings.SetValue("DevelopmentLogForm.DueDateTime", tbDueDateTime.Text)
            Settings.SetValue("DevelopmentLogForm.CompletedDate", tbCompletedDate.Text)
            Settings.SetValue("DevelopmentLogForm.Duration", tbDuration.Text)
            If Settings.IsDirty() Then
                Dim taAdminUsers = New ITSPTableAdapters.AdminUsersTableAdapter
                Dim sCourseSettings As String = Settings.GetSettingsAsString()
                taq.UpdateCourseSettings(sCourseSettings, nApplicationID)
            End If
        End If
    End Sub
    Private Sub lbtAdd_Click(sender As Object, e As EventArgs) Handles lbtAdd.Click
        CourseSettings.LoadSettingsFromString("").SetSettings(Session)
        lblCourseFormHeading.Text = "Add Course"
        fvCourseDetail.ChangeMode(FormViewMode.Insert)
        Me.mvCourses.SetActiveView(Me.vCourseDetails)
    End Sub
    Public Property bImageUpdated = True
    Protected Sub bimgCourseImage_ValueChanged(sender As Object, e As EventArgs)
        Dim bimg As ASPxBinaryImage = TryCast(sender, ASPxBinaryImage)
        If Not bimg.Value Is Nothing And bImageUpdated Then
            Dim myMemStream As New IO.MemoryStream(CType(bimg.Value, Byte()))
            bimg.Value = CCommon.resizeImageFromMemoryStream(myMemStream, 400, 300).ToArray()
            bimg.Width = 400
            bimg.Height = 300
            bImageUpdated = False
        Else
            bImageUpdated = True
        End If
    End Sub

    Private Sub lbtArchiveDelete_Click(sender As Object, e As EventArgs) Handles lbtArchiveDelete.Click
        Dim nCourseID As Integer = hfArchiveCourseID.Value

        lblModalText.Text = "<p>The course was successfully archived.</p><p>All content uploaded against it has been permanently deleted from the server and will need to be uploaded again if the course is unarchived.</p>"
        'delete all uploaded content related to the course:
        Dim fPath As String = Server.MapPath("~/cms/CMSContent/") & "Course" + nCourseID.ToString + "\"
        Try
            If Directory.Exists(fPath) Then
                Directory.Delete(fPath, True)

            End If
            Dim taq As New itspdbTableAdapters.QueriesTableAdapter
            taq.UpdateApplicationServerSpace(0, nCourseID)
            taq.UpdateServerSpaceUsedForCentreID(Session("UserCentreID"))
        Catch Ex As Exception
            lblModalText.Text = "<p>The course was successfully archived.</p><p>Uploaded content could not be removed because the server reported the following error:</p><hr/><p><i>" & Ex.Message & "</i><\p>"
        End Try


        ArchiveCourse(nCourseID)
    End Sub

    Private Sub lbtArchiveOnly_Click(sender As Object, e As EventArgs) Handles lbtArchiveOnly.Click
        lblModalText.Text = "<p>The course was successfully archived.</p><p>Uploaded content remains on the server and will be available if unarchived.</p>"
        ArchiveCourse(hfArchiveCourseID.Value)
    End Sub
    Protected Sub ArchiveCourse(ByVal nCourseID As Integer)
        lblModalHeading.Text = hfCourseTitle.Value.ToString & " - Course Archived"
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        taq.ArchiveCourse(Session("UserAdminID"), nCourseID)
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalArchived", "<script>$('#modalMessage').modal('show');</script>")
        bsgvCourses.DataBind()
        UpdateUsageDisplay()
    End Sub

    Protected Sub lbtUnarchive_Command(sender As Object, e As CommandEventArgs)
        Dim nCourseID As Integer = e.CommandArgument
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        taq.UnarchiveAppByID(nCourseID)
        bsgvCourses.DataBind()
        UpdateUsageDisplay()
        lblModalHeading.Text = "Course Unarchived"
        lblModalText.Text = "<p>The course was successfully unarchived.</p><p>If uploaded content was deleted during archiving, you will need to upload it again before publishing the course.</p>"
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalUnarchived", "<script>$('#modalMessage').modal('show');</script>")
    End Sub
    Protected Sub UpdateUsageDisplay()
        Dim taDash As New ITSPTableAdapters.ContractUsageDashTableAdapter
        Dim tDash As New ITSP.ContractUsageDashDataTable
        tDash = taDash.GetData(Session("UserCentreID"))
        If tDash.Count = 1 Then
            Dim nLimit As Integer = tDash.First.CustomCoursesLimit

            If nLimit = -1 Then
                pnlUsage.Visible = False
            Else
                Dim nCourses As Integer = tDash.First.CustomCourses
                lblUsed.Text = nCourses
                lblAvailable.Text = nLimit
                Dim percentageusage As Integer = 0
                If nLimit > 0 Then
                    percentageusage = (nCourses * 100) / nLimit

                Else
                    If nCourses = 0 Then
                        percentageusage = 0
                    Else
                        percentageusage = 100
                    End If

                End If
                If percentageusage > 100 Then
                    percentageusage = 100
                End If
                progbar.Attributes.Add("aria-valuenow", percentageusage.ToString())
                progbar.Attributes.Add("style", "width:" & percentageusage.ToString() & "%;")
                lblPercent.Text = percentageusage.ToString() & "%"
                bAllowNewCourse = True
                Select Case percentageusage
                    Case >= 100
                        pnlUsage.Attributes.Add("class", "card card-danger")
                        bAllowNewCourse = False
                        pnlExceeded.Visible = True
                    Case > 90
                        pnlUsage.Attributes.Add("class", "card card-danger")
                    Case < 60
                        pnlUsage.Attributes.Add("class", "card card-success")
                    Case Else
                        pnlUsage.Attributes.Add("class", "card card-warning")
                End Select
            End If
        Else
            pnlUsage.Visible = False
        End If
    End Sub
    Protected Function NiceBytes(ByVal lBytes As Long)
        Return CCommon.BytesToString(lBytes)
    End Function
    Protected Function GetCS(ByVal sSetting As String)
        Dim Settings As CourseSettings = CourseSettings.GetSettings(Session)
        If Not Settings Is Nothing Then
            Return Settings.GetValue(sSetting)
        Else
            Return "False"
        End If
    End Function



End Class