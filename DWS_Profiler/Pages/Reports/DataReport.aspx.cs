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
    public partial class DataReport : System.Web.UI.Page
    {
        public string todayDate = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            todayDate = DateTime.Now.ToString("dd-MMM-yyyy");
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
        public static string DataSearch(string Type,string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.DataSearchReport(Type,Week, Month, StartDate, EndDate);
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
        public static string DWSSuccessDataSearch(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {

            DataSet ds = new DataSet();
            try
            {
                //ds = BusinessLayer.clsMain.DWSDataSearchReport(Type, Week, Month, StartDate.Replace('t',' '), EndDate, pageIndex, pageSize);
                ds = BusinessLayer.clsMain.DWSSuccessDataSearch(Type, Week, Month, StartDate, EndDate, pageIndex, pageSize);
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
        }
        
        [WebMethod]
        public static string CalibrationDataSearch(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {

            DataSet ds = new DataSet();
            try
            {
                //ds = BusinessLayer.clsMain.DWSDataSearchReport(Type, Week, Month, StartDate.Replace('t',' '), EndDate, pageIndex, pageSize);
                ds = clsMain.CalibrationDataSearch(Type, Week, Month, StartDate, EndDate, pageIndex, pageSize);
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
        }


        [WebMethod]
        public static string DWSFailedDataSearch(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {

            DataSet ds = new DataSet();
            try
            {
                //ds = BusinessLayer.clsMain.DWSDataSearchReport(Type, Week, Month, StartDate.Replace('t',' '), EndDate, pageIndex, pageSize);
                ds = BusinessLayer.clsMain.DWSFailedDataSearch(Type, Week, Month, StartDate, EndDate, pageIndex, pageSize);
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
        }


        [WebMethod]
        public static string DWSDataSearch(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {
            
            DataSet ds = new DataSet();
            try
            {
                //ds = BusinessLayer.clsMain.DWSDataSearchReport(Type, Week, Month, StartDate.Replace('t',' '), EndDate, pageIndex, pageSize);
                ds = BusinessLayer.clsMain.DWSDataSearchReport(Type, Week, Month, StartDate, EndDate, pageIndex, pageSize);
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
        public static string SuccessExport(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.SuccessExport(Type, Week, Month, StartDate, EndDate);
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
        public static string FaliedArrayExport(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.FaliedArrayExport(Type, Week, Month, StartDate, EndDate);
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
        public static string Export(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.DataLogExport(Type, Week, Month, StartDate, EndDate);
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