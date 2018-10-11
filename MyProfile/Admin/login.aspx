<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="MyProfile.Admin.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Admin</title>
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
        <div class="header" style="font-weight:bold;">Sign In</div>
        <form runat="server" method="post">
            <div class="body bg-gray">
                <div class="form-group">
                    <asp:TextBox ID="txt_userID" runat="server" CssClass="form-control" autocomplete="off" placeholder="Username" MaxLength="25"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txt_password" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                </div>          
                <div class="form-group">
                    <asp:CheckBox ID="chk_remember_me" runat="server" Text="Remember me" /> 
                </div>
                <div class="form-error" style="display:block;">
                    <asp:Label ID="lblshow" CssClass="error-register" runat="server" Text="" ForeColor="#E21010" Font-Size="12px" Font-Names="Arial"></asp:Label>
                </div>
            </div>
            <div class="footer">                                                               
                <asp:Button ID="btn_Login" CssClass="btn bg-olive btn-block" OnClientClick="return Check_Login();" runat="server" Text="Sign me in" OnClick="btn_Login_Click" />
                <p><a href="/Admin/forgotinfo.aspx">I forgot my password</a></p>
                <a href="/Admin/register.aspx" class="text-center">Register a new membership</a>
            </div>
        </form><!--End form-->
        <div class="margin text-center">
            <span style="color:#fff;">Sign in using social networks</span>
            <br/>
            <button class="btn bg-light-blue btn-circle"><i class="fa fa-facebook"></i></button>
            <button class="btn bg-aqua btn-circle"><i class="fa fa-twitter"></i></button>
            <button class="btn bg-red btn-circle"><i class="fa fa-google-plus"></i></button>
        </div>
    </div><!--End login-box-->

    <!-- jQuery 2.0.2 -->
    <script src="/Admin/Theme/js/jquery.min2.0.2.js" type="text/javascript"></script>
    <!-- Bootstrap -->
    <script src="/Admin/Theme/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Check_Login() {
            var key = $("#<%= txt_userID.ClientID %>");
            var pass = $("#<%= txt_password.ClientID %>");
            var rex = /^[a-zA-Z0-9]([._](?![._])|[a-zA-Z0-9]){4,25}[a-zA-Z0-9]$/;
            if (rex.test(key.val()) == false) {
                $(".error-register").html("<i class='fa fa-cogs'></i> Username invalid. Please enter a different username");
                key.focus();
                return false;
            } else if (pass.val() == "") {
                $(".error-register").html("<i class='fa fa-cogs'></i> Password is not null. Please enter password");
                pass.focus();
                return false;
            } else {
                $(".error-register").html("");
                return true;
            }
        }
    </script>
</body>
</html>
