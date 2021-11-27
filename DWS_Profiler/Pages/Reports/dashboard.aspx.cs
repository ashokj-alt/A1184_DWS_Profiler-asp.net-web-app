using DWS_Profiler.BusinessLayer;
using System;
using System.Configuration;
using System.Data;
using System.Web.Services;

namespace DWS_Profiler.Pages.Reports
{
    public partial class dashboard : System.Web.UI.Page
    {
        public static int CellNo = Convert.ToInt32(ConfigurationSettings.AppSettings["LineNo"]);
        public static string ProjectCode = (ConfigurationSettings.AppSettings["ProjectCode"]);
        public string listData;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                listData = GetList();

                
            }
        }

        [WebMethod]
        public static string GetList()
        {
            try
            {
                //string projectName = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
                DataTable dtList = BusinessLayer.dashboard.dashboard.GetList();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(dtList);
                return json;
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
        }
        
        [WebMethod]
        public static string SearchBarcodeData(string Barcode)
        {
            try
            {
                //string projectName = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
                DataSet dtList = BusinessLayer.dashboard.dashboard.SearchBarcodeData(Barcode);
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(dtList);
                return json;
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
        }
        [WebMethod]
        public static string ShowData()
        {

            DataSet ds = new DataSet();
            try
            {
                ds = BusinessLayer.dashboard.dashboard.Countdata();
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

        [WebMethod]
        public static string Export()
        {
            try
            {
                DataSet dtList = clsMain.DashboardExport();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(dtList);
                return json;
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
        }

    }
}