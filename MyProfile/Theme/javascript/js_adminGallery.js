
/*
==========CALL AJAX===========
*/
function GalleryBusiness() {
    $.extend(this, new ShAjax());
    this.assembly = "MyProfile";
    this.typeAction = "Admin.Modules.Gallery.WebUserControl1";
    this.dodel = function (id, callback) {
        this.get("DeleteRecordGallery", { idGallery: id }, callback);
    }
    this.dobind = function (id, callback) {
        this.get("bindRecordToEdit", { idRecord: id }, callback);
    }
    this.doupdate = function (data, callback) {
        this.get("updateRecordGallery", data, callback);
    }
    this.doinsert = function (data, callback) {
        this.get("insertRecordGallery", data, callback);
    }
}
var galleryBusiness = new GalleryBusiness();

$(document).ready(function () {
/*
==========DELETE RECORD GALLERY===========
*/
    $(".list-gallery .tools .delItems").click(function (e) {
        if (confirm("Bạn thực sự muốn xóa ảnh này?")) {
            var id = $(this).find("[id*=hdf_ID]").val();
            var $this = this;
            galleryBusiness.dodel(id, function () {
                $($this).parents(".li").fadeOut("fast");
            });
        } else {
            return false;
        }
        e.preventDefault();
    });
/*
=========EDIT RECORD GALLERY========
*/
    var pib = 0; //ID Record
    var a = $("#txtName");
    var b = $("#txtContent");
    var c = $(".sh-Input input[type='text']");
    var d = $("#cmb_GroupGallery");
    var e = $("#cmb_Active");

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

    $('#compose-modal').on('shown.bs.modal', function (e) {
        if (parseInt(pib.toString()) == 0) {
            clearInput();
        } else {
            galleryBusiness.dobind(pib, function (res) {
                $("#txtName").val(res.Data.Entity.Title);
                $("#txtContent").val(res.Data.Entity.Content);
                $("#cmb_GroupGallery").val(res.Data.Entity.ID_GroupGallery);
                if (res.Data.Entity.Active == true) {
                    $("#cmb_Active").val("True");
                } else {
                    $("#cmb_Active").val("False");
                }
                $(".sh-Input input[type='text']").val(res.Data.Entity.Href);
            });
        }
    });

    function clearInput() {
        $(".modal-body").find("input[type='text']").val("");
        $("#cmb_Active").val("");
        $("#cmb_GroupGallery").val(0);
    }
/*
=========UPDATE RECORD GALLERY========
*/
    $("#btn_Update").click(function () {        
        if (parseInt(pib.toString()) != 0 || pib != null) {
            if (c.val() != "") {
                if (d.val().toString() != "0") {
                    galleryBusiness.doupdate({ idItem: pib, title: a.val(), content: b.val(), href: c.val(), idGroupGallery: d.val(), active: e.val() }, function(res) {
                        location.reload();
                    });
                } else {
                    alert("Vui lòng chọn một danh mục cụ thể!");
                }
            } else {
                alert("Vui lòng chọn hình ảnh!");
            }
        }
    });
/*
=========INSERT NEW RECORD GALLERY========
*/
    $("#btn_Accept").click(function () {
        if (c.val() != "") {
            if (d.val().toString() != "0") {
                galleryBusiness.doinsert({ title: a.val(), content: b.val(), href: c.val(), idGroupGallery: d.val(), active: e.val() }, function(res) {
                    alert("Thêm thành công!");
                    location.reload();
                });
            } else {
                alert("Vui lòng chọn một danh mục cụ thể!");
            }
        } else {
            alert("Vui lòng chọn hình ảnh!");
        }
    });
});