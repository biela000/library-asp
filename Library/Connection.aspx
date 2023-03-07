<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Connection.aspx.cs" Inherits="Library.Connection" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Connection</title>
</head>
<body>
<h1>Connect to a MySQL database</h1>
<form id="form1" runat="server">
    <div class="input-set">
        <asp:Label ID="ServerLb" runat="server">Server</asp:Label>
        <asp:TextBox ID="ServerTb" runat="server" />
    </div>
    <div class="input-set">
        <asp:Label ID="PortLb" runat="server">Port</asp:Label>
        <asp:TextBox ID="PortTb" runat="server" />
    </div>
    <div class="input-set">
        <asp:Label ID="DatabaseLb" runat="server">Database</asp:Label>
        <asp:TextBox ID="DatabaseTb" runat="server" />
    </div>
    <div class="input-set">
        <asp:Label ID="UserLb" runat="server">User</asp:Label>
        <asp:TextBox ID="UserTb" runat="server" />
    </div>
    <div class="input-set">
        <asp:Label ID="PasswordLb" runat="server">Password</asp:Label>
        <asp:TextBox ID="PasswordTb" TextMode="Password" runat="server" />
    </div>
    <asp:Button ID="ConnectBtn" runat="server" Text="Save" OnClick="ConnectBtn_Click" AutoPostBack="true" />
    <asp:Label ID="ConnectionStatusLb" runat="server" Visible="false"></asp:Label> 
    <asp:Button ID="GoToLoginBtn" runat="server" Visible="false" Enabled="false" OnClick="GoToLoginBtn_Click" Text="Go to login" />
</form>
</body>
</html>
