using DWS_Profiler.BusinessLayer;
using DWS_Profiler.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DWS_Profiler.Pages.Reports
{
    public partial class NewDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string DashboardData()
        {

            DataSet ds = new DataSet();
            try
            {
                ds = BusinessLayer.dashboard.dashboard.DashboardData();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
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