<%@ Control Language="vb" AutoEventWireup="true" Inherits="ITSP_TrackingSystemRefactor.AppointmentToolTip" Codebehind="AppointmentToolTip.ascx.vb" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web"	TagPrefix="dx" %>

<div runat="server" id="buttonDiv">
	<dx:ASPxButton ID="btnShowMenu" runat="server" AutoPostBack="False" AllowFocus="False">
		<Border BorderWidth="0px" />
		<Paddings Padding="0px" />
		<FocusRectPaddings Padding="4px" />
		<FocusRectBorder BorderStyle="None" BorderWidth="0px" />
	</dx:ASPxButton>
</div>    

<script type="text/javascript" id="dxss_ASPxClientAppointmentToolTip">
	ASPxClientAppointmentToolTip = ASPx.CreateClass(ASPxClientToolTipBase, {
		Initialize: function () {
			ASPxClientUtils.AttachEventToElement(this.controls.buttonDiv, "click", ASPx.CreateDelegate(this.OnButtonDivClick, this));
		},
		OnButtonDivClick: function (s, e) {
			this.ShowAppointmentMenu(s);
		},
		CanShowToolTip: function (toolTipData) {
			return this.scheduler.CanShowAppointmentMenu(toolTipData.GetAppointment());
		}
	});    
</script>