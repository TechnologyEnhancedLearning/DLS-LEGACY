Imports System.Net
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Public Class learnsco
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            If Session("BannerText") Is Nothing Then Session("BannerText") = ""
            litAccess.Text = CCommon.GetConfigString("AccessibilityNotice")
            'litPrivacy.Text = CCommon.GetConfigString("PrivacyNotice")
            litTOUDetail.Text = CCommon.GetConfigString("TermsAndConditions")
            If Session("learnUserAuthenticated") And Not Page.Request.Item("CustomisationID") Is Nothing Then
                If Session("lmCustomisationID") = Page.Request.Item("CustomisationID") Then
                    mvLearnMenu.SetActiveView(vLearnMenu)
                End If
            End If
        Else
            LitIntroVideo.Text = ""
        End If
        If Not Session("lmNoITSPLogo") Is Nothing Or Not Page.Request.Item("nobrand") Is Nothing Then
            logoImage.Attributes.Add("class", "pull-left")
            mainlogo.Visible = "False"
        End If
        If Session("UserForename") Is Nothing Then
            Session("lmGvSectionRow") = ""
            'Me.lblloggedinuser.Text = "please log in"
            ' Me.LitIntroVideo.Text = ""
            lbtnlogout.Visible = False
        Else
            Dim sName As String = Session("UserForename") & " " & Session("UserSurname")
            'lblloggedinuser.Text = sName
        End If
        If Not Session("lmAppColour") Is Nothing Then
            pnlMenuPanel.CssClass = Session("lmAppColour")
        End If
        Dim UserIP As String = HttpContext.Current.Request.ServerVariables("REMOTE_ADDR").ToString()
        Session("lmUserIP") = UserIP
    End Sub
