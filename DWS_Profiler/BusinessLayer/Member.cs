using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data.SqlClient;
using System.Data;
using DWS_Profiler.DataAccessLayer;

namespace armstrong.BusinessLayer
{
    public class Member
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string LoginUserName { get; set; }
        public string Password { get; set; }
        public int DeptId { get; set; }
        public int DesignationId { get; set; }
        public int ReportingToId { get; set; }
        public int IsActive { get; set; }
        public string FileName { get; set; }
        public int MenuId { get; set; }
        public int ResignType { get; set; }
        public DateTime ResignDate { get; set; }
        public string ResignRemarks { get; set; }
        public int CTC { get; set; }
        public int PAMonth { get; set; }
        public int PAYear { get; set; }
        public DateTime DOJ { get; set; }
        public string SortValue { get; set; }
        public int count { get; set; }

        public static DataTable FetchDeptAllUsers(string dept, string level)
        {
            SqlCommand cmdFetchDeptUser = new SqlCommand();
            cmdFetchDeptUser.Parameters.AddWithValue("@dept", dept);
            cmdFetchDeptUser.Parameters.AddWithValue("@level", level);
            return CommonDataLayer.GetDataTable("FetchDeptAllUsers", cmdFetchDeptUser);
        }

        public static DataTable FetchProjectEngg()
        {
            SqlCommand cmd = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchProjectEngg", cmd);
        }

