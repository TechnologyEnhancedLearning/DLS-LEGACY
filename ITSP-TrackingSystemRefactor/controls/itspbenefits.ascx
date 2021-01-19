<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="itspbenefits.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.itspbenefits" %>
<div class="row">
        <div class="col-md-7">
            <h2>Increased productivity</h2>
            <p>There is a clear link between staff increasing their IT skills and increased productivity in the workplace but don't take our word for it... In a survey of 3000 staff, over 90% stated they had increased their productivity in the workplace having undergone IT Training as part of the IT Skills Pathway.</p>
            <h2>Working to a recognised standard</h2>
            <p>How often have you seen a job description that asks for "good IT skills", "sound knowledge of Microsoft Office" or something similar? The trouble is, these tend to be very subjective terms. By implementing the IT Skills Pathway, you can provide your organisation with an objective, measurable standard that is accompanied by customisable assessment and learning tools.</p>
            <h2>Not reinventing the wheel</h2>
            <p>Whilst every organisation has different IT skills requirements, we believe there are certain core skills required by all staff. The IT Skills Pathway "for the Workplace" courses provide you with these core skills and also allows you to customise course content to suit your individual organisational needs. Designing, authoring and hosting your own learning is a time consuming and costly process. The IT Skills Pathway provides you with a system where this hard work has already been done for you - releasing your training staff to concentrate on other projects.</p>
        </div>
        <div class="col-md-5">
            <asp:UpdatePanel ID="upCalculator" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="pnlCalculator" runat="server"
                        BackColor="#FFFFFF" CssClass="card card-default">
                        <div class="card-header">
                            <h4><asp:Label ID="lblCalcTitle" runat="server" Text="Cost Savings Calculator"></asp:Label></h4>
                        </div>
                        <div class="card-body">
                            <div>
                                Use the form below to calculate the likely annual efficiency savings your organisation could achieve by implementing the IT Skills Pathway learning programme.<br />
                              
                            </div>
                            <div class="form-horizontal">
  <div class="form-group row">
                                        <asp:Label ID="lblOrgSize" CssClass="col-8 control-label" runat="server" Text="Staff in organisation:" Font-Bold="True" AssociatedControlID="tbOrgSize"></asp:Label></td>
      <div class="col-4">
                                        <asp:TextBox ID="tbOrgSize" runat="server" Width="50px" TextMode="Number" CssClass="form-control numeric"></asp:TextBox>

      </div>
 </div>
                                 <div class="form-group row">
                                        <asp:Label ID="lblPercentEntry" CssClass="col-8 control-label" runat="server" Text="% needing digital literacy and skills:" Font-Bold="True" AssociatedControlID="tbPercentEntry"></asp:Label></td>
                                     <div class="col-4">
                                        <asp:TextBox ID="tbPercentEntry" runat="server" Width="50px" Text="10" TextMode="Number" CssClass="form-control numeric"></asp:TextBox></div>
 </div>
                                <div class="form-group row">
                                        <asp:Label ID="lblPercentL1" CssClass="col-8 control-label" runat="server" Text="% needing IT for the Workplace:" Font-Bold="True" AssociatedControlID="tbPercentL1"></asp:Label></td>
                                    <div class="col-4">
                                        <asp:TextBox ID="tbPercentL1" runat="server" Width="50px" Text="10" TextMode="Number" CssClass="form-control numeric"></asp:TextBox></div>
                                    </div>
                                
                                
                                <div class="form-group row">
                                        <asp:Label ID="lblAvPayband" CssClass="col-8 control-label" runat="server" Text="Average salary of staff:" Font-Bold="True" AssociatedControlID="ddAvgPayband"></asp:Label></td>
                                    <div class="col-4">
                                        <asp:DropDownList ID="ddAvgPayband" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="£14,000" Value="9.367949"></asp:ListItem>
                                            <asp:ListItem Text="£15,000" Value="10.899359"></asp:ListItem>
                                            <asp:ListItem Text="£17,000" Value="12.068590"></asp:ListItem>
                                            <asp:ListItem Text="£20,000" Value="13.973077"></asp:ListItem>
                                            <asp:ListItem Text="£25,000" Value="17.708333"></asp:ListItem>
                                            <asp:ListItem Text="£30,000" Value="21.916026"></asp:ListItem>
                                            <asp:ListItem Text="£35,000" Value="25.741667"></asp:ListItem>
                                            <asp:ListItem Text="£45,000" Value="29.885256"></asp:ListItem>
                                            <asp:ListItem Text="£50,000" Value="35.862179"></asp:ListItem>
                                            <asp:ListItem Text="£60,000" Value="43.034615"></asp:ListItem>
                                            <asp:ListItem Text="£75,000" Value="51.801282"></asp:ListItem>
                                            <asp:ListItem Text="£90,000" Value="62.485897"></asp:ListItem>
                                        </asp:DropDownList></div>
                                    </div>
                                
                                    <div class="text-center">
                                        <asp:LinkButton ID="btnCalculate" runat="server"
                                            CssClass="btn btn-primary btn-raised" ToolTip="Calculate cost savings">
                   Calculate
                                        </asp:LinkButton>
 </div>
                                <div class="text-center">
                                        <asp:Label ID="lblCalcOutput" runat="server" Text="£ ???" Width="130px" Font-Size="X-Large" Font-Bold="True"></asp:Label>
                                       </div>


      </div>
                        </div>
                        </div>
                          
                    </asp:Panel><script>
                                    Sys.Application.add_load(BindEvents);
     </script>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

    </div>