using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

/// <summary>
/// Summary description for WebHelper
/// </summary>
public class WebHelper
{
    System.Web.UI.Page page_;
	public WebHelper(System.Web.UI.Page in_page)
	{
        page_ = in_page;
	}

    /// <summary>
    /// Converts the String to UTF8 Byte array and is used in De serialization
    /// </summary>
    /// <param name="pXmlString"></param>
    /// <returns></returns>
    public static Byte[] StringToUTF8ByteArray(String pXmlString)
    {
        UTF8Encoding encoding = new UTF8Encoding();
        Byte[] byteArray = encoding.GetBytes(pXmlString);
        return byteArray;
    }

    public string Param(string paramName)
    {
        NameValueCollection nvc = page_.Request.Form; 
        string value = nvc[paramName];

        // enable GET params as well
        if (value == null)
        {
            nvc = page_.Request.QueryString;
            value = nvc[paramName];
        }

        if (value == null)
        {
#if true
            //@DEBUG
            throw new ApiExitException("no parameter " + paramName);
#else
            throw new ApiExitException("no parameter");
#endif
        }
        return value;
    }
}
