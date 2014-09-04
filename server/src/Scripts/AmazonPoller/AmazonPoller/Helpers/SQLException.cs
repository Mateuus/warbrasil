using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Web;
using System.Data.SqlClient;

public class SqlExitException : SystemException
{
    public SqlExitException(string msg)
        : base(msg)
    {
    }
}
