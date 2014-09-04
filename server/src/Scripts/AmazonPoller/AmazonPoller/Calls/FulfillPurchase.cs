using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;

namespace AmazonPoller
{
    public class FulfillPurchase
    {
        AmazonPoller inst;
        string PurchaseId;
        string Sku;
        string Address;

        public FulfillPurchase(AmazonPoller in_inst, Dictionary<string, string> msgDict)
        {
            inst = in_inst;

            PurchaseId = msgDict["PurchaseId"];
            Sku = msgDict["Sku"];
            Address = msgDict["Address"];

            DebugLog.Write("FulfillPurchase {0} to {1}", Sku, Address);

            Process();
        }

        void SendAnswer(string Status)
        {
            //DebugLog.Write("ConfirmFulfillPurchase {0}", Status);

            string json = string.Format(
                "\"Type\":\"ConfirmFulfillPurchase\",\"PurchaseId\":\"{0}\",\"Status\":\"{1}\"",
                PurchaseId,
                Status);

            inst.sns_.Publish("{" + json + "}");
        }

        string CheckSKU()
        {
            SqlCommand sqcmd = new SqlCommand();
            sqcmd.CommandType = CommandType.StoredProcedure;
            sqcmd.CommandText = "WO_AMAZON_CheckSKU";
            sqcmd.Parameters.AddWithValue("@in_Address", Address);
            sqcmd.Parameters.AddWithValue("@in_SKU", Sku);

            return inst.ExecAmazonSQL(sqcmd);
        }

        string BuySKU()
        {
            SqlCommand sqcmd = new SqlCommand();
            sqcmd.CommandType = CommandType.StoredProcedure;
            sqcmd.CommandText = "WO_AMAZON_BuySKU";
            sqcmd.Parameters.AddWithValue("@in_Address", Address);
            sqcmd.Parameters.AddWithValue("@in_SKU", Sku);
            sqcmd.Parameters.AddWithValue("@in_PurchaseId", PurchaseId);

            return inst.ExecAmazonSQL(sqcmd);
        }

        void Process()
        {
            // check if SKU is valid
            string Status = CheckSKU();
            if (Status != "SUCCESS")
            {
                SendAnswer(Status);
                return;
            }

            // actual buy
            Status = BuySKU();
            SendAnswer(Status);
        }
    }
}
