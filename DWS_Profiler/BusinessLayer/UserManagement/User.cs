using DWS_Profiler.DataAccessLayer;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DWS_Profiler.BusinessLayer.UserManagement
{
    
    public class User
    {
        public Int64 Id { get; set; }
        public string LoginName { get; set; }
        public string Name { get; set; }
        public string UserGroup_Id { get; set; }
        public string GroupName { get; set; }
        public string Description { get; set; }
        public string Mobile { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string ProjectCode { get; set; }
        public Int64 CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public Int64 LastUpdatedBy { get; set; }
        
        public DateTime? LastUpdatedOn { get; set; }
        private string _tableName = "UserManagement_User";

        public User()
        {
            this.ProjectCode = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
            this.CreatedBy = Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]);
            this.LastUpdatedBy = Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]);
        }

        public static DataTable Login(string loginName, string password, string projectCode)
        {
            DataTable dt = new DataTable();
            
            string enPassword = SSTCryptographer.Encrypt(password, "");

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_User_Login"; //UserManagement_User_Login
            cmd.Parameters.AddWithValue("@LoginName", loginName);
            cmd.Parameters.AddWithValue("@Password", enPassword);
            cmd.Parameters.AddWithValue("@ProjectCode", projectCode);
            string proc = "UserManagement_User_Login";
            try
            {
                dt = CommonDataLayer.GetDataTable(proc, cmd);
            }
            catch (Exception ex) { throw ex; }

            return dt;
        }
        
        public static void InsertLoginDetails(string loginName, string password, string projectCode)
        {
            string enPassword = SSTCryptographer.Encrypt(password, "");

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "LoginDetails_Insert_Login_Details";
            cmd.Parameters.AddWithValue("@LoginName", loginName);
            cmd.Parameters.AddWithValue("@Password", enPassword);
            cmd.Parameters.AddWithValue("@ProjectCode", projectCode);
            string proc = "LoginDetails_Insert_Login_Details";
            try
            {
                CommonDataLayer.ExecuteNonQuery(proc, cmd);
            }
            catch (Exception ex) { throw ex; }

        }
        
        public static void InsertAccesRightLog(int UserId)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "AccesRightLog_Access_Change_Details_insert";
            cmd.Parameters.AddWithValue("@UserId", UserId);
            string proc = "AccesRightLog_Access_Change_Details_insert";
            try
            {
                CommonDataLayer.ExecuteNonQuery(proc, cmd);
            }
            catch (Exception ex) { throw ex; }

        }
        public long Insert()
        {
            long id;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_User_Insert";
            SqlParameter paraId = new SqlParameter("@Id", SqlDbType.BigInt);
            paraId.Direction = ParameterDirection.InputOutput;
            cmd.Parameters.Add(paraId);
            string enPassword = DWS_Profiler.BusinessLayer.UserManagement.SSTCryptographer.Encrypt(this.Password, "");
            cmd.Parameters.AddWithValue("@LoginName", this.LoginName);
            cmd.Parameters.AddWithValue("@Name", this.Name);
            cmd.Parameters.AddWithValue("@UserGroup_Id", this.UserGroup_Id);
            cmd.Parameters.AddWithValue("@Password", enPassword);

            cmd.Parameters.AddWithValue("@ProjectCode", this.ProjectCode);
            cmd.Parameters.AddWithValue("@CreatedBy", this.CreatedBy);
            try
            {
                id = Convert.ToInt32(CommonDataLayer.ExecuteNonQuery("UserManagement_User_Insert", cmd));
                id = Convert.ToInt64(paraId.Value);
            }
            catch (Exception ex) { throw ex; }

            return id;
        }
        public long InsertGroup()
        {
            long id;
            int OperationType = 1;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_UserGroup_Insert";
            SqlParameter paraId = new SqlParameter("@Id", SqlDbType.BigInt);
            paraId.Direction = ParameterDirection.InputOutput;
            cmd.Parameters.Add(paraId);
            cmd.Parameters.AddWithValue("@UserGroup", this.GroupName);
            cmd.Parameters.AddWithValue("@Description", this.Description);
            cmd.Parameters.AddWithValue("@OperationType", OperationType);

            cmd.Parameters.AddWithValue("@ProjectCode", this.ProjectCode);
            cmd.Parameters.AddWithValue("@CreatedBy", this.CreatedBy);
            try
            {
                id = Convert.ToInt32(CommonDataLayer.ExecuteNonQuery("UserManagement_UserGroup_Insert", cmd));
                id = Convert.ToInt64(paraId.Value);
            }
            catch (Exception ex) { throw ex; }

            return id;
        }
        public long UpdateGroup()
        {

            int id;
            int OperationType = 2;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_UserGroup_Update";
            cmd.Parameters.AddWithValue("@Id", this.Id);
            cmd.Parameters.AddWithValue("@LoginName", this.LoginName);
            cmd.Parameters.AddWithValue("@Name", this.Name);
            cmd.Parameters.AddWithValue("@ProjectCode", this.ProjectCode);
            cmd.Parameters.AddWithValue("@LastUpdatedBy", this.LastUpdatedBy);
            cmd.Parameters.AddWithValue("@OperationType", OperationType);
            try
            {
                id = Convert.ToInt32(CommonDataLayer.ExecuteNonQuery("UserManagement_UserGroup_Update", cmd));
            }
            catch (Exception ex) { throw ex; }
            return id;
        }

        public long Update()
        {

            int id;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_User_Update";
            string enPassword = SSTCryptographer.Encrypt(this.Password, "");

            cmd.Parameters.AddWithValue("@Id", this.Id);
            cmd.Parameters.AddWithValue("@LoginName", this.LoginName);
            cmd.Parameters.AddWithValue("@Name", this.Name);
            cmd.Parameters.AddWithValue("@UserGroup_Id", this.UserGroup_Id);
            cmd.Parameters.AddWithValue("@Password", enPassword);
            cmd.Parameters.AddWithValue("@ProjectCode", this.ProjectCode);
            cmd.Parameters.AddWithValue("@LastUpdatedBy", this.LastUpdatedBy);
            try
            {
                id = Convert.ToInt32(CommonDataLayer.ExecuteNonQuery("UserManagement_User_Update", cmd));
            }
            catch (Exception ex) { throw ex; }
            return id;
        }
        
            public void DeleteGroup(int Id)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_User_Delete";
            cmd.Parameters.AddWithValue("@Id", Id);
            try
            {
                CommonDataLayer.ExecuteNonQuery("UserManagement_User_Delete", cmd);
            }
            catch (Exception ex) { throw ex; }

        }
        public void Delete()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_User_Delete";
            cmd.Parameters.AddWithValue("@Id", this.Id);
            try
            {
                CommonDataLayer.ExecuteNonQuery("UserManagement_User_Delete", cmd);
            }
            catch (Exception ex) { throw ex; }

        }

        public static DataTable GetList(string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectCode",ProjectCode);
            cmd.CommandText = "UserManagement_User_GetList";
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_User_GetList", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;

        }
        
        public void GetRecordById()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_User_GetRecordById";
            cmd.Parameters.AddWithValue("@Id", this.Id);
            try
            {
                dt = CommonDataLayer.GetDataTable("UserManagement_User_GetRecordById", cmd);
            }
            catch (Exception ex) { throw ex; }

            this.Id = Convert.ToInt64(dt.Rows[0]["Id"]);
            this.LoginName = Convert.ToString(dt.Rows[0]["LoginName"]);
            this.Name = Convert.ToString(dt.Rows[0]["Name"]);
            this.UserGroup_Id = Convert.ToString(dt.Rows[0]["UserGroup_Id"]);
            this.Mobile = Convert.ToString(dt.Rows[0]["Mobile"]);
            this.Email = Convert.ToString(dt.Rows[0]["Email"]);
            this.Password = Convert.ToString(dt.Rows[0]["Password"]);
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
    }
}