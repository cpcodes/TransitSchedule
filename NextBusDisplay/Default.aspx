<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="TransitSchedule._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>NCTD OTC Schedule</title>
    <link rel="Stylesheet" href="./Styles/Site.css" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        var TableHeader = "\
            <table class='ScheduleTable' width='99%' cellspacing='0'>\
                <col style='width:33%'>\
                <col style='width:33%'>\
                <col style='width:33%'>\
                <thead>\
                    <tr>\
                        <th>\
                            <div> </div>\
                        </th>\
                        <th>\
                            <div>Next Departure</div>\
                        </th>\
                        <th>\
                            <div>Scheduled Platform</div>\
                        </th>\
                    </tr>\
                </thead>\
        ";
        // Remove this variable if Notices are broken out to separate page (1/3)
        var NoticeTableHeader = "\
        <table width='99%' height='180px' cellspacing='0'>\
            <thead>\
                <tr>\
                    <td class='ServiceNoticeStyle'><font color='red'><b>SERVICE NOTICE</b></font><br /></td>\
                </tr>\
            </thead>\
        ";
        (function getTime() {
            $.ajax({
                type: "POST",
                url: "WebService1.asmx/GetTime",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) { $("#divCurrentTime").html(data.d); },
                error: function () { $("#divCurrentTime").html(""); },
                complete: function () { setTimeout(getTime, 5000); }
            });
        })();

        (function getSchedule() {
            $.ajax({
                type: "POST",
                url: "WebService1.asmx/FetchSchedule",
                data: "{'queryString':'" + getQueryString() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $("#divScheduleData").html(TableHeader + "<tbody>" + data.d + "</tbody></table>");
                },
                error: function (object, status, errorMessage) {
                    $("#divScheduleData").html("<font color='red' size='4em'>" + status + ": " + errorMessage + "</font>");
                },
                complete: function () {
                    setTimeout(getSchedule, 60000);
                }
            });
            // Remove this AJAX call if Notices are broken out to separate page (2/3)
            $.ajax({
                type: "POST",
                url: "Notices.asmx/GetServiceNotices",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "") $("#divNoticeTable").html("");
                    else $("#divNoticeTable").html(NoticeTableHeader + "<tbody>" + data.d + "</tbody></table>");
                },
                error: function (object, status, errorMessage) {
                    $("#divNoticeTable").html("<font color='red' size='4em'>" + status + ": " + errorMessage + "</font>");
                }
            });
        })();

        function getQueryString() {
            return window.location.href.substring(window.location.href.indexOf('?') + 1);
        }

    </script>

</head>
<body>
    <!-- Page Header Table -->
    <form id="form1" runat="server">
        <table width="99%" class="HeaderTable" cellspacing="0">
            <tr>
                <td>
                    <img id="logo" class="NCTDLogo" src="./Content/Images/NCTD-Formal-Logo-Color-800.png" alt="" />
                </td>
                <td>
                    <div id="divCurrentTime" class="ClockText"></div>
                </td>
            </tr>
        </table>
        <!-- Page Data Table Header -->
        <div id="divScheduleData"></div>
        <!-- Remove this br and div tag if Notices are broken out to separate page (3/3) -->
        <br />
        <div id="divNoticeTable"></div>
    </form>
</body>
</html>
