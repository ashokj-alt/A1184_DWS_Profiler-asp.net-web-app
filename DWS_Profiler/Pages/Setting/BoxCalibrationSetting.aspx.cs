using DWS_Profiler.BusinessLayer;
using System;
using System.Configuration;
using System.Data;
using System.Web.Services;

namespace DWS_Profiler.Pages.Setting
{
    public partial class BoxCalibrationSetting : System.Web.UI.Page
    {
        public string listData;
        public string BoxSetting;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                listData = GetCalibrationList();
                BoxSetting = BoxCount();
            }
        }

        [WebMethod]
        public static string GetCalibrationList()
        {
            try
            {
                //string projectName = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
                DataTable dtList = Calibration.GetCalibrationList();
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
        public static string BoxCount()
        {
            try
            {
                //string projectName = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
                DataTable dtList = clsMain.BoxCount();
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
        public static string DeleteCalibratioBox(string Barcode)
        {
            string json = "";
            try
            {
                //string projectName = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
                DataTable dtList = new DataTable();
                DWS_Profiler.BusinessLayer.clsMain.DeleteCalibratioBox(Barcode);
                
                json = Newtonsoft.Json.JsonConvert.SerializeObject("");

            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
            return json;
        }

        [WebMethod]
        public static string InsertCalibrationBox(object JSONData)
        {
            try
            {
                clsMain user = (clsMain)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONData.ToString(), typeof(clsMain));
                if (user.ID == 0)
                {
                    long ID = user.InsertCalibrationBox();
                    return ID.ToString();
                }
                else
                {
                    return user.ID.ToString();
                }
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }

        }

        [WebMethod]
        public static string UpdateCalibrationBox(object JSONData)
        {
            try
            {
                DWS_Profiler.BusinessLayer.clsMain user = (DWS_Profiler.BusinessLayer.clsMain)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONData.ToString(), typeof(DWS_Profiler.BusinessLayer.clsMain));
                
                    user.UpdateCalibrationBox();
                    return user.ID.ToString();
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }

        }

        [WebMethod]
        public static string UpdateTime(object JSONData)
        {
            try
            {
                DWS_Profiler.BusinessLayer.clsMain user = (DWS_Profiler.BusinessLayer.clsMain)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONData.ToString(), typeof(DWS_Profiler.BusinessLayer.clsMain));

                user.UpdateTime();
                return user.ID.ToString();
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }

        }

        [WebMethod]
        public static string UpdateBoxCount(object JSONData)
        {
            try
            {
                DWS_Profiler.BusinessLayer.clsMain user = (DWS_Profiler.BusinessLayer.clsMain)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONData.ToString(), typeof(DWS_Profiler.BusinessLayer.clsMain));

                user.UpdateBoxCount();
                return user.ID.ToString();
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }

        }
        

        [WebMethod]
        public static string GetCalibrationCount()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = BusinessLayer.clsMain.GetCalibrationCount();
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