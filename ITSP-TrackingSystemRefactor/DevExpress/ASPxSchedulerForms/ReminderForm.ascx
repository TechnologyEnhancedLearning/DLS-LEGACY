<%@ Control Language="vb" AutoEventWireup="true" Inherits="ITSP_TrackingSystemRefactor.ReminderForm" Codebehind="ReminderForm.ascx.vb" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web"	TagPrefix="dx" %>

<table class="dxscBorderSpacing" <%= DevExpress.Web.Internal.RenderUtils.GetTableSpacings(Me, 0, 0) %> style="width:100%; padding-bottom:15px;">
    <tr>
        <td> 
            <dx:ASPxLabel ID="lblAppointmentSubject" ClientInstanceName="lblAppointmentSubject" CssClass="dxsc-reminder-form-apt-subject" runat="server">
            </dx:ASPxLabel>
        </td>
    </tr>
    <tr>
        <td style="padding-bottom: 15px;"> 
            <dx:ASPxLabel ID="lblStartTime" runat="server">
            </dx:ASPxLabel>
            <dx:ASPxLabel ID="lblAppointmentStartTime" ClientInstanceName="lblAppointmentStartTime" runat="server">
            </dx:ASPxLabel>
        </td>
    </tr>
    <tr><td> 
		 <dx:ASPxListBox ID="lbItems" runat="server" Width="100%" style="padding-bottom:15px;"></dx:ASPxListBox>
	</td></tr>
</table>
<table class="dxscButtonTable" style="width: 100%" <%= DevExpress.Web.Internal.RenderUtils.GetTableSpacings(Me, 0, 0) %>>
	<tr>
		<td style="width:100%;">
            <dx:ASPxButton ID="btnDismissAll" runat="server" AutoPostBack="false"></dx:ASPxButton>
            <div style="float: right;padding-right:20px;">
                <dx:ASPxButton ID="btnOpenItem" runat="server" Width="80px" AutoPostBack="false"></dx:ASPxButton>
            </div>
		</td>
		<td class="dx-ar" style="width:80px;" <%= DevExpress.Web.Internal.RenderUtils.GetAlignAttributes(Me, "right", Nothing)%>>
            <dx:ASPxButton ID="btnDismiss" runat="server" Width="80px" AutoPostBack="false"></dx:ASPxButton></td>
	</tr>
	<tr>
		<td colspan="2" style="padding:8px 0 4px 0;"><dx:ASPxLabel ID="lblClickSnooze" runat="server"></dx:ASPxLabel></td>
	</tr>
	<tr>
		<td style="width:100%;padding-right:20px;"><dx:ASPxComboBox ID="cbSnooze" runat="server" Width="100%">
		</dx:ASPxComboBox></td>
		<td style="width:80px;"><dx:ASPxButton ID="btnSnooze" runat="server" Width="80px" AutoPostBack="false"></dx:ASPxButton></td>
	</tr>
</table>
<script id="dxss_ASPxSchedulerReminderForm" type="text/javascript">
    ASPxReminderForm = ASPx.CreateClass(ASPxClientFormBase, {
        Initialize: function () {
            this.AttachEvents();
            this.InitDateFormatter();
            this.UpdateAppointmentInfoLabels();
        },
        AttachEvents: function() {
            this.controls.lbItems.SelectedIndexChanged.AddHandler(this.OnItemSelectedIndexChanged.aspxBind(this));
            this.controls.lbItems.Init.AddHandler(this.OnInitListBox.aspxBind(this));
            this.controls.btnOpenItem.Click.AddHandler(this.OnOpenItem.aspxBind(this));
        },
        OnInitListBox: function(s, e) {
            if(s.GetSelectedIndex() < 0 && s.GetVisibleItemCount() > 0) {
                s.SetSelectedIndex(0);
                this.UpdateAppointmentInfoLabels();
            }
        },
        OnItemSelectedIndexChanged: function(s, e) {
            this.UpdateAppointmentInfoLabels();
        },
        OnOpenItem: function(s, e) {
            var formOwner = this.GetFormOwner();
            if(formOwner)
                formOwner.ShowAppointmentFormByClientId(this.controls.lbItems.GetValue());
        },
        UpdateAppointmentInfoLabels: function() {
            var formOwner = this.GetFormOwner();
            if(!formOwner) return;

            var appointment = formOwner.GetAppointmentById(this.controls.lbItems.GetValue());
            var subject = this.getAppointmentSubject(appointment);
            var startTime = this.getAppointmentStartTimeText(appointment);

            lblAppointmentSubject.SetText(subject);
            lblAppointmentStartTime.SetText(startTime);
        },
        getAppointmentSubject: function(appointment) {
            var subject = appointment ? appointment.GetSubject() : "";
            return ASPx.Str.EncodeHtml(subject);
        },
        getAppointmentStartTimeText: function(appointment) {
            return appointment ? this.ToFormat(appointment.GetStart()) : "";
        },
        InitDateFormatter: function() {
            var formOwner = this.GetFormOwner();
            if(formOwner) {
                this.formatter = new ASPx.DateFormatter();
                this.formatter.SetFormatString(this.GetDateTimeFormat(formOwner));
            }
        },
        GetDateTimeFormat: function(formOwner) {
            return formOwner.dateFormatSettings.formatsDateTimeWithYear[0];
        },
        ToFormat: function(date) {
            return this.formatter.Format(date);
        }
    });
</script>