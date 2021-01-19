Imports DevExpress.Web.Bootstrap

Public Class coursesetup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sTrackingURL As String = CCommon.GetConfigString("TrackingSystemBaseURL")
        Session("TSURL") = sTrackingURL
        If Session("AdminCategoryID") > 0 Then
            ddTopicnNewFilter.CssClass = "d-none"
        End If
        ddCoursePrompt1.DataBind()
        ddCoursePrompt2.DataBind()
        ddCoursePrompt3.DataBind()
    End Sub
    Protected Sub Edit_Click(sender As Object, e As CommandEventArgs)
        Session("tsCustomisationID") = e.CommandArgument
        LoadEditValues(e.CommandArgument)
        'rptSections.DataBind()
        mvCourseSetup.SetActiveView(vEditCourse)

    End Sub
    Private Sub lbtAddCourse_Click(sender As Object, e As EventArgs) Handles lbtAddCourse.Click
        Session("tsCustomisationID") = 0
        LoadAddValues(ddApplication.SelectedValue)
        mvCourseSetup.SetActiveView(vEditCourse)
    End Sub
    Protected Sub LoadEditValues(ByVal nCustomisationID As Integer)
        'Load customisation info from table adapter:
        Dim taCus As New customiseTableAdapters.CustomisationsTableAdapter
        Dim tCus As customise.CustomisationsDataTable = taCus.GetData(nCustomisationID)
        If tCus.Count = 1 Then

            Dim r As customise.CustomisationsRow = tCus.First
            'Populate course details:
            hfLearners.Value = r.CandidateCountInProgress
            lblLearners.Text = r.CandidateCountInProgress
            hfCompletions.Value = r.Completions
            lblCompletions.Text = r.Completions
            lblVersion.Text = r.CurrentVersion
            lblCreated.Text = FormatDateTime(r.CreatedDate, DateFormat.ShortDate)
            If r.IsLastAccessNull Then
                lblLastAccess.Text = "Never"
            Else
                lblLastAccess.Text = FormatDateTime(r.LastAccess, DateFormat.ShortDate)
            End If
            hfAssessAvail.Value = r.AssessAvailable
            hfHasAssess.Value = r.HasAssess
            lblAppNameAdd.Text = r.AppName
            tbCustName.Text = r.CustomisationName
            tbCoursePassword.Text = r.Password
            ActiveCheckBox.Checked = r.Active
            hfPostLearn.Value = r.IsAssessed
            cbAllowSelfRegistration.Checked = r.SelfRegister
            cbHideInLearningPortal.Checked = r.HideInLearnerPortal
            cbDiagObjSelection.Checked = r.DiagObjSelect
            cbDiagObjSelection.Visible = r.HasDiag
            cbDiagnostic.Visible = r.HasDiag
            lblDiagCol.Visible = r.HasDiag
            pnlPL.Visible = r.HasAssess
            cbPostLearning.Checked = r.IsAssessed
            cbInviteContributors.Checked = r.InviteContributors
            If r.IsAssessed And r.HasAssess Then
                pnlThresh.CssClass = "form-group collapse"
            Else
                pnlThresh.CssClass = "form-group collapse show"
            End If
            spinLearnThresh.Number = r.TutCompletionThreshold
            pnlDiagnosticAdd.Visible = r.HasDiag
            spinDiagnosticThresh.Number = r.DiagCompletionThreshold
            'Populate learning pathway defaults
            spinCompleteWithinMonths.Number = r.CompleteWithinMonths
            cbMandatory.Checked = r.Mandatory
            spinValidityMonths.Number = r.ValidityMonths
            cbAutoRefresh.Checked = r.AutoRefresh
            collapseRefresh.Attributes.Remove("class")
            If r.AutoRefresh Then
                collapseRefresh.Attributes.Add("class", "form-group collapse show")
            Else
                collapseRefresh.Attributes.Add("class", "form-group collapse")
            End If
            ddResfreshTo.SelectedValue = r.RefreshToCustomisationID
            spinEnrolMonths.Number = r.AutoRefreshMonths
            'populate course admin fields:
            cbApplyToSelfEnrol.Checked = r.ApplyLPDefaultsToSelfEnrol
            ddCoursePrompt1.SelectedValue = r.CourseField1PromptID
            Q1OptionsText.Text = r.Q1Options
            ddCoursePrompt2.SelectedValue = r.CourseField2PromptID
            Q2OptionsText.Text = r.Q2Options
            ddCoursePrompt3.SelectedValue = r.CourseField3PromptID
            Q3OptionsText.Text = r.Q3Options
            tbCCEmail.Text = r.NotificationEmails
            Dim taSec As New customiseTableAdapters.SectionsTableAdapter
            Dim tSec As customise.SectionsDataTable = taSec.GetData(nCustomisationID)
            rptSections.DataSource = tSec
            rptSections.DataBind()
        End If
    End Sub
    Protected Sub LoadAddValues(ByVal nApplicationID As Integer)
        Dim taApp As New customiseTableAdapters.ApplicationInfoTableAdapter
        Dim tApp As customise.ApplicationInfoDataTable = taApp.GetData(nApplicationID)
        If tApp.Count = 1 Then
            Dim r As customise.ApplicationInfoRow = tApp.First
            hfLearners.Value = 0
            lblLearners.Text = ""
            hfCompletions.Value = 0
            lblCompletions.Text = ""
            lblVersion.Text = "1"
            hfAssessAvail.Value = r.AssessAvailable
            hfHasAssess.Value = r.HasAssess
            lblAppNameAdd.Text = r.AppName
            tbCustName.Text = ""
            tbCoursePassword.Text = ""
            tbCCEmail.Text = ""
            hfPostLearn.Value = r.HasAssess
            cbDiagObjSelection.Visible = r.HasDiag
            cbDiagObjSelection.Checked = True
            cbDiagnostic.Visible = r.HasDiag
            lblDiagCol.Visible = r.HasDiag
            ActiveCheckBox.Checked = True
            cbAllowSelfRegistration.Checked = True
            cbInviteContributors.Checked = False
            cbHideInLearningPortal.Checked = 0
            cbPostLearning.Checked = r.HasAssess
            spinLearnThresh.Number = 100
            spinValidityMonths.Number = 0
            spinDiagnosticThresh.Number = 85
            spinCompleteWithinMonths.Number = 0
            spinEnrolMonths.Number = 0
            pnlPL.Visible = r.HasAssess
            cbMandatory.Checked = False
            cbAutoRefresh.Checked = False
            ddResfreshTo.SelectedValue = 0
            ddCoursePrompt1.SelectedValue = 0
            Q1OptionsText.Text = ""
            ddCoursePrompt2.SelectedValue = 0
            Q2OptionsText.Text = ""
            ddCoursePrompt3.SelectedValue = 0
            Q3OptionsText.Text = ""
            If r.HasAssess Then
                pnlThresh.CssClass = "form-group collapse"
            Else
                pnlThresh.CssClass = "form-group collapse show"
            End If
            pnlCurrentUsage.Visible = False
        End If
        Dim taSec As New customiseTableAdapters.SectionsTableAdapter
        Dim tSec As customise.SectionsDataTable = taSec.GetForNew(nApplicationID)
        rptSections.DataSource = tSec
        rptSections.DataBind()
    End Sub

    Private Sub cbDiagnostic_CheckedChanged(sender As Object, e As EventArgs) Handles cbDiagnostic.CheckedChanged
        Dim bStatus As Boolean = cbDiagnostic.Checked
        Dim cbSec As CheckBox
        Dim cbDiag As CheckBox
        For Each i As RepeaterItem In rptSections.Items
            cbSec = CType(i.FindControl("cbDiag"), CheckBox)
            If Not cbSec Is Nothing Then
                cbSec.Checked = bStatus
                Dim rptTut As Repeater = CType(i.FindControl("rptTutorials"), Repeater)
                If Not rptTut Is Nothing Then
                    For Each ci As RepeaterItem In rptTut.Items
                        cbDiag = CType(ci.FindControl("cbDiag"), CheckBox)
                        cbDiag.Checked = bStatus
                    Next
                End If
            End If
        Next
    End Sub
    Protected Function GetEmail(ByVal nCustomisationID As Integer, ByVal sCustomisationName As String, ByVal sPassword As String) As String

        Dim sLink As String


        '
        ' Set up password
        '
        If sPassword <> String.Empty Then
            sPassword = ". Use the password '" & sPassword & "'."
        End If
        '
        ' Set up launch hotlink
        '

        If Session("NoITSPLogo") Is Nothing Then
            sLink = CCommon.GetServerURL("https", 80) & "learn" &
                  "?CentreID=" & Session("UserCentreID") &
                  "&CustomisationID=" & nCustomisationID.ToString
        Else
            'pass nobrand=1 parameter to hide the standard ITSP logo on learning menu:
            sLink = CCommon.GetServerURL("https", 80) & "learn" &
                  "?CentreID=" & Session("UserCentreID") &
                  "&CustomisationID=" & nCustomisationID.ToString &
                "&nobrand=1"
        End If

        Dim sEmailLink As String = "mailto:?subject=Digital Learning Solutions Course Link - " &
         sCustomisationName.Replace("&", "%26") & "&body=To start your " &
         sCustomisationName.Replace("&", "%26") & " course, click " & sLink.Replace("&", "%26") & sPassword.Replace("&", "%26")
        Return sEmailLink
    End Function
    Protected Sub rptTutorials_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim cbDiag As CheckBox = e.Item.FindControl("cbDiag")
        If Not cbDiag Is Nothing Then
            Dim cbDiagSec As CheckBox = e.Item.Parent.Parent.FindControl("cbDiag")
            If Not cbDiagSec Is Nothing Then
                '  cbDiagnostic.Visible = cbDiag.Visible
                '  cbDiagSec.Visible = cbDiag.Visible
                '  lblDiagCol.Visible = cbDiag.Visible
                If cbDiag.Checked = False Then

                    cbDiagSec.Checked = False
                    cbDiag.Checked = False
                End If
            End If
        End If
        Dim cbLearn As CheckBox = e.Item.FindControl("cbLearn")
        If Not cbLearn Is Nothing Then
            If cbLearn.Checked = False Then
                Dim cbLearnSec As CheckBox = e.Item.Parent.Parent.FindControl("cbLearn")
                If Not cbLearnSec Is Nothing Then
                    cbLearnSec.Checked = False
                    cbLearning.Checked = False
                End If
            End If
        End If
    End Sub

    Protected Sub rptSections_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim i As RepeaterItem = TryCast(e.Item, RepeaterItem)
        If Not i Is Nothing Then
            Dim hf As HiddenField = i.FindControl("hfSectionID")
            Dim rpt As Repeater = i.FindControl("rptTutorials")
            If Not hf Is Nothing And Not rpt Is Nothing Then
                Dim nSectionID As Integer = hf.Value
                Dim taTut As New customiseTableAdapters.CustomisationTutorialsTableAdapter
                Dim tTut As New customise.CustomisationTutorialsDataTable
                If Session("tsCustomisationID") > 0 Then
                    tTut = taTut.GetData(Session("tsCustomisationID"), nSectionID)
                Else
                    tTut = taTut.GetDataForNew(nSectionID)
                End If
                rpt.DataSource = tTut
                rpt.DataBind()
            End If
        End If
    End Sub
    Private Sub lbtCancelUpdate_Click(sender As Object, e As EventArgs) Handles lbtCancelUpdate.Click
        'Send user back to customisation list
        mvCourseSetup.SetActiveView(vCourseList)
    End Sub
    Private Sub lbtUpdateCourse_Click(sender As Object, e As EventArgs) Handles lbtUpdateCourse.Click
        Dim taq As New customiseTableAdapters.QueriesTableAdapter
        Page.Validate("ASPCustNew")
        If Page.IsValid Then
            Dim nCustomisationID As Integer
            Dim bActive As Boolean = ActiveCheckBox.Checked
            Dim sCustomisationName As String = tbCustName.Text
            Dim sPassword As String = tbCoursePassword.Text
            Dim bAllowSelf As Boolean = cbAllowSelfRegistration.Checked
            Dim nLearnThresh As Integer = spinLearnThresh.Number
            Dim bPostLearning As Boolean = cbPostLearning.Checked
            Dim nDiagThresh As Integer = spinDiagnosticThresh.Number
            Dim bDiagObjectiveSelection As Boolean = cbDiagObjSelection.Checked
            Dim bHideInLP As Boolean = cbHideInLearningPortal.Checked
            Dim nCompleteWithinMonths As Integer = spinCompleteWithinMonths.Number
            Dim vMandatory As Boolean = cbMandatory.Checked
            Dim nValidityMonths As Integer = spinValidityMonths.Number
            Dim bAutoRefresh As Boolean = cbAutoRefresh.Checked
            Dim nRefreshToCustID As Integer = ddResfreshTo.SelectedValue
            Dim nEnrolMonths As Integer = spinEnrolMonths.Number
            Dim sQ1Options As String = Q1OptionsText.Text
            Dim sQ2Options As String = Q2OptionsText.Text
            Dim sQ3Options As String = Q3OptionsText.Text
            Dim nQ1Prompt As Integer = ddCoursePrompt1.SelectedValue
            Dim nQ2Prompt As Integer = ddCoursePrompt2.SelectedValue
            Dim nQ3Prompt As Integer = ddCoursePrompt3.SelectedValue
            Dim bInviteContributors As Boolean = cbInviteContributors.Checked
            Dim bApplyLPDefaults As Boolean = cbApplyToSelfEnrol.Checked
            If Session("tsCustomisationID") > 0 Then
                nCustomisationID = taq.UpdateCustomisation(CInt(Session("tsCustomisationID")), bActive, sCustomisationName, sPassword, bAllowSelf, nLearnThresh, bPostLearning, nDiagThresh, bDiagObjectiveSelection, bHideInLP, nCompleteWithinMonths, vMandatory, nValidityMonths, bAutoRefresh, nRefreshToCustID, nEnrolMonths, sQ1Options, sQ2Options, sQ3Options, nQ1Prompt, nQ2Prompt, nQ3Prompt, bInviteContributors, tbCCEmail.Text, bApplyLPDefaults)
            Else
                nCustomisationID = taq.InsertCustomisation(bActive, ddApplication.SelectedValue, CInt(Session("UserCentreID")), sCustomisationName, sPassword, bAllowSelf, nLearnThresh, bPostLearning, nDiagThresh, bDiagObjectiveSelection, bHideInLP, nCompleteWithinMonths, vMandatory, nValidityMonths, bAutoRefresh, nRefreshToCustID, nEnrolMonths, sQ1Options, sQ2Options, sQ3Options, nQ1Prompt, nQ2Prompt, nQ3Prompt, bInviteContributors, tbCCEmail.Text, bApplyLPDefaults)
            End If
            If nCustomisationID > 0 Then
                InsertUpdateCustomisationTutorials(nCustomisationID)
                mvCourseSetup.SetActiveView(vCourseList)
            Else
                lblModalHeading.Text = "Error: Duplicate Course Name"
                lblModalMessage.Text = "Another course exists at your centre with an identical name. Please choose a different name and try again."
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMessage", "<script>$('#editUserModal').modal('show');</script>")
            End If
            bsgvCustomisations.DataBind()
        End If
    End Sub
    Protected Sub InsertUpdateCustomisationTutorials(ByVal nCustomisationID As Integer)
        Dim taq As New customiseTableAdapters.QueriesTableAdapter
        For Each item As RepeaterItem In rptSections.Items
            Dim nestedrpt As Repeater = TryCast(item.FindControl("rptTutorials"), Repeater)
            For Each di As RepeaterItem In nestedrpt.Items
                Dim hf As HiddenField = TryCast(di.FindControl("hfTutorialID"), HiddenField)
                Dim nTID As Integer = hf.Value
                Dim cbDiagStatus As CheckBox = TryCast(di.FindControl("cbDiag"), CheckBox)
                Dim cbStatus As CheckBox = TryCast(di.FindControl("cbLearn"), CheckBox)
                taq.InsertUpdateCustomisationTutorials(nCustomisationID, nTID, cbStatus.Checked, cbDiagStatus.Checked)
            Next
        Next
    End Sub
End Class