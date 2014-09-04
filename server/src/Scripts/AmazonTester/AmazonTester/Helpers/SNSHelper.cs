using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Amazon;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;

namespace AmazonTester
{
    public class SNSHelper
    {
        const string TopicARN = "arn:aws:sns:us-east-1:222383862245:responseWarInc";
        AmazonSimpleNotificationService sns_;

        public SNSHelper()
        {
            sns_ = AWSClientFactory.CreateAmazonSNSClient();
        }

        public bool ExecTest(string TestFunction)
        {
            Console.WriteLine(TestFunction);

            string msg = string.Format("{2}\"Type\":\"TestNotification\",\"Function\":\"{0}\",\"Email\":\"{1}\"{3}",
                TestFunction,
                "denis.zhulitov@arktosentertainment.com",
                "{",
                "}");
            return Publish(msg);
        }

        public bool Publish(string message)
        {
            try
            {
                PublishRequest req = new PublishRequest();
                req.TopicArn = TopicARN;
                req.Message = message;

                PublishResponse resp = sns_.Publish(req);
                PublishResult res = resp.PublishResult;
                if (!res.IsSetMessageId())
                {
                    throw new AmazonSimpleNotificationServiceException("!res.IsSetMessageId");
                }

                return true;
            }
            catch (AmazonSimpleNotificationServiceException ex)
            {
                Console.WriteLine("Caught Exception: " + ex.Message);
                Console.WriteLine("Response Status Code: " + ex.StatusCode);
                Console.WriteLine("Error Code: " + ex.ErrorCode);
                Console.WriteLine("Error Type: " + ex.ErrorType);
                Console.WriteLine("Request ID: " + ex.RequestId);
                Console.WriteLine("XML: " + ex.XML);
                return false;
            }
        }
    }
}
