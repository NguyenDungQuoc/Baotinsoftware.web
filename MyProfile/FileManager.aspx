<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileManager.aspx.cs" Inherits="MyProfile.FileManager" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>Quản lý file</title>
        <script src="/ckfinder/ckfinder.js"></script>
	    <style type="text/css">
		    body, html, iframe {
			    margin: 0;
			    padding: 0;
			    border: 0;
			    width: 100%;
			    height: 100%;
			    overflow: hidden;
		    }
	    </style>
    </head>
    <body>
        <script type="text/javascript">
            var finder = new CKFinder();
            finder.basePath = '/ckfinder/'; 
            finder.width = '99%';
            finder.height = "100%";

            finder.removePlugins = 'basket';
            finder.selectActionData = "container";
            finder.selectActionFunction = function (fileUrl, data)
            {
                window.opener.ShCore.fileManagerCallback(api.getSelectedFolder().getUrl(), api.getSelectedFiles());
            };
            finder.selectMultiple = <%= Multi ? "true":"false" %>;
            finder.resourceType = '<%= string.IsNullOrEmpty(Type) ? "Images" : Type %>';
            //finder.tabIndex = 1;
            //finder.startupPath = "Images:/";
            var api = (finder).create();
        </script>
    </body>
</html>
