<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="user_management.aspx.cs" Inherits="DWS_Profiler.Pages.user_management" MasterPageFile="~/Base.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../JS/Chart.min.js"></script>
    <script src="/../JS/angular-chart.min.js"></script>
    <%--<script src="../JS/angular.min.js"></script>--%>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%--<link href="../global/css/bootstrap.min.css" rel="stylesheet" />--%>
    <title>Delhivery | Users </title>
    <style>
        .input-group .input-group-addon {
            display: none;
        }

        .user_screen .user-manag-left-table tr th {
            font-family: 'ibm_plex_sansbold';
            font-size: 16px;
        }

        .user-manag-left-table .show-accordion-parent {
            border: 1px solid #ccc;
        }

        .fr_padd {
            padding: 10px 0px;
        }

        .user_screen .user-manag-right-table select {
            padding-right: 25px
        }

        .reset_btn label {
            display: block;
        }

        #add-user-btn {
            border: none;
            border-radius: calc(.5 * var(--cr-button-height));
            box-shadow: 0 3px 6px rgb(0 0 0 / 16%), 0 1px 2px rgb(0 0 0 / 23%);
            font-weight: 400;
            min-width: 32px;
        }

        #search-user-btn {
            border: none;
            border-radius: calc(.5 * var(--cr-button-height));
            box-shadow: 0 3px 6px rgb(0 0 0 / 16%), 0 1px 2px rgb(0 0 0 / 23%);
            font-weight: 400;
            min-width: 32px;
        }

        #btnSave1 {
            border: none;
            border-radius: calc(.5 * var(--cr-button-height));
            box-shadow: 0 3px 6px rgb(0 0 0 / 16%), 0 1px 2px rgb(0 0 0 / 23%);
            font-weight: 400;
            min-width: 32px;
        }

        #btnSave {
            border: none;
            border-radius: calc(.5 * var(--cr-button-height));
            box-shadow: 0 3px 6px rgb(0 0 0 / 16%), 0 1px 2px rgb(0 0 0 / 23%);
        }

        #reset_btn {
            border: none;
            border-radius: calc(.5 * var(--cr-button-height));
            box-shadow: 0 3px 6px rgb(0 0 0 / 16%), 0 1px 2px rgb(0 0 0 / 23%);
        }
    </style>
    <script>
        var myApp = angular.module("myApp", ["chart.js"]);
        myApp.controller("myController", function ($scope, $http) {
            $scope.inlistData = <%=listData%>; //;// Bind Your List Data here
            $scope.orderList = 'Name';
            $scope.orderDirection = false;
            $scope.IDPwdData = [], [];
            $scope.hiddenId = 0;
            $scope.txtSearch = '';
            $scope.txtUserGroup = 0;
            $scope.txtUserGroup111 = 0;
            $scope.txtUserGroup1111 = 0;
            $scope.txtUserID1 = 0;
            $scope.listData = angular.fromJson($scope.inlistData);
            $scope.UserGListRData ='<%= UGlistData %>';
            $scope.UGlistData = angular.fromJson($scope.UserGListRData);

            $scope.inUGAcessRightData_UG ='<%=UserAccessRightlistData_UG%>';
            if ($scope.inUGAcessRightData_UG.length > 0) {
                $scope.UserGrouplistData_UserGroup = angular.fromJson($scope.inUGAcessRightData_UG);
            }
            $scope.inUserGroup = '<%=listData1%>';
            if ($scope.inUserGroup.length > 0) {
                $scope.UserGrouplistData = angular.fromJson($scope.inUserGroup);
            }

            //************************** function To Refresh List
            $scope.RefreshList = function () {
                var httpreq = {
                    method: "POST",
                    url: "user_management.aspx/GetList",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: {},
                }
                $http(httpreq).success(function (response) {
                    $scope.listData = angular.fromJson(response.d);
                    $scope.txtLoginName = "";
                    $scope.txtName = "";
                    $scope.txtusergroupid2 = "";
                    $scope.txtUserGroup = 0;
                    $scope.hiddenId = 0;
                    $scope.txtPassword = "";
                    $scope.txtrePassword = "";
                    $scope.HeadingName = true;
                    $scope.selectUserGroup();
                })
            };
            $scope.Reset = function () {
                $scope.txtLoginName = "";
                $scope.txtName = "";
                $scope.txtusergroupid2 = "";
                $scope.txtUserGroup = 0;
                $scope.hiddenId = 0;
                $scope.txtPassword = "";
                $scope.txtrePassword = "";

            }
            $scope.bindMenu = function () {
                var httpreq = {
                    method: "POST",
                    url: "user_management.aspx/FetchMenu",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: {},
                }
                $http(httpreq).success(function (response) {
                    $scope.listMenuData = angular.fromJson(response.d);
                    $scope.GetUserGroupData11();

                })
            };

            $scope.BindSingleUser = function (GroupId) {

                var httpreq = {
                    method: "POST",
                    url: "user_management.aspx/GetUserList",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { GroupId: GroupId },
                }
                $http(httpreq).success(function (response) {
                    $scope.BindUser = angular.fromJson(response.d);



                })
            };


            $scope.bindMenu();
            $scope.selectUserGroup = function () { $scope.GetUserGroupData11(); }
            $scope.GetUserGroupData11 = function () {
                var e = document.getElementById("txtUserGroup111");
                $scope.txtusergroupid121 = e.options[e.selectedIndex].value;
                if ($scope.txtusergroupid121 == 0) {
                    $scope.txtUserID1 = 0;
                }
                var httpreq = {
                    method: "POST",
                    dataType: "jsonp",
                    url: "user_management.aspx/FetchSingleMenu",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { MenuId: $scope.txtusergroupid121 },
                };

                $http(httpreq).success(function (response) {

                    var s = angular.fromJson(response.d);
                    if (s.length > 0) {
                        $('input:checkbox').removeAttr('checked');
                        var UserGrouplistData_UG = angular.fromJson(response.d);
                        for (var cnt = 0; cnt < UserGrouplistData_UG.length; cnt++) {
                            var MenuId = UserGrouplistData_UG[cnt].MenuId;
                            var ca = UserGrouplistData_UG[cnt].CheckCanAdd;
                            var add = "#chkAddAdmin_" + MenuId;
                            if (ca == true) {
                                $(add).prop("checked", true);
                            }
                            else { $(add).prop("checked", false); }

                            var ce = UserGrouplistData_UG[cnt].CheckCanEdit;
                            var edit = "#chkEditAdmin_" + MenuId;
                            if (ce == true) { $(edit).prop("checked", true); }
                            else { $(edit).prop("checked", false); }

                            var cv = UserGrouplistData_UG[cnt].CheckCanView;
                            var view = "#chkViewAdmin_" + MenuId;
                            if (cv == true) {
                                $(view).prop("checked", true);
                            }
                            else { $(view).prop("checked", false); }

                            var cd = UserGrouplistData_UG[cnt].CheckCanDelete;
                            var del = "#chkDeleteAdmin_" + MenuId;
                            if (cd == true) {
                                $(del).prop("checked", true);
                            }
                            else { $(del).prop("checked", false); }

                            var gn = UserGrouplistData_UG[cnt].GroupName;
                        }
                        $scope.BindSingleUser($scope.txtusergroupid121);

                    }
                });
            }

            $scope.BindDataForSigleUser = function () {
                var e = document.getElementById("txtUserID1");
                $scope.txtSigleUserId = e.options[e.selectedIndex].value;
                var httpreq = {
                    method: "POST",
                    dataType: "jsonp",
                    url: "user_management.aspx/FetchMenuForSingleUser",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { Userid: $scope.txtSigleUserId },
                };

                $http(httpreq).success(function (response) {

                    var s = angular.fromJson(response.d);
                    if (s.length > 0) {
                        $('input:checkbox').removeAttr('checked');
                        var UserGrouplistData_UG = angular.fromJson(response.d);
                        for (var cnt = 0; cnt < UserGrouplistData_UG.length; cnt++) {
                            var MenuId = UserGrouplistData_UG[cnt].MenuId;
                            var ca = UserGrouplistData_UG[cnt].CheckCanAdd;
                            var add = "#chkAddAdmin_" + MenuId;
                            if (ca == true) {
                                $(add).prop("checked", true);
                            }
                            else { $(add).prop("checked", false); }

                            var ce = UserGrouplistData_UG[cnt].CheckCanEdit;
                            var edit = "#chkEditAdmin_" + MenuId;
                            if (ce == true) { $(edit).prop("checked", true); }
                            else { $(edit).prop("checked", false); }

                            var cv = UserGrouplistData_UG[cnt].CheckCanView;
                            var view = "#chkViewAdmin_" + MenuId;
                            if (cv == true) {
                                $(view).prop("checked", true);
                            }
                            else { $(view).prop("checked", false); }

                            var cd = UserGrouplistData_UG[cnt].CheckCanDelete;
                            var del = "#chkDeleteAdmin_" + MenuId;
                            if (cd == true) {
                                $(del).prop("checked", true);
                            }
                            else { $(del).prop("checked", false); }

                            var gn = UserGrouplistData_UG[cnt].GroupName;
                        }
                    }
                });
            }

            $scope.SaveData = function () {


                if ($scope.txtUserGroup111 == 0) {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Please select user group first..', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                    document.getElementById("tblRow").style.display = "table-row";
                    return;
                }
                if ($scope.txtUserID1 == 0) {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Please select user first..', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;

                }
                var cnt = 0;
                var AccessRights = "";
                var AccessRights2 = "";


                for (; cnt < $scope.listMenuData.length; cnt++) {

                    var MenuId = $scope.listMenuData[cnt].MenuId;
                    var para = $('#lbl_ID_' + MenuId);


                    var add = "#chkAddAdmin_" + MenuId;
                    var contents = $(add);//$('#chk_CA_' + cnt);
                    var edit = "#chkEditAdmin_" + MenuId;
                    var contents2 = $(edit);//$('#chk_CE_' + cnt);
                    var view = "#chkViewAdmin_" + MenuId;
                    var contents3 = $(view);//$('#chk_CV_' + cnt);
                    var del = "#chkDeleteAdmin_" + MenuId;
                    var contents4 = $(del);

                    AccessRights += para.text().trim() + "," + contents.prop("checked") + "," + contents2.prop("checked") + "," + contents3.prop("checked") + "," + contents4.prop("checked") + "|";

                }
                AccessRights = AccessRights.substring(0, AccessRights.length - 1);

                var e = document.getElementById("txtUserGroup111");
                $scope.txtusergroupid12 = e.options[e.selectedIndex].value;
                var e = document.getElementById("txtUserID1");
                $scope.txtuserId = e.options[e.selectedIndex].value;

                var httpreq = {
                    method: "POST",
                    dataType: "jsonp",
                    url: "user_management.aspx/SaveData",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { AccessRights: AccessRights, MenuId: $scope.txtusergroupid12, UserId: $scope.txtuserId },
                };
                $http(httpreq).success(function (response) {
                    var resu = response.d;

                    toastr.success('Access Rights saved successfully', '', {
                        iconClass: 'toast-just-text toast-success',
                        positionClass: 'toast-top-right',
                        containertId: 'toast-top-right',
                        closeButton: 'true',
                        preventDuplicates: 'true'
                    });
                });
            }
            $scope.ShowAddUserGroup = function () {

                $('#add-userGroup-btn').hide();
                $('#groupAdd').show();
                $('#close-userGroup-btn').show();
            }

            $scope.CloseUserGroup = function () {

                $('#add-userGroup-btn').show();
                $('#groupAdd').hide();
                $('#close-userGroup-btn').hide();
            }

            $scope.SaveGroup = function () {

                $scope.txtGruopName = document.getElementById("txtGruopName1").value;
                $scope.txtGruopDesc = document.getElementById("txtGruopDesc").value;

                if ($scope.txtGruopName == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Group name enter first', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                if ($scope.txtGruopDesc == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter description first', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }

                var obj = { GroupName: $scope.txtGruopName, Description: $scope.txtGruopDesc };
                var JSONData = JSON.stringify(obj);

                var httpreq = {
                    method: "POST",
                    url: "user_management.aspx/SaveGroupName",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { JSONData },
                }
                $http(httpreq).success(function (response) {
                    $scope.hiddenId = angular.fromJson(response.d);  // save function should send Id of records, which will be store back to hidden field
                    if ($scope.hiddenId != 0) {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('User group Saved Successfully...!!', 'Done', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        $('.add-user-field').hide();
                        $scope.listData = angular.fromJson($scope.inlistData);
                        $scope.UserGListRData = '<%= UGlistData %>';
                        $scope.UGlistData = angular.fromJson($scope.UserGListRData);
                        $scope.RefreshList();

                    }
                    else {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('UserGroup already present..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }

                })
            }

            $scope.Save = function (index) {
                if (index != 0) {
                    $scope.txtLoginName = document.getElementById("LoginName_" + index).value;
                    $scope.txtName = document.getElementById("Name_" + index).value;
                    var e = document.getElementById("UserGroup_" + index);
                    $scope.txtusergroupid2 = e.options[e.selectedIndex].value;
                    var hidderValue = document.getElementById('Id_' + index).value;
                    $scope.hiddenId = hidderValue;

                    $scope.txtPassword = document.getElementById("Password_" + index).value;

                    $scope.txtPassword1 = document.getElementById("rePassword_" + index).value;

                    if ($scope.txtPassword != $scope.txtPassword1) {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Password do not match', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }

                    if ($scope.txtLoginName == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Name..', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    if ($scope.txtName == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter User Name..', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    if ($scope.txtusergroupid2 == 0) {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Please select User Group..', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }
                    if ($scope.txtPassword == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Please Enter password', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }

                }
                else {
                    var e = document.getElementById("txtUserGroup");
                    $scope.txtusergroupid2 = e.options[e.selectedIndex].value;
                    $scope.hiddenId = 0;
                    $scope.txtPassword = document.getElementById("txtPassword").value;
                    $scope.txtPassword1 = document.getElementById("txtrePassword").value;

                    if ($scope.txtPassword != $scope.txtPassword1) {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Password do not match', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        $('.search-user-field .btn-success1, .add-user-field .btn-success1').click(function () {
                            $('.add-user-field').show();
                        });
                        return;
                    }
                    if ($scope.txtLoginName == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Name', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        $('.search-user-field .btn-success1, .add-user-field .btn-success1').click(function () {
                            $('.add-user-field').show();
                        });
                        return;
                    }
                    if ($scope.txtName == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter User Name', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        $('.search-user-field .btn-success1, .add-user-field .btn-success1').click(function () {
                            $('.add-user-field').show();
                        });
                        return;
                    }
                    if ($scope.txtusergroupid2 == 0) {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Please select User Group ', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        $('.search-user-field .btn-success1, .add-user-field .btn-success1').click(function () {
                            $('.add-user-field').show();
                        });
                        return;
                    }
                    if ($scope.txtPassword == "") {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('Enter Password', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        $('.search-user-field .btn-success1, .add-user-field .btn-success1').click(function () {
                            $('.add-user-field').show();
                        });
                        return;
                    }
                }

                var obj = { Id: $scope.hiddenId, LoginName: $scope.txtName, Name: $scope.txtLoginName, UserGroup_Id: $scope.txtusergroupid2, Password: $scope.txtPassword };
                var JSONData = JSON.stringify(obj);

                var httpreq = {
                    method: "POST",
                    url: "user_management.aspx/Save",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { JSONData },
                }
                $http(httpreq).success(function (response) {
                    $scope.hiddenId = angular.fromJson(response.d);  // save function should send Id of records, which will be store back to hidden field
                    if ($scope.hiddenId != 0) {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('User Data Saved Successfully...!!', 'Done', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        $('.add-user-field').hide();
                        $scope.listData = angular.fromJson($scope.inlistData);
                        $scope.UserGListRData =  '<%= UGlistData %>';
                        $scope.UGlistData = angular.fromJson($scope.UserGListRData);
                        $scope.RefreshList();

                    }
                    else {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.error('User already present..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                        return;
                    }

                })
            }
            
            $scope.DeleteGroup = function (Id) {
                
                swal({
                    title: "Are you Sure!",
                    text: "Do you want to delete group? ",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "OK!",
                    closeOnConfirm: true
                }, function (isConfirm) {
                    if (!isConfirm) return;
                    if (Id != 0) {
                        var obj = { Id }; //send data as shown here { Id: $scope.hiddenId, VehicleNo: $scope.txtVehicleNo, DriverName: $scope.txtDriverName, DriverPhone: $scope.txtDriverPhone };

                        var JSONData = JSON.stringify(obj);
                        alert(Id);
                        var httpreq = {
                            method: "POST",
                            url: "user_management.aspx/DeleteGroup",
                            headers: {
                                'Content-Type': 'application/json; charset=utf-8',
                                'dataType': 'json'
                            },
                            data: { Id },
                        }
                        $http(httpreq).success(function (response) {
                            $scope.UGlistData11111 = angular.fromJson(response.d);
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.success('Group deleted sucessfully', 'Done', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                            $scope.RefreshList();
                        })
                    }


                })
            };

            $scope.Delete = function (index) {
                if (index == 1) {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('You Cant delete Admin..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }

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
                    var hidderValue = document.getElementById('Id_' + index).value;
                    $scope.hiddenId = hidderValue;
                    if ($scope.hiddenId != 0) {
                        var obj = { Id: $scope.hiddenId }; //send data as shown here { Id: $scope.hiddenId, VehicleNo: $scope.txtVehicleNo, DriverName: $scope.txtDriverName, DriverPhone: $scope.txtDriverPhone };

                        var JSONData = JSON.stringify(obj);

                        var httpreq = {
                            method: "POST",
                            url: "user_management.aspx/DeleteUserGroup",
                            headers: {
                                'Content-Type': 'application/json; charset=utf-8',
                                'dataType': 'json'
                            },
                            data: { JSONData },
                        }
                        $http(httpreq).success(function (response) {
                            $scope.UGlistData11111 = angular.fromJson(response.d);
                            toastr.options.positionClass = 'toast-top-center';
                            toastr.success('User deleted sucessfully', 'Done', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                            $scope.RefreshList();
                        })
                    }


                })
            };
            $scope.SelectDiv = function (Index) {
                if (Index == 0) {
                    $scope.NoDataDiv = true;
                    $scope.HeadingName = false;
                }
                else {
                    $scope.NoDataDiv = false;
                    $scope.HeadingName = true;
                }

            }

            $scope.hidePasswordRow = function (id) {

                var row = document.getElementById("collapse" + id);
                if (row.style.display == "table-row") {
                    row.style.display = "none";

                }
                else {

                    row.style.display = "table-row";
                }

            }

            $scope.init = function () {
                $scope.HeadingName = true;
            }

        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid user_screen" ng-app="myApp" ng-controller="myController" ng-init="init()">
        <div ng-app="myApp" ng-controller="myController">
            <main class="origa-app-content origa-app-content-list" style="margin-top: 10px">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12 col-lg-7 col-xl-7">
                            <div class="user-manag-left-wrap">
                                <div class="user-manag-left-inner clearfix mb20">
                                    <h3 class="float-left lh35 fr_font">Users </h3>
                                    <ul class="list-inline user-list-inline clearfix float-right mt5">
                                        <li class="list-inline-item"></li>
                                        <li class="list-inline-item">
                                            <button type="button" class="btn btn-sm btn-dark" ng-click="ShowAddUserGroup()" id="add-userGroup-btn" title="Add User Group">
                                                <i class="fa fa-plus mr5" aria-hidden="true"></i>
                                                Add User Group
                                            </button>
                                            <button type="button" class="btn btn-sm btn-warning" ng-click="CloseUserGroup()" id="close-userGroup-btn" title="Close User Group" style="display: none;">
                                                <i class="fa fa-close" aria-hidden="true"></i>
                                                Close User Group
                                            </button>
                                        </li>
                                        <li class="list-inline-item"></li>
                                        <li class="list-inline-item">
                                            <button type="button" class="btn btn-sm btn-success1" ng-click="ShowAdd()" id="add-user-btn" title="Add User">
                                                <i class="fa fa-plus mr5" aria-hidden="true"></i>
                                                Add User 
                                            </button>
                                        </li>
                                        <li class="list-inline-item">
                                            <button type="button" id="search-user-btn" class="btn btn-primary btn-sm full_wid">
                                                <i class="fa fa-search"></i>&nbsp;&nbsp;Search
                                            </button>
                                            <button type="button" id="search-user-close" class="btn btn-warning btn-sm full_wid" style="display: none" ng-click="RefreshList()">
                                                <i class="fa fa-close"></i>&nbsp;&nbsp;Close
                                            </button>
                                        </li>
                                    </ul>
                                </div>
                                <div class="user-manag-left-table-wrap">
                                    <div class="table-responsive">
                                        <table class="user-manag-left-table">
                                            <thead>
                                                <tr class="parent-tr search-user-field show-accordion-parent fr_ser_btn">
                                                    <td>
                                                        <label>Name</label>
                                                        <input class="form-control input-text" ng-model="searchText.Name" ng-change="SelectDiv((listData | filter:searchText).length)" placeholder="Name" type="text" value="" />
                                                    </td>
                                                    <td>
                                                        <label>User Group</label>
                                                        <input class="form-control input-text" ng-model="searchText.GroupName" ng-change="SelectDiv((listData | filter:searchText).length)" placeholder="User Group" type="text" value="" />
                                                    </td>
                                                    <td>
                                                        <label>User Name</label>
                                                        <input class="form-control input-text" ng-model="searchText.LoginName" ng-change="SelectDiv((listData | filter:searchText).length)" placeholder="User Name" type="text" value="" />
                                                    </td>
                                                    <td>&nbsp;
                                                    </td>
                                                </tr>
                                                <tr class="bor_top" ng-show="HeadingName">
                                                    <th>Name</th>
                                                    <th>User Group</th>
                                                    <th>User name</th>
                                                    <th>&nbsp;</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Add user -->
                                                <tr class="parent-tr add-user-field show-accordion-parent" id="tblRow">
                                                    <td>
                                                        <label>Name</label>
                                                        <input id="txtLoginName" ng-model="txtLoginName" name="txtLoginName" class="form-control input-text" placeholder="" type="text" value="">
                                                    </td>
                                                    <td>
                                                        <label>User group</label>
                                                        <select id="txtUserGroup" ng-model="txtUserGroup" name="txtUserGroup" class="form-control input-text">
                                                            <option value="0">Select User Group  </option>
                                                            <option ng-repeat="t in UGlistData" value="{{t.Id}}">{{t.GroupName}}</option>

                                                        </select>
                                                    </td>
                                                    <td>
                                                        <label>User Name</label>
                                                        <input id="txtName" ng-model="txtName" name="txtName" class="form-control input-text" placeholder="" type="text" />
                                                    </td>
                                                    <td>&nbsp;
                                                    </td>
                                                </tr>
                                                <tr class="child-tr-password add-user-field collapse show fr_bor">

                                                    <td>
                                                        <label>Password</label>
                                                        <input id="txtPassword" ng-model="txtPassword" name="txtPassword" class="form-control" placeholder="" type="password" />
                                                    </td>
                                                    <td>
                                                        <label>Re-enter Password</label>
                                                        <input id="txtrePassword" ng-model="txtrePassword" name="txtrePassword" class="form-control" placeholder="" type="password">
                                                    </td>
                                                    <td class="fr_btn_sm">
                                                        <label>&nbsp;</label>
                                                        <button id="btnSave" ng-click="Save(0)" type="button" class="btn btn-sm btn-success1" title="Save Changes">
                                                            <img src="../global/images/save-24px.svg">Save Changes 
                                                        </button>
                                                    </td>
                                                    <td class="reset_btn">
                                                        <label>&nbsp;</label>
                                                        <button id="reset_btn" type="button" ng-click="Reset()" class="btn btn-sm btn-dark btn-cancel-adj" title="Reset">Reset</button>
                                                    </td>
                                                </tr>

                                                <!-- Search user -->



                                                <!-- user 1 -->
                                                <tbody data-ng-repeat="item in listData | filter:searchText">
                                                    <tr class="parent-tr">
                                                        <td>
                                                            <h6 class="h8">{{item.Name}}<%--{{item.Name}}--%>
                                                            </h6>
                                                            <input class="form-control input-text" placeholder="" type="text" id="Name_{{$index+1}}" data-ng-model="item.Name" />
                                                            <input class="form-control input-text" ng-value="{{item.Id}}" type="hidden" id="Id_{{$index+1}}" data-ng-model="item.Id" />
                                                        </td>
                                                        <td>
                                                            <h6 class="h8">{{item.GroupName}}
                                                            </h6>
                                                            <select class="form-control input-text" id="UserGroup_{{$index+1}}" data-ng-model="item.UserGroup_Id">

                                                                <option ng-repeat="t in UGlistData" ng-selected="{{t.Id == item.UserGroup_Id}}" value="{{t.Id}}">{{t.GroupName}}</option>
                                                            </select>

                                                        </td>
                                                        <td>
                                                            <h6 class="h8">{{item.LoginName}}<%--{{(listData | filter:searchText).length}}--%>
                                                            </h6>
                                                            <input class="form-control input-text" placeholder="" type="text" id="LoginName_{{$index+1}}" data-ng-model="item.LoginName" />
                                                        </td>

                                                        <td class="fr_over">
                                                            <a href="#collapse{{item.Id}}" data-toggle="collapse" class="btn-accordion collapsed" ng-click="hidePasswordRow(item.Id)" aria-expanded="false">
                                                                <i class="fa fa-fw fa-chevron-circle-down"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                    </tr>
                                                    <tr class="child-tr-password collapse" id="collapse{{item.Id}}" style="display: none">
                                                        <td>
                                                            <label>Password</label>
                                                            <input class="form-control" placeholder="" id="Password_{{$index+1}}" <%--data-ng-model="item.Password"--%> type="password">
                                                        </td>
                                                        <td>
                                                            <label>Re-enter Password</label>
                                                            <input class="form-control" id="rePassword_{{$index+1}}" placeholder="" type="password">
                                                        </td>
                                                        <td class="fr_btn_sm">
                                                            <label>&nbsp;</label>
                                                            <button type="button" id="btnEdit" ng-click="Save($index+1)" class="btn btn-sm btn-success1">
                                                                <img src="../global/images/save-24px.svg">&nbsp;&nbsp;Save Changes
                                                            </button>
                                                        </td>
                                                        <td>
                                                            <label>&nbsp;</label>
                                                            <a href="#" class="delete-row-a">
                                                                <i class="fa fa-fw fa-minus-circle" ng-click="Delete($index+1)" style="margin-top: 28px;"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="out_wrap" id="NoDataDiv" ng-show="NoDataDiv">
                                        <%-- ng-show="NoDataDiv"--%>
                                        <div class="inner_box">
                                            <img src="../assets/images/announcement.svg">
                                            <div class="text_note">
                                                <h4>No Results Found</h4>
                                            </div>
                                            <div class="text_line">Search for another term or try changing filters</div>
                                        </div>
                                    </div>

                                    <div class="table-responsive mt20" id="groupAdd" style="display: none;">
                                        <table class="user-manag-right-table">
                                            <thead>
                                                <tr class="tab_bg">
                                                    <%-- <label>User Group</label>--%>


                                                    <th colspan="5" class="fr_padd">
                                                        <div class="col-md-12">
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <label>Group Name</label>
                                                                    <input id="txtGruopName1" ng-model="txtGruopName" name="txtGruopName" class="form-control" placeholder="Enter Group" type="text" />
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <label>Description</label>
                                                                    <input id="txtGruopDesc" ng-model="txtGruopDesc" name="txtGruopDesc" class="form-control" placeholder="Enter Desciption" type="text" />
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <label>&nbsp;</label>
                                                                    <button type="button" id="btnSaveGroup" ng-click="SaveGroup()" class="btn btn-sm btn-success">
                                                                        <img src="../global/images/save-24px.svg">Save Group
                                                                    </button>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </div>

                                <div class="group" style="margin-top:20px;display:none;">
                                    <div class="col-md-6 pl-0">
                                        <h5>Group List</h5>
                                        <table class="table table-active" style="background-color:#e6e8e8;">
                                            <thead>
                                                <tr>
                                                    <th>Group Name</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr ng-repeat="t in UGlistData">
                                                    <td>{{t.GroupName}}</td>
                                                    <td ng-click="DeleteGroup(t.Id)">
                                                        <img src="../global/images/delete_1.png" /></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5 col-lg-5 col-xl-5 permissions-outer-wrap st">
                            <div class="user-manag-right-wrap">
                                <a href="#" class="permission-key-btn">
                                    <i class="fa fa-key" aria-hidden="true"></i>
                                </a>
                                <h3 class="fr_font">Permissions</h3>
                                <div class="table-responsive mt20">
                                    <table class="user-manag-right-table">
                                        <thead>
                                            <tr class="tab_bg">
                                                <%-- <label>User Group</label>--%>


                                                <th colspan="5" class="fr_padd">
                                                    <div class="col-md-12">
                                                        <div class="row">
                                                            <div class="col-md-5">
                                                                <select id="txtUserGroup111" ng-model="txtUserGroup111" ng-change="selectUserGroup();" name="txtUserGroup111" class="form-control input-text">
                                                                    <option value="0">Select User Group  </option>
                                                                    <option ng-repeat="t in UGlistData" value="{{t.Id}}">{{t.GroupName}}</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-5">
                                                                <select id="txtUserID1" ng-model="txtUserID1" ng-change="BindDataForSigleUser()" name="txtUserID1" class="form-control input-text">
                                                                    <option value="0">Select User </option>
                                                                    <option ng-repeat="t in BindUser" value="{{t.Id}}">{{t.Name}}</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </th>




                                            </tr>
                                            <tr class="bb1-adj">
                                                <th>Screen</th>
                                                <th class="text-center">View</th>
                                                <th class="text-center">Add</th>
                                                <th class="text-center">Edit</th>
                                                <th class="text-center">Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr data-ng-repeat="item in listMenuData">
                                                <td>{{item.Label}}</td>
                                                <td class="text-center">
                                                    <label class="custom-control origa-custom-checkbox" type="checkbox">
                                                        <input class="custom-control-input" id="chkViewAdmin_{{item.MenuId}}" type="checkbox" />
                                                        <span class="custom-control-indicator"></span>
                                                    </label>
                                                </td>
                                                <td class="text-center">
                                                    <label class="custom-control origa-custom-checkbox" type="checkbox">
                                                        <input class="custom-control-input" id="chkAddAdmin_{{item.MenuId}}" type="checkbox" />
                                                        <span class="custom-control-indicator"></span>
                                                    </label>
                                                </td>
                                                <td class="text-center">
                                                    <label class="custom-control origa-custom-checkbox" type="checkbox">
                                                        <input class="custom-control-input" id="chkEditAdmin_{{item.MenuId}}" type="checkbox" />
                                                        <span class="custom-control-indicator"></span>
                                                    </label>
                                                </td>
                                                <td class="text-center">
                                                    <label class="custom-control origa-custom-checkbox" type="checkbox">
                                                        <input class="custom-control-input" id="chkDeleteAdmin_{{item.MenuId}}" type="checkbox" />
                                                        <span class="custom-control-indicator"></span>
                                                    </label>
                                                </td>
                                                <td style="vertical-align: middle !important; width: 10%; display: none">
                                                    <label id="lbl_ID_{{item.MenuId}}">{{item.MenuId}} </label>
                                                </td>

                                            </tr>


                                            <tr>

                                                <td>
                                                    <label><b>Select All</b></label></td>
                                                <td>
                                                    <input class="custom-control origa-custom-checkbox" type="checkbox" name="select-all" id="select-all" />

                                                </td>
                                                <td colspan="4" class="text-right fr_btn_sm">
                                                    <button type="button" class="btn btn-sm btn-success1 float-right" id="btnSave1" ng-click="SaveData()" title="Save Changes">
                                                        <img src="../global/images/save-24px.svg">Save Changes</button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <%--<script src="../JS/popper.min.js"></script>--%>
    <script type="text/javascript">
            (function () {
                "use strict";
                var treeviewMenu = $('.origa-app-menu');
                // Toggle Sidebar
                $('[data-toggle="sidebar"]').click(function (event) {
                    event.preventDefault();
                    $('.app').toggleClass('sidenav-toggled');
                });
            })();
        $(document).ready(function () {
            $('.date-picker-outer').hide();
            $('#date-picker-wrap').show();
            $('.date-picker-outer1').hide();
            $('#date-picker-wrap1').show();
            $('#select-date-picker').change(function () {
                if ($('select[name=serviceChoice] option:selected').val() == 'day') {
                    $('.date-picker-outer1').hide();
                    $('#date-picker-wrap1').show();
                } else if ($('select[name=serviceChoice] option:selected').val() == 'week') {
                    $('.date-picker-outer1').hide();
                    $('#week-picker').show();
                } else if ($('select[name=serviceChoice] option:selected').val() == 'months') {
                    $('.date-picker-outer1').hide();
                    $('#month-picker-wrap1').show();
                }
            });

            $('.btn-accordion').click(function () {
                $(this).parents('.parent-tr').toggleClass('show-accordion-parent')
            });
            $('.search-user-field, .add-user-field').hide();
            $('#add-user-btn').click(function () {
                $('.search-user-field').hide();
                $('.add-user-field').fadeToggle();
            });
            $('#search-user-btn').click(function () {
                $('.add-user-field').hide();
                $('#search-user-close').show();
                $('#search-user-btn').hide();
                $('.search-user-field').fadeToggle();
            });
            $('#search-user-close').click(function () {
                $('#search-user-close').hide();
                $('#search-user-btn').show();
                $('.add-user-field').hide();
                $('.search-user-field').fadeToggle();
            });
            $('.search-user-field .btn-success1, .add-user-field .btn-success1').click(function () {
                $('.add-user-field, .search-user-field').hide();
            });
            $('.permission-key-btn').click(function () {
                $('.permissions-outer-wrap').toggleClass('active');
            });

        });

        // Listen for click on toggle checkbox
        $('#select-all').click(function (event) {
            if (this.checked) {
                // Iterate each checkbox
                $(':checkbox').each(function () {
                    this.checked = true;
                });
            } else {
                $(':checkbox').each(function () {
                    this.checked = false;
                });
            }
        });
    </script>
</asp:Content>
