<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="WebApplication2.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        After Connect Succeeds
    </h2>
    <script type="text/javascript">
            
            var appId = "112850195464492";
                     
            accessToken = window.location.hash.substring(1);
            graphUrl = "https://graph.facebook.com/me?" + accessToken +
                            "&callback=displayUser"

            //use JSON-P to call the graph
            var script = document.createElement("script");
            script.src = graphUrl;
            document.body.appendChild(script);  
            

            function displayUser(user) {
                userName.innerText = user.name;
            }
      </script>
      <p id="userName"></p>
</asp:Content>
