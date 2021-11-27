using DWS_Profiler.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DWS_Profiler.BusinessLayer.RobotAnnunciation
{
    public class RobotAnnaunciation
    {
        
        public static DataSet Robot_Annunciation(string CellNo)
        {
            string ProjectCode = System.Configuration.ConfigurationManager.AppSettings["ProjectCode"].ToString();
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            cmd.Parameters.AddWithValue("@CellNo", CellNo);
            cmd.CommandText = "RobotAnnunciation_GetData";
            try
            {
                ds = CommonDataLayer.GetDataSet("RobotAnnunciation_GetData", cmd);
                //  string json = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return dt;
        }
        public static DataSet CountAnnunciation(string CellNo)
        {

            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@cellNo", CellNo);
            //cmd.CommandText = "SortingLog_Annaunciation";
            cmd.CommandText = "Robot_Pallet_Details_PerHour_Select";
            try
            {
                ds = CommonDataLayer.GetDataSet("Robot_Pallet_Details_PerHour_Select", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return dt;
        }
    }
}