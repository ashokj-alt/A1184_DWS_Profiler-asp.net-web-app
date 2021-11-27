using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DWS_Profiler.Pages
{
    public partial class SearchImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //ImageSearch();
            Image();
        }

        public void ImageSearch()
        {
            string imgName = "101236548512378.jpg";
            Response.ContentType = "image/jpeg"; // for JPEG file
            string physicalFileName = @"D:\Ashok\Projects\2021_Project\DWS_Profiler\camera\CameraPreviewDemo\PreviewDemo\bin\" + imgName; 
            Response.WriteFile(physicalFileName);
        }
        public void Image()
        {
            String FileName;
            FileInfo MyFileInfo;
            long StartPos = 0, FileSize;

            string imgName = "101236548512378.jpg";
            Response.ContentType = "image/jpeg"; // for JPEG file
            string physicalFileName = @"D:\Ashok\Projects\2021_Project\DWS_Profiler\camera\CameraPreviewDemo\PreviewDemo\bin\" + imgName;

            MyFileInfo = new FileInfo(imgName);
            FileSize = MyFileInfo.Length;

            Response.Write("Please Login: <br>");
            Response.WriteFile(physicalFileName, StartPos, FileSize);
        }

    }
}