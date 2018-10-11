function AjaxBusiness() {
    $.extend(this, new ShAjax());
    this.assembly = "MyProfile";
    this.typeAction = "Admin.Modules.Comment.WucCommentManagement";
    this.DoInsert = function (data, callback) {
        this.get("InsertComment", data, callback);
    }
}
var ajaxBusiness = new AjaxBusiness();
$(".cmt-reply").click(function (e) {
    var id = $(this).attr("href");
    $("#compose-modal").modal("show");
    $("#btnAccept").attr("name", id);
    e.preventDefault();
});
$("#btnAccept").click(function() {
    var content = $("#ContentPlaceHolder1_WucCommentManagement_TxtReplyContent");
    var arrayImages = [];
    $("#ContentPlaceHolder1_WucCommentManagement_ImagesInputFile_ctl00 .thumbnails li.span2 img").each(function() {
        arrayImages.push($(this).attr("src"));
    });
    if (content.val() === "") {
        alert("Vui lòng nhập nội dung bình luận.");
        content.focus();
    } else if (arrayImages.length > 3) {
        alert("Số ảnh vượt quá quy định. Vui lòng chọn 3 hình ảnh đính kèm.");
    } else {
        var data = { content: content.val(), request: $(this).attr("name"), images: JSON.stringify(arrayImages) };
        ajaxBusiness.DoInsert(data, function (res) {
            if (res.Data.Response.Status === "Success") {
                location.reload();
            } else {
                alert(res.Data.Response.Description);
            }
        });
    }
});