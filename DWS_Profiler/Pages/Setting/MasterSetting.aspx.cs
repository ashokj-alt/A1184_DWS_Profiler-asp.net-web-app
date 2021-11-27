using DWS_Profiler.BusinessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DWS_Profiler.Pages.Setting
{
    public partial class MasterSetting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetData()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = Calibration.GetDataSetting();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                return json;
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
        }

        [WebMethod]
        public static string updateMachineSetting(string Machine_ID, string Machine_Location)
        {
            try
            {
                DataTable dtList = Calibration.updateMachineSetting(Machine_ID, Machine_Location);
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
        public static string UpdateDataSentSetting(string Weight_URL, string Weight_API_Token, string GI_URL, string GI_API_Token,string Calibration_URL, string Calibration_API_Token)
        {
            try
            {
                DataTable dtList = Calibration.UpdateDataSentSetting( Weight_URL, Weight_API_Token, GI_URL, GI_API_Token, Calibration_URL, Calibration_API_Token);
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
        public static string updateImageSentSetting(string Image_API_Key, string Image_Secret_Key, string Image_Bucket_Name, string Image_Local_File_Path, string Image_key_Name)
        {
            try
            {
                DataTable dtList = Calibration.updateImageSentSetting(Image_API_Key, Image_Secret_Key, Image_Bucket_Name, Image_Local_File_Path, Image_key_Name);
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
        public static string UpdateIPtSetting(string Camera_IP, string VMS_IP, string Check_Weigher_IP, string PLC_IP, string HMI_IP,string Scanner_Port , int CheckWeigher_LAN_Port, int VMS_LAN_Port)
        {
            try
            {
                DataTable dtList = Calibration.UpdateIPtSetting(Camera_IP, VMS_IP, Check_Weigher_IP, PLC_IP, HMI_IP, Scanner_Port , CheckWeigher_LAN_Port, VMS_LAN_Port);
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
        public static string UpdateDimentionSetting(int min_Length, int min_Width, int min_Height, int min_Weight, int max_Length, int max_Width, int max_Height, int max_Weight)
        {
            try
            {
                DataTable dtList = Calibration.UpdateDimentionSetting(min_Length, min_Width, min_Height, min_Weight, max_Length, max_Width, max_Height, max_Weight);
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
        public static string UpdateFlagDBAddress(int ID ,string DBAddress)
        {
            try
            {
                DataTable dtList = Calibration.UpdateFlagDBAddress(ID , DBAddress);
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
        public static string UpdateAlarm(int ID, string AlarmDBAddress, string Rectification_Action)
        {
            try
            {
                DataTable dtList = Calibration.UpdateAlarm(ID, AlarmDBAddress, Rectification_Action);
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
        public static string InsertAlarm(string FaultName, string DBAddress, string Rectification_Action)
        {
            try
            {
                DataTable dtList = Calibration.InsertAlarm(FaultName, DBAddress, Rectification_Action);
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