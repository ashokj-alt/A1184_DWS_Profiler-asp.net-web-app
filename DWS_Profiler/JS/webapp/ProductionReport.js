var myApp = angular.module("myApp", []);
myApp.controller("myController", function ($scope, $http) {
    //alert();
    $scope.NoDataDiv1 = true;
    $scope.NoDataDiv = true;
    $scope.NoDataDivLength = true;
    $scope.NoDataDivWeight = true;
    $scope.NoDataDivWidth = true;
    $scope.NoDataDivHeight = true;
    $scope.NoDataDivLBH = true;
    $scope.NoPerHourShipment = true;
    var Line1 = [], Line2 = [], Line3 = [], CSeries = [];

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
            url: "ProductionReport.aspx/DataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate },
        }
        $http(httpreq).success(function (response) {
            $scope.TotalProduction = angular.fromJson(response.d);
            $scope.Line1 = $scope.TotalProduction.Table;
            $scope.SearchPakegeType();
            $scope.SearchLengthWise();
            $scope.SearchWeightWise();
            $scope.SearchWidthWise();
            $scope.SearchHeightWise();
            $scope.SearchPerHourShipment();
            $scope.SearchLBHBar();
            //$scope.Line2 = $scope.TotalProduction.Table1;
            //$scope.Line3 = $scope.TotalProduction.Table2;
            if ($scope.Line1.length >= 1) {
                $('#DivHighchart').show();
                $scope.NoDataDiv = false;
                $scope.ChartSeries = $scope.TotalProduction.Table1;

                Line1 = [], CSeries = [];
                for (var i = 0; i < $scope.Line1.length; i++) {
                    Line1.push($scope.Line1[i].PalletCount);
                }
                for (var i = 0; i < $scope.ChartSeries.length; i++) {
                    CSeries.push($scope.ChartSeries[i].InsertedOn);
                }
            }
            else {
                $('#DivHighchart').hide();
                $scope.NoDataDiv = true;
            }
            Highcharts.chart('bar_chart', {
                chart: {
                    type: 'column',
                    backgroundColor: ''
                },

                title: {
                    text: 'DayWise AWB Count'
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
                        text: 'Shipment Count'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:f} Shipment</b></td></tr>',
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
                    name: 'Shipment Date',
                    data: Line1,
                    colorByPoint: true
                }]
            });
        })
    };

    $scope.SearchPakegeType = function () {

        var httpreq = {
            method: "POST",
            url: "ProductionReport.aspx/PakegeTypeDataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate },
        }
        $http(httpreq).success(function (response) {
            $scope.TotalProduction = angular.fromJson(response.d);
            $scope.PakageType = $scope.TotalProduction.Table;
            //$scope.Line2 = $scope.TotalProduction.Table1;
            //$scope.Line3 = $scope.TotalProduction.Table2;
            if ($scope.PakageType.length >= 1) {
                $('#DivHighchart1').show();
                $scope.NoDataDiv1 = false;
                $scope.ChartSeries = $scope.TotalProduction.Table1;

                PakageType = [], CSeries = [];
                for (var i = 0; i < $scope.PakageType.length; i++) {
                    PakageType.push($scope.PakageType[i].PackageTypeCount);
                }
                for (var i = 0; i < $scope.ChartSeries.length; i++) {
                    CSeries.push($scope.ChartSeries[i].PackageType);
                }
            }
            else {
                $('#DivHighchart1').hide();
                $scope.NoDataDiv1 = true;
            }
            Highcharts.chart('bar_chart1', {
                chart: {
                    type: 'column',
                    backgroundColor: ''
                },

                title: {
                    text: 'Package TypeWise AWB Count'
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
                    categories: ['Box', 'Non Box'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'AWB Count'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:f} Shipment</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },

                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        colors: ['#ff5c33', '#aaff80', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],

                    }
                },
                series: [{
                    name: 'Package Type',
                    data: PakageType,
                    colorByPoint: true
                    //color: '#02afae'
                    //}, {
                    //    name: 'Line 2',
                    //    data: Line2,
                    //    color: '#5188ca'
                    //}, {
                    //    name: 'Line 3',
                    //    data: Line3,
                    //    color: '#5361b5'
                }]
            });
        })
    };

    $scope.SearchLengthWise = function () {

        var httpreq = {
            method: "POST",
            url: "ProductionReport.aspx/LengthWiseDataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate },
        }
        $http(httpreq).success(function (response) {
            $scope.TotalProduction = angular.fromJson(response.d);
            $scope.LengthRange = $scope.TotalProduction.Table;
            if ($scope.LengthRange.length >= 1) {
                $('#DivHighchartLength').show();
                $scope.NoDataDivLength = false;
                $scope.ChartSeries = $scope.TotalProduction.Table1;

                LengthRange = [], CSeries = [];
                for (var i = 0; i < $scope.LengthRange.length; i++) {
                    LengthRange.push($scope.LengthRange[i].shipmentCount);
                }
                for (var i = 0; i < $scope.ChartSeries.length; i++) {
                    CSeries.push($scope.ChartSeries[i].LengthRange);
                }
            }
            else {
                $('#DivHighchartLength').hide();
                $scope.NoDataDivLength = true;
            }
            Highcharts.chart('bar_chartLength', {
                chart: {
                    type: 'column',
                    backgroundColor: ''
                },

                title: {
                    text: 'LengthWise AWBCount'
                },
                subtitle: {
                    text: ''
                },
                xAxis: {
                    categories: ['0mm - 100mm', '100mm - 200mm', '200mm - 300mm', '300mm - 400mm', '400mm - 500mm', '500mm - 600mm', '600mm - 700mm', '700mm - 800mm', '800mm - 900mm'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'AWB Count'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:f} Shipment</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },

                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        colors: ['#ff5c33', '#aaff80', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],

                    }
                },
                series: [{
                    name: 'Length Range (mm)',
                    data: LengthRange,
                    colorByPoint: true
                }]
            });
        })
    };

    $scope.SearchWidthWise = function () {

        var httpreq = {
            method: "POST",
            url: "ProductionReport.aspx/WidthWiseDataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate },
        }
        $http(httpreq).success(function (response) {
            $scope.TotalProduction = angular.fromJson(response.d);
            $scope.WidthRange = $scope.TotalProduction.Table;
            if ($scope.WidthRange.length >= 1) {
                $('#DivHighchartWidth').show();
                $scope.NoDataDivWidth = false;
                $scope.ChartSeries = $scope.TotalProduction.Table1;

                WidthRange = [], CSeries = [];
                for (var i = 0; i < $scope.WidthRange.length; i++) {
                    WidthRange.push($scope.WidthRange[i].shipmentCount);
                }
                for (var i = 0; i < $scope.ChartSeries.length; i++) {
                    CSeries.push($scope.ChartSeries[i].WidthRange);
                }
            }
            else {
                $('#DivHighcharWidth').hide();
                $scope.NoDataDivWidth = true;
            }
            Highcharts.chart('bar_chartWidth', {
                chart: {
                    type: 'column',
                    backgroundColor: ''
                },

                title: {
                    text: 'WidthWise AWB Count'
                },
                subtitle: {
                    text: ''
                },
                xAxis: {
                    categories: ['0mm - 100mm', '100mm - 200mm', '200mm - 300mm', '300mm - 400mm', '400mm - 500mm', '500mm - 600mm', '600mm - 700mm', '700mm - 800mm', '800mm - 900mm'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'AWB Count'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:f} Shipment</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },

                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        colors: ['#ff5c33', '#aaff80', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],

                    }
                },
                series: [{
                    name: 'Width Range (mm)',
                    data: WidthRange,
                    colorByPoint: true
                }]
            });
        })
    };

    $scope.SearchHeightWise = function () {

        var httpreq = {
            method: "POST",
            url: "ProductionReport.aspx/HeightWiseDataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate },
        }
        $http(httpreq).success(function (response) {
            $scope.TotalProduction = angular.fromJson(response.d);
            $scope.HeightRange = $scope.TotalProduction.Table;
            if ($scope.HeightRange.length >= 1) {
                $('#DivHighchartHeight').show();
                $scope.NoDataDivHeight = false;
                $scope.ChartSeries = $scope.TotalProduction.Table1;

                HeightRange = [], CSeries = [];
                for (var i = 0; i < $scope.HeightRange.length; i++) {
                    HeightRange.push($scope.HeightRange[i].shipmentCount);
                }
                for (var i = 0; i < $scope.ChartSeries.length; i++) {
                    CSeries.push($scope.ChartSeries[i].HeightRange);
                }
            }
            else {
                $('#DivHighcharHeight').hide();
                $scope.NoDataDivHeight = true;
            }
            Highcharts.chart('bar_chartHeight', {
                chart: {
                    type: 'column',
                    backgroundColor: ''
                },

                title: {
                    text: 'HeightWise AWB Count'
                },
                subtitle: {
                    text: ''
                },
                xAxis: {
                    categories: ['0mm - 100mm', '100mm - 200mm', '200mm - 300mm', '300mm - 400mm', '400mm - 500mm', '500mm - 600mm', '600mm - 700mm', '700mm - 800mm', '800mm - 900mm'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'AWB Count'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:f} Shipment</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },

                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        colors: ['#ff5c33', '#aaff80', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],

                    }
                },
                series: [{
                    name: 'Height Range (mm)',
                    data: HeightRange,
                    colorByPoint: true
                }]
            });
        })
    };

    $scope.SearchWeightWise = function () {

        var httpreq = {
            method: "POST",
            url: "ProductionReport.aspx/WeightWiseDataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate },
        }
        $http(httpreq).success(function (response) {
            $scope.TotalProduction = angular.fromJson(response.d);
            $scope.WeightRange = $scope.TotalProduction.Table;
            if ($scope.WeightRange.length >= 1) {
                $('#DivHighchartWeight').show();
                $scope.NoDataDivWeight = false;
                $scope.ChartSeries = $scope.TotalProduction.Table1;

                WeightRange = [], CSeries = [];
                for (var i = 0; i < $scope.WeightRange.length; i++) {
                    WeightRange.push($scope.WeightRange[i].shipmentCount);
                }
                for (var i = 0; i < $scope.ChartSeries.length; i++) {
                    CSeries.push($scope.ChartSeries[i].WeightRange);
                }
            }
            else {
                $('#DivHighcharWeight').hide();
                $scope.NoDataDivWeight = true;
            }
            Highcharts.chart('bar_chartWeight', {
                chart: {
                    type: 'column',
                    backgroundColor: ''
                },

                title: {
                    text: 'WeightWise AWB Count'
                },
                subtitle: {
                    text: ''
                },
                xAxis: {
                    categories: ['200g - 1500g', '1500g - 3000g', '3000g - 4500g', '4500g - 6000g', '6000g - 7500g', '7500g - 9000g', '9000g - 10500g', '10500g - 12000g', '12000g - 13500g', '13500g - 15000g', '15000g - 16500g', '16500g - 18000g', '18000g - 19500g', '19500g - 21000g', '21000g - 22500g', '22500g - 24000g', '24000g - 25500g', '25500g - 27000g', '27000g - 28500g', '28500g - 30000g', '30000g - 31500g', '31500g - 33000g', '33000g - 34500g', '34500g - 36000g', '36000g - 37500g', '37500g - 39000g', '39000g - 40500g', '40500g - 42000g', '42000g - 43500g', '43500g - 45000g', '45000g - 46500g', '46500g - 48000g', '48000g - 50000g'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'AWB Count'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:f} Shipment</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },

                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        colors: ['#ff5c33', '#aaff80', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],

                    }
                },
                series: [{
                    name: 'Weight Range (g)',
                    data: WeightRange,
                    colorByPoint: true

                }]
            });
        })
    };

    $scope.SearchLBHBar = function () {


        var httpreq = {
            method: "POST",
            url: "ProductionReport.aspx/SearchLBHBar",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate },
        }
        $http(httpreq).success(function (response) {
            $scope.TotalProduction = angular.fromJson(response.d);
            $scope.Line1 = $scope.TotalProduction.Table;
            $scope.Line2 = $scope.TotalProduction.Table1;
            $scope.Line3 = $scope.TotalProduction.Table2;
            if ($scope.Line1.length >= 1 || $scope.Line2.length >= 1 || $scope.Line3.length >= 1) {
                $('#DivHighchartLBH').show();
                $scope.NoDataDivLBH = false;
                //$scope.ChartSeries = $scope.TotalProduction.Table3;

                Line1 = [], Line2 = [], Line3 = [], CSeries = [];
                for (var i = 0; i < $scope.Line1.length; i++) {
                    Line1.push($scope.Line1[i].shipmentCount);
                }
                for (var i = 0; i < $scope.Line2.length; i++) {
                    Line2.push($scope.Line2[i].shipmentCount);
                }
                for (var i = 0; i < $scope.Line3.length; i++) {
                    Line3.push($scope.Line3[i].shipmentCount);
                }
                //for (var i = 0; i < $scope.ChartSeries.length; i++) {
                //    CSeries.push($scope.ChartSeries[i].InsertedOn);
                //}
            }
            else {
                $('#DivHighchartLBH').hide();
                $scope.NoDataDivLBH = true;
            }
            Highcharts.chart('bar_chartLBH', {
                chart: {
                    type: 'column',
                    backgroundColor: ''
                },
                title: {
                    text: 'LBHWise AWB Count'
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
                    categories: ['0mm - 100mm', '100mm - 200mm', '200mm - 300mm', '300mm - 400mm', '400mm - 500mm', '500mm - 600mm', '600mm - 700mm', '700mm - 800mm', '800mm - 900mm'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'AWB Count'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:f} Shipment</b></td></tr>',
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
                    name: 'Length(mm)',
                    data: Line1,
                    color: '#02afae'
                }, {
                    name: 'Width(mm)',
                    data: Line2,
                    color: '#5188ca'
                }, {
                    name: 'Height(mm)',
                    data: Line3,
                    color: '#5361b5'
                }]
            });
        })
    };

    $scope.Export = function () {
        $scope.selCell = selCell.value;
        if (SKUWise.checked == true) {
            $scope.SKUName = document.getElementById("SKUName").value;
            $scope.ReportType = "SKUWise";
        }
        else {
            $scope.SKUName = "Total";
            $scope.ReportType = "Total";
        }

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
        if ($scope.SKUName == undefined || $scope.SKUName == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Please Select SKU ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
            return;
        }
        var httpreq = {
            method: "POST",
            url: "ProductionReport.aspx/Export",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, Cell: $scope.selCell, SKU: $scope.SKUName, ReportType: $scope.ReportType },
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

    $scope.getSKUList = function () {
        var cell_no = document.getElementById("selCell").value;
        //alert(cell_no);
        var httpreq = {
            method: "POST",
            url: "ProductionReport.aspx/getSKUList",
            data: { Cell_No: cell_no },
        }
        $http(httpreq).success(function (response) {
            $scope.TotalProduction = angular.fromJson(response.d);
            $scope.SKUList = $scope.TotalProduction.Table;
        })
    };

    $scope.SearchPerHourShipment = function () {

        var httpreq = {
            method: "POST",
            url: "ProductionReport.aspx/SearchPerHourShipment",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, Cell: $scope.selCell, SKU: $scope.SKUName, ReportType: $scope.ReportType },
        }
        $http(httpreq).success(function (response) {
            $scope.TotalProduction = angular.fromJson(response.d);
            $scope.Hour = $scope.TotalProduction.Table;
            if ($scope.Hour.length >= 1) {
                $('#PerHourShipment').show();
                $scope.NoPerHourShipment = false;
                $scope.ChartSeries = $scope.TotalProduction.Table1;

                Hour = [], CSeries = [];
                for (var i = 0; i < $scope.Hour.length; i++) {
                    Hour.push($scope.Hour[i].no_off_Shipment);
                }
                for (var i = 0; i < $scope.ChartSeries.length; i++) {
                    CSeries.push($scope.ChartSeries[i].Hour);
                }
            }
            else {
                $('#PerHourShipment').hide();
                $scope.NoPerHourShipment = true;
            }
            Highcharts.chart('LineChart', {
                chart: {
                    type: 'column',
                    backgroundColor: ''
                },

                title: {
                    text: 'HourWise AWB Count'
                },
                subtitle: {
                    text: ''
                },
                xAxis: {
                    categories: ['12-1 am', '1-2 am', '2-3 am', '3-4 am', '4-5 am', '5-6 am', '6-7 am', '7-8 am', '8-9 am', '9-10 am', '10-11 am', '11-12 am', '12-1 pm', '1-2 pm', '2-3 pm', '3-4 pm', '4-5 pm', '5-6 pm', '6-7 pm', '7-8 pm', '8-9 pm', '9-10 pm', '10-11 pm', '11-12 pm'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'AWB Count'
                    }
                },
                tooltip: {
                    outside: true,
                    split: false,
                    shared: true,
                    useHTML: true,
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:f} Shipment</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },

                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        colors: ['#ff5c33', '#aaff80', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],

                    }
                },
                series: [{
                    type: 'spline',
                    name: 'Hour',
                    data: Hour,
                    colorByPoint: true

                }]
            });
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
        toastr.success('Data Exported..!!', 'Grate', { timeOut: 2000, closeButton: true, preventDuplicates: true });
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
        $('#SKUWise').change(function () {
            $('#SKU').show();
            document.getElementById("SKUName").value = "";
        });
        $('#Total').change(function () {
            $('#SKU').hide();
        });
    });
});


