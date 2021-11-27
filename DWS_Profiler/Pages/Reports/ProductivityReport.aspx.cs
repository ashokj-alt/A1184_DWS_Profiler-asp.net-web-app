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
    public partial class ProductivityReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string DataSearch(string Type,string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            try
            {
                DataSet dtList = BusinessLayer.clsMain.ProductivityDataSearch(Type,Week, Month, StartDate, EndDate, Cell);
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
                DataSet dtList = BusinessLayer.clsMain.ProductivityExport(Type, Week, Month, StartDate, EndDate, Cell);
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