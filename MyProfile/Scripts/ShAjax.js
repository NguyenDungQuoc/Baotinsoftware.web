/*

post(methodServer, data, callback)
+ Ajax Post
- methodServer: Phương thức ở server cần được gọi
- data: dữ liệu cần truyền đi ví dụ: {name: "Nguyễn Văn A", age: 20}
- callback: phương thức xử lý sau khi thực hiện request thành công

get(methodServer, data, callback)
+ Ajax Get: giống Ajax Post, phương thức thực hiện là GET

doPostTimer(methodServer, data, timeInterval, process, waiting, endWhen)
+ Thực hiện một phương thức ajax mà lặp đi lặp lại theo một chu kỳ
- methodServer: Phương thức ở server cần được gọi
- data: dữ liệu cần gửi đi từ client
- timeInterval: chu kỳ cần lặp
- process: phương thức xử lý sau khi thực hiện request thành công
- waiting: phương thức để gợi ý là có thực hiện đợi một chờ một vấn đề gì đó khi thực hiện chu kỳ tiếp theo hay không
- endWhen: phương thức đưa ra điều kiện khi nào thì sẽ dừng, không lặp lại nữa

clearThreadGet(methodServer)
clearThreadPOST(methodServer)
+ Clear thread thực hiện methodServer

*/

/* Class để thực hiện các function ajax */
function ShAjax() {
    // Đây là Assembly chứa đối tượng có phương thức ajax
    this.assembly = "Demo.GUI"; // Mặc định
    // Type của đối tượng chứa phương thức ajax trong Assembly
    this.typeAction = "";

    // Timer để check việc hiển thị thông báo trong quá trình gọi ajax
    this.timer = null;

    // selector của message khi thực hiện ajax
    this.divMessageSelector = ".float_loading";
    // div hiển thị message
    this.divMessage = "<div class='float_loading'>Loading</div>";

    // Thực hiện một request ajax post
    this.post = function (methodServer, data, callback) {
        // Đối tượng ShAjax đang được khai báo
        var $this = this;

        // Thực hiện request
        $this.doAjax("POST", methodServer, data, callback);
    }

    // Thực hiện một request ajax get
    this.get = function (methodServer, data, callback) {
        // Đối tượng ShAjax đang được khai báo
        var $this = this;

        // Thực hiện request
        $this.doAjax("GET", methodServer, data, callback);
    }

    // Thực hiện một request ajax
    this.doAjax = function (methodAjax, methodServer, data, callback) {
        // Đối tượng ShAjax đang được xử dụng
        var $this = this;

        // Xóa message cũ đi
        $($this.divMessageSelector).remove();

        // Clear việc đang chờ hiển thị message lúc trước đi
        if ($this.timer != null) clearTimeout($this.timer);

        // Thực hiện hiển thị message, nếu như quá trình đang thực hiện request quá 0.1s
        $this.timer = setTimeout(function () { $('body').append($this.divMessage); }, 100);

        // Url thực hiện request ajax
        var urlRequest = "/Services/Ajax.aspx?_n=" + $this.assembly + "&_o=" + $this.typeAction + "&_m=" + methodServer;

        // kiểm tra xem data có phải là một function lấy data hay không
        // nếu là một function lấy data thì thực hiện lấy data
        var dataPost = typeof (data) == "function" ? data() : data;

        //var request ajax
        var request = $.ajax(
        {
            // Url thực hiện request
            url: urlRequest,

            // method post hoặc get
            type: methodAjax,

            // data cần truyền đi
            data: dataPost,

            // ContentType dữ liệu trả về
            dataType: "json"
        });

        // Nếu như request thực hiện thành công
        request.done(
            function (res) {
                // Ẩn message đang hiển thị lên
                if ($this.timer != null) clearTimeout($this.timer);
                $($this.divMessageSelector).remove();

                // Có lỗi validate
                if (res.Data.ValidateError != null) {
                    alert(res.Data.ValidateError.Message);
                    return;
                }

                // Có lỗi về action trong method gọi đến
                if (res.Data.MessageError != null) {
                    alert("Error: " + res.Data.MessageError);
                    return;
                }

                // Thực hiện xử lý javascript mà server gửi về cho client
                eval(res.JavaScript);

                // Nếu có xử lý sau khi kết thúc request theo ý người lập trình
                if (callback != null) callback(res);
            }
        );
    }

    // Thực hiện phương thức Post có Timer
    this.doPostTimer = function (methodServer, data, timeInterval, process, waiting, endWhen) {
        // Đối tượng ShAjax đang được sử dụng
        var $this = this;

        // clear lại timeout trước đó đi
        $this.clearThread("POST", methodServer);

        // Gọi thread Timer
        $this.doTimer("POST", methodServer, data, timeInterval, null, process, waiting, endWhen);
    }

    // Thực hiện phương thức Get có Timer
    this.doGetTimer = function (methodServer, data, timeInterval, process, waiting, endWhen) {
        // Đối tượng ShAjax đang được sử dụng
        var $this = this;

        // clear lại timeout trước đó đi
        $this.clearThread("GET", methodServer);

        // Gọi thread Timer
        $this.doTimer("GET", methodServer, data, timeInterval, null, process, waiting, endWhen);
    }

    // ajax timer, dùng để thực hiện một phương thức theo một chu kỳ, có tính toán độ trễ qua từng request
    this.doTimer = function (methodAjax, methodServer, data, timeInterval, lastRequest, process, waiting, endWhen) {
        // Đối tượng ShAjax đang được sử dụng
        var $this = this;

        // Thực hiện request
        $this.threadDoAjax(methodAjax, methodServer, data, process, lastRequest, timeInterval, waiting, endWhen);
    }

    // Lưu trữ các timer thread đang chạy
    this.threadTimer = {};

    // Thực hiện xử lý cụ thể trong doTimer
    // endWhen: Khi phương thức trả về false thì kết thúc thread luôn
    this.threadDoAjax = function (methodAjax, methodServer, data, process, lastRequest, timeInterval, waiting, endWhen) {
        // Đối tượng ShAjax đang được sử dụng
        var $this = this;

        // nếu có sự kiện thực hiện đợi chờ một việc gì đó thì dừng lại chờ
        if (waiting != null && waiting()) {
            // request lại cho đến khi thoát khỏi waiting          
            $this.smoothingThread(lastRequest, methodAjax, methodServer, data, timeInterval, process, waiting, endWhen);
            return;
        }

        // Thực hiện ajax
        $this.doAjax(methodAjax, methodServer, data, function (res) {
            // Nếu có sử lý sau khi gọi phương thức ajax thì gọi process
            if (process != null) process(res);

            // nếu như có function để kiểm tra việc kết thúc thread thì gọi đến nó
            if (endWhen != null && endWhen(res)) return;

            // làm mượt chu kỳ thread
            $this.smoothingThread(lastRequest, methodAjax, methodServer, data, timeInterval, process, waiting, endWhen);
        });
    }

    // phương thức làm mượt thread
    this.smoothingThread = function (lastRequest, methodAjax, methodServer, data, timeInterval, process, waiting, endWhen) {
        // Đối tượng ShAjax đang sử dụng
        var $this = this;

        // clear lại timeout trước đó đi
        $this.clearThread(methodAjax, methodServer);

        // Tính toán lại thời gian thực hiện request
        // Đảm bảo cứ sau timeInterval sẽ thực hiện một lần
        var ti = lastRequest == null ? timeInterval : timeInterval - (new Date() - lastRequest);

        // Nếu mà thời gian thực hiện trước đó mà lớn hơn cả chu kỳ thì lấy lại là 20s
        ti = ti <= 0 ? timeInterval : ti;

        // thiết lập lại ngày giờ lần cuối cùng thực hiện request
        lastRequest = new Date();

        // setTimeout để chạy chu trình tiếp theo
        $this.threadTimer[methodAjax + "_" + methodServer] = setTimeout(function () {
            $this.doTimer(methodAjax, methodServer, data, timeInterval, lastRequest, process, waiting, endWhen);
        }, ti);
    }

    // Lấy ra timer của phương thức đang thực hiện
    this.getTimerGetOf = function (methodServer) {
        // Đối tượng ShAjax đang được sử dụng
        var $this = this;

        return $this.threadTimer["GET_" + methodServer];
    }

    // Lấy ra timer của phương thức đang thực hiện
    this.getTimerPostOf = function (methodServer) {
        // Đối tượng ShAjax đang được sử dụng
        var $this = this;

        return $this.threadTimer["POST_" + methodServer];
    }

    this.clearThreadGet = function (methodServer) {
        // Đối tượng ShAjax đang được sử dụng
        var $this = this;

        $this.clearThread("GET", methodServer);
    }

    this.clearThreadPOST = function (methodServer) {
        // Đối tượng ShAjax đang được sử dụng
        var $this = this;

        $this.clearThread("POST", methodServer);
    }

    // clear timer of thread 
    this.clearThread = function (methodAjax, methodServer) {
        // Đối tượng ShAjax đang được sử dụng
        var $this = this;

        // Lấy ra timer của phương thức ajax đang gọi
        var thisTimer = $this.threadTimer[methodAjax + "_" + methodServer];

        // Nếu tồn tại rồi thì clearTimeout
        if (thisTimer != null) {
            // clear timeout
            clearTimeout(thisTimer);

            // set null timer
            $this.threadTimer[methodAjax + "_" + methodServer] = null;
        }
    }
}

