<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Business.ascx.cs" Inherits="MyProfile.Modules.Business" %>
<%@ Register Src="~/Modules/Platform.ascx" TagPrefix="uc1" TagName="Platform" %>
<%@ Register Src="~/Modules/Membership/MembershipPrivileges.ascx" TagPrefix="uc1" TagName="MembershipPrivileges" %>

<section id="eplatform">
    <div class="title-box">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2>BUSINESS E-PLATFORM & MEMBERSHIP BENEFITS</h2>                        
                </div>                    
            </div>                
        </div>
    </div>
    <div class="box-info">
        <div class="container">
            <div class="row box-text">                
                <asp:Repeater runat="server" ID="rpt_Platform">
                    <ItemTemplate>
                        <div class="col-sm-6 col-md-6">
                            <h6 class="e-title"><%# Eval("Title") %></h6>
                            <%# Eval("News_Sapo") %>
                        </div>
                        <div class="col-sm-6 col-md-6">
                            <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>" title="<%# Eval("Title") %>" class="img-responsive border-image" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="clear"></div>
                <!-- MEMBERSHIP -->
                <div id="membership" class="col-md-12 padding-t20-b20"></div>                
                <asp:Repeater runat="server" ID="rpt_Membership" OnItemDataBound="rpt_Membership_OnItemDataBound">
                    <ItemTemplate>
                        <div class="col-sm-6 col-md-6">
                            <h6 class="e-title"><%# Eval("Title") %></h6>
                            <%# Eval("News_Sapo") %>                            
                            <h6 class="e-title"><asp:Literal runat="server" ID="ltr_Title"></asp:Literal></h6>
                            <asp:Repeater runat="server" ID="rpt_childListGallery">
                                <HeaderTemplate><ul class="list-partners"></HeaderTemplate>
                                <ItemTemplate>
                                    <li>
                                        <img class="img-responsive" src="<%# Eval("Href") %>" title="<%# Eval("Title") %>" alt="<%# Eval("Title") %>" />
                                    </li>
                                </ItemTemplate>
                                <FooterTemplate></ul></FooterTemplate>
                            </asp:Repeater>                            
                        </div>
                        <div class="col-sm-6 col-md-6">
                            <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>" title="<%# Eval("Title") %>" class="img-responsive border-image" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>                                                                                                       
            </div>
        </div>
    </div>
</section>
<!-- end eplatform -->