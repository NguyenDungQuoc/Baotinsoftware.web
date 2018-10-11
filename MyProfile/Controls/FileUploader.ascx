<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileUploader.ascx.cs" Inherits="MyProfile.Controls.FileUploader" %>
<%@ Import Namespace="MyProfile.Class" %>
<!--ADD - NAM-NT - 2017/03/27 -->
<link href="/Theme/plugins/uploadFile/styles/upload.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/Theme/plugins/uploadFile/scripts/wvtupload.js"></script>
<div class="mb20">
	<div id="fileupload" class="mt10">
		<div id="uploadimage" class="clearfix default-theme">
			<input type="hidden" name="hdfGuestUploadNonFlash" id="hdfGuestUploadNonFlash" />
            <p class="mt5">
		        (Bạn có thể nhập tối đa 3 ảnh và mỗi ảnh nặng không quá 1Mb!)
	        </p>
		</div>
	</div>
</div>
<script type="text/javascript">
    $('#uploadimage').wvtupload({
        target: 'hdfGuestUploadNonFlash',
        maxFiles: 3,
        serverThumb: '<%= MyConstant.PathUploadComment %>',
        serverUpload: '<%= MyConstant.PathServerUpload %>'
    });
</script>
