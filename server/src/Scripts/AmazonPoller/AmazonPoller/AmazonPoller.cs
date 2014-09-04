using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Data;
using System.Data.SqlClient;
using Amazon;
using Amazon.SQS;
using Amazon.SQS.Model;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;
using System.Web.Script.Serialization;

namespace AmazonPoller
{
    public class AmazonPoller
    {
        //sandbox value
        //static public string SNS_TOPIC_ARN = "arn:aws:sns:us-east-1:222383862245:responseWarInc";
        //static public string SQS_QUERY_URL = "https://queue.amazonaws.com/222383862245/requestWarInc";

        static public string SNS_TOPIC_ARN = "arn:aws:sns:us-east-1:326161783280:responseWarInc";
        static public string SQS_QUERY_URL = "https://queue.amazonaws.com/326161783280/requestWarInc";

        public SNSHelper sns_ = new SNSHelper();
        public AmazonSQS sqs_ = AWSClientFactory.CreateAmazonSQSClient();
        public SQLBase sql_ = new SQLBase();

        public AmazonPoller()
        {
            DebugLog.Write("---------");
            DebugLog.Write("---------");
            DebugLog.Write("AmazonPoller is starting, live mode");
            DebugLog.Write("---------");
            DebugLog.Write("---------");

            ConnectToSQL();

            WarmUpSQS();

            DebugLog.Write("---------");
            DebugLog.Write("AmazonPoller is started");

            int numCycles = 0;
            char [] cyclesArr = "\\|/-".ToCharArray();

            DateTime lastAliveTime = DateTime.Now;
            DateTime lastPollTime = DateTime.Now;

            while (true)
            {
                lastPollTime = DateTime.Now;

                numCycles++;
                Console.Title = string.Format("AmazonPoller, {0} {1} {2}",
                    cyclesArr[numCycles % cyclesArr.Length],
                    DateTime.Now.ToLocalTime(),
                    numCycles);

                CheckMessages();

                //
                // reconnect to SQL if connection was lost
                //
                if (!sql_.IsConnected())
                {
                    double seconds = DateTime.Now.Subtract(sql_.lostTime_).TotalSeconds;
                    DebugLog.Write("{0} seconds without SQL", seconds);
                    if (seconds > 60)
                    {
                        ConnectToSQL();
                    }
                }

                //
                // just some reminder that we're not dead
                //
                if (DateTime.Now.Subtract(lastAliveTime).TotalMinutes > 10)
                {
                    lastAliveTime = DateTime.Now;
                    DebugLog.Write("ping");
                }

                //
                // sleep some time to maintain polling freq of 2 sec
                //
                double secsFromLastPoll = DateTime.Now.Subtract(lastPollTime).TotalSeconds;
                double sleepSec = 2 - (secsFromLastPoll);
                if (sleepSec > 0)
                {
                    Thread.Sleep((int)(sleepSec * 1000));
                }
                else
                {
                    DebugLog.Write("!! too long tick {0}", secsFromLastPoll);
                }
            }
        }

        bool ConnectToSQL()
        {
            if (sql_.IsConnected())
                return true;

            try
            {
                DebugLog.Write("SQL: Connecting...");
                sql_.Connect();
                DebugLog.Write("SQL: Connected OK.");
                return true;
            }
            catch (Exception e)
            {
                DebugLog.Write("SQL: !!!!!!!! Connection FAILED: " + e.Message);
                return false;
            }
        }


        // no exception version
        string Impl_ExecAmazonSQL(SqlCommand sqcmd)
        {
            SqlDataReader reader = null;

            string Status = "FAILURE_UNKNOWN";
            try
            {
                reader = sql_.Select(sqcmd);

                // skip ResultCode
                reader.Read();
                reader.NextResult();

                reader.Read();
                Status = reader["Status"].ToString();
            }
            finally
            {
                if (reader != null)
                    reader.Close();
            }

            return Status;
        }

