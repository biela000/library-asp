<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddBook.aspx.cs" Inherits="Library.AddBook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Add book</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700&display=swap" rel="stylesheet" />
    <link href="reset.css" rel="stylesheet" />
    <link href="variables.css" rel="stylesheet" />
    <link href="global.css" rel="stylesheet" />
    <link href="add-book.css" rel="stylesheet" />
</head>
<body>
    <div class="main-header">
        <h1>Add a new book</h1>
    </div>
    <form id="form1" runat="server" class="main-form">
        <asp:Button ID="GoBackBtn" runat="server" OnClick="GoBackBtn_Click" Text="Go back" />
        <div class="input-set id-input-set">
            <asp:Label ID="IdLb" runat="server" AssociatedControlID="IdTb">Id</asp:Label>
            <asp:TextBox ID="IdTb" runat="server" Enabled="false" />
        </div>
        <div class="input-set">
            <asp:Label ID="AuthorsLb" runat="server" AssociatedControlID="AuthorsTb">Authors</asp:Label>
            <asp:TextBox ID="AuthorsTb" runat="server" />
            <asp:RequiredFieldValidator ID="AuthorsRfv" runat="server" ControlToValidate="AuthorsTb" ErrorMessage="Authors is required" ValidationGroup="BookValidators" />
        </div>
        <div class="input-set">
            <asp:Label ID="TitleLb" runat="server" AssociatedControlID="TitleTb">Title</asp:Label>
            <asp:TextBox ID="TitleTb" runat="server" />
            <asp:RequiredFieldValidator ID="TitleRfv" runat="server" ControlToValidate="TitleTb" ErrorMessage="Title is required" ValidationGroup="BookValidators" />
        </div>
        <div class="input-set">
            <asp:Label ID="Release_dateLb" runat="server" AssociatedControlID="Release_dateTb">Release_date</asp:Label>
            <asp:TextBox ID="Release_dateTb" runat="server" />
            <asp:RequiredFieldValidator ID="Release_dateRfv" runat="server" ControlToValidate="Release_dateTb" ErrorMessage="Release_date is required" ValidationGroup="BookValidators" />
            <asp:RegularExpressionValidator ID="Release_dateRev" runat="server" ControlToValidate="Release_dateTb" ErrorMessage="Release_date must be
in format dd-MM-yyyy"
                ValidationExpression="^([0-2][0-9]|(3)[0-1])(-)(((0)[0-9])|((1)[0-2]))(-)([0-9]{4})$" ValidationGroup="BookValidators" />
        </div>
        <div class="input-set">
            <asp:Label ID="ISBNLb" runat="server" AssociatedControlID="ISBNTb">ISBN</asp:Label>
            <asp:TextBox ID="ISBNTb" runat="server" />
            <asp:RequiredFieldValidator ID="ISBNRfv" runat="server" ControlToValidate="ISBNTb" ErrorMessage="ISBN is required" ValidationGroup="BookValidators" />
        </div>
        <div class="input-set">
            <asp:Label ID="FormatLb" runat="server" AssociatedControlID="FormatTb">Format</asp:Label>
            <asp:TextBox ID="FormatTb" runat="server" />
            <asp:RequiredFieldValidator ID="FormatRfv" runat="server" ControlToValidate="FormatTb" ErrorMessage="Format is required" ValidationGroup="BookValidators" />
            <asp:RegularExpressionValidator ID="FormatRev" runat="server" ControlToValidate="FormatTb" ErrorMessage="Format must be
less than 4 characters"
                ValidationExpression="^.{1,4}$" ValidationGroup="BookValidators" />
        </div>
        <div class="input-set">
            <asp:Label ID="PagesLb" runat="server" AssociatedControlID="PagesTb">Pages</asp:Label>
            <asp:TextBox ID="PagesTb" runat="server" TextMode="Number" />
            <asp:RequiredFieldValidator ID="PagesRfv" runat="server" ControlToValidate="PagesTb" ErrorMessage="Pages is required" ValidationGroup="BookValidators" />
            <asp:RegularExpressionValidator ID="PagesRev" runat="server" ControlToValidate="PagesTb" ErrorMessage="Pages must be
between 1 and 999"
                ValidationExpression="^([1-9]|[1-9][0-9]|[1-9][0-9][0-9]|[1-2][0-9][0-9][0-9]|(3)[0-1][0-9][0-9][0-9]|(3)[2][0-6][0-7][0-9]|(3)[2][0-6][8][0-7])$" ValidationGroup="BookValidators" />
        </div>
        <div class="input-set">
            <asp:Label ID="DescriptionLb" runat="server" AssociatedControlID="DescriptionTb">Description</asp:Label>
            <asp:TextBox ID="DescriptionTb" runat="server" TextMode="MultiLine" />
            <asp:RequiredFieldValidator ID="DescriptionRfv" runat="server" ControlToValidate="DescriptionTb" ErrorMessage="Description is required" ValidationGroup="BookValidators" />
        </div>
        <asp:Button ID="AddBookBtn" Text="Add book" OnClick="AddBookBtn_Click" runat="server" />
    </form>
    <asp:Label ID="StatusLb" runat="server" Visible="false"></asp:Label>
</body>
</html>
