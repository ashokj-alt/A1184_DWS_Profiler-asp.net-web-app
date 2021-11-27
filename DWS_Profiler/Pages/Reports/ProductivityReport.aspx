<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductivityReport.aspx.cs" MasterPageFile="~/Base.Master" Inherits="DWS_Profiler.Pages.Reports.ProductivityReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head runat="server">
        <title>Productivity Report </title>
        <link href="/../../global/css/bootstrap.min.css" rel="stylesheet" />
        <link href="../../global/fonts/font-awesome/font-awesome.min.css" rel="stylesheet" />
        <link href="/../../global/css/style.css" rel="stylesheet" />
        <script type="text/javascript">

            var myApp = angular.module("myApp", []);
            myApp.controller("myController", function ($scope, $http) {
                $scope.Type = "";
                var Line1 = [], Line2 = [], Line3 = [], CSeries = [];

                function time_convert(num) {
                    var hours = Math.floor(num / 3600);
                    var minutes = num % 60;
                    return parseFloat(hours + "." + minutes);
                }

                $scope.Search = function () {
                    $scope.selCell = selCell.value;
                    if ($scope.seldatepicker == undefined || $scope.seldatepicker == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Select Period First ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                        return;
                    }
                    if ($scope.seldatepicker == "date") {
                        $scope.Type = "Day";
                        $scope.txtStartDate = document.getElementById("txtDate").value;
                        $scope.txtWeek = 0;
                        $scope.txtMonth = 0;
                        $scope.txtEndDate = "";
                        if ($scope.txtStartDate == "" || $scope.txtStartDate == undefined) {
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.error('Please Select Date ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                            return;
                        }
                    }
                    if ($scope.seldatepicker == "week") {
                        $scope.Type = "Week";
                        var w = document.getElementById("txtWeek").value;
                        $scope.txtWeek = w.substring(6);
                        $scope.txtDate = 0;
                        $scope.txtMonth = 0;
                        $scope.txtStartDate = "";
                        $scope.txtEndDate = "";
                        if ($scope.txtWeek == "" || $scope.txtWeek == undefined) {
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.error('Please Select Week ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                            return;
                        }
                    }
                    if ($scope.seldatepicker == "month") {
                        $scope.Type = "Month";
                        var m = document.getElementById("txtMonth").value;
                        $scope.txtMonth = m.substring(5);
                        $scope.txtDate = 0;
                        $scope.txtWeek = 0;
                        $scope.txtStartDate = "";
                        $scope.txtEndDate = "";
                        if ($scope.txtMonth == "" || $scope.txtMonth == undefined) {
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.error('Please Select Month ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                            return;
                        }
                    }
                    if ($scope.seldatepicker == "dateRange") {
                        $scope.Type = "dateRange";
                        $scope.txtStartDate = document.getElementById("txtStartDate").value;
                        $scope.txtEndDate = document.getElementById("txtEndDate").value;

                        $scope.txtDate = 0;
                        $scope.txtWeek = 0;
                        $scope.txtMonth = 0;

                    }
                    if ($scope.selCell == undefined || $scope.selCell == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Please Select Cell ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                        return;
                    }
                    var httpreq = {
                        method: "POST",
                        url: "ProductivityReport.aspx/DataSearch",
                        data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, Cell: $scope.selCell },
                    }
                    $http(httpreq).success(function (response) {
                        $scope.TotalProductivity = angular.fromJson(response.d);
                        $scope.Line1 = $scope.TotalProductivity.Table;
                        if ($scope.Line1.length >= 1) {
                            $scope.NoDataDiv = false;
                            $('#DivHighchart').show();
                            Line1 = [], Line2 = [], Line3 = [], CSeries = [];
                            for (var i = 0; i < $scope.Line1.length; i++) {
                                Line1.push(time_convert($scope.Line1[i].PalletTime));
                                Line2.push(time_convert($scope.Line1[i].IdleTime));
                                CSeries.push($scope.Line1[i].InsertedOn);
                            }
                        }

                        else {
                            $scope.NoDataDiv = true;
                            $('#DivHighchart').hide();
                        }
                        console.dir(Line1);
                        console.dir(Line2);
                        console.dir(CSeries);

                        Highcharts.chart('bar_chart1', {
                            chart: {
                                type: 'column',
                                backgroundColor: ''
                            },
                            title: {
                                text: ''
                            },
                            subtitle: {
                                text: ''
                            },
                            //exporting: {
                            //    buttons: {
                            //        contextButton: {
                            //            menuItems: [
                            //                'downloadPNG',
                            //                'downloadJPEG',
                            //                'downloadPDF',

                            //            ],

                            //        },

                            //    }
                            //},
                            xAxis: {
                                categories: CSeries,
                                crosshair: true
                            },
                            yAxis: {
                                min: 0,
                                title: {
                                    text: 'Pallet Count HH:mm'
                                }
                            },
                            tooltip: {
                                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                    '<td style="padding:0"><b>{point.y:f} mm</b></td></tr>',
                                footerFormat: '</table>',
                                shared: true,
                                useHTML: true
                            },

                            plotOptions: {
                                column: {
                                    pointPadding: 0.2,
                                    borderWidth: 0
                                }
                            },
                            series: [{
                                name: 'Pallet Changeover Time',
                                data: Line1,
                                color: '#02afae'
                            },
                            {
                                name: 'Idle Time',
                                data: Line2,
                                color: '#5188ca'
                            }]
                        });
                    })
                };

                $scope.Export = function () {
                    $scope.selCell = selCell.value;
                    if ($scope.seldatepicker == undefined || $scope.seldatepicker == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Select Period First ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                        return;
                    }
                    if ($scope.seldatepicker == "date") {
                        $scope.Type = "Day";
                        $scope.txtStartDate = document.getElementById("txtDate").value;
                        $scope.txtWeek = 0;
                        $scope.txtMonth = 0;
                        $scope.txtEndDate = "";
                        if ($scope.txtStartDate == "" || $scope.txtStartDate == undefined) {
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.error('Please Select Date ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                            return;
                        }
                    }
                    if ($scope.seldatepicker == "week") {
                        $scope.Type = "Week";
                        var w = document.getElementById("txtWeek").value;
                        $scope.txtWeek = w.substring(6);
                        $scope.txtDate = 0;
                        $scope.txtMonth = 0;
                        $scope.txtStartDate = "";
                        $scope.txtEndDate = "";
                        if ($scope.txtWeek == "" || $scope.txtWeek == undefined) {
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.error('Please Select Week ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                            return;
                        }
                    }
                    if ($scope.seldatepicker == "month") {
                        $scope.Type = "Month";
                        var m = document.getElementById("txtMonth").value;
                        $scope.txtMonth = m.substring(5);
                        $scope.txtDate = 0;
                        $scope.txtWeek = 0;
                        $scope.txtStartDate = "";
                        $scope.txtEndDate = "";
                        if ($scope.txtMonth == "" || $scope.txtMonth == undefined) {
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.error('Please Select Month ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                            return;
                        }
                    }
                    if ($scope.seldatepicker == "dateRange") {
                        $scope.Type = "dateRange";
                        $scope.txtStartDate = document.getElementById("txtStartDate").value;
                        $scope.txtEndDate = document.getElementById("txtEndDate").value;

                        $scope.txtDate = 0;
                        $scope.txtWeek = 0;
                        $scope.txtMonth = 0;

                    }
                    if ($scope.selCell == undefined || $scope.selCell == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Please Select Cell ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                        return;
                    }
                    var httpreq = {
                        method: "POST",
                        url: "ProductivityReport.aspx/Export",
                        data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, Cell: $scope.selCell },
                    }
                    $http(httpreq).success(function (response) {
                        $scope.ExportData = angular.fromJson(response.d);
                        $scope.ArrayExport = $scope.ExportData.Table;
                        console.dir($scope.ArrayExport);

                        if ($scope.ArrayExport == "") {
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                        }
                        else {
                            JSONToCSVConvertor($scope.ArrayExport, "", true);
                        }

                        function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
                            JSONData = angular.copy(JSONData);

                            var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
                            var CSV = '';
                            CSV += ReportTitle + '\r\n\n';
                            if (ShowLabel) {
                                var row = "";
                                for (var index in arrData[0]) {
                                    row += index + ',';
                                }
                                row = row.slice(0, -1);
                                CSV += row + '\r\n';
                            }

                            for (var i = 0; i < arrData.length; i++) {
                                var row = "";
                                for (var index in arrData[i]) {
                                    var txt = arrData[i][index];
                                    if (index == "start" || index == "end") {
                                        var d = new Date(txt);
                                        txt = convertDate(d);
                                    }
                                    row += '"' + txt + '",';
                                }
                                row.slice(0, row.length - 1);
                                CSV += row + '\r\n';
                            }

                            if (CSV == '') {
                                return;
                            }

                            var today = new Date().toJSON().slice(0, 10).replace(/-/g, '/');;
                            var fileName = "Report_ " + today;
                            fileName += ReportTitle.replace(/ /g, "_");
                            var blob = new Blob([CSV], { type: 'text/csv' });

                            if (window.navigator.msSaveOrOpenBlob) {
                                window.navigator.msSaveBlob(blob, fileName);
                            }
                            else {
                                var elem = window.document.createElement('a');
                                elem.href = window.URL.createObjectURL(blob);
                                elem.download = fileName + ".csv";
                                document.body.appendChild(elem);
                                elem.click();
                                document.body.removeChild(elem);
                            }
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.success('Data Exported..!!', 'Grate', { timeOut: 2000, closeButton: true,preventDuplicates:true });
                        }

                    })
                };

            });
        </script>

       

    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="report" ng-app="myApp" ng-controller="myController">
        <div class="top_row">
            <div class="container-fluid">
                <div class="col-md-12" style="background-color: #194a77; color: white; height: 45px; padding-left: 20px; padding-top: 5px;">
                    <div class="row">
                        <div class="col-md-6">
                            <h4 class="main_title"  style="font-family: inherit;">Productivity report</h4>
                        </div>
                        <div class="col-md-6">
                            <div class="text-right exp_btn">
                                <button type="button" class="btn btn-success" ng-click="Export()">
                                    Export
                                    <img src="/Images/export_white.png"></button>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="col-md-12">
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
                                    <div id="bar_chart1"></div>

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
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <script src="../../JS/popper.min.js"></script>
    <script src="../../JS/Highcharts/highcharts.js"></script>
    <script src="../../JS/Highcharts/exporting.js"></script>
    <script src="../../JS/Highcharts/export-data.js"></script>
    <script src="../../JS/Highcharts/accessibility.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            $('#date').hide();
            $('#month').hide();
            $('#week').hide();
            $('#dateRange').hide();
            $('#SKU').hide();
            $('#seldatepicker').change(function () {
                if ($('select[name=DatePicker] option:selected').val() == 'date') {
                    $('#date').show();
                    $('#week').hide();
                    $('#month').hide();
                    $('#dateRange').hide();
                    document.getElementById("txtWeek").value = "";
                    document.getElementById("txtMonth").value = "";
                    document.getElementById("txtStartDate").value = "";
                    document.getElementById("txtEndDate").value = "";
                } else if ($('select[name=DatePicker] option:selected').val() == 'week') {
                    $('#week').show();
                    $('#date').hide();
                    $('#month').hide();
                    $('#dateRange').hide();
                    document.getElementById("txtDate").value = "";
                    document.getElementById("txtMonth").value = "";
                    document.getElementById("txtStartDate").value = "";
                    document.getElementById("txtEndDate").value = "";
                } else if ($('select[name=DatePicker] option:selected').val() == 'month') {
                    $('#month').show();
                    $('#date').hide();
                    $('#week').hide();
                    $('#dateRange').hide();
                    document.getElementById("txtDate").value = "";
                    document.getElementById("txtWeek").value = "";
                    document.getElementById("txtStartDate").value = "";
                    document.getElementById("txtEndDate").value = "";
                }
                else if ($('select[name=DatePicker] option:selected').val() == 'dateRange') {
                    $('#dateRange').show();
                    $('#date').hide();
                    $('#week').hide();
                    $('#month').hide();
                    document.getElementById("txtDate").value = "";
                    document.getElementById("txtWeek").value = "";
                    document.getElementById("txtMonth").value = "";
                }
            });
        });


    </script>


</asp:Content>
