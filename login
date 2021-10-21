using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace OnlineCarRentalSystem2
{
    public partial class Login : System.Web.UI.Page
    {
        string connetionString;
        SqlConnection con;
        DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            connetionString = @"Data Source=(LocalDB)\v11.0;AttachDbFilename=D:\project12\OnlineCarRentalSystem2\OnlineCarRentalSystem2\App_Data\carrental1.mdf;Integrated Security=True";
            con = new SqlConnection(connetionString);
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            string username = txt_user.Text.Trim();
            string pwd = txt_password.Text.Trim();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "SELECT user_username,user_password FROM registration where CONVERT(VARCHAR,user_username)='" + username + "' and CONVERT(VARCHAR, user_password)='" + pwd + "'";
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Session.Add("UserID", dt.Rows[0][0].ToString());
                Session.Add("Username", dt.Rows[0][1].ToString());
                Response.Redirect("~/home.aspx", false);
            }
            else
            {
                Response.Write("Invalid username or password");
            }

        }
    }
}
