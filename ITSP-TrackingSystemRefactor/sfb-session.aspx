<%@ Page Language="vb" AutoEventWireup="false" Title="Supervision Session" CodeBehind="sfb-session.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.sfb_session" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="Content/plugins.min.css" rel="stylesheet" />
    <link href="Content/landing.css" rel="stylesheet" />
    <link href="Content/preload.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css">
    <link href="Content/resources.css" rel="stylesheet" />
    <title><%: Page.Title %> - Digital Learning Solutions</title>
</head>
<body>
    <form id="form1" runat="server">
        <style>
            #skypeuicontrols {
               min-height:500px
            }
            .webkit-only {
                display:none
            }
            .webkit-only:not(*:root) {
                display: block
            }
        </style>
        <script src="Scripts/plugins.min.js"></script>
        <script src="Scripts/app.min.js"></script>
        <script src="https://swx.cdn.skype.com/shared/v/1.2.35/SkypeBootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/js-cookie@rc/dist/js.cookie.min.js"></script>
        <script src="Scripts/sfbsession.js"></script>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div id="ms-preload" class="ms-preload">
            <div id="status">
                <div class="spinner">
                    <div class="dot1"></div>
                    <div class="dot2"></div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfAttendees" ClientIDMode="Static" runat="server" />
        <div class="ms-site-container">

            <div class="ms-header ms-header-default">
                <!--ms-header-primary-->
                <div class="container container-full">
                    <div class="ms-title">
                        <a href="home">
                            <!-- <img src="assets/Images/demo/logo-header.png" alt=""> -->
                            <span class="animated zoomInDown animation-delay-5">
                                <img src="Images/DLS-Logo-Colour-sm.png" alt="Digital Learning Solutions Logo" /></span>
                            <h1 class="animated fadeInRight animation-delay-6">
                                <span>Digital Learning</span> Solutions
                            </h1>
                        </a>
                    </div>
                    <div class="float-right clearfix">
                        <img style="padding-top: 10px" src="Images/hee-logo-sm.png" alt="NHS England Logo" />

                    </div>

                </div>
            </div>
            <main id="maincontent">
                <%--Chrome Error--%>
                 <div class="webkit-only bg-danger pt-3 pb-3">
                    <div class="container mt-4">
                        <h1>
                            Please use Microsoft Edge Browser</h1>
                        <p>
                            To join your session, please open this page in the Microsoft Edge browser. Internet Explorer 11 and Firefox are also supported with the Skype for Business plugin. Alternatively, you can join the session in the Skype for Business app using the alternate link provided.
                        </p>
                    </div>
                </div>
                <%--LOGIN--%>
                <div runat="server" class="bg-light pt-4 pb-4 collapse show" tabindex="-1" id="joinskype">
                    <div class="container mt-4">
                        <h1 class="text-center"><small>
                            <asp:Label ID="lbltTitlePrepend" ClientIDMode="Static" runat="server" Text="Join Supervision Session:"></asp:Label>
                        </small>
                            <asp:Label ID="lblSession" ClientIDMode="Static" runat="server" Text="Label"></asp:Label></h1>
                        <div id="signInP" runat="server">
                            <div class="row">
                                <div class="col-sm-12 col-md-9 col-lg-7 mx-auto">
                                    <div class="card my-5">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <i class="fab fa-skype text-info fa-4x"></i>
                                                </div>
                                                <div class="col-md-10">
                                                    <div class="h4 modal-title pt-2">
                                                        Skype for Business Sign-in
                                                    </div>
                                                </div>
                                            </div>

                                            <fieldset role="form">
                                                <div class="form-group pl-5 pr-5 pt-3">
                                                    <label for="tbSFBUsername">NHSmail address:</label>
                                                    <asp:TextBox ID="tbSFBUsername" ClientIDMode="Static" CssClass="form-control" runat="server" ReadOnly></asp:TextBox>
                                                </div>
                                                <div class="form-group pl-5 pr-5">

                                                    <label for="sfbPassword">NHSmail password:</label>
                                                    <input type="password" required="required" class="form-control" id="sfbPassword" readonly />

                                                </div>
                                                <div class="form-group pl-5 pr-5">

                                                    <label for="cbRememberMe">Remember me?</label>
                                                    <input type="checkbox" id="cbRememberMe" />

                                                </div>
                                                <div class="form-group pl-5 pr-5 pb-2">
                                                    <button id="btnSFBSignin" type="button" class="btn btn-lg btn-raised btn-block btn-success">Join Supervision Session</button>
                                                </div>
                                            </fieldset>
                                            <div id="loginerror" class="alert alert-danger collapse collapsed" role="alert">
                                                <strong>Error</strong> There was a problem signing you in. Please try again.
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <%--ERROR--%>
                <div runat="server" class="bg-danger pt-6 pb-6 collapse collapsed" id="skypeerror">
                    <div class="container mt-4">
                        <h1>
                            <asp:Label ID="lblErrorTitle" runat="server" Text="Label"></asp:Label></h1>
                        <p>
                            <asp:Label ID="lblErrorText" runat="server" Text="Label"></asp:Label>
                        </p>
                    </div>
                </div>
              
                <%--SKYPE UI--%>
                <div runat="server" class=" bg-light pt-2 pb-2 collapse collapsed" id="skypeui">
                    <div class="container mt-4">
                        <div class="card">
                            <div class="card-header">
                                <div class="h2 card-title float-left mr-auto">Supervision Session
                                    <br />
                                    <small>
                                        <asp:Label ID="lblUISessionTitle" ClientIDMode="Static" runat="server" Text="Label"></asp:Label>
                                        (<asp:Label ID="lblUISessionStart" ClientIDMode="Static" runat="server" Text="Label"></asp:Label>)</small></div>
                                 <button id="btnSFBSignOut" type="button" class="btn btn-lg btn-raised btn-danger float-right"><i class="fas fa-sign-out-alt"></i> Sign Out</button>
                            </div>
                            <div class="card-body">
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-body">
                                                <div id="skypeuicontrols"></div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                  
                                </div>
                                <asp:Panel ID="pnlFiles" CssClass="row mt-2" runat="server">

                                
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                Session Files
                                            </div>
                                                <asp:ObjectDataSource ID="dsFiles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.FilesDataTableAdapters.FilesTableAdapter">
             <SelectParameters>
                 <asp:SessionParameter Name="LearningLogItemID" SessionField="learnCurrentLogItemID" Type="Int32" />
             </SelectParameters>
         </asp:ObjectDataSource>
         <table class="table table-striped">
                                            <asp:Repeater ID="rptFiles" runat="server" DataSourceID="dsFiles">
                                                <HeaderTemplate>
                                                    <div class="table-responsive">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <asp:HyperLink ID="hlFile" runat="server"
                                                                NavigateUrl='<%# Eval("FileID", "GetFile.aspx?FileID={0}&src=sfbsession")%>' Target="_blank">
                                                                <i id="I1" aria-hidden="true" class='<%# GetIconClass(Eval("FileName"))%>' runat="server"></i>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("FileName")%>'></asp:Label>
                                                            </asp:HyperLink>
                                                        </td>
                                                        <td><asp:Label ID="lblSize" runat="server" Text='<%# NiceBytes(Eval("FileSize"))%>'></asp:Label></td>
                                                        
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate></div></FooterTemplate>
                                            </asp:Repeater>
                                            <tr runat="server" id="trNoFilesAdd" visible="false"><td>
                                                No files have been uploaded against this item.
                                                                                              </td></tr>
                                        </table>
                                            </div>
                                        
                                    </div>
                                  
                                </asp:Panel>
                                <div id="messagearea" class="row mt-2 d-none">
                                      <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header collapse-card" data-toggle="collapse" data-target="#attendeeslist" aria-controls="attendeeslist" aria-expanded="false">
                                                <div class="card-title"><asp:Label ID="lblUIAttendeeCount" ClientIDMode="Static" runat="server" Text="0"></asp:Label>
                                                Invited Attendees <a href="https://www.dls.nhs.uk/tracking/schedule" title="submit outcomes and record attendance" target="_blank" class="btn btn-primary btn-raised float-right" runat="server" id="attendLink">Record Attendance</a></div>
                                            </div>
                                            <div id="attendeeslist" class="card-body collapse collapsed">
                                                <ul id="listAttendees" class="list-group">
                                                </ul>
                                            </div>
                                        </div>


                                    </div>
                                       </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

    </form>
</body>
</html>
