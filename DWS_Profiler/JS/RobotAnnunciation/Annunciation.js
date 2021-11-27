var palyAudio = true;
var showAnnunciationFault = true;
var showHeartBit = true;
var isplay_English = false;
var isPlayingAnnunciation = false;
var isContinue = null;
var listAnnunciation = null;
var LANfail = null;
var i = 0;
var myIndex = 0;
function carousel() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    myIndex++;
    if (myIndex > x.length) { myIndex = 1 }
    x[myIndex - 1].style.display = "block";
    setTimeout(carousel, 10000); // Change image every 2 seconds
}


var app = angular.module("myApp", []);
app.controller("myController", function ($scope, $http, $interval) {
   

    $scope.Line1 = "00";
    $scope.Line2 = "00";
    $scope.Line3 = "00";
    $scope.Line1SKUName = "00";
    $scope.Line2SKUName = "00";
    $scope.Line3SKUName = "00";
    $scope.TotalCount = "00";
    $scope.TotalRunningtime = "00:00";
    $scope.RobotNo = RobotNo;

    $scope.BoxCount1 = 0; $scope.BoxCount2 = 0; $scope.BoxCount3 = 0; $scope.BoxCount4 = 0; $scope.BoxCount5 = 0;
    $scope.BoxCount6 = 0; $scope.BoxCount7 = 0; $scope.BoxCount8 = 0; $scope.BoxCount9 = 0; $scope.BoxCount10 = 0;
    $scope.BoxCount11 = 0; $scope.BoxCount12 = 0; $scope.BoxCount13 = 0; $scope.BoxCount14 = 0; $scope.BoxCount15 = 0;
    $scope.BoxCount16 = 0; $scope.BoxCount17 = 0; $scope.BoxCount18 = 0; $scope.BoxCount19 = 0; $scope.BoxCount20 = 0;
    $scope.BoxCount21 = 0; $scope.BoxCount22 = 0; $scope.BoxCount23 = 0; $scope.BoxCount24 = 0;

    $scope.Pallet1 = 0; $scope.Pallet2 = 0; $scope.Pallet3 = 0; $scope.Pallet4 = 0; $scope.Pallet5 = 0;
    $scope.Pallet6 = 0; $scope.Pallet7 = 0; $scope.Pallet8 = 0; $scope.Pallet9 = 0; $scope.Pallet10 = 0;
    $scope.Pallet11 = 0; $scope.Pallet12 = 0; $scope.Pallet13 = 0; $scope.Pallet14 = 0; $scope.Pallet15 = 0;
    $scope.Pallet16 = 0; $scope.Pallet17 = 0; $scope.Pallet18 = 0; $scope.Pallet19 = 0; $scope.Pallet20 = 0;
    $scope.Pallet21 = 0; $scope.Pallet22 = 0; $scope.Pallet23 = 0; $scope.Pallet24 = 0;

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

        $scope.Count();

    };

    $scope.Count = function () {
        $scope.Date = new Date();

        var httpreq = {
            method: "POST",
            url: "Annunciation.aspx/ShowCount",
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'dataType': 'json',

            },
            async: false,

            data: { CellNo: $scope.RobotNo },
        }
        $http(httpreq).success(function (response) {
            $scope.countData = angular.fromJson(response.d);
            $scope.RobotNo = RobotNo;
            $scope.currentDate = $scope.countData.Table1[0].CurrentDate;
            $scope.Pallet1 = $scope.countData.Table[0].no_off_pallet; $scope.Pallet2 = $scope.countData.Table[1].no_off_pallet; $scope.Pallet3 = $scope.countData.Table[2].no_off_pallet;
            $scope.Pallet4 = $scope.countData.Table[3].no_off_pallet; $scope.Pallet5 = $scope.countData.Table[4].no_off_pallet; $scope.Pallet6 = $scope.countData.Table[5].no_off_pallet;
            $scope.Pallet7 = $scope.countData.Table[6].no_off_pallet; $scope.Pallet8 = $scope.countData.Table[7].no_off_pallet; $scope.Pallet9 = $scope.countData.Table[8].no_off_pallet;
            $scope.Pallet10 = $scope.countData.Table[9].no_off_pallet; $scope.Pallet11 = $scope.countData.Table[10].no_off_pallet; $scope.Pallet12 = $scope.countData.Table[11].no_off_pallet;
            $scope.Pallet13 = $scope.countData.Table[12].no_off_pallet; $scope.Pallet14 = $scope.countData.Table[13].no_off_pallet; $scope.Pallet15 = $scope.countData.Table[14].no_off_pallet;
            $scope.Pallet16 = $scope.countData.Table[15].no_off_pallet; $scope.Pallet17 = $scope.countData.Table[16].no_off_pallet; $scope.Pallet18 = $scope.countData.Table[17].no_off_pallet;
            $scope.Pallet19 = $scope.countData.Table[18].no_off_pallet; $scope.Pallet20 = $scope.countData.Table[19].no_off_pallet; $scope.Pallet21 = $scope.countData.Table[20].no_off_pallet;
            $scope.Pallet22 = $scope.countData.Table[21].no_off_pallet; $scope.Pallet23 = $scope.countData.Table[22].no_off_pallet; $scope.Pallet24 = $scope.countData.Table[23].no_off_pallet;
            console.log($scope.Pallet22);
            //alert($scope.BoxCount1);
            //alert($scope.BoxCount1);
            $scope.BoxCount1 = $scope.countData.Table[0].BoxCount; $scope.BoxCount2 = $scope.countData.Table[1].BoxCount; $scope.BoxCount3 = $scope.countData.Table[2].BoxCount;
            $scope.BoxCount4 = $scope.countData.Table[3].BoxCount; $scope.BoxCount5 = $scope.countData.Table[4].BoxCount; $scope.BoxCount6 = $scope.countData.Table[5].BoxCount;
            $scope.BoxCount7 = $scope.countData.Table[6].BoxCount; $scope.BoxCount8 = $scope.countData.Table[7].BoxCount; $scope.BoxCount9 = $scope.countData.Table[8].BoxCount;
            $scope.BoxCount10 = $scope.countData.Table[9].BoxCount; $scope.BoxCount11 = $scope.countData.Table[10].BoxCount; $scope.BoxCount12 = $scope.countData.Table[11].BoxCount;
            $scope.BoxCount13 = $scope.countData.Table[12].BoxCount; $scope.BoxCount14 = $scope.countData.Table[13].BoxCount; $scope.BoxCount15 = $scope.countData.Table[14].BoxCount;
            $scope.BoxCount16 = $scope.countData.Table[15].BoxCount; $scope.BoxCount17 = $scope.countData.Table[16].BoxCount; $scope.BoxCount18 = $scope.countData.Table[17].BoxCount;
            $scope.BoxCount19 = $scope.countData.Table[18].BoxCount; $scope.BoxCount20 = $scope.countData.Table[19].BoxCount; $scope.BoxCount21 = $scope.countData.Table[20].BoxCount;
            $scope.BoxCount22 = $scope.countData.Table[21].BoxCount; $scope.BoxCount23 = $scope.countData.Table[22].BoxCount; $scope.BoxCount24 = $scope.countData.Table[23].BoxCount;
            $scope.PopupAnnaunciation();
        });
    }

    function addZero(i) {
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }


    $scope.PopupAnnaunciation = function () {

        $.ajax({
            type: "POST",
            url: "Annunciation.aspx/PopAnnunciation",
            data: '{Cell_No:' + $scope.RobotNo + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {

                var jsonData = JSON.parse(r.d);
                var AnnunciationData = jsonData.Table;
                $scope.AnnList = angular.fromJson(AnnunciationData);
                console.dir($scope.AnnList);
                if (isContinue == false) {
                    AnnunciationData = LANfail;
                }
                listAnnunciation = AnnunciationData;
                if (!showAnnunciationFault)
                    return;
                if ($("#Modal_Notify").css("display") != "none")
                    $('#Modal_Notify').modal('hide');

                if (AnnunciationData.length > 0) {
                    Annunciation(AnnunciationData);

                }
                else {
                    Pauseonload();
                    if ($("#Modal_Notify_announciation").css("display") != "none")
                        $('#Modal_Notify_announciation').modal('hide');
                }
            },
            error: function (r) {
                if (r.responseText.indexOf("SessionError" >= 0)) {

                }

            },
            failure: function (r) {
            }
        });

    }
})

