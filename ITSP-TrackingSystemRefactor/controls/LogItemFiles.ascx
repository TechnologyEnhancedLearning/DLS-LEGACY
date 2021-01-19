<div class="card card-itsp-blue">
    <div class="card-header">
        <h5>Upload Evidence Files <small>Log item: <asp:Label ID="lblLogItemName" runat="server" Text="Label"></asp:Label></small></h5>
    </div>
    <div class="panel panel-default">
                                        <asp:ObjectDataSource ID="dsFiles" runat="server">
                                <SelectParameters>
                                    <asp:Parameter Name="LearningLogItemID" DefaultValue="0" Type="Int32" />
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
                                                                NavigateUrl='<%# Eval("FileID", "GetFile.aspx?FileID={0}")%>'>
                                                                <i id="I1" aria-hidden="true" class='<%# Eval("Type")%>' runat="server"></i>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("FileName")%>'></asp:Label>
                                                            </asp:HyperLink>
                                                        </td>
                                                        <td style="width: 20px">
                                                            <asp:LinkButton ID="lbtDelete" OnClientClick="return confirm('Are you sure you want delete this file?');" runat="server" CommandName="Delete" CommandArgument='<%# Eval("FileID")%>' CssClass="btn btn-danger btn-xs" ToolTip="Delete File" CausesValidation="false"><i aria-hidden="true" class="icon-minus"></i><!--[if lt IE 8]>Delete<![endif]--></asp:LinkButton></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate></div></FooterTemplate>
                                            </asp:Repeater>
                                            <tr runat="server" id="trNoFilesAdd" visible="false"><td>
                                                No files have been uploaded.
                                                                                              </td></tr>
                                        </table>
                                    </div>
</div>