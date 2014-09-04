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

public partial class IsItemFulfillable_Default : WOApiWebPage
{
    [DataContract]
    public class JsonReq
    {
        [DataMember]
        public string Sku;
        [DataMember]
        public string Address;
    }

    [DataContract]
    public class JsonAns
    {
        [DataMember]
        public string Status;
    }

    protected JsonAns IsItemFulfillable(JsonReq req)
    {
        // note: all SandBox tests is done inside SQL

        SqlCommand sqcmd = new SqlCommand();
        sqcmd.CommandType = CommandType.StoredProcedure;
        sqcmd.CommandText = "WO_AMAZON_CheckSKU";
        sqcmd.Parameters.AddWithValue("@in_Address", req.Address);
        sqcmd.Parameters.AddWithValue("@in_SKU", req.Sku);

        CallWOApi(sqcmd);
        reader.Read();

        JsonAns ans = new JsonAns();
        ans.Status = getString("Status");
        return ans;
    }

    protected override void Execute()
    {
        JsonReq req = null;
        try
        {
            req = JSONHelper.Deserialise<JsonReq>(IN_JSON);
        }
        catch(Exception e)
        {
            throw new ApiExitException("bad json:" + e.Message);
        }

        JsonAns ans = IsItemFulfillable(req);
        LResponse.Write(JSONHelper.ToJson(ans));
    }
}
