<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="TransitSchedule.Admin"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" href="./styles/site.css" type="text/css" />
</head>
<body>
    <table width="100%" cellspacing="0"  >
        <tr>
            <td>
                <img id="logo" src="./Content/Images/logo.png" alt="" />
            </td>
            <td style="text-align: right">
                <div id="divCurrentTime" style="font-size:3.5em"><asp:Label ID="labelTime" runat="server" ForeColor="White" /></div>
            </td>
        </tr>
    </table>
    <form id="form1" runat="server">
     <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="TransitSchedule.DataClasses1DataContext" EntityTypeName="" 
        OrderBy="Route" Select="new (Route, Stop, Platform)" 
        TableName="PlatformDisplays">
    </asp:LinqDataSource>
     <asp:PlaceHolder ID="placeHolder1" runat="server" />
    </form>
</body>
</html>
