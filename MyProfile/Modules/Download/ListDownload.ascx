<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListDownload.ascx.cs" Inherits="MyProfile.Modules.Download.ListDownload" %>
<%@ Register Src="~/Modules/Products/GroupProducts.ascx" TagPrefix="uc1" TagName="GroupProducts" %>
<section>
	<div class="container margin-bottom-50">
		<div class="row">
            <uc1:GroupProducts runat="server" ID="GroupProducts" />
            <div class="col-sm-9">
                <div class="blog-post-area">
					<h2 class="title text-center">Download Tài Liệu</h2>
					<div class="single-blog-post">                        
                        <div class="box-body table-responsive no-padding">                            
                            <table class="table table-hover table-bordered">                                                                
                                <asp:Repeater ID="rpt_DownloadFile" runat="server">
                                    <HeaderTemplate>
                                        <tr style="background: whitesmoke;">
                                            <th class="text-center" style="width: 25px">STT</th>
                                            <th class="text-center">Tên file</th>
                                            <th class="text-center">Mô tả</th>
                                            <th class="text-center" style="width: 90px">Ngày đăng</th>
                                            <th class="text-center" style="width: 80px">Kích thước</th>
                                        </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td class="text-center"><%# Container.ItemIndex + 1 %></td>
                                            <td><a target="_blank" href="<%# Eval("Path") %>" title="<%# Eval("Name") %>"><%# Eval("Name") %></a></td>
                                            <td><%# Eval("Description") %></td>
                                            <td class="text-center"><%# Eval("Date","{0:dd/MM/yyyy}") %></td>
                                            <td class="text-center"><%# Eval("Size") %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>                                
                            </table>
                        </div><!-- /.box-body -->
                        <p><%# rpt_DownloadFile.Items.Count == 0 ? "Đang cập nhật ..." : "" %></p>
					</div>
                </div>
            </div>
		</div>
    </div>
</section>