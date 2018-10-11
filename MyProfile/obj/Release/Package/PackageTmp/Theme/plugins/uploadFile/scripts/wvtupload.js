/*
-- =============================================
-- Author:		NAM-NT 0939203910
-- Create date: 2017/03/28
-- Revision:
-- 2017/12/03 - NAM-NT : Update for site baotinsoftware 
-- Description:	UploadMultiFile with base64
-- =============================================
*/
$.fn.wvtupload = function (parameters) {
    var instanceId = $(this).attr("id");
    var isIE7 = false; 
    var isInit = true;
    var defaults = $.extend({
        theme: "default-theme",
        pluginFolder: "/Theme/Plugins/uploadFile/images/",
        fileSize: 1,        //Dung lượng file: 1 Mb (Tương ứng số Megabyte)
        serverThumb: "",    //Đây là Kho lưu ảnh khi thực hiện Upload ảnh.
        serverUpload: "",   //Đây là Assembly chứa đối tượng có phương thức ajax.
        maxFiles: 3,        //Số lượng file tối đa
        itemWidth: 100,
        itemHeight: 90,
        rotateActionName: "rotate/",
        rotate90ActionName: "rotate/90/",
        rotate180ActionName: "rotate/180/",
        rotate270ActionName: "rotate/270/"
    }, parameters);
    var initOpenFileBrowser = function () {
        $("#" + instanceId + " .upload-item").unbind("click");
        $("#" + instanceId + " .working-upload-item").click(function () {
            $("#" + instanceId + " .fileUpload").click();
        });
    }
    var initActionImage = function () {
        //tạo sự kiện xóa và xoay
        $("#" + instanceId + " .upload-item .upload-item-delete").unbind("click");
        $("#" + instanceId + " .upload-item .upload-item-delete").click(function () {
            if (confirm("Bạn có chắc chắn muốn xoá ảnh này ?")) {
                var image = $(this).parent().attr("rel");
                var listImage = removeImage2List($("#" + parameters.target).val(), image);
                $("#" + parameters.target).val(listImage);
                $(this).parent().remove();
                if (!isIE7) {
                    //nếu xóa xong mà chưa có cái nào để upload thì phải show ra 1 cái
                    if ($("#" + instanceId + " .working-upload-item").length === 0) {
                        $("#" + instanceId).append(uploadItemTemplate);
                        initOpenFileBrowser();
                    }
                }
                else {
                    //nếu xóa xong mà chưa có cái nào để upload thì phải show ra 1 cái
                    if ($("#" + instanceId + " .working-upload-item").length === 0) {
                        $("#" + instanceId).append(uploadItemTemplateIE7);
                        createEvenForControlIE7();
                    }
                }
            }
        });
        $("#" + instanceId + " .upload-item .upload-item-rotate").unbind("click");
        $("#" + instanceId + " .upload-item .upload-item-rotate").click(function () {
            var image = $(this).parent().attr("rel");
            var newimage = "";
            if (image.indexOf(defaults.rotateActionName) === -1) newimage = defaults.rotate90ActionName + image;
            else if (image.indexOf(defaults.rotate90ActionName) !== -1) newimage = defaults.rotate180ActionName + image.replace(defaults.rotate90ActionName, "");
            else if (image.indexOf(defaults.rotate180ActionName) !== -1) newimage = defaults.rotate270ActionName + image.replace(defaults.rotate180ActionName, "");
            else if (image.indexOf(defaults.rotate270ActionName) !== -1) newimage = image.replace(defaults.rotate270ActionName, "");
            var listImage = replaceImage2List($("#" + parameters.target).val(), image, newimage);
            $("#" + parameters.target).val(listImage);
            if (!isIE7) {
                $(this).parent().attr("style", "background:url('" + defaults.serverThumb + "/" + newimage + "')  no-repeat scroll 0% 0% / " + defaults.itemWidth + "px " + defaults.itemHeight + "px transparent;");
                $(this).parent().attr("rel", newimage); //dùng làm data cho sự kiện xóa và xoay
            }
            else {
                $(this).parent().find(".background").remove();
                $(this).parent().append('<img class="background" src="' + defaults.serverThumb + "/" + newimage + '"/>');
                $(this).parent().attr("rel", newimage); //dùng làm data cho sự kiện xóa và xoay
            }
        });
    }
    var wvtuploadfinish = function (imageUrl) {
        //khi post data xong trả về đường dẫn ảnh và đẩy nó vào div hiển thị
        $("#" + instanceId + " .working-upload-item").removeClass("upload-item-loading");
        if (imageUrl.indexOf("namnt") !== -1 || imageUrl.indexOf("thumb") !== -1) { // Check file ảnh theo cách upload cũ hay mới
            //$('#' + instanceID + ' .working-upload-item').attr('style', 'background:url(\'' + imageURL + '\')  no-repeat scroll 0% 0% / ' + defaults.itemWidth + 'px ' + defaults.itemHeight + 'px transparent;');
            $("#" + instanceId + " .working-upload-item").attr("style", "background-image:url('" + imageUrl + "');  background-size: cover;");
        }
        else // Cách upload mới chỉ có cấu trúc resize, không có crop hoặc thumb
        { $("#" + instanceId + " .working-upload-item").attr("style", "background:url('" + defaults.serverThumb + "/" + imageUrl + "')  no-repeat scroll 0% 0% / " + defaults.itemWidth + "px " + defaults.itemHeight + "px transparent;"); }
        $("#" + instanceId + " .working-upload-item").attr("rel", imageUrl); //dùng làm data cho sự kiện xóa và xoay
        $("#" + instanceId + " .working-upload-item").append(actionItemTemplate); //thêm 2 nút xóa và xoay

        $("#" + instanceId + " .working-upload-item").removeClass("working-upload-item").after(uploadItemTemplate);//chuyển box upload hiện thời thành box upload mới
        initOpenFileBrowser(); //tạo sự kiện mở file

        initActionImage();//thêm sự kiện cho 2 nút xóa và xoay
    }
    var wvtuploadfinishIE7 = function (imageUrl) {
        //khi post data xong trả về đường dẫn ảnh và đẩy nó vào div hiển thị
        $("#" + instanceId + " .working-upload-item").removeClass("upload-item-loading");
        $("#postiframe").remove();
        $("#theuploadform").remove();
        $("#" + instanceId + " .working-upload-item").append('<img class="background" src="' + defaults.serverThumb + "/" + imageUrl + '"/>');
        $("#" + instanceId + " .working-upload-item").attr("rel", imageUrl);//dùng làm data cho sự kiện xóa và xoay
        $("#" + instanceId + " .working-upload-item").append(actionItemTemplate);//thêm 2 nút xóa và xoay
        $("#" + instanceId + " .working-upload-item").removeClass("working-upload-item").after(uploadItemTemplateIE7);//chuyển box upload hiện thời thành box upload mới

        createEvenForControlIE7(); //tạo control fileupload chèn vào div

        initActionImage();//thêm sự kiện cho 2 nút xóa và xoay
    }
    var validateImage = function (file) {
        //check size
        if (file.size > eval(defaults.fileSize * 1024 * 1024)) return "Kích thước ảnh quá lớn. Dung lượng ảnh phải nhỏ hơn " + defaults.fileSize + " Mb";
        //check type
        var ext = file.name.split(".").pop().toLowerCase();
        if ($.inArray(ext, ["gif", "png", "jpg", "jpeg"]) === -1) {
            return "Không đúng định dạng ảnh cho phép (gif, png, jpg, jpeg)";
        }
        return "";
    }
    var successPost = function (imgUrl) {
        var listImage = "";
        wvtuploadfinish(imgUrl);
        listImage = addImage2List($("#" + parameters.target).val(), imgUrl);
        $("#" + parameters.target).val(listImage);
    }
    var successPostIE7 = function (imgUrl) {
        var listImage = "";
        wvtuploadfinishIE7(imgUrl);
        listImage = addImage2List($("#" + parameters.target).val(), imgUrl);
        $("#" + parameters.target).val(listImage);
    }
    var createEvenForControlIE7 = function () {
        isInit = true;//do cái postiframe khi được append sẽ gọi load luôn. lên lần đầu chưa có gì để thực thi phải dùng cờ này để cản lại
        $("#fileToUpload").on("change", function () {
            //sau khi chọn file xong thì submit form
            $("#theuploadform").submit();
        });
        $("#postiframe").load(function () {
            //lần đầu mà đang khởi tạo sẽ không vào
            //chạy lần đâu xong thì chuyển init thành false đề lần sau chọn file là vào
            if (!isInit) {
                var imgUrl = this.contentWindow.document.body.innerHTML.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");
                if (imgUrl === "error") {
                    alert("Có lỗi xảy ra, xin bạn vui lòng upload lại ảnh");
                    return;
                }
                successPostIE7(imgUrl);
                if (isNumberOfImageOverload()) {
                    //nếu số lượng ảnh đã load đủ vào các item, thì không cần thêm cái upload nữa.
                    $("#" + instanceId + " .working-upload-item").remove();
                }
            }
            else {
                isInit = false;
            }
        });
    }
    var isNumberOfImageOverload = function () {
        //kiểm tra số lượng ảnh trong trường hợp chọn nhiều ảnh hơn được phép
        var arrListImage = $("#" + parameters.target).val() === "" ? "" : $("#" + parameters.target).val().split(",");
        if (arrListImage.length >= defaults.maxFiles) {
            return true;
        }
        return false;
    }
    //init
    $("#" + instanceId).addClass(defaults.theme);
    //var controlItemUpload = '<input multiple class="fileUpload" type="file" style="display:none" name="userfile"/>'; //Cho phép Upload nhiều file
    var controlItemUpload = '<input class="fileUpload" type="file" style="display:none" name="userfile"/>'; //Mỗi 1 lượt chỉ Upload 1 file
    var uploadItemTemplate = '<div class="upload-item working-upload-item"></div>';
    var uploadItemTemplateIE7 = '<div class="upload-item working-upload-item"><iframe name="postiframe" id="postiframe" style="display: none"></iframe><form id="theuploadform" action="/UploadHandler.ashx" method="post" encoding="multipart/form-data" enctype="multipart/form-data" target="postiframe"><input multiple class="fileuploadie7" type="file" id="fileToUpload" name="userfile"/></form></div>';
    var actionItemTemplate = '<a href="javascript:void(0)" class="upload-item-delete"><img src="' + defaults.pluginFolder + 'blank.gif"/></a>';
    //<a href="javascript:void(0)" class="upload-item-rotate"><img src="' + defaults.pluginFolder + '/images/blank.gif"/></a> <-- Tạm thời không cho rotate
    if (!isIE7) {
        $(this).append(controlItemUpload);
        $(this).append(uploadItemTemplate);
        if ($("#" + parameters.target).val() !== "") {
            //nếu là postback, đã có up ảnh từ lần trước        
            var arrListImage = $("#" + parameters.target).val() === "" ? "" : $("#" + parameters.target).val().split(",");
            for (var i = 0; i < arrListImage.length; i++) {
                wvtuploadfinish(arrListImage[i]);
            }
            //nếu số lượng ảnh đã load đủ vào các item, thì không cần thêm cái upload nữa, xẩy ra khi số lượng ảnh đã post back đúng bằng qouta
            if (isNumberOfImageOverload()) {
                $("#" + instanceId + " .working-upload-item").remove();
            }
        }
        else {
            initOpenFileBrowser();
        }
    }
    else {
        $(this).append(uploadItemTemplateIE7);
        if ($("#" + parameters.target).val() !== "") {
            //nếu là postback, đã có up ảnh từ lần trước        
            var arrListImage = $("#" + parameters.target).val() === "" ? "" : $("#" + parameters.target).val().split(",");
            for (var i = 0; i < arrListImage.length; i++) {
                wvtuploadfinishIE7(arrListImage[i]);
            }
            //nếu số lượng ảnh đã load đủ vào các item, thì không cần thêm cái upload nữa, xẩy ra khi số lượng ảnh đã post back đúng bằng qouta
            if (isNumberOfImageOverload()) {
                $("#" + instanceId + " .working-upload-item").remove();
            }
        }
        else {
            createEvenForControlIE7();
        }
    }

    //Endinit
    var addImage2List = function (list, newimage) {
        if (list === "") return newimage;
        var arrListImage = list.split(",");
        for (var i = 0; i < arrListImage.length; i++) {
            if (newimage === arrListImage[i]) return list;
        }
        return list + "," + newimage;
    }
    var removeImage2List = function (list, currentimage) {
        if (list === "") return "";
        var arrListImage = list.split(",");
        var newlist = "";
        for (var i = 0; i < arrListImage.length; i++) {
            if (currentimage !== arrListImage[i]) newlist += (newlist !== "" ? "," : "") + arrListImage[i];
        }
        return newlist.trim();
    }
    var replaceImage2List = function (list, currentimage, newimage) {
        if (list === "") return "";
        var arrListImage = list.split(",");
        var newlist = "";
        for (var i = 0; i < arrListImage.length; i++) {
            if (currentimage !== arrListImage[i]) {
                newlist += (newlist !== "" ? "," : "") + arrListImage[i];
            }
            else {
                newlist += (newlist !== "" ? "," : "") + newimage;
            }
        }
        return newlist.trim();
    }

    $("#" + instanceId + " .fileUpload").on("change", function () {
        //sau khi chọn file xong thì submit form
        if (this.files.length > 0) {
            var isFail = false;
            for (i = 0; i < this.files.length; i++) {
                if (isFail) break; //nếu có lỗi khi upload ảnh thì thoát ra tại thời điểm đó
                //kiểm tra dung lượng và loại
                var errImage = validateImage(this.files[i]);
                if (errImage !== "") {
                    alert(errImage);
                    //continue;
                    break;
                }
                if (isNumberOfImageOverload()) {
                    alert("Bạn đã upload quá " + defaults.maxFiles + " ảnh");
                    //nếu số lượng ảnh đã load đủ vào các item, thì không cần thêm cái upload nữa.
                    $("#" + instanceId + " .working-upload-item").remove();
                    break;
                }
                //MOD - 2017/03/26 - NAM-NT - START
                var reader = new FileReader();                
                reader.onload = function (e) {
                    var dtJson = { 'base64': e.target.result };
                    $.ajax({
                        url: defaults.serverUpload,
                        type: "POST",
                        data: JSON.stringify(dtJson),
                        cache: false,
                        dataType: "json",
                        async: false,
                        enctype: "multipart/form-data",
                        processData: false, // Don't process the files
                        contentType: "application/json; charset=utf-8",
                        beforeSend: function () {
                            $("#" + instanceId + " .working-upload-item").addClass("upload-item-loading");
                        },
                        success: function (data) {
                            successPost(data.d);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log(xhr.status);
                            console.log(xhr.responseText);
                            console.log(thrownError);
                            alert("Có lỗi xảy ra, xin bạn vui lòng upload lại ảnh");
                            isFail = true;
                        }
                    });
                }
                reader.readAsDataURL(this.files[i]);
                //MOD - 2017/03/26 - NAM-NT - END
            }
        }
        if (isNumberOfImageOverload()) {
            //nếu số lượng ảnh đã upload bằng đúng đủ qouta, thì không cần thêm cái upload nữa.
            $("#" + instanceId + " .working-upload-item").remove();
        }
    });
}