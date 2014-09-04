using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;

public partial class GetAddresses_Default : WOApiWebPage
{
    [DataContract]
    public class Addresses
    {
        [DataMember]
        public string Address;
        [DataMember]
        public string AddressDescription;
    }

    [DataContract]
    public class JsonReq
    {
        [DataMember]
        public string AccountToken;
    }

    [DataContract]
    public class JsonAns
    {
        [DataMember]
        public string Status { get; set; }

        [DataMember]
        public Addresses[] Addresses = { new Addresses() };
    }

    protected JsonAns SandboxTest(JsonReq req)
    {
        JsonAns ans = new JsonAns();
        if (req.AccountToken == "AMZNTESTGETADDRESSESSUCCESS")
        {
            ans.Status = "SUCCESS";
            ans.Addresses[0].Address = "AMZNTESTVALIDADDRESS";
            ans.Addresses[0].AddressDescription = "AMZNTESTVALIDADDRESSDESCRIPTION";
            return ans;
        }

        if (req.AccountToken == "AMZNTESTGETADDRESSESFAILUREDISABLED")
        {
            ans.Status = "FAILURE_ACCOUNT_DISABLED";
            ans.Addresses = new Addresses[0];
            return ans;
        }

        return null;
    }

    protected JsonAns GetAddreses(JsonReq req)
    {
        JsonAns ans = SandboxTest(req);
        if (ans != null)
            return ans;

        SqlCommand sqcmd = new SqlCommand();
        sqcmd.CommandType = CommandType.StoredProcedure;
        sqcmd.CommandText = "WO_AMAZON_GetAddresses";
        sqcmd.Parameters.AddWithValue("@in_AccountToken", req.AccountToken);

        CallWOApi(sqcmd);
        reader.Read();

        int CustomerID = getInt("CustomerID");
        int AccountStatus = getInt("AccountStatus");
        string AccountName = getString("AccountName");

        ans = new JsonAns();
        if (CustomerID == 0)
        {
            ans.Status = "FAILURE_ACCOUNT_INVALID";
            ans.Addresses = new Addresses[0];
        }
        else if (AccountStatus >= 200)
        {
            ans.Status = "FAILURE_ACCOUNT_DISABLED";
            ans.Addresses = new Addresses[0];
        }
        else
        {
            ans.Status = "SUCCESS";
            ans.Addresses[0].Address = CustomerID.ToString();
            ans.Addresses[0].AddressDescription = AccountName;
        }

        return ans;
    }

    protected override void Execute()
    {
        //IN_JSON = "{\"AccountToken\":\"1000\"}";
        //Response.Write("json1: " + IN_JSON);

        JsonReq req = null;
        try
        {
            req = JSONHelper.Deserialise<JsonReq>(IN_JSON);
        }
        catch(Exception e)
        {
            throw new ApiExitException("bad json:" + e.Message);
        }
        //Response.Write("<br>token: " + req.AccountToken);

        JsonAns ans = GetAddreses(req);
        LResponse.Write(JSONHelper.ToJson(ans));
    }
}
