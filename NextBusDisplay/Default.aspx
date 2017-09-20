<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="TransitSchedule._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="Stylesheet" href="./Styles/Site.css" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        var TableHeader = `
            <table class='ScheduleTable' width='100%' cellspacing='0'>
                < col width= '34%' /><colgroup span='2' width='33%' />
                <thead>
                    <tr>
                        <th>
                            <div>Route / Stop</div>
                        </th>
                        <th>
                            <div>Next Departure</div>
                        </th>
                        <th>
                            <div>Scheduled Platform</div>
                        </th>
                    </tr>
                </thead>
        `;
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
                    $("#divScheduleData").html(TableHeader + data.d);
                },
                error: function () {
                    $("#divScheduleData").attr("color", "red");
                    $("#divScheduleData").attr("size", "4em");
                    $("#divScheduleData").html(errorMessage);
                },
                complete: function () {
                    setTimeout(getSchedule, 60000);
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
        <table width="100%" class="HeaderTable" cellspacing="0">
            <tr>
                <td>
                    <img id="logo" class="NCTDLogo" src="./Content/Images/NCTD-Formal-Logo-Color.jpg" alt="" />
                </td>
                <td>
                    <div id="divCurrentTime" class="ClockText"></div>
                </td>
            </tr>
        </table>
        <!-- Page Data Table Header -->
        <div id="divScheduleData" />
    </form>
</body>
</html>
