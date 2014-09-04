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
public abstract class WOApiWebPage : System.Web.UI.Page
{
    public SQLBase sql = new SQLBase();
    public SqlDataReader reader = null;

    public string IN_JSON = "";
    public ResponseLog LResponse = new ResponseLog();

    abstract protected void Execute();

    public WOApiWebPage()
	{
    }

    bool WhitelistAmazonIP()
    {
        string ip = Request.UserHostAddress;

        return true;
    }

    public int getInt(string name)
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

    public string getString(string name)
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

    public bool CallWOApi(SqlCommand sqcmd)
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

        try
        {
            string rm = "";
            try
            {
                rm = reader["ResultMsg"].ToString();
            }
            catch { }

            int rc = Convert.ToInt32(reader["ResultCode"]);
            if (rc != 0)
                throw new ApiExitException("ResultCode: " + rc.ToString());
        }
        catch (Exception)
        {
            throw new ApiExitException("ResultCode not set");
        }

        // move to actual result data
        reader.NextResult();
        return true;
    }

    void LogAccess()
    {
        try
        {
            string fname = @"C:\inetpub\logss_CRASH\WOAmazon.txt";
            using (StreamWriter w = File.AppendText(fname))
            {
                w.WriteLine(string.Format("\n\n-----------\n{0} from {1}\n{2}\ndata1:{3}",
                    DateTime.Now.ToString(),
                    Request.UserHostAddress,
                    HttpContext.Current.Request.Url.AbsoluteUri,
                    IN_JSON));

                /*
                foreach (string key in Request.Form.Keys)
                    w.WriteLine("POST: {0}:{1}", key, Request.Form[key].ToString());
                foreach (string key in Request.QueryString.Keys)
                    w.WriteLine("GET: {0}:{1}", key, Request.QueryString[key].ToString());
                foreach (string key in Request.Headers.Keys)
                    w.WriteLine("HDR: {0}:{1}", key, Request.Headers[key].ToString());
                 **/

                w.Close();
            }
        }
        catch { }
    }

    void LogResult()
    {
        try
        {
            string fname = @"C:\inetpub\logss_CRASH\WOAmazon.txt";
            using (StreamWriter w = File.AppendText(fname))
            {
                w.WriteLine(string.Format("out: {0}\n",
                    LResponse.msg));
                w.Close();
            }
        }
        catch { }
    }

    protected void Page_Load(object sender, EventArgs _e)
    {
        try
        {
            // need to set culture for floating point separator! (need to be '.')
            System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");

            if (!WhitelistAmazonIP())
            {
                Response.Write("fraud");
                return;
            }

            // Amazon sending request in following format
            // HDR: Content-Length:59
            // HDR: Content-Type:application/json; charset=ISO-8859-1
            if (Request.InputStream == null)
                throw new ApiExitException("no Request.InputStream");
            using (StreamReader sr = new StreamReader(Request.InputStream))
            {
                IN_JSON = sr.ReadToEnd();
            }

            LogAccess();

            if (IN_JSON == null || IN_JSON.Length == 0)
                throw new ApiExitException("empty post body");

            sql.Connect();

            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Execute();
        }
        catch (Exception e)
        {
            JSON.StatusFailure ans = new JSON.StatusFailure();
            ans.Status = "FAILURE_UNKNOWN";
            ans.Reason = e.Message;
            LResponse.Write(JSONHelper.ToJson(ans));
            //Response.Write(e.ToString());
        }

        // close associated sql resources
        if(reader != null)
        {
            reader.Close();
            reader = null;
        }
        sql.Disconnect();

        // out page data
        LogResult();
        if (LResponse.msg.Length > 0)
            Response.Write(LResponse.msg);
    }
}
