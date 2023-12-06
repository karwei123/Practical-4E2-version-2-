<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesOrderByStaff.aspx.cs" Inherits="Practical_4E2.SalesOrderByStaff" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style3 {
            width: 592px;
            height: 42px;
        }
        .auto-style4 {
            height: 42px;
        }
        .auto-style5 {
            width: 592px;
            height: 30px;
        }
        .auto-style6 {
            height: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table class="auto-style1">
            <tr>
                <td class="auto-style3">Sales Order Information By Staff</td>
                <td class="auto-style4"></td>
            </tr>
            <tr>
                <td class="auto-style5">Please select staff name:</td>
                <td class="auto-style6">Please select year:</td>
            </tr>
            <tr>
                <td class="auto-style5">
                    <asp:DropDownList ID="ddlName" runat="server" DataSourceID="sdsName" DataTextField="Name" DataValueField="Name">
                    </asp:DropDownList>
                </td>
                <td class="auto-style6">
                    <asp:RadioButtonList ID="rblYear" runat="server" DataSourceID="sdsYear" DataTextField="Years" DataValueField="Years" RepeatDirection="Horizontal">
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="auto-style5"></td>
                <td class="auto-style6">
                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" />
                </td>
            </tr>
            <tr>
                <td class="auto-style6" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style6" colspan="2">
                    <asp:GridView ID="grvOrder" runat="server" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="sdsOrder">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                            <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" />
                        </Columns>
                    </asp:GridView>
                </td>
                <td>
                    <asp:Repeater ID="rptOrderDetails" runat="server" DataSourceID="sdsOrderDetails">
                        <HeaderTemplate>

                        </HeaderTemplate>
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>Product Name:</td>
                                    <td><%# Eval("ProductName") %></td>
                                </tr>
                                <tr>
                                    <td>Unit Price:</td>
                                    <td><%# Eval("UnitPrice") %></td>
                                </tr>
                                <tr>
                                    <td>Quantity:</td>
                                    <td><%# Eval("Quantity") %></td>
                                </tr>
                                <tr>
                                    <td>Discount:</td>
                                    <td><%# Eval("Discount") %></td>
                                </tr>
                                <tr>
                                    <td>Sales:</td>
                                    <td><%# Eval("Sales") %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </td>
            </tr>
            <tr>
                <td class="auto-style6" colspan="2">
                    <asp:SqlDataSource ID="sdsName" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS Name FROM Employees"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style6" colspan="2">
                    <asp:SqlDataSource ID="sdsYear" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT (YEAR(OrderDate)) AS Years FROM Orders ORDER BY Years ASC"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style6" colspan="2">
                    <asp:SqlDataSource ID="sdsOrder" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT OrderID, OrderDate
FROM Orders 
WHERE EmployeeID = @EmployeeID AND YEAR(OrderDate) = @Year">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlName" Name="EmployeeID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="rblYear" Name="Year" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style6" colspan="2">
                    <asp:SqlDataSource ID="sdsOrderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Orders.OrderID, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount, Products.ProductName, [Order Details].ProductID, ([Order Details].UnitPrice * OrderDetails.Quantity) * (1 - OrderDetails.Discount) AS Sales FROM Orders INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN Products ON [Order Details].ProductID = Products.ProductID WHERE (Orders.OrderID = @OrderID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="grvOrder" Name="OrderID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
