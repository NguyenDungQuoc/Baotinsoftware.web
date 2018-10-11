<%@ Page Title="Danh mục thể loại tin" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="groupnews.aspx.cs" Inherits="MyProfile.Admin.groupnews" %>

<%@ Register Src="~/Admin/Modules/News/ListGroupNews.ascx" TagPrefix="uc1" TagName="ListGroupNews" %>

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
            <li><a href="/Admin/listnews.aspx">News & Events</a></li>
            <li class="active">Group News</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ListGroupNews runat="server" id="ListGroupNews" />
    </section><!-- /.content -->
</asp:Content>
