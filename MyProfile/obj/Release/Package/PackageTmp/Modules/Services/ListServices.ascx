<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListServices.ascx.cs" Inherits="MyProfile.Modules.Services.ListServices" %>

<asp:Repeater runat="server" ID="rpt_ListServices" OnItemDataBound="rpt_ListServices_OnItemDataBound">
    <HeaderTemplate><section id="news_events"></HeaderTemplate>
    <ItemTemplate>
        <div class="title-box">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h2><%# Eval("Name") %></h2>
					    <%# Eval("Description") %>						
                    </div>                    
                </div>                
            </div>
        </div>
        <div class="box-info">
            <div class="container">
                <div class="row service-box">
				    <div class="col-md-12 col-lg-12 col-sm-12 margin-bottom20">
					    <asp:Literal runat="server" ID="ltr_Content"></asp:Literal>
				    </div>
                    <asp:Repeater runat="server" ID="rpt_ListServiceCategories">
                        <ItemTemplate>
                            <div class="col-sm-4 col-md-4 col-lg-4 service-box-items">
					            <a title="<%# Eval("Name") %>" href="<%# "/" + GetTagGroupServices(Convert.ToInt32(Eval("ParentID"))) + "/" + Eval("Tag") + Eval("ID","-{0}.html") %>">
						            <div class="serviceBox_2">							        
                                        <%# Eval("Image") %>
							            <h3><%# Eval("Name") %></h3>							            
						            </div>
					            </a>
				            </div>
                        </ItemTemplate>
                    </asp:Repeater>                
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("ID") %>' />
    </ItemTemplate>
    <FooterTemplate></section></FooterTemplate>
</asp:Repeater>
