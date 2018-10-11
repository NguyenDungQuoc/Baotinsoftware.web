function AjaxBusiness() {
    $.extend(this, new ShAjax());
    this.assembly = "MyProfile";
    this.typeAction = "Admin.Modules.Banners.BannersSliders";
    this.dodel = function (id, callback) {
        this.get("DeleteRecord", { idRecord: id }, callback);
    }
    this.dobind = function (id, callback) {
        this.get("bindRecordToEdit", { idRecord: id }, callback);
    }
    this.doupdate = function (data, callback) {
        this.get("updateRecordBanners", data, callback);
    }
    this.doinsert = function (data, callback) {
        this.get("insertRecordBanners", data, callback);
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

/*==========EDIT==========*/
var pib = 0; //ID Record
var a = $("#txtTitle");
var b = $("#txtLink");
var c = $(".sh-Input input[type='text']");
var d = $("#txtPosition");
var e = $("#cmb_Active");

$(".callmodal").click(function (e) {
    pib = $(this).attr("pib");
    $("#compose-modal").modal("show");
    $("#btn_Accept").hide();
    $("#btn_Update").show();
    e.preventDefault();
});

$("#btnClick").click(function () {
    pib = 0;
    $("#btn_Update").hide();
    $("#btn_Accept").show();
});

$("#compose-modal").on("shown.bs.modal", function () {
    if (parseInt(pib.toString()) === 0) {
        clearInput();
    } else {
        ajaxBusiness.dobind(pib, function (res) {
            a.val(res.Data.Entity.Title);
            b.val(res.Data.Entity.Href);
            d.val(res.Data.Entity.Position);
            c.val(res.Data.Entity.Image);
            if (res.Data.Entity.Active === true) {
                $("#cmb_Active").val("True");
            } else {
                $("#cmb_Active").val("False");
            }            
        });
    }
});

function clearInput() {
    $(".modal-body").find("input[type='text']").val("");
    d.val("");
    e.val("");
}

/*=========UPDATE RECORD GALLERY========*/
$("#btn_Update").click(function () {        
    if (parseInt(pib.toString()) !== 0 || pib != null) {
        if (c.val() !== "") {
            ajaxBusiness.doupdate({ idItem: pib, title: a.val(), content: "", href: b.val(), image: c.val(), position: d.val(), active: e.val() }, function(res) {
                location.reload();
            });
        } else {
            alert("Vui lòng chọn hình ảnh!");
        }
    }
});
/*=========INSERT NEW RECORD GALLERY========*/
$("#btn_Accept").click(function () {
    if (c.val() !== "") {
        ajaxBusiness.doinsert({ title: a.val(), content: "", href: b.val(), image: c.val(), position: d.val(), active: e.val() }, function (res) {
            alert("Thêm thành công!");
            location.reload();
        });
    } else {
        alert("Vui lòng chọn hình ảnh!");
    }    
});
});