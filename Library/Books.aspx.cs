﻿using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Library
{
    public partial class Books : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DatabaseUtils.ProtectUnlessLoggedIn(Response, Request.Cookies["JWT"]);
            DatabaseUtils.ProtectUnlessConnectedToDb(Response, Session["ConnectionString"] as string);
            MySqlConnection connection = DatabaseUtils.Connect(Session["ConnectionString"] as string);
            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "SELECT * FROM books";
            MySqlDataReader reader = command.ExecuteReader();
            FillGridViewWithData(reader);
            connection.Close();
        }

        private void FillGridViewWithData(MySqlDataReader reader)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ID", typeof(int));
            dt.Columns.Add("Authors", typeof(string));
            dt.Columns.Add("Title", typeof(string));
            dt.Columns.Add("Release_date", typeof(string));
            dt.Columns.Add("ISBN", typeof(string));
            dt.Columns.Add("Format", typeof(string));
            dt.Columns.Add("Pages", typeof(int));
            dt.Columns.Add("Description", typeof(string));
            StatusLb.Text = "";
            while (reader.Read())
            {
                DataRow row = dt.NewRow();
                row["ID"] = reader.GetInt16("Id");
                row["Authors"] = reader.GetString("Authors");
                row["Title"] = reader.GetString("Title");
                row["Release_date"] =  reader.GetString("Release_date");
                row["ISBN"] = reader.GetString("ISBN");
                row["Format"] = reader.GetString("Format");
                row["Pages"] = reader.GetInt16("Pages");
                row["Description"] = reader.GetString("Description");
                dt.Rows.Add(row);
            }
            BooksGridVw.DataSource = dt;
            BooksGridVw.DataBind();
        }

        protected void BooksGridVw_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "BookEditBtn_Click")
            {
                Response.Redirect("/AddBook.aspx?id=" + e.CommandArgument.ToString());
            } else if (e.CommandName == "BookDeleteBtn_Click")
            {
                try
                {
                    MySqlConnection connection = DatabaseUtils.Connect(Session["ConnectionString"] as string);
                    DatabaseUtils.DeleteBook(connection, int.Parse(e.CommandArgument.ToString()));
                    connection.Close();
                    Response.Redirect("/Books.aspx");
                }
                catch (Exception ex)
                {
                    StatusLb.Text = ex.Message;
                    StatusLb.Visible = true;
                }
            }
        }

        protected void SerchBtn_Click(object sender, EventArgs e)
        {
            try
            {
                MySqlConnection connection = DatabaseUtils.Connect(Session["ConnectionString"] as string);
                var reader = DatabaseUtils.GetBooksByTitleAndAuthors(connection, TitleTb.Text, AuthorsTb.Text, Release_dateTb.Text, ISBNTb.Text, FormatTb.Text, PagesTb.Text, DescriptionTb.Text);
                FillGridViewWithData(reader);
                connection.Close();
            }
            catch (Exception ex)
            {
                StatusLb.Text = ex.Message;
            }
       }

        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            Response.Cookies["JWT"].Value = "";
            Response.Redirect("/Login.aspx");
        }
    }
}