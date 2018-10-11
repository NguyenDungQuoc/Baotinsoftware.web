/*
==========CALL AJAX===========
*/
function AjaxBusiness() {
    $.extend(this, new ShAjax());
    this.assembly = "MyProfile";
    this.typeAction = "Admin.Modules.Contact.ListContacts";
    this.dodel = function (id, callback) {
        this.get("DeleteRecordContact", { idRecord: id }, callback);
    }
}
var ajaxBusiness = new AjaxBusiness();

$(document).ready(function() {
    $("#btnDel").click(function (e) {
        var selectedRows = $('.dataTable tr').filter(':has(:checkbox:checked)').length;
        if (selectedRows < 1) {
            alert("Vui lòng chọn Items muốn xóa!");
        } else {
            if (confirm("Bạn thực sự muốn xóa?")) {
                $('.dataTable tr').filter(':has(:checkbox:checked)').each(function () {
                    var id = $(this).find("[id*=hdf_ID]").val();
                    var $this = this;
                    ajaxBusiness.dodel(id, function() {
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