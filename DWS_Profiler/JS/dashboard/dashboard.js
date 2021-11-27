var app = angular.module("myApp", []);
app.controller("myController", function ($scope, $http, $interval) {
    $scope.NoDataDiv = true;
    $scope.Barcode = 0;
    $scope.Weight = 0;
    $scope.Length = 0;
    $scope.Width = 0;
    $scope.Height = 0;
    $scope.Volume = 0;
    $scope.RealVolume = 0;
    $scope.totalCount = 0;

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
        $scope.RefreshList();
        $scope.GetHeartBit();
    };

    $scope.DisplayData = function () {
        var httpreq = {
            method: "POST",
            url: "dashboard.aspx/ShowData",
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'dataType': 'json',

            },
            async: false,

            data: { },
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
            $scope.Hour = $scope.countData.Table2[0].Hour;
            $scope.Minute = $scope.countData.Table2[0].Minute;
            $scope.Second = $scope.countData.Table2[0].Second;
            if ($scope.Hour >= 1) {
                $('#Modal_Notify_Notification').show('slow');
            }
            else {
                $('#Modal_Notify_Notification').hide('slow');
            }
        });
    }

    //************************** function To Refresh List
    $scope.RefreshList = function () {
        var httpreq = {
            method: "POST",
            url: "dashboard.aspx/GetList",
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'dataType': 'json'
            },
            data: {},
        }
        $http(httpreq).success(function (response) {
            
            if (response.d != "") {
                $scope.listData = angular.fromJson(response.d);
                $scope.NoDataDiv = false;
                $('#NoDataDiv').hide();
            }
            else {
                $scope.NoDataDiv = true;
                $('#NoDataDiv').show();
            }
        })
    };
    //******************** End Reset List******************
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
        $("#Modal_Notify_Notification").css("z-index") == "99 !important";
    };

    $scope.GetHeartBit = function () {
        $.ajax({
            type: "POST",
            url: "dashboard.aspx/GetData",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {
                //alert(r.d);
                var jsonData = JSON.parse(r.d);
                var DeviceDataGet = jsonData.Table1;
                var AnnunciationData = jsonData.Table;
                $scope.AnnunciationData = jsonData.Table;
                $scope.AutoStatus = jsonData.Table2[0].AutoStatus;
                $scope.ManualStatus = jsonData.Table3[0].ManualStatus;
                $scope.PLCLAN = jsonData.Table4[0].PLCLAN;
                $scope.CameraLan = jsonData.Table5[0].CameraLan;
                $scope.CheckWeigherLAN = jsonData.Table6[0].CheckWeigherLAN;
                $scope.VMSLAN = jsonData.Table7[0].VMSLAN; 
                $scope.HMILAN = jsonData.Table8[0].HMILAN;
                var DeviceDataList = jsonData.Table2;
                if (DeviceDataGet.length > 0)
                    $scope.HeartBitStatus = 0;
                else
                    $scope.HeartBitStatus = 1;

                if (!showAnnunciationFault)
                    return;

                if ($("#Modal_Notify").css("display") != "none")
                    $('#Modal_Notify').modal('hide');
               // alert(AnnunciationData);
                if (AnnunciationData.length > 0) {
                    $('#IDannounciation').show();
                }
                else {
                    $('#IDannounciation').hide();
                }
            },
            error: function (r) {
                if (r.responseText.indexOf("SessionError" >= 0)) {
                    document.location = "/SessionError.aspx";
                }
            },
            failure: function (r) {
            }
        });
    }
    //******************** Get HeartBeat End******************
    $scope.SearchData = function () {
        if ($scope.txtSearch1 == undefined || $scope.txtSearch1 == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Enter AWB number First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
            return;
        }
        var httpreq = {
            method: "POST",
            url: "dashboard.aspx/SearchBarcodeData",
            data: { Barcode: $scope.txtSearch1},
        }
        $http(httpreq).success(function (response) {
            if (response.d != "") {
                json = JSON.parse(response.d);
                
                var filtered = {};
                $scope.listData2 = angular.fromJson(json);
                $scope.listData1 = $scope.listData2.Table; 
                $scope.searchTotal = $scope.listData2.Table1[0].searchTotal;
                if ($scope.listData1 == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                }
                else {
                    $(".table_data").hide();
                    $("#searchtable").show();
                }
            }
        })
    };
    $scope.Search = function () {
        $("#searchTextBox").show();
        $("#searchbutton").show();
        $("#serachclose").show();
        $("#serachbtn").hide(); 
        $("#tabletitle").hide();
        $("#exportbtn").hide();
        $("#Searchexportbtn").show();
    };
    $scope.close = function () {
        $("#searchTextBox").hide();
        $("#searchbutton").hide();
        $("#serachclose").hide();
        $("#serachbtn").show();
        $(".table_data").show();
        $("#searchtable").hide();
        $("#tabletitle").show();
        $scope.txtSearch1 = "";
        $("#exportbtn").show();
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
            url: "dashboard.aspx/Export",
            data: {  },
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