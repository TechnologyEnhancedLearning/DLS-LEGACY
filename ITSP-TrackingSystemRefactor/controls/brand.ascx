<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="brand.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.brand" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="~/controls/itspbenefits.ascx" TagPrefix="uc1" TagName="itspbenefits" %>


<asp:ObjectDataSource ID="dsAppsForBrand" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.ApplicationsForBrandTableAdapter">
    <SelectParameters>
        <asp:SessionParameter Name="BrandID" SessionField="plBrandID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="dsBrandCategories" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.CourseCategoriesForBrandTableAdapter">
    <SelectParameters>
        <asp:SessionParameter Name="BrandID" SessionField="plBrandID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="dsBrandTopics" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.CourseTopicsForBrandTableAdapter">
    <SelectParameters>
        <asp:SessionParameter Name="BrandID" SessionField="plBrandID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<header class="ms-hero-page-bottom bg-primary">
        <div class="container">
          <div class="row">
            <div class="col col-lg-3 text-center mt-6 order-lg-2">
                <dx:ASPxBinaryImage ID="bimgBrand" Width="100%" CssClass="img-fluid mb-4 animated zoomInRight animation-delay-4" runat="server"></dx:ASPxBinaryImage>
                
            </div>
            <div class="col col-lg-9 hero-img-col order-lg-1">
              <div class="text-center color-white">
                <h1 class="animated zoomInLeft animation-delay-3">
                    <asp:Label ID="lblBrandName" runat="server" Text="Label"></asp:Label></h1>
                <p class="lead lead-xl animated zoomInLeft text-white animation-delay-5">
                    <asp:Label ID="lblBrandDescription" runat="server" Text="Label"></asp:Label></p>
              </div>
              
             
            </div>
          </div>
        </div>
      </header>
<asp:ObjectDataSource ID="dsBrandTutorials" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.TutorialsForBrandTableAdapter">
    <SelectParameters>
        <asp:SessionParameter Name="BrandID" SessionField="plBrandID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
    <asp:Panel ID="pnlBrandTutorials" runat="server" CssClass="wrap ms-hero-img-csbkg ms-hero-bg-dark ms-bg-fixed">
        <script src="../Scripts/cms.js"></script>
        <div class="container">
            <div class="text-center color-white mb-4">
            <h2 class="animated zoomInUp animation-delay-6">Preview Learning Content</h2></div>
        <div class="row">
        <asp:Repeater ID="rptBrandTutorials" runat="server" DataSourceID="dsBrandTutorials">
                <ItemTemplate>
                    <div class='<%# "col-lg-4 col-md-6 animated fadeInLeft animation-delay-" & (7 + (2 * Container.ItemIndex)).ToString()  %>'>
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title"><span class='<%# IIF(Eval("ShortAppName").ToString.Length > 0, "", "d-none") %>'><%#Eval("ShortAppName")%> - </span>
                                      <%#Eval("TutorialName")%></h3>
                    </div>
    <div class="card-body overflow-hidden">
                                <div class="text-center">
                                    <asp:Image Visible='<%# Eval("VideoPath").ToString.Length > 0 Or Eval("TutorialPath").ToString.Contains("itspplayer.html") %>' ID="imgVideoThumb" runat="server" ImageUrl=' <%# IIf(Eval("TutorialPath").ToString.Contains("itspplayer.html"), Eval("TutorialPath").ToString.Substring(0, Eval("TutorialPath").ToString.LastIndexOf("/") + 1) + "ccthumb.jpg", IIf(Eval("VideoPath").ToString.Contains("https://www.dls.nhs.uk"), Eval("VideoPath"), "https://www.dls.nhs.uk" + Eval("VideoPath")))%>' Height="120px" Width="160px" />
                                </div>
        <div class="mt-2 mb-1 text-small">
            <%#Eval("Objectives")%>
        </div>
                                
        <a href=' <%#"javascript:playThisVideo (""https://www.dls.nhs.uk" + Eval("VideoPath").ToString.Replace("https://www.dls.nhs.uk", "") + """);"%>' class='<%# IIf(Eval("VideoPath").ToString.Length > 0, "btn btn-info btn-sm btn-block btn-raised mt-2 no-mb", "d-none") %>'><i aria-hidden="true" class="fas fa-video mr-1"></i> View video</a>
                               
                                            <%--<asp:LinkButton Visible=' <%# Eval("VideoPath").ToString.Length > 0 %>' ID="lbtViewVideo" runat="server" CssClass="btn btn-info btn-sm btn-block btn-raised mt-2 no-mb"
                                                OnClientClick=' <%#"javascript:playThisVideo (""https://www.dls.nhs.uk" + Eval("VideoPath").ToString.Replace("https://www.dls.nhs.uk", "") + ";return false;"%>'><i aria-hidden="true" class="fas fa-video mr-1"></i> View video</asp:LinkButton>--%>
                                      <a href='<%#"javascript:playThisTutorial(""" + Eval("TutorialPath").ToString() + """,""" + Eval("hEmbedRes").ToString() + """,""" + Eval("vEmbedRes").ToString() + """);"%>' class='<%# IIf(Eval("TutorialPath").ToString.Length > 0, "btn btn-success btn-sm btn-block btn-raised mt-2 no-mb", "d-none")%>'><i aria-hidden="true" class="fas fa-play mr-1"></i> Launch tutorial</a>
        <a href='<%#"javascript:openThisPage(""" + Eval("SupportingMatsPath").ToString() + """);"%>' class='<%# IIf(Eval("SupportingMatsPath").ToString.Length > 0, "btn btn-warning btn-sm btn-block btn-raised mt-2 no-mb", "d-none")%>' title="View Supporting Materials"><i aria-hidden="true" class="fas fa-info-circle"></i> Supporting info</a>
                                           <%-- <asp:LinkButton ID="lbtLaunchTutorial" Visible='<%# Eval("TutorialPath").ToString.Length > 0 %>' runat="server" CommandName="LaunchTut" OnClientClick=' <%#"javascript:playThisTutorial(""" + Eval("TutorialPath").ToString() + """,""" + Eval("hEmbedRes").ToString() + """,""" + Eval("vEmbedRes").ToString() + ");return false;"%>' CssClass="btn btn-success btn-sm btn-block btn-raised mt-2 no-mb"><i aria-hidden="true" class="fas fa-play mr-1"></i> Launch tutorial</asp:LinkButton>
                                       --%>
                                </div>

                            </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            </div>
            <p class="text-center color-white">Access to this content does not require login and progress is not tracked.</p>
            </div>
    </asp:Panel>

