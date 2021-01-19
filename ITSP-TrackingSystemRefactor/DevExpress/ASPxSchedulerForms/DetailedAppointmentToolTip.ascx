<%@ Control Language="vb" AutoEventWireup="true" Inherits="ITSP_TrackingSystemRefactor.DetailedAppointmentToolTip" Codebehind="DetailedAppointmentToolTip.ascx.vb" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<div class="dxsc-detailed-apt-tooltip">
    <div class="dxsc-dat-container">
        <div class="dxsc-dat-header">
            <div class="dxsc-selected dxsc-dat-images-container"></div>

            <div class="dxsc-dat-header-text-container">
                <dx:ASPxLabel runat="server" ID="lblInterval" EnableClientSideAPI="true" Font-Size="9pt">
                </dx:ASPxLabel>
            </div>
        </div>

        <div class="dxsc-dat-middle">
            <dx:ASPxLabel runat="server" ID="lblSubject" EnableClientSideAPI="true" Font-Size="12pt">
            </dx:ASPxLabel>
            <div class="dxsc-dat-resource-container">
                <dx:ASPxLabel runat="server" ID="lblResource" EnableClientSideAPI="true" Font-Size="8pt">
                </dx:ASPxLabel>
            </div>

        </div>

        <div class="dxsc-dat-bottom">
            <div class="dxsc-dat-buttons-container">
                <dx:ASPxButton runat="server" ID="btnEdit" EnableClientSideAPI="true" AutoPostBack="false">
                </dx:ASPxButton>
                <dx:ASPxButton runat="server" ID="btnDelete" EnableClientSideAPI="true" AutoPostBack="false">
                </dx:ASPxButton>
            </div>
        </div>

        <div class="dxsc-dat-callout"></div>
    </div>

</div>


<script type="text/javascript" id="dxss_cat">
    // <![CDATA[
    ASPxClientAppointmentDetailedToolTip = ASPx.CreateClass(ASPxClientAppointmentDetailedToolTipBase, {
        Initialize: function () {
            this.controls.btnEdit.Click.AddHandler(ASPx.CreateDelegate(this.OnBtnEditClick, this));
            this.controls.btnDelete.Click.AddHandler(ASPx.CreateDelegate(this.OnBtnDeleteClick, this));
        },
        Update: function (data) {
            this.AdjustButtons();

            var apt = data.GetAppointment();
            this.apt = apt;
            if (!apt.updated) {
                this.scheduler.RefreshClientAppointmentProperties(apt, AppointmentPropertyNames.Normal, this.OnAppointmentRefresh.bind(this));
                this.controls.lblSubject.SetText(this.localization.ASPxSchedulerLocalizer.ToolTip_Loading);
                this.controls.lblResource.SetText("");
            }
            else {
                this.UpdateTooltipInfo(apt);
            }

            var textInterval = this.ConvertIntervalToString(apt.interval);
            this.controls.lblInterval.SetText(textInterval);
        },
        OnAppointmentRefresh: function (apt) {
            apt.updated = true;

            this.UpdateTooltipInfo(apt);

            this.UpdatePosition();
        },
        UpdateTooltipInfo: function (apt) {
            this.controls.lblSubject.SetText(this.GetSubjectText(apt));
            this.controls.lblResource.SetText(ASPx.Str.EncodeHtml(this.GetResourcesText(apt)));

            this.controls.btnEdit.SetEnabled(this.IsEditButtonEnabled(apt));
            this.controls.btnDelete.SetEnabled(apt.flags.allowDelete);

            this.createAppointmentImages();
        },
        IsEditButtonEnabled: function (apt) {
            var isSingleAppoitmentSelected = this.scheduler.GetSelectedAppointmentIds().length === 1;

            return isSingleAppoitmentSelected && apt.flags.allowEdit && this.scheduler.CanShowAppointmentEditForm();
        },
        GetSubjectText: function (apt) {
            var subject = ASPx.Str.EncodeHtml(apt.GetSubject());
            var location = ASPx.Str.EncodeHtml(apt.GetLocation());
            if (location) {
                subject += " (" + location + ")";
            }
            return subject;
        },
        GetResourcesText: function (apt) {
            var resourceNames = apt.GetResources().map(function (resourceId) {
                return this.scheduler.GetResourceName(resourceId);
            }.aspxBind(this));

            return resourceNames.join(", ");
        },
        OnBtnEditClick: function () {
            this.ShowAppointmentForm();
        },
        OnBtnDeleteClick: function () {
            this.DeleteAppointment();
        },
        AdjustButtons: function () {
            window.setTimeout(function () {
                this.controls.btnEdit.AdjustControl();
                this.controls.btnDelete.AdjustControl();
            }.aspxBind(this), 0);
        }
    });
    // ]]> 
</script>