        public string ExecAmazonSQL(SqlCommand sqcmd)
        {
            // if we don't have connection, fail that call
            if (!sql_.IsConnected())
            {
                DebugLog.Write("- no sql connection");
                return "FAILURE_UNKNOWN";
            }

            try
            {
                string Status = Impl_ExecAmazonSQL(sqcmd);
                return Status;
            }
            catch (InvalidOperationException e)
            {
                //The current state of the connection is closed. ExecuteReader requires an open SqlConnection.

                DebugLog.Write("!!!!! SQL Connection LOST: " + e.Message);
                // try to immidiately reconnect
                if (ConnectToSQL())
                {
                    // and give request it 2nd try
                    try
                    {
                        string Status = Impl_ExecAmazonSQL(sqcmd);
                        return Status;
                    }
                    catch (Exception e2)
                    {
                        DebugLog.Write("!!!!! SQL Connection LOST 2nd time: " + e2.Message);
                    }
                }
            }
            catch (Exception e)
            {
                DebugLog.Write("!!!!! ExecAmazonSQL exception: " + e.ToString());
            }

            return "FAILURE_UNKNOWN";
        }


        void DumpAmazonMessage(Message msg)
        {
                DebugLog.Write("  Message");
                if (msg.IsSetMessageId())
                {
                    DebugLog.Write("    MessageId: {0}", msg.MessageId);
                }
                if (msg.IsSetReceiptHandle())
                {
                    DebugLog.Write("    ReceiptHandle: {0}", msg.ReceiptHandle);
                }
                if (msg.IsSetMD5OfBody())
                {
                    DebugLog.Write("    MD5OfBody: {0}", msg.MD5OfBody);
                }
                if (msg.IsSetBody())
                {
                    DebugLog.Write("    Body: {0}", msg.Body);
                }
                foreach (Amazon.SQS.Model.Attribute attribute in msg.Attribute)
                {
                    DebugLog.Write("  Attribute");
                    if (attribute.IsSetName())
                    {
                        DebugLog.Write("    Name: {0}", attribute.Name);
                    }
                    if (attribute.IsSetValue())
                    {
                        DebugLog.Write("    Value: {0}", attribute.Value);
                    }
                }
        }

        void DoFilfillPurchase(Dictionary<string, string> msgDict)
        {
        }

        void DoRevokePurchase(Dictionary<string, string> msgDict)
        {
            string PurchaseId = msgDict["PurchaseId"];

        }

        void ProcessDDDMessage(Dictionary<string, string> msgDict)
        {
            string msgType = msgDict["Type"];
            if (msgType == "FulfillPurchase")
            {
                FulfillPurchase call = new FulfillPurchase(this, msgDict);
            }
            else if (msgType == "RevokePurchase")
            {
                RevokePurchase call = new RevokePurchase(this, msgDict);
            }
            else
            {
                throw new ApiExitException(string.Format("bad ddd message: {0}", msgType));
            }
        }

        bool StoreMessageAndCheckIfUnique(string messageId, string messageBody)
        {
            SqlCommand sqcmd = new SqlCommand();
            sqcmd.CommandType = CommandType.StoredProcedure;
            sqcmd.CommandText = "WO_AMAZON_LogMessage";
            sqcmd.Parameters.AddWithValue("@in_MessageId", messageId);
            sqcmd.Parameters.AddWithValue("@in_MessageBody", messageBody == null ? "" : messageBody);

            string Status = ExecAmazonSQL(sqcmd);
            if (Status == "SUCCESS")
                return true;

            DebugLog.Write("Message: !!!! duplicate {0}", messageId);
            return true;
            
            // somehow test environment is sending duplicates
            // return false;
        }