function secondsToHms(d) {
    d = Number(d);
    var h = Math.floor(d / 3600);
    var m = Math.floor(d % 3600 / 60);
    var s = Math.floor(d % 3600 % 60);

    var hDisplay = h > 0 ? h + (h == 1 ? " :, " : " : , ") : "00";
    var mDisplay = m > 0 ? m + (m == 1 ? " :, " : ": , ") : ":00:";
    var sDisplay = s > 0 ? s + (s == 1 ? ":" : "") : ":00";
    return hDisplay + mDisplay + sDisplay;
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function Annunciation(AnnunciationData) {

    isPlayingAnnunciation = true;
    if (i < AnnunciationData.length) {

        var currt = listAnnunciation.find(x => x.id === AnnunciationData[i].id);

        if (currt != null) {

            var filename = AnnunciationData[i].AudioFilePath;

            var filename_English = AnnunciationData[i].AudioFilePath_English;

            fileName_ToPlay = filename;
            if (AnnunciationData[i].ErrorDescription != "") {
                document.getElementById("D_Name_ann").innerHTML = AnnunciationData[i].Label; //+ " : " + AnnunciationData[i].ErrorDescription;
            }
            else
                document.getElementById("D_Name_ann").innerHTML = AnnunciationData[i].Label;

            if (AnnunciationData[i].ImagePath != null) {
                document.getElementById("D_Path_ann").src = AnnunciationData[i].ImagePath;
            }
            else {
                $("#D_Path_ann").css("display") == "none";
            }
            if ($("#Modal_Notify_announciation").css("display") == "none") {
                $("#Modal_Notify_announciation").modal('show');
            }
            if (filename != null && filename != "" && filename_English != null && filename_English != "") {
                if (palyAudio) {
                    onload(filename);
                    fileName_ToPlay = filename;
                }
            }
            else if (filename != null && filename != "") {
                if (palyAudio) {
                    onload(filename);
                }
            }
            else if (filename_English != null && filename_English != "") {
                if (palyAudio) {
                    fileName_ToPlay = filename;
                    onload_English(filename);
                }
            }
            else {
                if (isContinue == false) {
                    i = 0;
                }
                else { i++; }
                await sleep(5000);
            }
        }
    }
    else {

        i = 0;
    }

    isPlayingAnnunciation = false;
}
var fileName_ToPlay = "";
function onload(audioname) {
    palyAudio = false;
    video_player = document.getElementById("adoAnnaunciation");
    video_player.setAttribute("src", audioname);

    var playPromise = video_player.play();

    if (playPromise !== undefined) {
        playPromise.then(_ => {
            video_player.play();
        })
            .catch(error => {
                video_player.pause();
            });
    }
}
function onload_English(audioname) {

    palyAudio = false;
    video_player1 = document.getElementById("adoAnnaunciation_English");
    video_player1.setAttribute("src", audioname);
    video_player1.play();
}
function Pauseonload() {
    palyAudio = true;
    video_player = document.getElementById("adoAnnaunciation");
    video_player.pause();
}
function onEnd() {
    palyAudio = true;
    onload(fileName_ToPlay)
}
function onEnd_English() {
    palyAudio = true;
    i++;
}