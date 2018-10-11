<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GalleriesOfCategories.ascx.cs" Inherits="MyProfile.Modules.Galleries.GalleriesOfCategories" %>

<asp:HiddenField runat="server" ID="hdf_Style" />
<section id="partners" style="<%= hdf_Style.Value %>">
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
            <div class="col-md-12 partners-content">
                <asp:Literal runat="server" ID="ltr_Content"></asp:Literal>
            </div>
            <asp:Repeater ID="rpt_GalleriesOfCategories" runat="server">                
                <ItemTemplate>                    
                    <div class="col-sm-6 col-md-2 partners-items">
                        <div class="image_thumb">
                            <a target="blank" href="<%# Eval("Content") %>" title="<%# Eval("Title") %>">
                                <img src="<%# Eval("Href") %>" alt="<%# Eval("Title") %>" class="img-responsive"/>   
                            </a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>                                
        </div>
    </div>
</div>
</section>
<!-- end partners -->