Imports System.Net
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports DevExpress.Web.Bootstrap
Imports DevExpress.Web
Imports System.Web.Routing

Public Class learn
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            If Session("pwComplete") Is Nothing Then
                Session("pwComplete") = False
            End If
            If Session("learnUserAuthenticated") Is Nothing Then
                Session("learnUserAuthenticated") = False
            End If
            If Session("BannerText") Is Nothing Then Session("BannerText") = ""
            litAccess.Text = CCommon.GetConfigString("AccessibilityNotice")
            'litPrivacy.Text = CCommon.GetConfigString("PrivacyNotice")
            litTOUDetail.Text = CCommon.GetConfigString("TermsAndConditions")
            If Not Session("learnUserAuthenticated") Then
                Page.Response.Redirect("~/home?action=login&app=lp&returnurl=" & Server.UrlEncode(Request.Url.AbsoluteUri))
            Else
                LearnMenuInitialise()
                LoadLearnerProgress()
            End If
        Else
            LitIntroVideo.Text = ""
        End If
        If pnlDevLog.Visible Then
            bsgvComplete.DataBind()
            bsgvPlanned.DataBind()
        End If
        If Not Session("lmNoITSPLogo") Is Nothing Or Not Page.Request.Item("nobrand") Is Nothing Then
            logoImage.Attributes.Add("class", "pull-left")
            mainlogo.Visible = "False"
        End If
        If Not Session("lmAppColour") Is Nothing Then
            pnlMenuPanel.CssClass = Session("lmAppColour")
        End If
        Dim UserIP As String = HttpContext.Current.Request.ServerVariables("REMOTE_ADDR").ToString()

        Session("lmUserIP") = UserIP
    End Sub
#Region "Login Logout"
    Private Sub learn_Init(sender As Object, e As EventArgs) Handles Me.Init
        Session("sPanelClass") = "card card-default"
        Session("sFrameColour") = "#E0E0E0"
        If Context.Session IsNot Nothing Then

            If Session.IsNewSession And Page.Request.Item("ProgressKey") Is Nothing Then
                Dim szCookieHeader As String = Request.Headers("Cookie")
                If (szCookieHeader IsNot Nothing) AndAlso (szCookieHeader.IndexOf("ASP.NET_SessionId") >= 0) Then
                    Logout(True)
                End If
            End If
        End If
        If Session("UserCentreID") Is Nothing Then
            If Page.Request.Item("CentreID") IsNot Nothing Then
                Session("UserCentreID") = Integer.Parse(Page.Request.Item("CentreID"))
            End If
        End If
    End Sub

    Protected Sub LearnMenuInitialise()
        Dim sURL As String
        sURL = My.Settings.ITSPTrackingURL
        If Not sURL.EndsWith("/") Then
            sURL = sURL & "/"
        End If
        Session("lmTrackingUrl") = sURL
        Dim CustomisationID As Int32
        If Page.Request.Item("CustomisationID") IsNot Nothing Then
            CustomisationID = Integer.Parse(Page.Request.Item("CustomisationID"))
        Else
            Response.Redirect("~/errorAccess?code=1")
        End If
        Session("lmCustomisationID") = CustomisationID
        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
        Dim bImg As System.Byte() = taq.GetLogoForCustomisationID(CustomisationID)
        If Not bImg Is Nothing Then
            bimgLogo.Value = bImg
        Else
            bimgLogo.Visible = False
        End If
        Dim taApplications As New LearnMenuTableAdapters.ApplicationsTableAdapter
        Dim tApplications As LearnMenu.ApplicationsDataTable
        Dim sClass As String = "card card-default"
        Dim sColor As String = "#E0E0E0"
        tApplications = taApplications.GetForCustomisation(CInt(CustomisationID))
        If tApplications.Count > 0 Then
            Dim AppG As Integer = tApplications.First.AppGroupID
            Select Case AppG

                Case 1
                    sClass = "card card-itsp-purple"
                    sColor = "#3B1979"
                Case 2
                    sClass = "card card-itsp-pink"
                    sColor = "#B5006A"
                Case 3
                    sClass = "card card-itsp-blue"
                    sColor = "#11AF52"
                Case 4
                    sClass = "card card-itsp-green"
                    sColor = "#009DCA"
            End Select
            If tApplications.First.OfficeVersionID < 3 Then
                'show the download shockwave panel:
                pnlSWDownload.Visible = True
            End If
        End If
        Session("sPanelClass") = sClass
        Session("sFrameColour") = sColor
        pnlLearnframe.BackColor = System.Drawing.ColorTranslator.FromHtml(sColor)
        Session("lmAppColour") = sClass
        Session("lmBkgColour") = sColor

        pnlMenuPanel.CssClass = sClass
        doLogoSize()
        'Get Application info table
        Dim taCustHeader As New LearnMenuTableAdapters.CustHeaderTableAdapter
        Dim tCustHeader As LearnMenu.CustHeaderDataTable
        tCustHeader = taCustHeader.GetData(Session("UserCentreID"), Session("lmCustomisationID"))
        If tCustHeader.Count > 0 Then
            CourseSettings.LoadSettingsFromString(tCustHeader.First.CourseSettings).SetSettings(Session)
            pnlDevLog.Visible = tCustHeader.First.IncludeLearningLog
            Session("lmDelegateByteLimit") = tCustHeader.First.CandidateByteLimit
            Session("lmSVVerified") = tCustHeader.First.SupervisorVerify
            Session("learnShowLearningLog") = tCustHeader.First.IncludeLearningLog
            Session("lmContentTypeID") = tCustHeader.First.DefaultContentTypeID
            pnlCompletion.Visible = tCustHeader.First.IncludeCertification
            btnContributors.Visible = tCustHeader.First.InviteContributors
            Session("lmContributors") = tCustHeader.First.InviteContributors
            If tCustHeader.First.DefaultContentTypeID = 1 Then
                pnlHowToVids.Visible = True
                lbtDiagVid.Visible = tCustHeader.First.DiagOn
                lbtLearnVid.Visible = tCustHeader.First.LearningOn
                lbtPLAssess.Visible = tCustHeader.First.IsAssessed
            End If
            Session("lmCustVersion") = tCustHeader.First.CurrentVersion
            lblCentreName.Text = tCustHeader.First.CentreName
            lblPageTitle.Text = tCustHeader.First.ApplicationName & " - " & tCustHeader.First.CustomisationName
            If tCustHeader.First.DefaultContentTypeID < 4 Then
                If GetCS("LearnMenu.ShowTime") Then
                    lblPageTitle.Text = lblPageTitle.Text & "<br/><small class='text-muted'>Average course length: " & tCustHeader.First.LearnMins & "</small>"
                End If
            End If
                lblCourseTitle.Text = tCustHeader.First.ApplicationInfo
            Session("lmThreshold") = tCustHeader.First.TutCompletionThreshold
            Session("lmCustIsAssessed") = tCustHeader.First.IsAssessed
            Session("lmCustDiagObjSelect") = tCustHeader.First.DiagObjSelect
            Session("lmPlaPassThreshold") = tCustHeader.First.PLAPassThreshold
            Dim sMovieW As Integer = tCustHeader.First.hEmbedRes + 8
            Dim sMovieH As Integer = tCustHeader.First.vEmbedRes + 10
            'pnlLearnframe.Width = sMovieW
            'pnlLearnframe.Height = sMovieH
            frame1.Attributes.Add("width", sMovieW)
            frame1.Attributes.Add("height", sMovieH)
            If Not Page.Request.Item("lp") Is Nothing Then
                lbtnlogout.Text = "<i class='fas fa-sign-out-alt mr-1'></i>Close"
                lbtnlogout.ToolTip = "Return to Learning Portal"
            End If
            If Not Session("pwComplete") And tCustHeader.First.Password.Length > 0 Then
                cvPassword.ValueToCompare = tCustHeader.First.Password
                cvPassword.Operator = ValidationCompareOperator.Equal
                cvPassword.ErrorMessage = "Please enter correct password"
                cvPassword.Display = ValidatorDisplay.Dynamic
                cvPassword.Text = "*"
                cvPassword.ControlToValidate = "tbPassword"
                cvPassword.EnableClientScript = True
                cvPassword.Enabled = True
                cvPassword.EnableViewState = True
                cvPassword.ToolTip = cvPassword.ErrorMessage
                cvPassword.Visible = True
                cvPassword.ID = "cvPassword"
                cvPassword.SetFocusOnError = True
                mvOuter.SetActiveView(vPassword)
            End If
        Else
            Response.Redirect("~/errorAccess?code=3")
        End If
    End Sub
    Protected Sub doLogoSize()
        Me.logoImage.Height = CInt(Session("logoHeight"))
        Me.logoImage.Width = CInt(Session("logoWidth"))
        Me.logoImage.Visible = Session("logoVisible")
    End Sub
    Private Sub lbtnlogout_Click(sender As Object, e As EventArgs) Handles lbtnlogout.Click
        Logout()
    End Sub
    Public Sub Logout(Optional ByVal bReturn As Boolean = False)
        EndSession()
        If lbtnlogout.ToolTip = "Return to Learning Portal" Then

            Response.Redirect(Session("LearningPortalUrl"))
        Else

            Context.Session.Clear()
            Context.Session.Abandon()
            If bReturn Then
                Page.Response.Redirect("~/home?action=login&app=lp&returnurl=" & Server.UrlEncode(Request.Url.AbsoluteUri))
            Else
                Page.Response.Redirect("~/home")
            End If

        End If
    End Sub
    Private Sub StartSession()
        Dim taSession As New ITSPTableAdapters.SessionsTableAdapter
        taSession.CloseActiveSessions(Session("learnCandidateID"), Session("lmCustomisationID"))
        Session("lmSessionID") = taSession.InsertAndGetID(Session("learnCandidateID"), Session("lmCustomisationID"), 0, True)
    End Sub
    Private Sub EndSession()
        Dim taSession As New ITSPTableAdapters.SessionsTableAdapter
        taSession.CloseActiveSessions(Session("learnCandidateID"), Session("lmCustomisationID"))
    End Sub

