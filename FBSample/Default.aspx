<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Welcome to the Facebook Connect Sample
    </h2>
    <div id="fb-root"></div>
		<script type="text/javascript">

		    function OnConnect() {
		        top.location.href = "https://graph.facebook.com/oauth/authorize?client_id=112850195464492&redirect_uri=http://localhost:5000/about.aspx&scope=email,publish_stream,user_work_history&response_type=token";
		    }    
		    function FacebookIframeAuthenticator() {
		        window.fbAsyncInit = function () {
		            FB.init({
		                appId: '112850195464492',
		                status: true,
		                logging: false,
		                cookie: false,
		                xfbml: true
		            });
		            FB.Canvas.scrollTo(0, 0);
		            FB.Canvas.setAutoResize();

		            //fbInitObj.onDone();
		        };
		        var e = document.createElement('script');
		        e.async = true;
		        e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
		        document.getElementById('fb-root').appendChild(e);
		    }
		    new FacebookIframeAuthenticator();		  
		</script>
    <p>
        <asp:Button BackColor="Aquamarine" Text="FBConnect" onClientClick="OnConnect()" 
            Width="111px" Height="40px" runat="server"  
            style="color: #FFFFFF; font-weight: 700; background-color: #6699FF" />
    </p>
    <p>
        &nbsp;</p>
    
</asp:Content>
