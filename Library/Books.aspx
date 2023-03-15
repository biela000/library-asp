<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="Library.Books" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Books</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700&display=swap" rel="stylesheet" />
    <link href="reset.css" rel="stylesheet" />
    <link href="variables.css" rel="stylesheet" />
    <link href="global.css" rel="stylesheet" />
    <link href="books.css" rel="stylesheet" />
</head>
<body>
    <div class="main-header">
        <h1>B00ks</h1>
    </div>
    <form runat="server" class="main-form">
        <asp:Button ID="LogoutBtn" Text="Log out" runat="server" OnClick="LogoutBtn_Click" />
        <div class="search-container">
            <div class="input-set">
                <asp:Label runat="server" ID="TitleLb" AssociatedControlID="TitleTb">Title</asp:Label>
                <asp:TextBox runat="server" ID="TitleTb" />
            </div>
            <div class="connector">OR</div>
            <div class="input-set">
                <asp:Label runat="server" ID="AuthorsLb" AssociatedControlID="AuthorsTb">Authors</asp:Label>
                <asp:TextBox runat="server" ID="AuthorsTb" />
            </div>
            <div class="input-set">
                <asp:Label runat="server" ID="Release_dateLb" AssociatedControlID="Release_dateTb">Release_date</asp:Label>
                <asp:TextBox runat="server" ID="Release_dateTb" />
            </div>
            <div class="connector">OR</div>
            <div class="input-set">
                <asp:Label runat="server" ID="ISBNLb" AssociatedControlID="ISBNTb">ISBN</asp:Label>
                <asp:TextBox runat="server" ID="ISBNTb" />
            </div>
            <div class="input-set">
                <asp:Label runat="server" ID="FormatLb" AssociatedControlID="FormatTb">Format</asp:Label>
                <asp:TextBox runat="server" ID="FormatTb" />
            </div>
            <div class="connector">OR</div>
            <div class="input-set">
                <asp:Label runat="server" ID="PagesLb" AssociatedControlID="PagesTb">Pages</asp:Label>
                <asp:TextBox runat="server" ID="PagesTb" TextMode="Number" />
            </div>
            <div class="input-set">
                <asp:Label runat="server" ID="DescriptionLb" AssociatedControlID="DescriptionTb">Description</asp:Label>
                <asp:TextBox runat="server" ID="DescriptionTb" />
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
        <a href="/AddBook.aspx" class="new-book-link">Add new book</a>
        <asp:Label ID="StatusLb" runat="server" Visible="false"></asp:Label>
    </form>
</body>
</html>
