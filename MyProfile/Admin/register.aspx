<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="MyProfile.Admin.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register New Membership</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <!-- bootstrap 3.0.2 -->
    <link href="/Admin/Theme/css/bootstrap.min.css" rel="stylesheet" />
    <!-- font Awesome -->
    <link href="/Admin/Theme/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Theme style -->
    <link href="/Admin/Theme/css/AdminLTE.css" rel="stylesheet" />

    <style type="text/css">
        html,
        body {
            background-color: #222222 !important;
        }
    </style>
</head>
<body>
    <div class="form-box" id="login-box">
        <div class="header" style="font-weight:bold;">Register New Membership</div>
        <form runat="server" method="post">
            <div class="body bg-gray">                
                <div class="form-group">
                    <asp:TextBox ID="txtUsername" autocomplete="off" class="form-control inputUsername" placeholder="Username *" MaxLength="25" runat="server"></asp:TextBox>        
                </div>
                <div class="form-group">                    
                    <asp:TextBox ID="txtPassword" TextMode="Password" class="form-control inputPassword" placeholder="Password *" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rqfPassword" runat="server" ErrorMessage="Password is not null" ControlToValidate="txtPassword" SetFocusOnError="True" Text="*" style="display: none;"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtFullname" autocomplete="off" class="form-control inputFullname" placeholder="Fullname *" runat="server" MaxLength="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rqfFullname" runat="server" ErrorMessage="Fullname is not null" ControlToValidate="txtFullname" SetFocusOnError="True" Text="*" style="display: none;"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">                    
                    <asp:TextBox ID="txtEmail" TextMode="Email" autocomplete="off" class="form-control inputEmail" placeholder="Email *" runat="server" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rqfEmail" runat="server" ErrorMessage="Email is not null" ControlToValidate="txtEmail" SetFocusOnError="True" Text="*" style="display: none;"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblshow" CssClass="error-register" runat="server" Text="" ForeColor="#E21010" Font-Size="12px" Font-Names="Arial"></asp:Label>
                    <asp:ValidationSummary ID="ValidationSummaryRegister" runat="server" ForeColor="Red" HeaderText="Message Box Errors" />
                </div>
            </div>
            <div class="footer">
                <asp:Button ID="btnSignUp" CssClass="btn bg-olive btn-block" runat="server" Text="Sign me up" OnClick="btnSignUp_OnClick" />
                <a href="/Admin/login.aspx" class="text-center">I already have a membership</a>
            </div>
        </form>

        <div class="margin text-center">
            <span style="color: #fff;">Register using social networks</span>
            <br/>
            <button class="btn bg-light-blue btn-circle"><i class="fa fa-facebook"></i></button>
            <button class="btn bg-aqua btn-circle"><i class="fa fa-twitter"></i></button>
            <button class="btn bg-red btn-circle"><i class="fa fa-google-plus"></i></button>
        </div>
    </div>
    <!-- jQuery 2.0.2 -->
    <script src="/Admin/Theme/js/jquery.min2.0.2.js" type="text/javascript"></script>
    <!-- Bootstrap -->
    <script src="/Admin/Theme/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="/Theme/javascript/js_adminUsersRegister.js" type="text/javascript"></script>    
</body>
</html>
