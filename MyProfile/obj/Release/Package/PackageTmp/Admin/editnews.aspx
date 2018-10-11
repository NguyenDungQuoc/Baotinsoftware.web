<%@ Page Title="Thông tin bài viết - tin tức" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="editnews.aspx.cs" Inherits="MyProfile.Admin.editnews" %>

<%@ Register Src="~/Admin/Modules/News/EditNews.ascx" TagPrefix="uc1" TagName="EditNews" %>

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
            <li class="active">Edit News & Events</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">    
        <uc1:EditNews runat="server" id="EditNews" /> 
    </section><!-- /.content -->
</asp:Content>
