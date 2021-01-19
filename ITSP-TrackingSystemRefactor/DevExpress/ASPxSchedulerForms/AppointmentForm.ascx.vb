Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports DevExpress.XtraScheduler
Imports DevExpress.Web
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Internal
Imports System.Collections
Imports System.Collections.Generic
Imports DevExpress.XtraScheduler.Localization
Imports DevExpress.Web.ASPxScheduler.Localization
Imports DevExpress.Utils
Imports System.Web.UI.WebControls
Imports DevExpress.Utils.Localization

Partial Public Class AppointmentForm
    Inherits SchedulerFormControl
    Public Overrides ReadOnly Property ClassName() As String
        Get
            Return "ASPxAppointmentForm"
        End Get
    End Property

    Public ReadOnly Property CanShowReminders() As Boolean
        Get
            Return (CType(Parent, AppointmentFormTemplateContainer)).Control.Storage.EnableReminders
        End Get
    End Property
    Public ReadOnly Property ResourceSharing() As Boolean
        Get
            Return (CType(Parent, AppointmentFormTemplateContainer)).Control.Storage.ResourceSharing
        End Get
    End Property
    Public ReadOnly Property ResourceDataSource() As IEnumerable
        Get
            Return (CType(Parent, AppointmentFormTemplateContainer)).ResourceDataSource
        End Get
    End Property
    Public ReadOnly Property TimeZonesEnabled() As Boolean
        Get
            Return (CType(Parent, AppointmentFormTemplateContainer)).TimeZonesEnabled
        End Get
    End Property

    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        MyBase.OnLoad(e)
        Localize()
        tbSubject.Focus()
    End Sub
    Private Sub Localize()
        lblSubject.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_Subject)
        lblLocation.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_Location)
        lblLabel.Text = "Type:"
        lblStartDate.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_StartTime)
        lblEndDate.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_EndTime)
        lblStatus.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_Status)
        lblAllDay.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_AllDayEvent)
        lblResource.Text = "Delegates:"
        If CanShowReminders Then
            lblReminder.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_Reminder)
        End If
        btnOk.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonOk)
        btnCancel.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonCancel)
        btnDelete.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonDelete)
        If TimeZonesEnabled Then
            lblTimeZone.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_TimeZone)
        End If
		btnOk.Wrap = DefaultBoolean.False
		btnCancel.Wrap = DefaultBoolean.False
		btnDelete.Wrap = DefaultBoolean.False
    End Sub
    Public Overrides Sub DataBind()
        MyBase.DataBind()

        Dim container As AppointmentFormTemplateContainer = CType(Parent, AppointmentFormTemplateContainer)
        Dim apt As Appointment = container.Appointment
		Dim appointmentStorage As IAppointmentStorageBase = container.Control.Storage.Appointments
        Dim label As IAppointmentLabel = appointmentStorage.Labels.GetById(apt.LabelKey)
        Dim status As IAppointmentStatus = appointmentStorage.Statuses.GetById(apt.StatusKey)
        edtLabel.ValueType = apt.LabelKey.GetType()
        edtLabel.SelectedIndex = appointmentStorage.Labels.IndexOf(label)
        edtStatus.ValueType = apt.StatusKey.GetType()
        edtStatus.SelectedIndex = appointmentStorage.Statuses.IndexOf(status)
        If Not apt.Id Is Nothing Then
            hfAptID.Value = apt.Id
            Session("learnCurrentLogItemID") = apt.Id
            filemxsess.DataBind()
        Else
            hfAptID.Value = 0
        End If
        PopulateResourceEditors(apt, container)

        'AppointmentRecurrenceForm1.Visible = container.ShouldShowRecurrence
        tbCallUri.Text = If(apt.CustomFields("CallUri") IsNot Nothing, apt.CustomFields("CallUri").ToString(), "")
        'If tbCallUri.Text.Trim() = "" Then
        '    launchLink.Attributes.Remove("class")
        '    launchLink.Attributes.Add("class", "d-none")
        '    If apt.Id > 0 And edtLabel.SelectedItem.Value = 3 Then
        '        launchLink.Attributes.Remove("class")
        '        launchLink.Attributes.Add("class", "btn btn-info")
        '    End If

        'Else
        '    launchLink.Attributes.Remove("class")
        '    launchLink.Attributes.Add("class", "btn btn-success")
        'End If
        If apt.HasReminder Then
            cbReminder.Value = apt.Reminder.TimeBeforeStart.ToString()
            chkReminder.Checked = True
        Else
            cbReminder.ClientEnabled = False
        End If

        If TimeZonesEnabled Then
            cbTimeZone.DataSource = TimeZoneInfo.GetSystemTimeZones()
            cbTimeZone.ValueField = "Id"
            cbTimeZone.TextField = "DisplayName"
            cbTimeZone.DataBind()
            cbTimeZone.Value = container.TimeZoneId
            cbTimeZone.Enabled = apt.Type = AppointmentType.Normal OrElse apt.Type = AppointmentType.Pattern
        End If

        'btnOk.ClientSideEvents.Click = container.SaveHandler;
        btnCancel.ClientSideEvents.Click = container.CancelHandler
        btnDelete.ClientSideEvents.Click = container.DeleteHandler
        JSProperties.Add("cpHasExceptions", apt.HasExceptions)
        'btnDelete.Enabled = !container.IsNewAppointment;
    End Sub
    Private Sub PopulateResourceEditors(ByVal apt As Appointment, ByVal container As AppointmentFormTemplateContainer)
        If ResourceSharing Then
            Dim edtMultiResource As ASPxListBox = TryCast(ddResource.FindControl("edtMultiResource"), ASPxListBox)
            If edtMultiResource Is Nothing Then
                Return
            End If
            SetListBoxSelectedValues(edtMultiResource, apt.ResourceIds)
            Dim multiResourceString As List(Of String) = GetListBoxSelectedItemsText(edtMultiResource)
            Dim stringResourceNone As String = SchedulerLocalizer.GetString(SchedulerStringId.Caption_ResourceNone)
            ddResource.Value = stringResourceNone
            If multiResourceString.Count > 0 Then
                ddResource.Value = String.Join(", ", multiResourceString.ToArray())
            End If
            ddResource.JSProperties.Add("cp_Caption_ResourceNone", stringResourceNone)
        Else
            If Not Object.Equals(apt.ResourceId, EmptyResourceId.Id) Then
                edtResource.Value = apt.ResourceId.ToString()
            Else
                edtResource.Value = SchedulerIdHelper.EmptyResourceId
            End If
        End If
    End Sub
    Private Function GetListBoxSelectedItemsText(ByVal listBox As ASPxListBox) As List(Of String)
        Dim result As New List(Of String)()
        For Each editItem As ListEditItem In listBox.Items
            If editItem.Selected Then
                result.Add(editItem.Text)
            End If
        Next editItem
        Return result
    End Function
    Private Sub SetListBoxSelectedValues(ByVal listBox As ASPxListBox, ByVal values As IEnumerable)
        listBox.Value = Nothing
        For Each value As Object In values
            Dim item As ListEditItem = listBox.Items.FindByValue(value.ToString())
            If item IsNot Nothing Then
                item.Selected = True
            End If
        Next value
    End Sub
    Protected Overrides Sub PrepareChildControls()
        Dim container As AppointmentFormTemplateContainer = CType(Parent, AppointmentFormTemplateContainer)
        Dim control As ASPxScheduler = container.Control

        'AppointmentRecurrenceForm1.EditorsInfo = New EditorsInfo(control, control.Styles.FormEditors, control.Images.FormEditors, control.Styles.Buttons)
        MyBase.PrepareChildControls()
    End Sub
    Protected Overrides Function GetChildEditors() As ASPxEditBase()
        Dim edits() As ASPxEditBase = {lblSubject, tbSubject, lblLocation, tbLocation, lblLabel, edtLabel, tbCallUri, lblStartDate, edtStartDate, lblEndDate, edtEndDate, lblStatus, edtStatus, lblAllDay, chkAllDay, lblResource, edtResource, tbDescription, cbReminder, lblReminder, ddResource, chkReminder, GetMultiResourceEditor(), edtStartTime, edtEndTime, cbTimeZone}

        Return edits
    End Function
    Private Function GetMultiResourceEditor() As ASPxEditBase
        If ddResource IsNot Nothing Then
            Return TryCast(ddResource.FindControl("edtMultiResource"), ASPxEditBase)
        End If
        Return Nothing
    End Function
    Protected Overrides Function GetChildButtons() As ASPxButton()
        Dim buttons() As ASPxButton = {btnOk, btnCancel, btnDelete}
        Return buttons
    End Function
    'Protected Overrides Function GetChildControls() As Control()
    '    Return New Control() { ValidationContainer, AppointmentRecurrenceForm1 }
    'End Function
    Protected Overrides Function GetDefaultButton() As WebControl
        Return btnOk
    End Function
    Protected Overrides Sub PrepareLocalization(ByVal localizationCache As SchedulerLocalizationCache)
        localizationCache.Add(SchedulerStringId.Msg_RecurrenceExceptionsWillBeLost)
        localizationCache.Add(SchedulerStringId.Msg_Warning)
    End Sub
End Class
