<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgotinfo.aspx.cs" Inherits="MyProfile.Admin.forgotinfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot My Password</title>
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
        <div class="header" style="font-weight:bold;">Forgot Password</div>
        <form runat="server" method="post">
            <div class="body bg-gray">                
                <div class="form-group">
                    <p style="  font-size: 13px; font-family: sans-serif; color: #0081F0;">
                        Vui lòng điền địa chỉ email bạn đã đăng ký, chúng tôi sẽ hỗ trợ bạn lấy lại mật khẩu.
                    </p>
                    <asp:TextBox ID="txtEmail" TextMode="Email" runat="server" CssClass="form-control" autocomplete="off" placeholder="Email Address"></asp:TextBox>
                </div>                
                <div class="form-error" style="display:block;">
                    <asp:Label ID="lblshow" CssClass="error-register" runat="server" Text="" ForeColor="#E21010" Font-Size="12px" Font-Names="Arial"></asp:Label>
                </div>
            </div>
            <div class="footer">                                                               
                <asp:Button ID="btn_SendRequest" CssClass="btn bg-olive btn-block" runat="server" Text="Send request" OnClientClick="return valid_SendRequest();" OnClick="btn_SendRequest_OnClick" />
                <p><a href="/Admin/login.aspx">I want Sign In</a></p>
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
        function valid_SendRequest() {
            var email = $("#<%= txtEmail.ClientID %>");
            if (email.val() === "") {
                $(".error-register").html("<i class='fa fa-cogs'></i> Email is not null. Please enter email");
                email.focus();
                return false;
            } else {
                $(".error-register").html("");
                return true;
            }
        }
    </script>
</body>
</html>
