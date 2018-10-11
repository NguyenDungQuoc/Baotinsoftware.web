<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Introduction.ascx.cs" Inherits="MyProfile.Modules.Introduction" %>

<div class="introduction row">
    <asp:Repeater ID="rpt_Introduction" runat="server">
        <ItemTemplate>
            <div class="col-md-12">
                <h2 class="title text-center"><%# Eval("Title") %></h2>
            </div>            
            <div class="col-xs-12 col-md-4 text-center">
                <img src="<%# Eval("Image") %>" alt="<%# Eval("Tag") %>" class="border-image" />
            </div>
            <div class="col-xs-12 col-md-8">
                <article class="introduction-article">
                    <%# Eval("News_Sapo") %>                    
                </article>   
                <div class="text-right">
                    <a href="#" id="readMore">Xem thêm <i class="" aria-hidden="true"></i></a>
                </div>             
            </div>
        </ItemTemplate>
    </asp:Repeater>    
</div>