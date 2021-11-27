using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DWS_Profiler.Pages
{
    public partial class Training_Doc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetDocList()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = BusinessLayer.clsMain.GetDocList();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
        }

        [WebMethod]
        public static string GetQuestionList()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = BusinessLayer.clsMain.GetQuestionList();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
        }
        [WebMethod]
        public static string GetQuestion(string Question)
        {
            DataSet ds = new DataSet();
            try
            {
                ds = BusinessLayer.clsMain.GetQuestion(Question);
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
        }
        

        [WebMethod]
        public static string Save(string Question)
        {
            DataSet ds = new DataSet();
            try
            {
                ds = BusinessLayer.clsMain.Save(Question);
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }
        }

    }
}