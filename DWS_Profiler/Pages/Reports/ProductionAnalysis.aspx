<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductionAnalysis.aspx.cs" MasterPageFile="~/Base.Master" Inherits="DWS_Profiler.Pages.Reports.ProductionAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head runat="server">
        <title>Delhivery | Production& Fault Analysis </title>
        <script src="../../JS/webapp/ProductionAnalysis.js"></script>
        <link href="../../global/webapp/ProductionAnalysis.css" rel="stylesheet" />
        <style>
            .chart_wrap {
                padding: 0px;
                height: 385px;
            }

            .IdleReason {
                color: rgb(255,92,51) !important;
            }

            .IdleReason1 {
                color: #c3ff99 !important;
            }

            .IdleReason2 {
                color: #6AF9C4 !important;
            }

            .FaultName1 {
                color: #7cb5ec !important;
            }

            .FaultName2 {
                color: #434348 !important;
            }

            .FaultName3 {
                color: #90ed7d !important;
            }

            .FaultName4 {
                color: #f7a35c !important;
            }

            .FaultName5 {
                color: #8085e9 !important;
            }

            .FaultName6 {
                color: #f15c80 !important;
            }

            .FaultName7 {
                color: #e4d354 !important;
            }

            .FaultName8 {
                color: #2b908f !important;
            }

            .FaultName9 {
                color: #f45b5b !important;
            }

            .FaultName10 {
                color: #91e8e1 !important;
            }

            .FaultName11 {
                color: #7cb5ec !important;
            }

            .FaultName12 {
                color: #434348 !important;
            }

            .FaultName13 {
                color: #90ed7d !important;
            }

            .FaultName14 {
                color: #f7a35c !important;
            }

            .FaultName15 {
                color: #8085e9 !important;
            }

            .FaultName16 {
                color: #f15c80 !important;
            }

            .FaultName17 {
                color: #e4d354 !important;
            }

            .FaultName18 {
                color: #2b908f !important;
            }

            .FaultName19 {
                color: #f45b5b !important;
            }

            .FaultName20 {
                color: #91e8e1 !important;
            }
            .data{
                background-color:#fff;
                padding: 0px;
    height: 385px;
            }
        </style>
        <script>
            function Production() {
                var checkBox = document.getElementById("Production");
                var production = document.getElementById("production");
                if (checkBox.checked == true) {
                    production.style.display = "block";
                } else {
                    production.style.display = "none";
                }
            }
            function SystemAlerts() {
                var checkBox = document.getElementById("SystemAlerts");
                var systemAlerts = document.getElementById("systemAlerts");
                if (checkBox.checked == true) {
                    systemAlerts.style.display = "block";
                } else {
                    systemAlerts.style.display = "none";
                }
            }

        </script>
    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="report" ng-app="myApp" ng-controller="myController">
        <div class="top_row">
            <div class="col-md-12" style="background-color: #194a77; color: white; height: 37px; padding-left: 20px;">

                <h4 class="main_title"><i class="far fa-chart-bar" style="margin:6px;"></i>Production Report And System Alerts Report</h4>
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
                                        <input type="datetime-local" class="form-control" id="txtStartDate" placeholder="Start Date" value="" />
                                    </div>
                                    <div>
                                        <label for="exampleFormControlInput1">To Date</label>
                                        <input type="datetime-local" class="form-control" id="txtEndDate" placeholder="End Date" value="" />
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

                            <div class="text-right exp_btn" style="margin-left: auto; margin-right: 0; display: none;">
                                <button type="button" class="btn btn-success" ng-click="Export()">
                                    Export
                                    <img src="/Images/export_white.png"></button>
                            </div>

                        </div>
                    </div>
                </div>


                <div class="row" id="RadioButton" style="background-color: #fff">
                    <div class="col-md-6">
                        <label class="container">
                            <span class="rad_txt">Production Analysis</span>
                            <input type="checkbox" id="Production" checked="checked" name="radio" onclick="Production()">
                            <span class="checkmark"></span>
                        </label>
                    </div>
                    <div class="col-md-6">
                        <label class="container">
                            <span class="rad_txt">System Alerts Analysis</span>
                            <input type="checkbox" id="SystemAlerts" name="radio" onclick="SystemAlerts()">
                            <span class="checkmark"></span>
                        </label>
                    </div>
                </div>

                <div id="production" style="margin-top: 13px;">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="chart_wrap">
                                <figure id="DivHighchart">
                                    <div id="pie_chart"></div>

                                </figure>
                                <div class="out_wrap" id="NoDataDiv" ng-show="NoDataDiv">

                                    <div class="inner_box">
                                        <img src="../../assets/images/announcement.svg">
                                        <div class="text_note">
                                            <h4>No Results Found</h4>
                                        </div>
                                        <div class="text_line">Search for another term or try changing filters</div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="data">
                                <div class="row">

                                    <div class="col-md-12">

                                        <div class="table prod" id="DivHighchart" style="margin-top: 20px; height: 200px; overflow: auto;">
                                            <table class="table">

                                                <thead style="background-color: #ccc; color: black; padding: 5px;">
                                                    <tr>
                                                        <th>Category</th>
                                                        <th>Number of AWB</th>
                                                    </tr>
                                                </thead>
                                                <tbody style="color: black; padding: 5px;">
                                                    <tr ng-repeat="data in Line1">
                                                        <td ng-class="{'IdleReason':data.IsSend==0,'IdleReason1':data.IsSend==1,'IdleReason2':data.IsSend==2}">{{data.IdleReason}}</td>
                                                        <td ng-class="{'IdleReason':data.IsSend==0,'IdleReason1':data.IsSend==1,'IdleReason2':data.IsSend==2}">{{data.InsertedOn}}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>

                                        
                                <div class="out_wrap" id="NoDataDiv1" ng-show="NoDataDiv1" style="display:none;">

                                    <div class="inner_box">
                                        <img src="../../assets/images/announcement.svg">
                                        <div class="text_note">
                                            <h4>No Results Found</h4>
                                        </div>
                                        <div class="text_line">Search for another term or try changing filters</div>
                                    </div>
                                </div>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 20px;">
                                    <div class="col-md-12">
                                        <h6>Total AWB Scan</h6>

                                        <h5 style="margin-top: 10px; margin-left: 30px; color: #2c84ec;">{{Totalcount}} </h5>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="systemAlerts" style="margin-top: 13px; display: none; margin-bottom: 40px;">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="chart_wrap">
                                <figure id="DivHighchart1">
                                    <div id="pie_chart1"></div>

                                </figure>
                                <div class="out_wrap" id="NoDataDiv1" ng-show="NoDataDiv1">

                                    <div class="inner_box">
                                        <img src="../../assets/images/announcement.svg">
                                        <div class="text_note">
                                            <h4>No Results Found</h4>
                                        </div>
                                        <div class="text_line">Search for another term or try changing filters</div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="data">
                            <div class="row">
                                <div class="col-md-12">

                                    <div class="table prod" id="DivHighchart" style="margin-top: 20px; height: 300px; overflow: auto;">
                                        <table class="table">

                                            <thead style="background-color: #ccc; color: black; padding: 5px;">
                                                <tr>
                                                    <th>Category</th>
                                                    <th>Time Taken</th>
                                                </tr>
                                            </thead>
                                            <tbody style="color: black; padding: 5px;">
                                                <tr ng-repeat="data in fault">
                                                    <td title="{{data.FaultName}}"><span class="tabulator-cell" style="width: 380px;" ng-class="{'FaultName1':data.ID==1,'FaultName2':data.ID==2,'FaultName3':data.ID==3,'FaultName4':data.ID==4,'FaultName5':data.ID==5,'FaultName6':data.ID==6,'FaultName7':data.ID==7,'FaultName8':data.ID==8,'FaultName9':data.ID==9,'FaultName10':data.ID==10,'FaultName11':data.ID==11,'FaultName12':data.ID==12,'FaultName13':data.ID==13,'FaultName14':data.ID==14,'FaultName15':data.ID==15,'FaultName16':data.ID==16,'FaultName17':data.ID==17,'FaultName18':data.ID==18,'FaultName19':data.ID==19,'FaultName20':data.ID==20}">{{data.FaultName}}</span></td>
                                                    <td ng-class="{'FaultName1':data.ID==1,'FaultName2':data.ID==2,'FaultName3':data.ID==3,'FaultName4':data.ID==4,'FaultName5':data.ID==5,'FaultName6':data.ID==6,'FaultName7':data.ID==7,'FaultName8':data.ID==8,'FaultName9':data.ID==9,'FaultName10':data.ID==10,'FaultName11':data.ID==11,'FaultName12':data.ID==12,'FaultName13':data.ID==13,'FaultName14':data.ID==14,'FaultName15':data.ID==15,'FaultName16':data.ID==16,'FaultName17':data.ID==17,'FaultName18':data.ID==18,'FaultName19':data.ID==19,'FaultName20':data.ID==20}">{{data.InsertedOn}} mm:ss</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    
                                <div class="out_wrap" id="NoDataDiv1" ng-show="NoDataDiv1" style="display:none;">

                                    <div class="inner_box">
                                        <img src="../../assets/images/announcement.svg">
                                        <div class="text_note">
                                            <h4>No Results Found</h4>
                                        </div>
                                        <div class="text_line">Search for another term or try changing filters</div>
                                    </div>
                                </div>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 20px;">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <h6>Total Time</h6>
                                        </div>
                                        <div class="col-md-9">
                                            <h5 style="color: #2c84ec;">{{FinalTotalTime}} hh:mm:ss</h5>

                                        </div>
                                    </div>

                                </div>
                            </div>
                                </div>
                        </div>
                    </div>
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