<div class="container">
    <asp:Panel ID="pnlTabs" runat="server">
        <ul id="myTab" class="nav mt-2 mb-2 nav-tabs nav-tabs-primary indicator-primary nav-tabs-full nav-tabs-2" role="tablist">
            <li class="nav-item">
                <a id="content-tab" aria-controls="home" aria-selected="true" class="nav-link active" data-toggle="tab" href="#home" role="tab">Learning Content</a>
            </li>
            <li class="nav-item">
                <a id="benefits-tab" aria-controls="profile" aria-selected="false" class="nav-link" data-toggle="tab" href="#profile" role="tab">Benefits</a>
            </li>
           
        </ul>
    </asp:Panel>
    <div class="tab-content" id="myTabContent">
    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="content-tab">
        <div class="row mt-2">
          <div class="col col-lg-3">
            <div class="card card-info">
              <div class="card-header">
                <h3 class="card-title color-white">Filter Content</h3>
              </div>
              <div class="card-body">
                <div class="form-horizontal" id="Filters">
                  <h4 class="no-mb">Category</h4>
                  <fieldset>
                    <div class="form-group no-m">
                        <asp:Repeater runat="server" ID="rptBrandCategories" DataSourceID="dsBrandCategories">
                            <ItemTemplate>
<div class="checkbox">
                        <label>
                          <input type="checkbox" value='<%# "." & Eval("CategoryName").ToString.ToLower.Replace(" ", "") %>'> <%# Eval("CategoryName") %> </label>
                      </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                  </fieldset>
                  <fieldset>
                    <h4 class="no-mb mt-1">Topic</h4>
                    <div class="form-group no-m">
                        <asp:Repeater ID="rptBrandTopics" runat="server" DataSourceID="dsBrandTopics">
                            <ItemTemplate>
