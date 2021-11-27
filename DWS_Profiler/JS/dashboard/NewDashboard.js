var app = angular.module("myApp", []);
app.controller("myController", function ($scope, $http, $interval) {
    //alert();
    $scope.NoDataDiv = true;
    $scope.NoPerHourShipment = true;
    $scope.Barcode = 000;
    $scope.Weight = 0;
    $scope.Length = 0;
    $scope.Width = 0;
    $scope.Height = 0;
    $scope.Volume = 0;
    $scope.RealVolume = 0;
    $scope.totalCount = 0;
    $scope.AlertImagePath = "../../Images/notification_icon.png";

    $scope.StartTimer = function () {
        $scope.Timer = $interval(function () {
            $scope.DoTimerAction();
        }, 1000);
    };
    $scope.StopTimer = function () {
        $scope.Message = "Timer stopped.";
        if (angular.isDefined($scope.Timer)) {
            $interval.cancel($scope.Timer);
        }
    };
    $scope.DoTimerAction = function () {
        //alert();
        $scope.DisplayData();
        //$scope.SearchPerHourShipment();
    };

    $scope.DisplayData = function () {
        var httpreq = {
            method: "POST",
            url: "NewDashboard.aspx/DashboardData",
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'dataType': 'json',

            },
            async: false,

            data: {},
        }
        $http(httpreq).success(function (response) {
            $scope.countData = angular.fromJson(response.d);
            $scope.Barcode = $scope.countData.Table[0].Barcode;
            $scope.Weight = $scope.countData.Table[0].Weight;
            $scope.Length = $scope.countData.Table[0].Length;
            $scope.Width = $scope.countData.Table[0].Width;
            $scope.Height = $scope.countData.Table[0].Height;
            $scope.Volume = $scope.countData.Table[0].Volume;
            $scope.RealVolume = $scope.countData.Table[0].RealVolume;
            $scope.totalCount = $scope.countData.Table1[0].totalCount;
            $scope.Day = $scope.countData.Table2[0].Day;
            $scope.Hour1 = $scope.countData.Table2[0].Hour;
            $scope.Minute = $scope.countData.Table2[0].Minute;
            $scope.Second = $scope.countData.Table2[0].Second;
           
            if ($scope.countData.Table3.length > 0) {
                $scope.toplistData = $scope.countData.Table3;
                $scope.NoDataDiv = false;
                $('#NoDataDiv').hide();
            }
            else {
                $('#NoDataDiv').show();
                $scope.NoDataDiv = true;
                $scope.toplistData = "";
            }
            if ($scope.countData.Table4.length < 1) {
                $('#NoAlarm').show();
                $scope.AlarmList = "";
            }
            else {
                $scope.AlarmList = $scope.countData.Table4;
                $('#NoAlarm').hide();
                
            }
            if ($scope.countData.Table5.length > 0) {
                $scope.auto = $scope.countData.Table5[0].auto;
                $scope.manual = $scope.countData.Table5[0].manual;
                $scope.PLCLAN = $scope.countData.Table5[0].PLCLAN;
                $scope.CameraLan = $scope.countData.Table5[0].CameraLan;
                $scope.CheckWeigherLAN = $scope.countData.Table5[0].CheckWeigherLAN;
                $scope.VMSLAN = $scope.countData.Table5[0].VMSLAN;
                $scope.HMILAN = $scope.countData.Table5[0].HMILAN;
                $scope.DataSentCount = $scope.countData.Table5[0].DataSentCount;
                $scope.ImageSentCount = $scope.countData.Table5[0].ImageSentCount; 
                $scope.ActiveFaultCount = $scope.countData.Table5[0].ActiveFaultCount;
            }
            if ($scope.countData.Table6.length > 0) {
                $scope.Hour = $scope.countData.Table6;
                if ($scope.Hour.length >= 1) {
                    $('#PerHourShipment').show();
                    $scope.NoPerHourShipment = false;
                    $scope.ChartSeries = $scope.countData.Table7;

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
                Highcharts.chart('container', {
                    chart: {
                        type: 'column',
                        backgroundColor: '#f5f5f5',
                        options3d: {
                            enabled: true,
                            alpha: 5,
                            beta: 0,
                            depth: 70
                        }
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: null
                    },
                    subtitle: {
                        text: 'Todays hour-wise shipment count'
                    },
                    plotOptions: {
                        column: {
                            depth: 25,
                        }
                    },
                    xAxis: {
                        categories: ['12-1 am', '1-2 am', '2-3 am', '3-4 am', '4-5 am', '5-6 am', '6-7 am', '7-8 am', '8-9 am', '9-10 am', '10-11 am', '11-12 am', '12-1 pm', '1-2 pm', '2-3 pm', '3-4 pm', '4-5 pm', '5-6 pm', '6-7 pm', '7-8 pm', '8-9 pm', '9-10 pm', '10-11 pm', '11-12 pm'],
                        labels: {
                            padding: 0,
                            skew3d: true,
                            style: {
                                fontSize: '9px'
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: null
                        }
                    },
                    series: [{
                        name: 'Hour range',
                        animation: false,
                        data: Hour,
                        colorByPoint: false
                    }]
                });
            }
        });
    }

    
    $("#menubar").click(function () {
        $(".top-action-wrap").addClass("active");
    });

    $(".body_wrap").click(function () {
        $(".top-action-wrap").removeClass("active");
    });

    //******************** Get HeartBeat Start******************
    $scope.open = function () {
        if ($("#Modal_Notify_announciation").css("display") == "none") {
            $("#Modal_Notify_announciation").modal('show');
        }
    }

    $scope.showData = function (Barcode, Length, Width, Height, Weight, Volume, RealVolume, PackageType, IsSend, ReasonForFailed, Timestamp) {
        if ($("#Modal_Barcode_details").css("display") == "none") {
            $("#Modal_Barcode_details").modal('show');
        }
        $scope.txtAWB = Barcode;
        $scope.txtLength = Length;
        $scope.txtWidth = Width;
        $scope.txtHeight = Height;
        $scope.txtWeight = Weight;
        $scope.txtVolume = Volume;
        $scope.txtReal = RealVolume;
        $scope.txtPackage = PackageType;
        $scope.txtData = IsSend;
        $scope.txtFailed = ReasonForFailed;
        $scope.txtDatetime = Timestamp;
    };

    //******************** Get HeartBeat End******************
    $scope.SearchData = function () {
        if ($scope.txtSearch1 == undefined || $scope.txtSearch1 == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Enter AWB number First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
            return;
        }
        var httpreq = {
            method: "POST",
            url: "NewDashboard.aspx/SearchBarcodeData",
            data: { Barcode: $scope.txtSearch1 },
        }
        $http(httpreq).success(function (response) {
            if (response.d != "") {
                json = JSON.parse(response.d);

                var filtered = {};
                $scope.listData2 = angular.fromJson(json);
                $scope.listData1 = $scope.listData2.Table;
                $scope.searchTotal = $scope.listData2.Table1[0].searchTotal;
                //alert($scope.listData1);
                if ($scope.listData1 == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                }
                else {
                   // alert();
                    $(".table_data").hide();
                    $("#searchtable").show();
                    $("#exportbtn1").hide();
                    $("#Searchexportbtn").show();
                }
            }
        })
    };

    $scope.close = function () {
        $(".table_data").show();
        $("#searchtable").hide();
        $("#tabletitle").show();
        $scope.txtSearch1 = "";
        $("#exportbtn1").show();
        $("#Searchexportbtn").hide();
    };

    //******************** Export Start******************
    $scope.SearchExport = function () {
        if ($scope.listData1 == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
        }
        else {
            JSONToCSVConvertor($scope.listData1, "", true);
        }
    };


    $scope.Export = function () {
        var httpreq = {
            method: "POST",
            url: "NewDashboard.aspx/Export",
            data: {},
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
    //******************** Export End******************
})

function tog(v) { return v ? "addClass" : "removeClass"; }
$(document).on("input", ".clearable", function () {
    $(this)[tog(this.value)]("x");
}).on("mousemove", ".x", function (e) {
    $(this)[tog(this.offsetWidth - 18 < e.clientX - this.getBoundingClientRect().left)]("onX");
}).on("touchstart click", ".onX", function (ev) {
    ev.preventDefault();
    $(this).removeClass("x onX").val("").change();
});