using DWS_Profiler.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DWS_Profiler.BusinessLayer
{
    public class Calibration
    {
        public static DataTable GetCalibrationList()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "Master_CalibrationBoxSetting_GetList";
            try
            {
                dt = CommonDataLayer.GetDataTable("Master_CalibrationBoxSetting_GetList", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataSet GetDataSetting()
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "GetDataSetting";
            try
            {
                ds = CommonDataLayer.GetDataSet("GetDataSetting", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable updateMachineSetting(string Machine_ID, string Machine_Location)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "System_Data_Sent_Setting_Update";
            cmd.Parameters.AddWithValue("@Machine_ID", Machine_ID);
            cmd.Parameters.AddWithValue("@Machine_Location", Machine_Location);
            cmd.Parameters.AddWithValue("@updateMachineSetting", "updateMachineSetting");
            try
            {
                dt = CommonDataLayer.GetDataTable("System_Data_Sent_Setting_Update", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        
        public static DataTable UpdateDataSentSetting(string Weight_URL, string Weight_API_Token, string GI_URL, string GI_API_Token, string Calibration_URL, string Calibration_API_Token)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "System_Data_Sent_Setting_UpdateDataSentSetting";
            cmd.Parameters.AddWithValue("@Weight_URL", Weight_URL);
            cmd.Parameters.AddWithValue("@Weight_API_Token", Weight_API_Token);
            cmd.Parameters.AddWithValue("@GI_URL", GI_URL);
            cmd.Parameters.AddWithValue("@GI_API_Token", GI_API_Token);
            cmd.Parameters.AddWithValue("@Calibration_URL", Calibration_URL);
            cmd.Parameters.AddWithValue("@Calibration_API_Token", Calibration_API_Token);
            cmd.Parameters.AddWithValue("@UpdateDataSentSetting", "UpdateDataSentSetting");
            try
            {
                dt = CommonDataLayer.GetDataTable("System_Data_Sent_Setting_UpdateDataSentSetting", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        
        public static DataTable updateImageSentSetting(string Image_API_Key, string Image_Secret_Key, string Image_Bucket_Name, string Image_Local_File_Path, string Image_key_Name)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "System_Data_Sent_Setting_updateImageSentSetting";
            cmd.Parameters.AddWithValue("@Image_API_Key", Image_API_Key);
            cmd.Parameters.AddWithValue("@Image_Secret_Key", Image_Secret_Key);
            cmd.Parameters.AddWithValue("@Image_Bucket_Name", Image_Bucket_Name);
            cmd.Parameters.AddWithValue("@Image_Local_File_Path", Image_Local_File_Path);
            cmd.Parameters.AddWithValue("@Image_key_Name", Image_key_Name);
            cmd.Parameters.AddWithValue("@updateImageSentSetting", "updateImageSentSetting");
            try
            {
                dt = CommonDataLayer.GetDataTable("System_Data_Sent_Setting_updateImageSentSetting", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        
        public static DataTable UpdateIPtSetting(string Camera_IP, string VMS_IP, string Check_Weigher_IP, string PLC_IP, string HMI_IP, string Scanner_Port, int CheckWeigher_LAN_Port, int VMS_LAN_Port)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "IP_Settings_UpdateIPtSetting";
            cmd.Parameters.AddWithValue("@Camera_IP", Camera_IP);
            cmd.Parameters.AddWithValue("@VMS_IP", VMS_IP);
            cmd.Parameters.AddWithValue("@Check_Weigher_IP", Check_Weigher_IP);
            cmd.Parameters.AddWithValue("@PLC_IP", PLC_IP);
            cmd.Parameters.AddWithValue("@HMI_IP", HMI_IP);
            cmd.Parameters.AddWithValue("@Scanner_Port", Scanner_Port);
            cmd.Parameters.AddWithValue("@CheckWeigher_LAN_Port", CheckWeigher_LAN_Port);
            cmd.Parameters.AddWithValue("@VMS_LAN_Port", VMS_LAN_Port);
            cmd.Parameters.AddWithValue("@UpdateIPtSetting", "UpdateIPtSetting");
            try
            {
                dt = CommonDataLayer.GetDataTable("IP_Settings_UpdateIPtSetting", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        
            public static DataTable UpdateDimentionSetting(int min_Length, int min_Width, int min_Height, int min_Weight, int max_Length, int max_Width,int max_Height, int max_Weight)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Setting_Data_UpdateDimentionSetting";
            cmd.Parameters.AddWithValue("@min_Length", min_Length);
            cmd.Parameters.AddWithValue("@min_Width", min_Width);
            cmd.Parameters.AddWithValue("@min_Height", min_Height);
            cmd.Parameters.AddWithValue("@min_Weight", min_Weight);
            cmd.Parameters.AddWithValue("@max_Length", max_Length);
            cmd.Parameters.AddWithValue("@max_Width", max_Width);
            cmd.Parameters.AddWithValue("@max_Height", max_Height);
            cmd.Parameters.AddWithValue("@max_Weight", max_Weight);
            cmd.Parameters.AddWithValue("@UpdateDimentionSetting", "UpdateDimentionSetting");
            try
            {
                dt = CommonDataLayer.GetDataTable("Setting_Data_UpdateDimentionSetting", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        
            public static DataTable UpdateFlagDBAddress(int ID , string DBAddress)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_DBAddress_Flag_Update";
            cmd.Parameters.AddWithValue("@ID", ID);
            cmd.Parameters.AddWithValue("@DBAddress", DBAddress);
            try
            {
                dt = CommonDataLayer.GetDataTable("Master_DBAddress_Flag_Update", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        
        public static DataTable UpdateAlarm(int ID, string AlarmDBAddress, string Rectification_Action)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_Fault_Details_DBAddress_Update";
            cmd.Parameters.AddWithValue("@ID", ID);
            cmd.Parameters.AddWithValue("@AlarmDBAddress", AlarmDBAddress);
            cmd.Parameters.AddWithValue("@Rectification_Action", Rectification_Action);
            try
            {
                dt = CommonDataLayer.GetDataTable("Master_Fault_Details_DBAddress_Update", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        
        public static DataTable InsertAlarm(string FaultName, string DBAddress, string Rectification_Action)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_Fault_Details_DBAddress_Insert";
            cmd.Parameters.AddWithValue("@FaultName", FaultName);
            cmd.Parameters.AddWithValue("@DBAddress", DBAddress);
            cmd.Parameters.AddWithValue("@Rectification_Action", Rectification_Action);
            cmd.Parameters.AddWithValue("@Action", "Insert");
            try
            {
                dt = CommonDataLayer.GetDataTable("Master_Fault_Details_DBAddress_Insert", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
    }
}