        public static DataTable FetchInterviewer()
        {
            SqlCommand cmd = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchInterviewer", cmd);
        }
        public static DataTable FetchLeadershipNominees()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchLeadershipNominees", cmdFetch);
        }

        public static DataTable FetchBaseUsersL5(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId", user.UserId);
            return CommonDataLayer.GetDataTable("FetchBaseUsersL5", cmdFetch);
        }

        public static DataTable FetchBaseUsers(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId", user.UserId);
            return CommonDataLayer.GetDataTable("FetchBaseUsers",cmdFetch);
        }

        public static DataTable FetchManagers()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchManagers",cmdFetch);
        }

        public static DataTable FetchDirReporting(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId",user.UserId);
            cmdFetch.Parameters.AddWithValue("@DeptId", user.DeptId);
            return CommonDataLayer.GetDataTable("FetchDirReporting", cmdFetch);
        }

        public static int UpdateUserStatus(Member user)
        {
            SqlCommand cmdUpdate = new SqlCommand();
            cmdUpdate.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.ExecuteNonQuery("UpdateUserStatus",cmdUpdate);
        }

        public static DataTable FetchTempUsers(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserName",user.UserName);
            return CommonDataLayer.GetDataTable("FetchTempUsers",cmdFetch);
        }

        public static DataTable FetchNLUser()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchNLUser", cmdFetch);
        }

        public static DataTable FetchProjEditUsers()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchProjEditUsers", cmdFetch);
        }

        public static DataTable FetchRight(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("FetchRight",cmdFetch);
        }

        public static DataTable FetchAppUsersRev(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId",user.UserId);
            cmdFetch.Parameters.AddWithValue("@count",user.count);
            return CommonDataLayer.GetDataTable("FetchAppUsersRev", cmdFetch);
        }

        public static DataTable FetchInActUsersCP(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@SortValue",user.SortValue);
            return CommonDataLayer.GetDataTable("FetchInActUsersCP", cmdFetch);
        }

        public static DataTable FetchAllUsersExceptMe(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("FetchAllUsersExceptMe", cmdFetch);
        }

        public static DataTable FetchOrgData()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchOrgData",cmdFetch);
        }
        
         public static DataTable FetchDummy()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchDummy",cmdFetch);
        }
      
        public static int UpdatePAProfDetails(Member user)
        {
            SqlCommand cmdUpdate = new SqlCommand();
            cmdUpdate.Parameters.AddWithValue("@CTC",user.CTC);
            cmdUpdate.Parameters.AddWithValue("@DOJ", user.DOJ);
            cmdUpdate.Parameters.AddWithValue("@PAMonth", user.PAMonth);
            cmdUpdate.Parameters.AddWithValue("@PAYear", user.PAYear);
            cmdUpdate.Parameters.AddWithValue("@UserId", user.UserId);
            return CommonDataLayer.ExecuteNonQuery("UpdatePAProfDetails", cmdUpdate);
        }
        
        public static DataTable FetchAllTheUsers()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchAllTheUsers",cmdFetch);
        }

        public static DataTable FetchAllUsersCompany()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchAllUsersCompany", cmdFetch);
        }
        public static DataTable LoadProfileData(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("LoadProfileData",cmdFetch);
        }
        
        public static DataTable FetchUserInfo(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("UserManagement_User_FetchUserInfo", cmdFetch);
        }
        public static DataSet AlertNotification()
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            // cmd.Parameters.AddWithValue("@cellNo", CellNo);
            //cmd.CommandText = "SortingLog_Annaunciation";
            cmd.CommandText = "MasterFaultDetails_Alert_Count";
            try
            {
                ds = CommonDataLayer.GetDataSet("MasterFaultDetails_Alert_Count", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public static DataTable EditUserCP(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("EditUserCP",cmdFetch);
        }

        public static DataTable FetchInActUsers()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchInActUsers", cmdFetch);
        }

        public static DataTable FetchAllActiveUsers()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchAllActiveUsers", cmdFetch);
        }
        
        public static DataTable FetchAppUsers(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("FetchAppUsers",cmdFetch);
        }

        public static DataTable FetchAppUsers1(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId", user.UserId);
            return CommonDataLayer.GetDataTable("FetchAppUsers1", cmdFetch);
        }

        public static DataTable FetchRepToHODUsers(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId", user.UserId);
            return CommonDataLayer.GetDataTable("FetchRepToHODUsers", cmdFetch);
        }

        public static DataTable FetchRepToHODUsersAll(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId", user.UserId);
            return CommonDataLayer.GetDataTable("FetchRepToHODUsersAll", cmdFetch);
        }

        public static DataTable FetchRepHODUsers(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId", user.UserId);
            //cmdFetch.Parameters.AddWithValue("@DeptId",user.DeptId);
            return CommonDataLayer.GetDataTable("FetchRepHODUsers",cmdFetch);
        }
        public static DataTable FetchRepHODUsersRed(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            //cmdFetch.Parameters.AddWithValue("@UserId", user.UserId);
            cmdFetch.Parameters.AddWithValue("@DeptId",user.DeptId);
            return CommonDataLayer.GetDataTable("FetchRepHODUsersRed", cmdFetch);
        }
         
        public static DataTable FetchDeptNameFrmUserId(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId", user.UserId);
            return CommonDataLayer.GetDataTable("FetchDeptNameFrmUserId", cmdFetch);
        }
        public static DataTable FetchBreadCrumb(Member user)
        {
            SqlCommand cmdFetchBreadCrumb = new SqlCommand();
            cmdFetchBreadCrumb.Parameters.AddWithValue("@MenuId", user.MenuId);
            return CommonDataLayer.GetDataTable("FetchBreadCrumb", cmdFetchBreadCrumb);
        }

        public static DataTable FetchMenu(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@filename", user.FileName);
            return CommonDataLayer.GetDataTable("FetchMenu", cmdFetch);
        }
        public static DataTable  FetchTaskNo(Member user)
        {
            SqlCommand cmdFetchTaskNo = new SqlCommand();
          //  SqlParameter parmTaskNo = new SqlParameter("@TaskNo", SqlDbType.Int);
          //  parmTaskNo.Direction = ParameterDirection.Output;
         //   cmdFetchTaskNo.Parameters.Add(parmTaskNo);
            cmdFetchTaskNo.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("FetchTaskNo",cmdFetchTaskNo);
          //  return Convert.ToInt32(cmdFetchTaskNo.Parameters["@TaskNo"].Value);
        }

        public static DataTable FetchHODs()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchHODs",cmdFetch);
        }

        public static int UpdateResigDetails(Member user)
        {
            SqlCommand cmdUpdate = new SqlCommand();
            cmdUpdate.Parameters.AddWithValue("@UserId", user.UserId);
            cmdUpdate.Parameters.AddWithValue("@ResignType", user.ResignType);
            cmdUpdate.Parameters.AddWithValue("@ResignDate", user.ResignDate);
            cmdUpdate.Parameters.AddWithValue("@ResignRemarks", user.ResignRemarks);
            return CommonDataLayer.ExecuteNonQuery("UpdateResigDetails", cmdUpdate);
        }

        public static DataTable FetchRepToId(Member user)
        {
            SqlCommand cmdFetchRepToId = new SqlCommand();
            cmdFetchRepToId.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("FetchReportingToId",cmdFetchRepToId);
        }

        public static DataTable FetchTaskFor(Member user)
        {
            SqlCommand cmdFetchTaskFor = new SqlCommand();
            cmdFetchTaskFor.Parameters.AddWithValue("@UserId",user.UserId);
            cmdFetchTaskFor.Parameters.AddWithValue("@ReportingToId",user.ReportingToId);
            return CommonDataLayer.GetDataTable("FetchTaskFor",cmdFetchTaskFor);
        }

        public static DataTable FetchSubBase(Member user)
        {
            SqlCommand cmdFetchSub = new SqlCommand();
            cmdFetchSub.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("FetchSubBaseLevel", cmdFetchSub);
        }

        public static DataTable ValidateLogin(Member member)
        {
            SqlCommand cmdValLog = new SqlCommand();
            cmdValLog.Parameters.AddWithValue("@LoginUserName",member.LoginUserName);
           // cmdValLog.Parameters.AddWithValue("@Password", member.Password);
            return CommonDataLayer.GetDataTable("ValidateLogin",cmdValLog);
        }

        public static DataTable FetchHODId(Member user)
        {
            SqlCommand cmdFetchHODId = new SqlCommand();
            cmdFetchHODId.Parameters.AddWithValue("@DeptId",user.DeptId);
            return CommonDataLayer.GetDataTable("FetchHODId",cmdFetchHODId);
        }

        public static DataTable FetchCollSub(Member user)
        {
            SqlCommand cmdFetchCollSub = new SqlCommand();
            cmdFetchCollSub.Parameters.AddWithValue("@ReportingToId", user.ReportingToId);
            cmdFetchCollSub.Parameters.AddWithValue("@UserId", user.UserId);
            return CommonDataLayer.GetDataTable("FetchCollSub", cmdFetchCollSub);
        }

        public static DataTable FetchSuperior(Member user)
        {
            SqlCommand cmdFetchSup = new SqlCommand();
            cmdFetchSup.Parameters.AddWithValue("@ReportingToId",user.ReportingToId);
            return CommonDataLayer.GetDataTable("FetchSuperiors",cmdFetchSup);
        }

        public static DataTable FetchDelTasks(Member user)
        {
            SqlCommand cmdFetchDelTask = new SqlCommand();
            cmdFetchDelTask.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("FetchDelTasks",cmdFetchDelTask);
        }

        public static DataTable FetchTaskCreatedBy(Member user)
        {
            SqlCommand cmdTaskCreatedBy = new SqlCommand();
            cmdTaskCreatedBy.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("FetchTaskCreatedBy",cmdTaskCreatedBy);
        }

        public static DataTable FetchUserCP(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();
            cmdFetch.Parameters.AddWithValue("@UserId", user.UserId);
            return CommonDataLayer.GetDataTable("FetchUserCP",cmdFetch);
        }

        public static DataTable FetchAllUsers(Member user)
        {
            SqlCommand cmdFetchUsers = new SqlCommand();
            cmdFetchUsers.Parameters.AddWithValue("@UserId",user.UserId);
            return CommonDataLayer.GetDataTable("FetchAllUsers",cmdFetchUsers);
        }

        public static DataTable FetchUser(Member user)
        {
            SqlCommand cmdFetchUser = new SqlCommand();
            cmdFetchUser.Parameters.AddWithValue("@User_id",user.UserId);
            return CommonDataLayer.GetDataTable("FetchSingleUser",cmdFetchUser);
        }

        public static int UpdatePassword(Member user)
        {
            SqlCommand cmdUpdate = new SqlCommand();
            cmdUpdate.Parameters.AddWithValue("@UserId",user.UserId);
            cmdUpdate.Parameters.AddWithValue("@Password",user.Password);
            return CommonDataLayer.ExecuteNonQuery("UpdatePassword",cmdUpdate);
        }

        public static DataTable FetchDeptUser(Member user)
        {
            SqlCommand cmdFetchDeptUser = new SqlCommand();
            cmdFetchDeptUser.Parameters.AddWithValue("@DeptId",user.DeptId);
            return CommonDataLayer.GetDataTable("FetchDeptUser",cmdFetchDeptUser);
        }

        public static DataTable FetchUserDept(Member user)
        {
            SqlCommand cmdFetchUserDept = new SqlCommand();
            cmdFetchUserDept.Parameters.AddWithValue("@DeptId",user.DeptId);
            return CommonDataLayer.GetDataTable("FetchUserDept",cmdFetchUserDept);
        }

        public static DataTable FetchEngineersPM()
        {
            SqlCommand cmdFetch = new SqlCommand();
            return CommonDataLayer.GetDataTable("FetchEngineersPM", cmdFetch);
        }

        public static DataTable CheckSub(Member user)
        {
            SqlCommand cmdCheckSub = new SqlCommand();
            cmdCheckSub.Parameters.AddWithValue("@UserId",user.UserId);
            cmdCheckSub.Parameters.AddWithValue("@ReportingToId", user.ReportingToId);
            return CommonDataLayer.GetDataTable("CheckSub",cmdCheckSub);
        }

        public static string FetchUserId(Member user)
        {
            SqlCommand cmdFetch = new SqlCommand();

            SqlParameter parmId = new SqlParameter("@UserId", SqlDbType.Int);
            parmId.Direction = ParameterDirection.Output;
            cmdFetch.Parameters.Add(parmId);

            SqlParameter parmGroupId = new SqlParameter("@User_GroupId", SqlDbType.Int);
            parmGroupId.Direction = ParameterDirection.Output;
            cmdFetch.Parameters.Add(parmGroupId);

            cmdFetch.Parameters.AddWithValue("@UserName",user.UserName);
            CommonDataLayer.GetDataTable("FetchUserId",cmdFetch);
            int UserId = Convert.ToInt32(cmdFetch.Parameters["@UserId"].Value);
            int groupid=Convert.ToInt32(cmdFetch.Parameters["@User_GroupId"].Value);
            return UserId.ToString()+":"+groupid.ToString();
        }
    }
}
