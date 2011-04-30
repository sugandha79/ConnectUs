using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

using Facebook;
using Facebook.Web;

namespace WebApplication2
{
    public partial class Server : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckIfFacebookAppIsSetupCorrectly();

            var auth = new CanvasAuthorizer { Permissions = new[] { "user_about_me" } };

            if (auth.Authorize())
            {
                ShowFacebookContent();
            }
        }

        private void ShowFacebookContent()
        {
            var fb = new FacebookWebClient();
            dynamic myInfo = fb.Get("me");
            lblName.Text = myInfo.name;
            pnlHello.Visible = true;

            dynamic myFriendsInfo = fb.Get("me/friends");
            foreach (var friend in myFriendsInfo.data)
            {
                FriendsList.Items.Add(friend.name);
            }
            /* OR */

            //var fbApp = new FacebookApp();
            //dynamic info = fbApp.Get("me");
            //lblName.Text = info.name;
            //pnlHello.Visible = true;
        }

        private bool CheckIfFacebookAppIsSetupCorrectly()
        {
            // YOU DONT NEED ANY OF THIS IN YOUR APPLICATION
            // THIS METHOD JUST CHECKS TO SEE IF YOU HAVE SETUP
            // THE SAMPLE. IF THE SAMPLE IS NOT SETUP YOU WILL
            // BE SENT TO THE GETTING STARTED PAGE.

            var settings = ConfigurationManager.GetSection("facebookSettings");
            if (settings != null)
            {
                var current = settings as IFacebookApplication;
                if (current.AppId != "{app id}" &&
                    current.AppSecret != "{app secret}" &&
                    current.CanvasPage != "http://apps.facebook.com/{fix path}/")
                {
                    return true;
                }
            }
            return false;
        }

        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}