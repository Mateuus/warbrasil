using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Amazon;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;

namespace AmazonPoller
{
    public class SNSHelper
    {
        AmazonSimpleNotificationService sns_;

        public SNSHelper()
        {
            sns_ = AWSClientFactory.CreateAmazonSNSClient();
        }

        public bool TestNotification(string TestFunction)
        {
            DebugLog.Write(TestFunction);

            string msg = string.Format("{2}\"Type\":\"TestNotification\",\"Function\":\"{0}\",\"Email\":\"{1}\"{3}",
                TestFunction,
                "denis.zhulitov@arktosentertainment.com",
                "{",
                "}");
            return Publish(msg);
        }

        public bool Publish(string message)
        {
            DebugLog.Write("SNS: " + message);
            try
            {
                PublishRequest req = new PublishRequest();
                req.TopicArn = AmazonPoller.SNS_TOPIC_ARN;
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
                DebugLog.Write("Caught Exception: " + ex.Message);
                DebugLog.Write("Response Status Code: " + ex.StatusCode);
                DebugLog.Write("Error Code: " + ex.ErrorCode);
                DebugLog.Write("Error Type: " + ex.ErrorType);
                DebugLog.Write("Request ID: " + ex.RequestId);
                DebugLog.Write("XML: " + ex.XML);
                return false;
            }
        }
    }
}
