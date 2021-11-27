<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReasonwiseReport.aspx.cs" MasterPageFile="~/Base.Master" Inherits="DWS_Profiler.Pages.Reports.ReasonwiseReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head runat="server">
        <title>Reasonwise Idletime Report | Delhivery </title>
        <link href="../../global/webapp/ReasonWiseReport.css" rel="stylesheet" />
        <script src="../../JS/webapp/ReasonWiseReport.js"></script>
    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="report" ng-app="myApp" ng-controller="myController">
        <div class="top_row">
            <div class="container-fluid">
                <div class="col-md-12" style="background-color: #194a77; color: white; height: 45px; padding-left: 20px; padding-top: 5px;">
                    <div class="row">
                        <div class="col-md-6">
                            <h4 class="main_title" style="font-family: inherit;">Reasonwise Data Report</h4>
                        </div>
                        <div class="col-md-6">
                            <div class="text-right exp_btn">
                                <button type="button" class="btn btn-success" ng-click="Export()" style="float:right;">
                                    Export
                                    <img src="/Images/export_white.png"></button>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
        
            <div class="inner_content">
                <div class="container">
                    <div class="row">
                        <div class="col-md-3 left_side">
                            <div class="Col-md-12 form-group">
                                <label for="exampleFormControlSelect1">Select</label>
                                <select class="form-control" ng-model="seldatepicker" id="seldatepicker" name="DatePicker">
                                    <option value="" selected="">Select of</option>
                                    <option value="date">Date</option>
                                    <option value="week">Week</option>
                                    <option value="month">Month</option>
                                    <option value="dateRange">Date range</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <div class="form-group" id="date">
                                    <label for="exampleFormControlInput1">Date</label>
                                    <input type="Date" class="form-control" id="txtDate" placeholder="Select Date" value="" />
                                </div>
                                <div class="form-group" id="week">
                                    <label for="exampleFormControlInput1">Week</label>
                                    <input type="week" class="form-control" id="txtWeek" placeholder="Select Week" value="" />
                                </div>
                                <div class="form-group" id="month">
                                    <label for="exampleFormControlInput1">Month</label>
                                    <input type="month" class="form-control" id="txtMonth" placeholder="Select Month" value="" />
                                </div>
                                <div class="form-group" id="dateRange">
                                    <label for="exampleFormControlInput1">From Date</label>
                                    <input type="date" class="form-control" id="txtStartDate" placeholder="Start Date" value="" />
                                    <label for="exampleFormControlInput1">To Date</label>
                                    <input type="date" class="form-control" id="txtEndDate" placeholder="End Date" value="" />
                                </div>
                            </div>
                            <div class="Col-md-12 form-group" id="RobotCell">
                                <label for="exampleFormControlSelect1">Robot cell</label>
                                <select class="form-control" ng-model="selCell" id="selCell">
                                    <option value="" selected="">Select cell</option>
                                    <option value="1">Robot Cell 1</option>
                                    <option value="2">Robot Cell 2</option>
                                </select>
                            </div>
                           <div class="text-right searcg_btn">

                                <button type="button" class="btn btn-primary" ng-click="Search()">
                                    Search
                                    <img src="/Images/search.svg"></button>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="chart_wrap">
                                <figure class="highcharts-figure" id="DivHighchart">
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

   <script src="../../JS/Highcharts/highcharts.js"></script>
    <script src="../../JS/Highcharts/exporting.js"></script>
    <script src="../../JS/Highcharts/export-data.js"></script>
    <script src="../../JS/Highcharts/accessibility.js"></script>

</asp:Content>
