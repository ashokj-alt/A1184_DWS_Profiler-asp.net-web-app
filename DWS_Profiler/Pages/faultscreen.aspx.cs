using DWS_Profiler.BusinessLayer;
using System;
using System.Configuration;
using System.Data;
using System.Web.Services;

namespace DWS_Profiler.Pages
{
    public partial class faultscreen : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        [WebMethod]
        public static string ShowFault()
        {

            DataSet ds = new DataSet();
            try
            {
                ds = clsMain.FaultData();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
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
        public static string GetFault()
        {
            try
            {
                //string projectName = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
                DataTable dtList = clsMain.GetFault();
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
        public static string open_Rectification_Action( int faults_ID)
        {
            try
            {
                //string projectName = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
                DataTable dtList = clsMain.open_Rectification_Action(faults_ID);
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
        public static string ReasonwiseFaultSearchList(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {
            try
            {
                DataSet dtList = clsMain.ReasonwiseFaultSearchList(Type, Week, Month, StartDate, EndDate, pageIndex, pageSize);
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
        public static string ReasonwiseFaultSearchData(int pageIndex, int pageSize)
        {
            try
            {
                DataSet dtList = clsMain.ReasonwiseFaultSearchData(pageIndex, pageSize);
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
        public static string Export_Alarms()
        {
            try
            {
                DataSet dtList = clsMain.Export_Alarms();
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
        public static string Export(string Type, string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            try
            {
                DataSet dtList = clsMain.ExportFaultData(Type, Week, Month, StartDate, EndDate, Cell);
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