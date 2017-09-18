<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatusMessage.aspx.cs" Inherits="TransitSchedule.StatusMessage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Status Message</title>
<style type="text/css">
body
{
    font-size: 24px;
    color: white;
    font-family: Arial, Tahoma, Helvetica, Verdana;
    background-color: black;
}
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        $('marquee').marquee(optionalClass);
    The Coaster Trains will not be running this weekend.
    </div>
    </form>
</body>
</html>
