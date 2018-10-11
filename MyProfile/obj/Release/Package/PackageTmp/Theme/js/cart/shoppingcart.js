/*---JS xử lý cho Giỏ hàng---*/
$(document).ready(function () {
    //Called when key is pressed in textbox
    $(".product-quantity").keypress(function (evt) {
        if (evt.which != 8 && evt.which != 0 && (evt.which < 48 || evt.which > 57)) {
            return false;
        }
    });
    //Change Size Product Detail
    $(".chk-size > label").click(function (e) {
        $(".chk-size > label").removeClass("on");
        $(this).addClass("on");
        fc_ChangePrice();
        e.preventDefault();
    });
    //Change Color Product Detail 
    $(".chk-color > span").click(function (event) {
        $(".chk-color > span").removeClass("on");
        $(this).addClass("on");
        fc_ChangePrice();
        event.preventDefault();
    });
});
//Check MaxLength Data Input HTML5
function maxLengthCheck(object) {
    if (object.value.length > object.maxLength)
        object.value = object.value.slice(0, object.maxLength);
};
//Change Price
function fc_ChangePrice() {
    var pColor = parseFloat($(".chk-color > span.on").attr("pricetag"));
    var pSize = parseFloat($(".chk-size > label.on").find("input").attr("pricetag"));
    var pInitial = parseFloat($(".price-tag").attr("pricetag"));
    var pDiscount = parseFloat($(".price-discount").attr("pricetag"));
    var pTotal = 0;
    var pDisplay = $(".price-tag");
    // TH: giá cũ & giá mới => cái nào xuất hiện sẽ lấy nó để tính    
    if (isNaN(pDiscount) != true) {
        pInitial = pDiscount;
        pDisplay = $(".price-discount");
    }

    if (isNaN(pColor) != true && isNaN(pSize) != true) {
        //TH: nếu color & size đều đc chọn
        pTotal = pInitial + pColor + pSize;        
    } else if (isNaN(pSize) != true) {
        //TH: nếu size đc chọn
        pTotal = pInitial + pSize;
    } else {
        pTotal = pInitial + pColor;
    }
    pDisplay.text(convertCurrency(pTotal));
};
//Format Currency
function convertCurrency(object) {
    return object.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.") + "đ";
};