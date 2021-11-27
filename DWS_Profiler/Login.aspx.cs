using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DWS_Profiler
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string Signin(string username, string password)
        {
            string ProjectCode = ConfigurationManager.AppSettings["ProjectCode"].ToString();
            DataTable dt = new DataTable();
            string json = "";
            dt = BusinessLayer.UserManagement.User.Login(username, password, ProjectCode);
            
            if (dt.Rows.Count > 0)
            {
                json = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                HttpContext.Current.Session.Add("UserId", Convert.ToInt32(dt.Rows[0]["Id"]));
                HttpContext.Current.Session.Add("ProjectCode", ProjectCode);
                BusinessLayer.UserManagement.User.InsertLoginDetails(username, password, ProjectCode);
                return "1"; 
            }
            else
            {
                json = "0";
            }

            return json;
        }
        
    }
}