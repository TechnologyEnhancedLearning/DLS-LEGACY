<%@ Page Async="true" Title="Knowledge Bank" Language="vb" AutoEventWireup="false" MasterPageFile="~/learningportal/lportal.Master" CodeBehind="KnowledgeBank.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.KnowledgeBank" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FeaturedContent" runat="server">
    <link href="../Content/owl.transitions.css" rel="stylesheet" />
    <link href="../Content/owl.carousel.css" rel="stylesheet" />
    <link href="../Content/owl.theme.css" rel="stylesheet" />
    <link href="../Content/jRating.jquery.css" rel="stylesheet" />
    <link href="../Content/jquery.wijmo-open.3.20141.34.css" rel="stylesheet" />
    <link href="../Content/modal.css" rel="stylesheet" />
    <link href="../Content/themes/base/jquery-ui.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-multiselect.css" rel="stylesheet" />
    <style>
        .modal-content {
  width:100%;
}

.modal-dialog-centered {
  display:-webkit-box;
  display:-ms-flexbox;
  display:flex;
  -webkit-box-align:center;
  -ms-flex-align:center;
  align-items:center;
  min-height:calc(100% - (.5rem * 2));
}

@media (min-width: 576px) {
  .modal-dialog-centered {
    min-height:calc(100% - (1.75rem * 2));
  }
}
        /*.modal-dialog {
            width: 99%;
            height: 99%;
            margin: 0;
            padding: 0;
        }

        .modal-content {
            height: auto;
            min-height: 99%;
        }*/
        .multiselect-container li a label.checkbox input[type=checkbox],.multiselect-container li a label.radio input[type=radio] {
            margin-right:10px !important
        }
    </style>
    <script src="../Scripts/bootstrap-multiselect.js"></script>
    <script src="../Scripts/knbank.js"></script>
    <script src="../Scripts/jRating.jquery.min.js"></script>
    <script src="../Scripts/owl.carousel.min.js"></script>
    <script src="../Scripts/jqmodal.js"></script>
    <script src="../Scripts/jquery-ui-1.12.1.min.js"></script>
    <h2>Knowledge Bank</h2>
    <hr />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Standard Modal Message  -->
    <div id="modalViewTut" class="modal fade align-content-center" tabindex="-1" role="dialog" aria-labelledby="lblModalText" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">

                <div class="modal-body">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <div id="modalContent"></div>

                </div>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="dsBrands" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetForCentreKB" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.BrandsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCategories" runat="server"  OldValuesParameterFormatString="original_{0}" SelectMethod="GetForCentreKB" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CourseCategoriesTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsTopics" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveForCentre" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CourseTopicsTableAdapter">
       
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:Parameter Name="IsSuperAdmin" Type="Boolean" DefaultValue="0" />
        </SelectParameters>
       
    </asp:ObjectDataSource>
    <%--<asp:ObjectDataSource ID="dsOfficeVersions" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnerPortalTableAdapters.OfficeVersionsTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsOfficeApps" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnerPortalTableAdapters.OfficeApplicationsTableAdapter"></asp:ObjectDataSource>--%>
    <div class="card card-info">
        <div class="card-header"><a data-toggle="collapse" href="#filterCollapse"><h6 class="text-white">
            What do you need to know? <i aria-hidden="true" class="fas float-right fa-caret-down"></i> </h6>
        </a></div>
        <asp:Panel ID="Panel1" DefaultButton="lbtSearch" runat="server">
            <div class="card-body collapse show form-inline" id="filterCollapse">
                <div class="container" role="form">
                    <div class="form-inline">

                        <dx:BootstrapTextBox ID="bstbSearchString" runat="server" NullText="Search"></dx:BootstrapTextBox>


                   
                        <asp:Label ID="Label3" CssClass="control-label ml-2" runat="server" AssociatedControlID="listBrand" Text="Brand:"></asp:Label>
                        <asp:ListBox ID="listBrand" CssClass="form-control bs-multi" runat="server" SelectionMode="Multiple" DataSourceID="dsBrands" DataTextField="BrandName" DataValueField="BrandID"></asp:ListBox>
                    
                        <asp:Label ID="Label2" CssClass="control-label  ml-2" runat="server" AssociatedControlID="listCategory" Text="Category:"></asp:Label>
                        <asp:ListBox ID="listCategory" CssClass="form-control bs-multi" runat="server" SelectionMode="Multiple" DataSourceID="dsCategories" DataTextField="CategoryName" DataValueField="CourseCategoryID"></asp:ListBox>
                    <asp:Label ID="Label1" CssClass="control-label  ml-2" runat="server" AssociatedControlID="listTopic" Text="Topic:"></asp:Label>
                        <asp:ListBox ID="listTopic" CssClass="form-control bs-multi" runat="server" SelectionMode="Multiple" DataSourceID="dsTopics" DataTextField="CourseTopic" DataValueField="CourseTopicID"></asp:ListBox>

                    <asp:LinkButton CssClass="btn btn-success ml-2" ID="lbtSearch" runat="server"><i class="fas fa-search"></i> Go</asp:LinkButton>
