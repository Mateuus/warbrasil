using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.IO;
using System.IO.Compression;
using System.Globalization;

/// <summary>
/// Summary description for WOApiWebPage
/// </summary>
public abstract class ApiWebPage : System.Web.UI.Page
{
    protected SQLBase sql = null;
    protected SqlDataReader reader = null;
    protected WebHelper web = null;

    abstract protected void Execute();

    public ApiWebPage()
	{
    }

    bool WhiteListIPs()
    {
        string ip = Request.UserHostAddress;
        switch (ip)
        {
            case "127.0.0.1":
            case "80.240.210.87":
            case "74.208.44.54":
                return true;
        }
        return false;
    }

    protected void Page_Load(object sender, EventArgs _e)
    {
        try
        {
            if (!WhiteListIPs())
                throw new ApiExitException("denied");

            // need to set culture for floating point separator! (need to be '.')
            System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            web = new WebHelper(this);

            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Execute();
        }
        catch (Exception e)
        {
            ApiReturnData rd = new ApiReturnData();
            rd.ErrorMessage = e.Message;
            Response.Write(JSONHelper.ToJson(rd));
        }

        // close associated sql resources
        if(reader != null)
        {
            reader.Close();
            reader = null;
        }
        sql.Disconnect();
    }
}