function ShCore(){}


ShCore.popup = function (url, event, width, height) {
    var w = width == null ? 800 : width;
    var h = height == null ? 600 : height;
    var left = (screen.width / 2) - (w / 2);
    var top = (screen.height / 2) - (h / 2);
    var windowName = "popUp";
    var params = "width=" + w + ",height=" + h + ",top=" + top + ",left=" + left;
    var newwin = window.open(url, windowName, params);
    if (event)
        event.preventDefault();
    if (window.focus) { newwin.focus() }
    return newwin;
}

ShCore.fileManagerCallback = null;
ShCore.showFiles = function (type, multi, callback) {
    ShCore.fileManagerCallback = function (folder, files) {
        callback(folder, files);
        ShCore.fileManagerCallback = null;
    };
    ShCore.popup("/filemanager.aspx?type=" + (type == null || type == "" ? "Images" : type) + "&multi=" + multi);
}
$.fn.thumb = function () {
    var imgs = this.find("img[data-src]").bind("error", function () {
        var target = $(this);

        // attribute đánh dấu ảnh đã được tìm tạo thumb và bị lỗi mấy lần rồi
        var t = target.attr("t");
        if (t == null || t == "") target.attr("t", "1");
        else target.attr("t", eval(t) + 1);

        // Lỗi trên 2 lần thì không tiếp tục tạo ảnh thumb nữa
        if (eval(target.attr("t")) >= 2) {
            target.error(function () { });
            // target.attr("src", "/no_image.jpg"); // Nếu trong trường hợp không tìm thấy ảnh thì sẽ đặt là ảnh no image
        }
        else {
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

    imgs.each(function () {
        $(this).attr("src", $(this).attr("data-src"));
        $(this).removeAttr("data-src");
    });
}
$(function () { $("body").thumb(); });