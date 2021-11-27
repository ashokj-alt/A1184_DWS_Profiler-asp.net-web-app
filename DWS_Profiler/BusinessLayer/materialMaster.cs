using System;
using System.Data;
using System.Data.SqlClient;

namespace DWS_Profiler.BusinessLayer
{
    public class materialMaster
    {
        public string SKUML { get; set; }

        public string SKUUnit { get; set; }

        public string SKUSize { get; set; }
        public Int16 Id { get; set; }

        public static DataTable GetList()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "Master_SKU_Test_GetaData";
            try
            {
                dt = DataAccessLayer.materiaMaster.GetDataTable("Master_SKU_Test_GetaData", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable Update(string MatCode, string SKUML, string SKUUnit, string SKUSize)
        {
            //int Id;
            //SqlCommand cmd = new SqlCommand();
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.CommandText = "Master_SKU_Test_Update";
            //cmd.Parameters.AddWithValue("@Id", this.Id);
            //cmd.Parameters.AddWithValue("@SKUML", this.SKUML);
            //cmd.Parameters.AddWithValue("@SKUSize", this.SKUSize);
            //cmd.Parameters.AddWithValue("@SKUUnit", this.SKUUnit);

            //try
            //{
            //    Id = Convert.ToInt32(DataAccessLayer.materiaMaster.ExecuteNonQuery("Master_SKU_Test_Update", cmd));
            //}
            //catch (Exception ex) { throw ex; }
            //return Id;
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MatCode", MatCode);
            cmd.Parameters.AddWithValue("@SKUML", SKUML);
            cmd.Parameters.AddWithValue("@SKUUnit", SKUUnit);
            cmd.Parameters.AddWithValue("@SKUSize", SKUSize);
            cmd.CommandText = "Master_SKU_Test_Update";
            try { 
            dt = DataAccessLayer.materiaMaster.GetDataTable("Master_SKU_Test_Update", cmd);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;

        }

        public long Insert()
        {

            long Id;
            //string enPassword; /*= armstrong.BusinessLayer.SSTCryptographer.Encrypt(Password, "")*/;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_SKU_Test_Insert";
            SqlParameter paraId = new SqlParameter("@Id", SqlDbType.BigInt);
            paraId.Direction = ParameterDirection.InputOutput;
            cmd.Parameters.Add(paraId);

            //cmd.Parameters.AddWithValue("@employee_name", this.employee_name);
            //cmd.Parameters.AddWithValue("@designation", this.designation);
            //cmd.Parameters.AddWithValue("@salary", this.salary);
            
            try
            {
                Id = Convert.ToInt32(DataAccessLayer.materiaMaster.ExecuteNonQuery("Master_SKU_Test_Insert", cmd));
                Id = Convert.ToInt64(paraId.Value);
            }
            catch (Exception ex) { throw ex; }

            return Id;
        }

        internal static DataTable UnSave(string matCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MatCode", matCode);
            cmd.CommandText = "Master_SKU_Test_Unsave";
            try
            {
                dt = DataAccessLayer.materiaMaster.GetDataTable("Master_SKU_Test_Unsave", cmd);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static void DeleteUser(string MatCode)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_SKU_Test_Delete_Data";
            cmd.Parameters.AddWithValue("@MatCode", MatCode);
            try
            {
                DataAccessLayer.materiaMaster.ExecuteNonQuery("Master_SKU_Test_Delete_Data", cmd);
            }
            catch (Exception ex) { throw ex; }
        }

        
    }
}