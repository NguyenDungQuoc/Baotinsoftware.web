$.fn.thumb = function ()
{
    var imgs = this.find("img[data-src]").bind("error", function ()
    {
        var target = $(this);

        // attribute đánh dấu ảnh đã được tìm tạo thumb và bị lỗi mấy lần rồi
        var t = target.attr("t");
        if (t == null || t == "") target.attr("t", "1");
        else target.attr("t", eval(t) + 1);

        // Lỗi trên 2 lần thì không tiếp tục tạo ảnh thumb nữa
        if (eval(target.attr("t")) >= 2)
        {
            target.error(function () { });
            // target.attr("src", "/no_image.jpg"); // Nếu trong trường hợp không tìm thấy ảnh thì sẽ đặt là ảnh no image
        }
        else
        {
            // http://images.site.com/thumb/Share/2012/3/25/nbxe_1366033055_w230_h174.jpg
            // /thumb/Share/2012/3/25/nbxe_1366033055_w230_h174.jpg
            var saveFolder = "Thumb";
            var sf = "/" + saveFolder + "/";
            var rex = new RegExp(sf + "(.*)_w([0-9]+)_h([0-9]+).(.*)", "g");

            var path = target.attr("src");
            // Replace để lấy đường link cần xử lý sau khi bị lỗi
            var path = path.replace(rex, "/w$2h$3/$1.$4.img");
            target.attr("src", path);
        }
    });

    imgs.each(function ()
    {
        $(this).attr("src", $(this).attr("data-src"));
        $(this).removeAttr("data-src");
    });
}

$(function () { $("body").thumb(); });