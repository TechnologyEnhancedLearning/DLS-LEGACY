Imports DevExpress.Web.Bootstrap

Public Class tickets
    Inherits System.Web.UI.Page
    Private Sub me_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        If Not Page.Request.Item("nonav") Is Nothing Then
            MasterPageFile = "~/tracking/trackingnonav.Master"
        Else
            MasterPageFile = "~/tracking/Site.Master"
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Session("UserUserAdmin") Then
            bsgvTickets.SettingsCookies.Version = "2.2"
            Dim tb As BootstrapGridViewToolbar = bsgvTickets.Toolbars.FindByName("gvToolbar")
            tb.Visible = False
            bsgvTickets.Columns("Reporter").Visible = False
            bsgvTickets.Columns("Reporter").Visible = False
            bsgvTickets.Columns("AssignedToName").Visible = False
            'bsgvTickets.Columns("Archived").Visible = False
            bsgvTickets.Columns("ResolveBy").Visible = False
            bsgvTickets.Columns("CentreName").Visible = False
            pnlAssignTo.Visible = False
            pnlPriority.Visible = False
            resby1.Visible = False
            resby2.Visible = False
            pnlCatType.Visible = False
        Else
            bsgvTickets.CssClasses.Table = "small"
        End If
        If Not Page.IsPostBack Then
            If Not Page.Request.Item("TID") Is Nothing Then
                Dim nTicketID As Integer = CInt(Page.Request.Item("TID"))
                If nTicketID > 0 Then
                    OpenTicket(nTicketID)
                End If
            End If
        End If
    End Sub

    Protected Function GetTicketColourStatus(ByVal nStatusID As Integer)
        Dim sReturn = "btn btn-outline-secondary"
        Select Case nStatusID
            Case 1
                sReturn = "btn btn-danger"
            Case 2
                sReturn = "btn btn-warning text-white"
            Case 3
                sReturn = "btn btn-success"
        End Select
        Return sReturn
    End Function
    Protected Function GetTicketStatus(ByVal nStatusID As Integer)
        Dim sReturn = "Closed"
        Select Case nStatusID
            Case 1
                sReturn = "New"
            Case 2
                sReturn = "Awaiting Response"
            Case 3
                sReturn = "Responded"
        End Select
        Return sReturn
    End Function
    Protected Function GetSLACSS(ByVal dTarget As DateTime)
        Dim sReturn = ""
        If dTarget < DateTime.Now() Then
            sReturn = "bg-danger"
        End If
        Return sReturn
    End Function
    Protected Sub OpenTicket_Click(sender As Object, e As CommandEventArgs)
        Dim nTicketID As Integer = e.CommandArgument
        OpenTicket(nTicketID)
    End Sub
    Protected Sub OpenTicket(ByVal nTicketID As Integer)
        Dim taTicket As New supportdataTableAdapters.TicketDetailTableAdapter
        Dim tTicket As New supportdata.TicketDetailDataTable
        tTicket = taTicket.GetData(nTicketID, Session("UserCentreID"), Session("UserUserAdmin"))
        If tTicket.Count > 0 Then
            hfTicketID.Value = nTicketID
            hfReporterAUID.Value = tTicket.First.AdminUserID
            hfReporterEmail.Value = tTicket.First.Email
            lblTicketHeader.Text = "Ticket " & tTicket.First.TicketID
            lblTicketSubject.Text = tTicket.First.QuerySubject
            lblTicketStatus.Text = GetTicketStatus(tTicket.First.TStatusID)
            ddTicketTypeManage.SelectedValue = tTicket.First.TicketTypeID
            ddTicketCategoryManage.SelectedValue = tTicket.First.TicketCategoryID
            If tTicket.First.TStatusID = 4 Then
                lbtArchiveTicket.Visible = False
            Else
                lbtArchiveTicket.Visible = True
            End If
            lblAddedDate.Text = tTicket.First.RaisedDate.ToString()
            lblLastUpdate.Text = tTicket.First.LastActivityDate.ToString()
            If tTicket.First.TicketTypeID = 4 Then
                pnlProblemContext.Visible = True
                pnlTicketHeader.CssClass = "col-12 col-md-8 "
                If tTicket.First.DelegateID.Length > 0 Then
                    lblDelID.Text = tTicket.First.DelegateID
                Else
                    lblDelID.Text = "N/A"
                End If
                If tTicket.First.CourseID > 0 Then
                    Dim sLink As String = CCommon.GetConfigString("TrackingSystemBaseURL") & "learn" &
                          "?CentreID=" & tTicket.First.CentreID.ToString &
                          "&CustomisationID=" & tTicket.First.CourseID.ToString

                    lbtLaunchCourse.PostBackUrl = sLink
                    lbtLaunchCourse.Text = "Course " & tTicket.First.CourseID
                    lbtLaunchCourse.Visible = True
                    lblNoCourse.Visible = False
                Else
                    lbtLaunchCourse.Visible = False
                    lblNoCourse.Visible = True
                End If
            Else
                pnlProblemContext.Visible = False
                pnlTicketHeader.CssClass = "col-12"
            End If

            If tTicket.First.AssignedToEmail <> "" Then
                lblAssignTo.Text = "Assigned to " & tTicket.First.AssignedToEmail
            Else
                lblAssignTo.Text = "Assign to"
            End If
            lblResolveBy.Text = tTicket.First.ResolveBy.ToString()
            lblAddedBy.Text = tTicket.First.ReporterName & " - " & tTicket.First.CentreName
            Select Case tTicket.First.ResolveInDays
                Case 1
                    lblResolveByDD.Text = "Priority: Critical (Same day)"
                Case 2
                    lblResolveByDD.Text = "Priority: High (Next day)"
                Case 7
                    lblResolveByDD.Text = "Priority: Medium (One week)"
                Case 90
                    lblResolveByDD.Text = "Priority: Low / Change request (90 days)"
            End Select
            dsTicketComments.SelectParameters(0).DefaultValue = nTicketID
            mvSupportTickets.SetActiveView(vManageTicket)
        Else
            lblModalTitle.Text = "Ticket #" & nTicketID.ToString & " could not be opened"
            lblModalBody.Text = "The requested ticket either does not exist or you don't have permission to open it."
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMsg", "<script>$('#messageModal').modal('show');</script>")
        End If


    End Sub
    Private Sub lbtCloseTicket_Click(sender As Object, e As EventArgs) Handles lbtCloseTicket.Click
        Dim sUri As Uri = New Uri(Request.Url.AbsoluteUri)
        Dim sURL = sUri.Scheme & Uri.SchemeDelimiter & sUri.Authority & sUri.AbsolutePath
        If Request.QueryString("nonav") IsNot Nothing Then
            sURL = sURL & "?nonav=true"
        End If
        Response.Redirect(sURL)
    End Sub
    Public Function RemoveHTMLTags(ByVal HTMLCode As String) As String
        Return System.Text.RegularExpressions.Regex.Replace(
          HTMLCode, "<[^>]*>", "")
    End Function
    Protected Sub ArchiveTicket(ByVal nTicketID As Integer)
        'send e-mails:
        Dim taq As New supportdataTableAdapters.QueriesTableAdapter
        Dim sComment As String = RemoveHTMLTags(htmlAddComment.Html)
        Dim sBody As String = ""
        Dim sSubject As String = ""
        Dim sUserName As String = Session("UserForename") & " " & Session("UserSurname")
        Dim sTicketURL As String = CCommon.GetConfigString("TrackingSystemBaseURL") & CCommon.GetConfigString("TicketPage") & "tid=" & nTicketID.ToString()
        Dim sReporterEmail As String = hfReporterEmail.Value.ToString()
        If sReporterEmail <> "" Then
            'send an e-mail to the recipient:

            sBody = "<p>Dear " & taq.GetUsernameFromEmail(sReporterEmail) & "</p>"
            If sTicketURL.Contains("sandpit") Then
                sSubject = "Your Digital Learning Solutions Tracking System Ticket " & nTicketID.ToString & " has been Closed"
                sBody = sBody & "<p>Your Digital Learning Solutions Tracking System support ticket regarding <i>" & lblTicketSubject.Text & "</i> has been closed by " & sUserName & ".</p>"
            Else
                sSubject = "Your Digital Learning Solutions Tracking System Ticket " & nTicketID.ToString & " has been Closed"
                sBody = sBody & "<p>Your Digital Learning Solutions Tracking System support ticket regarding <i>" & lblTicketSubject.Text & "</i> has been closed by " & sUserName & ".</p>"
            End If

            sBody = sBody & "<p>To view the support ticket (and reopen if required) <a href='" & sTicketURL & "'>click here</a>.</p>"
            sBody = sBody & "<p>PLEASE DO NOT REPLY TO THIS E-MAIL. IT WAS SENT FROM AN E-MAIL ADDRESS THAT IS NOT MONITORED.</p>"
            CCommon.SendEmail(sReporterEmail, sSubject, sBody, True,,,, 5, hfReporterAUID.Value)
        End If
        taq.CloseTicket(nTicketID)
        Response.Redirect(Request.Url.AbsoluteUri)
    End Sub
    Protected Sub ArchiveTicket_Click(sender As Object, e As CommandEventArgs)
        ArchiveTicket(e.CommandArgument)
    End Sub
    Private Sub lbtArchiveTicket_Click(sender As Object, e As EventArgs) Handles lbtArchiveTicket.Click
        ArchiveTicket(CInt(hfTicketID.Value))
    End Sub
    Protected Sub _SendEmailNewTicketAdmin(ByVal nTicketID As Integer)
        Dim taTickets As New supportdataTableAdapters.TicketDetailTableAdapter
        Dim tblTickets As New supportdata.TicketDetailDataTable
        tblTickets = taTickets.GetData(nTicketID, Session("UserCentreID"), Session("UserUserAdmin"))
        If tblTickets.Count <> 1 Then
            Exit Sub
        End If
        Dim sSubject As String
        Dim sTicketLink As String
        '
        ' Link to view the ticket
        '
        sTicketLink = CCommon.GetConfigString("TrackingSystemBaseURL") & CCommon.GetConfigString("TicketPage") & "action=view&TID=" & nTicketID.ToString
        '
        ' Create the email
        '
        Dim sbBody As New StringBuilder

        sSubject = "New Digital Learning Solutions Tracking System ticket raised (" & nTicketID & ")"
        sbBody.Append("Dear ITSP Administrator" & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("A centre user from " & tblTickets.First.CentreName & ", has raised a Digital Learning Solutions Tracking System ticket regarding: " & vbCrLf)
        sbBody.Append(tblTickets.First.QuerySubject & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("To see the ticket, follow this link : " & sTicketLink & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("This email as it has been automatically generated, please don't reply." & vbCrLf)
        CCommon.SendEmail(CCommon.GetConfigString("SupportEmail"), sSubject, sbBody.ToString(), False)
    End Sub
    Protected Sub _SendHoldingEmailToTicketRaiser(ByVal nTicketID As Integer)
        Dim taTickets As New supportdataTableAdapters.TicketDetailTableAdapter
        Dim tblTickets As New supportdata.TicketDetailDataTable
        tblTickets = taTickets.GetData(nTicketID, Session("UserCentreID"), Session("UserUserAdmin"))

        If tblTickets.Count <> 1 Then
            Exit Sub
        End If

        Dim sSubject As String
        Dim sTicketLink As String
        '
        ' Link to view the ticket
        '
        sTicketLink = CCommon.GetConfigString("TrackingSystemBaseURL") & CCommon.GetConfigString("TicketPage") & "action=view&TID=" & nTicketID.ToString
        '
        ' Create the email
        '
        Dim taConfig As New ITSPTableAdapters.ConfigTableAdapter
        Dim tblConfig As ITSP.ConfigDataTable

        tblConfig = taConfig.GetByName("AutoRespond")

        Dim sbBody As New StringBuilder

        sSubject = "New Digital Learning Solutions Support Ticket Raised: " & nTicketID.ToString
        sbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")

        sbBody.Append("Dear " & tblTickets.First.Forename & ",<br/><br/>")
        sbBody.Append("Thank you for raising a support ticket regarding: ")
        sbBody.Append(tblTickets.First.QuerySubject & "<br/><br/>")
        sbBody.Append("We will endeavour to respond to you within 2 working days. ")
        sbBody.Append("In the meantime, it may speed up the resolution of your issue if you check the Digital Learning Solutions <a href=""https://www.dls.nhs.uk/v2/tracking/faqs"">FAQS page</a> and <a href=""https://www.dls.nhs.uk/tracking/help/Introduction.html"">Help documentation</a> for assistance with your issue.<br/><br/>")
        sbBody.Append("Please note that most of the support requests that we receive can be resolved by ensuring https://www.dls.nhs.uk is in your Trusted Sites list.<br/><br/>")
        sbBody.Append("To review your ticket, <a href=""" & sTicketLink & """>click here</a>")
        sbBody.Append("<br/><br/>Once your query has been satisfactorily resolved, please remember to close your support ticket.<br/><br/>")
        sbBody.Append("Please don't reply to this email as it has been automatically generated.")
        If tblConfig.Rows.Count = 1 Then
            sbBody.Append("<br/><br/>")
            sbBody.Append(tblConfig.First.ConfigText)
        End If


        sbBody.Append("</body>")
        '
        ' And try to send the email, don't bother about 
        '
        Dim sBody As String = sbBody.ToString()
        CCommon.SendEmail(tblTickets.First.Email, sSubject, sBody, True,,,, 5, Session("AdminUserID"))
    End Sub
    Protected Function _GetPageAndTab(Optional ByVal bFullPath = False) As String
        Dim sPageName As String
        Dim sTab As String = "tickets"

        '
        ' Might be loaded from either courses or full delegate list tab. 
        ' Decide which one is appropriate, preserving the tab selection in the URL
        '
        If Not Page.Request.Item("tab") Is Nothing Then
            sTab = Page.Request.Item("tab")
        End If
        If bFullPath Then
            sPageName = Request.Url.AbsolutePath
        Else
            sPageName = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1)
        End If
        Return sPageName & "?tab=" & sTab
    End Function

    Private Sub lbtSubmitNewComment_Click(sender As Object, e As EventArgs) Handles lbtSubmitNewComment.Click
        'check that a comment has actually been made:
        If htmlAddComment.Html <> "" Then
            'set up ticket comment table adapter access:
            Dim taq As New supportdataTableAdapters.QueriesTableAdapter
            Dim nTicketStatusID As Integer = 2
            If Session("UserUserAdmin") Then
                nTicketStatusID = 3
            End If
            Dim nTicketID As Integer = CInt(hfTicketID.Value)
            Dim sEmail As String = Session("UserEmail").ToString()
            Dim nInsertedCommentID As Integer = taq.InsertTicketComment(nTicketID, htmlAddComment.Html, Session("UserAdminID"))
            If nInsertedCommentID > 0 Then
                taq.UpdateTicketStatus(nTicketStatusID, nTicketID)
                'Dim sComment As String = RemoveHTMLTags(htmlAddComment.Html)
                'htmlAddComment.Html = ""

                If nTicketStatusID = 2 Then
                    _SendEmailTicketResponseAdmin(nTicketID)
                Else
                    _SendEmailToTicketRaiser(nTicketID)
                End If
            End If
            Dim sUri As Uri = New Uri(Request.Url.AbsoluteUri)
            Dim sURL = sUri.Scheme & Uri.SchemeDelimiter & sUri.Authority & sUri.AbsolutePath
            Response.Redirect(sURL & "?TID=" & nTicketID.ToString)
        End If
    End Sub
    Protected Sub _SendEmailToTicketRaiser(ByVal nTicketID As Integer)
        Dim taTickets As New supportdataTableAdapters.TicketDetailTableAdapter
        Dim tblTickets As New supportdata.TicketDetailDataTable

        tblTickets = taTickets.GetData(nTicketID, Session("UserCentreID"), Session("UserUserAdmin"))

        If tblTickets.Count <> 1 Then
            Exit Sub
        End If

        Dim sSubject As String
        Dim sTicketLink As String
        '
        ' Link to view the ticket
        '
        sTicketLink = CCommon.GetConfigString("TrackingSystemBaseURL") & CCommon.GetConfigString("TicketPage") & "action=view&TID=" & nTicketID.ToString
        '
        ' Create the email
        '
        Dim sbBody As New StringBuilder

        sSubject = "Response made to Digital Learning Solutions Tracking System ticket " & nTicketID

        sbBody.Append("Dear " & tblTickets.First.Forename & "," & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("An administrator has responded to your Digital Learning Solutions Tracking System ticket regarding: " & vbCrLf)
        sbBody.Append(tblTickets.First.QuerySubject & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("To see the comment, follow this link : " & sTicketLink & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("Please don't reply to this email as it has been automatically generated." & vbCrLf)
        '
        ' And try to send the email, don't bother about 
        '
        CCommon.SendEmail(tblTickets.First.Email, sSubject, sbBody.ToString(), False, , ,, 5, tblTickets.First.AdminUserID)
    End Sub
    Protected Sub _SendEmailTicketResponseAdmin(ByVal nTicketID As Integer)
        Dim taTickets As New supportdataTableAdapters.TicketDetailTableAdapter
        Dim tblTickets As New supportdata.TicketDetailDataTable

        tblTickets = taTickets.GetData(nTicketID, Session("UserCentreID"), Session("UserUserAdmin"))

        If tblTickets.Count <> 1 Then
            Exit Sub
        End If

        Dim sSubject As String
        Dim sTicketLink As String
        '
        ' Link to view the ticket
        '
        sTicketLink = CCommon.GetConfigString("TrackingSystemBaseURL") & CCommon.GetConfigString("TicketPage") & "action=view&TID=" & nTicketID.ToString
        '
        ' Create the email
        '
        Dim sCC As String = ""
        Dim sTo As String = tblTickets.First.AssignedToEmail.ToString
        If sTo.Length = 0 Then
            Exit Sub
        End If

        Dim sbBody As New StringBuilder
        sSubject = "Digital Learning Solutions Tracking System ticket " & nTicketID & " commented"
        sbBody.Append("Dear ITSP Administrator" & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append(tblTickets.First.Forename & " from " & tblTickets.First.CentreName & " has added a new comment to the Digital Learning Solutions Tracking System ticket regarding: " & vbCrLf)
        sbBody.Append(tblTickets.First.QuerySubject & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("To see the comment, follow this link : " & sTicketLink & vbCrLf)
        sbBody.Append(vbCrLf)
        sbBody.Append("Please don't reply to this email as it has been automatically generated." & vbCrLf)
        CCommon.SendEmail(sTo, sSubject, sbBody.ToString(), False)
    End Sub

    Private Sub ddTicketTypeManage_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddTicketTypeManage.SelectedIndexChanged
        Dim taq As New supportdataTableAdapters.QueriesTableAdapter
        taq.UpdateTicketType(ddTicketTypeManage.SelectedValue, hfTicketID.Value)
    End Sub
    Private Sub ddTicketCategoryManage_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddTicketCategoryManage.SelectedIndexChanged
        Dim taq As New supportdataTableAdapters.QueriesTableAdapter
        taq.UpdateTicketCategory(ddTicketCategoryManage.SelectedValue, hfTicketID.Value)
    End Sub
    Private Sub rptAssignTo_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptAssignTo.ItemCommand
        If e.CommandName = "AssignTo" Then
            Dim nTicketID As Integer = CInt(hfTicketID.Value)
            Dim sAssignTo As Integer = e.CommandArgument
            Dim taq As New supportdataTableAdapters.QueriesTableAdapter
            Dim sAssignToEmail As String = taq.AssignTicketTo(sAssignTo, nTicketID)
            're-assign e-mail:
            Dim sBody As String = ""
            Dim sSubject As String = ""
            Dim sUserName As String = Session("UserForename") & " " & Session("UserSurname")
            Dim sTicketURL As String = CCommon.GetConfigString("TrackingSystemBaseURL") & CCommon.GetConfigString("TicketPage") & "action=view&TID=" & nTicketID.ToString
            Dim sAGEmail As String = sAssignToEmail
            If sAGEmail <> "" Then
                'send an e-mail to the recipient:
                sBody = "<p>Dear " & taq.GetUsernameFromEmail(sAssignToEmail) & "</p>"

                sSubject = "Digital Learning Solutions Ticket " & nTicketID.ToString & " has been Assigned to You"
                sBody = sBody & "<p>Digital Learning Solutions support ticket " & nTicketID.ToString & " regarding <i>" & lblTicketSubject.Text & "</i> has been assigned to you by " & sUserName & ".</p>"

                sBody = sBody & "<p>To view and manage the support ticket <a href='" & sTicketURL & "'>click here</a>.</p>"
                sBody = sBody & "<p>PLEASE DO NOT REPLY TO THIS E-MAIL. IT WAS SENT FROM AN E-MAIL ADDRESS THAT IS NOT MONITORED.</p>"
                CCommon.SendEmail(sAssignToEmail, sSubject, sBody, True)
            End If
            'end re-assign email
            OpenTicket(nTicketID)
        End If
    End Sub
    Private Sub lbtRemoveAssign_Click(sender As Object, e As EventArgs) Handles lbtRemoveAssign.Click
        Dim nTicketID As Integer = CInt(hfTicketID.Value)
        Dim taq As New supportdataTableAdapters.QueriesTableAdapter
        taq.UnassignTicket(nTicketID)
        OpenTicket(nTicketID)
    End Sub

    Private Sub lbtSameDay_Click(sender As Object, e As EventArgs) Handles lbtSameDay.Click
        setResolveDays(1)
    End Sub

    Private Sub lbtNextDay_Click(sender As Object, e As EventArgs) Handles lbtNextDay.Click
        setResolveDays(2)
    End Sub

    Private Sub lbtOneWeek_Click(sender As Object, e As EventArgs) Handles lbtOneWeek.Click
        setResolveDays(7)
    End Sub

    Private Sub lbtChangeRequest_Click(sender As Object, e As EventArgs) Handles lbtChangeRequest.Click
        setResolveDays(90)
    End Sub

    Private Sub setResolveDays(nDays As Integer)
        Dim taq As New supportdataTableAdapters.QueriesTableAdapter
        Dim nTicketID As Integer = CInt(hfTicketID.Value)
        taq.SetResolveDaysForTicket(nDays, nTicketID)
        OpenTicket(nTicketID)
    End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            TicketGridViewExporter.WriteXlsxToResponse()
        End If
    End Sub


End Class