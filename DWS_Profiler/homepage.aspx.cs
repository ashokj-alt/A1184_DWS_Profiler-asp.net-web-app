using DWS_Profiler.BusinessLayer;
using armstrong.BusinessLayer;
using System;
using System.Configuration;
using System.Data;
using System.Web.Services;

namespace DWS_Profiler
{
    public partial class homepage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        private static string AlertNotification()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = clsMain.AlertNotification();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }

        }

        [WebMethod]
        public static string GetData()
        {

            DataSet ds = new DataSet();
            try
            {
                ds = clsMain.HeartBeat_Annunciation();
                // dt = UserManagement.AccessRights.Menu.FetchMenu_AccessRights(user_id);
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }

            // refreshTimer.Interval = 60000; // Sets interval to 60 seconds
        }

    }
}