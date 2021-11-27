var app = angular.module("myApp", []);
app.controller('myController_HeartBit', function ($scope, $http, $interval) {
    //alert("hi");
    $scope.HeartBitStatus = 1;
    $scope.HeartBit_PC = null;
    $scope.HeartBit_PLC = null;
    $scope.HeartBit_Weighing = null;
    $scope.HeartBit_Scanner = null;
    $scope.HeartBit_server = null;

    $scope.startHeartBit = function () {
        if (showHeartBit)
            $scope.StartTimer();
        else {
            $("#navIconHeartBit").hide();
        }
    };
    $scope.StartTimer = function () {



        $scope.Timer = $interval(function () {
            //$scope.GetHeartBit();

        }, 1000);
    };
    $scope.StopTimer = function () {

        $scope.Message = "Timer stopped.";


        if (angular.isDefined($scope.Timer)) {
            $interval.cancel($scope.Timer);
        }
    };

    $scope.open = function () {
        if ($("#Modal_Notify_announciation").css("display") == "none") {
            $("#Modal_Notify_announciation").modal('show');

            //   $('#IDannounciation').show();
        }
    }
    $scope.GetHeartBit = function () {

        //alert("in");
        $.ajax({
            type: "POST",
            //  url: "Base.Master/GetData",
            url: "homepage.aspx/GetData",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {
                //alert(r.d);
                var jsonData = JSON.parse(r.d);
                var DeviceDataGet = jsonData.Table1;
                var AnnunciationData = jsonData.Table;
                $scope.AnnunciationData = jsonData.Table;
                var DeviceDataList = jsonData.Table2;

                // alert($scope.HeartBit_PLC.length);

                if (DeviceDataGet.length > 0)
                    $scope.HeartBitStatus = 0;
                else
                    $scope.HeartBitStatus = 1;

                if (!showAnnunciationFault)
                    return;

                if ($("#Modal_Notify").css("display") != "none")
                    $('#Modal_Notify').modal('hide');

                if (AnnunciationData.length > 0) {

                    $('#IDannounciation').hide();

                }
                else {


                    $('#IDannounciation').hide();

                }



            },
            error: function (r) {
                if (r.responseText.indexOf("SessionError" >= 0)) {
                    document.location = "/SessionError.aspx";
                }
                //alert("errr>>" + r.responseText);
            },
            failure: function (r) {
                //alert("failure>>" + r.responseText);
            }
        });
    }

    $scope.ShowUser = function () {

        $(".user").show("slow");

    }




});
function dashboard() {
    document.getElementById("dashboard").style.backgroundColor = "#4b9cf5";
    document.getElementById("UserManagement").style.backgroundColor = "#c4e0f9";
    document.getElementById("reports").style.backgroundColor = "#c4e0f9";
    document.getElementById("calibration").style.backgroundColor = "#c4e0f9";
}
function UserManagement() {
    document.getElementById("UserManagement").style.backgroundColor = "#4b9cf5";
    document.getElementById("dashboard").style.backgroundColor = "#c4e0f9";
    document.getElementById("reports").style.backgroundColor = "#c4e0f9";
    document.getElementById("calibration").style.backgroundColor = "#c4e0f9";
}
function reports() {
    document.getElementById("reports").style.backgroundColor = "#4b9cf5";
    document.getElementById("dashboard").style.backgroundColor = "#c4e0f9";
    document.getElementById("UserManagement").style.backgroundColor = "#c4e0f9";
    document.getElementById("calibration").style.backgroundColor = "#c4e0f9";
}
function calibration() {
    document.getElementById("calibration").style.backgroundColor = "#4b9cf5";
    document.getElementById("dashboard").style.backgroundColor = "#c4e0f9";
    document.getElementById("UserManagement").style.backgroundColor = "#c4e0f9";
    document.getElementById("reports").style.backgroundColor = "#c4e0f9";
}

$(document).ready(function () {
    $("#UserManagement").click(function () {
        $(".user").show();
        $(".reports").hide();
        $(".calibration").hide();
        $(".dashboard").hide();
    });
    $("#reports").click(function () {
        $(".user").hide();
        $(".reports").show();
        $(".calibration").hide();
        $(".dashboard").hide();
    });
    $("#dashboard").click(function () {
        $(".user").hide();
        $(".reports").hide();
        $(".dashboard").show();
        $(".calibration").hide();
    });
    $("#calibration").click(function () {
        $(".user").hide();
        $(".reports").hide();
        $(".dashboard").hide();
        $(".calibration").show();
    });
});