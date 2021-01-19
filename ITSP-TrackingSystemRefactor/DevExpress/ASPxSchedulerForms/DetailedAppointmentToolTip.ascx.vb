Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Localization
Imports DevExpress.Web.Internal

Partial Public Class DetailedAppointmentToolTip
	Inherits ASPxSchedulerToolTipBase
	Public Overrides ReadOnly Property ToolTipShowStem() As Boolean
		Get
			Return False
		End Get
	End Property
	Public Overrides ReadOnly Property ToolTipCloseOnClick() As Boolean
		Get
			Return True
		End Get
	End Property
	Public Overrides ReadOnly Property ToolTipResetPositionByTimer() As Boolean
		Get
			Return False
		End Get
	End Property

	Public Overrides ReadOnly Property ClassName() As String
		Get
			Return "ASPxClientAppointmentDetailedToolTip"
		End Get
	End Property
	Protected Overrides Sub OnLoad(ByVal e As EventArgs)
		MyBase.OnLoad(e)

		Localize()
	End Sub

	Protected Overrides Sub PrepareControls(ByVal scheduler As ASPxScheduler)
		MyBase.PrepareControls(scheduler)

		ApplyControlsStyle(scheduler)
	End Sub

	Private Sub Localize()
		btnEdit.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.ToolTip_EditAppointment)
		btnDelete.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.ToolTip_DeleteAppointment)
	End Sub

	Protected Overrides Sub PrepareLocalization(ByVal localizationCache As SchedulerLocalizationCache)
		MyBase.PrepareLocalization(localizationCache)

		localizationCache.Add(ASPxSchedulerStringId.ToolTip_Loading)
	End Sub

	Private Sub ApplyControlsStyle(ByVal scheduler As ASPxScheduler)
		ApplyControlsParentStyles(scheduler)
		ApplyButtonsStyle()
	End Sub

	Protected Sub ApplyControlsParentStyles(ByVal scheduler As ASPxScheduler)
		For Each control As ASPxWebControl In GetChildControls()
			If control IsNot Nothing Then
				control.ParentSkinOwner = scheduler
			End If
		Next control
	End Sub

	Private Sub ApplyButtonsStyle()
		ApplyButtonStyle(btnDelete)
		ApplyButtonStyle(btnEdit)
	End Sub

	Private Sub ApplyButtonStyle(ByVal button As ASPxButton)
		button.Width = Unit.Percentage(50)
		button.Height = Unit.Pixel(44)

		button.Border.BorderStyle = BorderStyle.None
		button.BorderTop.BorderStyle = BorderStyle.Solid
		button.BorderTop.BorderWidth = Unit.Pixel(1)

		Dim buttonWithColorClass = "dxsc-dat-colored-button"
		RenderUtils.AppendCssClass(button.HoverStyle, buttonWithColorClass)
		RenderUtils.AppendCssClass(button.PressedStyle, buttonWithColorClass)
		RenderUtils.AppendCssClass(button.DisabledStyle, "dxsc-dat-disabled-btn")
	End Sub

	Protected Overrides Function GetChildControls() As Control()
		Dim controls() As Control = { lblSubject, lblInterval, lblResource, btnDelete, btnEdit }
		Return controls
	End Function
End Class