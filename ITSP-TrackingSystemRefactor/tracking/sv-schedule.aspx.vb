Imports DevExpress.Web
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.Bootstrap
Imports DevExpress.XtraScheduler
Imports Microsoft.Graph

Public Class sv_schedule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        tbSFBUsername.Text = Session("UserEmail")
        hfRootURL.Value = My.Settings.MyURL
        If Not Page.IsPostBack Then
            If Not Page.Request.Item("id") Is Nothing Then
                Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
                If taq.GetLogItemIsValidForAdmin(Session("UserAdminID"), Page.Request.Item("id")) Then
                    ShowLogItemFinaliseForm(Page.Request.Item("id"))
                End If
            End If
        End If
    End Sub


    Private Sub Sv_schedule_Init(sender As Object, e As EventArgs) Handles Me.Init
        schSuperviseSessions.Storage.Appointments.Labels.Clear()
        Dim taAT As New SuperviseDataTableAdapters.AppointmentTypesTableAdapter
        Dim tAT As SuperviseData.AppointmentTypesDataTable = taAT.GetActiveForSchedule()
        For Each r As SuperviseData.AppointmentTypesRow In tAT.Rows
            Dim label As IAppointmentLabel = schSuperviseSessions.Storage.Appointments.Labels.CreateNewLabel(r.ApptTypeID, r.TypeLabel)
            label.SetColor(System.Drawing.Color.FromName(r.ColourString))
            schSuperviseSessions.Storage.Appointments.Labels.Add(label)
        Next
        bslbAttendees.DataBind()
        Dim statusColl As AppointmentStatusCollection = schSuperviseSessions.Storage.Appointments.Statuses
        statusColl.Clear()
        Dim stFree As AppointmentStatus = statusColl.CreateNewStatus(1, "Free")
        Dim stBusy As AppointmentStatus = statusColl.CreateNewStatus(2, "Busy")
        stFree.Color = System.Drawing.Color.WhiteSmoke
        stBusy.Color = System.Drawing.Color.RoyalBlue
        statusColl.Add(stFree)
        statusColl.Add(stBusy)
    End Sub


    Private Async Sub schSuperviseSessions_AppointmentInserting(sender As Object, e As PersistentObjectCancelEventArgs) Handles schSuperviseSessions.AppointmentInserting
        Dim apt As Appointment = CType(e.Object, Appointment)
        If Not apt Is Nothing Then
            setAptJSProperties(apt)

            If (apt.LabelKey = 8) Then
                If Request.IsAuthenticated Then
                    Dim sJoinURL = Await DLS.Helpers.SDKHelper.CreateOnlineMeeting(apt.Start, apt.End, apt.Subject, apt.Id, AttendeeListToString(apt, ""), Session("UserEmail"))
                    If sJoinURL <> "" Then
                        apt.CustomFields(0) = sJoinURL
                        If hfLogItemID.Value > 0 Then
                            Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
                            taq.UpdateCallUriForLogItem(sJoinURL, hfLogItemID.Value)
                            hfCallURI.Value = sJoinURL
                            schSuperviseSessions.JSProperties.Remove("cpCallUri")
                            schSuperviseSessions.JSProperties.Add("cpCallUri", sJoinURL)
                            Session("InsertedLogItemID") = hfLogItemID.Value
                        End If
                    End If
                Else
                    schSuperviseSessions.JSProperties.Add("cpNotLoggedIn", True)
                End If
            End If
            End If
    End Sub
    Private Async Sub schSuperviseSessions_AppointmentChanging(sender As Object, e As PersistentObjectCancelEventArgs) Handles schSuperviseSessions.AppointmentChanging

        Dim apt As Appointment = CType(e.Object, Appointment)
        If Not apt Is Nothing Then
            If (apt.LabelKey = 3) Or (apt.LabelKey = 4 And hfURIModified.Value = "true") Then
                hfLogItemID.Value = apt.Id
                schSuperviseSessions.JSProperties.Add("cpLogItemID", apt.Id)
                setAptJSProperties(apt)
                If apt.CustomFields(0).ToString.Length = 0 Then
                    schSuperviseSessions.JSProperties.Add("cpAptInserted", True)
                Else
                    'schSuperviseSessions.JSProperties.Add("cpCallUri", apt.CustomFields(0))
                    schSuperviseSessions.JSProperties.Add("cpAptModified", True)
                End If
                hfURIModified.Value = False
            ElseIf (apt.LabelKey = 8) Then
                'If apt.CustomFields(0).ToString.Length = 0 Then
                If Request.IsAuthenticated Then
                    Dim sJoinURL = Await DLS.Helpers.SDKHelper.CreateOnlineMeeting(apt.Start, apt.End, apt.Subject, apt.Id, AttendeeListToString(apt, ""), Session("UserEmail"))
                    If sJoinURL <> "" Then

                        schSuperviseSessions.JSProperties.Remove("cpAptInserted")
                        schSuperviseSessions.JSProperties.Add("cpAptInserted", True)
                        schSuperviseSessions.JSProperties.Remove("cpCallUri")
                        schSuperviseSessions.JSProperties.Add("cpCallUri", sJoinURL)
                        hfCallURI.Value = sJoinURL
                        If apt.Id > 0 Then
                            Session("InsertedLogItemID") = apt.Id
                        End If
                    End If
                        'End If
                    Else
                    schSuperviseSessions.JSProperties.Add("cpNotLoggedIn", True)
                End If
            End If
        End If
    End Sub
    Protected Sub setAptJSProperties(ByVal apt As Appointment)
        Dim nTypeID As Integer = apt.LabelKey
        schSuperviseSessions.JSProperties.Clear()
        schSuperviseSessions.JSProperties.Add("cpAptType", nTypeID)
        hfInsertedApptType.Value = nTypeID
        schSuperviseSessions.JSProperties.Add("cpAptSubject", apt.Subject)
        schSuperviseSessions.JSProperties.Add("cpAptDescription", apt.Description)
        schSuperviseSessions.JSProperties.Add("cpAptEndDate", apt.End)
        schSuperviseSessions.JSProperties.Add("cpCallUri", apt.CustomFields(0))
        schSuperviseSessions.JSProperties.Add("cpAptAttendees", AttendeeListToString(apt, "sip:"))
    End Sub
    Private Function AttendeeListToString(ByVal apt As Appointment, ByVal sPrefix As String) As String
        Dim sProgressIDsCSV As String = ""
        Dim sAttendees As String = ""
        If Not apt.ResourceIds(0).ToString = "DevExpress.XtraScheduler.EmptyResourceId" Then
            For Each nProgressID As Integer In apt.ResourceIds
                If nProgressID > 0 Then
                    sProgressIDsCSV = sProgressIDsCSV + nProgressID.ToString() + ", "
                End If
            Next
            If sProgressIDsCSV.Length > 2 Then
                sProgressIDsCSV = sProgressIDsCSV.Substring(0, sProgressIDsCSV.Length - 2)
            End If
            Dim taAtt As New SuperviseDataTableAdapters.AttendeesTableAdapter
            Dim tAtt As SuperviseData.AttendeesDataTable = taAtt.GetData(sProgressIDsCSV)
            If tAtt.Count > 0 Then
                For Each r As SuperviseData.AttendeesRow In tAtt.Rows
                    If Not r.IsEmailAddressNull Then
                        sAttendees = sAttendees & sPrefix & r.EmailAddress.ToLower() & ";"
                    End If
                Next
            End If
            If sAttendees.Length > 2 Then
                sAttendees = sAttendees.Substring(0, sAttendees.Length - 1)
            End If

            hfAttendeeProgressIDsCSV.Value = sProgressIDsCSV

        End If
        Return sAttendees
    End Function
    Private Sub schSuperviseSessions_AppointmentRowInserted(sender As Object, e As ASPxSchedulerDataInsertedEventArgs) Handles schSuperviseSessions.AppointmentRowInserted
        schSuperviseSessions.JSProperties.Add("cpAptInserted", True)
        Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
        Dim nLogItemID As Integer = taq.GetLastLogItemIDForAdmin(Session("UserAdminID"))
        hfLogItemID.Value = nLogItemID
        schSuperviseSessions.JSProperties.Add("cpLogItemID", nLogItemID)
        e.KeyFieldValue = nLogItemID
        'Dim sXML As String = e.NewValues("ResourceID")
    End Sub

    Protected Sub lbtOutcome_Command(sender As Object, e As CommandEventArgs)
        Dim nLogItemID As Integer = e.CommandArgument
        ShowLogItemFinaliseForm(nLogItemID)

    End Sub
    Protected Sub ShowLogItemFinaliseForm(ByVal nLogItemID As Integer)
        Dim taLI As New LearnMenuTableAdapters.LearningLogItemsTableAdapter
        Session("learnCurrentLogItemID") = nLogItemID
        'bslbAttendees.DataBind()
        'bslbAttendees.EnableSelectAll = True
        Dim tLI As LearnMenu.LearningLogItemsDataTable = taLI.GetByLearningLogItemID(nLogItemID)
        If tLI.Count = 1 Then
            Dim r As LearnMenu.LearningLogItemsRow = tLI.First
            Dim dtFormat As String = "dd/MM/yyyy HH:mm"
            If Not r.IsDueDateNull Then
                bsdeDueDate.Text = r.DueDate.ToString(dtFormat)
                bsdeCompletedDate.Text = r.DueDate.ToString("dd/MM/yyyy")
            End If
            bstbTopic.Text = r.Topic
            bsmemOutcomes.Text = r.Outcomes

            Dim hrs As Integer = 0
            Dim mins As Integer = r.DurationMins
            If r.DurationMins >= 60 Then
                hrs = r.DurationMins / 60
                mins = r.DurationMins Mod 60
            End If
            bspinHours.Value = hrs
            bspinMins.Value = mins
            filemxsess.DataBind()
            bsbtSubmitCompletedLogItem.CommandArgument = nLogItemID
            If bspcScheduleTabs.ActiveTabIndex = 0 Then
                bspcScheduleTabs.ActiveTabIndex = 1
            End If
            mvCompleted.SetActiveView(vOutcomeForm)
        End If
    End Sub
    Protected Sub lbtViewPrevious_Command(sender As Object, e As CommandEventArgs)
        Dim nLogItemID As Integer = e.CommandArgument
        Dim taLI As New LearnMenuTableAdapters.LearningLogItemsTableAdapter
        Session("learnCurrentLogItemID") = nLogItemID
        Session("ContributorRole") = 1
        'bslbAttendees.DataBind()
        'bslbAttendees.EnableSelectAll = True
        Dim tLI As LearnMenu.LearningLogItemsDataTable = taLI.GetByLearningLogItemID(nLogItemID)
        If tLI.Count = 1 Then
            Dim r As LearnMenu.LearningLogItemsRow = tLI.First
            lblDateVw.Text = r.CompletedDate.ToString("dd/MM/yyyy")
            lblActivityVw.Text = r.Topic
            lblOutcomesVw.Text = r.Outcomes

            Dim hrs As Integer = 0
            Dim mins As Integer = r.DurationMins
            If r.DurationMins >= 60 Then
                hrs = r.DurationMins / 60
                mins = r.DurationMins Mod 60
            End If
            lblHoursVw.Text = hrs.ToString
            lblMinsVw.Text = mins.ToString
            filemxsess1.DataBind()
            If bspcScheduleTabs.ActiveTabIndex = 0 Then
                bspcScheduleTabs.ActiveTabIndex = 1
            End If
            mvCompleted.SetActiveView(vPreviousSession)
        End If
    End Sub

    Protected Sub lbtArchive_Command(sender As Object, e As CommandEventArgs)
        Dim taSch As New SuperviseDataTableAdapters.SchedulerTableAdapter
        taSch.ArchiveSP(e.CommandArgument, Session("learnCandidateID"), e.CommandArgument)
    End Sub

    Private Sub dsCompletedSessions_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsCompletedSessions.Selected
        If e.ReturnValue.Count > 0 Then
            pnlOutcomeSessions.Visible = True
        Else
            pnlOutcomeSessions.Visible = False
        End If
    End Sub

    Protected Sub schSuperviseSessions_PopupMenuShowing(sender As Object, e As PopupMenuShowingEventArgs)
        Dim menu As ASPxSchedulerPopupMenu = e.Menu
        Dim menuItems As MenuItemCollection = menu.Items
        If menu.MenuId.Equals(SchedulerMenuItemId.DefaultMenu) Then
            ClearUnusedDefaultMenuItems(menu)
        ElseIf menu.MenuId.Equals(SchedulerMenuItemId.AppointmentMenu) Then
            ClearUnusedAptMenuItems(menu)
        End If

    End Sub
    Protected Sub ClearUnusedDefaultMenuItems(ByVal menu As ASPxSchedulerPopupMenu)
        RelabelMenuItem(menu, "NewAppointment", "New Supervision Session")
        RemoveMenuItem(menu, "NewAllDayEvent")
        RemoveMenuItem(menu, "NewRecurringAppointment")
        RemoveMenuItem(menu, "NewRecurringEvent")
    End Sub
    Protected Sub ClearUnusedAptMenuItems(ByVal menu As ASPxSchedulerPopupMenu)
        RemoveMenuItem(menu, "StatusSubMenu")
        RemoveMenuItem(menu, "LabelSubMenu")
    End Sub
    Protected Sub RemoveMenuItem(ByVal menu As ASPxSchedulerPopupMenu, ByVal menuItemName As String)
        Dim item As MenuItem = menu.Items.FindByName(menuItemName)
        If item IsNot Nothing Then
            menu.Items.Remove(item)
        End If
    End Sub
    Protected Sub RelabelMenuItem(ByVal menu As ASPxSchedulerPopupMenu, ByVal menuItemName As String, ByVal menuItemNewLabel As String)
        Dim item As MenuItem = menu.Items.FindByName(menuItemName)
        If item IsNot Nothing Then
            item.Text = menuItemNewLabel
        End If
    End Sub

    Private Sub schSuperviseSessions_AppointmentDeleting(sender As Object, e As PersistentObjectCancelEventArgs) Handles schSuperviseSessions.AppointmentDeleting
        Dim nItem As Integer = e.Object.Id
        Dim taSchedule As New SuperviseDataTableAdapters.SchedulerTableAdapter
        taSchedule.ArchiveSP(nItem, Session("learnCandidateID"), nItem)
        SendCancelAppointmentsForLogItem(nItem)
    End Sub
    Protected Function SendCancelAppointmentsForLogItem(ByVal nLogItemID As Integer) As Integer
        Dim taSched As New SuperviseDataTableAdapters.SchedulerTableAdapter
        Dim r As SuperviseData.SchedulerRow = taSched.GetDataByIDs(nLogItemID, Nothing, "").First
        Dim sSummary As String = "DLS Supervisor Scheduled Activity: " & r.Subject
        Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
        Dim sAttendees As String = taq.GetSIPsCSVForLogItem(nLogItemID, "")
        Dim gICSGUID As Guid = taq.GetGUIDForLogItemID(nLogItemID)
        Dim bAllDay As Boolean = False
        If r.StartDate.TimeOfDay.Ticks = 0 Then
            bAllDay = True
        End If
        Dim taAtt As New SuperviseDataTableAdapters.AttendeesTableAdapter
        Dim tAtt As SuperviseData.AttendeesDataTable = taAtt.GetByLogItemID(nLogItemID)
        If tAtt.Count > 0 Then
            For Each rAtt As SuperviseData.AttendeesRow In tAtt.Rows
                Dim sbDesc As String = CCommon.GetSupervisionSessionDesc(r, rAtt.EmailAddress, sAttendees, False)
                Dim sbDescHtml As String = CCommon.GetSupervisionSessionDesc(r, rAtt.EmailAddress, sAttendees, True)
                Dim sbCal As StringBuilder = CCommon.GetVCalendarString(r.StartDate, r.EndDate, Session("UserEmail"), "", sSummary, sbDesc, sbDescHtml, gICSGUID.ToString(), 0, 0, 15, bAllDay, sAttendees, True,, r.SeqInt)
                CCommon.SendEmail(rAtt.EmailAddress, sSummary, sbDescHtml.ToString(), True, , , , , , Session("UserEmail"), sbCal.ToString())
            Next
        End If
        Return tAtt.Count

    End Function
    Private Sub schSuperviseSessions_BeforeExecuteCallbackCommand(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxScheduler.SchedulerCallbackCommandEventArgs) Handles schSuperviseSessions.BeforeExecuteCallbackCommand
        If e.CommandId = SchedulerCallbackCommandId.AppointmentSave Then
            e.Command = New CustomAppointmentSaveCallbackCommand(CType(sender, ASPxScheduler))
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
    Protected Sub ClearCompletedLogItemForm()
        bsdeCompletedDate.Text = ""
        bsdeDueDate.Text = ""
        bstbTopic.Text = ""
        bsmemOutcomes.Text = ""
        bspinHours.Value = 0
        bspinMins.Value = 0
    End Sub
    Protected Sub lbtCancelAddCompleted_Command(sender As Object, e As CommandEventArgs)
        ClearCompletedLogItemForm()
        Session("ContributorRole") = Nothing
        mvCompleted.SetActiveView(vCompletedGrid)
    End Sub
    Protected Sub lbtSubmitCompletedLogItem_Command(sender As Object, e As CommandEventArgs)
        Dim sCSV As String = ""
        For Each i As BootstrapListEditItem In bslbAttendees.Items
            If i.Selected Then
                sCSV = sCSV + i.Value.ToString() + ", "
            End If
        Next
        If sCSV.Length > 2 Then
            sCSV = sCSV.Substring(0, sCSV.Length - 2)
        End If
        Dim taQ As New SuperviseDataTableAdapters.QueriesTableAdapter
        Dim nLearningLogItemID As Integer = Session("learnCurrentLogItemID")
        Dim dDue As Date?
        Dim dComplete As Date?
        If bsdeDueDate.Date > DateAdd(DateInterval.Year, -5, Date.Now()) Then
            dDue = bsdeDueDate.Date
        End If
        If bsdeCompletedDate.Date < DateAdd(DateInterval.Month, 1, Date.Now()) Then
            dComplete = bsdeCompletedDate.Date
        End If
        Dim nMins = CInt(bspinHours.Value) * 60 + CInt(bspinMins.Value)
        taQ.UpdateScheduledLearningLogItem(nLearningLogItemID, dDue, dComplete, nMins, bstbTopic.Text, bsmemOutcomes.Text, Session("UserAdminID"), sCSV)
        bsgvOutcomeSessions.DataBind()
        mvCompleted.SetActiveView(vCompletedGrid)
    End Sub

    Private Sub dsInvited_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsInvited.Selected
        Dim nRows As Integer = e.ReturnValue.count
        If nRows > 0 Then
            bslbAttendees.Rows = nRows
        End If
    End Sub
    Protected Function SendAppointmentsForLogItem(ByVal nLogItemID As Integer) As Integer
        Dim taSched As New SuperviseDataTableAdapters.SchedulerTableAdapter
        Dim r As SuperviseData.SchedulerRow = taSched.GetDataByIDs(nLogItemID, Nothing, "").First

        Dim sSummary As String = "DLS Supervisor Scheduled Activity: " & r.Subject

        Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
        Dim sAttendees As String = taq.GetSIPsCSVForLogItem(nLogItemID, "")
        Dim gICSGUID As Guid = taq.GetGUIDForLogItemID(nLogItemID)
        Dim bAllDay As Boolean = False
        If r.StartDate.TimeOfDay.Ticks = 0 Then
            bAllDay = True
        End If
        Dim taAtt As New SuperviseDataTableAdapters.AttendeesTableAdapter
        Dim tAtt As SuperviseData.AttendeesDataTable = taAtt.GetByLogItemID(nLogItemID)
        If tAtt.Count > 0 Then
            For Each rAtt As SuperviseData.AttendeesRow In tAtt.Rows
                Dim sbDesc As String = CCommon.GetSupervisionSessionDesc(r, rAtt.EmailAddress, sAttendees, False)
                Dim sbDescHtml As String = CCommon.GetSupervisionSessionDesc(r, rAtt.EmailAddress, sAttendees, True)
                Dim sbCal As StringBuilder = CCommon.GetVCalendarString(r.StartDate, r.EndDate, rAtt.EmailAddress, "", sSummary, sbDesc, sbDescHtml, gICSGUID.ToString(), 0, 0, 15, bAllDay, sAttendees,,, r.SeqInt)
                CCommon.SendEmail(rAtt.EmailAddress, sSummary, sbDescHtml.ToString(), True, , , , , , Session("UserEmail"), sbCal.ToString())
            Next
        End If
        taSched.IncrementAptSequence(nLogItemID)
        Return tAtt.Count

    End Function

    Protected Sub lbtSendInvites_Command(sender As Object, e As CommandEventArgs)
        If Not Session("InsertedLogItemID") Is Nothing Then
            SendAppointmentsForLogItem(Session("InsertedLogItemID"))
            Session("InsertedLogItemID") = Nothing
        End If
    End Sub
End Class