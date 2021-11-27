using DWS_Profiler.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DWS_Profiler.BusinessLayer.dashboard
{
    public class dashboard
    {
        public static DataSet Countdata()
        {

            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_dashboard_Data";
            try
            {
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_dashboard_Data", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return dt;
        }
        
        public static DataSet DashboardData()
        {

            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_NewDashboard_Data";
            try
            {
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_NewDashboard_Data", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return dt;
        }

        public static DataTable GetList()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "DWS_Data_Log_Dashboard_Data_List";
            try
            {
                dt = CommonDataLayer.GetDataTable("DWS_Data_Log_Dashboard_Data_List", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataSet SearchBarcodeData(string Barcode)
        {
            DataSet dt = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Barcode", Barcode);
            cmd.CommandText = "DWS_Data_Log_Dashboard_Search_Barcode";
            try
            {
                dt = CommonDataLayer.GetDataSet("DWS_Data_Log_Dashboard_Search_Barcode", cmd);
                return dt;
            }
            catch (Exception ex) { throw ex; }
            
        }
    }
}