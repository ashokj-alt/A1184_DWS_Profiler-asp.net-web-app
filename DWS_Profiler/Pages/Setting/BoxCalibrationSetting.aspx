<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="BoxCalibrationSetting.aspx.cs" Inherits="DWS_Profiler.Pages.Setting.BoxCalibrationSetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Delhivery | Calibration setting</title>
    <link href="../../global/webapp/BoxCalibrationSetting.css" rel="stylesheet" />
    <script type="text/javascript">
        var app = angular.module('myApp', []);
        app.controller("myController", function ($scope, $http, $interval) {
            // alert("hi");
            $scope.inlistData = <%=listData %>; //;// Bind Your List Data here
            $scope.BoxSetting1 = <%=BoxSetting %>;
            $scope.listData = angular.fromJson($scope.inlistData);
            $scope.BoxSetting = angular.fromJson($scope.BoxSetting1);
            $scope.txtSearch = '';

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
                $scope.RefreshList();

            };

            //************************** function To Refresh List
            $scope.RefreshList = function () {
                // alert();
                var httpreq = {
                    method: "POST",
                    url: "BoxCalibrationSetting.aspx/GetCalibrationCount",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: {},
                }
                $http(httpreq).success(function (response) {
                    $scope.listDataCount = angular.fromJson(response.d);
                    $scope.MasterCount = $scope.listDataCount.Table[0].MasterCount;
                    //  alert($scope.MasterCount);
                })
            };
            //************************** function To Refresh List
            $scope.GetCalibrationList = function () {

                var httpreq = {
                    method: "POST",
                    url: "BoxCalibrationSetting.aspx/GetCalibrationList",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: {},
                }
                $http(httpreq).success(function (response) {
                    $scope.listData = angular.fromJson(response.d);
                    $scope.GetBoxCount();
                    $scope.txtbarcode = "";
                    document.getElementById("txtbarcode").readOnly = false;
                })
            };


            $scope.Open = function () {
                if ($("#Modal_Setting_details").css("display") == "none") {
                    $("#Modal_Setting_details").modal('show');
                }
            };


            angular.element(document).ready(function () {

                $scope.GetBoxCount();

            });

            $scope.GetBoxCount = function () {
                //alert();
                var httpreq = {
                    method: "POST",
                    url: "BoxCalibrationSetting.aspx/BoxCount",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: {},
                }
                $http(httpreq).success(function (response) {
                    $scope.BoxSetting = angular.fromJson(response.d);
                    $scope.fieldname = $scope.BoxSetting[0].FieldName;
                    $scope.Value = $scope.BoxSetting[0].Value;
                    document.getElementById("txtbarcode").readOnly = false;
                })
            };


            //******************** End Reset List******************
            //************************** function To Refresh List
            $scope.Reset = function () {
                $scope.txtbarcode = "";
                $scope.txtweight = "";
                $scope.txtlength = "";
                $scope.txtwidth = "";
                $scope.txtheight = "";
                $scope.txtvolume = "";
                document.getElementById("txtbarcode").readOnly = false;
            }
            //******************** End Reset List******************
            //************************** function To Save Data***************
            // Same function will be used for Insert and Update
            // for Insert Id will be 0. $scope.hiddenId =0  
            //for update Id will be set to $scope.hiddenId
            $scope.serachList = function (Barcode) {
                for (var cnt = 0; cnt < $scope.listData.length; cnt++) {
                    if ($scope.listData[cnt].Barcode == Barcode) {
                        return $scope.listData[cnt];
                    }
                }
            }
            $scope.Save = function () {

                if ($scope.txtbarcode == undefined || $scope.txtbarcode == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Barcode First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                else if ($scope.txtweight == undefined || $scope.txtweight == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Weight First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                else if ($scope.txtlength == undefined || $scope.txtlength == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Length First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                else if ($scope.txtwidth == undefined || $scope.txtwidth == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Width First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                else if ($scope.txtheight == undefined || $scope.txtheight == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Height First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }

                var obj = { Barcode: $scope.txtbarcode, Weight: $scope.txtweight, Length: $scope.txtlength, Width: $scope.txtwidth, Height: $scope.txtheight };
                //alert($scope.txtbarcode);
                var JSONData = JSON.stringify(obj);
                //alert(JSONData);
                var httpreq = {
                    method: "POST",
                    url: "BoxCalibrationSetting.aspx/InsertCalibrationBox",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { JSONData },
                }
                $http(httpreq).success(function (response) {

                    $scope.GetCalibrationList();
                    $scope.Reset();
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.success('Calibration data inserted successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                    $scope.hiddenId = response.d;  // save function should send Id of records, which will be store back to hidden field
                    // add your additiona code to show and hide div over here
                    document.getElementById("txtbarcode").readOnly = false;

                })

            }
            $("#menubar").click(function () {
                $(".top-action-wrap").addClass("active");
            });

            $(".body_wrap").click(function () {
                $(".top-action-wrap").removeClass("active");
            });
            $scope.SaveTimeSetting = function () {
                if ($scope.txttime == undefined || $scope.txttime == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Time First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                var obj = { Time: $scope.txttime };
                var JSONData = JSON.stringify(obj);
                //alert(JSONData);
                var httpreq = {
                    method: "POST",
                    url: "BoxCalibrationSetting.aspx/UpdateTime",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { JSONData },
                }
                $http(httpreq).success(function (response) {
                    $scope.GetCalibrationList();
                    $scope.Reset();
                    $scope.GetBoxCount();
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.success('Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                    // swal("Data Inserted successfully..");
                    $scope.hiddenId = response.d;  // save function should send Id of records, which will be store back to hidden field
                    // add your additiona code to show and hide div over here
                    document.getElementById("txtbarcode").readOnly = false;

                })

            }
            $scope.SaveCountSetting = function () {
                if ($scope.txtboxcount == undefined || $scope.txtboxcount == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Box Count First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                var obj = { MBoxCount: $scope.txtboxcount };
                var JSONData = JSON.stringify(obj);
                //alert(JSONData);
                var httpreq = {
                    method: "POST",
                    url: "BoxCalibrationSetting.aspx/UpdateBoxCount",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { JSONData },
                }
                $http(httpreq).success(function (response) {
                    $scope.GetCalibrationList();
                    $scope.Reset();
                    $scope.GetBoxCount();
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.success('Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                    // swal("Data Inserted successfully..");
                    $scope.hiddenId = response.d;  // save function should send Id of records, which will be store back to hidden field
                    // add your additiona code to show and hide div over here
                    document.getElementById("txtbarcode").readOnly = false;

                })

            }

            //************************** End To Save Data


            $scope.Update = function () {

                if ($scope.txtbarcode == undefined || $scope.txtbarcode == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Barcode First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                else if ($scope.txtweight == undefined || $scope.txtweight == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Weight First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                else if ($scope.txtlength == undefined || $scope.txtlength == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Length First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                else if ($scope.txtwidth == undefined || $scope.txtwidth == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Width First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                else if ($scope.txtheight == undefined || $scope.txtheight == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Height First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                else if ($scope.txtvolume == undefined || $scope.txtvolume == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter Volume First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                //else if ($index >=5) {
                //    toastr.options.positionClass = 'toast-top-center';
                //    toastr.error('Already inserted 5 Calibration Boxes ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                //    return;
                //}

                var obj = { Barcode: $scope.txtbarcode, Weight: $scope.txtweight, Length: $scope.txtlength, Width: $scope.txtwidth, Height: $scope.txtheight, Volume: $scope.txtvolume };
                //alert($scope.txtbarcode);
                var JSONData = JSON.stringify(obj);
                //alert(JSONData);
                var httpreq = {
                    method: "POST",
                    url: "BoxCalibrationSetting.aspx/UpdateCalibrationBox",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { JSONData },
                }
                $http(httpreq).success(function (response) {
                    $("#btnUpdate").hide();
                    $("#btnNew").hide();
                    $("#btnSave").show();
                    $scope.GetCalibrationList();
                    $scope.Reset();
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.success('Data Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                    // swal("Data Inserted successfully..");
                    $scope.hiddenId = response.d;  // save function should send Id of records, which will be store back to hidden field
                    // add your additiona code to show and hide div over here
                    document.getElementById("txtbarcode").readOnly = false;

                })

            }


            //************************** Delete Data**********************************
            $scope.DeleteCalibrationBox = function (Barcode) {
                //alert(Barcode);

                var searchItem = $scope.serachList(Barcode);
                $scope.hiddenId = Barcode;

                swal({
                    title: "Are you Sure!",
                    text: "Do you want to delete user? ",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "OK!",
                    closeOnConfirm: true
                }, function (isConfirm) {
                    if (!isConfirm) return;

                    var httpreq = {
                        method: "POST",
                        url: "BoxCalibrationSetting.aspx/DeleteCalibratioBox",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { Barcode: $scope.hiddenId },
                    }
                    $http(httpreq).success(function (response) {
                        //alert("Data deleted successfully..");
                        $scope.GetCalibrationList();
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('Delated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                        $scope.hiddenId = response.d;  // save function should send Id of records, which will be store back to hidden field
                        // add your additiona code to show and hide div over here
                        document.getElementById("txtbarcode").readOnly = false;


                    })

                })


            };

            //************************** End To Delete Data******************************//

            $scope.EditCalibrationBox = function (Barcode, Weight, Length, Height, Width, Volume) {
                document.getElementById("txtbarcode").readOnly = true;
                $("#btnSave").hide();
                $("#btnUpdate").show();
                $("#btnCancel").show();
                $("#btnRefresh").hide();

                //alert(Barcode);
                var searchItem = $scope.serachList(Barcode);

                $scope.txtbarcode = Barcode;
                //$scope.txtemployee_name1 = searchItem.employee_name;
                $("#txtbarcode").attr("class", "form-control ");
                $scope.txtweight = Weight;
                $("#txtweight").attr("class", "form-control");

                $scope.txtlength = Length;
                $("#txtlength").attr("class", "form-control ");

                $scope.txtwidth = Width;
                $("#txtwidth").attr("class", "form-control ");

                $scope.txtheight = Height;
                $("#txtheight").attr("class", "form-control ");

                $scope.txtvolume = Volume;
                $("#txtvolume").attr("class", "form-control ");

            };

            $scope.New = function () {
                $("#btnSave").show();
                $("#btnUpdate").hide();
                $("#btnNew").hide();
                $scope.txtbarcode = "";
                $scope.txtweight = "";
                $scope.txtlength = "";
                $scope.txtwidth = "";
                $scope.txtheight = "";
                $scope.txtvolume = "";
                document.getElementById("txtbarcode").readOnly = false;
            };
            $scope.Refresh = function () {
                $("#btnSave").show();
                $("#btnUpdate").hide();
                $("#btnNew").hide();
                $scope.txtbarcode = "";
                $scope.txtweight = "";
                $scope.txtlength = "";
                $scope.txtwidth = "";
                $scope.txtheight = "";
                $scope.txtvolume = "";
                document.getElementById("txtbarcode").readOnly = false;
            };
            $scope.Cancel = function () {
                $("#btnSave").show();
                $("#btnUpdate").hide();
                $("#btnNew").hide();
                $("#btnRefresh").show();
                $("#btnCancel").hide();
                $scope.txtbarcode = "";
                $scope.txtweight = "";
                $scope.txtlength = "";
                $scope.txtwidth = "";
                $scope.txtheight = "";
                $scope.txtvolume = "";
                document.getElementById("txtbarcode").readOnly = false;
            };

            $scope.display = function () {
                $("#txttime").show();
                $("#btnSave1").show();
                $("#countSave").hide();
                $("#txtboxcount").hide();
            }

            $scope.displayCount = function () {
                $("#txtboxcount").show();
                $("#btnSave1").hide();
                $("#txttime").hide();
                $("#countSave").show();
            }


            $scope.serachList = function (id) {
                for (var cnt = 0; cnt < $scope.listData.length; cnt++) {
                    if ($scope.listData[cnt].id == id) {
                        return $scope.listData[cnt];
                    }
                }
            }

        });
    </script>
    <style>
        #detail #form1 input {
            width: 70%;
            background-color: #fff !important;
            padding: 5px 10px;
        }

        #detail #form1 label {
            width: 30%;
            font-size: 16px;
            color: #161616;
        }

        #form1 table tr {
            margin-bottom: 10px !important;
        }

        .top_row .title {
            background-color: #194a77;
            color: white;
            height: 35px;
            padding-left: 20px;
        }

        .item input:hover, .item select:hover, .item textarea:hover {
            border: 1px solid transparent;
            box-shadow: 0 0 3px 0 #669999;
            color: #669999;
        }

        .item span {
            color: red;
        }

        .week {
            display: flex;
            justfiy-content: space-between;
        }

        .colums {
            display: flex;
            justify-content: space-between;
            flex-direction: row;
            flex-wrap: wrap;
        }

            .colums div {
                width: 25%;
            }

        input[type="date"]::-webkit-inner-spin-button {
            display: none;
        }

        .item i, input[type="date"]::-webkit-calendar-picker-indicator {
            position: absolute;
            font-size: 20px;
            color: #a3c2c2;
        }

        .item i {
            right: 1%;
            top: 30px;
            z-index: 1;
        }

        input[type=radio], input[type=checkbox] {
            display: none;
        }

        label.radio {
            position: relative;
            display: inline-block;
            margin: 5px 20px 15px 0;
            cursor: pointer;
        }

        .question span {
            margin-left: 30px;
        }

        .question-answer label {
            display: block;
        }

        label.radio:before {
            content: "";
            position: absolute;
            left: 0;
            width: 17px;
            height: 17px;
            border-radius: 50%;
            border: 2px solid #ccc;
        }

        input[type=radio]:checked + label:before, label.radio:hover:before {
            border: 2px solid #669999;
        }

        label.radio:after {
            content: "";
            position: absolute;
            top: 6px;
            left: 5px;
            width: 8px;
            height: 4px;
            border: 3px solid #669999;
            border-top: none;
            border-right: none;
            transform: rotate(-45deg);
            opacity: 0;
        }

        input[type=radio]:checked + label:after {
            opacity: 1;
        }

        .flax {
            display: flex;
            justify-content: space-around;
        }

        .btn-block {
            margin-top: 10px;
            text-align: center;
        }

        textarea {
            width: calc(100% - 12px);
            padding: 5px;
        }

        .testbox {
            display: flex;
            justify-content: center;
            align-items: center;
            height: inherit;
            padding: 20px;
        }

        form {
            width: 100%;
            padding: 20px;
            border-radius: 6px;
        }

        .banner {
            position: relative;
            height: 300px;
            background-image: url("/uploads/media/default/0001/02/c1504011491c4e04e5158b63a27a4ea654b03ed1.jpeg");
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

            .banner::after {
                content: "";
                background-color: rgba(0, 0, 0, 0.2);
                position: absolute;
                width: 100%;
                height: 100%;
            }

        input, select, textarea {
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        input {
            width: calc(100% - 10px);
            padding: 5px;
        }

            input[type="date"] {
                padding: 4px 5px;
            }

        textarea {
            width: calc(100% - 12px);
            padding: 5px;
        }

        .item:hover p, .item:hover i, .question:hover p, .question label:hover, input:hover::placeholder {
            color: #669999;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Calibration" ng-app="myApp" ng-controller="myController">
        <div class="calibration">

            <div class="row" id="detail">
                <div class="col-md-5">
                    <div class="row">
                        <div class="top_row">
                            <div class="col-md-12 title">

                                <h5 class="main_title">Calibration Box</h5>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 12px;">
                        <div class="col-md-12 pl-0 pr-0">
                            <form id="form1" class="form-inline">
                                <table style="width: 100%;">
                                    <tr style="padding-bottom: 10px;">
                                        <td colspan="2">
                                            <div class="form-group form-material floating" style="display: flex;">
                                                <label class="pull-right" for="fname">AWB</label>
                                                <input type="text" ng-model="txtbarcode" class="form-control" required name="txtbarcode" id="txtbarcode" required placeholder="Enter AWB number"><br>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group form-material floating">
                                                <label for="txtlength">Length</label>
                                                <input type="text" ng-model="txtlength" class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' required name="txtlength" id="txtlength" required placeholder="Enter Length in mm"><br>
                                            </div>
                                        </td>
                                        <td>

                                            <div class="form-group form-material floating">
                                                <label for="txtwidth">Width</label><br>
                                                <input type="text" ng-model="txtwidth" class="form-control " onkeypress='return event.charCode >= 48 && event.charCode <= 57' required name="txtwidth" id="txtwidth" required placeholder="Enter width in mm"><br>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group form-material floating">
                                                <label for="txtheight">Height</label>
                                                <input type="text" ng-model="txtheight" class="form-control " onkeypress='return event.charCode >= 48 && event.charCode <= 57' required name="txtheight" id="txtheight" required placeholder="Enter Height in mm"><br>
                                            </div>

                                        </td>
                                        <td>

                                            <div class="form-group form-material floating">
                                                <label for="txtweight">Weight</label>
                                                <input type="text" ng-model="txtweight" class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' required name="txtweight" id="txtweight" required placeholder="Enter Weight gram"><br>
                                            </div>
                                        </td>
                                    </tr>
                                </table>

                            </form>
                        </div>
                    </div>

                    <div class="row no-gutters">
                        <div class="center" style="display: flex; margin-left: auto; margin-right: auto; margin-top: 10px;">

                            <button type="button" id="btnSave" class="btn btn-primary" value="Save" ng-click="Save()" style="margin-right: 10px;">
                                <img style="margin-bottom: 3px;" src="../../Images/save.png" />
                                Save</button>
                            <button style="display: none; margin-right: 10px;" type="button" id="btnUpdate" class="btn btn-primary" value="Update" ng-click="Update()">
                                <img src="../../Images/save_as.png" style="margin-bottom: 3px;" />
                                Update</button>
                            <button type="button" id="btnRefresh" class="btn btn-success" value="Refresh" ng-click="Refresh()">
                                <img src="../../Images/refresh.png" style="margin-bottom: 3px;" />
                                Reset</button>
                            <button style="display: none;" type="button" id="btnCancel" class="btn btn-success" value="Cancel" ng-click="Cancel()">
                                <img src="../../Images/close.png" style="margin-bottom: 3px;" />
                                Cancel</button>
                        </div>
                    </div>
                </div>

                <div class="col-md-7">
                    <div class="row no-gutters">
                        <div class="top_row">
                            <div class="col-md-12 title">

                                <h5 class="main_title">List of 5 Calibration Box</h5>
                            </div>
                        </div>
                    </div>
                    <div class="row no-gutters" style="padding-top: 10px; padding-right: 10px;">
                        <div class="table_data table-responsive">
                            <table class="table" style="width: 100%;">
                                <thead>
                                    <tr>

                                        <th>Sr.No</th>
                                        <th>AWB</th>
                                        <th>Length(mm)</th>
                                        <th>Width(mm)</th>
                                        <th>Height(mm)</th>
                                        <th>Weight(g)</th>
                                        <th>Volume(cm3)</th>
                                        <th style="text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="item in listData | filter:txtSearch">
                                        <td style="text-align: center;">{{$index+1}}</td>
                                        <td>{{item.Barcode}}</td>

                                        <td>{{item.Length}}</td>
                                        <td>{{item.Width}}</td>
                                        <td>{{item.Height}}</td>

                                        <td>{{item.Weight}}</td>
                                        <td>{{item.Volume}}</td>
                                        <td style="text-align: center;">
                                            <button id="btnEdit" data-toggle="tooltip" data-original-title="Edit" id="btnEdit" ng-click="EditCalibrationBox(item.Barcode,item.Weight,item.Length,item.Height,item.Width,item.Volume)" style="border: none;" title="Edit Barcode">
                                                <img src="../../global/images/edit_1.png" style="width: 16px; height: auto;" />
                                            </button>

                                            <button id="btnDelete" ng-click="DeleteCalibrationBox(item.Barcode)" style="border: none;" title="Delete Barcode">
                                                <img src="../../global/images/delete_1.png" style="width: 16px; height: auto;" />
                                            </button>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="9" class="center" style="text-align: center;">
                                            <div ng-switch="(listData | filter:txtSearch).length">
                                                <span class="ng-empty text-danger" ng-switch-when="5">* Only 5 calibration boxes are allowed..</span>
                                            </div>

                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="9" class="text-center" style="border-top: none;">
                                            <div ng-switch="(listData | filter:txtSearch).length">
                                                <span class="ng-empty text-danger" ng-switch-when="0">No Record(s) Found</span>
                                            </div>
                                        </td>
                                    </tr>


                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
            <hr />
        </div>

        <div class="row ">

            <div class="col-md-5" id="cali">
                <div class="row no-gutters">
                    <div class="top_row">
                        <div class="col-md-12 title">

                            <h5 class="main_title">Calibration Box Setting</h5>
                        </div>
                    </div>

                </div>
                <div class="row no-gutters" style="padding: 10px; margin-left: auto;">
                    <div class="col-md-6">
                        <div class="form-group form-material floating fr-cust_radio">
                            <label class="radio_button" ng-click="display()">
                                Time
                                      <input type="radio" checked="checked" name="radio">
                                <span class="checkmark" id="checkmark"></span>
                            </label>
                            <input type="text" ng-model="txttime" class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' required name="txttime" id="txttime" required style="margin-left: auto; background-color: #fff; width: 100%; display: none;" placeholder="Enter time in min i.e 1=60min" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group form-material floating fr-cust_radio">
                            <label class="radio_button" ng-click="displayCount()">
                                Box Count
                                      <input type="radio" checked="checked" name="radio">
                                <span class="checkmark" id="checkmark"></span>
                            </label>
                            <input type="type" ng-model="txtboxcount" class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' required name="txtboxcount" id="txtboxcount" required style="margin-left: auto; background-color: #fff; width: 100%; display: none;" placeholder="Enter Box Count" />
                        </div>
                    </div>
                </div>
                <div class="row no-gutters">
                    <div class="center" id="Calbutton" style="display: block; margin-left: auto; margin-right: auto; margin-top: 10px; margin-bottom: 20px;">

                        <button type="button" id="btnSave1" class="btn btn-primary" value="Save" ng-click="SaveTimeSetting()" style="display: none;">
                            <img style="margin-bottom: 3px;" src="../../Images/save.png" />
                            Save</button>
                        <button type="button" id="countSave" class="btn btn-primary" value="Save" ng-click="SaveCountSetting()" style="display: none;">
                            <img style="margin-bottom: 3px;" src="../../Images/save.png" />
                            Save</button>

                    </div>
                </div>
            </div>


            <div class="col-md-7" ng-init="StartTimer()">
                <div class="row no-gutters">
                    <div class="top_row">
                        <div class="col-md-12 title">

                            <h5 class="main_title">Current Box Setting</h5>
                        </div>
                    </div>
                </div>
                <div class="row no-gutters" style="padding-top: 10px; padding-right: 10px; margin-bottom: 20px;">
                    <div class="table_data">
                        <table class="table" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>{{fieldname}}</th>
                                    <th>Current shipment</th>
                                    <th>Remaining shipment</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>{{Value}}</td>
                                    <td>{{MasterCount}}</td>
                                    <td>{{Value - MasterCount}}</td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="text-center" style="border-top: none;">
                                        <div ng-switch="(item | filter:txtSearch).length">
                                            <span class="ng-empty text-danger" ng-switch-when="0">No Record(s) Found</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <button class="btn btn-primary" ng-click="Open()">Insert Details</button>
            </div>
        </div>

        <footer class="main-footer">
            <strong>Copyright © 2020 <a href="">Armstrong Machine Builders Pvt. Ltd</a>.</strong>
            All rights reserved.
        </footer>

        <%-- Model--%>

        <div class="modal fade" id="Modal_Setting_details" role="dialog" tabindex="-1" style="padding-right: 17px; display: none; z-index: 999999;">
            <div class="modal-dialog" style="max-width: 1000px; min-height: 100px; margin-top: 80px;">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Enter Details</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="">

                            <div class="colums">
                                <div class="item">
                                    <label for="txtAWB">Min Length (cm)<span>*</span></label>
                                    <input id="txtAWB" ng-model="txtAWB" type="text" name="txtAWB" required />
                                </div>
                                <div class="item">
                                    <label for="txtLength">Min Width (cm)<span>*</span></label>
                                    <input id="txtLength" ng-model="txtLength" type="text" name="txtLength" required />
                                </div>
                                <div class="item">
                                    <label for="txtWidth">Min Height (cm)<span>*</span></label>
                                    <input id="txtWidth" ng-model="txtWidth" type="text" name="txtWidth" required />
                                </div>
                                <div class="item">
                                    <label for="txtHeight">Min Weight (cm)<span>*</span></label>
                                    <input id="txtHeight" ng-model="txtHeight" type="text" name="txtHeight" required />
                                </div>
                                <div class="item">
                                    <label for="txtWeight">Max Length (cm)<span>*</span></label>
                                    <input id="txtWeight" ng-model="txtWeight" type="text" name="txtWeight" required />
                                </div>
                                <div class="item">
                                    <label for="txtVolume">Max Width (cm)<span>*</span></label>
                                    <input id="txtVolume" ng-model="txtVolume" type="text" name="txtVolume" required />
                                </div>
                                <div class="item">
                                    <label for="txtReal">Max Height (cm)<span>*</span></label>
                                    <input id="txtReal" ng-model="txtReal" type="text" name="txtReal" required />
                                </div>
                                <div class="item">
                                    <label for="txtPackage">Max Weight (cm)<span>*</span></label>
                                    <input id="txtPackage" ng-model="txtPackage" type="text" name="txtPackage" required />
                                </div>
                                <div class="item">
                                    <label for="txtData">Machine ID<span>*</span></label>
                                    <input id="txtData" ng-class="{'divRed1': txtData == 'Failed','divgreen': txtData == 'Success'}" ng-model="txtData" type="tel" name="txtData" required />
                                </div>
                                <div class="item">
                                    <label for="txtDatetime">Scan Location<span>*</span></label>
                                    <input id="txtDatetime" ng-model="txtDatetime" type="text" name="txtDatetime" required />
                                </div>
                                <div class="item">
                                    <label for="txtFailed">Reason for Failed</label>
                                    <textarea style="" rows="1" cols="50" id="txtFailed" ng-model="txtFailed" type="textarea" name="txtFailed" required />
                                </div>
                                <div class="item">
                                    <label for="txtFailed">Reason for Failed</label>
                                    <textarea style="" rows="1" cols="50" id="txtFailed" ng-model="txtFailed" type="textarea" name="txtFailed" required />
                                </div>
                                <div class="item">
                                    <button class="btn btn-primary">Save</button>
                                </div>


                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>


        <%-- Model End--%>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
