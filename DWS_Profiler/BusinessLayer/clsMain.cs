using DWS_Profiler.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DWS_Profiler.BusinessLayer
{
    public class clsMain
    {

        public string Barcode { get; set; }

        public decimal Weight { get; set; }

        public Int32 Length { get; set; }

        public Int32 Width { get; set; }

        public Int32 Height { get; set; }

        public Int64 Volume { get; set; }

        public string Time { get; set; }

        public string MBoxCount { get; set; }
        public int ID { get; set; }

        public Int64 CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public Int64 LastUpdatedBy { get; set; }

        public DateTime? LastUpdatedOn { get; set; }

        public clsMain()
        {
            //this.ProjectCode = System.Web.HttpContext.Current.Session["ProjectCode"].ToString();
            this.CreatedBy = Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]);
            this.LastUpdatedBy = Convert.ToInt64(System.Web.HttpContext.Current.Session["UserId"]);
        }
        public static DataSet DataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_ProductionReport";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                //cmd.Parameters.AddWithValue("@SKU", SKU);
                //cmd.Parameters.AddWithValue("@ReportType", ReportType);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_ProductionReport", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet PakegeTypeDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_ProductionReport_PakegeType_SP";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                //cmd.Parameters.AddWithValue("@SKU", SKU);
                //cmd.Parameters.AddWithValue("@ReportType", ReportType);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_ProductionReport_PakegeType_SP", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet LengthWiseDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_Lenght_In_Diffrent_Ranges";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                //cmd.Parameters.AddWithValue("@SKU", SKU);
                //cmd.Parameters.AddWithValue("@ReportType", ReportType);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Lenght_In_Diffrent_Ranges", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet WeightWiseDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_Weight_In_Diffrent_Ranges";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                //cmd.Parameters.AddWithValue("@SKU", SKU);
                //cmd.Parameters.AddWithValue("@ReportType", ReportType);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Weight_In_Diffrent_Ranges", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet WidthWiseDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_Width_In_Diffrent_Ranges";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                //cmd.Parameters.AddWithValue("@SKU", SKU);
                //cmd.Parameters.AddWithValue("@ReportType", ReportType);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Width_In_Diffrent_Ranges", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet HeightWiseDataSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_Height_In_Diffrent_Ranges";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                //cmd.Parameters.AddWithValue("@SKU", SKU);
                //cmd.Parameters.AddWithValue("@ReportType", ReportType);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Height_In_Diffrent_Ranges", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet SearchLBHBar(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_LBH_Diffrent_Ranges";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);

                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_LBH_Diffrent_Ranges", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static DataSet SearchPerHourShipment(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_PerHour_Data";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);

                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_PerHour_Data", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataSet getSKUList(string Cell_No)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getSKUList";
            try
            {
                cmd.Parameters.AddWithValue("@Cell_No", Cell_No);
                ds = CommonDataLayer.GetDataSet("getSKUList", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static DataTable BoxCount()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "Master_CalibrationSettings_GetList";
            try
            {
                dt = CommonDataLayer.GetDataTable("Master_CalibrationSettings_GetList", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }


        internal static void DeleteCalibratioBox(string barcode)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_CalibrationBoxSetting_Delete_Barcode";
            cmd.Parameters.AddWithValue("@Barcode", barcode);
            try
            {
                DataAccessLayer.materiaMaster.ExecuteNonQuery("Master_CalibrationBoxSetting_Delete_Barcode", cmd);
            }
            catch (Exception ex) { throw ex; }
        }
        
            public static DataSet Export_Alarms()
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_Faultdetails_Export";
            try
            {
                ds = CommonDataLayer.GetDataSet("Master_Faultdetails_Export", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet Export(string Type, string Week, string Month, string StartDate, string EndDate, string Cell, string SKU, string ReportType)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_ProductionReport_Export";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                cmd.Parameters.AddWithValue("@Cell", Cell);
                cmd.Parameters.AddWithValue("@SKU", SKU);
                cmd.Parameters.AddWithValue("@ReportType", ReportType);
                ds = CommonDataLayer.GetDataSet("SP_ProductionReport_Export", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public static DataSet GetCalibrationCount()
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_Box_Data_Get_Master_Count";
            try
            {
                ds = CommonDataLayer.GetDataSet("Master_Box_Data_Get_Master_Count", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet GetDocList()
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Documents_GetDocList";
            try
            {
                ds = CommonDataLayer.GetDataSet("Documents_GetDocList", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public static DataSet GetQuestionList()
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "tblquestion_GetQuestionList";
            cmd.Parameters.AddWithValue("@Type", "select");
            cmd.Parameters.AddWithValue("@Question", "Question");
            try
            {
                ds = CommonDataLayer.GetDataSet("tblquestion_GetQuestionList", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet GetQuestion(string Question)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "tblquestion_GetQuestionList";
            cmd.Parameters.AddWithValue("@Type", "Search");
            cmd.Parameters.AddWithValue("@Question", Question);
            try
            {
                ds = CommonDataLayer.GetDataSet("tblquestion_GetQuestionList", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataSet Save(string Question)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "tblquestion_GetQuestionList";
            cmd.Parameters.AddWithValue("@Type", "insert");
            cmd.Parameters.AddWithValue("@Question", Question);
            try
            {
                ds = CommonDataLayer.GetDataSet("tblquestion_GetQuestionList", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataSet ProductivityDataSearch(string Type, string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_dashboard_Data_List";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_dashboard_Data_List", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet DataSearchReport(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_Report_Data_List";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Report_Data_List", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public static DataSet CalibrationDataSearch(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PageIndex", SqlDbType.Int).Value = pageIndex;
            cmd.Parameters.Add("@pageSize", SqlDbType.Int).Value = pageSize;
            cmd.CommandText = "DWS_Data_Log_Search_CalibrationDataSearch";

            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@Week", Week);
            cmd.Parameters.AddWithValue("@Month", Month);
            cmd.Parameters.AddWithValue("@StartDate", StartDate);
            cmd.Parameters.AddWithValue("@EndDate", EndDate);
            try
            {
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Search_CalibrationDataSearch", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        public static DataSet DWSSuccessDataSearch(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PageIndex", SqlDbType.Int).Value = pageIndex;
            cmd.Parameters.Add("@pageSize", SqlDbType.Int).Value = pageSize;
            cmd.CommandText = "DWS_Data_Log_Success_Shipment_Report_Data_List";

            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@Week", Week);
            cmd.Parameters.AddWithValue("@Month", Month);
            cmd.Parameters.AddWithValue("@StartDate", StartDate);
            cmd.Parameters.AddWithValue("@EndDate", EndDate);
            try
            {
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Success_Shipment_Report_Data_List", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public static DataSet DWSFailedDataSearch(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PageIndex", SqlDbType.Int).Value = pageIndex;
            cmd.Parameters.Add("@pageSize", SqlDbType.Int).Value = pageSize;
            cmd.CommandText = "DWS_Data_Log_Failed_Shipment_Report_Data_List";

            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@Week", Week);
            cmd.Parameters.AddWithValue("@Month", Month);
            cmd.Parameters.AddWithValue("@StartDate", StartDate);
            cmd.Parameters.AddWithValue("@EndDate", EndDate);
            try
            {
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Failed_Shipment_Report_Data_List", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        public static DataSet DWSDataSearchReport(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PageIndex", SqlDbType.Int).Value = pageIndex;
            cmd.Parameters.Add("@pageSize", SqlDbType.Int).Value = pageSize;
            cmd.CommandText = "DWS_Data_Log_Report_Data_List";

            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@Week", Week);
            cmd.Parameters.AddWithValue("@Month", Month);
            cmd.Parameters.AddWithValue("@StartDate", StartDate);
            cmd.Parameters.AddWithValue("@EndDate", EndDate);
            try
            {
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Report_Data_List", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        
        public static DataSet SuccessExport(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_Report_Success_Data_Export";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Report_Success_Data_Export", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet FaliedArrayExport(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_Report_Failed_Data_Export";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Report_Failed_Data_Export", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet DataLogExport(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_Report_Data_Export";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Report_Data_Export", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet DashboardExport()
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_Dashboard_Data_Export";
            try
            {

                //cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_Dashboard_Data_Export", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static DataSet ReasonwiseDataSearch(string Type, string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DWS_Data_Log_ReasonwiseReport";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("DWS_Data_Log_ReasonwiseReport", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet Countdata()
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Log_Reasonwise_IdleTime_reason";
            try
            {
                ds = CommonDataLayer.GetDataSet("Log_Reasonwise_IdleTime_reason", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return dt;
        }

        public static DataSet ReasonwiseFaultSearch(string Type, string Week, string Month, string StartDate, string EndDate)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Log_SystemFault_FaultReport";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("Log_SystemFault_FaultReport", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet ReasonwiseFaultSearchList(string Type, string Week, string Month, string StartDate, string EndDate, int pageIndex, int pageSize)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PageIndex", SqlDbType.Int).Value = pageIndex;
            cmd.Parameters.Add("@pageSize", SqlDbType.Int).Value = pageSize;
            cmd.CommandText = "Log_SystemFault_FaultReport_List";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("Log_SystemFault_FaultReport_List", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet ReasonwiseFaultSearchData(int pageIndex, int pageSize)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PageIndex", SqlDbType.Int).Value = pageIndex;
            cmd.Parameters.Add("@pageSize", SqlDbType.Int).Value = pageSize;
            cmd.CommandText = "Log_SystemFault_FaultReport_Data";
            try
            {
                //cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("Log_SystemFault_FaultReport_Data", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        public static DataSet ExportReasonwiseData(string Type, string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Log_Reasonwise_IdleTime_ReasonwiseReportExport";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("Log_Reasonwise_IdleTime_ReasonwiseReportExport", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet ExportReasonwiseAndFaultData(string Type, string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Log_Reasonwise_IdleTime_And_Fault_Export";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("Log_Reasonwise_IdleTime_And_Fault_Export", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet ProductivityExport(string Type, string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_ProductivityReportExport";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("SP_ProductivityReportExport", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void CheckSession()
        {
            AMBPL.Common.ErrorLog log = new AMBPL.Common.ErrorLog();

            string sessionId = string.Empty;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UserManagement_User_SessionId_Get";
            string sessionError = "";
            try
            {
                cmd.Parameters.AddWithValue("@UserId", System.Web.HttpContext.Current.Session["UserId"].ToString());
                cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
                sessionId = CommonDataLayer.ExecuteScalar(cmd);
            }
            catch (Exception ex)
            {
                if (Convert.ToString(System.Web.HttpContext.Current.Session["isLogin"]) == "0")
                {
                    sessionError = "3";//not login yet.. new session

                }
                else
                {

                    log.WriteErrorLog("session expire error >> " + ex.ToString());
                    sessionError = "1";//session expire
                }
            }
            try
            {

                if (sessionError != "1" && sessionError != "3")
                {
                    if (sessionId != System.Web.HttpContext.Current.Session.SessionID)
                    {
                        sessionError = "2";
                        log.WriteErrorLog("session error:Duble session for User" + System.Web.HttpContext.Current.Session["UserId"].ToString());
                    }

                }
                if (sessionError != "")
                {
                    System.Web.HttpContext.Current.Session.Add("SessionError", sessionError);
                    System.Web.HttpContext.Current.Response.Redirect("/SessionError.aspx");
                }
            }
            catch (Exception ex) { throw ex; }
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

        //For Heartbeat service
        public static DataSet HeartBeat_Annunciation()
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "Master_FaultDetails_HeartBeat_GetData";
            try
            {
                ds = CommonDataLayer.GetDataSet("Master_FaultDetails_HeartBeat_GetData", cmd);
                //  string json = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return dt;

        }

        public long InsertCalibrationBox()
        {

            long ID;
            //string enPassword; /*= armstrong.BusinessLayer.SSTCryptographer.Encrypt(Password, "")*/;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_CalibrationBoxSetting_Insert";
            SqlParameter paraId = new SqlParameter("@ID", SqlDbType.BigInt);
            paraId.Direction = ParameterDirection.InputOutput;
            cmd.Parameters.Add(paraId);

            cmd.Parameters.AddWithValue("@Barcode", this.Barcode);
            cmd.Parameters.AddWithValue("@Weight", this.Weight);
            cmd.Parameters.AddWithValue("@Length", this.Length);
            cmd.Parameters.AddWithValue("@Width", this.Width);
            cmd.Parameters.AddWithValue("@Height", this.Height);
            cmd.Parameters.AddWithValue("@CreatedBy", this.CreatedBy);

            try
            {
                ID = Convert.ToInt64(CommonDataLayer.ExecuteNonQuery("Master_CalibrationBoxSetting_Insert", cmd));
                ID = Convert.ToInt64(paraId.Value);
            }
            catch (Exception ex) { throw ex; }

            return ID;
        }

        public long UpdateCalibrationBox()
        {
            int ID;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_CalibrationBoxSetting_Update";
            cmd.Parameters.AddWithValue("@Barcode", this.Barcode);
            cmd.Parameters.AddWithValue("@Weight", this.Weight);
            cmd.Parameters.AddWithValue("@Length", this.Length);
            cmd.Parameters.AddWithValue("@Width", this.Width);
            cmd.Parameters.AddWithValue("@Height", this.Height);
            try
            {
                ID = Convert.ToInt32(DataAccessLayer.CommonDataLayer.ExecuteNonQuery("Master_CalibrationBoxSetting_Update", cmd));
            }
            catch (Exception ex) { throw ex; }
            return ID;
        }

        public long UpdateTime()
        {
            int ID;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_CalibrationSetting_Time_Update";
            cmd.Parameters.AddWithValue("@Time", this.Time);
            try
            {
                ID = Convert.ToInt32(DataAccessLayer.CommonDataLayer.ExecuteNonQuery("Master_CalibrationSetting_Time_Update", cmd));
            }
            catch (Exception ex) { throw ex; }
            return ID;
        }

        public long UpdateBoxCount()
        {
            int ID;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_CalibrationSetting_MasterCount_Update";
            cmd.Parameters.AddWithValue("@MasterCount", this.MBoxCount);
            try
            {
                ID = Convert.ToInt32(DataAccessLayer.CommonDataLayer.ExecuteNonQuery("Master_CalibrationSetting_MasterCount_Update", cmd));
            }
            catch (Exception ex) { throw ex; }
            return ID;
        }

        public static DataSet FaultData()
        {

            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            // cmd.Parameters.AddWithValue("@cellNo", CellNo);
            //cmd.CommandText = "SortingLog_Annaunciation";
            cmd.CommandText = "[Master_FaultDetails_Faults]";
            try
            {
                ds = CommonDataLayer.GetDataSet("[Master_FaultDetails_Faults]", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return dt;
        }

        
        public static DataSet GetScanLocationList()
        {

            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[WMS_Data_HandShake_Center_Name_List]";
            try
            {
                ds = CommonDataLayer.GetDataSet("[WMS_Data_HandShake_Center_Name_List]", cmd);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return dt;
        }

        public static DataSet ExportFaultData(string Type, string Week, string Month, string StartDate, string EndDate, string Cell)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Log_SystemFault_Fault_Export";
            try
            {
                cmd.Parameters.AddWithValue("@Type", Type);
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Month", Month);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                cmd.Parameters.AddWithValue("@Cell", Cell);
                ds = CommonDataLayer.GetDataSet("Log_SystemFault_Fault_Export", cmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static DataTable open_Rectification_Action(int faults_ID)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@faults_ID", faults_ID);
            cmd.CommandText = "Master_FaultDetails_open_Rectification_Action";
            try
            {
                dt = CommonDataLayer.GetDataTable("Master_FaultDetails_open_Rectification_Action", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        public static DataTable GetFault()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.CommandText = "Master_FaultDetails_Fault_List";
            try
            {
                dt = CommonDataLayer.GetDataTable("Master_FaultDetails_Fault_List", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
    }
}