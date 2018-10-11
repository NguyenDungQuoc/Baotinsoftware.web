function AjaxBusiness() {
    $.extend(this, new ShAjax());
    this.assembly = "MyProfile";
    this.typeAction = "Admin.Modules.Services.ListGroupServices";
    this.dodel = function (id, callback) {
        this.get("DeleteRecord", { idRecord: id }, callback);
    }
    this.doinsert = function (data, callback) {
        this.get("insertRecordGroupProducts", data, callback);
    }
    this.dobind = function (id, callback) {
        this.get("bindRecordToEdit", { idRecord: id }, callback);
    }
    this.doupdate = function (data, callback) {
        this.get("updateRecordGroupProducts", data, callback);
    }
    this.dochange = function (data, callback) {
        this.get("updateRecordPosition", data, callback);
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

var pib = 0; //ID Record
var p1 = $("#txtName");
var p2 = $("#txtDescription");
var p3 = $("#txtPosition");
var p4 = $("#cmb_CategoriesParent");
var p5 = $("#cmb_Active");

$(".callmodal").click(function (e) {
    pib = $(this).attr("pib");
    $('#compose-modal').modal('show');
    $("#btn_Accept").hide();
    $("#btn_Update").show();
    e.preventDefault();
});

$("#btnClick").click(function () {
    pib = 0;
    $("#btn_Update").hide();
    $("#btn_Accept").show();
});

//Lock ChildCategories
$("#cmb_CategoriesParent option[prid*='False']").prop('disabled', true);

//---BIND TO EDIT---
$('#compose-modal').on('shown.bs.modal', function (e) {
    if (parseInt(pib.toString()) == 0) {
        clearInput();
    } else {
        ajaxBusiness.dobind(pib, function (res) {
            p1.val(res.Data.Entity.Name);
            p2.val(res.Data.Entity.Description);
            p3.val(res.Data.Entity.Position);
            p4.val(res.Data.Entity.ParentID);
            if (res.Data.Entity.Active == true) {
                p5.val("True");
            } else {
                p5.val("False");
            }
        });
    }
});

function clearInput() {
    $(".modal-body").find("input[type='text']").val("");
    p4.val(0);
    p3.val("");
    p5.val("");
}

//---UPDATE---
$("#btn_Update").click(function () {
    if (parseInt(pib.toString()) != 0 || pib != null) {
        if (p1.val() != "") {
            if (p3.val() != "") {
                ajaxBusiness.doupdate({ idItem: pib, name: p1.val(), position: p3.val(), des: p2.val(), parentID: p4.val(), active: p5.val() }, function (res) {
                    location.reload();
                });
            } else {
                alert("Bạn chưa chọn vị trí cho danh mục!");
            }
        } else {
            alert("Tên danh mục không được bỏ trống!");
        }
    }
});

//---INSERT---
$("#btn_Accept").click(function () {
    if (p1.val() != "") {
        if (p3.val() != "") {
            ajaxBusiness.doinsert({ name: p1.val(), position: p3.val(), des: p2.val(), parentID: p4.val(), active: p5.val() }, function (res) {
                alert("Thêm thành công!");
                location.reload();
            });
        } else {
            alert("Bạn chưa chọn vị trí cho danh mục!");
            p3.focus();
        }
    } else {
        alert("Tên danh mục không được bỏ trống!");
        p1.focus();
    }
});

//---CHANGE POSITION---
$("#btnSaves").click(function (e) {
    if (confirm("Bạn thực sự muốn thực hiện hành động này?")) {
        $('.dataTable tr').find("input[type='number']").each(function () {
            var idRecord = $(this).parents("tr").find("#delRecord").attr("href");//idRecord
            var pValue = $(this).val();//Position value
            if (idRecord != "" && pValue != "") {
                ajaxBusiness.dochange({ idItem: idRecord, position: pValue }, function (res) {
                    $(".lbl-alert").text("+ Cập nhật thành công").fadeIn("slow");
                });
            } else {
                $(".lbl-alert").text("+ Các trường Vị trí không được bỏ trống!").fadeIn("slow");
                return false;
            }
        });
    } else {
        return false;
    }
    e.preventDefault();
});