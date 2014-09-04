using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using FirstDataGateway;

/// <summary>
/// Summary description for FDCGWApi
/// </summary>
public class FDCGWApi
{
    FDGGWSApiOrderService api = null;
    
    public FDCGWApi()
	{
        ServicePointManager.Expect100Continue = false;

        // Initialize Service Object
        api = new FDGGWSApiOrderService();
        api.Url = @"https://ws.firstdataglobalgateway.com/fdggwsapi/services/order.wsdl";
        string certFile = HttpContext.Current.Server.MapPath("~/App_Data/") + "WS1001303445._.1.pem";
        api.ClientCertificates.Add(X509Certificate.CreateFromCertFile(certFile));
        api.Credentials = new NetworkCredential("WS1001303445._.1", "b3wrFgJk");
    }

    FDGGWSApiOrderResponse IssueOrder(Transaction oTransaction)
    {
        FDGGWSApiOrderRequest oOrderRequest = new FDGGWSApiOrderRequest();
        oOrderRequest.Item = oTransaction;

        // Get the Response
        FDGGWSApiOrderResponse oReponse = null;
        try
        {
            oReponse = api.FDGGWSApiOrder(oOrderRequest);
            return oReponse;
        }
        catch (System.Web.Services.Protocols.SoapException ex)
        {
            throw new ApiExitException(ex.Detail.InnerText);
        }
    }

    public FDGGWSApiOrderResponse Sale(PaymentInfo pi)
    {
        // Create preAuth Transaction Request
        CreditCardTxType oCreditCardTxType = new CreditCardTxType();
        oCreditCardTxType.Type = CreditCardTxTypeType.sale;

        CreditCardData oCreditCardData = new CreditCardData();
        oCreditCardData.ItemsElementName = new ItemsChoiceType[]
        {
            ItemsChoiceType.CardNumber,
            ItemsChoiceType.ExpMonth,
            ItemsChoiceType.ExpYear,
            ItemsChoiceType.CardCodeValue
        };
        oCreditCardData.Items = new string[]
        { 
            pi.CCNumber,
            string.Format("{0:00}", pi.CCExpMon),
            string.Format("{0:00}", pi.CCExpYear),
            pi.CCCCV
        };

        Billing oBilling = new Billing();
        oBilling.CustomerID = pi.CustomerID;
        oBilling.Name = pi.Name;
        oBilling.Address1 = pi.Address1;
        oBilling.City = pi.City;
        oBilling.State = pi.State;
        oBilling.Zip = pi.Zip;
        oBilling.Country = pi.Country;

        TransactionDetails oTransactionDetails = new TransactionDetails();
        oTransactionDetails.Ip = pi.IP;
        oTransactionDetails.UserID = pi.CustomerID;

        Payment oPayment = new Payment();
        oPayment.ChargeTotal = (Decimal)pi.ChargeTotal;

        Transaction oTransaction = new Transaction();
        oTransaction.Items = new object[] { oCreditCardTxType, oCreditCardData };
        oTransaction.Payment = oPayment;
        oTransaction.Billing = oBilling;
        oTransaction.TransactionDetails = oTransactionDetails;

        return IssueOrder(oTransaction);
    }

    public FDGGWSApiOrderResponse Void(string orderId, string TDate)
    {
        // Create preAuth Transaction Request
        CreditCardTxType oCreditCardTxType = new CreditCardTxType();
        oCreditCardTxType.Type = CreditCardTxTypeType.@void;

        TransactionDetails oTransactionDetails = new TransactionDetails();
        oTransactionDetails.OrderId = orderId;
        oTransactionDetails.TDate = TDate;

        Transaction oTransaction = new Transaction();
        oTransaction.Items = new object[] { oCreditCardTxType };
        oTransaction.TransactionDetails = oTransactionDetails;

        return IssueOrder(oTransaction);
    }

    public static bool CheckAVS(string AVSResponse)
    {
        // FDC return AVSReponse in form of YYYM
        if (AVSResponse.Length < 2)
            return false;

        /* AVS code results:
        Code	Visa	MC	Discov	AmEx	Description
        YY	Y	Y	A	Y	Address and zip code match.
        NY	Z	Z	Z	Z	Only the zip code matches
        YN	A	A	Y	A	Only the address matches.
        NN	N	N	N	N	Neither the address nor the zip code match.
        XX	-	W			Card number not on file.
        XX	U	U	U	U	Address information not verified for domestic transaction
        XX	R	-	R	R	Retry - system unavailable.
        XX	S	-	S	S	Service not supported
        XX	E	-			AVS not allowed for card type.
        XX		-			Address verification has been requested, but not received.
        XX	G	-			Global non-AVS participantS Normally an nternational transaction.
        YN	B	-			Street address matches for international transaction. Postal code not verified.
        NN	C	-			Street address and Postal code not verified for international transaction.
        YY	D	-			Street address and Postal code match for international transaction
        YY	F	-			Street address and Postal code match for international transaction. (UK Only)
        */

        string AVS = AVSResponse.Substring(0, 2);
        switch (AVS)
        {
            case "YY": return true;
            //case "NY": return true;
        }
        return false;
    }

    public static bool CheckCCV(string AVSResponse)
    {
        // FDC return AVSReponse in form of YYYM
        // CCV result is 4rd char
        if (AVSResponse.Length < 3)
            return false;

        char ccv = AVSResponse[3];
        /* CCV Code results:
	    'M' - card number matches
	    'N' - card number does not match
	    'P' - not processed
	    'S' - merchant has indicated that the card code is not present on the card
	    'X' - no response from the credit card association was received
        */
        if (ccv == 'M' || ccv == 'S')
            return true;

        return false;
    }

}
