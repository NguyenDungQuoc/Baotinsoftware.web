<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Skills.ascx.cs" Inherits="MyProfile.Modules.Skills" %>

<%--<!--Skills container-->
<div class="container skills">
    <h2>My Skills</h2>
    <div class="row">
        <div class="span3">
            <div class="ps">
            <h3>Ps</h3>
            </div>
        </div>
        <div class="span5">
            <h3>Photoshop <span>80%</span></h3>
            <div class="expand-bg"> <span class="expand ps2"> &nbsp; </span> </div>
        </div>
    </div>
    <!-- end Ps -->
    <div class="row">
        <div class="span3">
            <div class="ai">
            <h3>Ai</h3>
            </div>
        </div>
        <div class="span5">
            <h3>Illustrator <span>65%</span></h3>
            <div class="expand-bg"> <span class="expand ai2"> &nbsp; </span> </div>
        </div>
    </div>
    <!-- end AI -->
    <div class="row">
        <div class="span3">
            <div class="html">
            <h3>HTML5</h3>
            </div>
        </div>
        <div class="span5">
            <h3>HTML5 <span>75%</span></h3>
            <div class="expand-bg"> <span class="expand html2"> &nbsp; </span> </div>
        </div>
    </div>
    <!-- end html5 -->
    <div class="row">
        <div class="span3">
            <div class="css">
            <h3>CSS3</h3>
            </div>
        </div>
        <div class="span5">
            <h3>CSS3 <span>85%</span></h3>
            <div class="expand-bg"> <span class="expand css2"> &nbsp; </span> </div>
        </div>
    </div>
    <!-- end css -->
    <div class="row">
        <div class="span3">
            <div class="asp">
            <h3>ASP.NET</h3>
            </div>
        </div>
        <div class="span5">
            <h3>ASP.NET <span>90%</span></h3>
            <div class="expand-bg"> <span class="expand asp2"> &nbsp; </span> </div>
        </div>
    </div>
</div>
<!--END: Skills container-->--%>
<div class="site-maps">    
    <div class="wrap">   
        <h1 class="title"><span>Site Maps</span></h1>
        <ul class="maps-parent">
            <li>
                <a href="/trang-chu.html" title="Trang chủ">Trang chủ</a>
            </li>
            <li>
                <a href="/gioi-thieu.html" title="Giới thiệu">Giới thiệu</a>
            </li>
            <li class="dr">
                <a href="/dich-vu.html" title="Dịch vụ">Dịch vụ</a>                            
                <asp:Repeater runat="server" ID="rpt_ListServices">
                    <HeaderTemplate><ul class="maps-child"></HeaderTemplate>
                    <ItemTemplate>
                        <li>
                            <a href="<%# "/"+ MyProfile.Class.NewsBlog.GET_TABLE_GROUP_NEWS_IDGROUP(2).FirstOrDefault().Tag +"/" + Eval("Tag") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>">
                                <%# Eval("Title") %>
                            </a>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate></ul></FooterTemplate>
                </asp:Repeater>
            </li>
            <li class="dr">
                <a href="/tin-tuc.html" title="Tin tức & Sự kiện">Tin tức & Sự kiện</a>
                <asp:Repeater runat="server" ID="rpt_ListNews">
                    <HeaderTemplate><ul class="maps-child"></HeaderTemplate>
                    <ItemTemplate>
                        <li>
                            <a href="<%# "/"+ MyProfile.Class.NewsBlog.GET_TABLE_GROUP_NEWS_IDGROUP(1).FirstOrDefault().Tag +"/" + Eval("Tag") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>">
                                <%# Eval("Title") %>
                            </a>
                        </li>                
                    </ItemTemplate>
                    <FooterTemplate></ul></FooterTemplate>
                </asp:Repeater>        
            </li>
            <li>
                <a href="/doi-tac-khach-hang.html" title="Đối tác & Khách hàng">Đối tác & Khách hàng</a>
            </li>
            <li>
                <a href="/faqs.html" title="FAQs - Câu hỏi thường gặp">FAQs - Câu hỏi thường gặp</a>
            </li>
            <li>
                <a href="/lien-he.html" title="Liên hệ với chúng tôi">Liên hệ với chúng tôi</a>
            </li>
        </ul>
    </div>
</div>

