<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataEdit.aspx.cs" Inherits="TransitSchedule.DataEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center;">
            <input type="submit" id="Stops" value="Stops" />&nbsp; <!-- [NextBusDisplay].[dbo].[StopDisplay] -->
            <input type="submit" id="StaticTrainA" value="Amtrak Static Trains" />&nbsp; <!-- [NextBusDisplay].[dbo].[StaticTrains] -->
            <input type="submit" id="StaticTrainC" value="Coaster Static Trains" />&nbsp; <!-- [NextBusDisplay].[dbo].[StaticTrains] -->
            <input type="submit" id="StaticTrainM" value="Metrolink Static Trains" />&nbsp; <!-- [NextBusDisplay].[dbo].[StaticTrains] -->
            <input type="submit" id="StaticTrainS" value="Sprinter Static Trains" />&nbsp; <!-- [NextBusDisplay].[dbo].[StaticTrains] -->
            <input type="submit" id="platformov" value="Platform Override" />&nbsp; <!-- [NextBusDisplay].[dbo].[PlatformOverride] -->
            <input type="submit" id="Holidays" value="Holidays" /> <!-- [NextBusDisplay].[dbo].[tblHoliDate] -->
        </div>
    <div>
        <asp:PlaceHolder ID="GridHolder" runat="server">
            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
        </asp:PlaceHolder>
    </div>
    </form>
</body>
</html>
