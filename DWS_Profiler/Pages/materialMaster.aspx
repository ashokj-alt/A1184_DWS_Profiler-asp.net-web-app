<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="materialMaster.aspx.cs" Inherits="DWS_Profiler.Pages.materialMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head runat="server">
        <title>dashboard | Dynamic DWS</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../global/css/bootstrap.min.css" rel="stylesheet" />
        <link href="../global/fonts/font-awesome/font-awesome.min.css" rel="stylesheet" />
        <link href="../global/css/style1.css" rel="stylesheet" />

        <script src="../JS/dashboard/materialMaster.js"></script>

        <style>
            .pg_tit {
                margin: 10px 0px;
            }

            .bor_bottom {
                border-bottom: 1px solid #ccc;
            }

            .config_table_wrap {
                background-color: #fff;
            }

                .config_table_wrap .table {
                    margin-bottom: 0px;
                }

            .cpy_right {
                margin-bottom: 0px;
                position: fixed;
                bottom: 0;
                width: 100%;
            }

            .mrtop10 {
                margin-top: 10px;
            }

            .table_wrap .table thead th {
                background-color: #8d8d8e;
                color: #fff;
                padding: 8px 4px;
            }

            .table_wrap .table tbody td {
                padding: 4px;
            }

            .table_wrap .table .form-control {
                border-radius: 0px;
                height: 30px;
            }

            .table_wrap .table .btn_wrap .btn {
                border-radius: 0px;
                padding: 2px 16px;
            }

            .w20 {
                min-width: 20px;
            }

            .w50 {
                min-width: 50px;
            }

            .w70 {
                min-width: 70px;
            }

            .w80 {
                min-width: 80px;
            }

            .w100 {
                min-width: 100px;
            }

            .w120 {
                min-width: 120px;
            }

            .w130 {
                min-width: 130px;
            }

            .w150 {
                min-width: 150px;
            }

            .w200 {
                min-width: 200px;
            }

            .w300 {
                min-width: 300px;
            }

            .w250 {
                min-width: 250px;
            }
        </style>
        <script type="text/javascript">
            var app = angular.module('myApp', []);
            app.controller("myController", function ($scope, $http) {
                alert("hi");
                $scope.inlistData = <%=listData %>; //;// Bind Your List Data here
                
                $scope.listData = angular.fromJson($scope.inlistData);
                $scope.txtSearch = '';



                //************************** function To Refresh List
                $scope.RefreshList = function () {
                    alert("ashok");
                    var httpreq = {
                        method: "POST",
                        url: "materialMaster.aspx/GetList",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: {},
                    }
                    $http(httpreq).success(function (response) {
                        $scope.listData = angular.fromJson(response.d);
                        //$scope.MatCode = $scope.listData.Table[0].MatCode;
                    })
                };


                //******************** End Reset List******************
                //************************** function To Refresh List
                $scope.Reset = function () {
                    $scope.txtemployee_name = "";
                    $scope.txtdesignation = "";
                    $scope.txtsalary = "";
                    $scope.txtqualification = "";
                    $scope.txtmobile = "";
                    $scope.txtemail2 = "";
                    $scope.txtmanager = "";

                }
                //******************** End Reset List******************
                //************************** function To Save Data***************
                // Same function will be used for Insert and Update
                // for Insert Id will be 0. $scope.hiddenId =0
                //for update Id will be set to $scope.hiddenId
                $scope.Save = function (MatCode) {
                    
                    var obj = { MatCode: MatCode, SKUML: $scope.txtWeight, SKUUnit: $scope.dblUnit, SKUSize: $scope.dblSize }; //send data as shown here { Id: $scope.hiddenId, VehicleNo: $scope.txtVehicleNo, DriverName: $scope.txtDriverName, DriverPhone: $scope.txtDriverPhone };
                    alert($scope.txtWeight);
                    //var JSONData = JSON.stringify(obj);
                    //alert(JSONData);
                    var httpreq = {
                        method: "POST",
                        url: "materialMaster.aspx/Save",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { MatCode: MatCode, SKUML: $scope.txtWeight, SKUUnit: $scope.dblUnit, SKUSize: $scope.dblSize },
                    }
                    $http(httpreq).success(function (response) {
                        //alert("in");
                        swal("User Group Updated Successfully...");
                        //alert("Data Updated successfully..");
                        $scope.hiddenId = response.d;  // save function should send Id of records, which will be store back to hidden field
                        // add your additiona code to show and hide div over here
                        $scope.RefreshList();
                       


                    })

                }
                //************************** End To Save Data

                $scope.UnSave = function (MatCode) {
                    //alert(MatCode);

                    //if ($scope.txtWeight !="")
                    //var obj = { MatCode: MatCode }; //send data as shown here { Id: $scope.hiddenId, VehicleNo: $scope.txtVehicleNo, DriverName: $scope.txtDriverName, DriverPhone: $scope.txtDriverPhone };
                    var searchItem = $scope.serachList(MatCode);
                    $scope.hiddenId = MatCode;
                    //var JSONData = JSON.stringify(obj);
                    //alert(JSONData);
                    swal({
                        title: "Are you Sure!",
                        text: "Do you want to UnSave? ",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "OK!",
                        closeOnConfirm: true
                    }, function (isConfirm) {
                        if (!isConfirm) return;

                        var httpreq = {
                            method: "POST",
                            url: "materialMaster.aspx/Unsave",
                            headers: {
                                'Content-Type': 'application/json; charset=utf-8',
                                'dataType': 'json'
                            },
                            data: { MatCode: MatCode },
                        }
                        $http(httpreq).success(function (response) {
                            //alert("in");
                            swal("UnSaved...");
                            //alert("Data Updated successfully..");
                            $scope.hiddenId = response.d;  // save function should send Id of records, which will be store back to hidden field
                            // add your additiona code to show and hide div over here
                            $scope.RefreshList();

                        })

                    })

                };

                //************************** Delete Data
                $scope.DeleteUser = function (MatCode) {
                    //alert(MatCode);

                    var searchItem = $scope.serachList(MatCode);
                    $scope.hiddenId = MatCode;

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
                            url: "materialMaster.aspx/DeleteUser",
                            headers: {
                                'Content-Type': 'application/json; charset=utf-8',
                                'dataType': 'json'
                            },
                            data: { MatCode: $scope.hiddenId },
                        }
                        $http(httpreq).success(function (response) {
                            //alert("Data deleted successfully..");
                            swal("User Group Updated Successfully...");
                            $scope.hiddenId = response.d;  // save function should send Id of records, which will be store back to hidden field
                            // add your additiona code to show and hide div over here
                            $scope.RefreshList();
                            

                        })

                    })


                };

                //************************** End To Delete Data******************************//
                
                $scope.serachList = function (id) {
                    for (var cnt = 0; cnt < $scope.listData.length; cnt++) {
                        if ($scope.listData[cnt].id == id) {
                            return $scope.listData[cnt];
                        }
                    }
                }

            });
        </script>
    </head>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="materilmaster" class="" ng-app="myApp" ng-controller="myController">
        <section class="page-content config">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12 bor_bottom">

                        <h4 class="pg_tit">
                        Configure Material Master</h2>
                    </div>

                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="config_table_wrap  mrtop10">

                            <div class="table-responsive">
                                <div class="table_wrap">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Sr.No</th>
                                                <th class="w250">Material Code</th>
                                                <th class="w300">Material Description</th>
                                                <th class="w80">Net Weight</th>
                                                <th class="w80">Net Unit</th>
                                                <th class="w130">Size</th>
                                                <th class="w300">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="item in listData">
                                                <td>{{item.Id}}</td>
                                                <td>{{item.MatCode}}</td>
                                                <td>{{item.SKU}}</td>
                                                
                                                <td>
                                                    <input type="text" class="form-control"  ng-model="txtWeight" name="txtWeight" id="txtWeight" ></td>
                                                <td>
                                                    <div class="">

                                                        <select id="dblUnit" ng-model="dblUnit" class="form-control">
                                                            
                                                            <option>ML</option>
                                                            <option>KG</option>

                                                        </select>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="">

                                                        <select id="dblSize" ng-model="dblSize" class="form-control">
                                                            
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                        </select>
                                                    </div>
                                                </td>

                                                 <td class="btn_wrap">
                                                    <input type="button" id="btnUpdate" class="btn btn-primary" value="Update" ng-click="Save()" style="display: none" />
                                                    <button type="button" id="save" class="btn btn-primary" value="save" ng-click="Save(item.MatCode)" >Save</button>
                                                    <button type="button" class="btn btn-secondary" id="btnUnSave" value="UnSave" ng-click="UnSave(item.MatCode)">Unsave</button>
                                                    <button type="button" class="btn btn-danger"  data-toggle="tooltip" data-original-title="Delete" id="btnDelete" ng-click="DeleteUser(item.MatCode)">Delete</button>
                                                </td>
                                                
                                            </tr>


                                            <%--<tr>
                                                <td>2</td>
                                                <td>40000000004567865444</td>
                                                <td>Best Choice (Palm)</td>
                                                <td>
                                                    <input type="text" name="" class="form-control"></td>
                                                <td>
                                                    <div class="">

                                                        <select class="form-control" id="">
                                                            <option value="ML">ML</option>
                                                            <option>KG</option>

                                                        </select>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="">

                                                        <select class="form-control" id="">
                                                            <option>Select Size</option>
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td class="btn_wrap">
                                                    <button type="button" class="btn btn-primary">Save</button>
                                                    <button type="button" class="btn btn-secondary">Unsave</button>
                                                    <button type="button" class="btn btn-danger">Delete</button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>3</td>
                                                <td>40000000004567865436</td>
                                                <td>Vanaspati 15 (Kg)</td>
                                                <td>
                                                    <input type="text" name="" class="form-control"></td>
                                                <td>
                                                    <div class="">

                                                        <select class="form-control" id="">
                                                            <option>ML</option>
                                                            <option value="KG">KG</option>

                                                        </select>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="">

                                                        <select class="form-control" id="">
                                                            <option>Select Size</option>
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td class="btn_wrap">
                                                    <button type="button" class="btn btn-primary">Save</button>
                                                    <button type="button" class="btn btn-secondary">Unsave</button>
                                                    <button type="button" class="btn btn-danger">Delete</button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>4</td>
                                                <td>40000000004567865438</td>
                                                <td>Healthy & Tasty (Soya)</td>
                                                <td>
                                                    <input type="text" name="" class="form-control"></td>
                                                <td>
                                                    <div class="">

                                                        <select class="form-control" id="">
                                                            <option>ML</option>
                                                            <option value="KG">KG</option>

                                                        </select>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="">

                                                        <select class="form-control" id="">
                                                            <option>Select Size</option>
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td class="btn_wrap">
                                                    <button type="button" class="btn btn-primary">Save</button>
                                                    <button type="button" class="btn btn-secondary">Unsave</button>
                                                    <button type="button" class="btn btn-danger">Delete</button>
                                                </td>
                                            </tr>--%>


                                        </tbody>
                                    </table>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <p class="cpy_right">
                            &copy; 2019. Powered By Armstrong Machine Builders Pvt. Ltd. All rights reserved.
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <script src="../JS/jquery.min.js"></script>
    <script src="../JS/popper.min.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
    <script src="../JS/custom.js"></script>




</asp:Content>
