<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddBook.aspx.cs" Inherits="Library.AddBook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="GoBackBtn" runat="server" OnClick="GoBackBtn_Click" Text="Go back" />
            <div class="input-set">
                <asp:Label ID="IdLb" runat="server" AssociatedControlID="IdTb">Id</asp:Label>
                <asp:TextBox ID="IdTb" runat="server" Enabled="false" />
            </div>
            <div class="input-set">
                <asp:Label ID="AuthorsLb" runat="server" AssociatedControlID="AuthorsTb">Authors</asp:Label>
                <asp:TextBox ID="AuthorsTb" runat="server" />
            </div>
            <div class="input-set">
                <asp:Label ID="TitleLb" runat="server" AssociatedControlID="TitleTb">Title</asp:Label>
                <asp:TextBox ID="TitleTb" runat="server" />
            </div>
            <div class="input-set">
                <asp:Label ID="Release_dateLb" runat="server" AssociatedControlID="Release_dateTb">Release_date</asp:Label>
                <asp:TextBox ID="Release_dateTb" runat="server" />
            </div>
            <div class="input-set">
                <asp:Label ID="ISBNLb" runat="server" AssociatedControlID="ISBNTb">ISBN</asp:Label>
                <asp:TextBox ID="ISBNTb" runat="server" />
            </div>
            <div class="input-set">
                <asp:Label ID="FormatLb" runat="server" AssociatedControlID="FormatTb">Format</asp:Label>
                <asp:TextBox ID="FormatTb" runat="server" />
            </div>
            <div class="input-set">
                <asp:Label ID="PagesLb" runat="server" AssociatedControlID="PagesTb">Pages</asp:Label>
                <asp:TextBox ID="PagesTb" runat="server" TextMode="Number" />
            </div>
            <div class="input-set">
                <asp:Label ID="DescriptionLb" runat="server" AssociatedControlID="DescriptionTb">Description</asp:Label>
                <asp:TextBox ID="DescriptionTb" runat="server" TextMode="MultiLine" />
            </div>
        <asp:Button ID="AddBookBtn" Text="Add book" OnClick="AddBookBtn_Click" runat="server" />
        <asp:Label ID="StatusLb" runat="server" Visible="false"></asp:Label>
    </form>
</body>
</html>
