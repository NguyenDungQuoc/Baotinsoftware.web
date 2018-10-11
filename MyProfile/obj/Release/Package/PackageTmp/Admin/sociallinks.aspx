<%@ Page Title="Quản lý mạng xã hội - Fan page" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="sociallinks.aspx.cs" Inherits="MyProfile.sociallinks" %>

<%@ Register Src="~/Admin/Modules/SocialNetwork/SocialLinks.ascx" TagPrefix="uc1" TagName="SocialLinks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Administration
            <small>Control panel</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="/Admin/home.aspx"><i class="fa fa-dashboard"></i> Dashboard</a></li>            
            <li class="active">Social Network</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:SocialLinks runat="server" id="SocialLinks" />
    </section><!-- /.content -->
</asp:Content>
