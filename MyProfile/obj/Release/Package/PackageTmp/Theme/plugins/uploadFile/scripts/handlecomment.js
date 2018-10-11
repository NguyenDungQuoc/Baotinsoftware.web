var ValidateComment = function (fullname, email, message, captcha) {
    var expected = $(".captcha-code").find("input[type='hidden']").val();
    if ("" === fullname.val()) {
        fullname.focus();
        return "+ Vui lòng nhập họ tên của bạn";
    } else if ("" === email.val()) {
        email.focus();
        return "+ Vui lòng nhập địa chỉ email";
    } else if (!ValidateEmail(email.val())) {
        email.focus();
        return "+ Địa chỉ email không hợp lệ";
    } else if ("" === message.val()) {
        message.focus();
        return "+ Vui lòng nhập nội dung cho bình luận";
    } else if ("" === captcha.val()) {
        captcha.focus();
        return "+ Vui lòng nhập mã captcha";
    } else if (captcha.val() !== expected) {
        captcha.focus();
        return "+ Mã captcha không hợp lệ";
    }
    return "";
}

function ValidateEmail(a) {
    var b = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return b.test(a);
}

//=== Ajax handle send comment - Start ===
$("#btn_SendComment").on("click", function (e) {
    //Ban đầu click thì disabled, sau khi xử lý xong thì remove đó đi
    $(this).attr("disabled", "true");
    var fullname = $("#comment input[name='fullname']");
    var email = $("#comment input[type='email']");
    var message = $("#comment textarea[name='message']");
    var captcha = $("#comment input[name='captcha']");
    var productId = $("#hdfProductId").val();
    var avatar = $(".cmt-cover").find("img");
    var arrayFile = $("#hdfGuestUploadNonFlash") !== "undefined" ? $("#hdfGuestUploadNonFlash").val() : "";
    var errComment = ValidateComment(fullname, email, message, captcha);
    if (errComment !== "") {
        alert(errComment);
    } else {
        var jsonData = {
            'avatar': avatar.attr("src"),
            'fullname': fullname.val(),
            'message': message.val(),
            'email': email.val(),
            'provinceId': 0,
            'images': arrayFile,
            'productId': productId,
            'typeId': 0
        };
        $.ajax({
            url: "/productdetail.aspx/HandleSendComment",
            type: "POST",
            data: JSON.stringify(jsonData),
            cache: false,
            dataType: "json",
            async: false,
            processData: false, // Don't process the files
            contentType: "application/json; charset=utf-8",
            beforeSend: function () {
                $("#uploadimage .working-upload-item").addClass("upload-item-loading");
            },
            success: function (data) {
                if (data.d.StatusCode === "Success") {
                    console.log(data.d);
                    SuccessPostComment(data.d);
                    ClearControlWhenFinish(fullname, email, message, captcha, avatar);
                } else {
                    alert(data.d.Description);
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(xhr.responseText);
                console.log(thrownError);
                alert("Có lỗi xảy ra, xin bạn vui lòng kiểm tra lại");
            }
        });
    }
    $(this).removeAttr("disabled");
    e.preventDefault();
});

//Handle Preview Avatar
$(".fileUploadAvatar").change(function () {
    if (typeof (FileReader) != "undefined") {
        var dvPreview = $(".cmt-cover");
        // Duyệt từng files.
        $(this.files).each(function () {
            var file = this;
            // Kiểm tra dung lượng và loại
            var rex = /(?:gif|jpg|png|bmp)$/;
            if (!rex.test(file.name.toLowerCase())) {
                alert("Không đúng định dạng ảnh cho phép (gif, png, jpg, jpeg)");
            } else if (file.size > 1048576) {
                alert("Kích thước ảnh quá lớn. Dung lượng ảnh phải nhỏ hơn 1Mb");
            } else {
                var reader = new FileReader();
                reader.onload = function (e) {
                    dvPreview.find("img").attr("src", e.target.result);
                }
                reader.readAsDataURL(file);
            }
        });
    } else {
        alert("Trình duyệt này không hỗ trợ HTML5 FileReader");
    }
});
//=== Ajax handle send comment - End ===
function ClearControlWhenFinish(fullname, email, message, captcha, avatar) {
    fullname.val("");
    email.val("");
    message.val("");
    avatar.attr("src", "/Theme/photo/anonymous.gif");
    captcha.val("");
    $("#hdfGuestUploadNonFlash").val("");
    var instanceId = "#uploadimage";
    $(instanceId).find(".upload-item").remove();
    //Nếu Add xong mà chưa có cái nào để upload thì phải show ra 1 cái
    if ($(instanceId + " .working-upload-item").length === 0) {
        $(instanceId).append('<div class="upload-item working-upload-item"></div>');
        InitOpenFileBrowser(instanceId);
    }
}
// Xử lý sau khi send thành công
function SuccessPostComment(obj) {
    var commentList = $(".response-area ul.media-list").find("li.media");
    var attachFile = "";
    if (obj.AttachFile !== "undefined" && obj.AttachFile !== null && obj.AttachFile !== "") {
        var atf = obj.AttachFile.split(",");
        console.log(atf);
        if (atf.length !== 0) {
            attachFile += "<div class='list-img-comment'>";
            for (var i = 0; i < atf.length; i++) {
                attachFile += "<a style='background-image: url(" + atf[i] + ")' class='fancybox-thumb' rel='comment-thumb' href='" + atf[i] + "'></a>";
            }
            attachFile += "</div>";
        }
    }

    var strAppend = "<li class='media'>" +
        "<a class='pull-left' href='#' onclick='return false;'>" +
            "<span style='background-image: url(" + obj.Avatar + ")'></span>" +
        "</a>" +
        "<div class='media-body'>" +
        "<ul class='sinlge-post-meta'>" +
            "<li><i class='fa fa-user'></i>" + obj.Name + "</li>" +
            "<li><i class='fa fa-clock-o'></i>" + obj.Time + "</li>" +
            "<li><i class='fa fa-calendar'></i>" + obj.Date + "</li>" +
        "</ul>" +
        "<p>" + obj.Content + "</p>" + attachFile +
        "</div>" +
        "</li>";
    if (commentList.length === 0) {
        $(".response-area ul.media-list").append(strAppend);
        $(".response-area h4:first-child").show();
    } else {
        commentList.last().after(strAppend);
    }
    $("body, html").animate({ scrollTop: $(".response-area ul.media-list").offset().top }, 600);
}
//Khởi tạo lại event click
var InitOpenFileBrowser = function (instanceId) {
    $(instanceId + " .upload-item").unbind("click");
    $(instanceId + " .working-upload-item").click(function() {
        $(instanceId + " .fileUpload").click();
    });
}