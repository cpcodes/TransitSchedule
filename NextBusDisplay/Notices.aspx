<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notices.aspx.cs" Inherits="Notices._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" href="./Styles/Site.css" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        var TableHeader = `
        <table width='100%' height='200px' cellspacing='0'>
            <thead>
                <tr>
                    <td class='ServiceNoticeStyle'><font color='red'><b>SERVICE NOTICE</b></font><br /></td>
                </tr>
            </thead>
            <tbody>
        `;

        (function getNotices() {
            $.ajax({
                type: "POST",
                url: "Notices.asmx/GetServiceNotices",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $("#divNoticeTable").html(TableHeader + data.d + "</tbody></table>");
                },
                error: function (object, status, errorMessage) {
                    $("#divNoticeTable").attr("color", "red");
                    $("#divNoticeTable").attr("size", "4em");
                    $("#divNoticeTable").html(status + ": " + errorMessage);
                },
                complete: function () {
                    setTimeout(getNotices, 60000);
                }
            });
        })();
    </script>
    <title>Service Notices</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divNoticeTable" />
    </form>
</body>
</html>
