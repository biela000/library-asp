using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Web;
using System.Web.WebSockets;
using MySql.Data.MySqlClient;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.OpenSsl;
using Org.BouncyCastle.Security;

namespace Library
{
    public static class DatabaseUtils
    {
        private static string publicRsaKey = File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "publicKey.pem"));
        public static string BuildConnectionString(string server, string port, string databaseName, string user, string password)
        {
            return "server=" + server + ";port=" + port + ";user=" + user + ";password=" + password +
                ";database=" + databaseName;
        }

        public static MySqlConnection Connect(string connectionString)
        {
            try
            {
                MySqlConnection connection = new MySqlConnection(connectionString);
                connection.Open();
                return connection;
            } catch (Exception ex)
            {
                Console.WriteLine("There was an error connecting to the database " + ex);
                return null;
            }
        }

        public static string HashPassword(string password)
        {
            byte[] salt;
            new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);
            var pbkfd2 = new Rfc2898DeriveBytes(password, salt, 100000);
            byte[] hash = pbkfd2.GetBytes(20);
            byte[] hashBytes = new byte[36];
            Array.Copy(salt, 0, hashBytes, 0, 16);
            Array.Copy(hash, 0, hashBytes, 16, 20);
            return Convert.ToBase64String(hashBytes);
        }

        public static string CreateToken(List<Claim> claims, string privateRsaKey)
        {
            RSAParameters rsaParams;
            using (var tr = new StringReader(privateRsaKey))
            {
                var pemReader = new PemReader(tr);
                var keyPair = pemReader.ReadObject() as AsymmetricCipherKeyPair;
                if (keyPair == null)
                {
                    throw new Exception("Could not read RSA private key");
                }
                var privateRsaParams = keyPair.Private as RsaPrivateCrtKeyParameters;
                rsaParams = DotNetUtilities.ToRSAParameters(privateRsaParams);
            }
            using (RSACryptoServiceProvider rsa = new RSACryptoServiceProvider())
            {
                rsa.ImportParameters(rsaParams);
                Dictionary<string, object> payload = claims.ToDictionary(k => k.Type, v => (object)v.Value);
                return Jose.JWT.Encode(payload, rsa, Jose.JwsAlgorithm.RS256);
            }
        }

        public static string DecodeToken(string token)
        {
            RSAParameters rsaParams;

            using (var tr = new StringReader(publicRsaKey))
            {
                var pemReader = new PemReader(tr);
                var publicKeyParams = pemReader.ReadObject() as RsaKeyParameters;
                if (publicKeyParams == null)
                {
                    throw new Exception("Could not read RSA public key");
                }
                rsaParams = DotNetUtilities.ToRSAParameters(publicKeyParams);
            }
            using (RSACryptoServiceProvider rsa = new RSACryptoServiceProvider())
            {
                rsa.ImportParameters(rsaParams);
                return Jose.JWT.Decode(token, rsa, Jose.JwsAlgorithm.RS256);
            }
        }

        public static void ProtectUnlessConnectedToDb(HttpResponse response, string connectionString)
        {
            if (connectionString == null)
            {
                response.Redirect("/Connection.aspx");
            }
        }

        public static void ProtectUnlessLoggedIn(HttpResponse response, HttpCookie JWTToken)
        {
            try
            {
                object decodedToken = DecodeToken(JWTToken.Value);
            } catch (Exception ex)
            {
                response.Redirect("/Login.aspx");
            }
        }

        public static void InsertBook(MySqlConnection connection, string authors, string title, string release_date, string ISBN, string format, int pages, string description)
        {
            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "INSERT INTO books (Authors, Title, Release_date, ISBN, Format, Pages, Description) VALUES (@Authors, @Title, @Release_date, @ISBN, @Format, @Pages, @Description)";
            command.Parameters.AddWithValue("@Authors", authors);
            command.Parameters.AddWithValue("@Title", title);
            command.Parameters.AddWithValue("@Release_date", release_date);
            command.Parameters.AddWithValue("@ISBN", ISBN);
            command.Parameters.AddWithValue("@Format", format);
            command.Parameters.AddWithValue("@Pages", pages);
            command.Parameters.AddWithValue("@Description", description);
            command.ExecuteNonQuery();
        }

        public static string[] GetOneBookById(MySqlConnection connection, int id)
        {
            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "SELECT * FROM books WHERE Id = @Id";
            command.Parameters.AddWithValue("@Id", id);
            var reader = command.ExecuteReader();
            if (reader.Read())
            {
                return new string[] { reader.GetString("Id"), reader.GetString("Authors"), reader.GetString("Title"), reader.GetString("Release_date"), reader.GetString("ISBN"), reader.GetString("Format"), reader.GetString("Pages"), reader.GetString("Description") };
            } else
            {
                throw new Exception("No record with given ID");
            }
        }

        public static void UpdateBook(MySqlConnection connection, int id, string authors, string title, string release_date, string ISBN, string format, int pages, string description)
        {
            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "UPDATE books SET Authors=@Authors, Title=@Title, Release_date=@Release_date, ISBN=@ISBN, Format=@Format, Pages=@Pages, Description=@Description WHERE Id=@Id";
            command.Parameters.AddWithValue("@Authors", authors);
            command.Parameters.AddWithValue("@Title", title);
            command.Parameters.AddWithValue("@Release_date", release_date);
            command.Parameters.AddWithValue("@ISBN", ISBN);
            command.Parameters.AddWithValue("@Format", format);
            command.Parameters.AddWithValue("@Pages", pages);
            command.Parameters.AddWithValue("@Description", description);
            command.Parameters.AddWithValue("@Id", id);
            command.ExecuteNonQuery();
        }

        public static void DeleteBook(MySqlConnection connection, int id)
        {
            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "DELETE FROM books WHERE Id=@Id";
            command.Parameters.AddWithValue("@Id", id);
            command.ExecuteNonQuery();
        }

        public static MySqlDataReader GetBooksByTitleAndAuthors(MySqlConnection connection, string title, string authors)
        {
            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "SELECT * FROM books WHERE Title LIKE @Title OR Authors LIKE @Authors";
            command.Parameters.AddWithValue("@Title", "%" + title + "%");
            command.Parameters.AddWithValue("@Authors", "%" + authors + "%");
            var reader = command.ExecuteReader();
            return reader;
        }
    }
}