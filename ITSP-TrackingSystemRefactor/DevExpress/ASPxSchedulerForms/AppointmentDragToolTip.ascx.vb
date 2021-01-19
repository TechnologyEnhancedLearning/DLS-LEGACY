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
Imports DevExpress.Web.ASPxScheduler.Localization

Partial Public Class AppointmentDragToolTip
	Inherits ASPxSchedulerToolTipBase
	Public Overrides ReadOnly Property ClassName() As String
		Get
			Return "ASPxClientAppointmentDragTooltip"
		End Get
	End Property
	Public Overrides ReadOnly Property ToolTipShowStem() As Boolean
		Get
			Return True
		End Get
	End Property

	Protected Overrides Sub OnLoad(ByVal e As EventArgs)
		MyBase.OnLoad(e)
		Localize()
    End Sub
    Protected Overrides Sub PrepareControls(ByVal scheduler As ASPxScheduler)
        lblInfo.ParentSkinOwner = scheduler
        lblInterval.ParentSkinOwner = scheduler
    End Sub
    Private Sub Localize()
        lblInfo.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Caption_OperationToolTip)
    End Sub
    Protected Overrides Function GetChildControls() As Control()
        Dim controls() As Control = {lblInterval}
        Return controls
    End Function
End Class
