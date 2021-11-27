using DWS_Profiler.BusinessLayer;
using System;
using System.Configuration;
using System.Data;
using System.Web.Services;

namespace DWS_Profiler.Pages
{
    public partial class materialMaster : System.Web.UI.Page
    {
        public static int CellNo = Convert.ToInt32(ConfigurationSettings.AppSettings["LineNo"]);
        public static string ProjectCode = (ConfigurationSettings.AppSettings["ProjectCode"]);
        public string listData;
        //private static object dt;

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
                DataTable dtList = BusinessLayer.materialMaster.GetList();
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
        public static string Save(string MatCode,string SKUML,string SKUUnit,string SKUSize)
        {
            try
            {
                //BusinessLayer.materialMaster user = (BusinessLayer.materialMaster)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONData.ToString(), typeof(BusinessLayer.materialMaster));
                //if (user.Id == 0)
                //{
                //    long Id = user.Insert();
                //    return Id.ToString();

                //}
                //else
                //{
                //    user.Update();
                //    return user.Id.ToString();
                //}
                DataTable dt = new DataTable();
                dt = BusinessLayer.materialMaster.Update(MatCode, SKUML, SKUUnit,SKUSize);


               string json = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                return json;

            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }

        }

        [WebMethod]
        public static string UnSave(string MatCode)
        {
            try
            {
                DataTable dt = new DataTable();
                dt = BusinessLayer.materialMaster.UnSave(MatCode);


                string json = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                return json;

            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }

        }



        [WebMethod]
        public static string DeleteUser(string MatCode)
        {
            string json = "";
            try
            {
                //string projectName = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
                DataTable dtList = new DataTable();
                BusinessLayer.materialMaster.DeleteUser(MatCode);
                //  Master_UserGroup1.
                //  armstrong.BusinessLayer.Master.

                json = Newtonsoft.Json.JsonConvert.SerializeObject("");

            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
            return json;
        }


    }
}