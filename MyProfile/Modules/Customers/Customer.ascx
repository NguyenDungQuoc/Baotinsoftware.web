<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Customer.ascx.cs" Inherits="MyProfile.Modules.Customers.Customer" %>

<asp:HiddenField runat="server" ID="hdf_Style" />
<section id="customer" style="<%= hdf_Style.Value %>">
    <div class="title-box">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2><asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h2>                        
                </div>                    
            </div>                
        </div>
    </div>
    <div class="box-info">
        <div class="container">
            <div class="row box-text">
                <% if (Request.Url.AbsolutePath == "/home.aspx") %>
                <% { %>
                <div class="col-sm-6 col-md-6">                        
                    <asp:Literal runat="server" ID="ltr_Content"></asp:Literal>
                    <p style="text-align:right;">                        
                        <a href="/customer-focus-commitment.html" class="readmore">Read more<i style="padding-left: 5px;" class="fa fa-chevron-right fa-1x"></i></a>     
                    </p>
                </div>
                <div class="col-sm-6 col-md-6">
                    <asp:Image runat="server" ID="img_Photo" CssClass="img-responsive border-image" />
                </div>
                <% } %>
                <% else %>
                <% { %>
                <div class="col-md-12">
                    <%= ltr_Content.Text %>
                </div>
                <% } %>        
            </div>
        </div>
        </div>
</section>
<!-- end customer -->