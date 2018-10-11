<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Products.ascx.cs" Inherits="MyProfile.Modules.Products.Products" %>
<%@ Import Namespace="MyProfile.Services.Web.Images" %>
<%@ Import Namespace="MyProfile.Class" %>

<div class="features_items row"><!--features_items-->
    <div class="col-md-12">
        <h2 class="title text-center">Sản phẩm</h2>
    </div>		
    <asp:Repeater ID="rptCategory" runat="server" OnItemDataBound="rptCategory_ItemDataBound">
        <ItemTemplate>
            <div class="col-md-12">
                <div class="ribbon-title">
                    <h4><a href="#"><%# Eval("Name") %></a></h4>
                </div>
            </div>
            <asp:Repeater runat="server" ID="rptListProducts">        
                <ItemTemplate>
                    <div class="col-sm-4">
		                <div class="product-image-wrapper">
			                <div class="single-products">
			                    <div class="productinfo text-center">
			                        <a href="<%# Eval("UrlFormat") %>" class="click-detail">
			                            <%# PathImage.Inst.GetImageTag(Eval("Avatar"), 350, 500, Eval("ProductName"), "img-responsive") %>
			                        </a>
			                        <h2 class="hide-item">
			                            <%# Eval("Price") != null && "0".Equals(Eval("Price").ToString()) ? "Liên hệ" : Eval("Price","{0: 0,0} VNĐ") %>
			                        </h2>
			                        <p class="p-price">
			                            <a href="<%# Eval("UrlFormat") %>"><%# Eval("ProductName") %></a>                                
			                        </p>
			                        <a href="<%= MyConstant.ContactUrl %>" class="btn btn-default add-to-cart">
			                            <i class="fa fa-shopping-cart"></i>Liên hệ đặt hàng
			                        </a>
			                    </div>
			                    <%# Eval("Icon") %>                        					    
			                </div>
			                <div class="choose hide-item">
				                <ul class="nav nav-pills nav-justified">
					                <li><a><i class="fa fa-money"></i><%# Eval("CountBuy") %> Người mua</a></li>
					                <li><a><i class="fa fa-eye"></i><%# Eval("CountView") %> Lượt xem</a></li>
				                </ul>
			                </div>
		                </div>
	                </div>
                </ItemTemplate>
            </asp:Repeater>
        </ItemTemplate>
    </asp:Repeater>    
    <%--<div class="col-sm-12 paging_bootstrap">                		
        <asp:Repeater ID="rpt_Pager" runat="server">
            <HeaderTemplate><ul class="pagination"></HeaderTemplate>
            <ItemTemplate>
                <li class="<%# Utility.GetClassDisabledPaging(Convert.ToBoolean(Eval("Enabled"))) + " " + Utility.GetClassActivePaging(PageIndex.ToString(),Eval("Value").ToString())  %>">
                    <a href="<%# "/san-pham/" + p.Get_Url_Category(Convert.ToInt32(Request.Params["id"])) + Eval("Value","/page-{0}.html") %>"><%#Eval("Text") %></a>                                        
                </li>
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
        </asp:Repeater>
    </div>--%>				
</div><!--features_items-->
