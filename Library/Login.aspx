<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Library.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700&display=swap" rel="stylesheet" />
    <link href="reset.css" rel="stylesheet" />
    <link href="variables.css" rel="stylesheet" />
    <link href="global.css" rel="stylesheet" />
    <link href="login.css" rel="stylesheet" />
</head>
<body>
    <div class="main-header">
        <h1>Login to your account</h1>
    </div>
    <form id="form1" runat="server" class="main-form">
        <div class="input-set">
            <asp:Label ID="LoginLb" runat="server">Login</asp:Label>
            <asp:TextBox ID="LoginTb" runat="server" />
            <asp:RequiredFieldValidator ID="LoginRfv" runat="server" ControlToValidate="LoginTb" ErrorMessage="Login is required" Display="Dynamic" ValidationGroup="RegisterValidators" />
        </div>
        <asp:Panel CssClass="input-set" runat="server" ID="EmailInputPanel" Visible="false" Enabled="false">
            <asp:Label ID="EmailLb" runat="server">Email</asp:Label>
            <asp:TextBox ID="EmailTb" runat="server" TextMode="Email" />
            <asp:RegularExpressionValidator ID="EmailRev" runat="server" ControlToValidate="EmailTb" ErrorMessage="Email is not valid" Display="Dynamic" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ValidationGroup="RegisterValidators" />
            <asp:RequiredFieldValidator ID="EmailRfv" runat="server" ControlToValidate="EmailTb" ErrorMessage="Email is required" Display="Dynamic" ValidationGroup="RegisterValidators" />
        </asp:Panel>
        <div class="input-set password-set">
            <asp:Label ID="PasswordLb" runat="server">Password</asp:Label>
            <asp:TextBox ID="PasswordTb" runat="server" TextMode="Password" />
            <asp:RegularExpressionValidator ID="PasswordRev" runat="server" ControlToValidate="PasswordTb" ErrorMessage="Password must be at least 6 characters long" Display="Dynamic" ValidationExpression="^.{6,}$" ValidationGroup="RegisterValidators" />
            <asp:RequiredFieldValidator ID="PasswordRfv" runat="server" ControlToValidate="PasswordTb" ErrorMessage="Password is required" Display="Dynamic" ValidationGroup="RegisterValidators" />
        </div>
        <div class="checkbox-set">
            <asp:Label ID="RegisterCheckBoxLb" AssociatedControlID="RegisterCheckbox" runat="server">First time?</asp:Label>
            <asp:CheckBox ID="RegisterCheckbox" runat="server" AutoPostBack="true" OnCheckedChanged="RegisterCheckbox_CheckedChanged" />
        </div>
        <asp:Button ID="LoginBtn" runat="server" OnClick="LoginBtn_Click" Text="Login" />
    </form>
    <asp:Label ID="LoginMessageLb" runat="server" Visible="false">The login or the password are not correct</asp:Label>
</body>
</html>