#End Region
#Region "Progress"
    Private Function getProgressID()
        Dim taProgress As New LearnMenuTableAdapters.ProgressTableAdapter
        Dim tProgress As New LearnMenu.ProgressDataTable
        Dim ProgID As Int32 = 0
        tProgress = taProgress.GetData(Session("learnCandidateID"), Session("lmCustomisationID"))
        If tProgress.Count > 0 Then
            ProgID = tProgress.First.ProgressID
        End If
        Return ProgID
    End Function
#End Region
#Region "Learn Menu"
    Public Function GetSectionClass(ByVal pcComp As Integer) As String
        Dim sClass As String = ""
        Select Case pcComp
            Case 0 To 10
                sClass = "card card-ten mb-2"
            Case 11 To 20
                sClass = "card card-twenty mb-2"
            Case 21 To 30
                sClass = "card card-thirty mb-2"
            Case 31 To 40
                sClass = "card card-forty mb-2"
            Case 41 To 50
                sClass = "card card-fifty mb-2"
            Case 51 To 60
                sClass = "card card-sixty mb-2"
            Case 61 To 70
                sClass = "card card-seventy mb-2"
            Case 71 To 80
                sClass = "card card-eighty mb-2"
            Case 81 To 90
                sClass = "card card-ninety mb-2"
            Case Is > 90
                sClass = "card card-hundred mb-2"
        End Select

        Return sClass
    End Function



    Protected Sub rptTutorials_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If Session("lmCustomisationID") Is Nothing Then
            Logout()
        End If
        Dim hfSecID As HiddenField = source.parent.parent.parent.Findcontrol("hfSectionID")
        Dim tid As Integer = CInt(e.CommandArgument)
        Dim apppath As String = Request.Url.GetLeftPart(UriPartial.Authority) & Request.ApplicationPath
        apppath = apppath.Replace("tracking-reboot", "tracking")
        If apppath.Contains("localhost") Then
            apppath = "https://www.dls.nhs.uk/tracking"
        End If
        Session("lmTutorialID") = tid
        Select Case e.CommandName.ToString
            Case "cmdIntro"
                Dim taQ As New LearnMenuTableAdapters.QueriesTableAdapter
                Dim vidpath As String = taQ.GetVideoPath(tid)
                Dim vidhtml As String
                Dim mp4FilePath As String
                If vidpath.Contains("http") Then
                    mp4FilePath = vidpath
                    If vidpath.Contains("https://youtu.be/") Then
                        vidpath = vidpath.Replace("https://youtu.be/", "https://www.youtube.com/embed/")
                        vidhtml = "<div id='tutVideo'><div class='embed-responsive embed-responsive-16by9' style='height:100%'><iframe class='embed-responsive-item' id='YouTubeEmbed' src='" + vidpath + "' frameborder='0' allow='accelerometer; autoplay; encrypted - media; gyroscope; picture -in -picture' allowfullscreen></iframe></div></div>"
                    ElseIf vidpath.Contains("https://vimeo.com/") Then
                        vidpath = vidpath.Replace("https://vimeo.com/", "https://player.vimeo.com/video/") + "? title = 0 & byline=0 & portrait=0"
                        vidhtml = "<div id='tutVideo'><div class='embed-responsive embed-responsive-16by9' style='height:100%'><iframe class='embed-responsive-item' id='VimeoEmbed' src='" + vidpath + "' frameborder='0' allow='autoplay; fullscreen' allowfullscreen></iframe></div></div>"
                    Else
                        vidhtml = "<div id='tutVideo'><div class='embed-responsive embed-responsive-4by3' style='height:100%'><video id='introVid' controls='controls' class='embed-responsive-item' autoplay='autoplay'>" & vbCrLf &
                                              "<source src='" & mp4FilePath & "' type='video/mp4'/>" & vbCrLf &
                                              "<object type='application/x-shockwave-flash' data='swf/VideoPlayer.swf' width='640' height='480'>" & vbCrLf &
                                               "<param name='movie' value='swf/VideoPlayer.swf'/>" & vbCrLf &
                                               "<param name='allowFullScreen' value='true'/><param name='wmode' value='transparent'/>" & vbCrLf &
                                               "<param name='flashVars' value='src=" & mp4FilePath & "&amp;autoPlay=true'/>" & vbCrLf &
                                               "<span>Video not supported</span></object></video></div></div>"
                    End If
                Else
                    mp4FilePath = Server.MapPath("~" & vidpath.Replace("swf", "mp4"))
                    mp4FilePath = apppath & vidpath
                    mp4FilePath = mp4FilePath.Replace("swf", "mp4")

                    vidhtml = "<div id='tutVideo'><div class=""embed-responsive embed-responsive-4by3""><video id=""introVid"" controls=""controls"" class=""embed-responsive-item"" autoplay=""autoplay"">" & vbCrLf &
                         "<source src=""" & mp4FilePath & """ type=""video/mp4""/>" & vbCrLf &
                         "<object type=""application/x-shockwave-flash"" data=""swf/VideoPlayer.swf"" width=""640"" height=""480"">" & vbCrLf &
                          "<param name=""movie"" value=""swf/VideoPlayer.swf""/>" & vbCrLf &
                          "<param name=""allowFullScreen"" value=""true""/><param name=""wmode"" value=""transparent""/>" & vbCrLf &
                          "<param name=""flashVars"" value=""src=" & mp4FilePath & "&amp;autoPlay=true""/>" & vbCrLf &
                          "<span>Video not supported</span></object></video></div></div>"

                End If

                Dim nVidCount As Integer = taQ.uspIncrementVideoCount(Session("lmTutorialID"))
                Dim nRateCount As Integer = taQ.GetTimesRated(Session("lmTutorialID"))
                Dim nAverageRating As Double = taQ.GetAverageRatingForVideo(Session("lmTutorialID"))
                Me.ajxVideoRating.Visible = True
                Me.btnRateThis.Visible = True
                Me.ajxVideoRating.CurrentRating = nAverageRating
                Me.lblVideoCount.Text = nVidCount.ToString() & " views"
                If nAverageRating > 0 Then
                    Me.lblVideoRate.Text = TrimString(nAverageRating.ToString(), 3) & "/5 (" & nRateCount.ToString() & " ratings)"
                Else
                    Me.lblVideoRate.Text = "not yet rated"
                End If

                Me.LitIntroVideo.Text = vidhtml
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowVideoModal", "<script>$('#videoModal').modal('show');</script>")
            Case "cmdLaunch"
                Dim taTutorial As New LearnMenuTableAdapters.QueriesTableAdapter
                Dim tutpath As String = taTutorial.GetTutPath(tid)
                If Not tutpath.Contains("http") Then
                    tutpath = apppath & tutpath
                End If


                Try
                    Dim taApplications As New ITSPTableAdapters.ApplicationsTableAdapter
                    Dim tApplications As ITSP.ApplicationsDataTable
                    Dim sColor As String = "#E0E0E0"

                    tApplications = taApplications.GetForCustomisation(CInt(Session("lmCustomisationID")))

                    Dim AppG As Integer = tApplications.First.AppGroupID
                    Select Case AppG

                        Case 1
                            sColor = "#3B1979"
                        Case 2
                            sColor = "#B5006A"
                        Case 3
                            sColor = "#11AF52"
                        Case 4
                            sColor = "#009DCA"
                    End Select
                    LMBody.Attributes("bgcolor") = sColor
                Catch ex As Exception
                    '
                    ' Leave path to movie as the default value
                    '
                End Try

                If tutpath.Contains("itspplayer.html") Then
                    Dim sTrackerURL As String
                    sTrackerURL = My.Settings.ITSPTrackingURL
                    If Not sTrackerURL.EndsWith("/") Then
                        sTrackerURL = sTrackerURL & "/"
                    End If
                    sTrackerURL = sTrackerURL & "tracker"
                    frame1.Attributes("src") = tutpath & "?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&Version=" & Session("lmCustVersion") & "&TutorialID=" & Session("lmTutorialID") & "&ProgressID=" & Session("lmProgressID") & "&type=learn" & "&TrackURL=" & sTrackerURL
                ElseIf tutpath.Contains("imsmanifest.xml") Then
                    frame1.Attributes("src") = "../scoplayer/sco?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&Version=" & Session("lmCustVersion") & "&TutorialID=" & Session("lmTutorialID") & "&tutpath=" & tutpath
                ElseIf tutpath.Contains(".dcr") Then
                    frame1.Attributes("src") = "eitslm?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&Version=" & Session("lmCustVersion") & "&tutpath=" & tutpath
                Else
                    frame1.Attributes("src") = tutpath
                End If
                mvOuter.SetActiveView(vLearningContent)
                'Page.ClientScript.RegisterStartupScript(Me.GetType(), "setlearnheight", "sizeLearnPanel();", True)
            Case "cmdSupport"
                Dim taSupport As New LearnMenuTableAdapters.QueriesTableAdapter
                Dim supportpath As String = taSupport.GetSupportPath(tid)
                If Not supportpath.StartsWith("http") Then
                    supportpath = apppath & taSupport.GetSupportPath(tid)
                End If
                supportpath = supportpath.Replace("support", "support.html")
                Dim sb As New StringBuilder()
                sb.Append("ShowSupportPopup('" & supportpath & "');")
                'if the script is not already registered
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "setlearnheight", sb.ToString(), True)
            Case "cmdConsolidation"
            Case "cmdReviewSkill"
                Dim nAspProgressID As Integer = e.CommandArgument
                hfAPID.Value = nAspProgressID
                LoadCompetencyAssessment()


        End Select
    End Sub
    Protected Sub LoadCompetencyAssessment()
        Dim nAspProgressID As Integer = hfAPID.Value
        Dim taSA As New LearnMenuTableAdapters.SkillAssessmentTableAdapter
        Dim tSA As New LearnMenu.SkillAssessmentDataTable
        tSA = taSA.GetData(nAspProgressID)
        If tSA.Count = 1 Then
            Dim r As LearnMenu.SkillAssessmentRow
            r = tSA.First
            lblSADescription.Text = r.Description
            lblSAEvidenceText.Text = r.EvidenceText
            lblSASkill.Text = r.TutorialName
            pnlSADefinition.Visible = r.Description.Length > 0
            pnlSARequirements.Visible = r.Objectives.Length > 0
            lblSAObjectives.Text = r.Objectives
            hfSASelected.Value = r.AssessDescriptorID
            Session("nAssessDecsriptorSelected") = r.AssessDescriptorID
            lblSAStatus.Text = r.SelfAssessStatus
            If r.SelfAssessStatus = "Not assessed" And IsAvailableToContributor(3) Then
                tbSAComments.Text = r.OutcomesEvidence
                mvSelfAssess.SetActiveView(vSubmitSA)
                pnlSelfAssessHeader.CssClass = "card-header clickable collapse-card"
                pnlSelfAssessBody.CssClass = "card-body collapse show"
            Else
                mvSelfAssess.SetActiveView(vViewSA)
                lblSARating.Text = r.SelfAssessStatus
                tbSASupportingComments.Text = r.OutcomesEvidence
            End If
            If Not r.SupervisorVerify Then
                pnlSV.Visible = False
            Else
                If Not r.IsSupervisorVerifiedDateNull Then
                    lblSAVerifiedDate.Text = r.SupervisorVerifiedDate.ToString("dd/MM/yyyy")
                End If
                lblSASupervisorStatus.Text = r.SupervisorOutcomeText
                lblSASupervisor.Text = r.Supervisor
                lblSASupervisorComments.Text = r.SupervisorVerifiedComments
                lblSAVerificationStatus.Text = r.SupervisorOutcomeText
                If r.IsSupervisorVerificationRequestedNull Then
                    lblRequested.Visible = False
                Else
                    lblRequested.Text = "Requested " & r.SupervisorVerificationRequested.ToString("dd/MM/yyyy")
                End If
                superviseHeader.Attributes.Remove("data-target")
                superviseHeader.Attributes.Remove("data-toggle")
                superviseHeader.Attributes.Remove("aria-controls")
                superviseHeader.Attributes.Remove("class")

                Select Case r.SupervisorOutcome
                    Case 0
                        pnlSV.CssClass = "card card-zero m-1"
                        superviseHeader.Attributes.Add("data-target", "#supervisorstatus")
                        superviseHeader.Attributes.Add("data-toggle", "collapse")
                        superviseHeader.Attributes.Add("aria-controls", "supervisorstatus")
                        superviseHeader.Attributes.Add("class", "card-header clickable clearfix collapse-card collapsed")
                    Case 1
                        superviseHeader.Attributes.Add("data-target", "#supervisorstatus")
                        superviseHeader.Attributes.Add("data-toggle", "collapse")
                        superviseHeader.Attributes.Add("aria-controls", "supervisorstatus")
                        pnlSV.CssClass = "card card-hundred m-1"
                        superviseHeader.Attributes.Add("class", "card-header clickable clearfix collapse-card collapsed")
                    Case Else
                        pnlSV.CssClass = "card card-default m-1"
                        superviseHeader.Attributes.Add("class", "card-header clearfix")
                End Select
            End If
            If r.IncludeActionPlan Then
                pnlSAEvidence.Visible = True
                dsSkillAction.SelectParameters(1).DefaultValue = r.TutorialID
                dsSkillEvidence.SelectParameters(1).DefaultValue = r.TutorialID
                lbtAddSkillEvidence.CommandArgument = r.TutorialID
                lbtAddSkillAction.CommandArgument = r.TutorialID
            Else
                pnlSAEvidence.Visible = False
            End If
            hfCompAssessTutID.Value = r.TutorialID
            dsAssessDescriptors.SelectParameters(0).DefaultValue = r.AssessmentTypeID
            Dim taAT As New LearnMenuTableAdapters.AssessmentTypesTableAdapter
            Dim rAT As LearnMenu.AssessmentTypesRow = taAT.GetDataByAssessmentTypeID(r.AssessmentTypeID).First
            pnlHorizontalPrompts.Visible = rAT.LayoutHZ
            pnlVerticalPrompts.Visible = Not rAT.LayoutHZ
            If rAT.IsSelfAssessPromptNull Then
                lblSARateYourself.Text = "Rate yourself against these requirements:"
            Else
                lblSARateYourself.Text = rAT.SelfAssessPrompt
            End If
            tbSAComments.Visible = rAT.IncludeComments
            pnlViewComments.Visible = rAT.IncludeComments
            If rAT.IncludeComments And rAT.MandatoryComments Then
                Dim rfv As New RequiredFieldValidator With {
                    .ValidationGroup = "vgSelfAssess",
                    .ControlToValidate = "tbSAComments",
                    .ErrorMessage = "Required",
                    .Display = ValidatorDisplay.Dynamic,
                    .SetFocusOnError = True,
                    .Text = "*",
                    .ToolTip = "Required",
                    .ID = "rfvSAComments"
                }
                pnlRFVHolder.Controls.Add(rfv)
            End If
            Dim taPN As New LearnMenuTableAdapters.GetNextAndPreviousaspProgressIDsTableAdapter
            Dim rPN As LearnMenu.GetNextAndPreviousaspProgressIDsRow = taPN.GetData(Session("lmProgressID"), nAspProgressID).First
            lblProgress.Text = rPN.vRowNum.ToString & "/" & rPN.vCount.ToString
            If rPN.IsvNextNull Then
                lbtFinish.Visible = True
                lbtNext.Visible = False
            Else
                lbtNext.Visible = True
                lbtFinish.Visible = False
                lbtNext.CommandArgument = rPN.vNext
            End If
            If rPN.IsvPrevNull Then
                lbtPrevious.Enabled = False
                lbtPrevious.CssClass = "btn btn-primary disabled"
            Else
                lbtPrevious.Enabled = True
                lbtPrevious.CommandArgument = rPN.vPrev
                lbtPrevious.CssClass = "btn btn-primary"
            End If
            rptAssessDescs.DataBind()
            bsgvSkillActions.DataBind()
            bsgvSkillEvidence.DataBind()
            mvLM.SetActiveView(vReviewSkill)

        End If
    End Sub
    Public Shared Function TrimString(ByVal myString As String, ByVal maxLength As Integer)
        If myString.Length > maxLength Then
            myString = myString.Substring(0, maxLength)
        End If
        Return myString
    End Function

    Private Sub btnPost_Click(sender As Object, e As EventArgs) Handles btnPost.Click
        rptLMSections.DataBind()
        fvProgSummary.DataBind()
        mvOuter.SetActiveView(vMain)
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "expandAccordion", "SetSectionCollapseState();", True)
    End Sub

    Private Sub rptLMSections_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptLMSections.ItemCommand
        If Session("lmCustomisationID") Is Nothing Then
            Logout()
        Else
            Dim hfSecID As HiddenField = e.Item.FindControl("hfSectionID")
            Dim hfRowNum As HiddenField = e.Item.FindControl("hfRowNumber")
            If Not hfSecID Is Nothing And Not hfRowNum Is Nothing Then
                Dim nSecID As Integer = hfSecID.Value
                Session("lmGvSectionRow") = hfSecID.Value
                If e.CommandName = "RateCons" Then
                    Dim ajxRate As AjaxControlToolkit.Rating = TryCast(e.Item.FindControl("ajxRateThisCons"), AjaxControlToolkit.Rating)
                    ajxRate.CurrentRating = 0
                    ajxRate.Visible = True
                    Dim lblRate As Label = TryCast(e.Item.FindControl("lblClickToRateCons"), Label)
                    lblRate.Visible = True
                    Dim btnRate As LinkButton = TryCast(e.Item.FindControl("btnRateThisCons"), LinkButton)
                    btnRate.Visible = False
                ElseIf e.CommandName = "LaunchDiag" Or e.CommandName = "LaunchPLAssess" Then
                    'Page.ClientScript.RegisterStartupScript(Me.GetType(), "setlpheight", "sizeLearnPanel();", True)
                    Session("lmDiagSectionID") = nSecID
                    Dim taDO As New LearnMenuTableAdapters.DiagObjectivesTableAdapter
                    Dim tDO As New LearnMenu.DiagObjectivesDataTable
                    If e.CommandName = "LaunchDiag" Then
                        tDO = taDO.GetBySectionAndCustomisation(nSecID, Session("lmCustomisationID"))
                    Else
                        tDO = taDO.GetData(nSecID, Session("lmCustomisationID"))
                    End If
                    ' Check that some rows are returned
                    If tDO.Count > 0 Or e.CommandName <> "LaunchDiag" Then
                        Session("lmDiagPath") = e.CommandArgument
                        If e.CommandArgument.Contains("imsmanifest.xml") Then
                            Dim sType As String

                            If e.CommandName = "LaunchDiag" Then
                                sType = "diag"
                            Else
                                sType = "pl"
                            End If
                            StartAssessment(sType)
                        Else
                            If e.CommandName = "LaunchDiag" Then
                                DiagOnlyPoint.Visible = True
                                If Session("lmCustDiagObjSelect") Then
                                    DiagOnly2.Visible = True
                                    DiagSelectForm.Style.Add("display", "inline")
                                Else
                                    DiagOnly2.Visible = False
                                    DiagSelectForm.Style.Add("display", "none")
                                End If
                            Else
                                DiagOnlyPoint.Visible = False
                                DiagOnly2.Visible = False
                                DiagSelectForm.Style.Add("display", "none")
                            End If
                            Page.ClientScript.RegisterStartupScript(Me.GetType(), "diagObjectivesModal", "<script>$('#diagObjectivesModal').modal('show');</script>")
                        End If
                    Else
                        frame1.Attributes("src") = "eitslm?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&SectionID=" & Session("lmDiagSectionID") & "&Version=" & Session("lmCustVersion") & "&tutpath=" & e.CommandArgument & "&objlist=[]"
                        mvOuter.SetActiveView(vLearningContent)
                        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "setlearnheight", "sizeLearnPanel();", True)
                    End If
                End If
            End If
        End If
    End Sub
    Public Sub StartAssessment(ByVal sType As String)
        If Session("lmCustomisationID") Is Nothing Then
            Logout()
        Else
            Dim sObjList As String = "["
            If Len(sObjList) > 1 Or sType = "pl" Then
                sObjList = sObjList.Substring(0, sObjList.Length - 1) + "]"
                If Session("lmDiagPath").Contains("itspplayer.html") Then
                    Dim sTrackerURL As String = getTrackingURL()
                    frame1.Attributes("src") = Session("lmDiagPath") & "?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&SectionID=" & Session("lmDiagSectionID") & "&Version=" & Session("lmCustVersion") & "&type=" & sType & "&objlist=" & sObjList & "&ProgressID=" & Session("lmProgressID") & "&plathresh=" & Session("lmPlaPassThreshold") & "&TrackURL=" & sTrackerURL
                ElseIf Session("lmDiagPath").Contains("imsmanifest.xml") Then

                    frame1.Attributes("src") = "../scoplayer/sco?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&SectionID=" & Session("lmDiagSectionID") & "&Version=" & Session("lmCustVersion") & "&tutpath=" & Session("lmDiagPath") & "&type=" & sType
                Else
                    frame1.Attributes("src") = "eitslm?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&SectionID=" & Session("lmDiagSectionID") & "&Version=" & Session("lmCustVersion") & "&tutpath=" & Session("lmDiagPath") & "&objlist=" & sObjList
                End If
                mvOuter.SetActiveView(vLearningContent)
                'Page.ClientScript.RegisterStartupScript(Me.GetType(), "setlearnheight", "sizeLearnPanel();", True)
            End If
        End If
    End Sub
    Protected Function getTrackingURL() As String
        Dim sTrackerURL As String
        sTrackerURL = My.Settings.ITSPTrackingURL
        If Not sTrackerURL.EndsWith("/") Then
            sTrackerURL = sTrackerURL & "/"
        End If
        sTrackerURL = sTrackerURL & "tracker"
        Return sTrackerURL
    End Function

    Private Sub vLearningContent_Activate(sender As Object, e As EventArgs) Handles vLearningContent.Activate
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "setlearnheight", "sizeLearnPanel();", True)
        learnDiv.Attributes.Add("style", "background-color:" & Session("lmBkgColour"))
    End Sub

    Private Sub fvProgSummary_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvProgSummary.ItemCommand
        Dim sURL As String
        Dim sPath As String = Request.Url.AbsoluteUri
        Dim nPos As Integer = Request.Url.AbsoluteUri.LastIndexOf("/") + 1
        If e.CommandName = "finalise" Then
            Dim taDelegate As New LearnMenuTableAdapters.CandidatesTableAdapter
            Dim tDelegate As New LearnMenu.CandidatesDataTable
            tDelegate = taDelegate.GetByCentreCandidateID(Session("UserCentreID"), Session("learnCandidateID"))
            sURL = sPath.Substring(0, nPos) & "finalise" &
            "?ProgressID=" & Session("lmProgressID")
            Response.Redirect(sURL)
        ElseIf e.CommandName = "summary" Then
            sURL = sPath.Substring(0, nPos) & "summary" &
             "?ProgressID=" & Session("lmProgressID")
            Dim pdfName As String = "ITSPSummary_" & Session("lmProgressID") & ".pdf"
            CCommon.GeneratePDFFromURL(sURL, pdfName)
        End If
    End Sub


    Protected Sub LoadLearnerProgress()

        LoadOrCreateProgress()
    End Sub
    Protected Sub LoadOrCreateProgress()
        Session("learnUserAuthenticated") = True
        Session("ContributorRole") = -1
        Dim nProgID As Int32
        If Not Page.Request.Item("pcid") Is Nothing Then
            Dim nPCID As Integer = Page.Request.Item("pcid")
            If nPCID > 0 Then
                Dim taPC As New LearnMenuTableAdapters.ProgressContributorsTableAdapter
                Dim tPC As LearnMenu.ProgressContributorsDataTable = taPC.GetByPCIDAndCandidateID(nPCID, Session("learnCandidateID"))
                If tPC.Count = 1 Then
                    If tPC.First.Active Then
                        btnContributors.Visible = False
                        btnGroup.Visible = False
                        btnSupervisor.Visible = False
                        rptProgSupervisor.Visible = False
                        nProgID = tPC.First.ProgressID
                        Session("ContributorRole") = tPC.First.ContributorRoleID
                        lbtAddSkillAction.Visible = IsAvailableToContributor(3)
                        lbtAddSkillEvidence.Visible = IsAvailableToContributor(2)
                        lbtUpdateSA.Visible = IsAvailableToContributor(4)
                        lbtLogAddComplete.Visible = IsAvailableToContributor(2)
                        lbtLogAddPlanned.Visible = IsAvailableToContributor(3)
                        taPC.UpdateLastAccess(nPCID)
                    End If

                End If
            End If
        Else
            nProgID = getProgressID()
            Dim taProgress As New LearnMenuTableAdapters.uspCreateProgressRecordTableAdapter
            Dim tProgress As New LearnMenu.uspCreateProgressRecordDataTable
            If nProgID > 0 Then
                Session("ContributorRole") = 0
                taProgress.UpdateSubmittedTime(nProgID)
            Else
                tProgress = taProgress.CreateProgress(Session("learnCandidateID"), Session("lmCustomisationID"), Session("UserCentreID"), 1, 0)
                If tProgress.Count > 0 Then
                    nProgID = getProgressID()
                End If
            End If
        End If
        If nProgID > 0 Then
            Session("lmProgressID") = nProgID
            StartSession()
        Else
            Response.Redirect(Session("LearningPortalUrl") & "?invalid=1")
        End If

    End Sub
    Protected Function GetNiceDate(ByVal d As DateTime)
        Dim s As String = CCommon.GetPrettyDate(d)
        Return s
    End Function
    Private Sub rptLMSections_DataBinding(sender As Object, e As EventArgs) Handles rptLMSections.DataBinding
        Dim nPID As Integer = Session("lmProgressID")
        Dim taQ As New LearnMenuTableAdapters.QueriesTableAdapter
        Session("lmCohortGroupCustomisationID") = taQ.GetGroupCustomisationIDForCohort(nPID)
        If Session("lmCohortGroupCustomisationID") > 0 Then
            btnGroup.Visible = True
        End If
        CCommon.CheckProgressForCompletion(nPID, Session("learnCandidateID"), CInt(Session("UserCentreID")))
    End Sub


    Private Sub lbtDiagVid_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtDiagVid.Click, lbtLearnVid.Click, lbtPLAssess.Click
        Dim vidhtml As String
        Dim apppath As String = Request.Url.GetLeftPart(UriPartial.Authority) & Request.ApplicationPath
        Dim mp4FilePath As String = apppath & "/mp4/learning_demo.mp4"
        Dim lbt As LinkButton = TryCast(sender, LinkButton)
        Select Case lbt.CommandName
            Case "DiagVid"
                mp4FilePath = apppath & "/mp4/diagnostic_demo.mp4"
            Case "LearnVid"
                mp4FilePath = apppath & "/mp4/learning_demo.mp4"
            Case "PLVid"
                mp4FilePath = apppath & "/mp4/PLA_demo.mp4"
        End Select

        vidhtml = "<div id='tutVideo'><div class=""embed-responsive embed-responsive-4by3""><video id=""introVid"" controls=""controls"" autoplay=""autoplay"" width=""640"" height=""480"">" & vbCrLf &
         "<source src=""" & mp4FilePath & """ type=""video/mp4""/>" & vbCrLf &
         "<object type=""application/x-shockwave-flash"" data=""swf/VideoPlayer.swf"" width=""640"" height=""480"">" & vbCrLf &
          "<param name=""movie"" value=""swf/VideoPlayer.swf""/>" & vbCrLf &
          "<param name=""allowFullScreen"" value=""true""/><param name=""wmode"" value=""transparent""/>" & vbCrLf &
          "<param name=""flashVars"" value=""src=" & mp4FilePath & "&amp;autoPlay=true""/>" & vbCrLf &
          "<span>Video not supported</span></object></video></div></div>"

        Me.btnRateThis.Visible = False
        Me.lblVideoCount.Text = ""

        Me.lblVideoRate.Text = ""

        Me.LitIntroVideo.Text = vidhtml
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowVideoModal", "<script>$('#videoModal').modal('show');</script>")
    End Sub

    Private Sub btnSwitchView_Click(sender As Object, e As EventArgs) Handles btnSwitchView.Click
        frame1.Src = hfAssessSrc.Value
        mvOuter.SetActiveView(vLearningContent)
    End Sub

    Private Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        If Page.IsValid Then
            Session("pwComplete") = True
            mvOuter.SetActiveView(vMain)
        End If
    End Sub

    Private Sub dsPlanned_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsPlanned.Selected
        If e.ReturnValue.Count > 0 Then
            lblPlanned.Text = "Planned <b>(" + e.ReturnValue.Count.ToString() + " activities)</b>"
        End If
    End Sub

    Private Sub dsComplete_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsComplete.Selected
        If e.ReturnValue.Count > 0 Then
            lblComplete.Text = "Complete <b>(" + e.ReturnValue.Count.ToString() + " activities)</b>"
        End If
    End Sub

    Private Sub lbtCloseCompetency_Click(sender As Object, e As EventArgs) Handles lbtCloseCompetency.Click, lbtFinish.Click
        ClearCompetency()
        hfCompAssessTutID.Value = 0
        rptLMSections.DataBind()
        mvLM.SetActiveView(vLM)
    End Sub
    Protected Sub ClearCompetency()

    End Sub
    Private Sub lbtSASubmit_Click(sender As Object, e As EventArgs) Handles lbtSASubmit.Click
        Dim nAssessDescID As Integer = hfSASelected.Value
        If nAssessDescID > 0 Then
            Dim taSA As New LearnMenuTableAdapters.SkillAssessmentTableAdapter
            taSA.UpdateAspProgressForCompetency(hfAPID.Value, nAssessDescID, tbSAComments.Text, Session("learnCandidateID"))
        End If
        tbSAComments.Text = ""
        LoadCompetencyAssessment()

    End Sub

    Private Sub lbtUpdateSA_Click(sender As Object, e As EventArgs) Handles lbtUpdateSA.Click
        Dim nAssessDescID As Integer = hfSASelected.Value
        If nAssessDescID > 0 Then

            Dim hf As HiddenField

            Dim hl As HyperLink
            For Each r As RepeaterItem In rptHZAssessTabs.Items
                hf = r.FindControl("hfAssessDescID")
                If Not hf Is Nothing Then
                    If hf.Value = nAssessDescID Then
                        hl = r.FindControl("hlAssessDesc")
                        If Not hl Is Nothing Then
                            hl.Attributes.Add("data-checked", "true")
                        End If
                    End If
                End If
            Next

            Dim pnl As Panel
            For Each r As RepeaterItem In rptAssessDescs.Items
                hf = r.FindControl("hfAssessDescID")
                If Not hf Is Nothing Then
                    If hf.Value = nAssessDescID Then
                        pnl = r.FindControl("pnlChoice")
                        If Not pnl Is Nothing Then
                            pnl.Attributes.Add("data-checked", "true")
                        End If
                    End If
                End If
            Next
        End If

        tbSAComments.Text = tbSASupportingComments.Text
        mvSelfAssess.SetActiveView(vSubmitSA)
    End Sub

    Protected Sub lbtAddSkillAction_Command(sender As Object, e As CommandEventArgs)
        bsbtSubmitPlannedActivity.CommandName = "Insert"
        DataBindNestedListBox(bsddeTutorialsLogItemPlanned, "bslbTutorialsLogItemPlanned")
        If Session("lmDelegateByteLimit") > 0 Then
            lblAddEvPlanned.Text = "I have evidence files to upload against this log item:"
            pnlAddEvidencePlanned.Visible = True
        Else
            pnlAddEvidencePlanned.Visible = False
        End If

        lblPlannedHeading.Text = "Record Planned Development Activity"
        mvLM.SetActiveView(vLogItemPlanned)
    End Sub

    Protected Sub lbtAddSkillEvidence_Command(sender As Object, e As CommandEventArgs)
        bsbtSubmitCompletedLogItem.CommandName = "Insert"
        DataBindNestedListBox(bsddeTutorialsLogItem, "bslbTutorialsLogItem")
        If Session("lmDelegateByteLimit") > 0 Then
            lblCBAddEv.Text = "I have evidence files to upload against this log item:"
            pnlAddEvidence.Visible = True
        Else
            pnlAddEvidence.Visible = False
        End If
        lblLogItemHeading.Text = "Record Completed Development Activity / Evidence"
        mvLM.SetActiveView(vLogItemComplete)
    End Sub

    Protected Sub bslbTutorialsLogItem_DataBound(sender As Object, e As EventArgs)
        Dim nTutID As Integer = hfCompAssessTutID.Value
        Dim bslb As BootstrapListBox = TryCast(sender, BootstrapListBox)
        For Each i As BootstrapListEditItem In bslb.Items
            If i.Value = nTutID Then
                i.Selected = True
            End If
        Next
    End Sub

    Protected Sub bslbTutorialsLogItemPlanned_DataBound(sender As Object, e As EventArgs)
        Dim nTutID As Integer = hfCompAssessTutID.Value
        Dim bslb As BootstrapListBox = TryCast(sender, BootstrapListBox)
        For Each i As BootstrapListEditItem In bslb.Items
            If i.Value = nTutID Then
                i.Selected = True
            End If
        Next
    End Sub

    Protected Sub bsbtSubmitPlannedActivity_Command(sender As Object, e As CommandEventArgs)
        'Get a CSV string of selected tutorial IDs matched to this log item:
        Dim sTutsCSV As String = GetCSVFromListBoxInDropDown(bsddeTutorialsLogItemPlanned, "bslbTutorialsLogItemPlanned")
        Dim taQ As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim nLearningLogItemID As Integer
        Dim dDue As Date?
        Dim dComplete As Date?
        If bsdeDueDatePlanned.Date > Date.Now() Then
            dDue = bsdeDueDatePlanned.Date
        End If
        Dim nMins = CInt(bspinHoursExpected.Value) * 60 + CInt(bspinMinsExpected.Value)
        Dim nApptType As Integer = 7
        If CInt(ddCustomisationPlanned.SelectedValue) > 0 Then
            nApptType = 5
        End If
        Dim nMethod As Integer = 6
        If Not bscbxMethod.Value Is Nothing Then
            nMethod = CInt(bscbxMethodPlanned.Value)
        End If
        If e.CommandName = "Insert" Then
            Try
                nLearningLogItemID = taQ.InsertLearningLogItem(Session("learnCandidateID"), dDue, dComplete, nMins, nMethod, bstbMethodOtherPlanned.Text, bstbTopicPlanned.Text, bsmemOutcomesPlanned.Text, Session("UserCentreID"), CInt(ddCustomisationPlanned.SelectedValue), Session("lmProgressID").ToString(), sTutsCSV, 0, nApptType)
            Catch Ex As Exception
                Dim msg As String = Ex.Message
            End Try
        ElseIf e.CommandName = "Update" Then
            nLearningLogItemID = e.CommandArgument
            taQ.UpdateLearningLogItem(nLearningLogItemID, Session("learnCandidateID"), dDue, dComplete, nMins, nMethod, bstbMethodOtherPlanned.Text, bstbTopicPlanned.Text, bsmemOutcomesPlanned.Text, Session("UserCentreID"), CInt(ddCustomisationPlanned.SelectedValue), Session("lmProgressID").ToString(), sTutsCSV)
        End If
        If nLearningLogItemID > 0 Then
            If bscbHasEvidenceFilesPlanned.Checked Then
                Session("learnCurrentLogItemID") = nLearningLogItemID
                Dim ds As ObjectDataSource = fmxsess.FindControl("dsFiles")
                ds.SelectParameters(0).DefaultValue = nLearningLogItemID
                lblLogItemName.Text = IIf(bstbMethodOtherPlanned.Text.Length > 0, bstbMethodOtherPlanned.Text, bscbxMethodPlanned.SelectedItem.Text) & " " & bstbTopicPlanned.Text
                'vEvidenceFiles.Controls.Add(fmx)
                mvLM.SetActiveView(vEvidenceFiles)
            Else
                If hfCompAssessTutID.Value = 0 Then
                    mvLM.SetActiveView(vLM)
                Else
                    LoadCompetencyAssessment()
                End If
            End If
        End If
        bsgvPlanned.DataBind()
        ClearPlannedLogItemForm()
    End Sub

    Protected Sub lbtSubmitCompletedLogItem_Command(sender As Object, e As CommandEventArgs)
        'Get a CSV string of selected tutorial IDs matched to this log item:
        Dim sTutsCSV As String = GetCSVFromListBoxInDropDown(bsddeTutorialsLogItem, "bslbTutorialsLogItem")
        Dim taQ As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim nLearningLogItemID As Integer = 0
        Dim dDue As Date?
        Dim dComplete As Date?
        If bsdeDueDate.Date > DateAdd(DateInterval.Year, -5, Date.Now()) Then
            dDue = bsdeDueDate.Date
        End If
        If bsdeCompletedDate.Date < DateAdd(DateInterval.Month, 1, Date.Now()) Then
            dComplete = bsdeCompletedDate.Date
        End If
        Dim nMins = CInt(bspinHours.Value) * 60 + CInt(bspinMins.Value)
        Dim nApptType As Integer = 7
        If CInt(ddCustomisationCompleted.SelectedValue) > 0 Then
            nApptType = 5
        End If
        Dim nMethod As Integer = 6
        If Not bscbxMethod.Value Is Nothing Then
            nMethod = CInt(bscbxMethod.Value)
        End If
        If e.CommandName = "Insert" Then
            Try
                nLearningLogItemID = taQ.InsertLearningLogItem(Session("learnCandidateID"), dDue, dComplete, nMins, nMethod, bstbMethodOther.Text, bstbTopic.Text, bsmemOutcomes.Text, Session("UserCentreID"), CInt(ddCustomisationCompleted.SelectedValue), Session("lmProgressID").ToString(), sTutsCSV, 0, nApptType)
            Catch ex As Exception
                Dim msg As String = ex.Message
            End Try
        ElseIf e.CommandName = "Update" Then
            nLearningLogItemID = e.CommandArgument
            taQ.UpdateLearningLogItem(nLearningLogItemID, Session("learnCandidateID"), dDue, dComplete, nMins, nMethod, bstbMethodOther.Text, bstbTopic.Text, bsmemOutcomes.Text, Session("UserCentreID"), CInt(ddCustomisationCompleted.SelectedValue), Session("lmProgressID").ToString(), sTutsCSV)
        End If
        If nLearningLogItemID > 0 Then
            If bscbHasEvidenceFiles.Checked Then

                Session("learnCurrentLogItemID") = nLearningLogItemID
                Dim rpt As Repeater = fmxsess.FindControl("rptFiles")
                rpt.DataBind()
                lblLogItemName.Text = IIf(bstbMethodOther.Text.Length > 0, bstbMethodOther.Text, bscbxMethod.SelectedItem.Text) & " " & bstbTopic.Text
                'vEvidenceFiles.Controls.Add(fmx)
                mvLM.SetActiveView(vEvidenceFiles)
            Else
                If hfCompAssessTutID.Value = 0 Then
                    mvLM.SetActiveView(vLM)
                Else
                    LoadCompetencyAssessment()
                End If
            End If
            ClearCompletedLogItemForm()
            bsgvPlanned.DataBind()
            bsgvComplete.DataBind()
        End If
    End Sub
    Protected Sub ClearCompletedLogItemForm()
        bsdeCompletedDate.Text = ""
        bsdeDueDate.Text = ""
        bscbxMethod.Value = Nothing
        bstbMethodOther.Text = ""
        bstbTopic.Text = ""
        bsmemOutcomes.Text = ""
        ddCustomisationCompleted.SelectedValue = 0
        bspinHours.Value = 0
        bspinMins.Value = 0
        bscbHasEvidenceFiles.Checked = False
        ClearBootstrapListBox(bsddeTutorialsLogItem, "bslbTutorialsLogItem")
    End Sub
    Protected Sub ClearPlannedLogItemForm()
        bsdeDueDatePlanned.Text = ""
        bscbxMethodPlanned.Value = Nothing
        bstbMethodOtherPlanned.Text = ""
        bstbTopicPlanned.Text = ""
        bsmemOutcomesPlanned.Text = ""
        ddCustomisationPlanned.SelectedValue = 0
        bspinHoursExpected.Value = 0
        bspinMinsExpected.Value = 0
        bscbHasEvidenceFilesPlanned.Checked = False
        ClearBootstrapListBox(bsddeTutorialsLogItemPlanned, "bslbTutorialsLogItemPlanned")
    End Sub
    Protected Function GetCSVFromListBoxInDropDown(dd As BootstrapDropDownEdit, sLBName As String) As String
        Dim sCSV As String = ""
        Dim bslb As BootstrapListBox = dd.FindControl(sLBName)
        If Not bslb Is Nothing Then
            For Each i As BootstrapListEditItem In bslb.Items
                If i.Selected Then
                    sCSV = sCSV + i.Value.ToString() + ", "
                End If
            Next
        End If
        If sCSV.Length > 2 Then
            sCSV = sCSV.Substring(0, sCSV.Length - 2)
        End If
        Return sCSV
    End Function
    Protected Sub DataBindNestedListBox(dd As BootstrapDropDownEdit, sLBName As String)
        Dim bslb As BootstrapListBox = dd.FindControl(sLBName)
        bslb.DataBind()
    End Sub
    Protected Sub lbtCancelAddCompleted_Command(sender As Object, e As CommandEventArgs)
        ClearCompletedLogItemForm()
        ClearPlannedLogItemForm()
        If hfCompAssessTutID.Value = 0 Then
            mvLM.SetActiveView(vLM)
        Else
            LoadCompetencyAssessment()
        End If
    End Sub

    Protected Sub ddCustomisationCompleted_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim taApp As New LearnMenuTableAdapters.ApplicationsInfoTableAdapter
        Dim tapp As New LearnMenu.ApplicationsInfoDataTable
        tapp = taApp.GetCompletedByCustCand(Session("learnCandidateID"), ddCustomisationCompleted.SelectedValue)
        If tapp.Count = 1 Then
            Dim r As LearnMenu.ApplicationsInfoRow
            r = tapp.First
            For Each i As BootstrapListEditItem In bscbxMethod.Items
                If i.Text.ToLower() = "completed" Then
                    i.Selected = True
                    Exit For
                End If
            Next
            bstbTopic.Text = r.CourseName
            If Not r.IsApplicationInfoNull Then
                bsmemOutcomes.Text = "FROM COURSE DESCRIPTION: " & r.ApplicationInfo.ToString
            End If
            bsdeCompletedDate.Date = r.Completed
            Dim hrs As Integer = 0
            Dim mins As Integer = r.DurationMins
            If r.DurationMins >= 60 Then
                hrs = r.DurationMins / 60
                mins = r.DurationMins Mod 60
            End If
            bspinHours.Value = hrs
            bspinMins.Value = mins
        End If
    End Sub

    Protected Sub ddCustomisationPlanned_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim taApp As New LearnMenuTableAdapters.ApplicationsInfoTableAdapter
        Dim tapp As New LearnMenu.ApplicationsInfoDataTable
        tapp = taApp.GetForPlanned(ddCustomisationPlanned.SelectedValue)
        If tapp.Count = 1 Then
            Dim r As LearnMenu.ApplicationsInfoRow
            r = tapp.First
            For Each i As BootstrapListEditItem In bscbxMethodPlanned.Items
                If i.Text.ToLower() = "complete" Then
                    i.Selected = True
                    Exit For
                End If
            Next
            bstbTopicPlanned.Text = r.CourseName
            If Not r.IsApplicationInfoNull Then
                bsmemOutcomesPlanned.Text = "FROM COURSE DESCRIPTION: " & r.ApplicationInfo.ToString
            End If
            Dim hrs As Integer = 0
            Dim mins As Integer = r.DurationMins
            If r.DurationMins >= 60 Then
                hrs = r.DurationMins / 60
                mins = r.DurationMins Mod 60
            End If
            bspinHoursExpected.Value = hrs
            bspinMinsExpected.Value = mins
        End If
    End Sub

    Private Sub dsSkillEvidence_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsSkillEvidence.Selected

        lblEvidenceCount.Text = e.ReturnValue.Count.ToString()
    End Sub

    Private Sub dsSkillAction_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsSkillAction.Selected
        lblActionsCount.Text = e.ReturnValue.Count.ToString()
    End Sub

    Protected Function GetIconClass(ByVal sFileName As String) As String
        Return CCommon.GetIconClass(sFileName)
    End Function

    Protected Sub lbtEditLogItem_Command(sender As Object, e As CommandEventArgs)
        Dim nLogItemID As Integer = e.CommandArgument
        Dim taLI As New LearnMenuTableAdapters.LearningLogItemsTableAdapter
        Session("learnCurrentLogItemID") = nLogItemID
        If e.CommandName = "EditPlanned" Then

            Dim tLI As LearnMenu.LearningLogItemsDataTable = taLI.GetByLearningLogItemID(nLogItemID)
            If tLI.Count = 1 Then
                Dim r As LearnMenu.LearningLogItemsRow = tLI.First
                Dim dtFormat As String = "dd/MM/yyyy HH:mm"
                If Not r.IsDueDateNull Then
                    bsdeDueDatePlanned.Text = r.DueDate.ToString(dtFormat)
                End If
                If Not r.IsMethodIDNull Then
                    bscbxMethodPlanned.Value = r.MethodID
                End If
                bstbMethodOtherPlanned.Text = r.MethodOther
                bstbTopicPlanned.Text = r.Topic
                bsmemOutcomesPlanned.Text = r.Outcomes
                If r.LinkedCustomisationID > 0 Then
                    pnlCustPlanned.Visible = False
                End If
                Dim hrs As Integer = 0
                Dim mins As Integer = r.DurationMins
                If r.DurationMins >= 60 Then
                    hrs = r.DurationMins / 60
                    mins = r.DurationMins Mod 60
                End If
                bspinHoursExpected.Value = hrs
                bspinMinsExpected.Value = mins
                lblPlannedHeading.Text = "Edit Planned Development Activity"
                If Session("lmDelegateByteLimit") > 0 Then
                    lblAddEvPlanned.Text = "Manage evidence files after updating (" & r.FileCount.ToString & " files currently attached):"
                    pnlAddEvidencePlanned.Visible = True
                Else
                    pnlAddEvidencePlanned.Visible = False
                End If
                bsbtSubmitPlannedActivity.CommandName = "Update"
                bsbtSubmitPlannedActivity.CommandArgument = nLogItemID
                bsddeTutorialsLogItemPlanned.DataBind()
                PopulateAssociatedTutorialsDropDown(bsddeTutorialsLogItemPlanned, "bslbTutorialsLogItemPlanned", nLogItemID)
                mvLM.SetActiveView(vLogItemPlanned)
            End If

        ElseIf e.CommandName = "EditComplete" Or e.CommandName = "MarkComplete" Then
            Dim tLI As LearnMenu.LearningLogItemsDataTable = taLI.GetByLearningLogItemID(nLogItemID)
            If tLI.Count = 1 Then
                Dim r As LearnMenu.LearningLogItemsRow = tLI.First
                If Not r.IsCompletedDateNull Then
                    bsdeCompletedDate.Text = r.CompletedDate
                End If
                Dim dtFormat As String = "dd/MM/yyyy HH:mm"
                If Not r.IsDueDateNull Then
                    bsdeDueDate.Text = r.DueDate.ToString(dtFormat)
                End If
                If Not r.IsMethodIDNull Then
                    bscbxMethod.Value = r.MethodID
                End If
                bstbMethodOther.Text = r.MethodOther
                bstbTopic.Text = r.Topic
                bsmemOutcomes.Text = r.Outcomes
                If r.LinkedCustomisationID > 0 Then
                    pnlCustComp.Visible = False
                End If
                Dim hrs As Integer = 0
                Dim mins As Integer = r.DurationMins
                If r.DurationMins >= 60 Then
                    hrs = r.DurationMins / 60
                    mins = r.DurationMins Mod 60
                End If
                bspinHours.Value = hrs
                bspinMins.Value = mins
                bsddeTutorialsLogItem.DataBind()
                PopulateAssociatedTutorialsDropDown(bsddeTutorialsLogItem, "bslbTutorialsLogItem", nLogItemID)
                If e.CommandName = "MarkComplete" Then
                    lblLogItemHeading.Text = "Mark Planned Development Activity Complete"
                    lblCBAddEv.Text = "I have evidence files to upload against this log item:"
                Else
                    lblCBAddEv.Text = "Manage evidence files after updating (" & r.FileCount.ToString & " files currently attached):"
                    lblLogItemHeading.Text = "Edit Completed Development Activity / Evidence"
                End If
                If Session("lmDelegateByteLimit") = 0 Then
                    pnlAddEvidence.Visible = False
                End If
                bsbtSubmitCompletedLogItem.CommandName = "Update"
                bsbtSubmitCompletedLogItem.CommandArgument = nLogItemID
                mvLM.SetActiveView(vLogItemComplete)
            End If
        ElseIf e.CommandName = "Archive" Then
            Dim bsgv As BootstrapGridView = TryCast(sender.NamingContainer.Grid, BootstrapGridView)
            taLI.ArchiveLogItem(Session("learnCandidateID"), e.CommandArgument)
            taLI.RemoveFileDataForArchivedLogItem(e.CommandArgument)
            bsgv.DataBind()
        ElseIf e.CommandName = "MarkUta" Then
            'need to add notification to supervisor in here.
            Dim bsgv As BootstrapGridView = TryCast(sender.NamingContainer.Grid, BootstrapGridView)
            taLI.DeleteProgressLogItem(Session("learnCandidateID"), e.CommandArgument)
            bsgv.DataBind()
        ElseIf e.CommandName = "LaunchDLS" Then
            Dim nCustomisationID As Integer = CInt(e.CommandArgument)
            If nCustomisationID <= 0 Or Session("learnCandidateNumber") Is Nothing Then
                Exit Sub
            End If
            Dim sURL As String = My.Settings.ITSPTrackingURL & "learn?CustomisationID=" & nCustomisationID.ToString & "&lp=1"
            Response.Redirect(sURL)
        ElseIf e.CommandName = "AddRA" Then
            Dim tLI As LearnMenu.LearningLogItemsDataTable = taLI.GetByLearningLogItemID(nLogItemID)
            If tLI.Count = 1 Then
                bsbtnSubmitRA.CommandName = "Insert"
                Dim r As LearnMenu.LearningLogItemsRow = tLI.First
                tbRAActivity.Text = r.Topic
                tbRALearn.Text = r.Outcomes
                tbRAPractice.Text = ""
                bscbPractiseEffectively.Checked = False
                bscbPreserveSafety.Checked = False
                bscbPrioritisePeople.Checked = False
                bscbPromoteProfessionalism.Checked = False
                mvLM.SetActiveView(vReflectiveAccount)
            End If
        ElseIf e.CommandName = "EditRA" Then
            Dim taRA As New LearnMenuTableAdapters.ReflectiveAccountsTableAdapter
            Dim tRA As LearnMenu.ReflectiveAccountsDataTable = taRA.GetData(Session("learnCandidateID"), e.CommandArgument)
            If tRA.Count > 0 Then
                bsbtnSubmitRA.CommandName = "Update"
                Dim r As LearnMenu.ReflectiveAccountsRow = tRA.First
                tbRAActivity.Text = r.Topic
                tbRALearn.Text = r.LearningOutcomes
                tbRAPractice.Text = r.ChangesToPractice
                bscbPractiseEffectively.Checked = r.PractiseEffectively
                bscbPreserveSafety.Checked = r.PreserveSafety
                bscbPrioritisePeople.Checked = r.PrioritisePeople
                bscbPromoteProfessionalism.Checked = r.PromoteProfessionalism
                mvLM.SetActiveView(vReflectiveAccount)
            End If

        End If

    End Sub
    Protected Sub PopulateAssociatedTutorialsDropDown(dd As BootstrapDropDownEdit, sLBName As String, nLogItem As Integer)
        Dim taLLIT As New LearnMenuTableAdapters.LearningLogItemTutorialsTableAdapter
        Dim tLLLIT As LearnMenu.LearningLogItemTutorialsDataTable = taLLIT.GetData(nLogItem)
        If tLLLIT.Count > 0 Then
            Dim bslb As BootstrapListBox = dd.FindControl(sLBName)
            If Not bslb Is Nothing Then
                For Each i As BootstrapListEditItem In bslb.Items
                    For Each r As LearnMenu.LearningLogItemTutorialsRow In tLLLIT.Rows
                        If i.Value = r.TutorialID Then
                            i.Selected = True
                            Exit For
                        End If
                    Next
                Next
            End If
        End If
    End Sub
    Protected Sub ClearBootstrapListBox(dd As BootstrapDropDownEdit, sLBName As String)
        Dim bslb As BootstrapListBox = dd.FindControl(sLBName)
        If Not bslb Is Nothing Then
            For Each i As BootstrapListEditItem In bslb.Items
                i.Selected = False
            Next
        End If
    End Sub

    Protected Sub filemx_Init(sender As Object, e As System.EventArgs)
        Dim fmx As filemx = TryCast(sender, filemx)
        Dim ds As ObjectDataSource = fmx.FindControl("dsFiles")
        Dim ct As DevExpress.Web.GridViewDetailRowTemplateContainer = TryCast(sender.NamingContainer, DevExpress.Web.GridViewDetailRowTemplateContainer)
        If Not ct Is Nothing And Not ds Is Nothing Then
            Session("learnCurrentLogItemID") = ct.KeyValue
            ds.SelectParameters(0).DefaultValue = CInt(ct.KeyValue)
        End If
    End Sub

    Private Sub vReviewSkill_Activate(sender As Object, e As EventArgs) Handles vReviewSkill.Activate
        lbtClose.CommandName = "ReturnToSkill"
    End Sub

    Private Sub vLM_Activate(sender As Object, e As EventArgs) Handles vLM.Activate
        If pnlDevLog.Visible Then

            bsgvComplete.DataBind()
            bsgvPlanned.DataBind()

        End If
        lbtClose.CommandName = "ReturnToLM"
    End Sub

    Private Sub lbtClose_Command(sender As Object, e As CommandEventArgs) Handles lbtClose.Command
        Session("learnCurrentLogItemID") = Nothing
        If e.CommandName = "ReturnToLM" Then
            bsgvComplete.DataBind()
            bsgvPlanned.DataBind()
            mvLM.SetActiveView(vLM)
        Else
            bsgvSkillActions.DataBind()
            bsgvSkillEvidence.DataBind()
            mvLM.SetActiveView(vReviewSkill)
        End If
    End Sub
    Protected Function GetNiceMins(nMins As Integer) As String
        Dim sReturn As String
        Dim hrs As Integer = 0
        Dim mins As Integer = nMins
        sReturn = mins.ToString & " mins"
        If nMins >= 60 Then
            hrs = nMins / 60
            mins = nMins Mod 60
            If mins > 0 Then
                sReturn = hrs.ToString & " hrs " & mins.ToString & " mins"
            Else
                If hrs > 1 Then
                    sReturn = hrs.ToString & " hrs"
                Else
                    sReturn = hrs.ToString & " hr"
                End If
            End If
        End If
        Return sReturn
    End Function

    Protected Sub lbtDownloadICS_Command(sender As Object, e As CommandEventArgs)
        'implement downloading appointment here:
        Dim taLIC As New LearnMenuTableAdapters.LearningLogItemsCalTableAdapter
        Dim r As LearnMenu.LearningLogItemsCalRow = taLIC.GetData(e.CommandArgument).First
        Dim sCourseTitle As String = lblPageTitle.Text

        Dim sSummary As String = "DLS Planned Action: " & r.Method & " " & r.Topic
        Dim sbDesc As New StringBuilder()
        sbDesc.Append(sSummary & "\n\n")
        sbDesc.AppendFormat("Added under the activity {0}", sCourseTitle)
        sbDesc.Append("Objectives / Outcomes:\n")
        sbDesc.Append(r.Outcomes & "\n\n")
        sbDesc.Append("Linked to Requirements:\n")
        sbDesc.Append(r.LinkedTo & "\n\n")
        sbDesc.Append("To update your DLS action, please visit the following link: " & Request.Url.ToString())
        Dim sbDescHtml As New StringBuilder()
        sbDescHtml.Append("<html><body>")
        sbDescHtml.AppendFormat("<h3>DLS Planned Action</h3><h2>{0} {1}</h2>", r.Method, r.Topic)
        sbDescHtml.AppendFormat("<p>Added under the activity <strong><a href='{0}'>{1}</a></strong></p>", Request.Url.ToString(), sCourseTitle)
        sbDescHtml.AppendFormat("<h3>Objectives/Outcomes:</h3><p>{0}</p>", r.Outcomes)
        sbDescHtml.AppendFormat("<h3>Linked to Requirements:</h3><p>{0}</p>", r.LinkedTo)
        sbDescHtml.AppendFormat("<p>To update your DLS action please visit the <a href='{0}'>{1} Menu</a></p>", Request.Url.ToString(), sCourseTitle)
        sbDescHtml.Append("</body></html>")
        Dim bAllDay As Boolean = False
        If r.StartDate.TimeOfDay.Ticks = 0 Then
            bAllDay = True
        End If
        CCommon.DownloadCalendarEntry(r.StartDate, r.EndDate, Session("UserEmail"), "", sSummary, sbDesc.ToString(), sbDescHtml.ToString(), r.ICSGUID.ToString(), 0, 0, 15, bAllDay, r.Method & r.Topic)
    End Sub

    Private Sub dsProgSupervisor_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsProgSupervisor.Selected
        If e.ReturnValue.Count = 0 And Session("lmSVVerified") Then
            lbtCancelSetSV.Visible = False
            pnlChooseSV.Visible = True
            rptProgSupervisor.Visible = False
        Else
            lbtCancelSetSV.Visible = True
            rptProgSupervisor.Visible = True
            pnlChooseSV.Visible = False
        End If
    End Sub

    Protected Sub lbtSetSV_Command(sender As Object, e As CommandEventArgs)
        If ddSupervisor.SelectedValue > 0 Then
            Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
            Dim bUpdated As Boolean = taq.SetSupervisorForProgress(Session("lmProgressID"), ddSupervisor.SelectedValue)
            If bUpdated Then
                Dim taSVE As New SuperviseDataTableAdapters.SetSupervisorEmailTableAdapter
                Dim rSVE As SuperviseData.SetSupervisorEmailRow = taSVE.GetData(Session("lmProgressID")).First
                Dim SbBody As New StringBuilder
                SbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")
                SbBody.Append("<p>Dear " & rSVE.AdminName & "</p>")
                SbBody.Append("<p>This is an automated message from the Digital Learning Solutions (DLS) platform to notify you that you have been identified as supervisor by <b>" + rSVE.DelegateName + "</b> for their course or activity <b>" + rSVE.CourseName + "</b>.</p>")
                SbBody.Append("<p>To access the DLS Supervisor interface to supervise this delegate, please visit the <a href='" & My.Settings.ITSPTrackingURL & "/supervise'>DLS Supervisor Interface</a>.</p>")
                SbBody.Append("<p>To contact the delegate to discuss this supervision request, e-mail them at <a href='mailto:" & Session("UserEmail") & "'>" & Session("UserEmail") & "</a>.</p>")
                SbBody.Append("</body>")
                Dim sSubject As String = "You were nominated as Supervisor by a DLS Delegate"
                CCommon.SendEmail(rSVE.AdminEmail, sSubject, SbBody.ToString(), True,,,, 15, rSVE.AdminID)
            End If
            rptProgSupervisor.DataBind()
        End If
    End Sub

    Protected Sub lbtChangeSupervisor_Command(sender As Object, e As CommandEventArgs)
        pnlChooseSV.Visible = True
        rptProgSupervisor.Visible = False
    End Sub

    Protected Sub lbtCancelSetSV_Command(sender As Object, e As CommandEventArgs)
        rptProgSupervisor.Visible = True
        pnlChooseSV.Visible = False
    End Sub

    Protected Sub lbtSubmitVerificationRequest_Command(sender As Object, e As CommandEventArgs)
        Dim nRequestCount = 0
        Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
        For Each i As BootstrapListEditItem In bslbRequestVerification.Items
            If i.Selected Then
                nRequestCount += 1
                taq.RequestVerificationForAspProgID(i.Value)
            End If
        Next
        If nRequestCount > 0 Then
            Dim taSV As New LearnMenuTableAdapters.SupervisorTableAdapter
            Dim rSV As LearnMenu.SupervisorRow = taSV.GetDataByProgressID(Session("lmProgressID")).First

            'we need to email supervisor:
            Dim SbBody As New StringBuilder
            SbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")
            SbBody.Append("<p>Dear " & rSV.Forename & " " & rSV.Surname & "</p>")
            SbBody.Append("<p>" & Session("UserForename") & " " & Session("UserSurname") & ", has requested that you verify " & nRequestCount & " skills or objectives against their Digital Learning Solutions activity <b>" & lblPageTitle.Text & "</b>.</p>")

            SbBody.Append("<p>To review and verify these skills or objectives, please visit the <a href='" & My.Settings.ITSPTrackingURL & "/supervise'>DLS Supervisor Interface</a>.</p>")
            SbBody.Append("<p>To contact the delegate to discuss this verification request, e-mail them at <a href='mailto:" & Session("UserEmail") & "'>" & Session("UserEmail") & "</a>.</p>")

            SbBody.Append("</body>")
            Dim sSubject As String = "DLS Supervisor Verification Request"
            CCommon.SendEmail(rSV.Email, sSubject, SbBody.ToString(), True,,,, 16, rSV.AdminID)
            rptLMSections.DataBind()
        End If
    End Sub

    Protected Sub lbtRequestVerification_Command(sender As Object, e As CommandEventArgs)
        dsSkillsToVerify.SelectParameters(0).DefaultValue = Session("lmProgressID")
        bslbRequestVerification.DataBind()
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowRequestVerificationModal", "<script>$('#verificationRequestModal').modal('show');</script>")
    End Sub

    Protected Sub dsSkillsToVerify_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs)
        bslbRequestVerification.Visible = False
        pnlNothingToValidate.Visible = True
        lbtSubmitVerificationRequest.Visible = False
        If Not e.ReturnValue.Count Is Nothing Then
            If e.ReturnValue.Count > 0 Then
                pnlNothingToValidate.Visible = False
                bslbRequestVerification.Visible = True
                lbtSubmitVerificationRequest.Visible = True
                bslbRequestVerification.Rows = e.ReturnValue.Count
            End If
        End If
    End Sub

    Protected Sub bslbRequestVerification_DataBound(sender As Object, e As EventArgs)
        Dim bslb As BootstrapListBox = TryCast(sender, BootstrapListBox)
        If Not bslb Is Nothing Then
            For Each i As BootstrapListEditItem In bslb.Items
                i.Selected = True
            Next
        End If
    End Sub

    Protected Sub dsCustomisationsCompleted_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs)
        If e.ReturnValue.Count = 0 Then
            pnlCustComp.Visible = False
        Else
            pnlCustComp.Visible = True
        End If
    End Sub

    Protected Sub bsdeDueDatePlanned_Init(sender As Object, e As EventArgs)
        Dim bsde As BootstrapDateEdit = TryCast(sender, BootstrapDateEdit)
        bsde.MinDate = DateTime.Today()
    End Sub

    Protected Sub bsdeCompletedDate_Init(sender As Object, e As EventArgs)
        Dim bsde As BootstrapDateEdit = TryCast(sender, BootstrapDateEdit)
        bsde.MaxDate = DateTime.Today()
    End Sub

    Protected Sub bsgvPlanned_Init(sender As Object, e As EventArgs)
        If Session("lmDelegateByteLimit") = 0 Then
            Dim bsgv As BootstrapGridView = TryCast(sender, BootstrapGridView)
            If Not bsgv Is Nothing Then
                bsgv.Columns("FileCount").Visible = False
                bsgv.Columns("FileCount").ShowInCustomizationForm = False
            End If

        End If
    End Sub

    Private Sub lbtRefresh_Click(sender As Object, e As EventArgs) Handles lbtRefresh.Click

    End Sub

    Private Sub lbtNextPrev_Command(sender As Object, e As CommandEventArgs) Handles lbtNext.Command, lbtPrevious.Command
        Dim nAspProgressID As Integer = e.CommandArgument
        hfAPID.Value = nAspProgressID
        LoadCompetencyAssessment()
    End Sub
    Protected Function getSFBLink(ByVal sCallUri As String) As String
        If sCallUri.Length > 0 Then
            sCallUri = My.Settings.MyURL & "sfb-session?uri=" & WebUtility.UrlEncode(sCallUri) & "&attemail=" & WebUtility.UrlEncode(Session("UserEmail"))
        End If
        Return sCallUri
    End Function
    Protected Function getSFBMeetLink(ByVal sCallUri As String) As String
        If sCallUri.Length > 0 Then
            If sCallUri.IndexOf("@") > 0 Then
                Dim sUname As String = sCallUri.Substring(4, sCallUri.IndexOf("@") - 4)
                Dim sID As String = sCallUri.Substring(sCallUri.LastIndexOf(":") + 1)
                sCallUri = "https://meet.nhs.net/" + sUname + "/" + sID
            End If
        End If
        Return sCallUri
    End Function
    Protected Sub lbtDlSFBICS_Command(sender As Object, e As CommandEventArgs)
        Dim nLogItemID As Integer = e.CommandArgument
        Dim taSched As New SuperviseDataTableAdapters.SchedulerTableAdapter
        Dim tSched As SuperviseData.SchedulerDataTable = taSched.GetDataByIDs(nLogItemID, Nothing, "")
        If tSched.Count = 1 Then
            Dim r As SuperviseData.SchedulerRow = tSched.First
            Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
            Dim sAttendees As String = taq.GetSIPsCSVForLogItem(r.UniqueID, "")
            Dim sbDesc As String = CCommon.GetSupervisionSessionDesc(r, Session("UserEmail"), sAttendees, False)
            Dim sbDescHtml As String = CCommon.GetSupervisionSessionDesc(r, Session("UserEmail"), sAttendees, True)
            Dim gICSGUID As Guid = taq.GetGUIDForLogItemID(r.UniqueID)
            Dim bAllDay As Boolean = False
            If r.StartDate.TimeOfDay.Ticks = 0 Then
                bAllDay = True
            End If
            Dim sSummary As String = "DLS Supervisor Scheduled Activity: " & r.Subject
            Dim sbCal As StringBuilder = CCommon.GetVCalendarString(r.StartDate, r.EndDate, r.OrganiserEmail, "", sSummary, sbDesc, sbDescHtml, gICSGUID.ToString(), 0, 0, 15, bAllDay, sAttendees,,, r.SeqInt)
            CCommon.SendEmail(Session("UserEmail"), sSummary, sbDescHtml.ToString(), True, , , , , , , sbCal.ToString())
        End If
    End Sub
    Protected Function getDateFormatString(ByVal sDT As String) As String
        Dim sReturn As String = ""
        If Not (sDT) = "" Then
            sReturn = IIf(DateTime.Parse(sDT).TimeOfDay.Ticks = 0, "{0:d}", "{0:dd/MM/yy HH:mm}")
        End If
        Return sReturn
    End Function
    Protected Sub bsgv_BeforeGetCallbackResult(sender As Object, e As EventArgs)
        Dim bsgv As BootstrapGridView = TryCast(sender, BootstrapGridView)
        If Not bsgv Is Nothing Then

            If bsgv.IsNewRowEditing Then
                bsgv.SettingsText.PopupEditFormCaption = "Add"
                bsgv.SettingsCommandButton.UpdateButton.Text = "Add"
                bsgv.Columns("Active").SetColVisible(False)
            Else
                bsgv.SettingsText.PopupEditFormCaption = "Edit"
                bsgv.SettingsCommandButton.UpdateButton.Text = "Update"
                bsgv.Columns("Active").SetColVisible(True)
            End If
        End If
    End Sub

    Protected Function IsAvailableToContributor(ByVal nMinRole As Integer) As Boolean
        If Session("lmContributors") = False Then
            Return True
        Else
            Dim bReturn As Boolean = False
            Select Case Session("ContributorRole")
                Case 0
                    bReturn = True
                Case 2
                    If nMinRole < 3 And nMinRole > 0 Then
                        bReturn = True
                    End If
                Case 3
                    If nMinRole > 0 Then
                        bReturn = True
                    End If
            End Select
            Return bReturn
        End If
    End Function

    Protected Sub bsgvContributors_RowInserting(sender As Object, e As Data.ASPxDataInsertingEventArgs)
        e.NewValues("Active") = True
    End Sub
    Protected Function GetCS(ByVal sSetting As String)
        Dim Settings As CourseSettings = CourseSettings.GetSettings(Session)
        If Not Settings Is Nothing Then
            Return Settings.GetValue(sSetting)
        Else
            Return "False"
        End If
    End Function

    Protected Sub bsgvSkillActions_DataBound(sender As Object, e As EventArgs)
        Dim bsgv As BootstrapGridView = TryCast(sender, BootstrapGridView)
        If Not bsgv Is Nothing Then
            bsgv.Columns("Topic").Caption = GetCS("DevelopmentLogForm.Activity")
        End If
    End Sub

    Protected Sub ddSupervisor_DataBinding(sender As Object, e As EventArgs)
        Dim li As New ListItem
        li.Value = 0
        li.Text = "Choose " & GetCS("LearnMenu.Supervisor") & "..."
        ddSupervisor.Items.Add(li)
    End Sub

    Protected Sub bsbtnSubmitRA_Command(sender As Object, e As CommandEventArgs)
        Dim taRA As New LearnMenuTableAdapters.ReflectiveAccountsTableAdapter
        If e.CommandName = "Insert" Then
            taRA.InsertQuery(Session("learnCandidateID"), Session("learnCurrentLogItemID"), tbRALearn.Text, tbRAPractice.Text, bscbPrioritisePeople.Checked, bscbPractiseEffectively.Checked, bscbPreserveSafety.Checked, bscbPromoteProfessionalism.Checked)
        ElseIf e.CommandName = "Update" Then
            taRA.UpdateQuery(tbRALearn.Text, tbRAPractice.Text, bscbPrioritisePeople.Checked, bscbPractiseEffectively.Checked, bscbPreserveSafety.Checked, bscbPromoteProfessionalism.Checked, Session("learnCandidateID"), Session("learnCurrentLogItemID"))
        End If
        mvLM.SetActiveView(vLM)
    End Sub

    Protected Sub bsbtnCancelRA_Command(sender As Object, e As CommandEventArgs)
        mvLM.SetActiveView(vLM)
    End Sub
#End Region

End Class