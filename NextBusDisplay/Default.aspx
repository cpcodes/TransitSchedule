<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="TransitSchedule._Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="Stylesheet" href="./Styles/Site.css" type="text/css" />
    <!--<link href="Styles/Site.css" rel="stylesheet" /> -->
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">

        window.setInterval(function () {
            $.ajax({
                type: "POST",
                url: "WebService1.asmx/CheckReset",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnCheckResetSuccess,
                error: OnCheckResetError
            });


            $.ajax({
                type: "POST",
                url: "WebService1.asmx/GetTime",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetTimeSuccess,
                error: OnGetTimeError
            });
        

            $.ajax({
                type: "POST",
                url: "WebService1.asmx/FetchSchedule",
                data: "{'queryString':'" + getQueryString() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetMemberSuccess,
                error: OnGetMemberError
            });
        }, 60000); 

        function OnGetTimeSuccess(data, status) {
            $("#divCurrentTime").html(data.d);
        }


        function OnGetTimeError(request, status, error) {
            $("#divCurrentTime").html("");
        }

        function OnGetMemberSuccess(data, status) {
            $("#divScheduleData").html(data.d);
}

function OnGetMemberError(request, status, error) {
    // This Displays Any Errors For Debug
    $("#divScheduleData").html("<div style='font-size:3em; margin:20px;'>OnGetMemberError(request( readyState:" + request.readyState + " Status:" + request.status + "<br>responseText:" + request.responseText.replace(/\\r\\n/g, "<br />") + "), status, error)</div>");
    // $("#divScheduleData").html("<div style='font-size:3em; margin:20px;'>Schedule is temporarily offline.</div>");
}

function OnCheckResetSuccess(data, status) {
    if (data.d.toString() == "true") {
        window.location.href = window.location;
    }
} 

function OnCheckResetError(request, status, error) {
    alert(error);
}

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
                <div id="divCurrentTime" class="ClockText" ></div>
            </td>
        </tr>
    </table>
    <!-- Page Data Table Header -->
    <div id="divScheduleData" />
    </form>
</body>
</html>
