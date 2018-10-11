function AjaxBusiness() {
    $.extend(this, new ShAjax());
    this.assembly = "MyProfile";
    this.typeAction = "Admin.Modules.OrderProducts.ListOrderProducts";
    this.dodel = function (id, callback) {
        this.get("DeleteRecord", { idRecord: id }, callback);
    }
}
var ajaxBusiness = new AjaxBusiness();

$(document).ready(function () {
    //---DELETE RECORD---
    $("#btnDel").click(function (e) {
        var selectedRows = $('.dataTable tr').filter(':has(:checkbox:checked)').length;
        if (selectedRows < 1) {
            alert("Vui lòng chọn Items muốn xóa!");
        } else {
            if (confirm("Bạn thực sự muốn xóa?")) {
                $('.dataTable tr').filter(':has(:checkbox:checked)').each(function () {
                    var id = $(this).find("td input[type='checkbox']").attr("pid");                    
                    var $this = this;
                    ajaxBusiness.dodel(id, function () {
                        $($this).remove();
                    });
                });
            } else {
                return false;
            }
        }
        e.preventDefault();
    });
});