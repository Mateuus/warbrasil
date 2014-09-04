using System;
using System.Collections.Generic;
using System.Web;
using System.Configuration;

/// <summary>
/// Summary description for ApiExitException
/// </summary>
public class APICheck
{
    public static bool IsAllowed(string ip)
    {
        for(int i=0; i<9; i++)
        {
            try
            {
                string check = ConfigurationManager.AppSettings.Get("ip" + i.ToString());
                if (check == ip)
                    return true;
            }
            catch
            {
            }
        }
        return false;
    }
}
