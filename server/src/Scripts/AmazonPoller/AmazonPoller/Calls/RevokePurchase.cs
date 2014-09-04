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
    public class RevokePurchase
    {
        AmazonPoller inst;
        string PurchaseId;

        public RevokePurchase(AmazonPoller in_inst, Dictionary<string, string> msgDict)
        {
            inst = in_inst;

            PurchaseId = msgDict["PurchaseId"];

            DebugLog.Write("RevokePurchase {0}", PurchaseId);

            Process();
        }

        void SendAnswer(string Status)
        {
            //DebugLog.Write("ConfirmRevokePurchase {0}", Status);

            string json = string.Format(
                "\"Type\":\"ConfirmRevokePurchase\",\"PurchaseId\":\"{0}\",\"Status\":\"{1}\"",
                PurchaseId,
                Status);

            inst.sns_.Publish("{" + json + "}");
        }

        void Process()
        {
            SqlCommand sqcmd = new SqlCommand();
            sqcmd.CommandType = CommandType.StoredProcedure;
            sqcmd.CommandText = "WO_AMAZON_RevokePurchase";
            sqcmd.Parameters.AddWithValue("@in_PurchaseId", PurchaseId);

            string Status = inst.ExecAmazonSQL(sqcmd);
            SendAnswer(Status);
        }
    }
}
