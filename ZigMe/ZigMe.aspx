<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZigMe.aspx.cs" Inherits="ZigMeApp.ZigMe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title></title>
    <link rel="Stylesheet" type="text/css" href="Styles/Site.css" />
    <style type="text/css">
        #Submit2
        {
            width: 166px;
        }
    </style>
</head>
<body>
    <div id="fb-root"></div>
    <script language=javascript type='text/javascript'>
        window.fbAsyncInit = function () {
            FB.init({
                appId: '112850195464492',
                status: true,
                cookie: true,
                xfbml: true
            });

           FB.getLoginStatus(
                function (response) {
                    if (response.session) {
                        var submitBtn = document.getElementById('RecoSubmit');
                        submitBtn.disabled = "";
                    }
            }); 
            
            FB.Event.subscribe('auth.login', function (response) {
                var submitBtn = document.getElementById('RecoSubmit');
                submitBtn.disabled = "";
            });

            FB.Event.subscribe('auth.logout', function (response) {
                var submitBtn = document.getElementById('RecoSubmit');
                submitBtn.disabled = "disabled";
            });        
        };

        function ConfirmCheck() {
            var reconame = document.getElementById('RecoName').value;
            var recocity = document.getElementById('RecoCity').value;
            var recoemail = document.getElementById('ContactEmail').value;

            var pattern = /\s*\w[\w\s]*/i;
            if (!reconame.match(pattern) || !recocity.match(pattern) || !recoemail.match(pattern)) {
                window.alert('Name or city or email is invalid. Please correct!');
                return false;
            }
            return true;
        }

        // Run this one automatically on page load.
        (function () {
            var e = document.createElement('script');
            e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
            e.async = true;
            document.getElementById('fb-root').appendChild(e);
        } ());

</script>

<form id="form1" runat="server">
    <div id="appsurface" 
        style="position: absolute; right: 98px; left: 100px; top: 50px; overflow:auto; height: 382px;">
    <table style="width: 100%; height: 63px;">
        <tr>
            <td class="style2">
                <strong>ZigMe</strong></td>
            <td class="style3">
                 <div id="fblogin">
                    <fb:login-button autologoutlink='true'  perms='email,status_update,publish_stream'>
                    </fb:login>
                </div>
            </td>
        </tr>
    </table>
    <div id="underline" class="style1" />
        <br />
        <table style="width: 101%; height: 253px;">
            <tr>
                <td class="style6">
                    Recommend Someone</td>
                <td class="style7">
                    &nbsp;</td>
                <td class="style5">
                    Search for someone</td>
            </tr>
            <tr>
                <td class="style6">
                    Name</td>
                <td class="style7">
                    <asp:TextBox ID="RecoName" runat="server" AutoCompleteType="DisplayName" Height="24px" 
                        Width="206px"></asp:TextBox>
                </td>
                <td class="style5">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style6">
                    Email</td>
                <td class="style7">
                    <asp:TextBox ID="ContactEmail" runat="server" AutoCompleteType="Email" Width="241px" Height="24px"></asp:TextBox>
                </td>
                <td class="style5">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style6">
                    City</td>
                <td class="style7">
                    <asp:TextBox ID="RecoCity" runat="server" AutoCompleteType="BusinessCity" CausesValidation="True" 
                        Width="198px" Height="24px"></asp:TextBox>
                </td>
                <td class="style5">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style6">
                    Service</td>
                <td class="style7">
                    <asp:DropDownList ID="RecoService" runat="server" DataValueField="Name" Height="24px" Width="130px">
                        <asp:ListItem>BabySitter</asp:ListItem>
                        <asp:ListItem>HouseKeeping</asp:ListItem>
                        <asp:ListItem>PartyPlanner</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="style5">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style6">
                    &nbsp;</td>
                <td class="style7">
                    <input id="RecoSubmit" type="submit" value="submit" onclick="return ConfirmCheck();"
                        style="background-color: #FF9900; height: 24px;" /></td>
                <td class="style5">
                    <input id="ShowMyRecos" type="submit" value="Show all my Zigs!" disabled="disabled"  /></td>
            </tr>
        </table>
</div>
        <br />
</form>
</body>
</html>
