using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class ResponseLog
{
    public string msg = "";
	public ResponseLog()
	{
	}

    public void Write(string str)
    {
        msg += str;
    }
}
