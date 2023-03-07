<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="Library.Books" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form runat="server">
        <div class="search-container">
            <div class="input-set">
                <asp:Label runat="server" ID="TitleLb" AssociatedControlID="TitleTb">Title</asp:Label>
                <asp:TextBox runat="server" ID="TitleTb" />
            </div>
            <div>OR</div>
            <div class="input-set">
                <asp:Label runat="server" ID="AuthorsLb" AssociatedControlID="AuthorsTb">Authors</asp:Label>
                <asp:TextBox runat="server" ID="AuthorsTb" />
            </div>
            <asp:Button runat="server" ID="SerchBtn" Text="Search" OnClick="SerchBtn_Click" />
        </div>
    <asp:GridView ID="BooksGridVw" AllowPaging="true" runat="server" OnRowCommand="BooksGridVw_RowCommand">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="BookEditBtn" Text="Edit" runat="server" CommandName="BookEditBtn_Click" CommandArgument='<%# Eval("ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="BookDeleteBtn" Text="Delete" runat="server" CommandName="BookDeleteBtn_Click" CommandArgument='<%# Eval("ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <a href="/AddBook.aspx">Add new book</a>
    <asp:Label ID="StatusLb" runat="server" Visible="false"></asp:Label>
    </form>
</body>
</html>
