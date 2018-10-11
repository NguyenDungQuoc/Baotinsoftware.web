<%@ Page Title="Download" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="listdownload.aspx.cs" Inherits="MyProfile.Admin.listdownload" %>
<%@ Register Src="~/Admin/Modules/Download/ListDownload.ascx" TagPrefix="uc1" TagName="ListDownload" %>

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
            <li class="active">List Download</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ListDownload runat="server" id="ListDownload" />
    </section><!-- /.content -->
</asp:Content>
