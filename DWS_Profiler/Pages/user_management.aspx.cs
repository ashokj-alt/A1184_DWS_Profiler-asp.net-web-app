using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DWS_Profiler.Pages
{
    public partial class user_management : System.Web.UI.Page
    {
        public string listData;
        public string listData1;
        public string UGlistData;
        public string UserAccessRightlistData_UG;

        protected void Page_Load(object sender, EventArgs e)
        {
            listData = GetList();

            UGlistData = GetUserGroupList();
            listData1 = GetUserGroupList1();
            UserAccessRightlistData_UG = GetAccessRightList_UserGroup2();
        }

        [WebMethod]
        public static string GetList()
        {
            try
            {
                string ProjectCode = System.Configuration.ConfigurationManager.AppSettings["ProjectCode"].ToString();//"A1107"; //System.Web.HttpContext.Current.Session["ProjectCode"].ToString()
                DataTable dtList = BusinessLayer.UserManagement.User.GetList(ProjectCode);

                string json = Newtonsoft.Json.JsonConvert.SerializeObject(dtList);
                return json;
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
        }

        //[WebMethod]
        //public string DeleteGroup(int Id)
        //{
        //    try
        //    {
                
        //        User.DeleteGroup(Id);
        //        return "0";
        //    }
        //    catch (Exception ex)
        //    {
        //        //throw ex;
        //        return "Error:" + ex.Message;
        //    }


        //}

        [WebMethod]
        public static string DeleteUserGroup(object JSONData)
        {
            try
            {
                BusinessLayer.UserManagement.User user = (BusinessLayer.UserManagement.User)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONData.ToString(), typeof(BusinessLayer.UserManagement.User));
                if (user.Id == 0)
                {
                    //long id = user.Insert();
                    return "0";
                    // Int64 ugi = Convert.ToInt64(user.UserGroup_Id);
                    // return ugi.ToString();
                }
                else
                {
                    user.Delete();
                    return user.Id.ToString();
                }
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }


        }
        [WebMethod]
        public static string GetUserGroupList()
        {
            string json = "";
            try
            {
                string ProjectCode = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
                DataTable dtList = new DataTable();
                dtList = BusinessLayer.UserManagement.UserGroup.GetList(ProjectCode);

                json = Newtonsoft.Json.JsonConvert.SerializeObject(dtList);
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
            return json;
        }

        [WebMethod]
        public static string GetUserList(int GroupId)
        {
            string json = "";
            try
            {

                DataTable dtList = new DataTable();
                dtList = BusinessLayer.UserManagement.UserGroup.GetUserList(GroupId);
                json = Newtonsoft.Json.JsonConvert.SerializeObject(dtList);
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
            return json;
        }

        [WebMethod]
        public static string SaveGroupName(object JSONData)
        {
            try
            {
                BusinessLayer.UserManagement.User userGroup = (BusinessLayer.UserManagement.User)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONData.ToString(), typeof(BusinessLayer.UserManagement.User));
                if (userGroup.Id == 0)
                {
                    long id = userGroup.InsertGroup();
                    return id.ToString();

                }
                else
                {
                    userGroup.UpdateGroup();
                    return userGroup.Id.ToString();
                }
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
        }

        [WebMethod]
        public static string Save(object JSONData)
        {
            try
            {
                BusinessLayer.UserManagement.User user = (BusinessLayer.UserManagement.User)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONData.ToString(), typeof(BusinessLayer.UserManagement.User));
                if (user.Id == 0)
                {
                    long id = user.Insert();
                    return id.ToString();

                }
                else
                {
                    user.Update();
                    return user.Id.ToString();
                }
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
        }
        [WebMethod]
        public static string GetAccessRightList_UserGroup2()
        {
            try
            {
                string ProjectCode = System.Configuration.ConfigurationManager.AppSettings["ProjectCode"].ToString();
                DataTable dtAccessRights = new DataTable();
                dtAccessRights = BusinessLayer.UserManagement.AccessRights.AccessRights.GetUserGroupList(ProjectCode);

                return Newtonsoft.Json.JsonConvert.SerializeObject(dtAccessRights);

            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }

        }
        [WebMethod]
        public static string GetUserGroupList1()
        {
            try
            {
                string ProjectCode = System.Configuration.ConfigurationManager.AppSettings["ProjectCode"].ToString();
                DataTable dt = BusinessLayer.UserManagement.UserGroup.GetList(ProjectCode);
                // DataTable dtVehicle = armstrong.BusinessLayer.Master.
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                return json;
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }


        }

        [WebMethod]
        public static string FetchSingleMenu(string MenuId)
        {
            string strVehicleList = "";
            try
            {
                DataTable dtAccessRights = new DataTable();
                dtAccessRights = BusinessLayer.UserManagement.AccessRights.AccessRights.FetchList(MenuId);


                dtAccessRights.Columns.Add("CheckCanAdd", typeof(bool));
                dtAccessRights.Columns.Add("CheckCanView", typeof(bool));
                dtAccessRights.Columns.Add("CheckCanEdit", typeof(bool));
                dtAccessRights.Columns.Add("CheckCanDelete", typeof(bool));
                foreach (DataRow dr in dtAccessRights.Rows)
                {
                    if (dr["CanAdd"].ToString() != "")
                    {
                        if (Convert.ToInt16(dr["CanAdd"]) == 1)
                            dr["CheckCanAdd"] = true;
                        else
                            dr["CheckCanAdd"] = false;
                    }

                    if (dr["CanView"].ToString() != "")
                    {
                        if (Convert.ToInt16(dr["CanView"]) == 1)
                            dr["CheckCanView"] = true;
                        else
                            dr["CheckCanView"] = false;
                    }

                    if (dr["CanEdit"].ToString() != "")
                    {
                        if (Convert.ToInt16(dr["CanEdit"]) == 1)
                            dr["CheckCanEdit"] = true;
                        else
                            dr["CheckCanEdit"] = false;
                    }

                    if (dr["CanDelete"].ToString() != "")
                    {
                        if (Convert.ToInt16(dr["CanDelete"]) == 1)
                            dr["CheckCanDelete"] = true;
                        else
                            dr["CheckCanDelete"] = false;
                    }

                }

                foreach (DataRow dr in dtAccessRights.Rows)
                {
                    strVehicleList += " <option value = '" + dr["GroupName"].ToString().Trim() + "' data-ca='" + dr["CheckCanAdd"].ToString().Trim() + "' data-ce='" + dr["CheckCanEdit"].ToString().Trim() + "' data-cv='" + dr["CheckCanView"].ToString().Trim() + "' data-cd='" + dr["CheckCanDelete"].ToString().Trim() + "' data-ugi='" + dr["Id"].ToString().Trim() + "'/>";
                }

                return Newtonsoft.Json.JsonConvert.SerializeObject(dtAccessRights);
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }

        }

        [WebMethod]
        public static string FetchMenuForSingleUser(string Userid)
        {
            string strVehicleList = "";
            try
            {
                DataTable dtAccessRights = new DataTable();
                dtAccessRights = BusinessLayer.UserManagement.AccessRights.AccessRights.FetchSingleUserList(Userid);


                dtAccessRights.Columns.Add("CheckCanAdd", typeof(bool));
                dtAccessRights.Columns.Add("CheckCanView", typeof(bool));
                dtAccessRights.Columns.Add("CheckCanEdit", typeof(bool));
                dtAccessRights.Columns.Add("CheckCanDelete", typeof(bool));
                foreach (DataRow dr in dtAccessRights.Rows)
                {
                    if (dr["CanAdd"].ToString() != "")
                    {
                        if (Convert.ToInt16(dr["CanAdd"]) == 1)
                            dr["CheckCanAdd"] = true;
                        else
                            dr["CheckCanAdd"] = false;
                    }

                    if (dr["CanView"].ToString() != "")
                    {
                        if (Convert.ToInt16(dr["CanView"]) == 1)
                            dr["CheckCanView"] = true;
                        else
                            dr["CheckCanView"] = false;
                    }

                    if (dr["CanEdit"].ToString() != "")
                    {
                        if (Convert.ToInt16(dr["CanEdit"]) == 1)
                            dr["CheckCanEdit"] = true;
                        else
                            dr["CheckCanEdit"] = false;
                    }

                    if (dr["CanDelete"].ToString() != "")
                    {
                        if (Convert.ToInt16(dr["CanDelete"]) == 1)
                            dr["CheckCanDelete"] = true;
                        else
                            dr["CheckCanDelete"] = false;
                    }

                }

                foreach (DataRow dr in dtAccessRights.Rows)
                {
                    strVehicleList += " <option value = '" + dr["Name"].ToString().Trim() + "' data-ca='" + dr["CheckCanAdd"].ToString().Trim() + "' data-ce='" + dr["CheckCanEdit"].ToString().Trim() + "' data-cv='" + dr["CheckCanView"].ToString().Trim() + "' data-cd='" + dr["CheckCanDelete"].ToString().Trim() + "' data-ugi='" + dr["Id"].ToString().Trim() + "'/>";
                }

                return Newtonsoft.Json.JsonConvert.SerializeObject(dtAccessRights);
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }

        }

        [WebMethod]
        public static string FetchMenu()
        {
            try
            {

                DataTable dt = BusinessLayer.UserManagement.UserGroup.GetMenuList();
                // DataTable dtVehicle = armstrong.BusinessLayer.Master.
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                return json;
            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }


        }


        [WebMethod]
        public static string SaveData(string AccessRights, string MenuId, int UserId)
        {
            string s1 = "";

            try
            {

                string s2 = AccessRights;
                string i1 = MenuId;
                BusinessLayer.UserManagement.AccessRights.AccessRights obj = new BusinessLayer.UserManagement.AccessRights.AccessRights();

                if (AccessRights.Length > 1)
                {
                    BusinessLayer.UserManagement.User.InsertAccesRightLog(UserId);
                    var s = AccessRights.Split(new char[] { '|' });

                    for (int i = 0; i < s.Length; i++)
                    {
                        string split2 = s[i].ToString();
                        string[] parameters2 = split2.Split(new char[] { ',' });
                        for (int j = 0; j < 1; j++)
                        {
                            string v1 = parameters2[0].ToString();
                            string v2 = parameters2[1].ToString();
                            if (v2 == "true")
                                v2 = "1";
                            else if (v2 == "false")
                                v2 = "0";
                            string v3 = parameters2[2].ToString();
                            if (v3 == "true")
                                v3 = "1";
                            else if (v3 == "false")
                                v3 = "0";
                            string v4 = parameters2[3].ToString();
                            if (v4 == "true")
                                v4 = "1";
                            else if (v4 == "false")
                                v4 = "0";
                            string v5 = parameters2[4].ToString();
                            if (v5 == "true")
                                v5 = "1";
                            else if (v5 == "false")
                                v5 = "0";
                            if (UserId != 0)

                                obj.UserGroup_Id = Convert.ToInt32(0);
                            else
                                obj.UserGroup_Id = Convert.ToInt32(i1);
                            obj.MenuId = Convert.ToInt32(v1);
                            obj.CanAdd = Convert.ToInt32(v2);
                            obj.CanEdit = Convert.ToInt32(v3);
                            obj.CanView = Convert.ToInt32(v4);
                            obj.CanDelete = Convert.ToInt32(v5);
                            obj.User_id = Convert.ToInt32(UserId);
                            long k = obj.Insert();
                            s1 = k.ToString();


                        }
                    }

                }

            }
            catch (Exception ex)
            {
                //throw ex;
                return "Error:" + ex.Message;
            }
            return s1;
        }
    }
}