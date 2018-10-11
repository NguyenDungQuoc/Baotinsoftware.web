<%@ Page Title="Quản lý Hashtags" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="hashtag.aspx.cs" Inherits="MyProfile.Admin.hashtag" %>

<%@ Register Src="~/Admin/Modules/Hashtag/WucHashtag.ascx" TagPrefix="uc1" TagName="WucHashtag" %>

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
            <li class="active">List Hashtags</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <uc1:WucHashtag runat="server" id="WucHashtag" />
    </section><!-- /.content -->
</asp:Content>
