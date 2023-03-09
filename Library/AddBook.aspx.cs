using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Library
{
    public partial class AddBook : System.Web.UI.Page
    {
        private bool isInEditMode = false;
        private int editedRecordId;
        protected void Page_Load(object sender, EventArgs e)
        {
            DatabaseUtils.ProtectUnlessConnectedToDb(Response, Session["ConnectionString"] as string);
            DatabaseUtils.ProtectUnlessLoggedIn(Response, Request.Cookies["JWT"]);

            if (Request.QueryString["id"] != null && IdTb.Text == "")
            {
                isInEditMode = true;
                editedRecordId = int.Parse(Request.QueryString["id"]);
                MySqlConnection connection = DatabaseUtils.Connect(Session["ConnectionString"] as string);
                try
                {
                    var bookInfo = DatabaseUtils.GetOneBookById(connection, editedRecordId);
                    IdTb.Text = bookInfo[0];
                    AuthorsTb.Text = bookInfo[1];
                    TitleTb.Text = bookInfo[2];
                    Release_dateTb.Text = bookInfo[3];
                    ISBNTb.Text = bookInfo[4];
                    FormatTb.Text = bookInfo[5];
                    PagesTb.Text = bookInfo[6];
                    DescriptionTb.Text = bookInfo[7];
                }
                catch (Exception ex)
                {
                    isInEditMode = false;
                    Response.Redirect("/AddBook.aspx");
                }
            } else if (Request.QueryString["id"] != null && IdTb.Text != "")
            {
                isInEditMode = true;
                editedRecordId = int.Parse(Request.QueryString["id"]);
            }
            if (isInEditMode)
            {
                SiteTitleLb.Text = "Edit an existing book";
                AddBookBtn.Text = "Edit book";
            }
        }

        private void ClearTbs()
        {
            AuthorsTb.Text = "";
            TitleTb.Text = "";
            Release_dateTb.Text = "";
            ISBNTb.Text = "";
            FormatTb.Text = "";
            PagesTb.Text = "";
            DescriptionTb.Text = "";
        }

        protected void AddBookBtn_Click(object sender, EventArgs e)
        {
            Page.Validate("BookValidators");
            if (!Page.IsValid)
            {
                return;
            }
            MySqlConnection connection = DatabaseUtils.Connect(Session["ConnectionString"] as string);
            try
            {
                if (!isInEditMode)
                {
                    DatabaseUtils.InsertBook(connection, AuthorsTb.Text,
                                        TitleTb.Text, Release_dateTb.Text,
                                        ISBNTb.Text, FormatTb.Text,
                                        int.Parse(PagesTb.Text), DescriptionTb.Text);
                    StatusLb.Text = "New book added to the database";
                    StatusLb.Visible = true;
                    ClearTbs();
                } else
                {
                    StatusLb.Text = TitleTb.Text;
                    StatusLb.Visible = true;
                    DatabaseUtils.UpdateBook(connection, editedRecordId,
                                            AuthorsTb.Text,
                                            TitleTb.Text, Release_dateTb.Text,
                                        ISBNTb.Text, FormatTb.Text,
                                        int.Parse(PagesTb.Text), DescriptionTb.Text);
                }
                connection.Close();
            }
            catch (Exception ex)
            {
                StatusLb.Text = ex.Message;
                StatusLb.Visible = true;
            }
        }

        protected void GoBackBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Books.aspx");
        }
    }
}