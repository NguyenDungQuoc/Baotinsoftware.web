<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="MyProfile._404" %>
<%@ Import Namespace="MyProfile.Class" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /*=== 404 ===*/
        .head-404 {
            padding-bottom: 30px;
            text-align: center;
        }
        .head-404 h2{
            font-size: 58px;
            margin: 0;
            color: #0986C8;
        }
        .head-404 h4 {
            font-size: 48px;
            color: #FF0000;
            line-height: 58px;
        }
        .head-404 p{
            color: #0c7799;
            font-size: 13px;    
        }
        .head-404 p a{
            text-decoration: none;
            font-size: 22px;
            color: #0986C8;
            display: inline-block;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">        
    <div class="container text-center">
		<div class="logo-404">
			<a href="<%= MyConstant.HomeUrl %>">
			    <asp:Image runat="server" ID="imgLogo"/>
			</a>
		</div>
		<div class="content-404 margin-bottom-30">
			<img src="/Theme/img/404.jpg" class="img-responsive" alt="" />
			<h1><b>OPPS!</b> We Couldn’t Find this Page</h1>
			<p>Uh... So it looks like you brock something. The page you are looking for has up and Vanished.</p>
			<h2><a href="<%= MyConstant.HomeUrl %>">Bring me back Home</a></h2>
		</div>
	</div>
</asp:Content>
