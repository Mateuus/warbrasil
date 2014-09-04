using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Amazon;
using Amazon.SQS;
using Amazon.SQS.Model;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;

namespace AmazonTester
{
    class Program
    {
        static void RunAllTests()
        {
            SNSHelper sns = new SNSHelper();
            sns.ExecTest("GetAddressesSuccess");
            sns.ExecTest("GetAddressesFailureAccountInvalid");
            sns.ExecTest("GetAddressesFailureAccountDisabled");

            sns.ExecTest("IsItemFulfillableSuccess");
            sns.ExecTest("IsItemFulfillableFailureAddressInvalid");
            sns.ExecTest("IsItemFulfillableFailureSkuInvalid");
            sns.ExecTest("IsItemFulfillableFailureSkuDisabled");

            sns.ExecTest("FulfillPurchaseSuccess");
            sns.ExecTest("FulfillPurchaseFailureAddressInvalid");
            sns.ExecTest("FulfillPurchaseFailureSkuInvalid");
            sns.ExecTest("FulfillPurchaseFailureSkuDisabled");

            sns.ExecTest("RevokePurchaseSuccess");
            sns.ExecTest("RevokePurchaseFailureAlreadyRevoked");
            sns.ExecTest("RevokePurchaseFailurePurchaseInvalid");

            //sns.ExecTest("LinkAccountLogin");
        }

        static void TestSNS()
        {
            //RunAllTests();

            SNSHelper sns = new SNSHelper();

            sns.ExecTest("FulfillPurchaseFailureSkuDisabled");

            //sns.ExecTest("FulfillPurchaseFailureSkuInvalid");
            //sns.ExecTest("LinkAccountLogin");

            return;
        }

        static void Main(string[] args)
        {
            try
            {
                TestSNS();
            }
            catch (AmazonSQSException ex)
            {
                Console.WriteLine("Caught Exception: " + ex.Message);
                Console.WriteLine("Response Status Code: " + ex.StatusCode);
                Console.WriteLine("Error Code: " + ex.ErrorCode);
                Console.WriteLine("Error Type: " + ex.ErrorType);
                Console.WriteLine("Request ID: " + ex.RequestId);
                Console.WriteLine("XML: " + ex.XML);
            }
            catch (AmazonSimpleNotificationServiceException ex)
            {
                Console.WriteLine("Caught Exception: " + ex.Message);
                Console.WriteLine("Response Status Code: " + ex.StatusCode);
                Console.WriteLine("Error Code: " + ex.ErrorCode);
                Console.WriteLine("Error Type: " + ex.ErrorType);
                Console.WriteLine("Request ID: " + ex.RequestId);
                Console.WriteLine("XML: " + ex.XML);
            }

            //Console.WriteLine("Press Enter to continue...");
            //Console.Read();
        }
    }
}