#Region "Login Logout"
    Private Sub learn_Init(sender As Object, e As EventArgs) Handles Me.Init
        Session("sPanelClass") = "panel panel-default"
        Session("sFrameColour") = "#E0E0E0"
        If Context.Session IsNot Nothing Then

            If Session.IsNewSession And Page.Request.Item("ProgressKey") Is Nothing Then
                Dim szCookieHeader As String = Request.Headers("Cookie")
                If (szCookieHeader IsNot Nothing) AndAlso (szCookieHeader.IndexOf("ASP.NET_SessionId") >= 0) Then
                    Logout()
                End If
            End If
        End If
        If Session("UserCentreID") Is Nothing Then
            If Page.Request.Item("CentreID") IsNot Nothing Then
                Session("UserCentreID") = Integer.Parse(Page.Request.Item("CentreID"))
            End If
        End If
    End Sub
    Private Sub btnlogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        LoginLearner()
    End Sub
    Protected Sub LoginLearner()
        lblError.Text = String.Empty
        ' Dim CentreID As Int32 = 101
        Dim sTxtUsername As String = tbUserName.Text.Trim
        Dim sTxtPassword As String = tbPassword.Text.Trim
        If sTxtUsername.Count > 0 Then
            Dim taDelegate As New LearnMenuTableAdapters.CandidatesTableAdapter
            Dim tDelegate As New LearnMenu.CandidatesDataTable
            'If hfCentreID.Value = "" Then
            '	Logout()
            'End If
            Dim nCentID As Int32 = Session("UserCentreID")
            tDelegate = taDelegate.GetData(Session("UserCentreID"), sTxtUsername, sTxtUsername)
            If tDelegate.Count() = 1 Then
                Session("learnCandidateID") = tDelegate.First.CandidateID

                Session("UserForename") = tDelegate.First.FirstName
                Session("UserSurname") = tDelegate.First.LastName
                Session("lmApproved") = tDelegate.First.Approved
                Session("UserEmail") = tDelegate.First.EmailAddress
                If Not Page.Request.Item("CandidateNumber") Is Nothing Then
                    If Session("lmProgressKeyChecked") = Page.Request.Item("ProgressKey") Then
                        LoadLearnerProgress()
                    End If
                ElseIf Not tDelegate.First.Password = "" Then
                    Session("lmUserPassword") = tDelegate.First.Password
                    mvLearnMenu.SetActiveView(vUserPassword)
                Else
                    mvLearnMenu.SetActiveView(vSecureYourLogin)
                End If

            Else
                lblError.Text = "No active delegate record found for that delegate ID at this centre"
                pnlError.Visible = True
            End If
        End If
    End Sub
    Private Sub LearnLogin_Activate(ByVal sender As Object, ByVal e As System.EventArgs) Handles vLogin.Activate
        If My.Settings.RedirectLearnSco Then
            Dim sUrl As String = Request.Url.ToString()
            sUrl = sUrl.Replace(".aspx", "")
            sUrl = sUrl.Replace("learnsco", "learnsco.aspx")
            Dim sNewURL As String = sUrl.Replace(My.Settings.MyURL, My.Settings.LegacyURL)
            Response.Redirect(sNewURL)
        End If
        Dim nApplicationID As Int32
        Dim taApplications As New LearnMenuTableAdapters.ApplicationsTableAdapter
        Dim tApplications As LearnMenu.ApplicationsDataTable
        Dim sClass As String = "panel panel-default"
        Dim sColor As String = "#E0E0E0"
        Dim AppG As Integer
        If Session("lmCustomisationSelected") Is Nothing And Page.Request.Item("ApplicationID") IsNot Nothing Then
            Session.RemoveAll()
            nApplicationID = Integer.Parse(Page.Request.Item("ApplicationID"))
            Session("lmApplicationID") = nApplicationID
            Me.mvLearnMenu.SetActiveView(vPickCentre)
            Dim taApps As New ITSPTableAdapters.ApplicationsTableAdapter
            Dim tApp As New ITSP.ApplicationsDataTable
            tApp = taApps.GetByApplicationID(nApplicationID)
            lblCentreName.Visible = False
            If tApp.Count > 0 Then
                lblCourseTitle.Text = tApp.First.ApplicationName
            End If
            logoImage.Visible = False

            tApplications = taApplications.GetForCustomisation(nApplicationID)
            If tApplications.Count > 0 Then
                AppG = tApplications.First.AppGroupID
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
            End If
            Session("sPanelClass") = sClass
            Session("sFrameColour") = sColor
            pnlLearnframe.BackColor = System.Drawing.ColorTranslator.FromHtml(sColor)
            Session("lmAppColour") = sClass
            Session("lmBkgColour") = sColor

            pnlMenuPanel.CssClass = sClass
            Exit Sub
        ElseIf Page.Request.Item("ApplicationID") Is Nothing Then
            Dim CustomisationID As Int32
            Dim CentreID As Int32
            If Page.Request.Item("CustomisationID") IsNot Nothing Then
                CustomisationID = Integer.Parse(Page.Request.Item("CustomisationID"))
            Else
                Response.Redirect("~/errorAccess?code=1")
            End If
            If Page.Request.Item("CentreID") IsNot Nothing Then
                CentreID = Integer.Parse(Page.Request.Item("CentreID"))
            Else
                Response.Redirect("~/errorAccess?code=2")
            End If
            Session("lmUserIP") = HttpContext.Current.Request.ServerVariables("REMOTE_ADDR").ToString()
            Session("UserCentreID") = CentreID
            'hfCentreID.Value = CentreID
            'If hfCentreID.Value = "" Then
            '	Logout()
            'End If
            Session("lmCustomisationID") = CustomisationID
        End If
        Dim taq1 As New ITSPTableAdapters.QueriesTableAdapter
        Dim bImg As System.Byte() = taq1.GetLogoForCustomisationID(Session("lmCustomisationID"))
        If Not bImg Is Nothing Then
            bimgLogo.Value = bImg
        Else
            bimgLogo.Visible = False
        End If
        'hfCustomisationID.Value = CustomisationID

        tApplications = taApplications.GetForCustomisation(Session("lmCustomisationID"))
        If tApplications.Count > 0 Then
            AppG = tApplications.First.AppGroupID
            Select Case AppG

                Case 1
                    sClass = "panel panel-itsp-purple"
                    sColor = "#3B1979"
                Case 2
                    sClass = "panel panel-itsp-pink"
                    sColor = "#B5006A"
                Case 3
                    sClass = "panel panel-itsp-blue"
                    sColor = "#11AF52"
                Case 4
                    sClass = "panel panel-itsp-green"
                    sColor = "#009DCA"
            End Select
        End If
        Session("sPanelClass") = sClass
        Session("sFrameColour") = sColor
        pnlLearnframe.BackColor = System.Drawing.ColorTranslator.FromHtml(sColor)
        Session("lmAppColour") = sClass
        Session("lmBkgColour") = sColor

        pnlMenuPanel.CssClass = sClass
        Session("lmCustPassword") = ""
        doLogoSize()
        'Get Application info table
        Dim taCustHeader As New LearnMenuTableAdapters.CustHeaderTableAdapter
        Dim tCustHeader As LearnMenu.CustHeaderDataTable
        tCustHeader = taCustHeader.GetData(Session("UserCentreID"), Session("lmCustomisationID"))
        If tCustHeader.Count > 0 Then

            lbtDiagVid.Visible = tCustHeader.First.DiagOn
            lbtLearnVid.Visible = tCustHeader.First.LearningOn
            lbtPLAssess.Visible = tCustHeader.First.IsAssessed
            Session("lmCustVersion") = tCustHeader.First.CurrentVersion
            lblCourseTitle.Text = tCustHeader.First.CentreName
            lblCentreName.Text = tCustHeader.First.ApplicationName & " - " & tCustHeader.First.CustomisationName & " (Average course length: " & tCustHeader.First.LearnMins & ")"
            lbtRegister.Visible = tCustHeader.First.SelfRegister
            Session("lmThreshold") = tCustHeader.First.TutCompletionThreshold
            Session("lmCustIsAssessed") = tCustHeader.First.IsAssessed
            Session("lmCustDiagObjSelect") = tCustHeader.First.DiagObjSelect
            Session("lmPlaPassThreshold") = tCustHeader.First.PLAPassThreshold
            Dim sMovieW As Integer = tCustHeader.First.hEmbedRes + 10
            Dim sMovieH As Integer = tCustHeader.First.vEmbedRes + 10
            'frame1.Attributes("width") = sMovieW
            'frame1.Attributes("height") = sMovieH
            'pnlLearnframe.Width = sMovieW
            'pnlLearnframe.Height = sMovieH
            If Not Page.Request.Item("CandidateNumber") Is Nothing Then
                lbtnlogout.Text = "Close"
                lbtnlogout.ToolTip = "Return to Learner Portal"
                If Session("lmProgressKeyChecked") Is Nothing Or Not Session("lmProgressKeyChecked") = Page.Request.Item("ProgressKey") Then
                    If Page.Request.Item("ProgressKey") = "Enroll" Then
                        Session("lmProgressKeyChecked") = "Enroll"
                    Else
                        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
                        Dim nProgressID As Integer = taq.GetProgressIDFromCustCandNum(Session("lmCustomisationID"), Page.Request.Item("CandidateNumber"))
                        Dim idLPGUID As Guid = New Guid(Page.Request.Item("ProgressKey"))
                        If taq.CheckProgressKeyExistsAndRemove(idLPGUID, nProgressID) = 0 Then
                            Response.Redirect("~/errorAccess?code=4")
                        Else
                            Session("lmProgressKeyChecked") = idLPGUID.ToString
                        End If
                    End If

                End If

                tbUserName.Text = Page.Request.Item("CandidateNumber")
            End If
            If tCustHeader.First.Password.Length > 0 Then
                Session("lmCustPassword") = tCustHeader.First.Password
                pwdDiv.Visible = True
                Dim cvPassword As New CompareValidator()
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
                pwdDiv.Controls.Add(cvPassword)
                AddRequiredFieldValidator("tbPassword", pwdDiv, "", "Login")
            Else
                If Not Page.Request.Item("CandidateNumber") Is Nothing Then

                    LoginLearner()
                End If
                pwdDiv.Visible = False
            End If
        Else
            Response.Redirect("~/errorAccess?code=3")
        End If
    End Sub
    Protected Sub doLogoSize()
        Dim taCentre As New ITSPTableAdapters.CentresTableAdapter
        Dim tCtre As New ITSP.CentresDataTable
        tCtre = taCentre.GetByCentreID(CInt(Session("UserCentreID")))
        If tCtre.First.Active = False Then
            Response.Redirect("~/CentreInactive")
        End If
        Session("BannerText") = tCtre.First.BannerText
        Dim nHeight As Integer = tCtre.First.LogoHeight
        If nHeight = 0 Then
            Me.logoImage.Visible = False
        Else
            Dim nWidth As Integer = tCtre.First.LogoWidth
            Dim nNewWidth As Integer = nWidth
            Dim nNewHeight As Integer = nHeight
            If nNewHeight > 100 Then
                nNewWidth = CInt((CSng(100) / CSng(nHeight)) * CSng(nWidth))
                nNewHeight = 100
            End If
            If nNewWidth > 360 Then
                nNewHeight = CInt((CSng(360) / CSng(nNewWidth)) * CSng(nNewHeight))
                nNewWidth = 360
            End If

            Me.logoImage.Height = nNewHeight
            Me.logoImage.Width = nNewWidth
            Me.logoImage.Visible = True
        End If
    End Sub
    Private Sub lbtnlogout_Click(sender As Object, e As EventArgs) Handles lbtnlogout.Click
        Logout()
    End Sub
    Public Sub Logout()
        If Not Session("lmProgressKeyChecked") Is Nothing Then
            Dim nCentreID As Integer = CInt(Session("UserCentreID"))
            Session.RemoveAll()
            Response.Redirect("https://www.dls.nhs.uk/learnerportal/Current?CentreID=" & nCentreID.ToString())
        Else
            Session.RemoveAll()

            'Me.lblloggedinuser.Text = "please log in"
            lbtnlogout.Visible = False
            Me.tbUserName.Text = ""
            Me.tbPassword.Text = ""
            Me.mvLearnMenu.SetActiveView(Me.vLogin)
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
    Private Sub btnLoginReturn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLoginReturn.Click
        Me.mvLearnMenu.SetActiveView(Me.vLogin)
    End Sub
    Public Function AddRequiredFieldValidator(ByVal pControlToValidate, ByVal pControlToAddTo, ByVal pInitialValue, ByVal sValidationGroup)
        Dim rfv As New RequiredFieldValidator()
        rfv.ErrorMessage = "Required"
        rfv.Display = ValidatorDisplay.Dynamic
        rfv.Text = "*"
        If pInitialValue.Length > 0 Then
            rfv.InitialValue = pInitialValue
        End If
        rfv.ControlToValidate = pControlToValidate
        rfv.EnableClientScript = True
        rfv.ValidationGroup = sValidationGroup.ToString()
        rfv.Enabled = True
        rfv.EnableViewState = True
        rfv.ToolTip = rfv.ErrorMessage
        rfv.Visible = True
        rfv.ID = "rfv" + pControlToValidate
        rfv.SetFocusOnError = True
        pControlToAddTo.Controls.Add(rfv)
        Return True
    End Function
