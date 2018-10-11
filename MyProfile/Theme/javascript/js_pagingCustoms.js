$(document).ready(function () {
    $(".paging_bootstrap > .pagination > li:first-child.disabled, .paging_bootstrap > .pagination > li:last-child.disabled").removeClass("active").find("a").click(function (e) {
        e.preventDefault();
    });    
    $(".paging_bootstrap > .pagination > li.active").removeClass("disabled").find("a").click(function (e) {
        e.preventDefault();
    });
    //Page Admin
    $(".paging_bootstrap > .pagination > li:first-child.active, .paging_bootstrap > .pagination > li:last-child.active").addClass("disabled").removeClass("active");
});