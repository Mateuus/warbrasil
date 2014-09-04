<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            <font face="Verdana">Logon Page</font>
        </h3>
        <table>
            <tr>
                <td>
                    Email:</td>
                <td>
                    <input id="txtUserName" runat="server" type="text" /></td>
                <td>
                    <asp:RequiredFieldValidator ID="vUserName" runat="server" 
                        ControlToValidate="txtUserName" Display="Static" ErrorMessage="*" />
                </td>
            </tr>
            <tr>
                <td>
                    Password:</td>
                <td>
                    <input id="txtUserPass" runat="server" type="password" /></td>
                <td>
                    <asp:RequiredFieldValidator ID="vUserPass" runat="server" 
                        ControlToValidate="txtUserPass" Display="Static" ErrorMessage="*" />
                </td>
            </tr>
        </table>
        <input id="cmdLogin" runat="server" type="submit" value="Logon" /><p>
        </p>
        <asp:Label ID="lblMsg" runat="server" Font-Name="Verdana" Font-Size="10" 
            ForeColor="red" />
    
    </div>
    </form>
</body>
</html>
