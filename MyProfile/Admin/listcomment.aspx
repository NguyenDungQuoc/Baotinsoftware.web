<%@ Page Title="Quản lý Bình luận" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="listcomment.aspx.cs" Inherits="MyProfile.Admin.listcomment" %>
<%@ Register Src="~/Admin/Modules/Comment/WucCommentManagement.ascx" TagPrefix="uc1" TagName="WucCommentManagement" %>

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
            <li class="active">Comment</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <uc1:WucCommentManagement runat="server" ID="WucCommentManagement" />
    </section><!-- /.content -->
</asp:Content>
