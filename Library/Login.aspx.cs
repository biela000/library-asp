using JWT;
using JWT.Algorithms;
using JWT.Builder;
using JWT.Serializers;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Library
{
    public partial class Login : System.Web.UI.Page
    {
        private MySqlConnection connection = null;
        private string secret = "LKHJACN1274689BJKSAB0//7*&8254685GHA92V$^(*429846B196Vkajbf&*@$^Talkrasdasdavs::aca@$986SRAfa.adafvafasf";
        protected void Page_Load(object sender, EventArgs e)
        {
            DatabaseUtils.ProtectUnlessConnectedToDb(Response, Session["ConnectionString"] as string);
        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            Page.Validate("RegisterValidators");
            if (!Page.IsValid && RegisterCheckbox.Checked)
            {
                return;
            }
            bool isUserNew = RegisterCheckbox.Checked;
            connection = DatabaseUtils.Connect(Session["ConnectionString"].ToString());
            string hashedPassword = DatabaseUtils.HashPassword(PasswordTb.Text);
            MySqlCommand command = connection.CreateCommand();
            if (isUserNew && connection != null)
            {
                try
                {
                    command.CommandText = "INSERT INTO users(Login, Email, Password) VALUES(@Login, @Email, @Password)";
                    command.Parameters.AddWithValue("@Login", LoginTb.Text);
                    command.Parameters.AddWithValue("@Email", EmailTb.Text);
                    command.Parameters.AddWithValue("@Password", hashedPassword);
                    command.ExecuteNonQuery();
                    EmailTb.Text = "";
                    PasswordTb.Text = "";
                    RegisterCheckbox.Checked = false;
                    LoginMessageLb.Text = "Your account has been created";
                    LoginMessageLb.Visible = true;
                    EmailInputPanel.Visible = false;
                    EmailInputPanel.Enabled = false;
                    LoginBtn.Text = "Login";
                } catch (MySqlException ex) {
                    LoginMessageLb.Text = "Login is already taken";
                    LoginMessageLb.Visible = true;
                    Console.WriteLine("There was an error creating a new user" + ex);
                }
            } else if (!isUserNew && connection != null)
            {
                try
                {
                    command.CommandText = "SELECT password FROM users WHERE Login=@Login";
                    command.Parameters.AddWithValue("@Login", LoginTb.Text);
                    string truePassword = command.ExecuteScalar() as string;
                    if (truePassword == null)
                    {
                        throw new UnauthorizedAccessException();
                    }
                    byte[] hashBytes = Convert.FromBase64String(truePassword);
                    byte[] salt = new byte[16];
                    Array.Copy(hashBytes, 0, salt, 0, 16);
                    var pbkdf2 = new Rfc2898DeriveBytes(PasswordTb.Text, salt, 100000);
                    byte[] hash = pbkdf2.GetBytes(20);
                    for (int i = 0; i < 20; i++)
                    {
                        if (hashBytes[i + 16] != hash[i])
                        {
                            throw new UnauthorizedAccessException();
                        }
                    }
                    DateTime currentDate = new DateTime();
                    var payload = new Dictionary<string, object>
                    {
                        { "login", LoginTb.Text },
                        { "isAdmin", false },
                        { "expiresAt", currentDate.AddHours(1).ToShortDateString() }
                    };
                    string publicKey = File.ReadAllText(Server.MapPath("~/publicKey.pem"));
                    string privateKey = File.ReadAllText(Server.MapPath("~/privateKey.pem"));
                    var claims = new List<Claim>();
                    claims.Add(new Claim("login", LoginTb.Text));
                    claims.Add(new Claim("isAdmin", "0"));
                    claims.Add(new Claim("exp", DateTimeOffset.UtcNow.AddHours(1).ToUnixTimeSeconds().ToString()));
                    var token = DatabaseUtils.CreateToken(claims, privateKey);
                    var cookie = new HttpCookie("JWT", token);
                    Response.Cookies.Add(cookie);
                    Response.Redirect("/Books.aspx");
                } catch (MySqlException ex)
                {
                    LoginMessageLb.Text = "Server error 500";
                    LoginMessageLb.Visible = true;

                } catch (UnauthorizedAccessException ex)
                {
                    LoginMessageLb.Text = "The login or the password are not correct";
                    LoginMessageLb.Visible = true;
                } catch (Exception ex)
                {
                    LoginMessageLb.Text = "Server error 500";
                    LoginMessageLb.Visible = true;
                }
            }
            connection.Close();
        }

        protected void RegisterCheckbox_CheckedChanged(object sender, EventArgs e)
        {
            EmailInputPanel.Visible = RegisterCheckbox.Checked;
            EmailInputPanel.Enabled = RegisterCheckbox.Checked;
            LoginBtn.Text = RegisterCheckbox.Checked ? "Register" : "Login";
            if (!RegisterCheckbox.Checked)
            {
                LoginRfv.Enabled = false;
                PasswordRev.Enabled = false;
                EmailRev.Enabled = false;
            }
        }
    }
}