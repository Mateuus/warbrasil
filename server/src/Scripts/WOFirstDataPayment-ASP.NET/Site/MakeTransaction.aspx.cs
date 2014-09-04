using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Data;
using System.Data.SqlClient;
using FirstDataGateway;

public partial class MakeTransaction : ApiWebPage
{
    protected override void Execute()
    {
        sql = new SQLBase("game_api_user", "b2agrickw", "gameid_v1");
        sql.Connect();

        ApiReturnDataTransaction ret = new ApiReturnDataTransaction();

        // parse payment info
        PaymentInfo pi = new PaymentInfo(web);

        // create api
        FDCGWApi api = new FDCGWApi();

        // make sale
        FDGGWSApiOrderResponse sale = api.Sale(pi);
        if(sale.TransactionResult != "APPROVED")
        {
            // transaction failed, return details.
            ret.ReturnCode = 1;
            ret.ErrorMessage = sale.ErrorMessage;
            ret.TransactionResult = sale.TransactionResult;
            Response.Write(JSONHelper.ToJson(ret));
            return;
        }

        /*
        // check for CCV part of AVS response
        if(!CheckCCV(sale.AVSResponse))
        {
            // immidiately void transaction
            FDGGWSApiOrderResponse rvoid = api.Void(sale.OrderId, sale.TDate);

            // respond with cvv error
            ret.ReturnCode = 2;
            ret.ErrorMessage = rvoid.ErrorMessage;
            Response.Write(JSONHelper.ToJson(ret));
            return;
        }*/

        // fill transaction info
        ret.ReturnCode = 0;
        ret.ErrorMessage = "";
        ret.TransactionResult = sale.TransactionResult;
        ret.TransactionTime = sale.TransactionTime;
        ret.OrderId = sale.OrderId;
        ret.ApprovalCode = sale.ApprovalCode;

        // record transaction in DB and if there is error - override code
        if (!ProcessTransactionDB(sale, pi))
        {
            ret.ReturnCode = 3;
            ret.ErrorMessage = "game DB is down";
        }

        Response.Write(JSONHelper.ToJson(ret));
        return;
    }

    bool ProcessTransactionDB(FDGGWSApiOrderResponse sale, PaymentInfo pi)
    {
        // assemble some reference string for our info, including credit card first/last digits
        string someCode1 = string.Format("Y:{0} {1}..{2}",
            sale.ApprovalCode,
            pi.CCNumber.Substring(0, 4),
            pi.CCNumber.Substring(pi.CCNumber.Length - 4, 4));
        string someCode2 = string.Format("{0} {1}",
            FDCGWApi.CheckCCV(sale.AVSResponse) ? "ACCEPTED" : "BAD_CCV",
            sale.TransactionScore);

        SqlCommand sqcmd = new SqlCommand();
        sqcmd.CommandType = CommandType.StoredProcedure;
        sqcmd.CommandText = "ECLIPSE_PROCESSTRANSACTION";
        sqcmd.Parameters.AddWithValue("@tr_transid", sale.OrderId);
        sqcmd.Parameters.AddWithValue("@tr_userid", pi.CustomerID);
        sqcmd.Parameters.AddWithValue("@tr_date", DateTime.Now);
        sqcmd.Parameters.AddWithValue("@tr_amount", pi.ChargeTotal.ToString());
        sqcmd.Parameters.AddWithValue("@tr_result", someCode1);
        sqcmd.Parameters.AddWithValue("@tr_status", someCode2);
        sqcmd.Parameters.AddWithValue("@tr_itemid", pi.ItemID);

        try
        {
            reader = sql.Select(sqcmd);
            reader.Read();
            return true;
        }
        catch (Exception)
        {
            return false;
        }
    }
}