</div>
               </div>
            </div>
        </asp:Panel>
    </div>
    <asp:ObjectDataSource ID="dsSearchResults" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnerPortalTableAdapters.uspSearchKnowledgeBank_V3TableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:SessionParameter Name="CandidateID" SessionField="learnCandidateID" Type="Int32" />
            <asp:Parameter Name="BrandCSV" Type="String" />
            <asp:Parameter Name="CategoryCSV" Type="String" />
            <asp:Parameter Name="TopicCSV" Type="String" />
            <asp:ControlParameter ControlID="bstbSearchString" Name="SearchTerm" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>


    <div class="results">
        <asp:Label ID="lblSearchResultHeader" runat="server" AssociatedControlID="bstbSearchString" Text="Top rated (30+ results)"></asp:Label>
        <div id="ca-container" class="ca-container">

            <asp:Repeater ID="rptTopRated" runat="server" DataSourceID="dsSearchResults">
                <ItemTemplate>
                    <div class="result-item">
                        <div class='<%# (Eval("ShortAppName").ToString + "Na").Substring(0, 2) %> result-box'>
                            <div class="result-container">
                                <div class="ca-item-number">
                                    <%#(Container.ItemIndex + 1)%>.
                                </div>
                                <div class="result-icon">

                                    <asp:Image Visible='<%# Eval("VideoPath").ToString.Length > 0 Or Eval("TutorialPath").ToString.Contains("itspplayer.html") %>' ID="imgVideoThumb" runat="server" ImageUrl=' <%# IIf(Eval("TutorialPath").ToString.Contains("itspplayer.html"), Eval("TutorialPath").ToString.Substring(0, Eval("TutorialPath").ToString.LastIndexOf("/") + 1) + "ccthumb.jpg", IIf(Eval("VideoPath").ToString.Contains("https://www.dls.nhs.uk"), Eval("VideoPath"), "https://www.dls.nhs.uk" + Eval("VideoPath")))%>' Height="120px" Width="160px" />
                                </div>

                                <h6><%#Eval("ShortAppName")%> - 
                                      <%#Eval("TutorialName")%>
                                </h6>

                                <div class="nobull">
                                    <ul>
                                        <li>
                                            <asp:LinkButton Visible=' <%# Eval("VideoPath").ToString.Length > 0 %>' ID="lbtViewVideo" runat="server" CssClass="btn btn-info btn-block"
                                                OnClientClick=' <%#"javascript:playThisVideo (""https://www.dls.nhs.uk" + Eval("VideoPath").ToString.Replace("https://www.dls.nhs.uk", "") + """, """ + Eval("TutorialID").ToString() + """, """ + Eval("CandidateID").ToString() + """, """ + Eval("VidRating").ToString() + """, """ + Eval("Rated").ToString() + """);return false;"%>'
                                                ToolTip='<%# "Rated " + Eval("VidRating").ToString.Replace(".0","") + "/5 (" + Eval("Rated").ToString() + " ratings) " + Eval("VideoCount").ToString() + " views"%>'><i aria-hidden="true" class="fas fa-video mr-1"></i> View video</asp:LinkButton>
                                        </li>
                                        <li>
                                            <asp:LinkButton ID="lbtLaunchTutorial" Visible='<%# Eval("TutorialPath").ToString.Length > 0 %>' runat="server" ToolTip='<%#Eval("Objectives")%>' CommandName="LaunchTut" OnClientClick=' <%#"javascript:playThisTutorial(""" + Eval("TutorialPath").ToString() + """,""" + Eval("CandidateID").ToString() + """,""" + Eval("hEmbedRes").ToString() + """,""" + Eval("vEmbedRes").ToString() + """, """ + Eval("TutorialID").ToString() + """);return false;"%>' CssClass="btn btn-success btn-block"><i aria-hidden="true" class="fas fa-play mr-1"></i> Launch tutorial</asp:LinkButton>
                                        </li>
                                    </ul>
                                </div>

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="result-item" id="divAwol" runat="server">
                <div class=' result-box'>
                    <div class="result-container">
                        <div class="ca-item-number">
                            &nbsp;
                        </div>
                        <div class="result-icon">
                        </div>

                        <h3>Not found what you wanted?
                        </h3>

                        <div class="nobull">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="lbtClearFilters" runat="server" ToolTip="Clear filters and search again" CssClass="ocbutton ClearFilters" CommandName="clearFilters">Clear filters</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="lbtNotHappy" runat="server" ToolTip="Report search results as unsatisfactory. This will help us to improve content tagging for future users." CssClass="ocbutton LogAwol">Report</asp:LinkButton>
                                </li>
                            </ul>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divYouTube" runat="server">
        <h3>YouTube Content</h3>
        <div id="YouSearch" runat="server">
            <p>
                We can use your specified filter and search criteria to search YouTube for relevant
                          content.
            </p>
            <p>
                YouTube content is not solicited by us and we make no representations with
                          regard to the accuracy or appropriateness of any content returned.
            </p>
            <br />
            <asp:LinkButton ID="lbtDoTube" OnClick="btnDoTube_Click" CssClass="btn btn-success" runat="server"> Show unsolicited results from YouTube</asp:LinkButton>
        </div>
        <div id="YouTubeRes" runat="server" visible="false">


            <p>
                You tube search results (search criteria: <b>
                    <asp:Label ID="lblSearchCriteria" runat="server" Text=""></asp:Label></b>)
            </p>
            <div id="ca-container2" class="ca-container">
                <asp:Repeater ID="rptYoutubeRes" runat="server">
                    <ItemTemplate>
                        <div class="result-item">
                            <div class="result-box">
                                <div class="result-container">
                                    <div class="ca-item-number">
                                        <%#(Container.ItemIndex + 1)%>.
                                    </div>
                                    <div class="result-icon">
                                        <a id="aVid1" title='<%#Eval("Description")%>' href="javascript:LogYouTube('<%#Eval("CandidateID")%>', '<%#Eval("VideoId") %>', '<%#Eval("VideoName")%>');">
                                            <img src='<%# Eval("ThumbURL")%>' width="160" height="120" /></a>

                                    </div>

                                    <h6>
                                        <%#Eval("VideoName")%>
                                    </h6>

                                    <div class="nobull">
                                        <ul>
                                            <li>
                                                <a id="a1"  class="btn btn-info btn-block" title='<%#Eval("Description")%>' href="javascript:LogYouTube('<%#Eval("CandidateID")%>', '<%#Eval("VideoId") %>', '<%#Eval("VideoName")%>');"><i aria-hidden="true" class="fas fa-video mr-1"></i> View video
                                                </a>

                                            </li>

                                        </ul>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <p>
                YouTube content is not solicited by us and we make no representations with
                          regard to the accuracy or appropriateness of any content returned.
            </p>
            <asp:Button ID="btnDontTube" runat="server" Text="Hide YouTube results"
                CssClass="btn btn-danger" />
        </div>
    </div>
    
    <script>
        function BindEvents() {
            $(document).ready(function () {
                doCarousel();
                $('.bs-multi').multiselect({
                     buttonClass: 'form-control ml-1',
    templates: { li: '<li class="float-left"><a class="dropdown-item" tabindex="0"><label class="pl-1" style="width: 100%"></label></a></li>' },
                    buttonText: function (options, select) {
                        if (options.length === 0) {
                            return 'Any';
                        }
                        else if (options.length > 3) {
                            return options.length + ' options selected';
                        }
                        else {
                            var labels = [];
                            options.each(function () {
                                if ($(this).attr('label') !== undefined) {
                                    labels.push($(this).attr('label'));
                                }
                                else {
                                    labels.push($(this).html());
                                }
                            });
                            return labels.join(', ') + '';
                        }
                    }
                });
            });
        }

        Sys.Application.add_load(BindEvents);
    </script>
</asp:Content>
