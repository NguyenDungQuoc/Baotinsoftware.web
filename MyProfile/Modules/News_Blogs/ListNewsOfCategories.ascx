<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListNewsOfCategories.ascx.cs" Inherits="MyProfile.Modules.News_Blogs.ListNewsOfCategories" %>

<div class="col-xs-12 col-md-4 col-lg-4 col-sm-4">
	<div class="col-md-12">		
        <asp:Repeater runat="server" ID="rpt_ListNewsCategories" OnItemDataBound="rpt_ListNewsCategories_OnItemDataBound">
            <HeaderTemplate><div class="box-widget"></HeaderTemplate>
            <ItemTemplate>
                <div class="widget_title">
				    <h4><span><%# Eval("Name") %></span></h4>
			    </div>
                <asp:Repeater runat="server" ID="rpt_ChildCategories">
                    <HeaderTemplate><ul class="arrows-list-category"></HeaderTemplate>
                    <ItemTemplate>
                        <li class="<%# Eval("ID").ToString() == Request.Params["id"].Trim() ? "active" : ""  %>">
                            <a href="<%# "/" + Eval("Tag") + Eval("ID","-{0}.html") %>"> <%# Eval("Name") %></a>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate></ul></FooterTemplate>
                </asp:Repeater>
                <asp:HiddenField ID="hdfID" runat="server" Value='<%# Eval("ID") %>'/>
            </ItemTemplate>
            <FooterTemplate></div></FooterTemplate>
        </asp:Repeater>
	</div>						
</div>