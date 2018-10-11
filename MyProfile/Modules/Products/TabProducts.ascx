<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TabProducts.ascx.cs" Inherits="MyProfile.Modules.Products.TabProducts" %>
<%@ Import Namespace="MyProfile.Services.Web.Images" %>

<div class="category-tab"><!--category-tab-->
	<div class="col-sm-12">		
        <asp:Repeater runat="server" ID="rpt_TabOfCategories">
            <HeaderTemplate><ul class="nav nav-tabs"></HeaderTemplate>   
            <ItemTemplate>
                <li class="<%# Eval("ID_Type").ToString() == "1" ? "active" : "" %>"><a href="#<%# Eval("Tag") %>" data-toggle="tab"><%# Eval("Name") %></a></li>
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
        </asp:Repeater>
	</div>
    <asp:Repeater runat="server" ID="rpt_TabContentOfCategory" OnItemDataBound="rpt_TabContentOfCategory_OnItemDataBound">
        <HeaderTemplate><div class="tab-content"></HeaderTemplate>   
        <ItemTemplate>
            <div class="tab-pane fade <%# Eval("ID_Type").ToString() == "1" ? "active in" : "" %>" id="<%# Eval("Tag") %>" >
                <asp:Repeater runat="server" ID="rpt_ListProductOfTabs">
                    <ItemTemplate>
                        <div class="col-sm-3">
				            <div class="product-image-wrapper">
					            <div class="single-products">
						            <div class="productinfo text-center">
							            <a href="<%# "/san-pham/" + ProductProvider.Get_Url_Category(Convert.ToInt32(Eval("ID_GroupProduct"))) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>" class="click-detail">
						                    <%# PathImage.Inst.GetImageTag(Eval("Image"),270,250,Eval("Name"),"img-responsive") %>
                                        </a>
							            <h2><%# Eval("Price").ToString() == "0" ? "Liên hệ" : Eval("Price","{0: 0,0} VNĐ") %></h2>
							            <p><a href="<%# "/san-pham/" + ProductProvider.Get_Url_Category(Convert.ToInt32(Eval("ID_GroupProduct"))) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>"><%# Eval("Name") %></a></p>
							            <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Đặt mua</a>
						            </div>											
					            </div>
				            </div>
			            </div>
                    </ItemTemplate>
                </asp:Repeater>			    
		    </div>    
            <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("ID_Type") %>'/>                        
        </ItemTemplate>
        <FooterTemplate></div></FooterTemplate>
    </asp:Repeater>	
</div><!--/category-tab-->