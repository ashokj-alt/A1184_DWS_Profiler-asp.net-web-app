var app = angular.module("myApp", []);
app.controller("myController", function ($scope, $http, $interval) {
    $scope.maxSize = 5;     // Limit number for pagination display number.  
    $scope.totalCount = 0;  // Total number of items in all pages. initialize as a zero  
    $scope.pageIndex = 1;   // Current page number. First page is 1.-->  
    $scope.pageSizeSelected = 10; // Maximum number of items per page. 
    $scope.FinalTotalTime = "00: 00: 00";
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
        $scope.DisplayFault();
        $scope.RefreshList();
    };

    $scope.DisplayFault = function () {

        var httpreq = {
            method: "POST",
            url: "faultscreen.aspx/ShowFault",
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'dataType': 'json',

            },
            async: false,

            data: {},
        }
        $http(httpreq).success(function (response) {

            $scope.countData = angular.fromJson(response.d);
            //alert($scope.countData);
            $scope.totalActiveFault = $scope.countData.Table1[0].totalActiveFault;
            //alert($scope.totalActiveFault);
            if ($scope.totalActiveFault == 0) {

                $('#active').hide();
                $('#inactive').show();
            }
            else {
                $('#active').show();
                $('#inactive').hide();
            }

        });
    }

    $scope.RefreshList = function () {
        //alert();
        var httpreq = {
            method: "POST",
            url: "faultscreen.aspx/GetFault",
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'dataType': 'json'
            },
            data: {},
        }
        $http(httpreq).success(function (response) {
            $scope.listData = angular.fromJson(response.d);

            //alert($scope.listData);
        })
    };

    $scope.GetScanLocationList = function () {
        //alert();
        var httpreq = {
            method: "POST",
            url: "faultscreen.aspx/GetScanLocationList",
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

    $scope.open = function (faults_ID) {
        //alert(faults_ID);
        var httpreq = {
            method: "POST",
            url: "faultscreen.aspx/open_Rectification_Action",
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'dataType': 'json'
            },
            data: { faults_ID },
        }
        $http(httpreq).success(function (response) {
            $scope.Rectification_Action = angular.fromJson(response.d);

            //$scope.FaultName = $scope.Rectification_Action.FaultName;
            //alert($scope.FaultName);
            if ($("#Modal_Notify_announciation").css("display") == "none") {
                $("#Modal_Notify_announciation").modal('show');

                //   $('#IDannounciation').show();
            }
        })
    };

    $scope.SearchData = function () {
        var httpreq = {
            method: "POST",
            url: "faultscreen.aspx/ReasonwiseFaultSearchData",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, pageIndex: $scope.pageIndex, pageSize: $scope.pageSizeSelected },
        }
        $http(httpreq).success(function (response) {

            if (response.d != "") {
                json = JSON.parse(response.d);

                var filtered = {};
                $('.table_data').show();
                $('.fault_box').hide();
                $('#alertHide').hide();
                $('#alertTableHide').show();
                $scope.NoDataDiv = false;
                $scope.listData = angular.fromJson(json);
                $scope.list = $scope.listData.Table;
                $scope.Totaltime = $scope.listData.Table1[0].Totaltime;
                var date = new Date(null);
                date.setSeconds($scope.Totaltime); // specify value for SECONDS here
                var result = date.toISOString().substr(11, 8);
                $scope.FinalTotalTime = result;

            }
            else {
                $('.table_data').hide();
                $scope.NoDataDiv = true;
            }
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
            if ($scope.txtStartDate == "" || $scope.txtStartDate == undefined || $scope.txtEndDate == "" || $scope.txtEndDate == undefined) {
                toastr.options.positionClass = 'toast-top-center';
                toastr.error('Please enter start date and end date ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                return;
            }
            if ($scope.txtStartDate > $scope.txtEndDate) {
                toastr.options.positionClass = 'toast-top-center';
                toastr.error('start Date is must be lesser then end date..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                return;
            }

        }

        $scope.txtStartDate = $scope.txtStartDate.substring(0, 10) + " " + $scope.txtStartDate.substring(11, 16);
        $scope.txtEndDate = $scope.txtEndDate.substring(0, 10) + " " + $scope.txtEndDate.substring(11, 16);


        var httpreq = {
            method: "POST",
            url: "faultscreen.aspx/ReasonwiseFaultSearchList",
            data: { Type: $scope.Type, Week: $scope.txtWeek, Month: $scope.txtMonth, StartDate: $scope.txtStartDate, EndDate: $scope.txtEndDate, pageIndex: $scope.pageIndex, pageSize: $scope.pageSizeSelected },
        }
        $http(httpreq).success(function (response) {

            if (response.d != "") {
                json = JSON.parse(response.d);

                var filtered = {};
                $('.table_data').show();
                $('.fault_box').hide();
                $scope.NoDataDiv = false;
                $scope.listData = angular.fromJson(json);
                $scope.list = $scope.listData.Table;
                $scope.Totaltime = $scope.listData.Table1[0].Totaltime;
                var date = new Date(null);
                date.setSeconds($scope.Totaltime); // specify value for SECONDS here
                var result = date.toISOString().substr(11, 8);
                $scope.FinalTotalTime = result;
            }
            else {
                $('.table_data').hide();
                $scope.NoDataDiv = true;
            }
        })
    };

    $scope.ExportToExcel = function (ArrayExport) {
        JSONToCSVConvertor(ArrayExport, "", true);
    }

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

    $scope.Hide = function () {
        $scope.SearchData();
        $('.table_data').show();
        $('.fault_box').hide();
        $('#alertHide').hide();
        $('#alertTableHide').show();

    };
    $scope.HideTable = function () {
        //$scope.SearchData();
        $('.table_data').hide();
        $('.fault_box').show();
        $('#alertHide').show();
        $('#alertTableHide').hide();

    };

    $scope.Search1 = function () {
        $scope.selCell = selCell.value;
        if ($scope.seldatepicker == undefined || $scope.seldatepicker == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Select Period First ..!!', 'Wait', {
                timeOut: 9000, closeButton: true, maxOpened: 1,
                preventDuplicates: true,
                autoDismiss: true
            });
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
            url: "faultscreen.aspx/ReasonwiseFaultSearch",
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
                toastr.options.positionClass = 'toast-top-center';
                toastr.success('Data Found For Export Click on Export Button ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });

            }
        })
    };
    
    $scope.ExportList = function () {
        
        var httpreq = {
            method: "POST",
            url: "faultscreen.aspx/Export_Alarms",
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
    //******************** Export Start******************
    $scope.Export = function () {
        $scope.selCell = selCell.value;
        if ($scope.seldatepicker == undefined || $scope.seldatepicker == "") {
            toastr.options.positionClass = 'toast-top-center';
            toastr.error('Select Period First ..!!', 'Wait', {
                timeOut: 9000, closeButton: true, maxOpened: 1,
                preventDuplicates: true,
                autoDismiss: true
            });
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
        $scope.txtStartDate = $scope.txtStartDate.substring(0, 10) + " " + $scope.txtStartDate.substring(11, 16);
        $scope.txtEndDate = $scope.txtEndDate.substring(0, 10) + " " + $scope.txtEndDate.substring(11, 16);

        var httpreq = {
            method: "POST",
            url: "faultscreen.aspx/Export",
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

    //******************** Export End******************
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
                $('#alertHide').hide();
                $('#alertTableHide').hide();
            }
        });
    });
})


