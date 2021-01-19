Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Internal
Imports DevExpress.XtraScheduler
Public Class CustomAppointmentFormController
    Inherits AppointmentFormController
    Public Sub New(ByVal control As ASPxScheduler, ByVal apt As Appointment)
        MyBase.New(control, apt)
    End Sub
    Public Property CallUriField() As String
        Get
            Return CStr(EditedAppointmentCopy.CustomFields("CallUri"))
        End Get
        Set(ByVal value As String)
            EditedAppointmentCopy.CustomFields("CallUri") = value
        End Set
    End Property
    Private Property SourceCallUriField() As String
        Get
            Return CStr(SourceAppointment.CustomFields("ApptCallUri"))
        End Get
        Set(ByVal value As String)
            SourceAppointment.CustomFields("CallUri") = value
        End Set
    End Property

    Public Overrides Function IsAppointmentChanged() As Boolean
        Dim isChanged As Boolean = MyBase.IsAppointmentChanged()
        Return isChanged OrElse SourceCallUriField <> CallUriField
    End Function
End Class
