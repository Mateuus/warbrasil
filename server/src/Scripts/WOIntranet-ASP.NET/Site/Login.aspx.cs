using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!APICheck.IsAllowed(Request.UserHostAddress))
        {
            lblMsg.Text = "no access";
            return;
        }
        this.cmdLogin.ServerClick += new System.EventHandler(this.cmdLogin_ServerClick);
    }

    private bool ValidateUser(string userName, string pwd)
    {
        if (ConfigurationManager.AppSettings.Get("user") == userName && 
            ConfigurationManager.AppSettings.Get("pwd") == pwd)
            return true;

        return false;
    }

    private void cmdLogin_ServerClick(object sender, System.EventArgs e)
    {
        if (ValidateUser(txtUserName.Value, txtUserPass.Value))
            FormsAuthentication.RedirectFromLoginPage(txtUserName.Value, false);
        else
            Response.Redirect("Login.aspx", true);
    }

}
