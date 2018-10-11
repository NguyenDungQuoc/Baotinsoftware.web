<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Faqs.ascx.cs" Inherits="MyProfile.Modules.Faqs" %>

<div class="faqs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="faqs-wrap">
                    <h1 class="title"><span>Câu hỏi thường gặp</span></h1>
                    <ul class="accordion_menu">
                        <li>
                            <a href="#">1. Tôi có thể đến trực tiếp văn phòng công ty để trao đổi về sản phẩm được không?</a>
                            <ul>
                                <li>
                                    <div class="faqs-content">
                                        <p>Chào bạn! Bạn có có thể đến trực tiếp văn phòng, trụ sở công ty tại số 123A Đường Lê Thánh Tông, Phường Cầu Giấy, Quận Từ Liêm, Hà Nội</p>
                                        <p>Bạn cũng có thể liên hệ trực tiếp với chúng tôi qua đường dây nóng : 0939 20 39 10 Mr.Nam</p>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">2. Chính sách hỗ trợ của công ty như thế nào?</a>
                            <ul>
                                <li>
                                    <div class="faqs-content">
                                        <p>Chào bạn! Bạn có có thể đến trực tiếp văn phòng, trụ sở công ty tại số 123A Đường Lê Thánh Tông, Phường Cầu Giấy, Quận Từ Liêm, Hà Nội</p>
                                        <p>Bạn cũng có thể liên hệ trực tiếp với chúng tôi qua đường dây nóng : 0939 20 39 10 Mr.Nam</p>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">3. Tôi là khách hàng thân thiết, đã sử dụng nhiều dịch vụ, gói website của công ty. Vậy tôi có quyền lợi và ưu đãi nào không?</a>
                            <ul>
                                <li>
                                    <div class="faqs-content">
                                        <p>Chào bạn! Bạn có có thể đến trực tiếp văn phòng, trụ sở công ty tại số 123A Đường Lê Thánh Tông, Phường Cầu Giấy, Quận Từ Liêm, Hà Nội</p>
                                        <p>Bạn cũng có thể liên hệ trực tiếp với chúng tôi qua đường dây nóng : 0939 20 39 10 Mr.Nam</p>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">4. Tôi là một nhà đâu tư kiêm chủ doanh nghiệp, tôi muốn tham gia, hợp tác cùng quý công ty có được không?</a>
                            <ul>
                                <li>
                                    <div class="faqs-content">
                                        <p>Chào bạn! Bạn có có thể đến trực tiếp văn phòng, trụ sở công ty tại số 123A Đường Lê Thánh Tông, Phường Cầu Giấy, Quận Từ Liêm, Hà Nội</p>
                                        <p>Bạn cũng có thể liên hệ trực tiếp với chúng tôi qua đường dây nóng : 0939 20 39 10 Mr.Nam</p>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">5. Tôi muốn ứng cử vào làm việc ở công ty, không biết công ty có tuyển dụng nhân sự không?</a>
                            <ul>
                                <li>
                                    <div class="faqs-content">
                                        <p>Chào bạn! Bạn có có thể đến trực tiếp văn phòng, trụ sở công ty tại số 123A Đường Lê Thánh Tông, Phường Cầu Giấy, Quận Từ Liêm, Hà Nội</p>
                                        <p>Bạn cũng có thể liên hệ trực tiếp với chúng tôi qua đường dây nóng : 0939 20 39 10 Mr.Nam</p>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>                
    </div>
</div>
<script type="text/javascript">

    $(document).ready(function () {
        $('.accordion_menu > li').find('ul').each(function () {
            $(this).parent().addClass('lv2');
        });

        $('.lv2 > a').click(function(e) {
            e.preventDefault();
            el = $(this);
            if (!el.hasClass('active')) {
                $('.active').removeClass('active').next().stop(false, true).slideUp('fast');
                el.addClass('active').next().stop(false, true).slideDown('fast');
            } else {
                $('.active').removeClass('active').next().stop(false, true).slideUp('fast');
            }
        });

    })(jQuery);

</script>