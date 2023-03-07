<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchBooks.aspx.cs" Inherits="Library.SearchBooks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search Books</title>
</head>
<body>
    <form id="form1" runat="server">
            <div class="input-set">
                <asp:Label runat="server" ID="TitleLb" AssociatedControlID="TitleTb">Title</asp:Label>
                <asp:TextBox runat="server" ID="TitleTb" />
            </div>
            <div class="input-set">
                <asp:Label runat="server" ID="AuthorsLb" AssociatedControlID="AuthorsTb">Authors</asp:Label>
                <asp:TextBox runat="server" ID="AuthorsTb" />
            </div>
        <asp:Button runat="server" ID="SearchBtn" OnClick="SearchBtn_Click" Text="Search" />
    </form>
</body>
</html>
