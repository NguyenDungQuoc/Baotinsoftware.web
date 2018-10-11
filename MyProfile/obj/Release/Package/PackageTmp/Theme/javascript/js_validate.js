//GROUP NEWS AND GROUP GALLERY
function validInsertRecord(value) {
    var n = $("div.validName input[type='text']");
    var path = $("div.validPath input[type='text']");
    var t = $("td.validName input");
    var p = $("td.validPosition input");
    if (value === 0) {        
        if (n.val() !== "") {
            return true;
        } else {
            alert("Tên/tiêu đề không được bỏ trống");
            n.focus();
            return false;
        }        
    }
    else if (value === 1) {
        if (n.val() !== "" && path.val() !== "") {
            return true;
        } else {
            alert("Tên file & đường dẫn không được bỏ trống!");
            n.focus();
            return false;
        }
    } else {        
        if (t.val() === "") {
            t.focus();
            return false;
        }
        if (p.val() === "") {
            p.focus();
            return false;
        }
        if (parseInt(p.val()) < 0) {
            alert("Vị trí phải là ký số và lớn hơn 0");
            return false;
        } else {
            return true;
        }
    }
}
function updateRecordUploadFile() {
    var n = $(".f-Name");
    var path = $(".f-Path");
    if (n.val() !== "" && path.val() !== "") {
        return true;
    } else {
        alert("Tên file & đường dẫn không được bỏ trống!");
        n.focus();
        return false;
    }
}