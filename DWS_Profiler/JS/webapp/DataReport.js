var myApp = angular.module("myApp", ['ui.bootstrap']);
myApp.controller("myController", function ($scope, $http) {
    $scope.NoDataDiv = true;
    $('#all').hide();
    $('.failedtable').hide();
    $('.successtable').hide();
    $scope.Type = "";
    var dateObj = new Date('<%=todayDate%>');
    $scope.Type = dateObj;
    $scope.maxSize = 5;     // Limit number for pagination display number.  
    $scope.totalCount = 0;  // Total number of items in all pages. initialize as a zero  
    $scope.pageIndex = 1;   // Current page number. First page is 1.-->  
    $scope.pageSizeSelected = 10; // Maximum number of items per page.  

    var Line1 = [], Line2 = [], Line3 = [], CSeries = [];

    function time_convert(num) {
        var hours = Math.floor(num / 3600);
        var minutes = num % 60;
        return parseFloat(hours + "." + minutes);
    }
    $scope.GetScanLocationList = function () {
        //alert();
        var httpreq = {
            method: "POST",
            url: "DataReport.aspx/GetScanLocationList",
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
        //alert();
        //$scope.selCell = selCell.value;
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

        $scope.txtStartDate = $scope.txtStartDate.substring(0, 10) + " " + $scope.txtStartDate.substring(11, 16);
        $scope.txtEndDate = $scope.txtEndDate.substring(0, 10) + " " + $scope.txtEndDate.substring(11, 16);

        var httpreq = {
            method: "POST",
            url: "DataReport.aspx/DWSDataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, pageIndex: $scope.pageIndex, pageSize: $scope.pageSizeSelected },
        }
        $http(httpreq).success(function (response) {

            if (response.d != "") {
                json = JSON.parse(response.d);

                var filtered = {}; 
                $('.successtable').hide();
                $('.failedtable').hide();
                $('#all').show();
                $('#1').show();
                $('#2').hide();
                $('#3').hide();
                $('#5').hide();
                $("#searchtable").hide();
                $scope.NoDataDiv = false;
                $scope.listData = angular.fromJson(json);
                $scope.list = $scope.listData.Table;
                $scope.list1 = $scope.listData.Table1;
                $scope.totalCount = $scope.listData.Table1[0].totalCount;
                $scope.Success = $scope.listData.Table2[0].Success;
                $scope.Failed = $scope.listData.Table3[0].Failed;
            }
            else {
                $('#all').hide();
                $('.failedtable').show();
                $scope.NoDataDiv = true;
            }
        })
    };

    $scope.open = function () {
        if ($("#Modal_Notify_announciation").css("display") == "none") {
            $("#Modal_Notify_announciation").modal('show');

            //   $('#IDannounciation').show();
        }
    }

    
    $scope.CalibrationDataSearch = function () {
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

        $scope.txtStartDate = $scope.txtStartDate.substring(0, 10) + " " + $scope.txtStartDate.substring(11, 16);
        $scope.txtEndDate = $scope.txtEndDate.substring(0, 10) + " " + $scope.txtEndDate.substring(11, 16);

        var httpreq = {
            method: "POST",
            url: "DataReport.aspx/CalibrationDataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, pageIndex: $scope.pageIndex, pageSize: $scope.pageSizeSelected },
        }
        $http(httpreq).success(function (response) {

            if (response.d != "") {
                json = JSON.parse(response.d);

                var filtered = {};
                $('.successtable').hide();
                $('#all').hide();
                $('#1').hide();
                $('#2').hide();
                $('#3').hide();
                $('#4').show();
                $('#5').hide();
                $('.failedtable').show();
                $('#failed').hide();
                $('#calibration').show();

                $scope.NoDataDiv = false;
                $scope.listData = angular.fromJson(json);
                $scope.failedlist = $scope.listData.Table;
                $scope.list1 = $scope.listData.Table1;
                $scope.totalCount = $scope.listData.Table1[0].totalCount;
                $scope.Success = $scope.listData.Table2[0].Success;
                $scope.Failed = $scope.listData.Table3[0].Failed;
            }
            else {
                $('#all').show();
                $('.failedtable').hide();

                $scope.NoDataDiv = true;
            }
        })
    };

    $scope.CalibrationExport = function () {
        //alert();
        if ($scope.failedlist == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
        }
        else {
            JSONToCSVConvertor($scope.failedlist, "", true);
        }
    };

    $scope.FaultySearch = function () {
        //alert('Hi');
        //$scope.selCell = selCell.value;
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

        $scope.txtStartDate = $scope.txtStartDate.substring(0, 10) + " " + $scope.txtStartDate.substring(11, 16);
        $scope.txtEndDate = $scope.txtEndDate.substring(0, 10) + " " + $scope.txtEndDate.substring(11, 16);

        var httpreq = {
            method: "POST",
            url: "DataReport.aspx/DWSFailedDataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, pageIndex: $scope.pageIndex, pageSize: $scope.pageSizeSelected },
        }
        $http(httpreq).success(function (response) {

            if (response.d != "") {
                json = JSON.parse(response.d);

                var filtered = {};
                $('.successtable').hide();
                $('#all').hide();
                $('#1').hide();
                $('#2').show();
                $('#3').hide();
                $('#4').hide();
                $('#5').hide();
                $('.failedtable').show();
                $('#failed').show();
                $('#calibration').hide();

                $scope.NoDataDiv = false;
                $scope.listData = angular.fromJson(json);
                $scope.failedlist = $scope.listData.Table;
                $scope.list1 = $scope.listData.Table1;
                //console.dir($scope.list);
                //console.dir($scope.list1);

                $scope.totalCount = $scope.listData.Table1[0].totalCount;
                $scope.Success = $scope.listData.Table2[0].Success;
                $scope.Failed = $scope.listData.Table3[0].Failed;
            }
            else {
                $('#all').show();
                $('.failedtable').hide();
                $scope.NoDataDiv = true;
            }
        })
    };

    $scope.SuccessSearch = function () {
       // alert('success');
        //$scope.selCell = selCell.value;
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

        $scope.txtStartDate = $scope.txtStartDate.substring(0, 10) + " " + $scope.txtStartDate.substring(11, 16);
        $scope.txtEndDate = $scope.txtEndDate.substring(0, 10) + " " + $scope.txtEndDate.substring(11, 16);

        var httpreq = {
            method: "POST",
            url: "DataReport.aspx/DWSSuccessDataSearch",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, pageIndex: $scope.pageIndex, pageSize: $scope.pageSizeSelected },
        }
        $http(httpreq).success(function (response) {

            if (response.d != "") {
                json = JSON.parse(response.d);
               // alert();
                var filtered = {};
                $('#all').hide();
                $('.failedtable').hide();
                $('.successtable').show();
                $('#1').hide();
                $('#2').hide();
                $('#3').show();
                $('#4').hide();
                $('#5').hide();
                $scope.NoDataDiv = false;
                $scope.listData = angular.fromJson(json);
                $scope.successlist = $scope.listData.Table;
                $scope.list2 = $scope.listData.Table1;
                $scope.totalCount = $scope.listData.Table1[0].totalCount;
                $scope.Success = $scope.listData.Table2[0].Success;
                $scope.Failed = $scope.listData.Table3[0].Failed;
            }
            else {
                $('#all').hide();
                $('.failedtable').hide();
                $scope.NoDataDiv = true;
            }
        })
    };

    //Loading employees list on first time  
    //$scope.getEmployeeList();

    //This method is calling from pagination number  
    $scope.pageChanged = function () {
        $scope.Search();
    };

    //This method is calling from dropDown  
    $scope.changePageSize = function () {
        $scope.pageIndex = 1;
        $scope.Search();
    };

    $scope.pageChanged1 = function () {
        $scope.FaultySearch();
    };

    //This method is calling from dropDown  
    $scope.changePageSize1 = function () {
        $scope.pageIndex1 = 1;
        $scope.FaultySearch();
    };

    $scope.pageChanged2 = function () {
        $scope.SuccessSearch();
    };

    //This method is calling from dropDown  
    $scope.changePageSize2 = function () {
        $scope.pageIndex2 = 1;
        $scope.SuccessSearch();
    };

    $scope.SortList = function (orderBy) {
        if ($scope.orderList == orderBy) {
            if ($scope.orderDirection)
                $scope.orderDirection = false;
            else
                $scope.orderDirection = true;
        }
        else {
            $scope.orderList = orderBy;
        }
    }
    $scope.SearchData = function () {
        //alert();
        if ($scope.txtSearch1 == undefined || $scope.txtSearch1 == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Enter AWB number First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
            return;
        }
        var httpreq = {
            method: "POST",
            url: "DataReport.aspx/SearchBarcodeData",
            data: { Barcode: $scope.txtSearch1 },
        }
        $http(httpreq).success(function (response) {

            //alert(response.d);

            if (response.d != "") {
                json = JSON.parse(response.d);

                var filtered = {};
                $scope.listData2 = angular.fromJson(json);
                $scope.listData1 = $scope.listData2.Table;
                $scope.searchTotal = $scope.listData2.Table1[0].searchTotal;
                if ($scope.listData1 == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    $scope.NoDataDiv = false;
                }
                else {
                    $(".table_data").hide();
                    $("#searchtable").show();
                    $scope.NoDataDiv = false;
                    $('.successtable').hide();
                    $('.failedtable').hide();
                    $('#all').hide();
                    $('#4').hide();
                    $('#5').show();
                    $('#1').hide();
                    $('#2').hide();
                    $('#3').hide();
                }

            }
        })
    };

    $scope.Export = function () {
        if ($scope.list == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
        }
        else {
            JSONToCSVConvertor($scope.list, "", true);
        }
    };
    $scope.SearchExport = function () {
        if ($scope.listData1 == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
        }
        else {
            JSONToCSVConvertor($scope.listData1, "", true);
        }
    };

    $scope.FaliedExport = function () {
        if ($scope.failedlist == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
        }
        else {
            JSONToCSVConvertor($scope.failedlist, "", true);
        }
    };

    $scope.SuccessExport = function () {
        if ($scope.successlist == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.info('No Data Found ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
        }
        else {
            JSONToCSVConvertor($scope.successlist, "", true);
        }
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




