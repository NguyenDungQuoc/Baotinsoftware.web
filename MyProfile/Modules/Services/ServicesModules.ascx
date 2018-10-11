<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServicesModules.ascx.cs" Inherits="MyProfile.Modules.Services.ServicesModules" %>

<asp:Repeater runat="server" ID="rpt_ServicesAbout" OnItemDataBound="rpt_ServicesAbout_OnItemDataBound">
    <HeaderTemplate><section id="services"></HeaderTemplate>
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
                <asp:Repeater runat="server" ID="rpt_ServicesDetail">
                    <HeaderTemplate><div class="row box-text"></HeaderTemplate>
                    <ItemTemplate>
                        <div class="col-sm-6 col-md-6">
                            <%# Eval("Sub") %>
					        <p style="text-align:right;">                        
						        <a href="<%# "/" + GetTagGroupServices(Convert.ToInt32(Eval("ID_GroupServices"))) + ".html"  %>" class="readmore">Read more<i style="padding-left: 5px;" class="fa fa-chevron-right fa-1x"></i></a>     
					        </p>
                        </div>
                        <div class="col-sm-6 col-md-6">
                            <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>" class="img-responsive border-image" />
                        </div>
                    </ItemTemplate>
                    <FooterTemplate></div></FooterTemplate>
                </asp:Repeater>                
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("ID") %>' />                
    </ItemTemplate>
    <FooterTemplate></section></FooterTemplate>
</asp:Repeater>
<!-- Services End -->

<asp:Repeater runat="server" ID="rpt_ListServiceOfCategory" OnItemDataBound="rpt_ListServiceOfCategory_OnItemDataBound">
    <ItemTemplate>
        <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("ID") %>' />
        <section class="box-sv">
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
                    <asp:Repeater runat="server" ID="rpt_ChildListSerives">
                        <HeaderTemplate><div class="row box-text"></HeaderTemplate>
                        <ItemTemplate>
                            <div class="col-sm-6 col-md-4 circle-items">
                                <a title="<%# Eval("Title") %>" href="<%# "/our-services/" + GetTagGroupServices(Convert.ToInt32(Eval("ID_GroupServices"))) + "/" + Eval("Tag") + Eval("ID","-{0}.html") %>">
                                    <img class="img-responsive" src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>" />
                                </a>
					            <h3><a title="<%# Eval("Title") %>" href="<%# "/our-services/" + GetTagGroupServices(Convert.ToInt32(Eval("ID_GroupServices"))) + "/" + Eval("Tag") + Eval("ID","-{0}.html") %>"><%# Eval("Title") %></a></h3>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate></div></FooterTemplate>
                    </asp:Repeater>                    
                </div>
            </div>
        </section>
        <!-- end fast -->
    </ItemTemplate>
</asp:Repeater>