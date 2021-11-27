using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace DWS_Profiler.DataAccessLayer
{
    public class materiaMaster
    {
        public static DataTable GetDataTable(string ProcName, SqlCommand cmd)
        {
            DataTable dt = new DataTable();
            try
            {
                SqlConnection cn = new SqlConnection(GetConnectionString());
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = ProcName;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            catch (Exception e)
            {
                throw e;
            }
            return dt;
        }

        public static string GetConnectionString()
        {
            return (ConfigurationSettings.AppSettings["SQLConnection"].ToString());
        }

        public static int ExecuteNonQuery(string ProcName, SqlCommand cmd)
        {
            int ResultExecuteNonQuery = 0;
            SqlConnection cn = new SqlConnection(GetConnectionString());
            try
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = ProcName;
                cn.Open();
                ResultExecuteNonQuery = cmd.ExecuteNonQuery();
                cn.Close();
            }
            catch (Exception e)
            {
                throw e;
            }
            return ResultExecuteNonQuery;
        }
    }
}