        void ProcessAmazonMessage(Message msg)
        {
            if (!msg.IsSetBody())
                return;

            // if we don't have connection, fail that call
            if (!sql_.IsConnected())
            {
                DebugLog.Write("Message is SKIPPED - there is no SQL connection");
                return;
            }

            JavaScriptSerializer jss = new JavaScriptSerializer();

            Dictionary<string, string> bodyDict = null;
            try
            {
                bodyDict = jss.Deserialize<Dictionary<string, string>>(msg.Body);
            }
            catch
            {
                throw new ApiExitException(string.Format("message Deserialize: {0}", msg.Body));
            }

            string bodyType = bodyDict["Type"];
            if (bodyType == null || bodyType != "Notification")
            {
                throw new ApiExitException(string.Format("bad body type: {0}", bodyType));
            }

            // from amazon SLA requirement
            // 99% of all responses should occur within 55s
            // so we need to discard old messages
            DateTime timeStamp = Convert.ToDateTime(bodyDict["Timestamp"]);
            double timeDiff = DateTime.Now.Subtract(timeStamp).TotalSeconds;
            if(timeDiff >= 60)
            {
                DebugLog.Write("Message: skipping outdated, {0} sec. {1}", (int)timeDiff, bodyDict["Message"]);
                return;
            }

            // if message is not unique, skip it
            if (!StoreMessageAndCheckIfUnique(msg.MessageId, bodyDict["Message"]))
            {
                return;
            }

            string bodyMessage = bodyDict["Message"];
            if (bodyMessage == null)
            {
                throw new ApiExitException(string.Format("no message"));
            }

            Dictionary<string, string> msgDict = null;
            try
            {
                msgDict = jss.Deserialize<Dictionary<string, string>>(bodyMessage);
            }
            catch
            {
                throw new ApiExitException(string.Format("body Deserialize: {0}", msg.Body));
            }

            ProcessDDDMessage(msgDict);
        }

        void DeleteAmazonMessage(Message msg)
        {
            //DebugLog.Write("DeleteMessage");

            try
            {
                DeleteMessageRequest deleteRequest = new DeleteMessageRequest();
                deleteRequest.QueueUrl = SQS_QUERY_URL;
                deleteRequest.ReceiptHandle = msg.ReceiptHandle;
                sqs_.DeleteMessage(deleteRequest);
            }
            catch (Exception e)
            {
                DebugLog.Write("Message: !!!!!! delete failed: " + e.Message);
            }
        }

        void WarmUpSQS()
        {
            DebugLog.Write("SQS: Connecting");

            try
            {
                GetQueueAttributesRequest req = new GetQueueAttributesRequest();
                req.QueueUrl = SQS_QUERY_URL;
                GetQueueAttributesResponse resp = sqs_.GetQueueAttributes(req);
                GetQueueAttributesResult res = resp.GetQueueAttributesResult;
            }
            catch
            {
                //DebugLog.Write("WarmUpSQS: exception: " + e.Message);
            }

            DebugLog.Write("SQS: Warmed up.");
        }

        void CheckMessages()
        {
            try
            {
                ReceiveMessageRequest receiveMessageRequest_ = new ReceiveMessageRequest();
                receiveMessageRequest_.QueueUrl = SQS_QUERY_URL;

                ReceiveMessageResponse resp = sqs_.ReceiveMessage(receiveMessageRequest_);

                if (!resp.IsSetReceiveMessageResult())
                    return;

                ReceiveMessageResult result = resp.ReceiveMessageResult;
                if (result.Message.Count == 0)
                    return;

                DebugLog.Write("Processing Messages");
                foreach (Message message in result.Message)
                {
                    //DumpAmazonMessage(message);

                    // delete it right away from queue
                    DeleteAmazonMessage(message);

                    // and process
                    ProcessAmazonMessage(message);
                }
            }
            catch (AmazonSQSException ex)
            {
                DebugLog.Write("CheckMessages: !!!!!! SQS Exception: " + ex.ToString());
                DebugLog.Write("Caught Exception: " + ex.Message);
                DebugLog.Write("Response Status Code: " + ex.StatusCode);
                DebugLog.Write("Error Code: " + ex.ErrorCode);
                DebugLog.Write("Error Type: " + ex.ErrorType);
                DebugLog.Write("Request ID: " + ex.RequestId);
                DebugLog.Write("XML: " + ex.XML);
            }
            catch (AmazonSimpleNotificationServiceException ex)
            {
                DebugLog.Write("CheckMessages: !!!!!! SQS Exception: " + ex.ToString());
                DebugLog.Write("Caught Exception: " + ex.Message);
                DebugLog.Write("Response Status Code: " + ex.StatusCode);
                DebugLog.Write("Error Code: " + ex.ErrorCode);
                DebugLog.Write("Error Type: " + ex.ErrorType);
                DebugLog.Write("Request ID: " + ex.RequestId);
                DebugLog.Write("XML: " + ex.XML);
            }
            catch (Exception e)
            {
                DebugLog.Write("CheckMessages: !!!!!! some SHIT Exception: " + e.ToString());
            }
        }

    }
}
