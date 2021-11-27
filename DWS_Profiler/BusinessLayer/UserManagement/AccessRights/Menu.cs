using DWS_Profiler.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DWS_Profiler.BusinessLayer.UserManagement.AccessRights
{
    public class Menu
    {
        public int MenuId { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }
        public string URL { get; set; }
        public int ParentId { get; set; }
        public int Sequence { get; set; }
        public int IsActive { get; set; }
        public string ClassIcon { get; set; }
        public DateTime? CreatedOn { get; set; }
        public Int64 CreatedBy { get; set; }
        public Int64 LastUpdatedBy { get; set; }
        public DateTime? LastUpdatedOn { get; set; }
        private string _tableName = "UserManagement_Menu";

        public static DataTable FetchParentMenu(int parentId)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@ParentId", parentId);
            cmdFetch.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            return CommonDataLayer.GetDataTable("UserManagement_Menu_FetchParentMenu", cmdFetch);
        }

        public static DataTable FetchSequenceMenu(int parentId)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@ParentId", parentId);
            cmdFetch.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            return CommonDataLayer.GetDataTable("UserManagement_Menu_FetchSequenceMenu", cmdFetch);
        }

        public static DataTable FetchMenu_AccessRights(string user_id)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@User_id", user_id);
            //cmdFetch.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            return CommonDataLayer.GetDataTable("UserManagement_Menu_AccessRights", cmdFetch);
        }

        public static DataTable FetchMenu_AccessRights()
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@User_id", System.Web.HttpContext.Current.Session["UserId"].ToString());
            //cmdFetch.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            return CommonDataLayer.GetDataTable("UserManagement_Menu_AccessRights", cmdFetch);
        }

        public int InsertMenu()
        {
            SqlCommand cmdInsert = new SqlCommand();
            cmdInsert.Parameters.AddWithValue("@Label", this.Label);
            cmdInsert.Parameters.AddWithValue("@Description", this.Description);
            cmdInsert.Parameters.AddWithValue("@Url", this.URL);
            cmdInsert.Parameters.AddWithValue("@ParentId", this.ParentId);
            cmdInsert.Parameters.AddWithValue("@IsActive", this.IsActive);
            cmdInsert.Parameters.AddWithValue("@Sequence", this.Sequence);
            cmdInsert.Parameters.AddWithValue("@ClassIcon", this.ClassIcon);
            cmdInsert.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmdInsert.Parameters.AddWithValue("@CreatedBy", Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]));

            return CommonDataLayer.ExecuteNonQuery("UserManagement_Menu_Insert", cmdInsert);
        }

        public int UpdateMenu()
        {
            SqlCommand cmdUpdate = new SqlCommand();
            cmdUpdate.Parameters.AddWithValue("@Label", this.Label);
            cmdUpdate.Parameters.AddWithValue("@Description", this.Description);
            cmdUpdate.Parameters.AddWithValue("@Url", this.URL);
            cmdUpdate.Parameters.AddWithValue("@MenuId", this.MenuId);
            cmdUpdate.Parameters.AddWithValue("@IsActive", this.IsActive);
            cmdUpdate.Parameters.AddWithValue("@Sequence", this.Sequence);
            cmdUpdate.Parameters.AddWithValue("@ClassIcon", this.ClassIcon);
            cmdUpdate.Parameters.AddWithValue("@LastUpdatedBy", Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]));
            return CommonDataLayer.ExecuteNonQuery("UserManagement_Menu_Update", cmdUpdate);
        }

        public static int Deletemenu(string menu)
        {
            SqlCommand cmdDelete = new SqlCommand();
            cmdDelete.Parameters.AddWithValue("@mnu", menu);
            return CommonDataLayer.ExecuteNonQuery("UserManagement_Menu_DeleteMenus", cmdDelete);
        }

        public static DataTable FetchSubMenus(int parentId)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@ParentId", parentId);
            return CommonDataLayer.GetDataTable("UserManagement_Menu_FetchSubMenus", cmdFetch);
        }

        public static DataTable FetchSingleMenu(int menuId)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@MenuId", menuId);
            return CommonDataLayer.GetDataTable("UserManagement_Menu_FetchSingleMenu", cmdFetch);
        }




        public void Delete()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_Menu_Delete";
            cmd.Parameters.AddWithValue("@MenuId", this.MenuId);
            try
            {
                CommonDataLayer.ExecuteNonQuery("Master_Menu_Delete", cmd);
            }
            catch (Exception ex) { throw ex; }

        }

        public static DataTable GetList()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "UserManagement_Menu_GetList";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_Menu_GetList", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }

        public void GetRecordById()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_Menu_GetRecordById";
            cmd.Parameters.AddWithValue("@MenuId", this.MenuId);
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_Menu_GetRecordById", cmd);
            }
            catch (Exception ex) { throw ex; }

            this.MenuId = Convert.ToInt32(dt.Rows[0]["MenuId"]);
            this.Label = Convert.ToString(dt.Rows[0]["Label"]);
            this.Description = Convert.ToString(dt.Rows[0]["Description"]);
            this.URL = Convert.ToString(dt.Rows[0]["URL"]);
            this.ParentId = Convert.ToInt32(dt.Rows[0]["ParentId"]);
            this.Sequence = Convert.ToInt32(dt.Rows[0]["Sequence"]);
            this.IsActive = Convert.ToInt32(dt.Rows[0]["IsActive"]);
            //this.ColorCode = Convert.ToString(dt.Rows[0]["ColorCode"]);
            if (dt.Rows[0]["CreatedOn"] != DBNull.Value)
                this.CreatedOn = Convert.ToDateTime(dt.Rows[0]["CreatedOn"]);
            else
                this.CreatedOn = null;
            this.CreatedBy = Convert.ToInt64(dt.Rows[0]["CreatedBy"]);
            this.LastUpdatedBy = Convert.ToInt64(dt.Rows[0]["LastUpdatedBy"]);
            if (dt.Rows[0]["LastUpdatedOn"] != DBNull.Value)
                this.LastUpdatedOn = Convert.ToDateTime(dt.Rows[0]["LastUpdatedOn"]);
            else
                this.LastUpdatedOn = null;
        }
    }
}