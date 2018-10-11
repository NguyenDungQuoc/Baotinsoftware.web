var fck_content = $("#editor_content").ckeditor();
var fck_subdes = $("#editor_subdescription").ckeditor();

/*---GROUP PRODUCTS---*/
function AjaxBusiness() {
    $.extend(this, new ShAjax());
    this.assembly = "MyProfile";
    this.typeAction = "Admin.Modules.Products.ListProducts";
    this.dodel = function (id, callback) {
        this.get("DeleteRecord", { idRecord: id }, callback);
    }
    this.dochange = function (data, callback) {
        this.get("updateRecordProducts", data, callback);
    }
}
var ajaxBusiness = new AjaxBusiness();

$(document).ready(function () {
    //---DELETE RECORD---
    $("#btnDel").click(function (e) {
        var selectedRows = $(".dataTable tr").filter(":has(:checkbox:checked)").length;
        if (selectedRows < 1) {
            alert("Vui lòng chọn Items muốn xóa!");
        } else {
            if (confirm("Bạn thực sự muốn xóa?")) {
                $(".dataTable tr").filter(":has(:checkbox:checked)").each(function () {
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

    //---CHANGE POSITION---
    $("#btnSaves").click(function (e) {
        if (confirm("Bạn thực sự muốn thực hiện hành động này?")) {
            $(".dataTable tr").find("input[type='text']").each(function () {
                var idRecord = $(this).parents("tr").find("td input[type='checkbox']").attr("pid");//idRecord
                var prValue = $(this).val();//Price value
                var sValue = $(this).parents("tr").find("td .ddlStatus option:selected").val();                
                if (idRecord !== "" && prValue !== "") {
                    ajaxBusiness.dochange({ idItem: idRecord, valuePrice: prValue, valueStatus: sValue }, function (res) {
                        $(".lbl-alert").text("+ Cập nhật thành công").fadeIn("slow");
                    });
                } else {
                    $(".lbl-alert").text("+ Giá bán không được bỏ trống!").fadeIn("slow");
                    return false;
                }
            });
        } else {
            return false;
        }
        e.preventDefault();
    });        

    // Call AutoNumeric Currency
    $(".auto").autoNumeric("init", { aPad: false });
    // Textbox Size Price    
    $(".chk-enable label").click(function () {        
        var txtPrice = $(this).parents(".chk-enable").find("input[type='text']");        
        if ($(this).parent("span").find(".icheckbox_minimal").hasClass("checked")) {            
            txtPrice.attr("disabled", true);            
        } else {                        
            txtPrice.removeAttr("disabled");
            txtPrice.val("");
        }
    });
});

function beforeSubmit() {    
    var name = $('.title-Input input[type="text"]');
    //var price = $(".auto");
    if (name.val() === "") {
        alert("Vui lòng nhập tên Sản phẩm");
        name.focus();
        return false;
    } /*else if (price.val() === "") {
        alert("Vui lòng nhập giá bán cho sản phẩm");
        price.focus();
        return false;
    } else if (price.val() < 0) {
        alert("Giá bán không thể bé hơn 0");
        price.focus();
        return false;
    }*/ else {
        return true;
    }
}

$(".js-example-basic-multiple").select2({
    tags: "true",
    placeholder: "Chọn từ khóa (Hashtag)",
    allowClear: true
});