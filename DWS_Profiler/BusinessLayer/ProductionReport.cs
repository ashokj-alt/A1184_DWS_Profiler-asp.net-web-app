using DWS_Profiler.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DWS_Profiler.BusinessLayer
{
    public class ProductionReport
    {
        public static DataTable GetLineQty()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SC_GetLineQuantity";
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());

            try
            {
                dt = CommonDataLayer.GetDataTable("SC_GetLineQuantity", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetShiftQty()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SC_GetShiftQuantity";
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());

            try
            {
                dt = CommonDataLayer.GetDataTable("SC_GetShiftQuantity", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetDestQty()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SC_GetDestQuantity";
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());

            try
            {
                dt = CommonDataLayer.GetDataTable("SC_GetDestQuantity", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }


        public static DataTable GetDestinationList()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SC_Master_RollDestination_Get";
            // cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());

            try
            {
                dt = CommonDataLayer.GetDataTable("SC_Master_RollDestination_Get", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetProductionReport_Daily(string Date, string Type, string Destination, string DataType)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_Production_Daily";

            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.Parameters.AddWithValue("@Date", Date);
            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@Destination", Destination);
            cmd.Parameters.AddWithValue("@DataType", DataType);
            try
            {
                dt = CommonDataLayer.GetDataTable("Report_Production_Daily", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetFaultReport_Daily(string Date, string Type)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SR_SystemFault_log_Report";
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.Parameters.AddWithValue("@Date", Date);
            cmd.Parameters.AddWithValue("@Type", Type);

            try
            {
                dt = CommonDataLayer.GetDataTable("SR_SystemFault_log_Report", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataSet GetDetailFaultReport_Daily(string Date,string LineZone, string Type,string FaultType)
        {
            DataSet dt = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_Fault_Daily ";
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.Parameters.AddWithValue("@Date", Date);
            cmd.Parameters.AddWithValue("@LineZone", LineZone);
            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@FaultType", FaultType);

            try
            {
                dt = CommonDataLayer.GetDataSet("Report_Fault_Daily ", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetProductionReport_Weekly(int week,int year, string Type, string Destination, string DataType)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_Production_Weekly";

            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.Parameters.AddWithValue("@Week", week);
            cmd.Parameters.AddWithValue("@Year", year);
            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@Destination", Destination);
            cmd.Parameters.AddWithValue("@DataType", DataType);
            try
            {
                dt = CommonDataLayer.GetDataTable("Report_Production_Weekly", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetProductionReport_DateRange(string fromDate, string endDate, string Type, string Destination, string DataType)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_Production_DateRange";

            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.Parameters.AddWithValue("@StartDate", fromDate);
            cmd.Parameters.AddWithValue("@EndDate", endDate);
            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@Destination", Destination);
            cmd.Parameters.AddWithValue("@DataType", DataType);
            cmd.Parameters.AddWithValue("@ShowDayName",0);
            cmd.Parameters.AddWithValue("@ShowDate", 0);

            try
            {
                dt = CommonDataLayer.GetDataTable("Report_Production_DateRange", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetReportYears()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_GetYears";

            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            
            try
            {
                dt = CommonDataLayer.GetDataTable("Report_GetYears", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetProductionReport_Monthly(string month, int year, string Type, string Destination, string DataType,string DataGroup)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_Production_Monthly";

            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.Parameters.AddWithValue("@Month", month);
            cmd.Parameters.AddWithValue("@Year", year);
            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@Destination", Destination);
            cmd.Parameters.AddWithValue("@DataType", DataType);
            cmd.Parameters.AddWithValue("@DataGroup", DataGroup);
            try
            {
                dt = CommonDataLayer.GetDataTable("Report_Production_Monthly", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable GetProductionReport_Yearly(int year, string Type, string Destination, string DataType, string DataGroup)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_Production_Yearly";
            cmd.Parameters.AddWithValue("@ProjectCode", System.Web.HttpContext.Current.Session["ProjectCode"].ToString());
            cmd.Parameters.AddWithValue("@Year", year);
            cmd.Parameters.AddWithValue("@Type", Type);
            cmd.Parameters.AddWithValue("@Destination", Destination);
            cmd.Parameters.AddWithValue("@DataType", DataType);
            cmd.Parameters.AddWithValue("@DataGroup", DataGroup);
            try
            {
                dt = CommonDataLayer.GetDataTable("Report_Production_Yearly", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataSet TotalReport(string Start_Date, string End_Date, string Filletr, string ReportName, int Line)
        {
            DataSet dt = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            cmd.Parameters.AddWithValue("@Line", Line);
            try

            {
                dt = CommonDataLayer.GetDataSet("Report", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable TotalProductionLogReport(string Start_Date, string End_Date, string Filletr, string ReportName, int Line)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_ProductionLog";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            cmd.Parameters.AddWithValue("@Line", Line);
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_ProductionLog", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable TotalSystemFaultLogReport(string Start_Date, string End_Date, string Filletr, string ReportName, string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_SystemFaultLogData";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_SystemFaultLogData", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }


        public static DataTable TotalConveyorStartStopLogReport(string Start_Date, string End_Date, string Filletr, string ReportName, string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_ConveyorStartStopLog";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_ConveyorStartStopLog", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable TotalDevicesStartStopLogReport(string Start_Date, string End_Date, string Filletr, string ReportName,string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_DevicesLog";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_DevicesLog", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable TotalBarcodeNoReadLogReport(string Start_Date, string End_Date, string Filletr, string ReportName,string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_ScannerLog";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_ScannerLog", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable TotalOperationModeLogReport(string Start_Date, string End_Date, string Filletr, string ReportName, string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_OperationModeLog";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_OperationModeLog", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataSet TotalProductiveIdleReport(string Start_Date, string End_Date, string Filletr, string ReportName)
        {
            DataSet dt = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_IdleVsProductive";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            try

            {
                dt = CommonDataLayer.GetDataSet("Report_IdleVsProductive", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataSet TotalProductiveIdleReport1(string Start_Date, string End_Date)
        {
            DataSet dt = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_IdleVsProductive1";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            //cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            //cmd.Parameters.AddWithValue("@ReportName", ReportName);
            try

            {
                dt = CommonDataLayer.GetDataSet("Report_IdleVsProductive1", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable TotalProductiveIdleReportNew(string Start_Date, string End_Date, string Filletr, string ReportName)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_ProductiveVsIdleTimeLog";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_ProductiveVsIdleTimeLog", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable TotalConveyorJamLogReport(string Start_Date, string End_Date, string Filletr, string ReportName, string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_ConveyorJamLog";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_ConveyorJamLog", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable TotalLineFullLogReport(string Start_Date, string End_Date, string Filletr, string ReportName, string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_LineFullLog";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            cmd.Parameters.AddWithValue("@ReportName", ReportName);
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);  
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_LineFullLog", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataTable TotalProductiveTimeReport(string Start_Date, string End_Date, string ProjectCode)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_ProductivevsIdealTime";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@ProjectCode", ProjectCode);
            //cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            //cmd.Parameters.AddWithValue("@ReportName", ReportName);
            try

            {
                dt = CommonDataLayer.GetDataTable("Report_ProductivevsIdealTime", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataSet TotalFaultReport(string Start_Date, string End_Date, int Line)
        {
            DataSet dt = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Report_FaultType";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@ProjectCode", Line);
            //cmd.Parameters.AddWithValue("@FillterQry", Filletr);
            //cmd.Parameters.AddWithValue("@ReportName", ReportName);
            try

            {
                dt = CommonDataLayer.GetDataSet("Report_FaultType", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataSet BindDockNoandShift()
        {
            DataSet ds = new DataSet();

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Master_DockandShift_get";

            try
            {
                ds = CommonDataLayer.GetDataSet("Master_DockandShift_get", cmd);
                return ds;
            }
            catch (Exception ex) { return ds = null; }
        }

        public static DataSet PerformanceReport(string Start_Date, string End_Date, string Type)
        {
            DataSet dt = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SlitRollData_PerformanceReport";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@Type", Type);

            try

            {
                dt = CommonDataLayer.GetDataSet("SlitRollData_PerformanceReport", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }

        public static DataSet EstimatedDataReport(string Start_Date, string End_Date, string Type)
        {
            DataSet dt = new DataSet();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SlitRollBatch_PerformanceReport";

            cmd.Parameters.AddWithValue("@StartDt", Start_Date);
            cmd.Parameters.AddWithValue("@EndDt", End_Date);
            cmd.Parameters.AddWithValue("@Type", Type);

            try

            {
                dt = CommonDataLayer.GetDataSet("SlitRollBatch_PerformanceReport", cmd);
            }
            catch (Exception ex) { throw ex; }
            return dt;
        }
        

    }
}