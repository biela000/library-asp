using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Library
{
    public partial class Connection : System.Web.UI.Page
    {
        private MySqlConnection connection = null;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ConnectBtn_Click(object sender, EventArgs e)
        {
            string connectionString = DatabaseUtils.BuildConnectionString(ServerTb.Text, PortTb.Text, DatabaseTb.Text, UserTb.Text, PasswordTb.Text);
            Session["ConnectionString"] = connectionString;
            connection = DatabaseUtils.Connect(connectionString);
            ConnectionStatusLb.Visible = true;
            if (connection != null)
            {
                ConnectionStatusLb.Text = "Valid connection data";
                GoToLoginBtn.Visible = true;
                GoToLoginBtn.Enabled = true;
            } else
            {
                ConnectionStatusLb.Text = "Could not connect to the database";
            }
        }

        protected void GoToLoginBtn_Click(object sender, EventArgs e)
        {
            if (connection != null)
            {
                connection.Close();
            }
            Response.Redirect("/Login.aspx");
        }
    }
}