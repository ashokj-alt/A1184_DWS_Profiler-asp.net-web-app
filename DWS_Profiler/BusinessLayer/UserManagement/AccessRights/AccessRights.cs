using DWS_Profiler.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DWS_Profiler.BusinessLayer.UserManagement.AccessRights
{
    public class AccessRights
    {
        public int RightId { get; set; }
        public int MenuId { get; set; }
        public int User_id { get; set; }
        public int CanAdd { get; set; }
        public int CanEdit { get; set; }
        public int CanDelete { get; set; }
        public int CanView { get; set; }
        public int UserGroup_Id { get; set; }
        public string ProjectCode { get; set; }
        public Int64 CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public Int64 LastUpdatedBy { get; set; }
        public DateTime? LastUpdatedOn { get; set; }
        private string _tableName = "UserManagement_AccessRights";

        public AccessRights()
        {

        }

        public static DataTable GetList_UserGroup(string UserGroup)
        {
            string U_Group = UserGroup;
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserGroup_Id", UserGroup);
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "UserManagement_User_GetListByGroupName";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_User_GetListByGroupName", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }

        public int Insert()
        {
            int id = 0;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_AccessRights_Insert";
            // cmd.Parameters.AddWithValue("@RightId", 0);
            cmd.Parameters.AddWithValue("@MenuId", this.MenuId);
            cmd.Parameters.AddWithValue("@User_id", this.User_id);
            cmd.Parameters.AddWithValue("@UserGroup_Id", this.UserGroup_Id);
            cmd.Parameters.AddWithValue("@CanAdd", this.CanAdd);
            cmd.Parameters.AddWithValue("@CanEdit", this.CanEdit);
            cmd.Parameters.AddWithValue("@CanDelete", this.CanDelete);
            cmd.Parameters.AddWithValue("@CanView", this.CanView);
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.Parameters.AddWithValue("@CreatedBy", Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]));
            // cmd.Parameters.AddWithValue("@CreatedOn", this.CreatedOn);
            // cmd.Parameters.AddWithValue("@LastUpdatedBy", this.LastUpdatedBy);
            //cmd.Parameters.AddWithValue("@LastUpdatedOn", this.LastUpdatedOn);
            try
            {
                id = Convert.ToInt32(CommonDataLayer.ExecuteNonQuery("UserManagement_AccessRights_Insert", cmd));
            }
            catch (Exception ex) { throw ex; }
            return id;
        }

        public int Insert_User()
        {
            int id = 0;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_AccessRights_Insert_User";
            // cmd.Parameters.AddWithValue("@RightId", 0);
            cmd.Parameters.AddWithValue("@MenuId", this.MenuId);
            cmd.Parameters.AddWithValue("@User_id", this.User_id);
            cmd.Parameters.AddWithValue("@UserGroup_Id", this.UserGroup_Id);
            cmd.Parameters.AddWithValue("@CanAdd", this.CanAdd);
            cmd.Parameters.AddWithValue("@CanEdit", this.CanEdit);
            cmd.Parameters.AddWithValue("@CanDelete", this.CanDelete);
            cmd.Parameters.AddWithValue("@CanView", this.CanView);
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.Parameters.AddWithValue("@CreatedBy", Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]));
            // cmd.Parameters.AddWithValue("@CreatedOn", this.CreatedOn);
            // cmd.Parameters.AddWithValue("@LastUpdatedBy", this.LastUpdatedBy);
            //cmd.Parameters.AddWithValue("@LastUpdatedOn", this.LastUpdatedOn);
            try
            {
                id = Convert.ToInt32(CommonDataLayer.ExecuteNonQuery("UserManagement_AccessRights_Insert_User", cmd));
            }
            catch (Exception ex) { throw ex; }
            return id;
        }

        public int Update()
        {
            int id = 0;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_AccessRights_Update";
            //cmd.Parameters.AddWithValue("@RightId", this.RightId);
            cmd.Parameters.AddWithValue("@MenuId", this.MenuId);
            cmd.Parameters.AddWithValue("@User_id", this.User_id);
            cmd.Parameters.AddWithValue("@UserGroup_Id", this.UserGroup_Id);
            cmd.Parameters.AddWithValue("@CanAdd", this.CanAdd);
            cmd.Parameters.AddWithValue("@CanEdit", this.CanEdit);
            cmd.Parameters.AddWithValue("@CanDelete", this.CanDelete);
            cmd.Parameters.AddWithValue("@CanView", this.CanView);
            cmd.Parameters.AddWithValue("@ProjectCode", this.ProjectCode);
            // cmd.Parameters.AddWithValue("@CreatedBy", this.CreatedBy);
            // cmd.Parameters.AddWithValue("@CreatedOn", this.CreatedOn);
            cmd.Parameters.AddWithValue("@LastUpdatedBy", this.LastUpdatedBy);
            //cmd.Parameters.AddWithValue("@LastUpdatedOn", this.LastUpdatedOn);
            try
            {
                //id = Convert.ToInt32(CommonDataLayer.ExecuteNonQuery("UserManagement_AccessRights_Update", cmd));
            }
            catch (Exception ex) { throw ex; }
            return id;
        }

        public void Delete()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_User_Delete";
            cmd.Parameters.AddWithValue("@Id", this.User_id);
            try
            {
                CommonDataLayer.ExecuteNonQuery("UserManagement_User_Delete", cmd);
            }
            catch (Exception ex) { throw ex; }

        }

        public static DataTable FetchList_User(string MenuId, string U_Id)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MenuId", MenuId);
            cmd.Parameters.AddWithValue("@User_id", U_Id);
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "UserManagement_AccessRights_GetList_MenuID_User";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_AccessRights_GetList_MenuID_User", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable FetchList_UserList(string MenuId)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MenuId", MenuId);
            //cmd.Parameters.AddWithValue("@User_id", 0);
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "UserManagement_AccessRights_UserList_MenuID";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_AccessRights_UserList_MenuID", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable FetchList(string MenuId)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MenuId", MenuId);
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "UserManagement_AccessRights_GetList_MenuID";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_AccessRights_GetList_MenuID", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        public static DataTable FetchSingleUserList(string MenuId)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", MenuId);
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "UserManagement_AccessRights_GetList_UserID";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_AccessRights_GetList_UserID", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetList()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "UserManagement_AccessRights_GetList";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_AccessRights_GetList", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }

        public static DataTable GetUserGroupList(string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            cmd.CommandText = "UserManagement_AccessRights_GetListbyUG";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_AccessRights_GetListbyUG", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }



        public void GetRecordById()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_AccessRights_GetRecordById";
            cmd.Parameters.AddWithValue("@RightId", this.RightId);
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_AccessRights_GetRecordById", cmd);
            }
            catch (Exception ex) { throw ex; }

            this.RightId = Convert.ToInt32(dt.Rows[0]["RightId"]);
            this.MenuId = Convert.ToInt32(dt.Rows[0]["MenuId"]);
            this.User_id = Convert.ToInt32(dt.Rows[0]["User_id"]);
            this.CanAdd = Convert.ToInt32(dt.Rows[0]["CanAdd"]);
            this.CanEdit = Convert.ToInt32(dt.Rows[0]["CanEdit"]);
            this.CanDelete = Convert.ToInt32(dt.Rows[0]["CanDelete"]);
            this.CanView = Convert.ToInt32(dt.Rows[0]["CanView"]);
            this.ProjectCode = Convert.ToString(dt.Rows[0]["ProjectCode"]);
            this.CreatedBy = Convert.ToInt64(dt.Rows[0]["CreatedBy"]);
            if (dt.Rows[0]["CreatedOn"] != DBNull.Value)
                this.CreatedOn = Convert.ToDateTime(dt.Rows[0]["CreatedOn"]);
            else
                this.CreatedOn = null;
            this.LastUpdatedBy = Convert.ToInt64(dt.Rows[0]["LastUpdatedBy"]);
            if (dt.Rows[0]["LastUpdatedOn"] != DBNull.Value)
                this.LastUpdatedOn = Convert.ToDateTime(dt.Rows[0]["LastUpdatedOn"]);
            else
                this.LastUpdatedOn = null;
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

        public static DataTable GetPageUserAccessRights(string url)
        {

            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@url", url);
            cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(System.Web.HttpContext.Current.Session["UserId"]));
            int userid = Convert.ToInt32(System.Web.HttpContext.Current.Session["UserId"]);
            cmd.Parameters.AddWithValue("@ProjectCode", Convert.ToString(System.Web.HttpContext.Current.Session["ProjectCode"]));
            cmd.CommandText = "UserManagement_GetUserAccessRights";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_GetUserAccessRights", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }
    }

}