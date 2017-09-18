<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServiceNotice.aspx.cs" Inherits="TransitSchedule.ServiceNotice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add / Update Service Notices</title>
 <link rel="Stylesheet" href="./styles/site.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Table ID="Table1" runat="server" Width="100%" CssClass="adminTable">
            <asp:TableHeaderRow BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Size="XX-Large" BackColor="#005daa">
                <asp:TableHeaderCell Wrap="False">Active Date From</asp:TableHeaderCell>
                <asp:TableHeaderCell Wrap="False">Active Date To</asp:TableHeaderCell>
            </asp:TableHeaderRow>
            <asp:TableRow HorizontalAlign="Center" BackColor="#008c99" Width="50%">
                <asp:TableCell VerticalAlign="Top" Width="50%">
                    <asp:Calendar ID="DisplayFrom" runat="server" CssClass="CalendarDisplay" BackColor="Black" ForeColor="White" Width="100" Height="100" DayHeaderStyle-CssClass="failureNotification" NextPrevStyle-ForeColor="Red" SelectedDayStyle-BackColor="Red"></asp:Calendar>
                </asp:TableCell>
                <asp:TableCell VerticalAlign="Top" Width="50%">
                    <asp:Calendar ID="DisplayTo" runat="server" CssClass="CalendarDisplay" BackColor="Black" ForeColor="White" Width="100" Height="100" DayHeaderStyle-CssClass="failureNotification" NextPrevStyle-ForeColor="Red" SelectedDayStyle-BackColor="Red"></asp:Calendar>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>

        <asp:Table ID="Table3" runat="server" Height="100%" Width="100%" CssClass="adminTable">
            <asp:TableHeaderRow BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Size="XX-Large" BackColor="#005daa">
                <asp:TableHeaderCell Wrap="False">Service Notice ID</asp:TableHeaderCell>
                <asp:TableHeaderCell Wrap="False">Display Text</asp:TableHeaderCell>
            </asp:TableHeaderRow>
            <asp:TableRow BackColor="#008c99">
                <asp:TableCell VerticalAlign="Top">
                    <asp:TextBox ID="ServiceNoticeID" runat="server" BackColor="White" ForeColor="Black" Font-Size="X-Large"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell VerticalAlign="Top" Width="75%">
                    <asp:TextBox ID="DisplayText" runat="server" Width="100%" BackColor="White" ForeColor="Black" TextMode="MultiLine" Height="150" Font-Size="X-Large"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableHeaderCell HorizontalAlign="Right" >
                    <asp:Button ID="butSave" runat="server" Text="Save" OnCommand="RecordUpSert_Click" Font-Size="X-Large" />
                </asp:TableHeaderCell>
                <asp:TableHeaderCell HorizontalAlign="Center">
                    <asp:Button ID="butCancel" runat="server" Text="Cancel" OnCommand="CancelButton_Click" Font-Size="X-Large" />
                </asp:TableHeaderCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table ID="Table2" runat="server" Height="100%" Width="100%" BorderColor="White" BorderStyle="Solid" BorderWidth="1px">
            <asp:TableRow Height="100">
                <asp:TableCell ColumnSpan="3" VerticalAlign="Top" CssClass="adminTable">
                    <div style="font-size: 32px; font-family: Arial, Tahoma, Helvetica, Verdana; color: white; background-color: black;">
                    <font color='red'><b>SERVICE NOTICE</b></font>:<br>
                    <asp:PlaceHolder ID="ServiceNoticeHolder1" runat="server" />
                    </div>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    </form>
    </body>
</html>
