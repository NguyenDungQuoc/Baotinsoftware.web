<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Contact.ascx.cs" Inherits="MyProfile.Modules.Contact" %>

<div id="contact-page" class="container">
    <div class="bg">
	    <div class="row">    		
	    	<div class="col-md-12">    			   			
				<h2 class="title text-center">Liên hệ với chúng tôi</h2>    			    				    				
				<div id="gmap" class="contact-map">
				    <asp:Literal runat="server" ID="ltrMaps"></asp:Literal>
				</div>
			</div>			 		
		</div>    	
    	<div class="row">
	    	<div class="col-md-8">
	    		<div class="contact-form">
                    <div class="col-md-12">
                        <h2 class="title text-center">Gửi liên hệ</h2>
                    </div>	    			
	    			<div class="status alert alert-success" style="display: none"></div>
				    <form id="main-contact-form" class="contact-form row" name="contact-form" method="post">
				        <div class="form-group col-md-6">
				            <asp:TextBox ID="txtFirstName" CssClass="form-control" MaxLength="25" runat="server" placeholder="Họ *"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rqfFirstName" runat="server" ErrorMessage="Họ không được bỏ trống" ControlToValidate="txtFirstName" SetFocusOnError="True" Text="*" style="display: none;"></asp:RequiredFieldValidator>
				        </div>
				        <div class="form-group col-md-6">
				            <asp:TextBox ID="txtLastName" CssClass="form-control" MaxLength="25" runat="server" placeholder="Tên *"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rqfLastName" runat="server" ErrorMessage="Tên không được bỏ trống" ControlToValidate="txtLastName" SetFocusOnError="True" Text="*" style="display: none;"></asp:RequiredFieldValidator>
				        </div>
                        <div class="form-group col-md-12">
                            <asp:TextBox ID="txtEmail" TextMode="Email" CssClass="form-control" MaxLength="50" runat="server" placeholder="Email *" autocomplete="off"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rqfEmail" runat="server" ErrorMessage="Email không được bỏ trống" ControlToValidate="txtEmail" SetFocusOnError="True" Text="*" style="display: none;"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group col-md-12">
                            <asp:TextBox ID="txtPhone" TextMode="Phone" MaxLength="15" CssClass="form-control" runat="server" placeholder="Điện thoại *" autocomplete="off"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rqfPhone" runat="server" ErrorMessage="Điện thoại không được bỏ trống" ControlToValidate="txtPhone" SetFocusOnError="True" Text="*" style="display: none;"></asp:RequiredFieldValidator>
                        </div>
				        <div class="form-group col-md-12">
				            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" MaxLength="100" placeholder="Tiêu đề" autocomplete="off"></asp:TextBox>
				        </div>
				        <div class="form-group col-md-12">
				            <asp:TextBox ID="txtMessage" TextMode="MultiLine" MaxLength="500" CssClass="form-control message" runat="server" rows="6" placeholder="Nội dung"></asp:TextBox>
				        </div>				        
                        <div class="form-group col-md-12">			                                                                                    
                            <asp:Button ID="btnSendEmail" runat="server" CssClass="btn btn-primary no-margin-top" Text="Gửi liên hệ" OnClick="btnSendEmail_OnClick" />
                            <asp:Literal runat="server" ID="ltrError"></asp:Literal>					        
                        </div>
                        <div class="form-group col-md-12">
                            <asp:ValidationSummary ID="ValidationSummaryContact" runat="server" ForeColor="Red" Font-Size="14px" HeaderText="Thông báo lỗi" CssClass="box-errors" />
                        </div>
				    </form>
	    		</div>
	    	</div>
	    	<div class="col-md-4">
	    		<div class="contact-info nopadding">
	    			<h2 class="title text-center">Thông tin liên hệ</h2>
	    			<address>
	    				<asp:Literal runat="server" ID="ltr_InfoContact"></asp:Literal>
	    			</address>	    			
	    		</div>
    		</div>    			
	    </div>  
    </div>	
</div><!--/#contact-page-->