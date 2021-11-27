using DWS_Profiler.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DWS_Profiler.BusinessLayer.UserManagement
{
    public class UserGroup
    {
        public Int64 Id { get; set; }
        public int userGroupId { get; set; }
        public string GroupName { get; set; }
        public string Description { get; set; }
        public string ProjectCode { get; set; }
        public DateTime? CreatedOn { get; set; }
        public Int64 CreatedBy { get; set; }
        public DateTime? LastUpdatedOn { get; set; }
        public Int64 LastUpdatedBy { get; set; }
        private string _tableName = "UserManagement_UserGroup";

        public UserGroup()
        {
            this.ProjectCode = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
            this.CreatedBy = Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]);
            this.LastUpdatedBy = Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]);
        }

        public int Insert()
        {
            int id;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_UserGroup_Insert";
            cmd.Parameters.AddWithValue("@Id", 0);
            cmd.Parameters.AddWithValue("@GroupName", this.GroupName);
            cmd.Parameters.AddWithValue("@Description", this.Description);
            cmd.Parameters.AddWithValue("@ProjectCode", this.ProjectCode);
            cmd.Parameters.AddWithValue("@CreatedBy", this.CreatedBy);

            try
            {
                id = Convert.ToInt32(CommonDataLayer.ExecuteNonQuery("UserManagement_UserGroup_Insert", cmd));
            }
            catch (Exception ex) { throw ex; }
            return id;
        }

        public long Update()
        {
            int id;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_UserGroup_Update";
            cmd.Parameters.AddWithValue("@Id", this.Id);
            cmd.Parameters.AddWithValue("@GroupName", this.GroupName);
            cmd.Parameters.AddWithValue("@Description", this.Description);
            //  cmd.Parameters.AddWithValue("@ProjectCode", this.ProjectCode);
            //    cmd.Parameters.AddWithValue("@CreatedOn", this.CreatedOn);
            //     cmd.Parameters.AddWithValue("@CreatedBy", this.CreatedBy);
            //cmd.Parameters.AddWithValue("@LastUpdatedOn", this.LastUpdatedOn);
            cmd.Parameters.AddWithValue("@LastUpdatedBy", this.LastUpdatedBy);
            try
            {
                id = Convert.ToInt32(CommonDataLayer.ExecuteNonQuery("UserManagement_UserGroup_Update", cmd));
            }
            catch (Exception ex) { throw ex; }
            return id;
        }

        public void Delete()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_UserGroup_Delete";
            cmd.Parameters.AddWithValue("@Id", this.Id);
            try
            {
                CommonDataLayer.ExecuteNonQuery("UserManagement_UserGroup_Delete", cmd);
            }
            catch (Exception ex) { throw ex; }

        }

        public static DataTable GetList(string ProjectCode)
        {
            //string ProjectCode = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            cmd.CommandText = "UserManagement_UserGroup_GetList";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_UserGroup_GetList", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }
        public static DataTable GetUserList(int GroupId)
        {
            string ProjectCode = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            cmd.Parameters.AddWithValue("@UserGroup_Id", GroupId);
            cmd.CommandText = "UserManagement_User_GetList1";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_User_GetList1", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }

        public static DataTable GetMenuList()
        {
            string ProjectCode = System.Configuration.ConfigurationManager.AppSettings["ProjectCode"].ToString();
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            cmd.CommandText = "UserManagement_Menu_FetchSingleMenu";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_Menu_FetchSingleMenu", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }
        public void GetRecordById()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_UserGroup_GetRecordById";
            cmd.Parameters.AddWithValue("@Id", this.Id);
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_UserGroup_GetRecordById", cmd);
            }
            catch (Exception ex) { throw ex; }

            this.Id = Convert.ToInt64(dt.Rows[0]["Id"]);
            this.GroupName = Convert.ToString(dt.Rows[0]["GroupName"]);
            this.Description = Convert.ToString(dt.Rows[0]["Description"]);
            this.ProjectCode = Convert.ToString(dt.Rows[0]["ProjectCode"]);
            if (dt.Rows[0]["CreatedOn"] != DBNull.Value)
                this.CreatedOn = Convert.ToDateTime(dt.Rows[0]["CreatedOn"]);
            else
                this.CreatedOn = null;
            this.CreatedBy = Convert.ToInt64(dt.Rows[0]["CreatedBy"]);
            if (dt.Rows[0]["LastUpdatedOn"] != DBNull.Value)
                this.LastUpdatedOn = Convert.ToDateTime(dt.Rows[0]["LastUpdatedOn"]);
            else
                this.LastUpdatedOn = null;
            this.LastUpdatedBy = Convert.ToInt64(dt.Rows[0]["LastUpdatedBy"]);
        }

        public DataTable GetRecordsByDynamicSearch(string strGetFields, string strSearchField, string strSearchValue)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DynamicSearch";
            cmd.Parameters.AddWithValue("@GetFields", strGetFields);
            cmd.Parameters.AddWithValue("@SearchField", strSearchField);
            cmd.Parameters.AddWithValue("@SearchValue", strSearchValue);
            cmd.Parameters.AddWithValue("@SearchTable", this._tableName);
            try
            {
                dt = CommonDataLayer.GetDataTable("DynamicSearch", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }
    }
}