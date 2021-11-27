using DWS_Profiler.BusinessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DWS_Profiler.Pages.Reports
{
    public partial class ProductionAnalysis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string GetScanLocationList()
        {

            DataSet ds = new DataSet();
            try
            {
                ds = clsMain.GetScanLocationList();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
        }


        [WebMethod]
        public static string DataSearch(string Type, string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            try
            {
                DataSet dtList = clsMain.ReasonwiseDataSearch(Type, Week, Month, StartDate, EndDate, Cell);
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
        public static string FalultSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = clsMain.ReasonwiseFaultSearch(Type, Week, Month, StartDate, EndDate);
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
                ds = clsMain.Countdata();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
        }


        [WebMethod]
        public static string Export(string Type, string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            try
            {
                DataSet dtList = clsMain.ExportReasonwiseAndFaultData(Type, Week, Month, StartDate, EndDate, Cell);
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