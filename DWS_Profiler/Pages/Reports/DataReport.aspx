<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataReport.aspx.cs" MasterPageFile="~/Base.Master" Inherits="DWS_Profiler.Pages.Reports.DataReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head runat="server">
        <title>Delhivery | Data Report</title>
        <script src="../../JS/ui-bootstrap-tpls-0.13.4.min.js"></script>
        <script src="../../JS/webapp/DataReport.js"></script>
        <link href="../../global/webapp/datareport.css" rel="stylesheet" />
        <style>
            .div-left {
                float: left;
                padding-left: 10px;
            }

            .div-right {
                float: right;
                padding-right: 10px;
            }

            .tabulator-cell {
                display: inline-block;
                position: relative;
                box-sizing: border-box;
                vertical-align: middle;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .divRed1 {
                color: red !important;
            }

            .divgreen {
                color: #00cc00 !important;
            }

            .table_data {
                margin-bottom: 20px;
                background-color: #fff;
            }


            .btn {
                padding: 0px 5px;
            }
            /* table tbody {
                display: block;
                max-height: 383px;
                overflow-y: scroll;
            }*/

            /*table thead, table tbody tr {
                    display: table;
                    width: 100%;
                    table-layout: fixed;
                }*/
        </style>

    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="report" ng-app="myApp" ng-controller="myController">
        <div class="top_row">
            <div class="col-md-12" style="background-color: #194a77; color: white; height: 37px; padding-left: 20px;">

                <h4 class="main_title"><i class="fas fa-list-ul" style="margin: 6px;"></i>DWS Statistics Report</h4>
            </div>
        </div>
        <div class="inner_content">
            <div class="container-fluid">
                <div class="row">
                    <div class="left_side">
                        <div class="row">
                            <div class="form-group" style="margin-right: 10px">
                                <label for="exampleFormControlSelect1">Select</label>
                                <select class="form-control" ng-model="seldatepicker" id="seldatepicker" name="DatePicker">
                                    <option value="" selected="">Select of</option>
                                    <option value="date">Date</option>
                                    <option value="week">Week</option>
                                    <option value="month">Month</option>
                                    <option value="dateRange">DateTime range</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <div class="form-group" id="date" style="margin-right: 10px;">
                                    <label for="exampleFormControlInput1">Date</label>
                                    <input type="Date" class="form-control" id="txtDate" placeholder="Select Date" value="" />
                                </div>
                                <div class="form-group" id="week" style="margin-right: 10px;">
                                    <label for="exampleFormControlInput1">Week</label>
                                    <input type="week" class="form-control" id="txtWeek" placeholder="Select Week" value="" />
                                </div>
                                <div class="form-group" id="month" style="margin-right: 10px;">
                                    <label for="exampleFormControlInput1">Month</label>
                                    <input type="month" class="form-control" id="txtMonth" placeholder="Select Month" value="" />
                                </div>
                                <div class="" id="dateRange" style="margin-top: 0px; margin-bottom: 0px; display: flex; margin-right: 10px;">
                                    <div style="margin-right: 10px;">
                                        <label for="exampleFormControlInput1">From Date</label>
                                        <input type="datetime-local" style="width: 247px;" class="form-control" id="txtStartDate" value="" />
                                    </div>
                                    <div>
                                        <label for="exampleFormControlInput1">To Date</label>
                                        <input type="datetime-local" style="width: 247px;" class="form-control" id="txtEndDate" value="" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="RobotCell" style="margin-right: 10px;">
                                <label for="exampleFormControlSelect1">DWS No.</label>
                                <select class="form-control" ng-model="selCell" id="selCell">
                                    <option value="" selected="">Select DWS</option>
                                    <option value="{{GetScanLocationList}}">{{GetScanLocationList}}</option>
                                </select>
                            </div>
                            <div class="text-right searcg_btn">
                                <button type="button" class="btn btn-primary" ng-click="Search()">
                                    Search
                                    <img src="/Images/search.svg"></button>
                            </div>

                            <div class="text-right exp_btn" style="margin-left: auto; margin-right: 0;">
                                <button type="button" id="1" class="btn btn-success" ng-click="Export()"  title="All data export">
                                    Export
                                    <img src="/Images/export_white.png"></button>
                                <button type="button" id="2" class="btn btn-success" ng-click="FaliedExport()" style="display: none;"  title="Failed data export">
                                    Export
                                    <img src="/Images/export_white.png"></button>
                                <button type="button" id="3" class="btn btn-success" ng-click="SuccessExport()" style="display: none;" title="Success data export">
                                    Export
                                    <img src="/Images/export_white.png"></button>
                                <button type="button" id="4" class="btn btn-success" ng-click="CalibrationExport()" style="display: none;" title="calibration data export">
                                    Export
                                    <img src="/Images/export_white.png"></button>
                                <button type="button" id="5" class="btn btn-success" ng-click="SearchExport()" style="display: none;" title="Search data export">
                                    Export
                                    <img src="/Images/export_white.png"></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <div style="display: flex;">

                        <button style="min-width: 100px;" class="btn btn-info" id="total" ng-click="Search()">All</button>
                        <button style="min-width: 100px;" class="btn btn-success" id="successCount" ng-click="SuccessSearch()">Success</button>
                        <button style="min-width: 100px;" class="btn btn-danger" id="failedCount" ng-click="FaultySearch()">Failed</button>
                        <button style="min-width: 140px;" class="btn btn-warning" id="CalibrationData" ng-click="CalibrationDataSearch()">Calibration Data</button>
                        <div style="display: flex; width: 100%; justify-content: flex-end;">
                            <input id="searchTextBox" ng-model="txtSearch1" type="text" style="display: block;" onkeypress='return event.charCode >= 48 && event.charCode <= 57' required class="inline clearable inlinesearch" placeholder="Search Barcode..">
                            <button id="searchbutton" class="inlinesearch btn btn-info" ng-click="SearchData()" style="min-width: 113px; margin-left: 10px; margin-right: 10px;">
                                Search<img src="../../Images/search_white.png" style="margin-bottom: 2px;" />
                            </button>
                        </div>
                    </div>
                    <div class="table_data table-responsive main_table" id="all">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Sr.No</th>
                                    <th style="cursor: pointer;" ng-click="SortList('Barcode')">AWB</th>
                                    <th>Length(cm)</th>
                                    <th>Width(cm)</th>
                                    <th>Height(cm)</th>
                                    <th>Weight(g)</th>
                                    <th>Volume(mm3)</th>
                                    <th>Real Volume(mm3)</th>
                                    <th>Package Type</th>
                                    <th>Data Sent</th>
                                    <th>Failed Reason</th>
                                    <th>TimeStamp</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="item in list | filter:txtSearch | orderBy:orderList:orderDirection">
                                    <td>{{$index+1}}</td>
                                    <td>{{item.Barcode}}</td>
                                    <td>{{item.Length}}</td>
                                    <td>{{item.Width}}</td>
                                    <td>{{item.Height}}</td>
                                    <td>{{item.Weight}}</td>
                                    <td>{{item.Volume}}</td>
                                    <td>{{item.RealVolume}}</td>
                                    <td>{{item.PackageType}}</td>
                                    <td ng-class="{'divRed1': item.IsSend == 'Failed','divgreen': item.IsSend == 'Success'}">{{item.IsSend}}</td>
                                    <td title="{{item.ReasonForFailed}}"><span class="tabulator-cell" style="width: 110px;">{{item.ReasonForFailed}}</span></td>
                                    <td>{{item.Datetime}}</td>
                                </tr>
                                <tr>
                                    <td colspan="12" class="text-center" style="background-color: #fff; border-bottom: 1px solid #fff;">
                                        <div ng-switch="(list | filter:txtSearch).length">
                                            <span class="ng-empty text-danger" ng-switch-when="0">No Record(s) Found</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot id="tfoot">
                                <tr>
                                    <td align="center" colspan="12">
                                        <div class="div-left" style="display: flex;">
                                            <span class="form-group pull-left page-size form-inline">
                                                <select id="ddlPageSize" class="form-control"
                                                    ng-model="pageSizeSelected"
                                                    ng-change="changePageSize()">
                                                    <option value="5">5</option>
                                                    <option value="10">10</option>
                                                    <option value="25">25</option>
                                                    <option value="50">50</option>
                                                    <option value="1000">1000</option>
                                                    <option value="10000">10000</option>
                                                    <option value="100000">100000</option>
                                                </select>
                                            </span>
                                            <p style="padding: 7px; color: #161616;">Total {{totalCount}} shipment processed {{Success}} shipment are successfully sent and {{Failed}} shipment are failed.</p>

                                        </div>
                                        <div class="pull-right pagination div-right" style="display: flex;">
                                            <pagination total-items="totalCount" ng-change="pageChanged()" items-per-page="pageSizeSelected" direction-links="true" ng-model="pageIndex" max-size="maxSize" class="pagination" boundary-links="true" rotate="false" num-pages="numPages"></pagination>
                                            <a class="btn btn-primary" style="color: #161616;">Page: {{pageIndex}} / {{numPages}}</a>
                                        </div>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>

                    </div>
                </div>
                <div class="out_wrap" id="NoDataDiv" ng-show="NoDataDiv">
                    <div class="inner_box" style="background: #fff; padding: 155px;">
                        <img src="../../assets/images/announcement.svg">
                        <div class="text_note">
                            <h4>No Results Found</h4>
                        </div>
                        <div class="text_line">Search for another term or try changing filters</div>
                    </div>
                </div>

                <div class="failedtable main_table" style="display: none;">

                    <div class="table_data failedtable table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Sr.No</th>
                                    <th style="cursor: pointer;" ng-click="SortList('Barcode')">AWB</th>
                                    <th>Length(cm)</th>
                                    <th>Width(cm)</th>
                                    <th>Height(cm)</th>
                                    <th>Weight(g)</th>
                                    <th>Volume(mm3)</th>
                                    <th>Real Volume(mm3)</th>
                                    <th>Package Type</th>
                                    <th>Data Sent</th>
                                    <th>Failed Reason</th>
                                    <th>TimeStamp</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="item in failedlist | filter:txtSearch | orderBy:orderList:orderDirection">
                                    <td>{{$index+1}}</td>
                                    <td>{{item.Barcode}}</td>
                                    <td>{{item.Length}}</td>
                                    <td>{{item.Width}}</td>
                                    <td>{{item.Height}}</td>
                                    <td>{{item.Weight}}</td>
                                    <td>{{item.Volume}}</td>
                                    <td>{{item.RealVolume}}</td>
                                    <td>{{item.PackageType}}</td>
                                    <td ng-class="{'divRed1': item.IsSend == 'Failed','divgreen': item.IsSend == 'Success'}">{{item.IsSend}}</td>
                                    <td title="{{item.ReasonForFailed}}"><span class="tabulator-cell" style="width: 110px;">{{item.ReasonForFailed}}</span></td>
                                    <td>{{item.Datetime}}</td>
                                </tr>
                                <tr>
                                    <td colspan="12" class="text-center" style="background-color: #fff; border-bottom: 1px solid #fff;">
                                        <div ng-switch="(failedlist | filter:txtSearch).length">
                                            <span class="ng-empty text-danger" ng-switch-when="0">No Record(s) Found</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot id="tfoot">
                                <tr>
                                    <td align="center" colspan="12">
                                        <div class="div-left" style="display: flex;">
                                            <span class="form-group pull-left page-size form-inline">
                                                <select id="ddlPageSize1" class="form-control"
                                                    ng-model="pageSizeSelected"
                                                    ng-change="changePageSize1()">
                                                    <option value="5">5</option>
                                                    <option value="10">10</option>
                                                    <option value="25">25</option>
                                                    <option value="50">50</option>
                                                    <option value="1000">1000</option>
                                                    <option value="10000">10000</option>
                                                    <option value="100000">100000</option>
                                                </select>
                                            </span>
                                            <p id="failed" style="padding: 7px; color: red;">Total {{totalCount}} shipment processed {{Failed}} shipment are failed.</p>
                                            <p id="calibration" style="padding: 7px; color: #ffb96d;">Total {{totalCount}} Calibration shipment processed {{Success}} successfully sent and {{Failed}} shipment are failed.</p>
                                        </div>
                                        <div class="pull-right pagination div-right" style="display: flex;">
                                            <pagination total-items="Failed" ng-change="pageChanged1()" items-per-page="pageSizeSelected" direction-links="true" ng-model="pageIndex" max-size="maxSize" class="pagination" boundary-links="true" rotate="false" num-pages="numPages"></pagination>
                                            <a class="btn btn-primary" style="color: #161616;">Page: {{pageIndex}} / {{numPages}}</a>
                                        </div>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>

                    </div>
                </div>

                <div class="successtable main_table">
                    <div class="table_data table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Sr.No</th>
                                    <th style="cursor: pointer;" ng-click="SortList('Barcode')">AWB</th>
                                    <th>Length(cm)</th>
                                    <th>Width(cm)</th>
                                    <th>Height(cm)</th>
                                    <th>Weight(g)</th>
                                    <th>Volume(mm3)</th>
                                    <th>Real Volume(mm3)</th>
                                    <th>Package Type</th>
                                    <th>Data Sent</th>
                                    <th>Failed Reason</th>
                                    <th>TimeStamp</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="item in successlist | filter:txtSearch | orderBy:orderList:orderDirection">
                                    <td>{{$index+1}}</td>
                                    <td>{{item.Barcode}}</td>
                                    <td>{{item.Length}}</td>
                                    <td>{{item.Width}}</td>
                                    <td>{{item.Height}}</td>
                                    <td>{{item.Weight}}</td>
                                    <td>{{item.Volume}}</td>
                                    <td>{{item.RealVolume}}</td>
                                    <td>{{item.PackageType}}</td>
                                    <td ng-class="{'divRed1': item.IsSend == 'Failed','divgreen': item.IsSend == 'Success'}">{{item.IsSend}}</td>
                                    <td title="{{item.ReasonForFailed}}"><span class="tabulator-cell" style="width: 110px;">{{item.ReasonForFailed}}</span></td>
                                    <td>{{item.Datetime}}</td>
                                </tr>
                                <tr>
                                    <td colspan="12" class="text-center" style="background-color: #fff; border-bottom: 1px solid #fff;">
                                        <div ng-switch="(successlist | filter:txtSearch).length">
                                            <span class="ng-empty text-danger" ng-switch-when="0">No Record(s) Found</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot id="tfoot">
                                <tr>
                                    <td align="center" colspan="12">
                                        <div class="div-left" style="display: flex;">
                                            <span class="form-group pull-left page-size form-inline">
                                                <select id="ddlPageSize2" class="form-control"
                                                    ng-model="pageSizeSelected"
                                                    ng-change="changePageSize2()">
                                                    <option value="5">5</option>
                                                    <option value="10">10</option>
                                                    <option value="25">25</option>
                                                    <option value="50">50</option>
                                                    <option value="1000">1000</option>
                                                    <option value="10000">10000</option>
                                                    <option value="100000">100000</option>
                                                </select>
                                            </span>
                                            <p style="padding: 7px; color: #00cc00;">Total {{totalCount}} shipment processed {{Success}} shipment successfully sent.</p>
                                        </div>
                                        <div class="pull-right pagination div-right" style="display: flex;">
                                            <pagination total-items="Success" ng-change="pageChanged2()" items-per-page="pageSizeSelected" direction-links="true" ng-model="pageIndex" max-size="maxSize" class="pagination" boundary-links="true" rotate="false" num-pages="numPages"></pagination>
                                            <a class="btn btn-primary" style="color: #161616;">Page: {{pageIndex}} / {{numPages}}</a>
                                        </div>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <div class="table_data main_table" id="searchtable" style="margin-bottom: 0px; display: none;">
                    <p style="text-align: center;">{{searchTotal}} Records Found</p>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Sr.No</th>
                                <th scope="col">AWB</th>
                                <th scope="col">Length(cm)</th>
                                <th scope="col">Width(cm)</th>
                                <th scope="col">Height(cm)</th>
                                <th scope="col">Weight(g)</th>
                                <th scope="col">Volume(mm3)</th>
                                <th scope="col">Real Volume(mm3)</th>
                                <th scope="col">Package Type</th>
                                <th scope="col">Data Send</th>
                                <th scope="col">Reason for Failed </th>
                                <th scope="col">Datetime</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="item in listData1">
                                <td>{{$index+1}}</td>
                                <td>{{item.Barcode}}</td>
                                <td>{{item.Length}}</td>
                                <td>{{item.Width}}</td>
                                <td>{{item.Height}}</td>
                                <td>{{item.Weight}}</td>
                                <td>{{item.Volume}}</td>
                                <td>{{item.RealVolume}}</td>
                                <td>{{item.PackageType}}</td>
                                <td ng-class="{'divRed1': item.IsSend == 'Failed','divgreen': item.IsSend == 'Success'}">{{item.IsSend}}</td>
                                <td title="{{item.ReasonForFailed}}"><span class="tabulator-cell" style="width: 130px;">{{item.ReasonForFailed}}</span></td>
                                <td>{{item.Datetime}}</td>
                            </tr>
                            <tr>
                                <td colspan="12" class="text-center" style="font-size: 15px; background-color: white; border-bottom: 1px solid white; border-right: 1px solid white; border-left: 1px solid white;">
                                    <div ng-switch="(listData1 | filter:txtSearch1).length">
                                        <span class="ng-empty text-danger" ng-switch-when="0">No Record(s) Found</span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <footer>
            <div class="foot_wrap">
                <span class="fot_txt">Copyright © 2020  Armstrong Machine Builders Pvt. Ltd  All rights reserved.</span>
            </div>
        </footer>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
