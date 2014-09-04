using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class ShowScreenshots : WOApiWebPage
{
    string PICTURE_DIR = ConfigurationManager.AppSettings.Get("pictures");
    string SAVE_PICTURE_DIR = ConfigurationManager.AppSettings.Get("saved_pictures");

    int MinXPToBan = 5200;

    public class WOUser
    {
        public string gamertag;
        public int AccountStatus;
        public int HonorPoints;
        public string admin_note;

        public string gfxDescription;
    }

    string GetUserGraphicsCard(string CustomerID)
    {
        SqlCommand sqcmd = new SqlCommand();
        sqcmd.CommandType = CommandType.Text;
        sqcmd.CommandText = "select gfxDescription from DBG_HWInfo where CustomerID=@in_CustomerID";
        sqcmd.Parameters.AddWithValue("@in_CustomerID", CustomerID);


        try
        {
            CallWOApi(sqcmd);

            return getString("gfxDescription");
        }
        catch
        {
            return "no gfx card info";
        }
    }

    WOUser GetUserInfo(string CustomerID)
    {
        SqlCommand sqcmd = new SqlCommand();
        sqcmd.CommandType = CommandType.Text;
        sqcmd.CommandText = "select l.gamertag, l.accountstatus, l.HonorPoints, a.admin_note from LoginID l, AccountInfo a where l.CustomerID=@in_CustomerID and l.CustomerID=a.CustomerID";
        sqcmd.Parameters.AddWithValue("@in_CustomerID", CustomerID);

        if (!CallWOApi(sqcmd))
            throw new ApiExitException("GetUserInfo failed");

        WOUser user = new WOUser();
        user.gamertag = getString("gamertag");
        user.AccountStatus = getInt("AccountStatus");
        user.HonorPoints = getInt("HonorPoints");
        user.admin_note = getString("admin_note");
        user.gfxDescription = GetUserGraphicsCard(CustomerID);
        return user;
    }

    void ScanUser(string CustomerID)
    {
        string[] files = null;
        try
        {
            files = System.IO.Directory.GetFiles(PICTURE_DIR + CustomerID, "*.jpg");
            if (files.Length < 2) // show only users that have more than one reported pictures (to remove tons of false positives)
                return;
        }
        catch
        {
            // this crap might happen when we got directory listing
            // after deleting some dirs there. GetDirectories() will return not existing dir, so we fail
            return;
        }

        WOUser user = GetUserInfo(CustomerID);

        string clearurl = string.Format("ShowScreenshots.aspx?act=clear&i0={0}", CustomerID);
        string banurl = string.Format("ShowScreenshots.aspx?act=ban&i0={0}", CustomerID);
        Response.Write("<font size=+2>");
        if (user.HonorPoints < MinXPToBan)
        {
            Response.Write(string.Format("{0} - {1}, low level",
                CustomerID,
                user.gamertag));

            Response.Write("</font>");
            Response.Write("<br>\n");
            return;
        }


        Response.Write(string.Format("<a href=\"{0}\">CLEAR</a> {1} - {2}, ", 
            clearurl, 
            CustomerID, 
            user.gamertag));

        if (user.AccountStatus >= 200)
        {
            Response.Write("<font color=\"red\">USER IS ALREADY BANNED, ");
            Response.Write(string.Format(" reason: {0}", user.admin_note));
            Response.Write("</font>");
        }
        else
        {
            Response.Write("<font color=\"red\">Press ");
            Response.Write(string.Format("<a href=\"{0}\">BAN</a>", banurl));
            Response.Write(" to ban this user</font>");
        }
        Response.Write("</font>");
        Response.Write("<br>\n");
        Response.Write(string.Format("gfx: {0}<br>", user.gfxDescription));

        foreach(string file in files)
        {
            string[] arr = file.Split("\\".ToCharArray());
            Response.Write(string.Format("<img src=\"{0}\\{1}\\{2}\">\n", 
                "pictures", CustomerID, arr[arr.Length-1]));
        }

        Response.Write("<br>\n");
        Response.Write("<br>\n");
        Response.Write("<hr>\n");
    }

    void SavePictures(string CustomerID)
    {
        string dir1 = PICTURE_DIR + CustomerID;
        string dir2 = SAVE_PICTURE_DIR + CustomerID;
        System.IO.Directory.CreateDirectory(dir2);

        string[] files = System.IO.Directory.GetFiles(dir1);
        foreach(string f1 in files)
        {
            string f2 = dir2 + "\\" + System.IO.Path.GetFileName(f1);
            try
            {
                System.IO.File.Delete(f2);
                System.IO.File.Move(f1, f2);
            }
            catch
            {
            }
        }

        // theer might be new files uploading already...
        try
        {
            System.IO.Directory.Delete(dir1, true);
        }
        catch
        {
        }
    }

    void BanUserInSQL(string CustomerID)
    {
        WOUser user = GetUserInfo(CustomerID);
        if (user.AccountStatus >= 200)
            return;

        SqlCommand sqcmd1 = new SqlCommand();
        sqcmd1.CommandType = CommandType.Text;
        sqcmd1.CommandText = "update LoginID set accountstatus=200 where CustomerID=@in_CustomerID";
        sqcmd1.Parameters.AddWithValue("@in_CustomerID", CustomerID);
        if (!CallWOApi(sqcmd1))
            throw new ApiExitException("failed #3");

        string banReason = string.Format("{0}-{1} WH", DateTime.Now.Month, DateTime.Now.Day);
        if (user.admin_note.Length > 0)
            user.admin_note = banReason + ", " + user.admin_note;
        else
            user.admin_note = banReason;

        SqlCommand sqcmd2 = new SqlCommand();
        sqcmd2.CommandText = "update AccountInfo set admin_note=@admin_note where CustomerID=@in_CustomerID";
        sqcmd2.Parameters.AddWithValue("@in_CustomerID", CustomerID);
        sqcmd2.Parameters.AddWithValue("@admin_note", user.admin_note);
        if (!CallWOApi(sqcmd2))
            throw new ApiExitException("failed #4");

    }

    void BanUsers()
    {
        Response.Write("<font size=+3>");

        for (int i = 0; i < 999; i++)
        {
            string CustomerID = web.Param("i" + i.ToString());
            if (CustomerID == null)
                break;

            try
            {
                BanUserInSQL(CustomerID);

                System.IO.Directory.CreateDirectory(SAVE_PICTURE_DIR);
                SavePictures(CustomerID);
            }
            catch (Exception e)
            {
                Response.Write(e.Message + "<br>");
            }

            Response.Write("<p style=\"color:blue\">User " + CustomerID + " is banned</p>");
        }

        Response.Write("</font>");
        Response.Write("<br>\n");
        Response.Write("<br>\n");
        return;
    }

    void ClearUsers()
    {
        for (int i = 0; i < 999; i++)
        {
            string CustomerID = web.Param("i" + i.ToString());
            if (CustomerID == null)
                break;

            string dir = PICTURE_DIR + CustomerID;
            try
            {
                System.IO.Directory.Delete(dir, true);
                Response.Write(string.Format("{0} cleared<br>", CustomerID));
            }
            catch (Exception/* e*/)
            {
                Response.Write(string.Format("error deleting {0}<br>", dir));
            }
        }
    }

    protected override void Execute()
    {
        Response.Write("<body>\n");

        string xpToBan = web.Param("xp");
        if (xpToBan != null)
        {
            MinXPToBan = Convert.ToInt32(xpToBan);
        }

        string act = web.Param("act");
        if (act == "ban")
        {
            BanUsers();
            // continue
        }
        else if (act == "clear")
        {
            ClearUsers();
            // continue to 
        }
        else if (act != null)
        {
            Response.Write("bad act parameter\n");
            Response.Write("</body>\n");
            Response.Write("</html>\n");
            return;
        }

        int MAX_DIRS_TO_SHOW = 10;
        string[] dirs = System.IO.Directory.GetDirectories(PICTURE_DIR);
        Array.Sort<string>(dirs);

        Response.Write("<font size=+3>");
        Response.Write(string.Format("Showing {0} of {1} users<br>", Math.Min(MAX_DIRS_TO_SHOW, dirs.Length), dirs.Length));
        Response.Write("</font>");

        for(int i=0; i<dirs.Length && i<MAX_DIRS_TO_SHOW; i++)
        {
            string[] arr = dirs[i].Split("\\".ToCharArray());
            string CustomerID = arr[arr.Length - 1];
            ScanUser(CustomerID);
        }

        Response.Write("<br>");
        string clearall = string.Format("ShowScreenshots.aspx?act=clear");
        for (int i = 0; i < dirs.Length && i < MAX_DIRS_TO_SHOW; i++)
        {
            string[] arr = dirs[i].Split("\\".ToCharArray());
            string CustomerID = arr[arr.Length - 1];
            clearall += string.Format("&i{0}={1}", i, CustomerID);
        }

        Response.Write("<font size=+3>");
        Response.Write(string.Format("<a href=\"{0}\">CLEAR ALL SCREENSHOTS</a>", clearall));
        Response.Write("</font>");

        Response.Write("</body>\n");
        Response.Write("</html>\n");
    }
}

