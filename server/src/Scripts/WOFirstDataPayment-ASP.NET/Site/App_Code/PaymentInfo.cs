using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PaymentInfo
/// </summary>
public class PaymentInfo
{
    public string CustomerID;
    public string ItemID;
    public string IP;

    public string Name;
    public string Address1;
    public string Address2;
    public string City;
    public string State;
    public string Zip;
    public string Country;

    public string CCNumber;
    public int CCExpMon;
    public int CCExpYear;
    public string CCCCV;

    public float ChargeTotal;

    /*void SetTest()
    {
        CustomerID = "1000";
        ItemID = "Test Item";
        IP = "127.0.0.1";

        Name = "Sergey Titov";
        Address1 = "11833 MISSISSIPPI AVE, STE 100";
        City = "LOS ANGELES";
        State = "CA";
        Zip = "90025";
        Country = "US";

        CCNumber = "371556855012011";
        CCExpMon = 9;
        CCExpYear = 15;
        CCCCV = "0960";

        ChargeTotal = 1.05f;
    }*/

    public PaymentInfo(WebHelper web)
	{
        CustomerID = web.Param("userid");
        ItemID = web.Param("itemid");
        IP = web.Param("uip");

        Name = web.Param("bname");
        Address1 = web.Param("baddr1");
        Address2 = null;
        City = web.Param("bcity");
        Zip = web.Param("bzip");
        State = web.Param("bstate");
        Country = web.Param("bcountry");
        if (Country != "US")
            State = "";

        // CCNumber must be digits only.
        CCNumber = web.Param("cardnumber").Replace("-", "").Replace(" ", "");

        try
        {
            CCExpMon = Convert.ToInt32(web.Param("expmonth"));
            if (CCExpMon < 0 || CCExpMon > 12)
                throw new ApiExitException("bad card expiration month");
        }
        catch (FormatException)
        {
            throw new ApiExitException("bad card expiration month");
        }

        try
        {
            // expiration year must be 2 digits. without 20
            CCExpYear = Convert.ToInt32(web.Param("expyear"));
            if (CCExpYear > 2000)
            {
                CCExpYear -= 2000;
            }
            if(CCExpYear < 11 || CCExpYear > 99)
                throw new ApiExitException("bad card expiration year");
        }
        catch (FormatException)
        {
            throw new ApiExitException("bad card expiration year");
        }

        try
        {
            int checkCvv = Convert.ToInt32(web.Param("cvm"));
            CCCCV = web.Param("cvm");
        }
        catch(FormatException)
        {
            throw new ApiExitException("bad card CCV");
        }

        try
        {
            int Cents = Convert.ToInt32(web.Param("chargeCents"));
            ChargeTotal = (float)Cents / 100;
            if(ChargeTotal < 0 || ChargeTotal > 999)
                throw new ApiExitException("bad charge total");
        }
        catch (FormatException)
        {
            throw new ApiExitException("bad card ChargeTotal");
        }
    }
}
