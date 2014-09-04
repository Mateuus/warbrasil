using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.IO.Compression;

/// <summary>
/// Summary description for WOApiWebPage
/// </summary>
public abstract class WOApiWebPage : System.Web.UI.Page
{
    protected SQLBase sql = new SQLBase();
    protected SqlDataReader reader = null;

    protected WebHelper web = null;
    protected string LastIP = "0.0.0.0";

    abstract protected void Execute();

    public WOApiWebPage()
	{
    }

    protected string xml_attr(string name, Object var)
    {
        string xml = string.Format("{0}=\"{1}\"\n", name, Server.HtmlEncode(var.ToString()));
        return xml;
    }

    protected int getInt(string name)
    {
        try
        {
            int var = Convert.ToInt32(reader[name]);
            return var;
        }
        catch (Exception)
        {
            throw new ApiExitException("bad field " + name);
        }
    }

    protected string getString(string name)
    {
        try
        {
            return reader[name].ToString();
        }
        catch (Exception)
        {
            throw new ApiExitException("no field " + name);
        }
    }

    protected bool CallWOApi(SqlCommand sqcmd)
    {
        // need to close previous reader here, because of
        // "There is already an open DataReader associated with this Command which must be closed first"
        if (reader != null)
        {
            reader.Close();
            reader = null;
        }

        reader = sql.Select(sqcmd);
        if (reader == null)
            return false;
        reader.Read();

        return true;
    }

    protected void Page_Load(object sender, EventArgs _e)
    {
        try
        {
            web = new WebHelper(this);
            LastIP = Request.UserHostAddress;

            sql.Connect();

            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Execute();
        }
        catch (ApiExitException e)
        {
            Response.Write("WO_5" + e.Message);
        }
        catch (Exception e)
        {
            Response.Write("WO_5" + e.ToString());
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
