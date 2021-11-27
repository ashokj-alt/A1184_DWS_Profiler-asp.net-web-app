<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="MasterSetting.aspx.cs" Inherits="DWS_Profiler.Pages.Setting.MasterSetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Setting's</title>
    <script src="../../JS/9226cb70eb.js"></script>
    <script type="text/javascript">
        var app = angular.module('myApp', []);
        app.controller("myController", function ($scope, $http, $interval) {
            //alert();

            angular.element(document).ready(function () {

                $scope.GetData();

            });

            $(document).ready(function () {
                $("#SearchFlag").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#FlagDBAddress #FaultName").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });

                $("#SearchAlarms").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#AlarmsDBAddress #Description").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });

            //************************** function To Refresh List
            $scope.GetData = function () {
                // alert();
                var httpreq = {
                    method: "POST",
                    url: "MasterSetting.aspx/GetData",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: {},
                }
                $http(httpreq).success(function (response) {
                    $scope.listData = angular.fromJson(response.d);
                    $scope.DimentionData = $scope.listData.Table;

                    $scope.PLC_IP = $scope.listData.Table1[0].PLC_IP;
                    $scope.Camera_IP = $scope.listData.Table1[0].Camera_IP;
                    $scope.VMS_IP = $scope.listData.Table1[0].VMS_IP;
                    $scope.HMI_IP = $scope.listData.Table1[0].HMI_IP;
                    $scope.Check_Weigher_IP = $scope.listData.Table1[0].Check_Weigher_IP;
                    $scope.Scanner_Port = $scope.listData.Table1[0].Scanner_Port;
                    $scope.CheckWeigher_LAN_Port = $scope.listData.Table1[0].CheckWeigher_LAN_Port;
                    $scope.VMS_LAN_Port = $scope.listData.Table1[0].VMS_LAN_Port;

                    $scope.Machine_ID = $scope.listData.Table2[0].Machine_ID;
                    $scope.Machine_Location = $scope.listData.Table2[0].Center_Name;
                    $scope.Weight_URL = $scope.listData.Table2[0].Weight_URL;
                    $scope.Weight_API_Token = $scope.listData.Table2[0].Weight_API_Token;
                    $scope.GI_URL = $scope.listData.Table2[0].GI_URL;
                    $scope.GI_API_Token = $scope.listData.Table2[0].GI_API_Token;
                    $scope.Calibration_URL = $scope.listData.Table2[0].Calibration_URL;
                    $scope.Calibration_API_Token = $scope.listData.Table2[0].Calibration_API_Token;
                    $scope.Image_API_Key = $scope.listData.Table2[0].Image_API_Key;
                    $scope.Image_Secret_Key = $scope.listData.Table2[0].Image_Secret_Key;
                    $scope.Image_Bucket_Name = $scope.listData.Table2[0].Image_Bucket_Name;
                    $scope.Image_Local_File_Path = $scope.listData.Table2[0].Image_Local_File_Path;
                    $scope.Image_key_Name = $scope.listData.Table2[0].Image_key_Name;

                    $scope.FlagDBAddress = $scope.listData.Table3;

                    $scope.editAlarmsDBAddress12 = $scope.listData.Table4;
                    //alert($scope.editAlarmsDBAddress);
                })
            };
            //************************** function To Refresh List

            $scope.editOpen = function (min_Length, min_Width, min_Height, min_Weight, max_Length, max_Width, max_Height, max_Weight) {
                if ($("#editDimentionSetting").css("display") == "none") {
                    $("#editDimentionSetting").modal('show');
                }
                //alert($scope.min_Length);
                $scope.min_Length = min_Length;
                $scope.min_Width = min_Width;
                $scope.min_Height = min_Height;
                $scope.min_Weight = min_Weight;
                $scope.max_Length = max_Length;
                $scope.max_Width = max_Width;
                $scope.max_Height = max_Height;
                $scope.max_Weight = max_Weight;
            }

            $scope.EditMachineSetting = function (Machine_ID, Machine_Location) {
                if ($("#editMachineSetting").css("display") == "none") {
                    $("#editMachineSetting").modal('show');
                }
                $scope.Machine_ID = Machine_ID;
                $scope.Machine_Location = Machine_Location;
            }

            $scope.editDataSentSetting = function (Weight_URL, Weight_API_Token, GI_URL, GI_API_Token, Calibration_URL, Calibration_API_Token) {
                if ($("#editDataSentSetting").css("display") == "none") {
                    $("#editDataSentSetting").modal('show');
                }
                $scope.Weight_URL = Weight_URL;
                $scope.Weight_API_Token = Weight_API_Token;
                $scope.GI_URL = GI_URL;
                $scope.GI_API_Token = GI_API_Token;
                $scope.Calibration_URL = Calibration_URL;
                $scope.Calibration_API_Token = Calibration_API_Token;
            }

            $scope.editImageSentSetting = function (Image_API_Key, Image_Secret_Key, Image_Bucket_Name, Image_Local_File_Path, Image_key_Name) {
                if ($("#editImageSentSetting").css("display") == "none") {
                    $("#editImageSentSetting").modal('show');
                }
                $scope.Image_API_Key = Image_API_Key;
                $scope.Image_Secret_Key = Image_Secret_Key;
                $scope.Image_Bucket_Name = Image_Bucket_Name;
                $scope.Image_Local_File_Path = Image_Local_File_Path;
                $scope.Image_key_Name = Image_key_Name;
            }

            $scope.editIPtSetting = function (Camera_IP, VMS_IP, Check_Weigher_IP, PLC_IP, HMI_IP, Scanner_Port, CheckWeigher_LAN_Port, VMS_LAN_Port) {
                if ($("#editIPtSetting").css("display") == "none") {
                    $("#editIPtSetting").modal('show');
                }
                $scope.Camera_IP = Camera_IP;
                $scope.VMS_IP = VMS_IP;
                $scope.Check_Weigher_IP = Check_Weigher_IP;
                $scope.PLC_IP = PLC_IP;
                $scope.HMI_IP = HMI_IP;
                $scope.Scanner_Port = Scanner_Port;
                $scope.CheckWeigher_LAN_Port = CheckWeigher_LAN_Port;
                $scope.VMS_LAN_Port = VMS_LAN_Port;
            }

            $scope.FlagSetting = function () {
                if ($("#editFlagDBAddress").css("display") == "none") {
                    $("#editFlagDBAddress").modal('show');
                }
            }

            $scope.editAlarmsDBAddress = function () {
                if ($("#editAlarmsDBAddress1").css("display") == "none") {
                    $("#editAlarmsDBAddress1").modal('show');
                }
            }

            $scope.updateMachineSetting = function () {
                swal({
                    title: "Are you sure want to Update ",
                    text: "You will not be able to recover this Parameter!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-warning",
                    confirmButtonText: "Yes, Update it!",
                    cancelButtonText: "No !",
                    closeOnConfirm: true,
                    closeOnCancel: true
                }, function (isConfirm) {
                    if (!isConfirm) return;

                    if ($scope.Machine_ID == undefined || $scope.Machine_ID == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Machine_ID First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.Machine_Location == undefined || $scope.Machine_Location == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Machine Location First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }

                    var httpreq = {
                        method: "POST",
                        url: "MasterSetting.aspx/updateMachineSetting",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { Machine_ID: $scope.Machine_ID, Machine_Location: $scope.Machine_Location },
                    }
                    $http(httpreq).success(function (response) {
                        $scope.successResponce = angular.fromJson(response.d);
                        if ($("#editMachineSetting").css("display") == "block") {
                            $("#editMachineSetting").modal('hide');
                        }
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;

                        $scope.GetData();
                    })
                })
            }

            $scope.UpdateDataSentSetting = function () {
                swal({
                    title: "Are you sure want to Update ",
                    text: "You will not be able to recover this Parameter!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-warning",
                    confirmButtonText: "Yes, Update it!",
                    cancelButtonText: "No !",
                    closeOnConfirm: true,
                    closeOnCancel: true
                }, function (isConfirm) {
                    if (!isConfirm) return;

                    if ($scope.Weight_URL == undefined || $scope.Weight_URL == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Weight URL First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.Weight_API_Token == undefined || $scope.Weight_API_Token == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Machine Weight API Token First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    if ($scope.GI_URL == undefined || $scope.GI_URL == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter GI URL First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.GI_API_Token == undefined || $scope.GI_API_Token == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter GI API Token First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    if ($scope.Calibration_URL == undefined || $scope.Calibration_URL == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Calibration URL First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.Calibration_API_Token == undefined || $scope.Calibration_API_Token == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Calibration API Token First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }

                    var httpreq = {
                        method: "POST",
                        url: "MasterSetting.aspx/UpdateDataSentSetting",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { Weight_URL: $scope.Weight_URL, Weight_API_Token: $scope.Weight_API_Token, GI_URL: $scope.GI_URL, GI_API_Token: $scope.GI_API_Token, Calibration_URL: $scope.Calibration_URL, Calibration_API_Token: $scope.Calibration_API_Token, },
                    }
                    $http(httpreq).success(function (response) {
                        $scope.successResponce = angular.fromJson(response.d);
                        if ($("#editDataSentSetting").css("display") == "block") {
                            $("#editDataSentSetting").modal('hide');
                        }
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;

                        $scope.GetData();
                    })
                })
            }

            $scope.updateImageSentSetting = function () {
                swal({
                    title: "Are you sure want to Update ",
                    text: "You will not be able to recover this Parameter!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-warning",
                    confirmButtonText: "Yes, Update it!",
                    cancelButtonText: "No !",
                    closeOnConfirm: true,
                    closeOnCancel: true
                }, function (isConfirm) {
                    if (!isConfirm) return;

                    if ($scope.Image_API_Key == undefined || $scope.Image_API_Key == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Image API Key First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.Image_Secret_Key == undefined || $scope.Image_Secret_Key == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Image Secret Key First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    if ($scope.Image_Bucket_Name == undefined || $scope.Image_Bucket_Name == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Image Bucket Name First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.Image_Local_File_Path == undefined || $scope.Image_Local_File_Path == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Image Local FilePath First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }

                    var httpreq = {
                        method: "POST",
                        url: "MasterSetting.aspx/updateImageSentSetting",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { Image_API_Key: $scope.Image_API_Key, Image_Secret_Key: $scope.Image_Secret_Key, Image_Bucket_Name: $scope.Image_Bucket_Name, Image_Local_File_Path: $scope.Image_Local_File_Path, Image_key_Name: $scope.Image_key_Name },
                    }
                    $http(httpreq).success(function (response) {
                        $scope.successResponce = angular.fromJson(response.d);
                        if ($("#editImageSentSetting").css("display") == "block") {
                            $("#editImageSentSetting").modal('hide');
                        }
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;

                        $scope.GetData();
                    })
                })
            }

            $scope.UpdateIPtSetting = function () {
                swal({
                    title: "Are you sure want to Update ",
                    text: "You will not be able to recover this Parameter!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-warning",
                    confirmButtonText: "Yes, Update it!",
                    cancelButtonText: "No !",
                    closeOnConfirm: true,
                    closeOnCancel: true
                }, function (isConfirm) {
                    if (!isConfirm) return;

                    if ($scope.Camera_IP == undefined || $scope.Camera_IP == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Image API Key First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.VMS_IP == undefined || $scope.VMS_IP == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Image Secret Key First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.Check_Weigher_IP == undefined || $scope.Check_Weigher_IP == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Check_Weigher_IP First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.PLC_IP == undefined || $scope.PLC_IP == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Image Local FilePath First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.HMI_IP == undefined || $scope.HMI_IP == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter HMI_IP First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.Scanner_Port == undefined || $scope.Scanner_Port == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Scanner_Port First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                        }
                    else if ($scope.CheckWeigher_LAN_Port == undefined || $scope.CheckWeigher_LAN_Port == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter CheckWeigher LAN Port First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    else if ($scope.VMS_LAN_Port == undefined || $scope.VMS_LAN_Port == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter VMS LAN Port First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }

                    var httpreq = {
                        method: "POST",
                        url: "MasterSetting.aspx/UpdateIPtSetting",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { Camera_IP: $scope.Camera_IP, VMS_IP: $scope.VMS_IP, Check_Weigher_IP: $scope.Check_Weigher_IP, PLC_IP: $scope.PLC_IP, HMI_IP: $scope.HMI_IP, Scanner_Port: $scope.Scanner_Port, CheckWeigher_LAN_Port: $scope.CheckWeigher_LAN_Port, VMS_LAN_Port: $scope.VMS_LAN_Port },
                    }
                    $http(httpreq).success(function (response) {
                        $scope.successResponce = angular.fromJson(response.d);
                        if ($("#editIPtSetting").css("display") == "block") {
                            $("#editIPtSetting").modal('hide');
                        }
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;

                        $scope.GetData();
                    })
                })
            }

            $scope.UpdateFlag = function (ID, DBAddress) {
                //alert(DBAddress);
                swal({
                    title: "Are you sure want to Update ",
                    text: "You will not be able to recover this Parameter!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-warning",
                    confirmButtonText: "Yes, Update it!",
                    cancelButtonText: "No !",
                    closeOnConfirm: true,
                    closeOnCancel: true
                }, function (isConfirm) {
                    if (!isConfirm) return;

                        if (DBAddress == undefined || DBAddress == "") {
                        toastr.options.positionClass = 'toast-top-center';
                            toastr.error('Enter DBAddress First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    var httpreq = {
                        method: "POST",
                        url: "MasterSetting.aspx/UpdateFlagDBAddress",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { ID,DBAddress },
                    }
                    $http(httpreq).success(function (response) {
                        $scope.successResponce = angular.fromJson(response.d);
                        
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;

                        $scope.GetData();
                    })
                })
            }

            $scope.closeaddNewFault = function () {
                $('#addNewFault').hide();
            }

            $scope.dismiss = function () {
                $('.modal-backdrop').hide();
                $('#addNewFault').hide();
            }

            $scope.AddNewAlarm = function () {
                alert($scope.txtFault_Name);
                
                var httpreq = {
                    method: "POST",
                    url: "MasterSetting.aspx/InsertAlarm",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { FaultName: $scope.txtFault_Name, DBAddress: $scope.txtDB_Address, RectificationAction: $scope.txtRectification_Action},
                }
                $http(httpreq).success(function (response) {
                    $scope.successResponce = angular.fromJson(response.d);

                    toastr.options.positionClass = 'toast-top-center';
                    toastr.success('Inserted successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;

                    $scope.GetData();
                })


            }

            $scope.UpdateAlarm = function (ID, AlarmDBAddress, Rectification_Action) {
                //alert(DBAddress);
                swal({
                    title: "Are you sure want to Update ",
                    text: "You will not be able to recover this Parameter!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-warning",
                    confirmButtonText: "Yes, Update it!",
                    cancelButtonText: "No !",
                    closeOnConfirm: true,
                    closeOnCancel: true
                }, function (isConfirm) {
                    if (!isConfirm) return;

                        if (AlarmDBAddress == undefined || AlarmDBAddress == "") {
                        toastr.options.positionClass = 'toast-top-center';
                            toastr.error('Enter AlarmDBAddress First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                        }
                        if (Rectification_Action == undefined || Rectification_Action == "") {
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.error('Enter Rectification_Action First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                            return;
                        }
                    var httpreq = {
                        method: "POST",
                        url: "MasterSetting.aspx/UpdateAlarm",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { ID, AlarmDBAddress, Rectification_Action },
                    }
                    $http(httpreq).success(function (response) {
                        $scope.successResponce = angular.fromJson(response.d);

                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;

                        $scope.GetData();
                    })
                })
            }
            
            $scope.UpdateDimentionSetting = function () {
                        swal({
                            title: "Are you sure want to Update ",
                            text: "You will not be able to recover this Parameter!",
                            type: "warning",
                            showCancelButton: true,
                            confirmButtonClass: "btn-warning",
                            confirmButtonText: "Yes, Update it!",
                            cancelButtonText: "No !",
                            closeOnConfirm: true,
                            closeOnCancel: true
                        }, function (isConfirm) {
                            if (!isConfirm) return;

                            if ($scope.min_Length == undefined || $scope.min_Length == "") {
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.error('Enter min length First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                                return;
                            }
                            else if ($scope.min_Width == undefined || $scope.min_Width == "") {
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.error('Enter Image Secret Key First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                                return;
                            }
                            else if ($scope.min_Height == undefined || $scope.min_Height == "") {
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.error('Enter min Height First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                                return;
                            }
                            else if ($scope.min_Weight == undefined || $scope.min_Weight == "") {
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.error('Enter Image Local FilePath First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                                return;
                            }
                            else if ($scope.max_Length == undefined || $scope.max_Length == "") {
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.error('Enter max Length First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                                return;
                            }
                            else if ($scope.max_Width == undefined || $scope.max_Width == "") {
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.error('Enter max Width First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                                return;
                            }
                            else if ($scope.max_Height == undefined || $scope.max_Height == "") {
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.error('Enter max Height First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                                return;
                            }
                            else if ($scope.max_Weight == undefined || $scope.max_Weight == "") {
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.error('Enter max Weight First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                                return;
                            }

                            var httpreq = {
                                method: "POST",
                                url: "MasterSetting.aspx/UpdateDimentionSetting",
                                headers: {
                                    'Content-Type': 'application/json; charset=utf-8',
                                    'dataType': 'json'
                                },
                                data: { min_Length: $scope.min_Length, min_Width: $scope.min_Width, min_Height: $scope.min_Height, min_Weight: $scope.min_Weight, max_Length: $scope.max_Length, max_Width: $scope.max_Width, max_Height: $scope.max_Height, max_Weight: $scope.max_Weight },
                            }
                            $http(httpreq).success(function (response) {
                                $scope.successResponce = angular.fromJson(response.d);
                                if ($("#editDimentionSetting").css("display") == "block") {
                                    $("#editDimentionSetting").modal('hide');
                                }
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.success('Updated successfully ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                                return;

                                $scope.GetData();
                            })
                        })
                    }
        });
    </script>
    <style>
        body {
            color: #566787;
            background: #f5f5f5;
            font-family: 'Varela Round', sans-serif;
            font-size: 13px;
        }

        .table-responsive {
            margin-top: 10px;
            margin-bottom: 8px;
        }

        .table-wrapper {
            min-width: 1000px;
            background: #fff;
            padding: 20px 25px;
            border-radius: 3px;
            box-shadow: 0 1px 1px rgba(0,0,0,.05);
        }

        .table-title {
            padding-bottom: 15px;
            background: #435d7d;
            color: #fff;
            padding: 5px 10px;
            margin: -20px -25px 10px;
            border-radius: 3px 3px 0 0;
        }

            .table-title h2 {
                font-size: 22px;
            }

            .table-title .btn-group {
                float: right;
            }

            .table-title .btn {
                color: #fff;
                float: right;
                font-size: 13px;
                border: none;
                min-width: 50px;
                border-radius: 2px;
                border: none;
                outline: none !important;
                margin-left: 10px;
            }

                .table-title .btn i {
                    float: left;
                    font-size: 21px;
                    margin-right: 5px;
                }

                .table-title .btn span {
                    float: left;
                    margin-top: 2px;
                }

        table.table tr th, table.table tr td {
            border-color: #e9e9e9;
            padding: 4px 2px;
            vertical-align: middle;
        }

            table.table tr th:first-child {
                /*width: 60px;*/
            }

            table.table tr th:last-child {
                width: 100px;
                text-align: center;
            }

        table.table-striped tbody tr:nth-of-type(odd) {
            background-color: #fcfcfc;
        }

        table.table-striped.table-hover tbody tr:hover {
            background: #f5f5f5;
        }

        table.table th i {
            font-size: 13px;
            margin: 0 5px;
            cursor: pointer;
        }

        table.table td:last-child i {
            opacity: 0.9;
            font-size: 22px;
            margin: 0 5px;
        }

        table.table td a {
            font-weight: bold;
            color: #566787;
            display: inline-block;
            text-decoration: none;
            outline: none !important;
        }

            table.table td a:hover {
                color: #2196F3;
            }

            table.table td a.edit {
                color: #FFC107;
            }

            table.table td a.delete {
                color: #F44336;
            }

        table.table td i {
            font-size: 19px;
        }

        .modal-header .close {
            max-width: 50px;
        }

        table.table .avatar {
            border-radius: 50%;
            vertical-align: middle;
            margin-right: 10px;
        }

        .pagination {
            float: right;
            margin: 0 0 5px;
        }

            .pagination li a {
                border: none;
                font-size: 13px;
                min-width: 30px;
                min-height: 30px;
                color: #999;
                margin: 0 2px;
                line-height: 30px;
                border-radius: 2px !important;
                text-align: center;
                padding: 0 6px;
            }

                .pagination li a:hover {
                    color: #666;
                }

            .pagination li.active a, .pagination li.active a.page-link {
                background: #03A9F4;
            }

                .pagination li.active a:hover {
                    background: #0397d6;
                }

            .pagination li.disabled i {
                color: #ccc;
            }

            .pagination li i {
                font-size: 16px;
                padding-top: 6px
            }

        .hint-text {
            float: left;
            margin-top: 10px;
            font-size: 13px;
        }
        /* Custom checkbox */
        .custom-checkbox {
            position: relative;
        }

            .custom-checkbox input[type="checkbox"] {
                opacity: 0;
                position: absolute;
                margin: 5px 0 0 3px;
                z-index: 9;
            }

            .custom-checkbox label:before {
                width: 18px;
                height: 18px;
            }

            .custom-checkbox label:before {
                content: '';
                margin-right: 10px;
                display: inline-block;
                vertical-align: text-top;
                background: white;
                border: 1px solid #bbb;
                border-radius: 2px;
                box-sizing: border-box;
                z-index: 2;
            }

            .custom-checkbox input[type="checkbox"]:checked + label:after {
                content: '';
                position: absolute;
                left: 6px;
                top: 3px;
                width: 6px;
                height: 11px;
                border: solid #000;
                border-width: 0 3px 3px 0;
                transform: inherit;
                z-index: 3;
                transform: rotateZ(45deg);
            }

            .custom-checkbox input[type="checkbox"]:checked + label:before {
                border-color: #03A9F4;
                background: #03A9F4;
            }

            .custom-checkbox input[type="checkbox"]:checked + label:after {
                border-color: #fff;
            }

            .custom-checkbox input[type="checkbox"]:disabled + label:before {
                color: #b8b8b8;
                cursor: auto;
                box-shadow: none;
                background: #ddd;
            }
        /* Modal styles */
        .modal .modal-dialog {
            max-width: 400px;
        }

        .modal .modal-header, .modal .modal-body, .modal .modal-footer {
            padding: 10px 30px;
        }

        .modal-body {
            height: 430px;
            overflow: auto;
        }

        .modal .modal-content {
            border-radius: 3px;
        }

        .modal .modal-footer {
            background: #ecf0f1;
            border-radius: 0 0 3px 3px;
        }

        .modal .modal-title {
            display: inline-block;
        }

        .modal .form-control {
            border-radius: 2px;
            box-shadow: none;
            border-color: #dddddd;
        }

        .modal textarea.form-control {
            resize: vertical;
        }

        .modal .btn {
            border-radius: 2px;
            min-width: 100px;
        }

        .modal form label {
            font-weight: normal;
            color: #000000;
            font-size: 16px;
        }

        @media (min-width: 768px) {
            .modal-dialog {
                width: 1000px;
                margin: 90px auto;
            }
        }

        input, select, textarea, label, p {
            padding: 0;
            margin: 0;
            outline: none;
            font-family: Roboto, Arial, sans-serif;
            font-size: 14px;
            color: #666;
            line-height: 22px;
        }

        h1 {
            position: absolute;
            margin: 0;
            font-size: 40px;
            color: #fff;
            z-index: 2;
            line-height: 83px;
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
            background: #fff;
            box-shadow: 0 0 8px #669999;
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

        .item input:hover, .item select:hover, .item textarea:hover {
            border: 1px solid transparent;
            box-shadow: 0 0 3px 0 #669999;
            color: #669999;
        }

        .item {
            position: relative;
            margin: 4px 0;
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
                width: 48%;
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

        button {
            width: 150px;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background: #669999;
            font-size: 16px;
            color: #fff;
            cursor: pointer;
        }

            button:hover {
                background: #a3c2c2;
            }

        @media (min-width: 568px) {
            .name-item, .city-item {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

                .name-item input, .name-item div {
                    width: calc(50% - 20px);
                }

                    .name-item div input {
                        width: 97%;
                    }

                    .name-item div label {
                        display: block;
                        padding-bottom: 5px;
                    }
        }

        .ip label {
            color: #fff;
        }

        #data .item {
            position: relative;
            margin: 0px 0;
        }

        .table-title a i {
            height: 24px;
        }

        #flag .table-title:hover, #alarm .table-title:hover {
            opacity: 0.8;
        }

        .modal-footer input {
            max-width: 130px;
        }

        .modal-footer {
            justify-content: center;
        }
    </style>
    <script>
        $(document).ready(function () {
            // Activate tooltip
            $('[data-toggle="tooltip"]').tooltip();

            // Select/Deselect checkboxes
            var checkbox = $('table tbody input[type="checkbox"]');
            $("#selectAll").click(function () {
                if (this.checked) {
                    checkbox.each(function () {
                        this.checked = true;
                    });
                } else {
                    checkbox.each(function () {
                        this.checked = false;
                    });
                }
            });
            checkbox.click(function () {
                if (!this.checked) {
                    $("#selectAll").prop("checked", false);
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="Setting" ng-app="myApp" ng-controller="myController">
        <div class="row">
            <div class="col-md-10">
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <div class="table-title">
                            <div class="row">
                                <div class="col-md-6">
                                    <h2 style="color: #fff;">Dimention <b>Setting</b></h2>
                                </div>
                                <div class="col-md-6">
                                    <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal" title="Add"><i class="fas fa-plus-circle"></i><span>Add New Specification</span></a>
                                    <a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal" title="Delete"><i class="fas fa-minus-circle"></i><span>Delete</span></a>
                                </div>
                            </div>
                        </div>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Min Length (cm)</th>
                                    <th>Min Width (cm)</th>
                                    <th>Min Height (cm)</th>
                                    <th>Min Weight (g)</th>
                                    <th>Max Length (cm)</th>
                                    <th>Max Width (cm)</th>
                                    <th>Max Height (cm)</th>
                                    <th>Max Weight (g)</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr ng-repeat="item in DimentionData">
                                    <td>{{item.min_Length}}</td>
                                    <td>{{item.min_Width}}</td>
                                    <td>{{item.min_Height}}</td>
                                    <td>{{item.min_Weight}}</td>
                                    <td>{{item.max_Length}}</td>
                                    <td>{{item.max_Width}}</td>
                                    <td>{{item.max_Height}}</td>
                                    <td>{{item.max_Weight}}</td>
                                    <td>
                                        <a ng-click="editOpen(item.min_Length,item.min_Width,item.min_Height,item.min_Weight,item.max_Length,item.max_Width,item.max_Height,item.max_Weight)" class="edit"><i class="fa fa-edit" data-toggle="tooltip" title="Edit"></i></a>
                                        <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="fas fa-trash" data-toggle="tooltip" title="Delete"></i></a>
                                    </td>
                                </tr>


                            </tbody>
                        </table>
                        <div class="clearfix">
                            <div class="hint-text">Showing <b>1</b> out of <b>1</b> entries</div>
                            <ul class="pagination">
                                <li class="page-item disabled"><a href="#">Previous</a></li>
                                <li class="page-item active"><a href="#" class="page-link">1</a></li>
                                <li class="page-item"><a href="#" class="page-link">2</a></li>
                                <li class="page-item "><a href="#" class="page-link">3</a></li>
                                <li class="page-item"><a href="#" class="page-link">4</a></li>
                                <li class="page-item"><a href="#" class="page-link">5</a></li>
                                <li class="page-item"><a href="#" class="page-link">Next</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pl-0 pr-0">
                        <div class="table-title" style="margin: 0px 0;">
                            <div class="row">
                                <div class="col-md-6">
                                    <h2 style="color: #fff;">Machine <b>Setting</b></h2>
                                </div>

                                <div class="col-md-6">
                                    <a href="#AddMachineSetting" class="btn" data-toggle="modal" title="Add" style="background-color: none;"><i class="fas fa-plus-circle"></i><span></span></a>
                                    <a class="btn" ng-click="EditMachineSetting(Machine_ID,Machine_Location)" title="Edit" style="background-color: none;"><i class="fa fa-edit"></i><span></span></a>
                                </div>
                            </div>
                        </div>
                        <div class="colums" style="padding: 5px;">
                            <div class="item">
                                <label for="Machine_ID">Machine ID <span>*</span></label>
                                <input id="Machine_ID" ng-model="Machine_ID" type="text" name="Machine_ID" title="{{Machine_ID}}" disabled />
                            </div>
                            <div class="item">
                                <label for="Machine_Location">Machine Location <span>*</span></label>
                                <input id="Machine_Location" ng-model="Machine_Location" type="text" name="Machine_Location" title="{{Machine_Location}}" disabled />
                            </div>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pl-0 pr-0" id="data">
                        <div class="table-title" style="margin: 0px 0;">
                            <div class="row">
                                <div class="col-md-6">
                                    <h2 style="color: #fff;">Data Sent <b>Setting</b></h2>
                                </div>
                                <div class="col-md-6">
                                    <a href="#AddDataSentSetting" class="btn" data-toggle="modal" title="Add" style="background-color: none;"><i class="fas fa-plus-circle"></i><span></span></a>
                                    <a class="btn" ng-click="editDataSentSetting(Weight_URL,Weight_API_Token,GI_URL,GI_API_Token,Calibration_URL,Calibration_API_Token)" title="Edit" style="background-color: none;"><i class="fa fa-edit"></i><span></span></a>
                                </div>
                            </div>
                        </div>
                        <div class="colums" style="padding: 5px;">
                            <div class="item">
                                <label for="Weight_URL">Weight URL <span>*</span></label>
                                <input id="Weight_URL" ng-model="Weight_URL" type="text" title="{{Weight_URL}}" name="Weight_URL" disabled />
                            </div>
                            <div class="item">
                                <label for="Weight_API_Token">Weight API Token <span>*</span></label>
                                <input id="Weight_API_Token" ng-model="Weight_API_Token" type="text" title="{{Weight_API_Token}}" name="Weight_API_Token" disabled />
                            </div>
                            <div class="item">
                                <label for="GI_URL">GI URL <span>*</span></label>
                                <input id="GI_URL" ng-model="GI_URL" type="text" name="GI_URL" title="{{GI_URL}}" disabled />
                            </div>
                            <div class="item">
                                <label for="GI_API_Token">GI API Token <span>*</span></label>
                                <input id="GI_API_Token" ng-model="GI_API_Token" type="text" title="{{GI_API_Token}}" name="GI_API_Token" disabled />
                            </div>
                            <div class="item">
                                <label for="Calibration_URL">Calibration URL <span>*</span></label>
                                <input id="Calibration_URL" ng-model="Calibration_URL" type="text" title="{{Calibration_URL}}" name="Calibration_URL" disabled />
                            </div>
                            <div class="item">
                                <label for="Calibration_API_Token">Calibration API Token <span>*</span></label>
                                <input id="Calibration_API_Token" ng-model="Calibration_API_Token" type="text" title="{{Calibration_API_Token}}" name="Calibration_API_Token" disabled />
                            </div>

                        </div>
                    </div>
                </div>
                <div class="row" style="margin-bottom:20px;">
                    <div class="col-md-12 pl-0 pr-0" id="data">
                        <div class="table-title" style="margin: 0px 0;">
                            <div class="row">
                                <div class="col-md-6">
                                    <h2 style="color: #fff;">Image Sent <b>Setting</b></h2>
                                </div>
                                <div class="col-md-6">
                                    <a href="#AddImageSentSetting" class="btn" data-toggle="modal" title="Add" style="background-color: none;"><i class="fas fa-plus-circle"></i><span></span></a>
                                    <a class="btn" ng-click="editImageSentSetting(Image_API_Key,Image_Secret_Key,Image_Bucket_Name,Image_Local_File_Path,Image_key_Name)" title="Edit" style="background-color: none;"><i class="fa fa-edit"></i><span></span></a>
                                </div>
                            </div>
                        </div>
                        <div class="colums" style="padding: 5px;">
                            <div class="item">
                                <label for="Image_API_Key">API Key <span>*</span></label>
                                <input id="Image_API_Key" ng-model="Image_API_Key" type="text" title="{{Image_API_Key}}" name="Image_API_Key" disabled />
                            </div>
                            <div class="item">
                                <label for="Image_Secret_Key">Secret Key <span>*</span></label>
                                <input id="Image_Secret_Key" ng-model="Image_Secret_Key" type="text" title="{{Image_Secret_Key}}" name="Image_Secret_Key" disabled />
                            </div>
                            <div class="item">
                                <label for="Image_Bucket_Name">Bucket Name <span>*</span></label>
                                <input id="Image_Bucket_Name" ng-model="Image_Bucket_Name" type="text" title="{{Image_Bucket_Name}}" name="Image_Bucket_Name" disabled />
                            </div>
                            <div class="item">
                                <label for="Image_Local_File_Path">Local File Path <span>*</span></label>
                                <input id="Image_Local_File_Path" ng-model="Image_Local_File_Path" type="text" title="{{Image_Local_File_Path}}" name="Image_Local_File_Path" disabled />
                            </div>
                            <div class="item">
                                <label for="Image_key_Name">key Name <span>*</span></label>
                                <input id="Image_key_Name" ng-model="Image_key_Name" type="text" title="{{Image_key_Name}}" name="Image_key_Name" disabled />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="table-title" style="margin: 10px 0;">
                    <div class="row">
                        <div class="col-md-12 pl-0 pr-0" style="display: flex;">
                            <h2 style="color: #fff;">IP <b>Setting</b></h2>
                            <i class="fa fa-edit" ng-click="editIPtSetting(Camera_IP,VMS_IP,Check_Weigher_IP,PLC_IP,HMI_IP,Scanner_Port,CheckWeigher_LAN_Port,VMS_LAN_Port)" data-toggle="tooltip" title="Edit IP" style="padding: 7px; font-size: 18px; color: #ffc781; margin-left: 60px; cursor: pointer;"></i>
                        </div>

                    </div>
                    <hr />
                    <div class="ip">
                        <div class="form-group">
                            <label>Camera  </label>
                            <input type="text" ng-model="Camera_IP" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label>VMS </label>
                            <input type="text" ng-model="VMS_IP" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label>Check Weigher</label>
                            <input type="text" ng-model="Check_Weigher_IP" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label>PLC</label>
                            <input type="text" ng-model="PLC_IP" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label>HMI</label>
                            <input type="text" ng-model="HMI_IP" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label>Scanner Port</label>
                            <input type="text" ng-model="Scanner_Port" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label>CheckWeigher LAN Port</label>
                            <input type="text" ng-model="CheckWeigher_LAN_Port" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label>VMS LAN Port</label>
                            <input type="text" ng-model="VMS_LAN_Port" class="form-control" disabled>
                        </div>
                    </div>
                </div>
                <div class="row" id="flag">
                    <div class="col-md-12 pl-0 pr-0">
                        <div class="table-title" style="margin: 2px 0; cursor: pointer;" ng-click="FlagSetting()">
                            <h2 style="color: #fff; font-size: 18px;"><i class="far fa-hand-point-right"></i>Flag <b>Setting</b></h2>
                        </div>
                    </div>
                </div>
                <div class="row" id="alarm">
                    <div class="col-md-12 pl-0 pr-0">
                        <div class="table-title" style="margin: 2px 0; cursor: pointer;" ng-click="editAlarmsDBAddress()">
                            <h2 style="color: #fff; font-size: 18px;"><i class="far fa-hand-point-right"></i>Alarm's <b>Setting</b></h2>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!-- add Modal HTML -->
        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add Dimention</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="colums">
                            <div class="item">
                                <label for="txtLength">Min Length (cm)<span>*</span></label>
                                <input id="txtLength" type="text" name="txtLength" required />
                            </div>
                            <div class="item">
                                <label for="txtWidth">Min Width (cm)<span>*</span></label>
                                <input id="txtWidth" type="text" name="txtWidth" required />
                            </div>
                            <div class="item">
                                <label for="txtHeight">Min Height (cm)<span>*</span></label>
                                <input id="txtHeight" type="text" name="txtHeight" required />
                            </div>
                            <div class="item">
                                <label for="txtWeight">Min Weight (g)<span>*</span></label>
                                <input id="txtWeight" type="text" name="txtWeight" required />
                            </div>
                            <div class="item">
                                <label for="mtxtLength">Max Length (cm)<span>*</span></label>
                                <input id="mtxtLength" type="text" name="mtxtLength" required />
                            </div>
                            <div class="item">
                                <label for="mtxtWidth">Max Width (cm)<span>*</span></label>
                                <input id="mtxtWidth" type="text" name="mtxtWidth" required />
                            </div>
                            <div class="item">
                                <label for="mtxtHeight">Max Height (cm)<span>*</span></label>
                                <input id="mtxtHeight" type="text" name="mtxtHeight" required />
                            </div>
                            <div class="item">
                                <label for="mtxtWeight">Max Weight (g)<span>*</span></label>
                                <input id="mtxtWeight" type="text" name="mtxtWeight" required />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                        <input type="submit" class="btn btn-success" value="Add">
                    </div>
                </div>
            </div>
        </div>
        <!-- Edit Dimentions HTML -->
        <div id="editDimentionSetting" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Dimentions</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="colums">
                                <div class="item">
                                    <label for="min_Length">Min Length (cm)<span>*</span></label>
                                    <input id="min_Length" ng-model="min_Length" type="text" name="min_Length" required />
                                </div>
                                <div class="item">
                                    <label for="min_Width">Min Width (cm)<span>*</span></label>
                                    <input id="min_Width" ng-model="min_Width" type="text" name="min_Width" required />
                                </div>
                                <div class="item">
                                    <label for="min_Height">Min Height (cm)<span>*</span></label>
                                    <input id="min_Height" ng-model="min_Height" type="text" name="min_Height" required />
                                </div>
                                <div class="item">
                                    <label for="min_Weight">Min Weight (g)<span>*</span></label>
                                    <input id="min_Weight" ng-model="min_Weight" type="text" name="min_Weight" required />
                                </div>
                                <div class="item">
                                    <label for="max_Length">Max Length (cm)<span>*</span></label>
                                    <input id="max_Length" ng-model="max_Length" type="text" name="max_Length" required />
                                </div>
                                <div class="item">
                                    <label for="max_Width">Max Width (cm)<span>*</span></label>
                                    <input id="max_Width" ng-model="max_Width" type="text" name="max_Width" required />
                                </div>
                                <div class="item">
                                    <label for="max_Height">Max Height (cm)<span>*</span></label>
                                    <input id="max_Height" ng-model="max_Height" type="text" name="max_Height" required />
                                </div>
                                <div class="item">
                                    <label for="max_Weight">Max Weight (g)<span>*</span></label>
                                    <input id="max_Weight" ng-model="max_Weight" type="text" name="max_Weight" required />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-info" ng-click="UpdateDimentionSetting()" value="Update">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Delete Modal HTML -->
        <div id="deleteEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Delete Dimention</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete these Records?</p>
                            <p class="text-warning"><small>This action cannot be undone.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-danger" value="Delete">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Machine Setting HTML -->
        <div id="editMachineSetting" class="modal fade">
            <div class="modal-dialog" style="max-width: 600px;">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Machine Setting</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="colums">
                                <div class="item">
                                    <label for="Machine_ID">Machine ID <span>*</span></label>
                                    <input id="Machine_ID" ng-model="Machine_ID" type="text" name="Machine_ID" required />
                                </div>
                                <div class="item">
                                    <label for="Machine_Location">Machine Location <span>*</span></label>
                                    <input id="Machine_Location" ng-model="Machine_Location" type="text" name="Machine_Location" required />
                                </div>
                            </div>
                            <p>Are you sure you want to edit these Records?</p>
                            <p class="text-warning"><small>This is very confidinicial data.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-warning" value="Update" ng-click="updateMachineSetting()">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Add Machine Setting HTML -->
        <div id="AddMachineSetting" class="modal fade">
            <div class="modal-dialog" style="max-width: 600px;">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Add Machine Setting</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="colums">
                                <div class="item">
                                    <label for="txtMachine_ID">Machine ID <span>*</span></label>
                                    <input id="txtMachine_ID" type="text" name="txtMachine_ID" required />
                                </div>
                                <div class="item">
                                    <label for="txtMachine_Location">Machine Location <span>*</span></label>
                                    <input id="txtMachine_Location" type="text" name="txtMachine_Location" required />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-primery" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Data Sent Setting HTML -->
        <div id="editDataSentSetting" class="modal fade">
            <div class="modal-dialog" style="max-width: 1000px;">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Data Sent Setting</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="colums">
                                <div class="item">
                                    <label for="Weight_URL">Weight URL <span>*</span></label>
                                    <input id="Weight_URL" ng-model="Weight_URL" type="text" name="Weight_URL" required />
                                </div>
                                <div class="item">
                                    <label for="Weight_API_Token">Weight API Token <span>*</span></label>
                                    <input id="Weight_API_Token" ng-model="Weight_API_Token" type="text" name="Weight_API_Token" required />
                                </div>
                                <div class="item">
                                    <label for="GI_URL">GI URL <span>*</span></label>
                                    <input id="GI_URL" ng-model="GI_URL" type="text" name="GI_URL" required />
                                </div>
                                <div class="item">
                                    <label for="GI_API_Token">GI API Token <span>*</span></label>
                                    <input id="GI_API_Token" ng-model="GI_API_Token" type="text" name="GI_API_Token" required />
                                </div>
                                <div class="item">
                                    <label for="Calibration_URL">Calibration URL <span>*</span></label>
                                    <input id="Calibration_URL" ng-model="Calibration_URL" type="text" name="Calibration_URL" required />
                                </div>
                                <div class="item">
                                    <label for="Calibration_API_Token">Calibration API Token <span>*</span></label>
                                    <input id="Calibration_API_Token" ng-model="Calibration_API_Token" type="text" name="Calibration_API_Token" required />
                                </div>
                            </div>
                            <p>Are you sure you want to edit these Records?</p>
                            <p class="text-warning"><small>This is very confidinicial data.</small></p>
                        </div>
                        <div class="modal-footer" style="justify-content: center;">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-warning" value="Update" ng-click="UpdateDataSentSetting()">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Add Data Sent Setting HTML -->
        <div id="AddDataSentSetting" class="modal fade">
            <div class="modal-dialog" style="max-width: 1000px;">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Add Data Sent Setting</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="colums">
                                <div class="item">
                                    <label for="txtWeight_URL">Weight URL <span>*</span></label>
                                    <input id="txtWeight_URL" type="text" name="txtWeight_URL" required />
                                </div>
                                <div class="item">
                                    <label for="txtWeight_API_Token">Weight API Token <span>*</span></label>
                                    <input id="txtWeight_API_Token" type="text" name="txtWeight_API_Token" required />
                                </div>
                                <div class="item">
                                    <label for="txtGI_URL">GI URL <span>*</span></label>
                                    <input id="txtGI_URL" type="text" name="txtGI_URL" required />
                                </div>
                                <div class="item">
                                    <label for="txtGI_API_Token">GI API Token <span>*</span></label>
                                    <input id="txtGI_API_Token" type="text" name="txtGI_API_Token" required />
                                </div>
                                <div class="item">
                                    <label for="txtCalibration_URL">Calibration URL <span>*</span></label>
                                    <input id="txtCalibration_URL" type="text" name="txtCalibration_URL" required />
                                </div>
                                <div class="item">
                                    <label for="txtCalibration_API_Token">Calibration API Token <span>*</span></label>
                                    <input id="txtCalibration_API_Token" type="text" name="txtCalibration_API_Token" required />
                                </div>
                            </div>
                            <p class="text-warning"><small>This is very confidinicial data.</small></p>
                        </div>
                        <div class="modal-footer" style="justify-content: center;">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-warning" value="Edit">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Image Sent Setting HTML -->
        <div id="editImageSentSetting" class="modal fade">
            <div class="modal-dialog" style="max-width: 1000px;">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Image Sent Setting</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="colums">
                                <div class="item">
                                    <label for="Image_API_Key">Image API Key <span>*</span></label>
                                    <input id="Image_API_Key" ng-model="Image_API_Key" type="text" name="Image_API_Key" required />
                                </div>
                                <div class="item">
                                    <label for="Image_Secret_Key">Image Secret Key <span>*</span></label>
                                    <input id="Image_Secret_Key" ng-model="Image_Secret_Key" type="text" name="Image_Secret_Key" required />
                                </div>
                                <div class="item">
                                    <label for="Image_Bucket_Name">Image Bucket Name <span>*</span></label>
                                    <input id="Image_Bucket_Name" ng-model="Image_Bucket_Name" type="text" name="Image_Bucket_Name" required />
                                </div>
                                <div class="item">
                                    <label for="Image_Local_File_Path">Image Local FilePath <span>*</span></label>
                                    <input id="Image_Local_File_Path" ng-model="Image_Local_File_Path" type="text" name="Image_Local_File_Path" required />
                                </div>
                                <div class="item">
                                    <label for="Image_key_Name">Image keyName <span>*</span></label>
                                    <input id="Image_key_Name" ng-model="Image_key_Name" type="text" name="Image_key_Name" required />
                                </div>
                            </div>
                            <p>Are you sure you want to edit these Records?</p>
                            <p class="text-warning"><small>This is very confidinicial data.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-warning" value="Update" ng-click="updateImageSentSetting()">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Add Image Sent Setting HTML -->
        <div id="AddImageSentSetting" class="modal fade">
            <div class="modal-dialog" style="max-width: 1000px;">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Image Sent Setting</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="colums">
                                <div class="item">
                                    <label for="txtImage_API_Key">Image API Key <span>*</span></label>
                                    <input id="txtImage_API_Key" type="text" name="txtImage_API_Key" required />
                                </div>
                                <div class="item">
                                    <label for="txtImage_Secret_Key">Image Secret Key <span>*</span></label>
                                    <input id="txtImage_Secret_Key" type="text" name="txtImage_Secret_Key" required />
                                </div>
                                <div class="item">
                                    <label for="txtImage_Bucket_Name">Image Bucket Name <span>*</span></label>
                                    <input id="txtImage_Bucket_Name" type="text" name="txtImage_Bucket_Name" required />
                                </div>
                                <div class="item">
                                    <label for="txtImage_Local_File_Path">Image Local FilePath <span>*</span></label>
                                    <input id="txtImage_Local_File_Path" type="text" name="txtImage_Local_File_Path" required />
                                </div>
                                <div class="item">
                                    <label for="txtImage_key_Name">Image keyName <span>*</span></label>
                                    <input id="txtImage_key_Name" type="text" name="txtImage_key_Name" required />
                                </div>
                            </div>
                            <p class="text-warning"><small>This is very confidinicial data.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-warning" value="Edit">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit IP Setting HTML -->
        <div id="editIPtSetting" class="modal fade">
            <div class="modal-dialog" style="max-width: 1000px;">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Edit IP Setting</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="colums">
                                <div class="item">
                                    <label for="Camera_IP">Camera IP <span>*</span></label>
                                    <input id="Camera_IP" ng-model="Camera_IP" type="text" name="Camera_IP" required />
                                </div>
                                <div class="item">
                                    <label for="VMS_IP">VMS IP <span>*</span></label>
                                    <input id="VMS_IP" ng-model="VMS_IP" type="text" name="VMS_IP" required />
                                </div>
                                <div class="item">
                                    <label for="Check_Weigher_IP">Check Weigher IP <span>*</span></label>
                                    <input id="Check_Weigher_IP" ng-model="Check_Weigher_IP" type="text" name="Check_Weigher_IP" required />
                                </div>
                                <div class="item">
                                    <label for="PLC_IP">PLC IP <span>*</span></label>
                                    <input id="PLC_IP" ng-model="PLC_IP" type="text" name="PLC_IP" required />
                                </div>
                                <div class="item">
                                    <label for="HMI_IP">HMI IP <span>*</span></label>
                                    <input id="HMI_IP" ng-model="HMI_IP" type="text" name="HMI_IP" required />
                                </div>
                                <div class="item">
                                    <label for="Scanner_Port">Scanner Port <span>*</span></label>
                                    <input id="Scanner_Port" ng-model="Scanner_Port" type="text" name="Scanner_Port" required />
                                </div>
                                <div class="item">
                                    <label for="CheckWeigher_LAN_Port">CheckWeigher LAN Port<span>*</span></label>
                                    <input id="CheckWeigher_LAN_Port" ng-model="CheckWeigher_LAN_Port" type="text" name="CheckWeigher_LAN_Port" required />
                                </div>
                                <div class="item">
                                    <label for="VMS_LAN_Port">VMS LAN Port<span>*</span></label>
                                    <input id="VMS_LAN_Port" ng-model="VMS_LAN_Port" type="text" name="VMS_LAN_Port" required />
                                </div>
                            </div>
                            <p>Are you sure you want to edit these Records?</p>
                            <p class="text-warning"><small>This is very confidinicial data.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-warning" value="Update" ng-click="UpdateIPtSetting()">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Flag DBAddress HTML -->
        <div id="editFlagDBAddress" class="modal fade">
            <div class="modal-dialog" style="max-width: 1000px;">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Flag DBAddress</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body" style="padding: 0px 20px;">
                            <div class="colums">
                                <input type="text" class="form-control" id="SearchFlag" aria-describedby="SearchHelp" placeholder="Enter Flter">
                                <div class="item" ng-repeat="item in FlagDBAddress" id="FlagDBAddress">
                                    <label for="Camera_IP" id="Description">{{item.Description}} <span>*</span></label>
                                    <input id="DBAddress" ng-model="item.DBAddress" type="text" name="DBAddress" required /><i class="far fa-save" ng-click="UpdateFlag(item.ID,item.DBAddress)" ng-show="item.DBAddress" id="{{item.ID}}" title="Edit" style="margin-right: 14px;"></i>
                                </div>

                            </div>
                            <p>Are you sure you want to edit these Records?</p>
                            <p class="text-warning"><small>This is very confidinicial data.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-warning" value="Update">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Alarms DBAddress HTML -->
        <div id="editAlarmsDBAddress1" class="modal fade">
            <div class="modal-dialog" style="max-width: 1000px;">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Alarms DBAddress</h4>
                            <a href="#addNewFault" class="btn btn-success" data-toggle="modal" title="Add" style="margin: 0px 15px;"><i class="fas fa-plus-circle"></i><span>Add New Fault</span></a>
                            <button type="button" class="close" ng-click="dismiss()" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="colums" id="addNewFault" style="display:none ;background-color: #edfbff;padding: 9px;">
                                <h4>Add New Alarms</h4>
                                <div class="item" style="width: 100%;">
                                    <label for="txtFault_Name">Fault Name <span>*</span></label>
                                    <input id="txtFault_Name" ng-model="txtFault_Name" type="text" name="txtFault_Name" required />
                                </div>
                                <div class="item" style="width: 100%;">
                                    <label for="txtDB_Address">DB Address <span>*</span></label>
                                    <input id="txtDB_Address" ng-model="txtDB_Address" type="text" name="txtDB_Address" required />
                                </div>
                                <div class="item" style="width: 100%;">
                                    <label for="txtRectification_Action">Rectification Action <span>*</span></label>
                                    <input id="txtRectification_Action" ng-model="txtRectification_Action" type="text" name="txtRectification_Action" required />
                                </div>
                                <div style="display:flex;">
                                <button class="btn btn-primary" value="save" style="margin-left: 80%;" ng-click="AddNewAlarm()">Save</button>
                                <button class="btn btn-info" value="Cancel" style="margin-left: 3%;" ng-click="closeaddNewFault()">Cancel</button>
                                </div>
                            </div>
                            
                            <div class="colums">
                                
                                <input type="text" class="form-control" id="SearchAlarms" aria-describedby="SearchHelp" placeholder="Enter Flter" style="margin-top:30px;">
                                <div class="item" ng-repeat="item in editAlarmsDBAddress12" id="AlarmsDBAddress">
                                    <b>
                                        <label for="Camera_IP" id="FaultName">{{item.FaultName}} <span>*</span></label></b>
                                    <input id="AlarmDBAddress" ng-model="item.AlarmDBAddress" type="text" name="AlarmDBAddress" title="{{item.AlarmDBAddress}}" required />
                                    <input id="Rectification_Action" ng-model="item.Rectification_Action" type="text" name="Rectification_Action" title="{{item.Rectification_Action}}" required /><i class="far fa-save" ng-click="UpdateAlarm(item.ID,item.AlarmDBAddress,item.Rectification_Action)" id="{{item.ID}}" title="Edit" style="margin-right: 14px;cursor:pointer;"></i>
                                    <i class="far fa-trash-alt" ng-click="DeleteAlarm(item.ID)" id="{{item.ID}}" title="Delete" style="margin-right: 50px;color:#e24a4a;cursor:pointer;"></i>

                                </div>
                            </div>
                            <p>Are you sure you want to edit these Records?</p>
                            <p class="text-warning"><small>This is very confidinicial data.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel" ng-click="dismiss()">
                            <input type="submit" class="btn btn-warning" value="Update">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
