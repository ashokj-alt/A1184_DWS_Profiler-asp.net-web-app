<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="faultscreen.aspx.cs" Inherits="DWS_Profiler.Pages.faultscreen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Delhivery | System Alarm's</title>
    <link href="../global/webapp/FaultScreen.css" rel="stylesheet" />
    <script src="../JS/webapp/FaultScreen.js"></script>
    <style>
        .div-left {
            float: left;
            padding-left: 10px;
        }

        .divRed h6 {
            color: #fff !important;
        }

        .fault_box h6 {
            font-size: 14px;
        }

        .div-right {
            float: right;
            padding-right: 10px;
        }

        .table_wrap thead th {
            background-color: #003fb3;
            color: #fff;
        }

        .dot {
            height: 19px;
            width: 24px;
            background-color: #bbb;
            border-radius: 50%;
            display: inline-block;
        }

        .divRedtotalActiveFault {
            color: orangered !important;
            font-size: 15px !important;
        }

        .fault_box {
            margin-bottom: 10px;
            margin-top: 5px;
            height: 460px;
            overflow: auto;
            background-color: #fff;
            padding: 10px 0px;
        }

        .table_data {
            display: none;
            background-color: #fff;
            margin-bottom: 10px;
            margin-top: 5px;
            height: 450px;
            overflow: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="faultpage" ng-app="myApp" ng-controller="myController" ng-init="StartTimer()">
        <div class="top_row">
            <div class="col-md-12" style="background-color: #194a77; color: white; height: 37px; padding-left: 20px;">

                <h4 class="main_title"><i class="fas fa-list-ul" style="margin: 6px;"></i>System Alerts</h4>
                <p style="text-align: center; padding-top: 8.5px; display: none; color: #1bff00; margin-left: -150px; width: 100%;" id="inactive">System is healthy.. <span class="dot">{{totalActiveFault}}</span> active alerts</p>
                <p id="active" style="text-align: center; padding-top: 8.5px; width: 100%; color: #ffc239; margin-left: -150px;" ng-class="{'divRedtotalActiveFault':totalActiveFault > 2}">System is in Fault.. <span class="dot">{{totalActiveFault}}</span> active alerts</p>
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
                                    <option value="" selected="" >Select DWS</option>
                                    <option value="{{GetScanLocationList}}">{{GetScanLocationList}}</option>
                                </select>
                            </div>
                            <div class="text-right searcg_btn">
                                <button type="button" class="btn btn-primary" ng-click="Search()">
                                    Search
                                    <img src="/Images/search.svg"></button>
                            </div>
                            <div class="text-right exp_btn" style="margin-left: auto; margin-right: 0; min-width: 60px !important;">
                                <button type="button" class="btn btn-success" ng-click="Export()" title="Export Data to CSV">
                                    Export  
                                    <img src="/Images/export_white.png" style="margin-left: 0px;"></button>
                            </div>
                            <div class="text-right searcg_btn" style="margin-left: 10px;">
                                <button type="button" id="alertHide" class="btn btn-primary" ng-click="Hide()" title="hide alerts (switch into Table Type Data)">
                                    Hide Alert</button>
                            </div>
                            <div class="text-right searcg_btn" style="margin-left: 10px;">
                                <button type="button" id="alertTableHide" class="btn btn-primary" ng-click="HideTable()" style="display: none;">
                                    Hide Table</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row fault_box">
                    <div class="col-md-2 " ng-repeat="data in listData">
                        <div class="card mb-3" style="border: none;" title="{{data.FaultName}}" id="faults_ID" ng-click="open(data.ID)">

                            <div class="col-md-12 no-gutters" id="one" ng-class="{'divRed':data.Status==1}">
                                <div class="card-body" style="padding: 0.3rem; height: 60px;">
                                    <h6 class="card-title text-center">{{data.FaultName}}</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2 ">
                        <div class="text-right exp_btn" style="margin-left: auto; margin-right: 0; min-width: 60px !important;">
                            <button type="button" class="btn btn-outline-success" ng-click="ExportList()" title="Export Data to CSV">
                                Export Alarms  
                                <img src="/Images/export_white.png" style="margin-left: 0px;"></button>
                        </div>
                    </div>
                </div>
                <div class="table_data table-responsive">
                    <table class="table" style="margin-bottom: 30px;">
                        <thead>
                            <tr>
                                <th>Sr.No</th>
                                <th style="cursor: pointer" ng-click="SortList('Barcode')">AlertName</th>
                                <th>StartTime</th>
                                <th>EndTime</th>
                                <th>TotalTime</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="item in list | filter:txtSearch | orderBy:orderList:orderDirection">
                                <td>{{$index+1}}</td>
                                <td title="AlertName">{{item.FaultName}}</td>
                                <td title="Start Time">{{item.StartTime}}</td>
                                <td title="End Time">{{item.EndTime}}</td>
                                <td title="TotalTime mm:ss">{{item.TotalTime}} mm:ss</td>
                            </tr>
                            <tr>
                                <td colspan="11" class="text-center" style="background-color: #fff; border-bottom: 1px solid #fff;">
                                    <div ng-switch="(list | filter:txtSearch).length">
                                        <span class="ng-empty text-danger" ng-switch-when="0">No Record(s) Found</span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                        <tfoot id="tfoot">
                            <tr>
                                <td align="center" colspan="11">
                                    <div class="div-left">
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
                                    </div>
                                    <div class="pull-right pagination div-right" style="display: flex;">
                                        <a class="btn btn-primary" style="color: #161616;">Total Time {{FinalTotalTime}} hh:mm:ss</a>
                                    </div>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
        <%-- Model--%>

        <div class="modal fade" id="Modal_Notify_announciation" role="dialog" tabindex="-1" style="padding-right: 17px; display: none;">
            <div class="modal-dialog" style="max-width: 750px; min-height: 100px; margin-top: 80px;">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Rectification action</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body" style="min-height: 100px;">
                        <div class="">
                            <table class="table_wrap table table-bordered">
                                <thead>
                                    <tr>
                                        <th class="w30" style="width: 50px;">Sr. No</th>
                                        <th class="w30">Fault Name</th>
                                        <th class="w30">Solution</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="data in Rectification_Action" ng-class="{'divRed':data.Status==1}">
                                        <td style="text-align: center;">{{$index+1}}</td>
                                        <td>{{data.FaultName}}</td>
                                        <td>{{data.Rectification_Action}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <%-- Model End--%>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
