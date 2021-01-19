Imports DevExpress.Web
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Internal

Public Class CustomAppointmentSaveCallbackCommand
    Inherits AppointmentFormSaveCallbackCommand
    Public Sub New(ByVal control As ASPxScheduler)
        MyBase.New(control)
    End Sub
    Protected Friend Shadows ReadOnly Property Controller() As CustomAppointmentFormController
        Get
            Return CType(MyBase.Controller, CustomAppointmentFormController)
        End Get
    End Property

    Protected Overrides Function CreateAppointmentFormController(ByVal apt As DevExpress.XtraScheduler.Appointment) As AppointmentFormController
        Return New CustomAppointmentFormController(Control, apt)
    End Function

    Protected Overrides Function FindControlByID(ByVal id As String) As Control
        Return FindTemplateControl(TemplateContainer, id)
    End Function

    Private Function FindTemplateControl(ByVal RootControl As System.Web.UI.Control, ByVal id As String) As System.Web.UI.Control
        Dim foundedControl As System.Web.UI.Control = RootControl.FindControl(id)
        If foundedControl Is Nothing Then
            For Each item As System.Web.UI.Control In RootControl.Controls
                foundedControl = FindTemplateControl(item, id)
                If foundedControl IsNot Nothing Then
                    Exit For
                End If
            Next item
        End If
        Return foundedControl
    End Function

    Protected Overrides Sub AssignControllerValues()
        MyBase.AssignControllerValues()

        Dim tbCallUri As ASPxTextBox = TryCast(FindControlByID("tbCallUri"), ASPxTextBox)
        Controller.CallUriField = tbCallUri.Text
    End Sub
End Class
