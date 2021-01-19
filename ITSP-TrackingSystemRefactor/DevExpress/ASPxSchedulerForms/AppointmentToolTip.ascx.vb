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

Partial Public Class AppointmentToolTip
	Inherits ASPxSchedulerToolTipBase
	Public Overrides ReadOnly Property ToolTipShowStem() As Boolean
		Get
			Return False
		End Get
	End Property
	Public Overrides ReadOnly Property ClassName() As String
		Get
			Return "ASPxClientAppointmentToolTip"
		End Get
	End Property

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        'DevExpress.Web.ASPxWebControl.RegisterBaseScript(Page);
	End Sub
	Protected Overrides Sub OnLoad(ByVal e As EventArgs)
		MyBase.OnLoad(e)
		btnShowMenu.Image.Assign(GetSmartTagImage())
	End Sub
	Protected Overrides Function GetChildControls() As Control()
		Dim controls() As Control = { buttonDiv}
		Return controls
	End Function
End Class
