var fck_content = $("#editor_content").ckeditor();
var fck_subdes = $("#editor_subdescription").ckeditor();

function beforeSubmit() {
    var title = $(".title-Input > input[type='text']");    
    if (title.val() == "") {
        title.focus();
        return false;
    } else {
        return true;
    }
}

function AjaxBusiness() {
    $.extend(this, new ShAjax());
    this.assembly = "MyProfile";
    this.typeAction = "Admin.Modules.News.ListNewsBlogs";
    this.dodel = function (id, callback) {
        this.get("DeleteRecordNews", { idRecord: id }, callback);
    }
    this.doupdate = function (data, callback) {
        this.get("updateRecordNewsType", data, callback);
    }
}
var ajaxBusiness = new AjaxBusiness();
$(document).ready(function () {
    $("#btnDel").click(function (e) {
        var selectedRows = $('.dataTable tr').filter(':has(:checkbox:checked)').length;
        if (selectedRows < 1) {
            alert("Vui lòng chọn Items muốn xóa!");
        } else {
            if (confirm("Bạn thực sự muốn xóa?")) {
                $('.dataTable tr').filter(':has(:checkbox:checked)').each(function () {
                    var id = $(this).find("[id*=hdf_ID]").val();
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
    /*
    ==========UPDATE========
    */    
    $("#btnSaves").click(function (e) {
        if (confirm("Bạn thực sự muốn thực hiện hành động này?")) {
            $('.dataTable tr').find('select').each(function () {
                var idRecord = $(this).parents("tr").find("[id*=hdf_ID]").val();//idRecord
                var idSelected = $(this).find(":selected").val();//idSelect
                if (idRecord != null && idSelected != null) {
                    ajaxBusiness.doupdate({ idItem: idRecord, idGroupNews: idSelected }, function(res) {
                        $(".lbl-alert").text("+ Cập nhật thành công").fadeIn("slow");
                    });
                } else {
                    $(".lbl-alert").text("+ Cập nhật thất bại").fadeIn("slow");
                    return false;
                }
            });
        } else {
            return false;
        }
        e.preventDefault();
    });
});