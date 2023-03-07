<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Library.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
<h1>Connect to a MySQL database</h1>
<form id="form1" runat="server">
    <div class="input-set">
        <asp:Label ID="LoginLb" runat="server">Login</asp:Label>
        <asp:TextBox ID="LoginTb" runat="server" />
    </div>
    <asp:Panel CssClass="input-set" runat="server" ID="EmailInputPanel" Visible="false" Enabled="false">
        <asp:Label ID="EmailLb" runat="server">Email</asp:Label>
        <asp:TextBox ID="EmailTb" runat="server" TextMode="Email" />
    </asp:Panel>
    <div class="input-set">
        <asp:Label ID="PasswordLb" runat="server">Password</asp:Label>
        <asp:TextBox ID="PasswordTb" runat="server" TextMode="Password" />
    </div>
    <div class="input-set">
        <asp:Label ID="RegisterCheckBoxLb" AssociatedControlID="RegisterCheckbox" runat="server">First time?</asp:Label>
        <asp:CheckBox ID="RegisterCheckbox" runat="server" AutoPostBack="true" OnCheckedChanged="RegisterCheckbox_CheckedChanged" />
    </div>
    <asp:Label ID="LoginMessageLb" runat="server" Visible="false">The login or the password are not correct</asp:Label>
    <asp:Button ID="LoginBtn" runat="server" OnClick="LoginBtn_Click" Text="Login" />
</form>
</body>
</html>
