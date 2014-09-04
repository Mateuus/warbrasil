using System;
using System.Collections.Generic;
using System.Web;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;

[DataContract]
public class ApiReturnData
{
    [DataMember]
    public int ReturnCode = 99;
    [DataMember]
    public string ErrorMessage = "";
}

[DataContract]
public class ApiReturnDataTransaction : ApiReturnData
{
    [DataMember]
    public string TransactionResult;
    [DataMember]
    public string TransactionTime;
    [DataMember]
    public string ApprovalCode;
    [DataMember]
    public string OrderId;
}
