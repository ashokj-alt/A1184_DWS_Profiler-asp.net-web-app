using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;

namespace DWS_Profiler.DataAccessLayer
{
    public class CommonDataLayer
    {
        public static string GetConnectionString()
        {
            return (ConfigurationSettings.AppSettings["SQLConnection"].ToString());
        }

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

        public static DataSet GetDataSet(string ProcName, SqlCommand cmd)
        {
            DataSet ds = new DataSet();
            try
            {
                SqlConnection cn = new SqlConnection(GetConnectionString());
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = ProcName;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }
            catch (Exception e)
            {
                throw e;
            }
            return ds;
        }

        public static DataSet GetDataSet(string ProcName)
        {
            DataSet ds = new DataSet();
            try
            {
                SqlCommand cmd = new SqlCommand();
                SqlConnection cn = new SqlConnection(GetConnectionString());
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = ProcName;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }
            catch (Exception e)
            {
                throw e;
            }
            return ds;
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

        public static string ExecuteScalar(SqlCommand cmd)
        {
            string returnStr = null;
            SqlConnection cn = new SqlConnection(GetConnectionString());
            try
            {
                cn.Open();
                cmd.Connection = cn;
                object result = cmd.ExecuteScalar();
                if (result != null)
                    returnStr = result.ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (cn.State == ConnectionState.Open)
                    cn.Close();
            }


            return returnStr;

        }

        public static List<int> ExecuteNonQueryTransaction(List<SqlCommand> commandList)
        {
            List<int> commandResult = new List<int>();
            SqlConnection cn = new SqlConnection(GetConnectionString());
            SqlTransaction tran;
            try
            {
                cn.Open();
                tran = cn.BeginTransaction();
                foreach (SqlCommand cmd in commandList)
                {
                    cmd.Connection = cn;
                    cmd.Transaction = tran;

                    try
                    {
                        commandResult.Add(cmd.ExecuteNonQuery());
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        throw ex;
                    }
                }
                tran.Commit();
                cn.Close();
            }
            catch (Exception e)
            {

                throw e;
            }
            finally { }
            return commandResult;
        }

        public static SqlTransaction StartTransaction()
        {
            SqlConnection cn = new SqlConnection(GetConnectionString());
            SqlTransaction tran;
            try
            {
                cn.Open();
                tran = cn.BeginTransaction();

            }
            catch (Exception ex)
            {
                throw ex;

            }
            return tran;
        }
        public static int ExecuteNonQuery(SqlTransaction tran, SqlCommand cmd)
        {
            cmd.Connection = tran.Connection;
            cmd.Transaction = tran;
            try
            {
                return cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw ex;
            }
        }
        public static void EndTransaction(SqlTransaction tran)
        {
            try
            {
                tran.Commit();
            }
            catch (Exception ex)
            {

            }
            finally
            {
                // tran.Connection.Close();
            }
        }

    }
}