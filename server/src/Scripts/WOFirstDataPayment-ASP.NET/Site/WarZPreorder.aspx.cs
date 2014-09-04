using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Data;
using System.Data.SqlClient;
using FirstDataGateway;

public partial class WarZPreorder : ApiWebPage
{
    protected override void Execute()
    {
        sql = new SQLBase("bn_api_user", "H5fzjj3amr", "BreezeNet");
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

        // fill transaction info
        ret.ReturnCode = 0;
        ret.ErrorMessage = "";
        ret.TransactionResult = sale.TransactionResult;
        ret.TransactionTime = sale.TransactionTime;
        ret.OrderId = sale.OrderId;
        ret.ApprovalCode = sale.ApprovalCode;

        // record transaction in DB and if there is error - override code
        if (!StoreWarzPreorderDB(sale, pi))
        {
            ret.ReturnCode = 3;
            ret.ErrorMessage = "game DB is down";
        }

        Response.Write(JSONHelper.ToJson(ret));
        return;
    }

    bool StoreWarzPreorderDB(FDGGWSApiOrderResponse sale, PaymentInfo pi)
    {
        // assemble some reference string for our info, including credit card first/last digits
        string someCode1 = string.Format("Y:{0} {1}..{2}",
            sale.ApprovalCode,
            pi.CCNumber.Substring(0, 4),
            pi.CCNumber.Substring(pi.CCNumber.Length - 4, 4));

        SqlCommand sqcmd = new SqlCommand();
        sqcmd.CommandType = CommandType.StoredProcedure;
        sqcmd.CommandText = "BN_WarZ_PreorderRegister";
        sqcmd.Parameters.AddWithValue("@in_Method", "CC");
        sqcmd.Parameters.AddWithValue("@in_Amount", pi.ChargeTotal.ToString());
        sqcmd.Parameters.AddWithValue("@in_OrderID", sale.OrderId);
        sqcmd.Parameters.AddWithValue("@in_ApprovalCode", someCode1);
        sqcmd.Parameters.AddWithValue("@in_email", pi.CustomerID);

        try
        {
            reader = sql.Select(sqcmd);
            reader.Read();
            return true;
        }
        catch (Exception e)
        {
            sale.ErrorMessage = e.Message;
            return false;
        }
    }
}
