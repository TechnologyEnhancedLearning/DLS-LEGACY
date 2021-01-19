<%@ Page Title="Reset Password" Language="vb" AutoEventWireup="false" MasterPageFile="~/Landing.Master" CodeBehind="reset.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.reset" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function onConfirmPWValidation(s, e) {
            var confirmpw = e.value;
            var pw = $('#bstbPasswordReg_I').val();
            if (confirmpw !== pw) {
                e.isValid = false;
                e.errorText = "Password must match";
            }
        }
    </script>
    <asp:HiddenField ID="hfTemp" runat="server" />
     <div class="ms-hero-page-override ms-hero-img-study ms-bg-fixed ms-hero-bg-dark-light">
        <div class="container">
            <div class="text-center">
                <h1 class="no-m ms-site-title color-white center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">Set Digital Learning Solutions Password</h1>
                <p class="lead lead-lg color-light text-center center-block mt-2 mw-800 text-info fw-300 animated fadeInUp animation-delay-7">
                    <asp:Label ID="lblRegText" runat="server" Text="Use the form below to set the password for delegate and admin accounts associated with your e-mail address."></asp:Label>
                </p>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="card card-primary card-hero animated fadeInUp animation-delay-7">
            <div class="card-body">
                <fieldset>
                            <div class="row">
                               
                                <div class="col-md-6 form-group label-floating">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                        <asp:Label ID="Label4" CssClass="control-label" AssociatedControlID="bstbEmailReg" runat="server" Text="Email"></asp:Label>
                                        <dx:BootstrapTextBox ID="bstbEmailReg" runat="server">
                                            <ValidationSettings ValidationGroup="vgReset">
                                                <RequiredField IsRequired="true" ErrorText="E-mail is required" />
                                                <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                            </ValidationSettings>
                                        </dx:BootstrapTextBox>
                                    </div>
                                </div>
                              </div>
                    <div class="row">
                       <div class="col-md-6 form-group label-floating">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <asp:Label ID="Label12" runat="server" CssClass="control-label" AssociatedControlID="bstbPasswordReg" autocomplete="off" Text="New Password"></asp:Label>
                                        <dx:BootstrapTextBox ClientIDMode="Static" ID="bstbPasswordReg" AutoCompleteType="Disabled" runat="server" Password="True">
                                            <ValidationSettings ValidationGroup="vgReset">
                                                <RequiredField IsRequired="true" ErrorText="Required" />
                                                <RegularExpression ErrorText="Minimum 8 characters with at least 1 letter, 1 number and 1 symbol" ValidationExpression="(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*" />
                                            </ValidationSettings>
                                        </dx:BootstrapTextBox>
                                    </div>
                                </div>

                                <div class="col-md-6 form-group label-floating">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <asp:Label ID="Label19" runat="server" CssClass="control-label" AssociatedControlID="bstbPasswordConfirm" Text="Re-type Password"></asp:Label>
                                        <dx:BootstrapTextBox ClientIDMode="Static" ID="bstbPasswordConfirm" Password="true" runat="server">
                                            <ClientSideEvents Validation="onConfirmPWValidation" />
                                            <ValidationSettings ValidationGroup="vgReset">
                                                <RequiredField IsRequired="true" ErrorText="Required" />
                                            </ValidationSettings>
                                        </dx:BootstrapTextBox>
                                    </div>
                                   
                                </div>
                        </div>
                            <dx:BootstrapButton ID="bsbtnReset" CausesValidation="true" runat="server" SettingsBootstrap-RenderOption="Primary" CssClasses-Control="btn-raised btn-block" AutoPostBack="false" type="submit" Text="Reset Password">
                                <ClientSideEvents Click="function(s, e) { e.processOnServer = ASPxClientEdit.ValidateGroup('vgReset'); }" />
                            </dx:BootstrapButton>
                        </fieldset>
                </div>
            </div>
        </div>

    <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title" id="confirmModalLabel">
                        <asp:Label ID="lblConfirmTitle" runat="server" Text="Changes Saved"></asp:Label></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblConfirmMessage" runat="server" Text="Your changes have been saved successfully."></asp:Label>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="lbtConfirmOK" CssClass="btn btn-primary float-right" PostBackUrl="~/home?action=login" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="updateAllModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title" id="updateAllModalLabel">Update all of your DLS Account Passwords?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblUpdateAll" runat="server"></asp:Label>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="lbtNoUpdateAll" CssClass="btn btn-secondary float-left mr-auto" PostBackUrl="~/home?action=login" runat="server">No</asp:LinkButton>
                    <asp:LinkButton ID="lbtUpdateAll" CssClass="btn btn-success float-right" runat="server">Yes</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
