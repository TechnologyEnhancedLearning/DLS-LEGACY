Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.XtraScheduler
Imports DevExpress.Web.ASPxScheduler.Internal
Imports DevExpress.Web
Imports DevExpress.XtraScheduler.Native
Imports DevExpress.XtraScheduler.Localization
Imports DevExpress.Web.ASPxScheduler.Localization

Partial Public Class ReminderForm
    Inherits SchedulerFormControl
    Public Overrides ReadOnly Property ClassName() As String
        Get
            Return "ASPxReminderForm"
        End Get
    End Property
    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
		MyBase.OnLoad(e)
		Localize()
		'PrepareChildControls();
	End Sub
	Private Sub Localize()
		btnDismissAll.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonDismissAll)
		btnDismiss.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonDismiss)
		lblClickSnooze.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_SnoozeInfo)
        btnSnooze.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonSnooze)
        btnOpenItem.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonOpenItem)
        lblStartTime.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_StartTime)
    End Sub
	Public Overrides Sub DataBind()
		MyBase.DataBind()

		Dim container As RemindersFormTemplateContainer = CType(Parent, RemindersFormTemplateContainer)

		btnDismiss.ClientSideEvents.Click = container.DismissReminderHandler
		btnDismissAll.ClientSideEvents.Click = container.DismissAllRemindersHandler
		btnSnooze.ClientSideEvents.Click = container.SnoozeRemindersHandler

		InitItemListBox(container)
		InitSnoozeCombo(container)
	End Sub
	Private Sub InitItemListBox(ByVal container As RemindersFormTemplateContainer)
		Dim reminders As ReminderCollection = container.Reminders
		Dim count As Integer = reminders.Count
		For i As Integer = 0 To count - 1
            Dim reminder As Reminder = reminders(i)
            Dim item As New ListEditItem(reminder.Subject, AppointmentSearchHelper.GetAppointmentClientId(reminder.Appointment))
            lbItems.Items.Add(item)
		Next i
		lbItems.SelectedIndex = 0
	End Sub
	Private Sub InitSnoozeCombo(ByVal container As RemindersFormTemplateContainer)
		cbSnooze.Items.Clear()
		Dim timeSpans() As TimeSpan = container.SnoozeTimeSpans
		Dim count As Integer = timeSpans.Length
		For i As Integer = 0 To count - 1
			Dim timeSpan As TimeSpan = timeSpans(i)
			cbSnooze.Items.Add(New ListEditItem(container.ConvertSnoozeTimeSpanToString(timeSpan), timeSpan))
		Next i
		cbSnooze.SelectedIndex = 4
	End Sub
	Protected Overrides Function GetChildEditors() As ASPxEditBase()
        Dim edits() As ASPxEditBase = {lbItems, lblClickSnooze, cbSnooze, lblStartTime, lblAppointmentStartTime, lblAppointmentSubject}
        Return edits
	End Function
	Protected Overrides Function GetChildButtons() As ASPxButton()
        Dim buttons() As ASPxButton = {btnDismissAll, btnDismiss, btnSnooze, btnOpenItem}
        Return buttons
	End Function
End Class
