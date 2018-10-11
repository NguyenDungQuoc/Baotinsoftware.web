<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductOfTypes.ascx.cs" Inherits="MyProfile.Modules.Products.ProductOfTypes" %>
<%@ Import Namespace="MyProfile.Services.Web.Images" %>
<%@ Import Namespace="MyProfile.Class" %>

<div class="features_items"><!--features_items-->
	<h2 class="title text-center">
	    <asp:Literal runat="server" ID="ltr_Title"></asp:Literal>
	</h2>	
    <asp:Repeater runat="server" ID="rpt_ListProducts">        
        <ItemTemplate>
            <div class="col-sm-4">
		        <div class="product-image-wrapper">
			        <div class="single-products">
					    <div class="productinfo text-center">
					        <a href="<%# "/san-pham/" + ProductProvider.Get_Url_Category(Convert.ToInt32(Eval("ID_GroupProduct"))) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>" class="click-detail">
						        <%# PathImage.Inst.GetImageTag(Eval("Image"),270,250,Eval("Name"),"img-responsive") %>
                            </a>
						    <h2>
						        <%# Eval("Price").IsNull() || "0".Equals(Eval("Price").ToString()) ? "Liên hệ" : Eval("Price","{0: 0,0} VNĐ") %>
						    </h2>
						    <p class="p-price">
						        <a href="<%# "/san-pham/" + ProductProvider.Get_Url_Category(Convert.ToInt32(Eval("ID_GroupProduct"))) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>"><%# Eval("Name") %></a>                                
						    </p>
						    <a href="<%= MyConstant.ContactUrl %>" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Liên hệ đặt hàng</a>
					    </div>
                        <%# ProductProvider.Get_Product_Of_Type(Convert.ToInt32(Eval("ID"))) %>                        					    
			        </div>
			        <div class="choose hide-item">
				        <ul class="nav nav-pills nav-justified">
					        <li><a><i class="fa fa-money"></i>10 Người mua</a></li>
					        <li><a><i class="fa fa-eye"></i><%# Eval("CountView") %> Lượt xem</a></li>
				        </ul>
			        </div>
		        </div>
	        </div>
        </ItemTemplate>
    </asp:Repeater>
    <%--<div class="col-sm-12 paging_bootstrap">                		
        <asp:Repeater ID="rpt_Pager" runat="server">
            <HeaderTemplate><ul class="pagination"></HeaderTemplate>
            <ItemTemplate>
                <li class="<%# Utility.GetClassDisabledPaging(Convert.ToBoolean(Eval("Enabled"))) + " " + Utility.GetClassActivePaging(PageIndex.ToString(),Eval("Value").ToString())  %>">
                    <a href="<%# "/san-pham/" + p.Get_Url_Category(Convert.ToInt32(Request.QueryString["id"])) + Eval("Value","/page-{0}.html") %>"><%#Eval("Text") %></a>                                        
                </li>
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
        </asp:Repeater>
    </div>--%>				
</div><!--features_items-->