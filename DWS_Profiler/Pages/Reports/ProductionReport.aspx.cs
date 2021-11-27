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
    public partial class ProductionReport : System.Web.UI.Page
    {
        //public string SKUList;
        protected void Page_Load(object sender, EventArgs e)
        {
            //SKUList = getSKUList();
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
        public static string DataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = clsMain.DataSearch(Type, Week, Month, StartDate, EndDate);
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
        public static string PakegeTypeDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = clsMain.PakegeTypeDataSearch(Type, Week, Month, StartDate, EndDate);
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
        public static string LengthWiseDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = clsMain.LengthWiseDataSearch(Type, Week, Month, StartDate, EndDate);
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
        public static string WeightWiseDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.WeightWiseDataSearch(Type, Week, Month, StartDate, EndDate);
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
        public static string WidthWiseDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.WidthWiseDataSearch(Type, Week, Month, StartDate, EndDate);
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
        public static string HeightWiseDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.HeightWiseDataSearch(Type, Week, Month, StartDate, EndDate);
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
        public static string SearchPerHourShipment(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.SearchPerHourShipment(Type, Week, Month, StartDate, EndDate);
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
        public static string SearchLBHBar(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.SearchLBHBar(Type, Week, Month, StartDate, EndDate);
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
        public static string getSKUList(string Cell_No)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.getSKUList(Cell_No);
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
        public static string Export(string Type, string Week, string Month, string StartDate, string EndDate, string Cell, string SKU, string ReportType)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.Export(Type, Week, Month, StartDate, EndDate, Cell, SKU, ReportType);
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