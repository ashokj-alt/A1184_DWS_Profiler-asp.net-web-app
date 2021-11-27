using armstrong.BusinessLayer;
using System;
using System.Data;
using System.Threading;
using System.Web.Services;

namespace DWS_Profiler
{
    public partial class Base : System.Web.UI.MasterPage
    {
        public static string user_id = "";
        public string MenuAccessRightslistData;
        public int ShowEditTeam;
        public string DeviceData;
        public short canAdd = 0, canEdit = 0, canDelete = 0;
        public string bcParentMenu = string.Empty, bcCurrentMenu = string.Empty;
        public string PageName = "";
        public string UserNamecheck = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            SetAccessRights();
            FetchUserInfo();

            if (Session["UserId"] == null)
                Response.Redirect("/login.aspx");
            else if (Session["UserId"].ToString().Trim() == string.Empty || Session["UserId"].ToString().Trim() == "0")
                Response.Redirect("/login.aspx");
            user_id = Session["UserId"].ToString();
            MenuAccessRightslistData = GetMenuData();
        }


        [WebMethod]
        private void FetchUserInfo()
        {
            Member user = new Member();
            user.UserId = Convert.ToInt32(Session["UserId"]);
            DataTable dt = new DataTable();
            dt = Member.FetchUserInfo(user);
            if (dt.Rows.Count > 0)
            {
                UserName.InnerHtml = Convert.ToString(dt.Rows[0]["Name"]);
            }
        }

        [WebMethod]
        public static string GetMenuData()
        {
            DataTable dt = new DataTable();
            try
            {
                //string user_id = Session["UserId"].ToString();
                dt = BusinessLayer.UserManagement.AccessRights.Menu.FetchMenu_AccessRights();
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                return json;
            }
            catch (Exception ex)
            {
                return "Error:" + ex.Message;
            }

        }

        protected void SetAccessRights()
        {
            Member user = new Member();
            user.UserId = Convert.ToInt32(Session["UserId"]);
            DataTable dt1 = new DataTable();
            dt1 = Member.FetchUserInfo(user);
            if (dt1.Rows.Count > 0)
            {
                UserNamecheck = Convert.ToString(dt1.Rows[0]["Name"]);
            }
            if (Request.FilePath != "/Pages/user_management.aspx")
            {
                DataTable dt = BusinessLayer.UserManagement.AccessRights.AccessRights.GetPageUserAccessRights(Request.FilePath);
                if (Request.FilePath == "/Pages/Setting/MasterSetting.aspx" && UserNamecheck == "Ashokj@99")
                {
                    if (dt.Rows[0]["CanAdd"].ToString() == "1")
                        canAdd = 1;
                    if (dt.Rows[0]["CanEdit"].ToString() == "1")
                        canEdit = 1;
                    if (dt.Rows[0]["CanDelete"].ToString() == "1")
                        canDelete = 1;

                }
                else if(Request.FilePath != "/Pages/Setting/MasterSetting.aspx")
                {
                    if (dt.Columns.Count >= 0)// when access rights are set for page. If not skip
                    {
                        if (dt.Rows.Count == 0)//access of page is not set for current user and user group
                        {
                            Response.Redirect("/AccessDenied.aspx");

                        }
                        else if (dt.Rows[0]["CanView"].ToString() == "0")
                        {
                            Response.Redirect("/AccessDenied.aspx");

                        }
                        else
                        {
                            if (dt.Rows[0]["CanAdd"].ToString() == "1")
                                canAdd = 1;
                            if (dt.Rows[0]["CanEdit"].ToString() == "1")
                                canEdit = 1;
                            if (dt.Rows[0]["CanDelete"].ToString() == "1")
                                canDelete = 1;

                        }
                    }
                }
                else
                {
                     Response.Redirect("/AccessDenied.aspx");
                }
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            //  Session.Abandon();
            //  Session.Clear();
            //Response.Redirect("/Login.aspx");
        }
    }
}