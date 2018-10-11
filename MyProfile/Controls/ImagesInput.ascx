<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImagesInput.ascx.cs" Inherits="MyProfile.Controls.ImagesInput" %>
<asp:UpdatePanel runat="server">
    <ContentTemplate>
        <ul class="thumbnails" style="margin-bottom:0px">
            <asp:Repeater runat="server" ID="rpData">
                <ItemTemplate>
                    <li class="span2">
                        <div class="thumbnail imip">
                            <asp:Button runat="server" CssClass="btn btn-small btn-primary del" Text="Xóa" ID="btnDel" OnClick="btnDel_Click" />                    
                            <div class="thumbnail" style="overflow:hidden;height:120px">
                                <img alt="<%# Eval("Note") %>" src="<%# Eval("Path") %>">
                                <asp:HiddenField runat="server" ID="hdPathItem" Value='<%# Eval("Path") %>' />
                            </div>
                            <asp:TextBox runat="server" ID="txtTitle" Text='<%# Eval("Note") %>' Width="100%" CssClass="ip-img" autocomplete="off" placeholder="Chú thích"></asp:TextBox>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>

            <li class="span2 tile">
                <asp:Literal runat="server" ID="ltrChoose" />
            </li>
        </ul>
    </ContentTemplate>
</asp:UpdatePanel>

<asp:HiddenField runat="server" ID="hdPath" />
<asp:UpdatePanel runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div style="display:none"><asp:LinkButton runat="server" ID="lnk" OnClick="lnk_Click" /></div>
    </ContentTemplate>
</asp:UpdatePanel>

<style type="text/css">
    .imip { position:relative }
    .imip:hover .del { display:block }
    .imip .del { position:absolute; top:0px; right:0px; display:none }
    .ip-img {
        padding:2px 3px; box-shadow:none; border: 1px solid #dadada; margin-top:4px;
    }
</style>

<script type="text/javascript">
    function MultipleImagesCallback(hdPath, lnk, folder, files) {
        var data = "";
        for (var i = 0; i < files.length; i++) data += folder + files[i] + "@";
        $('#' + hdPath).val(data); __doPostBack(lnk, '');
    }
</script>