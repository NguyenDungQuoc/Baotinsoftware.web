function AjaxBusiness() {
    $.extend(this, new ShAjax());
    this.assembly = "MyProfile";
    this.typeAction = "Admin.Modules.SocialNetwork.SocialLinks";
    this.dodel = function (id, callback) {
        this.get("DeleteRecord", { idRecord: id }, callback);
    }
}
var ajaxBusiness = new AjaxBusiness();

$(document).ready(function () {
    $(".delRecord").click(function (e) {
        if (confirm("Bạn thực sự muốn xóa Items này?")) {
            var id = $(this).attr("href");
            var row = $(this).closest("tr");
            ajaxBusiness.dodel(id, function () {
                row.remove();
            });
        } else {
            return false;
        }
        e.preventDefault();
    });
});