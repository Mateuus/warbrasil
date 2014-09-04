using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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

    public string Param(string paramName)
    {
        //Request.QueryString for GET params
        //Request.Form for POST params
        NameValueCollection nvc = page_.Request.QueryString;
        string value = nvc[paramName];
        return value;
    }
}
