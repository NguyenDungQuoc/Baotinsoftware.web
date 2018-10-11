$(document).ready(function () {
    $(".inputUsername").blur(function () {        
        var rex = /^[a-zA-Z0-9]([._](?![._])|[a-zA-Z0-9]){4,25}[a-zA-Z0-9]$/;
        if (rex.test($(this).val()) == false) {
            $(".error-register").html("<i class='fa fa-cogs'></i> Username invalid. Please enter a different username");
            $(this).focus();
            return false;
        } else {
            $(".error-register").html("");
            return true;
        }
    });
});