<div class="checkbox">
                        <label>
                          <input type="checkbox" value='<%# "." & Eval("CourseTopic").ToString.ToLower.Replace(" ", "") %>'> <%# Eval("CourseTopic") %> </label>
                      </div>
                            </ItemTemplate>
                        </asp:Repeater>
                      
                      
                    </div>
                  </fieldset>
                 
                </div>
                <div class="form-horizontal">
                  
                  <h4 class="no-mb mt-1">Sort by</h4>
                  <div class="form-group no-m">
                      <asp:DropDownList CssClass="form-control" aria-label="Choose sort order" ClientIDMode="Static" ID="SortSelect" runat="server">
                          <asp:ListItem Value="title:asc" Text="Title"></asp:ListItem>
                          <asp:ListItem Value="popularity:desc" Text="Popular"></asp:ListItem>
                          <asp:ListItem Value="time:asc" Text="Length (asc)"></asp:ListItem>
                          <asp:ListItem Value="time:desc" Text="Length (desc)"></asp:ListItem>
                          <asp:ListItem Value="date:desc" Text="Recent"></asp:ListItem>
                      </asp:DropDownList>
                   <%-- <select id="SortSelect" aria-label="Choose sort order" class="form-control selectpicker" data-dropup-auto="false">
                        <option value="title:asc">Title</option>
                        <option value="popularity:desc">Popular</option>
                      <option value="time:asc">Length (asc)</option>
                      <option value="time:desc">Length (desc)</option>
                      <option value="date:desc">Recent</option>
                    </select>--%>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col col-lg-9">
            <div class="row" id="Container">
                <asp:Repeater ID="rptBrandApps" runat="server" DataSourceID="dsAppsForBrand">
                    <ItemTemplate>
                         <div class='<%# "col-xl-4 col-md-6 mix " & Eval("Category").ToString.ToLower.Replace(" ", "") & " " & Eval("Topic").ToString.ToLower.Replace(" ", "") %>' data-time='<%# Eval("Mins") %>' data-title='<%# Eval("ApplicationName") %>' data-popularity='<%# Eval("Popularity") %>' data-date='<%# Eval("CreatedDate", "{0:yyyyMMdd}") %>' >
                <div class="card ms-feature">
                    <div class="card-header">
                        <h3 class="card-title"><asp:Label ID="lblCourseTitle" runat="server" Text='<%# Eval("ApplicationName") %>'></asp:Label></h3>
                    </div>
                  <div class="card-body overflow-hidden text-center">
                    
                      <dx:ASPxBinaryImage ID="ASPxBinaryImage1" Value='<%# Eval("CourseImage") %>' Width="100%" EmptyImage-Url="~/Images/nothumb.png" runat="server"></dx:ASPxBinaryImage>
                    
                        <table style="width:100%;text-align:left;font-size:small;font-weight:200;">
                            <tr><td style="text-align:right;padding-right:10px;">Popularity:</td><td style="width:60%">
                                <meter max="1.0" style="width:100%" min="0.0" value='<%# GetPopularity(Eval("Popularity")) %>' high="0.7" low="0.3" optimum="1">
                                    <progress style="width:100%" value='<%# GetPopularity(Eval("Popularity")) %>' max="1"></progress>
                                </meter>

                                                                                                 </td></tr>
                            <tr><td style="text-align:right;padding-right:10px;">Length:</td><td><%# GetTimeString(Eval("Mins")) %></td></tr>
                        </table>
                    
                       
                        
                    <button type="button" class="btn btn-info btn-sm btn-block btn-raised mt-2 no-mb" data-toggle="modal" data-target='<%#"#myModal" & Eval("ApplicationID").ToString %>'>
<i class="fas fa-align-justify"></i> View Course Outline
</button>
                    
                  </div>
                </div>
              </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        
                    </FooterTemplate>
                </asp:Repeater>
             
       
            
            </div>
          </div>
        </div>
        </div>
        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="benefits-tab">
            <uc1:itspbenefits runat="server" ID="itspbenefits" />
        </div>
        </div>
      </div>
<asp:Repeater ID="rptModals" runat="server" DataSourceID="dsAppsForBrand">
    <ItemTemplate>
    <div class="modal" id='<%#"myModal" & Eval("ApplicationID").ToString %>' tabindex="-1" role="dialog" aria-labelledby="lblModalHeading">
        <div class="modal-dialog modal-lg animated zoomIn animated-3x" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h3 class="modal-title color-primary" >
                        <asp:Label ID="lblModalHeading" runat="server" Text='<%# Eval("ApplicationName") & " - Course Outline" %>'></asp:Label></h3><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfApplicationID" Value='<%# Eval("ApplicationID") %>' runat="server" />
<asp:ObjectDataSource ID="dsSections" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.SectionsTableAdapter">
    <SelectParameters>
        <asp:ControlParameter ControlID="hfApplicationID" Name="ApplicationID" PropertyName="Value" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:Repeater ID="rptSections" DataSourceID="dsSections" runat="server">
    <ItemTemplate>   
        <asp:HiddenField ID="hfSectionID" Value='<%# Eval("SectionID") %>' runat="server" />
        <asp:ObjectDataSource ID="dsTutorials" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.TutorialsTableAdapter">
    <SelectParameters>
        <asp:ControlParameter ControlID="hfSectionID" Name="SectionID" PropertyName="Value" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
            <div class="panel panel-info" style="text-align:left;">
    <div class="panel-heading">
                                                                            <h3 class="panel-title"><%#Eval("SectionName")%></h3></div>
<div class="panel-body">
                                                                            <ul>
                                                                                <asp:Repeater ID="rptSections2" DataSourceID="dsTutorials" runat="server">
                                                                                    <ItemTemplate>
                                                                                        <li><%#Eval("TutorialName")%></li>
                                                                                    </ItemTemplate>
                                                                                </asp:Repeater>

                                                                            </ul>
    </div></div>
                                                                       
    </ItemTemplate>
</asp:Repeater>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div></ItemTemplate>
</asp:Repeater>

<!-- Video modal -->
<div id="videoModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lblModalText" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                   
                    <h5 class="modal-title">
                        <asp:Label ID="Label6" runat="server">Video Preview</asp:Label></h5> <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="videodiv embed-responsive embed-responsive-4by3">
</div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>

                </div>
            </div>
        </div>
    </div>
    