<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Server.aspx.cs" Inherits="WebApplication2.Server" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<asp:Label runat="server" ID="a" />
   <asp:Panel ID="pnlHello" runat="server" Visible="false">
        <h2>
            Hello
            <asp:Label ID="lblName" runat="server" />! Here is a list of your FB friends.<br />
            <asp:ListBox ID="FriendsList" runat="server" onselectedindexchanged="ListBox1_SelectedIndexChanged" 
            Width="307px" Height="363px" style="background-color: #FFFFFF"></asp:ListBox>
        </h2>
        
    </asp:Panel>
    <asp:Panel ID="pnlError" runat="server" Visible="false">
        <a href="Default.aspx">
            <asp:Label ID="lblError" runat="server" ForeColor="Red" /><br />
        </a>
    </asp:Panel>
</asp:Content>
