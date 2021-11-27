var myApp = angular.module("myApp", []);
myApp.controller("myController", function ($scope, $http) {
    $scope.NoDataDiv1 = true;
    $scope.NoDataDiv = true;
    $scope.Type = "";
    $scope.FinalTotalTime = "00: 00: 00";
    var Line1 = [], Line2 = [], Line3 = [], CSeries = [], jsonData = [];

    function time_convert(num) {
        var hours = Math.floor(num / 3600);
        var minutes = num % 60;
        return parseFloat(hours + "." + minutes);
    }
    $scope.GetScanLocationList = function () {
        //alert();
        var httpreq = {
            method: "POST",
            url: "ProductionAnalysis.aspx/GetScanLocationList",
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'dataType': 'json'
            },
            data: {},
        }
        $http(httpreq).success(function (response) {
            $scope.GetScanLocation = angular.fromJson(response.d);
            $scope.GetScanLocationList = $scope.GetScanLocation.Table[0].Center_Name;

            //alert($scope.GetScanLocationList);
        })
    };
    $scope.Search = function () {
        $scope.DisplayData();
        $scope.selCell = selCell.value;
        if ($scope.seldatepicker == undefined || $scope.seldatepicker == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Select Period First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
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
                toastr.error('Please Select Date ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
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
                toastr.error('Please Select Week ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
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
                toastr.error('Please Select Month ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
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
            if ($scope.txtStartDate > $scope.txtEndDate) {
                toastr.options.positionClass = 'toast-top-center';
                toastr.error('start Date is must be lesser then end date..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                return;
            }
            else if ($scope.txtStartDate == undefined || $scope.txtStartDate == "" || $scope.txtEndDate == undefined || $scope.txtEndDate == "") {
                toastr.options.positionClass = 'toast-top-center';
                toastr.error('Please Select StartDate and EndDate ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                return;
            }
        }
        if ($scope.selCell == undefined || $scope.selCell == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Please Select Cell ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
            return;
        }
        $scope.txtStartDate = $scope.txtStartDate.substring(0, 10) + " " + $scope.txtStartDate.substring(11, 16);
        $scope.txtEndDate = $scope.txtEndDate.substring(0, 10) + " " + $scope.txtEndDate.substring(11, 16);

        var httpreq = {
            method: "POST",
            url: "ProductionAnalysis.aspx/DataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, Cell: $scope.selCell },
        }
        $http(httpreq).success(function (response) {
            $scope.SearchFaults();
            $("#production").show();
            $scope.Reasonwise = angular.fromJson(response.d);
            $scope.Line1 = $scope.Reasonwise.Table;
            $scope.Totalcount = $scope.Reasonwise.Table1[0].Totalcount;
            if ($scope.Line1.length > 0) {
                $scope.NoDataDiv = false;
                $('#DivHighchart').show();
                Line1 = [], Line2 = [], Line3 = [], CSeries = [], jsonData = [];
                for (var i = 0; i < $scope.Line1.length; i++) {
                    Line1.push($scope.Line1[i].IdleReason);
                    data = {
                        name: $scope.Line1[i].IdleReason, /*chartSeries[i]*/
                        y: $scope.Line1[i].InsertedOn
                    };
                    jsonData.push(data);

                }
            }
            else {
                $scope.NoDataDiv = true;
                $('#DivHighchart').hide();

            }
            //// Radialize the colors
            //Highcharts.setOptions({
            //    colors: Highcharts.map(Highcharts.getOptions().colors, function (color) {
            //        return {
            //            radialGradient: {
            //                cx: 0.5,
            //                cy: 0.3,
            //                r: 0.7
            //            },
            //            stops: [
            //                [0, color],
            //                [1, Highcharts.color(color).brighten(-0.3).get()] // darken
            //            ]
            //        };
            //    })
            //});


            Highcharts.chart('pie_chart', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie',
                    backgroundColor: ''
                },
                legend: {
                    align: 'center',
                    verticalAlign: 'bottom',
                    x: 0,
                    y: 0

                },

                title: {
                    text: 'Production Analysis'
                },
                exporting: {
                    buttons: {
                        contextButton: {
                            menuItems: [
                                'downloadPNG',
                                'downloadJPEG',
                                'downloadPDF',

                            ],

                        },

                    }
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                accessibility: {
                    point: {
                        valueSuffix: '%'
                    }
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: false,
                        cursor: 'pointer',
                        colors: ['#ff5c33', '#6AF9C4', '#aaff80', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
                        dataLabels: {
                            enabled: false,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                        }
                    }

                },
                series: [{
                    showInLegend: true,
                    name: 'Number of AWB',
                    colorByPoint: true,
                    data: jsonData
                }]
            });

        })
    };

    $scope.SearchFaults = function () {
        $scope.txtStartDate = $scope.txtStartDate.substring(0, 10) + " " + $scope.txtStartDate.substring(11, 16);
        $scope.txtEndDate = $scope.txtEndDate.substring(0, 10) + " " + $scope.txtEndDate.substring(11, 16);

        var httpreq = {
            method: "POST",
            url: "ProductionAnalysis.aspx/FalultSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, Cell: $scope.selCell },
        }
        $http(httpreq).success(function (response) {

            $scope.Reasonwise = angular.fromJson(response.d);
            $scope.fault = $scope.Reasonwise.Table;
            $scope.Totaltime = $scope.Reasonwise.Table1[0].Totaltime;
            var date = new Date(null);
            date.setSeconds($scope.Totaltime); // specify value for SECONDS here
            var result = date.toISOString().substr(11, 8);
            $scope.FinalTotalTime = result;
            //alert($scope.FinalTotalTime);
            if ($scope.fault.length > 0) {
                $scope.NoDataDiv1 = false;
                $('#DivHighchart1').show();
                fault = [], Line2 = [], Line3 = [], CSeries = [], jsonData = [];
                for (var i = 0; i < $scope.fault.length; i++) {
                    fault.push($scope.fault[i].FaultName);
                    data = {
                        name: $scope.fault[i].FaultName, /*chartSeries[i]*/
                        y: $scope.fault[i].InsertedOn
                    };
                    jsonData.push(data);

                }
            }
            else {
                $scope.NoDataDiv1 = true;
                $('#DivHighchart1').hide();

            }


            Highcharts.chart('pie_chart1', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie',
                    backgroundColor: ''
                },
                legend: {
                    align: 'center',
                    verticalAlign: 'bottom',
                    x: 0,
                    y: 0

                },

                title: {
                    text: 'System Alerts Analysis'
                },
                exporting: {
                    buttons: {
                        contextButton: {
                            menuItems: [
                                'downloadPNG',
                                'downloadJPEG',
                                'downloadPDF',

                            ],

                        },

                    }
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                accessibility: {
                    point: {
                        valueSuffix: '%'
                    }
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        colors: ["#7cb5ec", "#434348", "#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354", "#2b908f", "#f45b5b", "#91e8e1"],
                        dataLabels: {
                            enabled: false,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                        }
                    }
                },
                series: [{
                    showInLegend: true,
                    name: 'Time',
                    colorByPoint: true,
                    data: jsonData
                }]
            });

        })
    };

    $scope.DisplayData = function () {
        //$scope.Date = new Date();

        var httpreq = {
            method: "POST",
            url: "ProductionAnalysis.aspx/ShowData",
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'dataType': 'json',

            },
            async: false,

            data: {},
        }
        $http(httpreq).success(function (response) {
            $scope.countData = angular.fromJson(response.d);
            //console.dir($scope.countData);
            $scope.Datalist = $scope.countData.Table;
            $scope.TotalVolume = $scope.countData.Table1[0].totalVolume;

        });
    }

    $scope.Export = function () {
        $scope.selCell = selCell.value;
        if ($scope.seldatepicker == undefined || $scope.seldatepicker == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Select Period First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
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
                toastr.error('Please Select Date ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
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
                toastr.error('Please Select Week ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
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
                toastr.error('Please Select Month ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
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
            if ($scope.txtStartDate > $scope.txtEndDate) {
                toastr.options.positionClass = 'toast-top-center';
                toastr.error('start Date is must be lesser then end date..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                return;
            }

        }
        if ($scope.selCell == undefined || $scope.selCell == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Please Select Cell ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
            return;
        }
        var httpreq = {
            method: "POST",
            url: "ProductionAnalysis.aspx/Export",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, Cell: $scope.selCell },
        }
        $http(httpreq).success(function (response) {
            $scope.ExportData = angular.fromJson(response.d);
            $scope.ArrayExport = $scope.ExportData.Table;
            if ($scope.ArrayExport == "") {
                toastr.options.positionClass = 'toast-top-center';
                toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
            }
            else {
                JSONToCSVConvertor($scope.ArrayExport, "", true);
            }



        })
    };

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
        toastr.success('Data Exported..!!', 'Great', { timeOut: 2000, closeButton: true, preventDuplicates: true });
    }
    $(document).ready(function () {
        $scope.GetScanLocationList();
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
});

