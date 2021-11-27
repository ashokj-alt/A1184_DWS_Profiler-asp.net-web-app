<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductionReport.aspx.cs" MasterPageFile="~/Base.Master" Inherits="DWS_Profiler.Pages.Reports.ProductionReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head runat="server">
        <title>Production Report | Delhivery </title>
        <script src="../../JS/webapp/ProductionReport.js"></script>
        <script>
            function Daywise() {
                var checkBox = document.getElementById("Daywise");
                var daywise = document.getElementById("daywise");
                if (checkBox.checked == true) {
                    daywise.style.display = "block";
                } else {
                    daywise.style.display = "none";
                }
            }
            function Package() {
                var checkBox = document.getElementById("Package");
                var package = document.getElementById("package");
                if (checkBox.checked == true) {
                    package.style.display = "block";
                } else {
                    package.style.display = "none";
                }
            }

            function LengthWise() {
                var checkBox = document.getElementById("Length");
                var length = document.getElementById("length");
                if (checkBox.checked == true) {
                    length.style.display = "block";
                } else {
                    length.style.display = "none";
                }
            }
            function Width() {
                var checkBox = document.getElementById("Width");
                var width = document.getElementById("width");
                if (checkBox.checked == true) {
                    width.style.display = "block";
                } else {
                    width.style.display = "none";
                }
            }
            function Height() {
                var checkBox = document.getElementById("Height");
                var height = document.getElementById("height");
                if (checkBox.checked == true) {
                    height.style.display = "block";
                } else {
                    height.style.display = "none";
                }
            }
            function HourWise() {
                var checkBox = document.getElementById("Hour");
                var hourwise = document.getElementById("hourwise");
                if (checkBox.checked == true) {
                    hourwise.style.display = "block";
                } else {
                    hourwise.style.display = "none";
                }
            }
            function LBH() {
                var checkBox = document.getElementById("LBH");
                var lbh = document.getElementById("lbh");
                if (checkBox.checked == true) {
                    lbh.style.display = "block";
                } else {
                    lbh.style.display = "none";
                }
            }
            function Weight() {
                var checkBox = document.getElementById("Weight");
                var weight = document.getElementById("weight");
                if (checkBox.checked == true) {
                    weight.style.display = "block";
                } else {
                    weight.style.display = "none";
                }
            }
        </script>
    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="report" ng-app="myApp" ng-controller="myController">
        <div class="top_row">
            <div class="col-md-12" style="background-color: #194a77; color: white; height: 37px; padding-left: 20px;">
                <h4 class="main_title"><i class="far fa-chart-bar" style="margin:6px;"></i>Production Report</h4>
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
                        <div class="row">
                            <div class="col-md-3 pl-0 pr-0">
                                <label class="container">
                                    <span class="rad_txt">Day Wise</span>
                                    <input type="checkbox" id="Daywise" checked="checked" name="radio" onclick="Daywise()">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <div class="col-md-3 pl-0 pr-0">
                                <label class="container">
                                    <span class="rad_txt">Package Type</span>
                                    <input type="checkbox" checked="checked" id="Package" name="radio" onclick="Package()">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <div class="col-md-3 pl-0">
                                <label class="container">
                                    <span class="rad_txt">Length Wise</span>
                                    <input type="checkbox" id="Length" name="radio" onclick="LengthWise()">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <div class="col-md-3 pl-0">
                                <label class="container">
                                    <span class="rad_txt">Width Wise</span>
                                    <input type="checkbox" id="Width" name="radio" onclick="Width()">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-3 pl-0">
                                <label class="container">
                                    <span class="rad_txt">Height Wise</span>
                                    <input type="checkbox" id="Height" name="radio" onclick="Height()">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <div class="col-md-3 pl-0">
                                <label class="container">
                                    <span class="rad_txt">Hour Wise</span>
                                    <input type="checkbox" id="Hour" name="radio" onclick="HourWise()">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <div class="col-md-3 pl-0">
                                <label class="container">
                                    <span class="rad_txt">LBH Wise</span>
                                    <input type="checkbox" id="LBH" name="radio" onclick="LBH()">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <div class="col-md-3 pl-0">
                                <label class="container">
                                    <span class="rad_txt">Weight Wise</span>
                                    <input type="checkbox" id="Weight" name="radio" onclick="Weight()">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="data" style="height: 450px; overflow: auto;">
                    <div class="row" style="margin-top: 13px;">
                        <div class="col-md-6 mb-10" id="daywise" style="margin-bottom: 15px;">
                            <div class="chart_wrap">
                                <figure class="highcharts-figure" id="DivHighchart">
                                    <div id="bar_chart"></div>
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

                        <div class="col-md-6 mb-10" id="package" style="margin-bottom: 15px;">
                            <div class="chart_wrap">
                                <figure class="highcharts-figure" id="DivHighchart1">
                                    <div id="bar_chart1"></div>

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
                        <div class="col-md-6 mb-10" id="length" style="display: none; margin-bottom: 15px;">
                            <div class="chart_wrap">
                                <figure class="highcharts-figure" id="DivHighchartLength">
                                    <div id="bar_chartLength"></div>
                                </figure>
                                <div class="out_wrap" id="NoDataDivLength" ng-show="NoDataDivLength">
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

                        <div class="col-md-6 mb-10" style="display: none; margin-bottom: 15px;" id="width">
                            <div class="chart_wrap">
                                <figure class="highcharts-figure" id="DivHighchartWidth">
                                    <div id="bar_chartWidth"></div>
                                </figure>
                                <div class="out_wrap" id="NoDataDivWidth" ng-show="NoDataDivWidth">
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
                        <div class="col-md-6 mb-10" style="display: none; margin-bottom: 15px;" id="height">
                            <div class="chart_wrap">
                                <figure class="highcharts-figure" id="DivHighchartHeight">
                                    <div id="bar_chartHeight"></div>
                                </figure>
                                <div class="out_wrap" id="NoDataDivHeight" ng-show="NoDataDivHeight">
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

                        <div class="col-md-6 mb-10" style="display: none; margin-bottom: 15px;" id="weight">
                            <div class="chart_wrap">
                                <figure class="highcharts-figure" id="DivHighchartWeight">
                                    <div id="bar_chartWeight"></div>
                                </figure>
                                <div class="out_wrap" id="NoDataDivWeight" ng-show="NoDataDivWeight">
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
                        <div class="col-md-6 mb-10" style="display: none; margin-bottom: 15px;" id="hourwise">
                            <div class="chart_wrap">
                                <figure class="highcharts-figure" id="PerHourShipment">
                                    <div id="LineChart"></div>
                                    <p class="highcharts-description">
                                    </p>
                                </figure>
                                <div class="out_wrap" id="NoPerHourShipment" ng-show="NoPerHourShipment">
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
                        <div class="col-md-6" style="display: none; margin-bottom: 15px;" id="lbh">
                            <div class="chart_wrap">
                                <figure class="highcharts-figure" id="DivHighchartLBH">
                                    <div id="bar_chartLBH"></div>
                                    <p class="highcharts-description">
                                    </p>
                                </figure>
                                <div class="out_wrap" id="NoDataDivLBH" ng-show="NoDataDivLBH">
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
                    </div>
                </div>
            </div>

            <footer>
                <div class="foot_wrap">
                    <span class="fot_txt">Copyright © 2020  Armstrong Machine Builders Pvt. Ltd  All rights reserved.</span>
                </div>
            </footer>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script src="../../JS/popper.min.js"></script>
    <script src="../../JS/Highcharts/highcharts.js"></script>
    <script src="../../JS/Highcharts/exporting.js"></script>
    <script src="../../JS/Highcharts/export-data.js"></script>
    <script src="../../JS/Highcharts/accessibility.js"></script>

</asp:Content>
