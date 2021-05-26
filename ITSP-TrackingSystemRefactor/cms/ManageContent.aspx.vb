Imports System.IO
Imports Ionic.Zip
Imports System.Collections.Generic
Imports System.Web.Configuration
Imports DevExpress.Web

Public Class ManageContent
    Inherits System.Web.UI.Page
    Public Property bAllowUpload = True
    Public Property fPathBase As String = Server.MapPath("~/cms/CMSContent/")
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            UpdateUsageDisplay()
        End If
        cbFilterForCentre.Visible = Session("UserPublishToAll")
        If Not Page.IsPostBack Then
            If Page.Request.Item("courseid") Is Nothing Then
                mvManageContent.SetActiveView(vChooseCourse)
            Else
                Dim taq As New itspdbTableAdapters.QueriesTableAdapter
                If Not taq.CheckCourseValidForUser(Page.Request.Item("courseid"), Session("UserCentreID"), Session("UserPublishToAll")) Then
                    mvManageContent.SetActiveView(vChooseCourse)
                Else

                    Dim nCourseID As Integer = Page.Request.Item("courseid")
                    Dim taApp As New itspdbTableAdapters.ApplicationsTableAdapter
                    Dim tApp As New itspdb.ApplicationsDataTable
                    tApp = taApp.GeByApplicationID(nCourseID)
                    lblCourseHeading.Text = tApp.First.ApplicationName
                    Session("DefaultContentTypeID") = tApp.First.DefaultContentTypeID
                    Session("DisplayFormatID") = tApp.First.DisplayFormatID
                    mvManageContent.SetActiveView(vManageContent)
                    divAddAndImport.Visible = Session("UserPublishToAll")
                    divImportOnly.Visible = Not (Session("UserPublishToAll"))
                End If
            End If
        End If
    End Sub
    Protected Sub UpdateUsageDisplay()
        Dim taC As New itspdbTableAdapters.CentresTableAdapter
        Dim tC As New itspdb.CentresDataTable
        tC = taC.GetByCentreID(Session("UserCentreID"))
        If tC.Count = 1 Then
            Dim nTotalBytes As Long = tC.First.ServerSpaceUsed
            Dim sSize As String = CCommon.BytesToString(nTotalBytes)
            lblUsed.Text = sSize
            Dim nAvail As Long = tC.First.ServerSpaceBytes
            lblAvailable.Text = CCommon.BytesToString(nAvail)
            Dim percentageusage As Long = 0
            If nAvail > 0 Then
                percentageusage = (nTotalBytes * 100) / nAvail
            Else
                percentageusage = 100
            End If
            If percentageusage > 100 Then
                percentageusage = 100
            End If
            progbar.Attributes.Add("aria-valuenow", percentageusage.ToString())
            progbar.Attributes.Add("style", "width:" & percentageusage.ToString() & "%;")
            lblPercent.Text = percentageusage.ToString() & "%"
            bAllowUpload = True
            Select Case percentageusage
                Case >= 100
                    pnlUsage.Attributes.Add("class", "card card-danger")
                    bAllowUpload = False
                    pnlExceeded.Visible = True
                Case > 90
                    pnlUsage.Attributes.Add("class", "card card-danger")
                Case < 60
                    pnlUsage.Attributes.Add("class", "card card-success")
                Case Else
                    pnlUsage.Attributes.Add("class", "card card-warning")
            End Select

        End If
    End Sub
    Private Sub ddCourse_DataBound(sender As Object, e As EventArgs) Handles ddCourse.DataBound

        ddCourse.SelectedValue = Page.Request.Item("courseid")

    End Sub

    Private Sub lbtOK_Click(sender As Object, e As EventArgs) Handles lbtOK.Click
        Response.Redirect("ManageContent?courseid=" & ddCourse.SelectedValue.ToString())
    End Sub

    Private Sub rptSections_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptSections.ItemCommand
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        Select Case e.CommandName
            Case "MoveFirst"
                taq.ReorderSection(CInt(e.CommandArgument), "UP", False)
                rptSections.DataBind()
            Case "MoveUp"
                taq.ReorderSection(CInt(e.CommandArgument), "UP", True)
                rptSections.DataBind()
            Case "MoveDown"
                taq.ReorderSection(CInt(e.CommandArgument), "DOWN", True)
                rptSections.DataBind()
            Case "MoveLast"
                taq.ReorderSection(CInt(e.CommandArgument), "DOWN", False)
                rptSections.DataBind()
            Case "EditDetails"
                dsSection.SelectParameters(0).DefaultValue = CInt(e.CommandArgument)
                fvSectionDetail.ChangeMode(FormViewMode.Edit)
                fvSectionDetail.DataBind()
                HideShowSectionControls()
                mvManageContent.SetActiveView(vSectionDetail)
            Case "Archive"
                'need to archive content:
                Dim fPath As String = fPathBase & "Course" + Page.Request.Item("courseid").ToString() + "\"
                fPath = fPath & "Section" + e.CommandArgument.ToString() + "\"
                If Directory.Exists(fPath) Then
                    RemoveFileAttributes(fPath)
                    Directory.Delete(fPath, True)
                End If
                Dim taSec As New itspdbTableAdapters.SectionsTableAdapter
                Dim tSec As New itspdb.SectionsDataTable
                tSec = taSec.GetBySectionID(e.CommandArgument)
                If tSec.Count = 1 Then
                    Dim bUpdate As Boolean = False
                    If EraseOldContentIfChanged(tSec.First.ConsolidationPath, "") Then
                        bUpdate = True
                    End If
                    If EraseOldContentIfChanged(tSec.First.PLAssessPath, "") Then
                        bUpdate = True
                    End If
                    If EraseOldContentIfChanged(tSec.First.DiagAssessPath, "") Then
                        bUpdate = True
                    End If
                End If
                CCommon.GetCourseServerSpaceUsage(CInt(Page.Request.Item("courseid")), Session("UserCentreID"), fPathBase)
                UpdateUsageDisplay()
                taq.ArchiveSection(Session("UserAdminID"), CInt(e.CommandArgument))
                rptSections.DataBind()
                lblModalHeading.Text = "Section Archived"
                lblModalText.Text = "The section was successfully archived. All content uploaded against it has been permanently deleted from the server."
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalEdit", "<script>$('#modalMessage').modal('show');</script>")
            Case "AddTutorial"
                lblTutorialDetailHeading.Text = "Add Tutorial"
                fvTutorialDetail.ChangeMode(FormViewMode.Insert)
                fvTutorialDetail.DataBind()
                Dim hfsecid As HiddenField = fvTutorialDetail.FindControl("hfSectionID")
                Dim bspinDiagAssessOutOf As Bootstrap.BootstrapSpinEdit = fvTutorialDetail.FindControl("bspinDiagAssessOutOf")
                hfsecid.Value = CInt(e.CommandArgument)
                bspinDiagAssessOutOf.Number = 0
                Dim dd As DropDownList = fvTutorialDetail.FindControl("ddContentType")
                dd.SelectedValue = Session("DefaultContentTypeID")
                Me.mvManageContent.SetActiveView(vTutorialDetail)
            Case "ImportTutorial"
                Dim hfsecid As HiddenField = hfSectionIDImport
                hfsecid.Value = CInt(e.CommandArgument)
                Me.mvManageContent.SetActiveView(vImportTutorial)
            Case "AssessTemplate"
                Dim taAssess As New itspdbTableAdapters.AssessExportTableAdapter
                Dim tAssess As New itspdb.AssessExportDataTable
                tAssess = taAssess.GetData(e.CommandArgument)
                CCommon.WriteDownloadFile(Response, CCommon.ToCSV(tAssess), "Sec" & e.CommandArgument.ToString & "-AssessTemplate.itst")
                UpdateUsageDisplay()
        End Select
    End Sub

    Private Sub rptSections_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptSections.ItemDataBound
        Dim rptItem As RepeaterItem = DirectCast(e.Item, RepeaterItem)
        Dim hfSecID As HiddenField = rptItem.FindControl("hfSectionID")
        Dim pnlAddAndImport As Panel = rptItem.FindControl("pnlAddAndImport")
        Dim pnlImportOnly As Panel = rptItem.FindControl("pnlImportOnly")
        pnlAddAndImport.Visible = Not Session("UserImportOnly")
        pnlImportOnly.Visible = Session("UserImportOnly")
        If Not hfSecID Is Nothing Then
            Dim nSectionID As Integer = hfSecID.Value
            Dim rptTuts As Repeater = rptItem.FindControl("rptTutorials")
            Dim dsTut As ObjectDataSource = rptItem.FindControl("dsTutorials")
            If Not dsTut Is Nothing Then
                dsTut.SelectParameters(0).DefaultValue = nSectionID
            End If
            rptTuts.DataSource = dsTut
            rptTuts.DataBind()
        End If
    End Sub

    Private Sub lbtAddSection_Click(sender As Object, e As EventArgs) Handles lbtAddSection.Click, lbtAddNewSection.Click, lbtAddNewSection2.Click
        lblSectionDetailFormHeading.Text = "Add Section"
        fvSectionDetail.ChangeMode(FormViewMode.Insert)
        fvSectionDetail.DataBind()
        HideShowSectionControls()
        Dim hfappid As HiddenField = fvSectionDetail.FindControl("hfApplicationID")
        Dim hfcentreid As HiddenField = fvSectionDetail.FindControl("hfCreatedByCentreID")
        Dim hfcreatedbyid As HiddenField = fvSectionDetail.FindControl("hfCreatedByID")
        Dim tbCreatedBy As TextBox = fvSectionDetail.FindControl("CreatedByTextBox")
        Dim tbCentre As TextBox = fvSectionDetail.FindControl("CreatedByCentreIDTextBox")
        tbCentre.Text = Session("UserCentreName")
        tbCreatedBy.Text = Session("UserForename") & " " & Session("UserSurname")
        hfcentreid.Value = Session("UserCentreID")
        hfcreatedbyid.Value = Session("UserAdminID")
        hfappid.Value = CInt(Page.Request.Item("courseid"))
        Me.mvManageContent.SetActiveView(Me.vSectionDetail)
    End Sub

    Private Sub fvSectionDetail_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvSectionDetail.ItemCommand
        If e.CommandName.Contains("Upload") Then
            Dim fPath As String = fPathBase & "Course" + Page.Request.Item("courseid").ToString() + "\"
            Dim fup As FileUpload
            Dim fName As String
            Dim tb As TextBox
            Select Case e.CommandName
                Case "UploadConsolidation"
                    fup = fvSectionDetail.FindControl("fupConsolidation")
                    tb = fvSectionDetail.FindControl("ConsolidationTextBox")
                    If fup.HasFile Then
                        fPath = fPath + "Consolidation" + "\"
                        If Not Directory.Exists(fPath) Then
                            Directory.CreateDirectory(fPath)
                        End If
                        fName = System.IO.Path.GetFileName(fup.PostedFile.FileName)
                        fPath = fPath + fName
                    Else
                        Exit Sub
                    End If
                Case "UploadDiagnostic"
                    fup = fvSectionDetail.FindControl("fupDiagnostic")
                    tb = fvSectionDetail.FindControl("DiagnosticPathTextBox")
                    If fup.HasFile Then
                        fPath = fPath + "Diagnostic" + "\"
                        If Not Directory.Exists(fPath) Then
                            Directory.CreateDirectory(fPath)
                        End If
                        fName = System.IO.Path.GetFileName(fup.PostedFile.FileName)
                        fPath = fPath + fName
                    Else
                        Exit Sub
                    End If
                Case "UploadPLAssess"
                    fup = fvSectionDetail.FindControl("fupPLAssess")
                    tb = fvSectionDetail.FindControl("PLAssessPathTextBox")
                    If fup.HasFile Then
                        fPath = fPath + "PLAssess" + "\"
                        If Not Directory.Exists(fPath) Then
                            Directory.CreateDirectory(fPath)
                        End If
                        fName = System.IO.Path.GetFileName(fup.PostedFile.FileName)
                        fPath = fPath + fName
                    Else
                        Exit Sub
                    End If
                Case Else
                    Exit Sub
            End Select
            If fName.Contains(".zip") And e.CommandName <> "UploadConsolidation" Then
                fPath = fPath.Substring(0, fPath.Length - 4)
                fPath = fPath + "\"
                If Not Directory.Exists(fPath) Then
                    Directory.CreateDirectory(fPath)
                End If
                Using zip As ZipFile = ZipFile.Read(fup.PostedFile.InputStream)
                    zip.ExtractAll(fPath, ExtractExistingFileAction.OverwriteSilently)
                    If zip.ContainsEntry("imsmanifest.xml") Then
                        tb.Text = ReverseMapPath(fPath + "imsmanifest.xml")
                    ElseIf zip.ContainsEntry("itspplayer.html") Then
                        tb.Text = ReverseMapPath(fPath + "itspplayer.html")
                    Else
                        hfFileField.Value = e.CommandName
                        hfFilePath.Value = fPath
                        gvSelectFile.DataSource = zip.Entries
                        gvSelectFile.DataBind()
                        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalFileSelect", "<script>$('#selectFileModal').modal('show');</script>")
                    End If
                End Using
            Else
                fup.SaveAs(fPath)
                tb.Text = ReverseMapPath(fPath)
            End If
            CCommon.GetCourseServerSpaceUsage(CInt(Page.Request.Item("courseid")), Session("UserCentreID"), fPathBase)
            UpdateUsageDisplay()
        ElseIf e.CommandName = "Cancel" Then
            Dim hf As HiddenField
            Dim tb As TextBox
            Dim bUpdate As Boolean = False
            Dim sOldVal As String = ""
            hf = CType(sender, FormView).FindControl("hfConsolidationPath")
            If Not hf Is Nothing Then
                sOldVal = hf.Value
            End If

            tb = CType(sender, FormView).FindControl("ConsolidationTextBox")
            If EraseOldContentIfChanged(tb.Text, sOldVal) Then
                bUpdate = True
            End If
            sOldVal = ""
            hf = CType(sender, FormView).FindControl("hfDiagnosticPath")
            If Not hf Is Nothing Then
                sOldVal = hf.Value
            End If

            tb = CType(sender, FormView).FindControl("DiagnosticPathTextBox")
            If EraseOldContentIfChanged(tb.Text, sOldVal) Then
                bUpdate = True
            End If
            sOldVal = ""
            hf = CType(sender, FormView).FindControl("hfPLAssessPath")
            If Not hf Is Nothing Then
                sOldVal = hf.Value
            End If
            tb = CType(sender, FormView).FindControl("PLAssessPathTextBox")
            If EraseOldContentIfChanged(tb.Text, sOldVal) Then
                bUpdate = True
            End If
            If bUpdate Then
                CCommon.GetCourseServerSpaceUsage(CInt(Page.Request.Item("courseid")), Session("UserCentreID"), fPathBase)
                UpdateUsageDisplay()
            End If
            mvManageContent.SetActiveView(vManageContent)
        End If
    End Sub

    Private Sub fvSectionDetail_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvSectionDetail.ItemInserted
        UpdateCustCourseCount()
        rptSections.DataBind()
        Me.mvManageContent.SetActiveView(vManageContent)
        lblModalHeading.Text = "Section Added"
        lblModalText.Text = "Section details were successfully saved."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAdd", "<script>$('#modalMessage').modal('show');</script>")

    End Sub
    Protected Sub UpdateCustCourseCount()
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        taq.UpdateCustomCoursesCountByAppID(Page.Request.Item("courseid"))
    End Sub
    Private Sub fvSectionDetail_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvSectionDetail.ItemUpdated
        UpdateCustCourseCount()
        rptSections.DataBind()
        Me.mvManageContent.SetActiveView(vManageContent)
        lblModalHeading.Text = "Section Details Updated"
        lblModalText.Text = "Section details were successfully updated."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalEdit", "<script>$('#modalMessage').modal('show');</script>")

    End Sub
    Protected Sub TutorialRepeaterCommand(source As Object, e As EventArgs)
        Dim lbt As LinkButton = TryCast(source, LinkButton)
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        Select Case lbt.CommandName
            Case "MoveFirst"
                taq.ReorderTutorial(CInt(lbt.CommandArgument), "UP", False)
                rptSections.DataBind()
            Case "MoveUp"
                taq.ReorderTutorial(CInt(lbt.CommandArgument), "UP", True)
                rptSections.DataBind()
            Case "MoveDown"
                taq.ReorderTutorial(CInt(lbt.CommandArgument), "DOWN", True)
                rptSections.DataBind()
            Case "MoveLast"
                taq.ReorderTutorial(CInt(lbt.CommandArgument), "DOWN", False)
                rptSections.DataBind()
            Case "EditDetails"
                dsTutorial.SelectParameters(0).DefaultValue = CInt(lbt.CommandArgument)
                fvTutorialDetail.DataBind()
                mvManageContent.SetActiveView(vTutorialDetail)
            Case "Archive"
                'Need to delete the server content associated with the course:
                Dim taTut As New itspdbTableAdapters.TutorialsTableAdapter
                Dim tTut As New itspdb.TutorialsDataTable
                tTut = taTut.GetByTutorialID(lbt.CommandArgument)
                If tTut.Count = 1 Then
                    Dim bUpdate As Boolean = False
                    If EraseOldContentIfChanged(tTut.First.VideoPath, "") Then
                        bUpdate = True
                    End If
                    If EraseOldContentIfChanged(tTut.First.TutorialPath, "") Then
                        bUpdate = True
                    End If
                    If EraseOldContentIfChanged(tTut.First.SupportingMatsPath, "") Then
                        bUpdate = True
                    End If
                    If bUpdate Then
                        CCommon.GetCourseServerSpaceUsage(CInt(Page.Request.Item("courseid")), Session("UserCentreID"), fPathBase)
                        UpdateUsageDisplay()
                    End If
                End If
                'and then mark as archived:
                taq.ArchiveTutorial(Session("UserAdminID"), CInt(lbt.CommandArgument))
                rptSections.DataBind()
                lblModalHeading.Text = "Tutorial Archived"
                lblModalText.Text = "The tutorial was successfully archived. All content uploaded against it has been permanently deleted from the server."
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalEdit", "<script>$('#modalMessage').modal('show');</script>")
        End Select
    End Sub
    Protected Function ReverseMapPath(path As String) As String
        Dim appPath As String = HttpContext.Current.Server.MapPath("~")
        Dim res As String = My.Settings.MyURL + path.Replace(appPath, "").Replace("\", "/")
        Return res
    End Function
    Private Sub fvTutorialDetail_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvTutorialDetail.ItemCommand
        If e.CommandName.Contains("Upload") Then
            Dim hf As HiddenField = fvTutorialDetail.FindControl("hfSectionID")
            Dim fPath As String = fPathBase & "Course" + Page.Request.Item("courseid").ToString() + "\"
            fPath = fPath & "Section" + hf.Value.ToString() + "\"
            Dim fup As FileUpload
            Dim fName As String
            Dim tb As TextBox
            Select Case e.CommandName
                Case "UploadVideo"
                    fup = fvTutorialDetail.FindControl("fupVideo")
                    tb = fvTutorialDetail.FindControl("VideoPathTextBox")
                    If fup.HasFile Then
                        fPath = fPath + "Videos" + "\"
                        If Not Directory.Exists(fPath) Then
                            Directory.CreateDirectory(fPath)
                        End If
                        fName = System.IO.Path.GetFileName(fup.PostedFile.FileName)
                        fPath = fPath + fName
                    Else
                        Exit Sub
                    End If
                Case "UploadTutorial"
                    fup = fvTutorialDetail.FindControl("fupTutorial")
                    tb = fvTutorialDetail.FindControl("TutorialPathTextBox")
                    If fup.HasFile Then
                        fPath = fPath + "Tutorials" + "\"
                        If Not Directory.Exists(fPath) Then
                            Directory.CreateDirectory(fPath)
                        End If
                        fName = System.IO.Path.GetFileName(fup.PostedFile.FileName)
                        fPath = fPath + fName
                    Else
                        Exit Sub
                    End If
                Case "UploadSupportMats"
                    fup = fvTutorialDetail.FindControl("fupSupportMats")
                    tb = fvTutorialDetail.FindControl("SupportingMatsPathTextBox")
                    If fup.HasFile Then
                        fPath = fPath + "SupportMats" + "\"
                        If Not Directory.Exists(fPath) Then
                            Directory.CreateDirectory(fPath)
                        End If
                        fName = System.IO.Path.GetFileName(fup.PostedFile.FileName)
                        fPath = fPath + fName
                    Else
                        Exit Sub
                    End If
                Case Else
                    Exit Sub
            End Select
            If fName.Contains(".zip") And Not e.CommandName = "UploadSupportMats" Then
                fPath = fPath.Substring(0, fPath.Length - 4)
                fPath = fPath + "\"
                If Not Directory.Exists(fPath) Then
                    Directory.CreateDirectory(fPath)
                End If
                Using zip As ZipFile = ZipFile.Read(fup.PostedFile.InputStream)
                    zip.ExtractAll(fPath, ExtractExistingFileAction.OverwriteSilently)
                    If zip.ContainsEntry("imsmanifest.xml") Then
                        tb.Text = ReverseMapPath(fPath + "imsmanifest.xml")
                    ElseIf zip.ContainsEntry("itspplayer.html") Then
                        tb.Text = ReverseMapPath(fPath + "itspplayer.html")
                    Else
                        hfFileField.Value = e.CommandName
                        hfFilePath.Value = fPath
                        gvSelectFile.DataSource = zip.Entries
                        gvSelectFile.DataBind()
                        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalFileSelect", "<script>$('#selectFileModal').modal('show');</script>")
                    End If
                End Using
            Else
                fup.SaveAs(fPath)
                tb.Text = ReverseMapPath(fPath)
            End If
            CCommon.GetCourseServerSpaceUsage(Page.Request.Item("courseid"), Session("UserCentreID"), fPathBase)
            UpdateUsageDisplay()
        ElseIf e.CommandName = "Cancel" Then

            Dim tb As TextBox
            Dim hf As HiddenField
            Dim bUpdate As Boolean = False
            Dim sOldVal As String = ""
            hf = CType(sender, FormView).FindControl("hfVideoPath")
            If Not hf Is Nothing Then
                sOldVal = hf.Value
            End If
            tb = CType(sender, FormView).FindControl("VideoPathTextBox")
            'reuse the erase old sub by reversing the submitted params:
            If EraseOldContentIfChanged(tb.Text, sOldVal) Then
                bUpdate = True
            End If
            sOldVal = ""
            hf = CType(sender, FormView).FindControl("hfTutorialPath")
            If Not hf Is Nothing Then
                sOldVal = hf.Value
            End If
            tb = CType(sender, FormView).FindControl("TutorialPathTextBox")
            If EraseOldContentIfChanged(tb.Text, sOldVal) Then
                bUpdate = True
            End If
            sOldVal = ""
            hf = CType(sender, FormView).FindControl("hfSupportingMatsPath")
            If Not hf Is Nothing Then
                sOldVal = hf.Value
            End If
            tb = CType(sender, FormView).FindControl("SupportingMatsPathTextBox")
            If EraseOldContentIfChanged(tb.Text, sOldVal) Then
                bUpdate = True
            End If
            If bUpdate Then
                CCommon.GetCourseServerSpaceUsage(Page.Request.Item("courseid"), Session("UserCentreID"), fPathBase)
                UpdateUsageDisplay()
            End If
            mvManageContent.SetActiveView(vManageContent)
        End If

    End Sub
    Private Sub fvTutorialDetail_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvTutorialDetail.ItemInserted
        Dim hf As HiddenField = fvTutorialDetail.FindControl("hfSectionID")
        If Not hf Is Nothing Then
            Dim taq As New itspdbTableAdapters.QueriesTableAdapter
            taq.UpdateSectionTime(hf.Value)
            taq.UpdateCustomCoursesCountByAppID(Page.Request.Item("courseid"))
        End If
        rptSections.DataBind()
        Me.mvManageContent.SetActiveView(vManageContent)
        lblModalHeading.Text = "Tutorial Added"
        lblModalText.Text = "Tutorial details were successfully saved."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAdd", "<script>$('#modalMessage').modal('show');</script>")

    End Sub

    Private Sub fvTutorialDetail_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvTutorialDetail.ItemUpdated
        Dim hf As HiddenField = fvTutorialDetail.FindControl("hfSectionID")
        If Not hf Is Nothing Then
            Dim taq As New itspdbTableAdapters.QueriesTableAdapter
            taq.UpdateSectionTime(hf.Value)
            taq.UpdateCustomisationTime(Page.Request.Item("courseid"))
            taq.UpdateCustomCoursesCountByAppID(Page.Request.Item("courseid"))
        End If

        rptSections.DataBind()
        Me.mvManageContent.SetActiveView(vManageContent)
        lblModalHeading.Text = "Tutorial Details Updated"
        lblModalText.Text = "Tutorial details were successfully updated."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalEdit", "<script>$('#modalMessage').modal('show');</script>")

    End Sub

    Private Sub gvSelectFile_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvSelectFile.RowCommand
        If e.CommandName = "Select" Then
            Dim sCommand As String = hfFileField.Value
            Dim sFilePath As String = hfFilePath.Value
            Dim tb As TextBox
            Select Case sCommand
                Case "UploadConsolidation"
                    tb = fvSectionDetail.FindControl("ConsolidationTextBox")
                Case "UploadDiagnostic"
                    tb = fvSectionDetail.FindControl("DiagnosticPathTextBox")
                Case "UploadPLAssess"
                    tb = fvSectionDetail.FindControl("PLAssessPathTextBox")
                Case "UploadVideo"
                    tb = fvTutorialDetail.FindControl("VideoPathTextBox")
                Case "UploadTutorial"
                    tb = fvTutorialDetail.FindControl("TutorialPathTextBox")
                Case "UploadSupportMats"
                    tb = fvTutorialDetail.FindControl("SupportingMatsPathTextBox")
                Case Else
                    Exit Sub
            End Select
            tb.Text = ReverseMapPath(sFilePath + e.CommandArgument)
        End If
    End Sub

    Private Sub lbtImportSection_Click(sender As Object, e As EventArgs) Handles lbtImportSection.Click, lbtImportSection2.Click
        Me.mvManageContent.SetActiveView(Me.vImportSection)

    End Sub

    Private Sub lbtImportSectionCancel_Click(sender As Object, e As EventArgs) Handles lbtImportSectionCancel.Click, lbtImportTutorialCancel.Click
        Me.mvManageContent.SetActiveView(Me.vManageContent)
    End Sub

    Private Sub lbtImportSectionConfirm_Click(sender As Object, e As EventArgs) Handles lbtImportSectionConfirm.Click
        'Need to setup and call stored procedure here to handle the importing of content from the section
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        taq.uspImportSectionToCourse(ddSectionToImport.SelectedValue, Page.Request.Item("courseid"), Session("UserAdminID"), Session("UserCentreID"))
        rptSections.DataBind()
        Me.mvManageContent.SetActiveView(Me.vManageContent)
        lblModalHeading.Text = "Section Imported"
        lblModalText.Text = "The section " + ddSectionToImport.SelectedItem.Text + " and all of its content have been imported to this course."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalConfirmSectionImport", "<script>$('#modalMessage').modal('show');</script>")
    End Sub


    Private Sub ddSectionsForTutorialImport_DataBound(sender As Object, e As EventArgs) Handles ddSectionsForTutorialImport.DataBound
        ddTutorialToImport.DataBind()
    End Sub

    Private Sub lbtImportTutorialConfirm_Click(sender As Object, e As EventArgs) Handles lbtImportTutorialConfirm.Click
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        taq.uspImportTutorialToSection(ddTutorialToImport.SelectedValue, hfSectionIDImport.Value)
        rptSections.DataBind()
        Me.mvManageContent.SetActiveView(Me.vManageContent)
        lblModalHeading.Text = "Tutorial Imported"
        lblModalText.Text = "The tutorial " + ddTutorialToImport.SelectedItem.Text + " and all of its content have been imported to this section."
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalConfirmTutorialImport", "<script>$('#modalMessage').modal('show');</script>")
    End Sub


    Protected Sub HideShowSectionControls()
        If Session("UserImportOnly") Then
            Dim pnl1 As Panel = fvSectionDetail.FindControl("pnlConsolidationUpload")
            Dim pnl2 As Panel = fvSectionDetail.FindControl("pnlDiagUpload")
            Dim pnl3 As Panel = fvSectionDetail.FindControl("pnlAssessUpload")
            pnl1.Visible = False
            pnl2.Visible = False
            pnl3.Visible = False
        End If
    End Sub

    Private Sub fvTutorialDetail_PreRender(sender As Object, e As EventArgs) Handles fvTutorialDetail.PreRender
        If CType(sender, FormView).CurrentMode = FormViewMode.Insert Then
            Dim bsSpin As Bootstrap.BootstrapSpinEdit = CType(sender, FormView).FindControl("bsSpinOverrideTutorialMins")
            If bsSpin IsNot Nothing Then
                bsSpin.Number = 0
            End If
            Dim chk As Object = CType(sender, FormView).FindControl("ActiveCheckBox")
            If chk IsNot Nothing AndAlso chk.GetType Is GetType(CheckBox) Then
                CType(chk, CheckBox).Checked = True
            End If
        End If
        If Not bAllowUpload Then
            DisableLinkButton(CType(sender, FormView).FindControl("lbtUploadTutVideo"))
            DisableLinkButton(CType(sender, FormView).FindControl("lbtUploadTutorial"))
            DisableLinkButton(CType(sender, FormView).FindControl("lbtUploadSuppportMats"))
        End If
    End Sub

    Private Sub cbFilterForCentre_CheckedChanged(sender As Object, e As EventArgs) Handles cbFilterForCentre.CheckedChanged
        ddCourse.Items.Clear()
        ddCourse.DataBind()
    End Sub

    Private Sub fvSectionDetail_PreRender(sender As Object, e As EventArgs) Handles fvSectionDetail.PreRender
        If Not bAllowUpload Then
            DisableLinkButton(CType(sender, FormView).FindControl("lbtUploadConsolidation"))
            DisableLinkButton(CType(sender, FormView).FindControl("lbtUploadDiagnostic"))
            DisableLinkButton(CType(sender, FormView).FindControl("lbtUploadPLAssess"))
        End If
    End Sub
    Protected Sub DisableLinkButton(ByRef lbt As LinkButton)
        If Not lbt Is Nothing Then
            lbt.Enabled = False
            lbt.Attributes.Add("aria-disabled", "true")
            lbt.CssClass = lbt.CssClass & " disabled"
        End If
    End Sub

    Private Sub fvSectionDetail_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles fvSectionDetail.ItemUpdating
        'Check if any content needs deleting from the server and do so:
        Dim hf As HiddenField
        Dim tb As TextBox
        Dim bUpdate As Boolean = False
        hf = CType(sender, FormView).FindControl("hfConsolidationPath")
        tb = CType(sender, FormView).FindControl("ConsolidationTextBox")
        If EraseOldContentIfChanged(hf.Value, tb.Text) Then
            bUpdate = True
        End If
        hf = CType(sender, FormView).FindControl("hfDiagnosticPath")
        tb = CType(sender, FormView).FindControl("DiagnosticPathTextBox")
        If EraseOldContentIfChanged(hf.Value, tb.Text) Then
            bUpdate = True
        End If
        hf = CType(sender, FormView).FindControl("hfPLAssessPath")
        tb = CType(sender, FormView).FindControl("PLAssessPathTextBox")
        If EraseOldContentIfChanged(hf.Value, tb.Text) Then
            bUpdate = True
        End If
        If bUpdate Then
            CCommon.GetCourseServerSpaceUsage(Page.Request.Item("courseid"), Session("UserCentreID"), fPathBase)
            UpdateUsageDisplay()
        End If
    End Sub
    Private Sub fvTutorialDetail_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles fvTutorialDetail.ItemUpdating
        Dim hf As HiddenField
        Dim tb As TextBox
        Dim bUpdate As Boolean = False
        hf = CType(sender, FormView).FindControl("hfVideoPath")
        tb = CType(sender, FormView).FindControl("VideoPathTextBox")
        If EraseOldContentIfChanged(hf.Value, tb.Text) Then
            bUpdate = True
        End If
        hf = CType(sender, FormView).FindControl("hfTutorialPath")
        tb = CType(sender, FormView).FindControl("TutorialPathTextBox")
        If EraseOldContentIfChanged(hf.Value, tb.Text) Then
            bUpdate = True
        End If
        hf = CType(sender, FormView).FindControl("hfSupportingMatsPath")
        tb = CType(sender, FormView).FindControl("SupportingMatsPathTextBox")
        If EraseOldContentIfChanged(hf.Value, tb.Text) Then
            bUpdate = True
        End If
        If bUpdate Then
            CCommon.GetCourseServerSpaceUsage(Page.Request.Item("courseid"), Session("UserCentreID"), fPathBase)
            UpdateUsageDisplay()
        End If
    End Sub
    Protected Function EraseOldContentIfChanged(ByVal sOldPath As String, ByVal sNewPath As String) As Boolean
        'is the old value present and a file in the CMS repository?
        Dim bContentDeleted As Boolean = False
        If sOldPath.Contains("CMSContent") Then
            'check that the content belongs to this course:
            If sOldPath.Contains("Course" & Page.Request.Item("courseid").ToString() & "/") Then

                Try
                    If sOldPath <> sNewPath Then
                        sOldPath = sOldPath.Replace(My.Settings.MyURL, "~/")
                        sOldPath = Server.MapPath(sOldPath)
                        'there is old content, should we delete it?
                        'it's different so yes:
                        If sOldPath.Contains("Diagnostic") Or sOldPath.Contains("PLAssess") Or sOldPath.Contains("Tutorials") Then
                            'we need to delete the containing folder:
                            Dim sPath As String = sOldPath.Substring(0, sOldPath.LastIndexOf("\"))
                            If Directory.Exists(sPath) Then
                                RemoveFileAttributes(sPath)
                                Directory.Delete(sPath, True)
                                bContentDeleted = True
                            End If
                        Else
                            'we need to delete the file:
                            If File.Exists(sOldPath) Then
                                RemoveFileAttributes(sOldPath)
                                File.Delete(sOldPath)
                                bContentDeleted = True

                            End If
                        End If
                    End If
                Catch Ex As Exception

                End Try

            End If
        End If
        Return bContentDeleted
    End Function
    Public Shared Sub RemoveFileAttributes(ByVal target_dir As String)
        Dim files As String() = Directory.GetFiles(target_dir)
        For Each sFile In files
            File.SetAttributes(sFile, FileAttributes.Normal)
        Next
    End Sub
    Protected Function CorrectTutorialURL(ByVal sURL As String) As String
        If sURL.StartsWith("/cms/CMSContent") Then
            sURL = My.Settings.MyURL & sURL
        End If
        Return sURL
    End Function

    Private Sub fvTutorialDetail_DataBound(sender As Object, e As EventArgs) Handles fvTutorialDetail.DataBound
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "setformcontrolvis", "<script>setEditFormControlVis();setDiagnosticControlVisibility();</script>")
    End Sub

    Protected Sub lbtReview_Command(sender As Object, e As CommandEventArgs)
        dsCompetency.SelectParameters(0).DefaultValue = e.CommandArgument
        fvCompetency.DataBind()
        mvManageContent.SetActiveView(vCompetencyAssess)
    End Sub

    Protected Sub lbtCloseCompetency_Command(sender As Object, e As CommandEventArgs)
        mvManageContent.SetActiveView(vManageContent)
    End Sub
End Class