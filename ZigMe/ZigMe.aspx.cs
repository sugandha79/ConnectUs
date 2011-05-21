using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

using Facebook;
using Facebook.Web;

using Amazon;
using Amazon.SimpleDB;
using Amazon.SimpleDB.Model;

namespace ZigMeApp
{
    public partial class ZigMe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                CheckIfFacebookAppIsSetupCorrectly();

                var auth = new CanvasAuthorizer { Permissions = new[] { "user_about_me" } };

                if (auth.Authorize())
                {
                    ShowFacebookContent();
                }
            }
            else
            {
                AmazonSimpleDB sdb = GetSDB();

                // Should I clean out the AWS domain state?
                if (Page.Request.Params["delaws"] == "1")
                {
                    //Deleting a domain
                    DeleteDomainRequest deleteDomainAction = new DeleteDomainRequest().WithDomainName("ZigMeRecos");
                    sdb.DeleteDomain(deleteDomainAction);
                }

                // Now read from the AWS domain and populate the dropdown list

                // First check to see if a domain contain service types exists. if not then create it and populate it
                // Listing domains
                /*ListDomainsResponse sdbListDomainsResponse = sdb.ListDomains(new ListDomainsRequest());
                if (sdbListDomainsResponse.IsSetListDomainsResult())
                {
                    ListDomainsResult listDomainsResult = sdbListDomainsResponse.ListDomainsResult;

                    if (!listDomainsResult.DomainName.Contains("ZigMeServiceTypes"))
                    {
                    }
                    else
                    {
                        String selectExpression = "Select * From ZigMeServiceTypes";
                        SelectRequest selectRequestAction = new SelectRequest().WithSelectExpression(selectExpression);
                        SelectResponse selectResponse = sdb.Select(selectRequestAction);
                        if (selectResponse.IsSetSelectResult())
                        {
                            SelectResult selectResult = selectResponse.SelectResult;
                            foreach (Item item in selectResult.Item)
                            {
                                foreach (Amazon.SimpleDB.Model.Attribute attribute in item.Attribute)
                                {
                                    if (attribute.IsSetName() && attribute.IsSetValue())
                                    {
                                    }
                                }
                            }
                        }
                    }
                }*/
            }
        }

        /// <summary>
        /// Get a reference to an instance of AmazonSimpleDB
        /// </summary>
        /// <returns></returns>
        private AmazonSimpleDB GetSDB()
        {
            NameValueCollection appConfig = ConfigurationManager.AppSettings;
            AmazonSimpleDB sdb = AWSClientFactory.CreateAmazonSimpleDBClient(
                         appConfig["AWSAccessKey"],
                         appConfig["AWSSecretKey"]
                         );
            return sdb;
        }


        /// <summary>
        /// Get FB info of the user, save the recommendation into our SimpleDB and then redirect to a web page that posts to the uers's wall.
        /// </summary>
        private void ShowFacebookContent()
        {
            var fb = new FacebookWebClient();
            dynamic myInfo = fb.Get("me");
            string myFBId = myInfo["id"]; ;

            if (SaveRecoToSimpleDB(myFBId))
            {
                Response.Redirect("posttowall.htm?rn=" + RecoName.Text + "&rc=" + RecoCity.Text + "&rs=" + RecoService.SelectedValue);
            }
        }

        /// <summary>
        /// Put the user's reco into the ZigMeRecos domain in SimpleDB
        /// </summary>
        /// <returns></returns>
        private bool SaveRecoToSimpleDB(string myFBId)
        {
            AmazonSimpleDB sdb = GetSDB();
                      
            // Creating a domain
            String domainName = "ZigMeRecos";
            CreateDomainRequest createDomain = (new CreateDomainRequest()).WithDomainName(domainName);
            sdb.CreateDomain(createDomain);

            // Check to see how many recos this FB user id has stored in our domain
            String selectExpression = "Select * From ZigMeRecos Where FBId = '" + myFBId + "'";
            SelectRequest selectRequestAction = new SelectRequest().WithSelectExpression(selectExpression);
            SelectResponse selectResponse = sdb.Select(selectRequestAction);

            int cRecos = 0;
            // Now store the actual recommendation item
            if (selectResponse.IsSetSelectResult())
            {
                SelectResult selectResult = selectResponse.SelectResult;
                cRecos = selectResult.Item.Count;
            }
            cRecos++;
            String recoItem = "Reco_" + myFBId + "_" + cRecos;
            PutAttributesRequest putAttributesRecoItem = new PutAttributesRequest().WithDomainName(domainName).WithItemName(recoItem);
            List<ReplaceableAttribute> attributesRecoItem = putAttributesRecoItem.Attribute;
            attributesRecoItem.Add(new ReplaceableAttribute().WithName("FBId").WithValue(myFBId));
            attributesRecoItem.Add(new ReplaceableAttribute().WithName("Name").WithValue(RecoName.Text));
            attributesRecoItem.Add(new ReplaceableAttribute().WithName("Email").WithValue(ContactEmail.Text));
            attributesRecoItem.Add(new ReplaceableAttribute().WithName("City").WithValue(RecoCity.Text));
            attributesRecoItem.Add(new ReplaceableAttribute().WithName("Service").WithValue(RecoService.SelectedValue));
            PutAttributesResponse putAttributesResponse = sdb.PutAttributes(putAttributesRecoItem);
            
            return putAttributesResponse.IsSetResponseMetadata();
        }

        /// <summary>
        /// YOU DONT NEED ANY OF THIS IN YOUR APPLICATION
        /// THIS METHOD JUST CHECKS TO SEE IF YOU HAVE SETUP
        /// THE SAMPLE. IF THE SAMPLE IS NOT SETUP YOU WILL
        /// BE SENT TO THE GETTING STARTED PAGE.
        /// </summary>
        /// <returns></returns>
        private bool CheckIfFacebookAppIsSetupCorrectly()
        {            
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

    }
}