#End Region
#Region "Registration"
    Protected Sub lbtregister_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lbtRegister.Click
        Me.mvLearnMenu.SetActiveView(Me.vLearnerReg)
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
                sClass = "panel panel-ten"
            Case 11 To 20
                sClass = "panel panel-twenty"
            Case 21 To 30
                sClass = "panel panel-thirty"
            Case 31 To 40
                sClass = "panel panel-forty"
            Case 41 To 50
                sClass = "panel panel-fifty"
            Case 51 To 60
                sClass = "panel panel-sixty"
            Case 61 To 70
                sClass = "panel panel-seventy"
            Case 71 To 80
                sClass = "panel panel-eighty"
            Case 81 To 90
                sClass = "panel panel-ninety"
            Case Is > 90
                sClass = "panel panel-hundred"
        End Select

        Return sClass
    End Function



    Protected Sub rptTutorials_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If Session("lmCustomisationID") Is Nothing Then
            Logout()
        End If
        Dim hfSecID As HiddenField = source.parent.parent.parent.Findcontrol("hfSectionID")
        'If Not hfSecID Is Nothing Then
        '    Session("lmGvSectionRow") = hfSecID.Value
        'End If
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
                    frame1.Attributes("src") = tutpath & "?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&Version=" & Session("lmCustVersion") & "&ProgressID=" & Session("lmProgressID") & "&type=learn" & "&TrackURL=" & sTrackerURL
                ElseIf tutpath.Contains("imsmanifest.xml") Then
                    frame1.Attributes("src") = "../scoplayer/sco?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&Version=" & Session("lmCustVersion") & "&tutpath=" & tutpath
                ElseIf tutpath.Contains(".dcr") Then
                    frame1.Attributes("src") = "eitslm?CentreID=" & Session("UserCentreID") & "&CustomisationID=" & Session("lmCustomisationID") & "&CandidateID=" & Session("learnCandidateID") & "&Version=" & Session("lmCustVersion") & "&tutpath=" & tutpath
                Else
                    frame1.Attributes("src") = tutpath
                End If
                mvOuter.SetActiveView(vLearningContent)
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "setlearnheight", "sizeLearnPanel();", True)
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
                    'If Not Page.ClientScript.IsClientScriptBlockRegistered(Page.[GetType](), "ShowSupportPopup") Then
                    '  'notice that I added the boolean value as the last parameter
                    '  ClientScript.RegisterClientScriptBlock(Page.[GetType](), "ShowSupportPopup", sb.ToString(), True)
                    'End If
            Case "cmdConsolidation"
        End Select
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
                        Page.ClientScript.RegisterStartupScript(Me.GetType(), "setlearnheight", "sizeLearnPanel();", True)
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
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "setlearnheight", "sizeLearnPanel();", True)
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
    Private Sub btnSetPassword_Click(sender As Object, e As EventArgs) Handles btnSetPassword.Click
        Dim taCandidates As New LearnMenuTableAdapters.CandidatesTableAdapter
        taCandidates.SetPassword(Crypto.HashPassword(tbSetPassword1.Text.Trim), Session("learnCandidateID"))
        Session("learnUserAuthenticated") = True
        lbtnlogout.Visible = True
        Dim sName As String = Session("UserForename") & " " & Session("UserSurname")
        'lblloggedinuser.Text = sName
        If Not Session("lmApproved") Then
            Me.mvLearnMenu.SetActiveView(Me.vNotApproved)
        ElseIf Session("UserEmail").ToString.Length < 1 Then
            Me.mvLearnMenu.SetActiveView(Me.vUpdateDetails)
        Else
            Dim nProgID As Int32 = getProgressID()
            If nProgID > 0 Then
                Session("lmProgressID") = nProgID
                'hfProgressID.Value = nProgID
                'If hfProgressID.Value = "" Then
                '	Logout()
                'End If
                StartSession()
                Me.mvLearnMenu.SetActiveView(Me.vLearnMenu)
            Else
                Dim taProgress As New LearnMenuTableAdapters.uspCreateProgressRecordTableAdapter
                Dim tProgress As New LearnMenu.uspCreateProgressRecordDataTable
                tProgress = taProgress.CreateProgress(Session("learnCandidateID"), Session("lmCustomisationID"), Session("UserCentreID"), 1, 0)
                If tProgress.Count > 0 Then
                    nProgID = getProgressID()
                    If nProgID > 0 Then
                        Session("lmProgressID") = nProgID
                        'hfProgressID.Value = nProgID
                        'If hfProgressID.Value = "" Then
                        '	Logout()
                        'End If
                        StartSession()
                        Me.mvLearnMenu.SetActiveView(Me.vLearnMenu)
                    End If
                End If
            End If
        End If
    End Sub
    Private Sub btnSubmitPWord_Click(sender As Object, e As EventArgs) Handles btnSubmitPWord.Click
        If Crypto.VerifyHashedPassword(Session("lmUserPassword"), tbUserPassword.Text.Trim) Then
            Dim regex As Regex = New Regex("(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*")
            Dim match As Match = regex.Match(tbUserPassword.Text.Trim)
            If match.Success Then
                LoadLearnerProgress()
            Else
                lblSetPWTitle.Text = "Choose a Safer Password"
                lblSetPWText.Text = "Your password no longer meets the minimum security requirements. Please choose a new, stronger one."
                mvLearnMenu.SetActiveView(vSecureYourLogin)
            End If
        Else
            lblErrorPW.Text = "Incorrect password. Please try again or use the Reset link to reset your password."
            pnlErrorPW.Visible = True
        End If
    End Sub
    Protected Sub LoadLearnerProgress()
        lbtnlogout.Visible = True
        Dim sName As String = Session("UserForename") & " " & Session("UserSurname")
        'lblloggedinuser.Text = sName
        If Not Session("lmApproved") Then
            Me.mvLearnMenu.SetActiveView(Me.vNotApproved)
        ElseIf Session("UserEmail").ToString.Length < 1 Then
            Me.mvLearnMenu.SetActiveView(Me.vUpdateDetails)
        Else
            LoadOrCreateProgress()
        End If
    End Sub
    Protected Sub LoadOrCreateProgress()
        Session("learnUserAuthenticated") = True
        Dim nProgID As Int32 = getProgressID()
        If nProgID > 0 Then
            Session("lmProgressID") = nProgID
            StartSession()
            Me.mvLearnMenu.SetActiveView(Me.vLearnMenu)
        Else
            Dim taProgress As New LearnMenuTableAdapters.uspCreateProgressRecordTableAdapter
            Dim tProgress As New LearnMenu.uspCreateProgressRecordDataTable
            tProgress = taProgress.CreateProgress(Session("learnCandidateID"), Session("lmCustomisationID"), Session("UserCentreID"), 1, 0)
            If tProgress.Count > 0 Then
                nProgID = getProgressID()
                If nProgID > 0 Then
                    Session("lmProgressID") = nProgID
                    StartSession()
                    Me.mvLearnMenu.SetActiveView(Me.vLearnMenu)
                End If
            End If
        End If
    End Sub
    Private Sub lbtResetPW_Click(sender As Object, e As EventArgs) Handles lbtResetPW.Click
        Dim sResetHash As String = (Guid.NewGuid()).ToString()
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        taq.SetPWResetHash(sResetHash, Session("learnCandidateID"))
        'Setup and send a reset e-mail here:
        Dim taCand As New LearnMenuTableAdapters.CandidatesTableAdapter
        Dim tCand As New LearnMenu.CandidatesDataTable
        tCand = taCand.GetByCandidateID(Session("learnCandidateID"))
        Dim sbBody As New StringBuilder
        Dim sPageName As String = My.Settings.MyURL
        sPageName = sPageName & "reset" & "?pwdr=" & sResetHash & "&email=" & tCand.First.EmailAddress
        sbBody.Append("Dear " & tCand.First.FirstName & "," & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("A request has been made to reset the password for your account for " & vbCrLf)
        sbBody.Append("the Digital Learning Solutions website." & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("To reset your password please follow this link: " & sPageName & vbCrLf)
        sbBody.Append("Note that this link can only be used once." & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("Please don't reply to this email as it has been automatically generated." & vbCrLf)
        If CCommon.SendEmail(tCand.First.EmailAddress, "Digital Learning Solutions Tracking System Password Reset", sbBody.ToString(), False) Then
            lblModalBody.Text = "A password has been sent to the e-mail address you registered with containing a link to reset your password. Following the link will remove the password associated with your login, allowing you to set a new one."
            lblModalTitle.Text = "Password Reset E-mail Sent"
        Else
            lblModalBody.Text = "There was a problem sending you an email. Please contact the site administrators at it.skill@nhs.net to ask about your password reset."
            lblModalTitle.Text = "Password Reset E-mail Error"
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#messageModal').modal('show');</script>")
    End Sub
    Protected Function GetNiceDate(ByVal d As DateTime)
        Dim s As String = CCommon.GetPrettyDate(d)
        Return s
    End Function
    Private Sub vLearnerReg_Activate(sender As Object, e As EventArgs) Handles vLearnerReg.Activate
        Dim taCentre As New LearnMenuTableAdapters.CentresTableAdapter()
        Dim tCentre As New LearnMenu.CentresDataTable
        tCentre = taCentre.GetData(CInt(Session("UserCentreID")))
        If tCentre.Count > 0 Then
            Session("lmNotifyEmail") = tCentre.First.NotifyEmail
            Dim lblField1 As String = tCentre.First.F1Name
            If lblField1.Length > 0 Then
                lblCustField1.Text = lblField1 + ":"

                Dim ddChoicesFld1 As String = tCentre.First.F1Options
                If ddChoicesFld1.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld1, ddField1)
                    ddField1.Visible = True
                    tbField1.Visible = False
                Else
                    tbField1.Visible = True
                    ddField1.Visible = False
                End If
                If tCentre.First.F1Mandatory Then
                    If ddChoicesFld1.Length > 0 Then
                        AddRequiredFieldValidator("ddField1", trCustField1, "0", "Register")
                    Else
                        AddRequiredFieldValidator("tbField1", trCustField1, "", "Register")
                    End If
                End If
            Else
                trCustField1.Visible = False
            End If
            Dim lblField2 As String = tCentre.First.F2Name
            If lblField2.Length > 0 Then
                lblCustField2.Text = lblField2 + ":"

                Dim ddChoicesFld2 As String = tCentre.First.F2Options
                If ddChoicesFld2.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld2, ddField2)
                    tbField2.Visible = False
                Else
                    ddField2.Visible = False
                End If
                If tCentre.First.F2Mandatory Then
                    If ddChoicesFld2.Length > 0 Then
                        AddRequiredFieldValidator("ddField2", trCustField2, "0", "Register")
                    Else
                        AddRequiredFieldValidator("tbField2", trCustField2, "", "Register")
                    End If
                End If
            Else
                trCustField2.Visible = False
            End If
            Dim lblField3 As String = tCentre.First.F3Name
            If lblField3.Length > 0 Then
                lblCustField3.Text = lblField3 + ":"

                Dim ddChoicesFld3 As String = tCentre.First.F3Options
                If ddChoicesFld3.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld3, ddField3)
                    tbField3.Visible = False
                Else
                    ddField3.Visible = False
                End If
                If tCentre.First.F3Mandatory Then
                    If ddChoicesFld3.Length > 0 Then
                        AddRequiredFieldValidator("ddField3", trCustField3, "0", "Register")
                    Else
                        AddRequiredFieldValidator("tbField3", trCustField3, "", "Register")
                    End If
                End If
            Else
                trCustField3.Visible = False
            End If
            Dim lblField4 As String = tCentre.First.F4Name
            If lblField4.Length > 0 Then
                lblCustField4.Text = lblField4 + ":"

                Dim ddChoicesFld4 As String = tCentre.First.F4Options
                If ddChoicesFld4.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld4, ddField4)
                    tbField4.Visible = False
                Else
                    ddField4.Visible = False
                End If
                If tCentre.First.F4Mandatory Then
                    If ddChoicesFld4.Length > 0 Then
                        AddRequiredFieldValidator("ddField4", trCustField4, "0", "Register")
                    Else
                        AddRequiredFieldValidator("tbField4", trCustField4, "", "Register")
                    End If
                End If
            Else
                trCustField4.Visible = False
            End If
            Dim lblField5 As String = tCentre.First.F5Name
            If lblField5.Length > 0 Then
                lblCustField5.Text = lblField5 + ":"

                Dim ddChoicesFld5 As String = tCentre.First.F5Options
                If ddChoicesFld5.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld5, ddField5)
                    tbField5.Visible = False
                Else
                    ddField5.Visible = False
                End If
                If tCentre.First.F5Mandatory Then
                    If ddChoicesFld5.Length > 0 Then
                        AddRequiredFieldValidator("ddField5", trCustField5, "0", "Register")
                    Else
                        AddRequiredFieldValidator("tbField5", trCustField5, "", "Register")
                    End If
                End If
            Else
                trCustField5.Visible = False
            End If
            Dim lblField6 As String = tCentre.First.F6Name
            If lblField6.Length > 0 Then
                lblCustField6.Text = lblField6 + ":"

                Dim ddChoicesFld6 As String = tCentre.First.F6Options
                If ddChoicesFld6.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld6, ddField6)
                    tbField6.Visible = False
                Else
                    ddField6.Visible = False
                End If
                If tCentre.First.F6Mandatory Then
                    If ddChoicesFld6.Length > 0 Then
                        AddRequiredFieldValidator("ddField6", trCustField6, "0", "Register")
                    Else
                        AddRequiredFieldValidator("tbField6", trCustField6, "", "Register")
                    End If
                End If
            Else
                trCustField6.Visible = False
            End If
        End If
        Session("learnRegApprove") = True
        pnlIPAlert.Visible = False

    End Sub

    Private Sub btnRegister_Click(sender As Object, e As EventArgs) Handles btnRegister.Click
        If Page.IsValid Then
            Dim strAnswer1 As String = ""
            Dim strAnswer2 As String = ""
            Dim strAnswer3 As String = ""
            Dim strAnswer4 As String = ""
            Dim strAnswer5 As String = ""
            Dim strAnswer6 As String = ""
            If tbField1.Visible Then
                strAnswer1 = tbField1.Text
            ElseIf ddField1.Visible Then
                strAnswer1 = ddField1.SelectedValue
            End If
            If tbField2.Visible Then
                strAnswer2 = tbField2.Text
            ElseIf ddField2.Visible Then
                strAnswer2 = ddField2.SelectedValue
            End If
            If tbField3.Visible Then
                strAnswer3 = tbField3.Text
            ElseIf ddField3.Visible Then
                strAnswer3 = ddField3.SelectedValue
            End If
            If tbField4.Visible Then
                strAnswer4 = tbField4.Text
            ElseIf ddField4.Visible Then
                strAnswer4 = ddField4.SelectedValue
            End If
            If tbField5.Visible Then
                strAnswer5 = tbField5.Text
            ElseIf ddField5.Visible Then
                strAnswer5 = ddField5.SelectedValue
            End If
            If tbField6.Visible Then
                strAnswer6 = tbField6.Text
            ElseIf ddField6.Visible Then
                strAnswer6 = ddField6.SelectedValue
            End If
            Dim bApproved As Boolean = CBool(Session("learnRegApprove"))
            Dim bExternal As Boolean = True
            If bApproved Or Page.Request.Item("ApplicationID") IsNot Nothing Then
                bExternal = False
            End If
            Dim sCandidateNumber As String = ""
            Try
                sCandidateNumber = CCommon.SaveNewCandidate(Session("UserCentreID"), tbFName.Text, tbLName.Text, ddJobGroup.SelectedValue, True, strAnswer1, strAnswer2, strAnswer3, strAnswer4, strAnswer5, strAnswer6, "", Session("learnRegApprove"), tbEmail.Text, bExternal, True, DateTime.Today())
            Catch ex As CCommon.CandidateException
                lblRegistrationError.Text = ex.Message
                pnlRegistrationError.Visible = True
                Exit Sub
            End Try
            If Session("learnRegApprove") = False And Not sCandidateNumber = "-4" Then
                Dim service As New ts.services.services
                service.SendDelegateRegRequiresApprovalNotification(tbFName.Text, tbLName.Text, Session("UserCentreID"))
                divRegNotApproved.Visible = True
                divRegApproved.Visible = False
            Else
                divRegNotApproved.Visible = False
                divRegApproved.Visible = True
            End If
            Dim taDelegate As New LearnMenuTableAdapters.CandidatesTableAdapter
            Dim tDelegate As New LearnMenu.CandidatesDataTable
            If sCandidateNumber = "-4" Then
                Me.mvLearnMenu.SetActiveView(Me.vDuplicateEmail)
            Else
                tDelegate = taDelegate.GetData(Session("UserCentreID"), sCandidateNumber, sCandidateNumber)

                If tDelegate.Count() = 1 Then
                    Session("learnCandidateID") = tDelegate.First.CandidateID
                    'hfCandidateID.Value = Session("CandidateID")
                    'If hfCandidateID.Value = "" Then
                    '	Logout()
                    'End If
                    'lblloggedinuser.Text = tDelegate.First.FirstName + " " + tDelegate.First.LastName
                End If

                lblCandidateNumber.Text = sCandidateNumber
                Me.mvLearnMenu.SetActiveView(Me.vShowDelegateID)
            End If

        End If
    End Sub
    Private Sub btnReturn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReturn.Click, btnLoginPostReg.Click
        Logout()
    End Sub

    Private Sub btnSendReminder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendReminder.Click
        Dim toAdd As String = tbEmail_u.Text
        If toAdd = "" Then
            toAdd = tbEmail.Text
        End If
        DoReminder(toAdd)
        Logout()
    End Sub
    Public Sub DoReminder(ByVal EmailField As String)
        Dim taCand As New LearnMenuTableAdapters.CandidatesTableAdapter
        Dim tCand As New LearnMenu.CandidatesDataTable
        tCand = taCand.GetByEmail(Session("UserCentreID"), EmailField)
        If tCand.Count > 0 Then
            Dim sbBody As New StringBuilder
            sbBody.Append("Dear " & tCand.First.FirstName & "," & vbCrLf)
            sbBody.Append(vbCrLf)
            sbBody.Append("A request has been made for a reminder of your delegate ID / password for Digital Learning Solutions learning materials. " & vbCrLf)
            sbBody.Append("Your delegate ID is: " & tCand.First.CandidateNumber & vbCrLf)
            If tCand.First.AliasID <> "" Then
                sbBody.Append("You may also login with your alias ID: " & tCand.First.AliasID & vbCrLf)
            End If
            sbBody.Append("If the course that you were trying to access requires a password and you need a reminder of it, please refer to your original course joining details or contact your Digital Learning Solutions centre.")
            If CCommon.SendEmail(tCand.First.EmailAddress, "Digital Learning Solutions Reminder", sbBody.ToString(), False) Then
                pnlReminderOutcome.CssClass = "alert alert-success"
                Me.lblReminderOutcome.Text = "An email has been sent to you with a reminder of your delegate ID."
            Else
                pnlReminderOutcome.CssClass = "alert alert-danger"
                Me.lblReminderOutcome.Text = "There was a problem sending your reminder e-mail."
            End If
        Else
            pnlReminderOutcome.CssClass = "alert alert-danger"
            Me.lblReminderOutcome.Text = "No active delegate ID was found matching the above e-mail address."
        End If
    End Sub


    Private Sub rptLMSections_DataBinding(sender As Object, e As EventArgs) Handles rptLMSections.DataBinding
        Dim nPID As Integer = Session("lmProgressID")
        Dim taQ As New LearnMenuTableAdapters.QueriesTableAdapter
        If taQ.CheckIfComplete(nPID) = 0 Then
            Dim nCompStatus As Int32 = 2
            nCompStatus = taQ.GetAndReturnCompletionStatusByProgID(nPID)
            If nCompStatus > 0 Then

                Dim taDelegate As New LearnMenuTableAdapters.CandidatesTableAdapter
                Dim tDelegate As New LearnMenu.CandidatesDataTable
                tDelegate = taDelegate.GetByCentreCandidateID(Session("UserCentreID"), Session("learnCandidateID"))
                Dim sCC As String = taQ.GetAdminCCEmail(nPID)
                taQ.MarkProgComplete(nPID)
                'get the course name (I know, silly label name but let's go with it):
                Dim sCourse As String = lblCentreName.Text
                'Now, let's get rid of the average time info if it's present:
                If sCourse.EndsWith(")") Then
                    sCourse = sCourse.Substring(0, sCourse.LastIndexOf("("))
                End If
                Dim sURL As String = My.Settings.ITSPTrackingURL & "finalise" &
                   "?SessionID=" & Session("lmSessionID") &
                   "&ProgressID=" & Session("lmProgressID") & "&UserCentreID=" & Session("UserCentreID").ToString
                Dim sbBody As New StringBuilder
                sbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")
                sbBody.Append("<p>Dear " & tDelegate.First.FirstName & ",</p>")
                sbBody.Append("<p>You have completed the Digital Learning Solutions learning course - " & sCourse & "</p>")
                If nCompStatus = 2 Then
                    sbBody.Append("<p>To evaluate the course and access your certificate of completion, click <a href=""" & sURL & """>here</a>.</p>")
                Else
                    sbBody.Append("<p>If you haven't already done so, please evaluate the course to help us to improve provision for future learners by clicking <a href=""" & sURL & """>here</a>. Only one evaluation can be submitted per completion.</p>")
                End If
                If sCC.Length > 2 Then
                    sbBody.Append("<p><b>Note:</b> This message has been copied to the administrator who enrolled you on this course for their information.</p>")
                End If
                sbBody.Append("</body>")
                CCommon.SendEmail(tDelegate.First.EmailAddress, "Digital Learning Solutions Course Complete", sbBody.ToString(), True,, sCC,, 11, Session("learnCandidateID"))
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "markcomplete", "<script>mm_adlUpdate('completed');</script>")
            Else
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "markcomplete", "<script>mm_adlUpdate('incomplete');</script>")
            End If
        Else
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "markcomplete", "<script>mm_adlUpdate('completed');</script>")
        End If
    End Sub

    Private Sub vUpdateDetails_Activate(sender As Object, e As EventArgs) Handles vUpdateDetails.Activate
        Dim taCentre As New LearnMenuTableAdapters.CentresTableAdapter
        Dim tCentre As New LearnMenu.CentresDataTable
        tCentre = taCentre.GetData(Session("UserCentreID"))
        Dim taCandidate As New LearnMenuTableAdapters.CandidatesTableAdapter
        Dim tCandidate As New LearnMenu.CandidatesDataTable
        tCandidate = taCandidate.GetByCentreCandidateID(Session("UserCentreID"), Session("learnCandidateID"))
        If tCentre.Count > 0 And tCandidate.Count > 0 Then
            hfActive.Value = tCandidate.First.Active
            hfApproved.Value = tCandidate.First.Approved
            hfAlias.Value = tCandidate.First.AliasID
            tbFName_u.Text = tCandidate.First.FirstName
            tbLName_u.Text = tCandidate.First.LastName
            tbEmail_u.Text = tCandidate.First.EmailAddress
            ddJobGroup_u.DataBind()
            ddJobGroup_u.SelectedValue = tCandidate.First.JobGroupID
            Dim lblField1 As String = tCentre.First.F1Name
            If lblField1.Length > 0 Then
                lblField1_u.Text = lblField1 + ":"

                Dim ddChoicesFld1 As String = tCentre.First.F1Options
                If ddChoicesFld1.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld1, ddField1_u)
                    ddField1_u.Visible = True
                    tbField1_u.Visible = False
                    Try
                        ddField1_u.SelectedValue = tCandidate.First.Answer1
                    Catch
                        ddField1_u.SelectedIndex = 0
                    End Try


                Else
                    tbField1_u.Visible = True
                    ddField1_u.Visible = False
                    tbField1_u.Text = tCandidate.First.Answer1
                End If
                If tCentre.First.F3Mandatory Then
                    If ddChoicesFld1.Length > 0 Then
                        AddRequiredFieldValidator("ddField1_u", pnlField1_u, "0")
                    Else
                        AddRequiredFieldValidator("tbField1_u", pnlField1_u, "")
                    End If
                End If
            Else
                pnlField1_u.Visible = False
            End If
            Dim lblField2 As String = tCentre.First.F2Name
            If lblField2.Length > 0 Then
                lblField2_u.Text = lblField2 + ":"

                Dim ddChoicesFld2 As String = tCentre.First.F2Options
                If ddChoicesFld2.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld2, ddField2_u)
                    tbField2_u.Visible = False
                    Try
                        ddField2_u.SelectedValue = tCandidate.First.Answer2
                    Catch
                        ddField2_u.SelectedIndex = 0
                    End Try
                Else
                    ddField2_u.Visible = False
                    tbField2_u.Text = tCandidate.First.Answer2
                End If
                If tCentre.First.F3Mandatory Then
                    If ddChoicesFld2.Length > 0 Then
                        AddRequiredFieldValidator("ddField2_u", pnlField2_u, "0")
                    Else
                        AddRequiredFieldValidator("tbField2_u", pnlField2_u, "")
                    End If
                End If
            Else
                pnlField2_u.Visible = False
            End If
            Dim lblField3 As String = tCentre.First.F3Name
            If lblField3.Length > 0 Then
                lblField3_u.Text = lblField3 + ":"

                Dim ddChoicesFld3 As String = tCentre.First.F3Options
                If ddChoicesFld3.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld3, ddField3_u)
                    tbField3_u.Visible = False
                    Try
                        ddField3_u.SelectedValue = tCandidate.First.Answer3
                    Catch
                        ddField3_u.SelectedIndex = 0
                    End Try
                Else
                    ddField3_u.Visible = False
                    tbField3_u.Text = tCandidate.First.Answer3
                End If
                If tCentre.First.F3Mandatory Then
                    If ddChoicesFld3.Length > 0 Then
                        AddRequiredFieldValidator("ddField3_u", pnlField3_u, "0")
                    Else
                        AddRequiredFieldValidator("tbField3_u", pnlField3_u, "")
                    End If
                End If
            Else
                pnlField3_u.Visible = False
            End If
            Dim lblField4 As String = tCentre.First.F4Name
            If lblField4.Length > 0 Then
                lblField4_u.Text = lblField4 + ":"

                Dim ddChoicesFld4 As String = tCentre.First.F4Options
                If ddChoicesFld4.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld4, ddField4_u)
                    tbField4_u.Visible = False
                    Try
                        ddField4_u.SelectedValue = tCandidate.First.Answer4
                    Catch
                        ddField4_u.SelectedIndex = 0
                    End Try
                Else
                    ddField4_u.Visible = False
                    tbField4_u.Text = tCandidate.First.Answer4
                End If
                If tCentre.First.F4Mandatory Then
                    If ddChoicesFld4.Length > 0 Then
                        AddRequiredFieldValidator("ddField4_u", pnlField4_u, "0")
                    Else
                        AddRequiredFieldValidator("tbField4_u", pnlField4_u, "")
                    End If
                End If
            Else
                pnlField4_u.Visible = False
            End If
            Dim lblField5 As String = tCentre.First.F5Name
            If lblField5.Length > 0 Then
                lblField5_u.Text = lblField5 + ":"

                Dim ddChoicesFld5 As String = tCentre.First.F5Options
                If ddChoicesFld5.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld5, ddField5_u)
                    tbField5_u.Visible = False
                    Try
                        ddField5_u.SelectedValue = tCandidate.First.Answer5
                    Catch
                        ddField5_u.SelectedIndex = 0
                    End Try
                Else
                    ddField5_u.Visible = False
                    tbField5_u.Text = tCandidate.First.Answer5
                End If
                If tCentre.First.F5Mandatory Then
                    If ddChoicesFld5.Length > 0 Then
                        AddRequiredFieldValidator("ddField5_u", pnlField5_u, "0")
                    Else
                        AddRequiredFieldValidator("tbField5_u", pnlField5_u, "")
                    End If
                End If
            Else
                pnlField5_u.Visible = False
            End If
            Dim lblField6 As String = tCentre.First.F6Name
            If lblField6.Length > 0 Then
                lblField6_u.Text = lblField6 + ":"

                Dim ddChoicesFld6 As String = tCentre.First.F6Options
                If ddChoicesFld6.Length > 0 Then
                    CCommon.PopDDListFromReturnSeparatedString(ddChoicesFld6, ddField6_u)
                    tbField6_u.Visible = False
                    Try
                        ddField6_u.SelectedValue = tCandidate.First.Answer6
                    Catch
                        ddField6_u.SelectedIndex = 0
                    End Try
                Else
                    ddField6_u.Visible = False
                    tbField6_u.Text = tCandidate.First.Answer6
                End If
                If tCentre.First.F6Mandatory Then
                    If ddChoicesFld6.Length > 0 Then
                        AddRequiredFieldValidator("ddField6_u", pnlField6_u, "0")
                    Else
                        AddRequiredFieldValidator("tbField6_u", pnlField6_u, "")
                    End If
                End If
            Else
                pnlField6_u.Visible = False
            End If
        End If
    End Sub
    Public Function AddRequiredFieldValidator(ByVal pControlToValidate, ByVal pControlToAddTo, ByVal pInitialValue)
        Dim rfv As New RequiredFieldValidator()
        rfv.ErrorMessage = "Required"
        rfv.Display = ValidatorDisplay.Dynamic
        rfv.Text = "*"
        If pInitialValue.Length > 0 Then
            rfv.InitialValue = pInitialValue
        End If
        rfv.ControlToValidate = pControlToValidate
        rfv.EnableClientScript = True
        rfv.Enabled = True
        rfv.EnableViewState = True
        rfv.ToolTip = rfv.ErrorMessage
        rfv.Visible = True
        rfv.ID = "rfv" + pControlToValidate
        rfv.SetFocusOnError = True
        pControlToAddTo.Controls.Add(rfv)
        Return True
    End Function

    Private Sub btnUpdateDetails_Click(sender As Object, e As EventArgs) Handles btnUpdateDetails.Click
        Dim taCandidate As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim strAnswer1 As String = ""
        Dim strAnswer2 As String = ""
        Dim strAnswer3 As String = ""
        Dim strAnswer4 As String = ""
        Dim strAnswer5 As String = ""
        Dim strAnswer6 As String = ""
        If tbField1_u.Visible Then
            strAnswer1 = tbField1_u.Text
        ElseIf ddField1_u.Visible Then
            strAnswer1 = ddField1_u.SelectedValue
        End If
        If tbField2_u.Visible Then
            strAnswer2 = tbField2_u.Text
        ElseIf ddField2_u.Visible Then
            strAnswer2 = ddField2_u.SelectedValue
        End If
        If tbField3_u.Visible Then
            strAnswer3 = tbField3_u.Text
        ElseIf ddField3_u.Visible Then
            strAnswer3 = ddField3_u.SelectedValue
        End If
        If tbField4_u.Visible Then
            strAnswer4 = tbField4_u.Text
        ElseIf ddField4_u.Visible Then
            strAnswer4 = ddField4_u.SelectedValue
        End If
        If tbField5_u.Visible Then
            strAnswer5 = tbField5_u.Text
        ElseIf ddField5_u.Visible Then
            strAnswer5 = ddField5_u.SelectedValue
        End If
        If tbField6_u.Visible Then
            strAnswer6 = tbField6_u.Text
        ElseIf ddField6_u.Visible Then
            strAnswer6 = ddField6_u.SelectedValue
        End If
        Dim sRes As String = taCandidate.uspUpdateCandidateEmailCheck(Session("learnCandidateID"), tbFName_u.Text, tbLName_u.Text, ddJobGroup_u.SelectedValue, strAnswer1, strAnswer2, strAnswer3, strAnswer4, strAnswer5, strAnswer6, tbEmail_u.Text, hfAlias.Value, hfApproved.Value, hfActive.Value)
        If sRes = "-4" Then
            mvLearnMenu.SetActiveView(vDuplicateEmail)
        Else
            LoadOrCreateProgress()
        End If
    End Sub
    Private Sub btnSwitchView_Click(sender As Object, e As EventArgs) Handles btnSwitchView.Click
        frame1.Src = hfAssessSrc.Value
        mvOuter.SetActiveView(vLearningContent)
    End Sub
#End Region
#Region "SCO"
    Private Sub btnPickCentre_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPickCentre.Click
        Dim nCentreID As Integer = ddCentre.SelectedValue
        Session("UserCentreID") = nCentreID
        'hfCentreID.Value = nCentreID
        Dim nApplicationID As Integer = CInt(Session("lmApplicationID"))
        ' Get the current customisation information 
        Dim customisationAdapter As New ITSPTableAdapters.CustomisationsTableAdapter
        Dim tCustomisations As ITSP.CustomisationsDataTable
        ' 
        ' Extract the data 
        ' 
        tCustomisations = customisationAdapter.GetDataByCentreAppLongCourseName(nCentreID, nApplicationID)
        lblCentreName.Visible = True
        If tCustomisations.Count = 0 Then
            'Generate a vanilla ESR customisation 
            Dim taQ As New customiseTableAdapters.QueriesTableAdapter
            Dim nCustomisationId As Integer = taQ.uspCreateASPCustomisation(nApplicationID, nCentreID, "ESR")
            Session("lmCustomisationID") = nCustomisationId
            Session("lmCustomisationSelected") = True
            'hfCustomisationID.Value = nCustomisationId
            mvLearnMenu.SetActiveView(vLogin)
        ElseIf tCustomisations.Count = 1 Then
            'Load the customisation that we found: 
            Session("lmCustomisationSelected") = True
            Session("lmCustomisationID") = tCustomisations.First.CustomisationID
            'hfCustomisationID.Value = tCustomisations.First.CustomisationID
            mvLearnMenu.SetActiveView(vLogin)
        Else
            'List the customisations for the delegate to choose: 
            ddCusomisation.DataSource = tCustomisations
            ddCusomisation.DataBind()
            mvLearnMenu.SetActiveView(Me.vPickCustomisation)
        End If
    End Sub
    Private Sub btnSelectCustomisation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSelectCustomisation.Click
        Session("lmCustomisationSelected") = True
        Session("lmCustomisationID") = ddCusomisation.SelectedValue
        'hfCustomisationID.Value = ddCusomisation.SelectedValue
        mvLearnMenu.SetActiveView(vLogin)
    End Sub

    Private Sub vLearnMenu_Activate(sender As Object, e As EventArgs) Handles vLearnMenu.Activate
        Session("CustomisationSelected") = Nothing
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "findapi", "<script>initializeAPICommunication();</script>")
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
#End Region
End Class