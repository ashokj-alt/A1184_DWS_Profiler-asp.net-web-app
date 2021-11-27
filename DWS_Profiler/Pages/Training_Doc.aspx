<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="Training_Doc.aspx.cs" Inherits="DWS_Profiler.Pages.Training_Doc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var app = angular.module('myApp', []);
        app.controller("myController", function ($scope, $http, $interval) {


            //************************** function To Refresh List
            $scope.GetDocList = function () {

                var httpreq = {
                    method: "POST",
                    url: "Training_Doc.aspx/GetDocList",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: {},
                }
                $http(httpreq).success(function (response) {
                    $scope.GetDocList = angular.fromJson(response.d);
                    $scope.GetDocumentList = $scope.GetDocList.Table;
                })
            };

            $scope.GetQuestionList = function () {

                var httpreq = {
                    method: "POST",
                    url: "Training_Doc.aspx/GetQuestionList",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: {},
                }
                $http(httpreq).success(function (response) {
                    $scope.GetquesList = angular.fromJson(response.d);
                    $scope.GetQuestionList = $scope.GetquesList.Table;

                })
            };

            $scope.cancel = function () {
                $scope.GetDocList();
                $scope.GetQuestionList();
            }

            $scope.getvalue = function (Question) {
                var httpreq = {
                    method: "POST",
                    url: "Training_Doc.aspx/GetQuestion",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { Question},
                }
                $http(httpreq).success(function (response) {
                    $scope.GetquesList = angular.fromJson(response.d);
                    $scope.GetQuestionList = $scope.GetquesList.Table;
                    $("#btnCancel").show();
                })
            };

            $scope.Save = function () {
                if ($scope.txtquestion == undefined || $scope.txtquestion == "") {
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.error('Enter question First ..!!', 'Wait', { timeOut: 2000, closeButton: true, preventDuplicates: true });
                    return;
                }
                swal({
                    title: "Are you Sure!",
                    text: "Do you want to insert question? ",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "OK!",
                    closeOnConfirm: true
                }, function (isConfirm) {
                    if (!isConfirm) return;

                    var httpreq = {
                        method: "POST",
                        url: "Training_Doc.aspx/Save",
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                            'dataType': 'json'
                        },
                        data: { Question: $scope.txtquestion },
                    }
                    $http(httpreq).success(function (response) {
                        toastr.options.positionClass = 'toast-top-center';
                        toastr.success('inserted successfully we will get back to you shortely..!!', 'Wait', { timeOut: 5000, closeButton: true, preventDuplicates: true });
                        return;
                    })
                })
            };
            angular.element(document).ready(function () {

                $scope.GetDocList();
                $scope.GetQuestionList();
            });

        });
    </script>
    <style>
        .download .table tbody tr td a img {
            padding: 2px 5px;
            height: 18px;
        }

        .w3-white, .w3-hover-white:hover {
            color: #000 !important;
            background-color: #fff !important;
        }

        .w3-margin-bottom {
            margin-bottom: 16px !important;
        }
        #btnCancel{
	height: 36px;
    margin-top: 15px;
    margin-left: 20px;

        }
        .w3-card, .w3-card-2 {
            box-shadow: 0 2px 5px 0 rgb(0 0 0 / 16%), 0 2px 10px 0 rgb(0 0 0 / 12%);
            margin-top: 15px;
        }

        .w3-container, .w3-panel {
            padding: 0.01em 16px;
        }

        .download .table tbody tr td a img:hover {
            background-color: #f5f5f5;
        }

        .table thead th {
            background-color: #00a1ff;
            color: #fff;
        }

        .container {
            font-size: 16px !important;
        }

        .table th, .table td {
            border-top: 1px solid #d0d0d0;
            padding: 2.5px;
        }

        .table th, .table td {
            border-top: 1px solid #d0d0d0;
            padding: 0px 2.5px;
        }

        .w3-text-teal, .w3-hover-text-teal:hover {
            color: #009688 !important;
        }

        .w3-text-grey, .w3-hover-text-grey:hover, .w3-text-gray, .w3-hover-text-gray:hover {
            color: #757575 !important;
        }

        .w3-padding-16 {
            padding-top: 16px !important;
            padding-bottom: 16px !important;
        }

        .w3-opacity b {
            color: #5a5a5a;
        }

        i.w3-padding-16:hover {
            background-color: #009688;
            border-radius: 17px;
            height: 49px;
            color: #fff !important;
        }

        .modal {
            position: fixed;
            top: 225px;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 1050;
            display: none;
            overflow: hidden;
            outline: 0;
        }

        .btn-group {
            height: 36px;
            margin-top: 15px;
            margin-left: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container download" ng-app="myApp" ng-controller="myController">
        <h4>Documents</h4>
        <div class="" style="background-color: #fff; padding: 15px; box-shadow: 0 2px 5px 0 rgb(0 0 0 / 16%), 0 2px 10px 0 rgb(0 0 0 / 12%);">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Sr. No</th>
                            <th>Document name</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="item in GetDocumentList ">
                            <td>{{$index+1}}</td>
                            <td>{{item.Document_Name}}</td>
                            <td>
                                <a href="{{item.Document_URL}}" download="{{item.Document_Name}}" title="Download {{item.Document_Name}}">
                                    <img src="{{item.Download_Logo}}" />
                                </a>
                                <a href="{{item.Document_URL}}" title="Open {{item.Document_Name}}">
                                    <img src="{{item.open_Logo}}" /></a>

                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- Right Column -->
        <div class="w3-twothird">

            <div class="w3-container w3-card w3-white w3-margin-bottom">
                <div style="display: flex;">
                    <h4 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Frequently Asked Question</h4>
                    <div style="display:flex;">
                    <select id="txtMasterId" class="form-control" style="margin-top: 17px;" data-ng-model="Question" data-ng-change="getvalue(Question)">
                        <option ng-repeat="data in GetQuestionList" ng-selected="{{data.Question == Question}}" value="{{data.Question}}">{{data.Question}}
                        </option>
                    </select>
                        <button class="btn btn-dark" id="btnCancel" style="display:none;" ng-click="cancel()">Cancel</button>
                    </div>
                    <i class="fa fa-plus w3-padding-16 pull-right btn" style="width: 2%; margin-left: auto; min-width: 70px; color: #009688;" title="Add Your question" data-toggle="modal" data-target="#myModal"></i>
                </div>
                <div class="w3-container" ng-repeat="data in GetQuestionList">
                    <h6 class="w3-opacity"><b>{{data.Question}}</b></h6>
                    <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>{{data.InsertedDate}}</h6>
                    <p>{{data.Answer}}</p>
                    <hr>
                </div>
            </div>
        </div>
        <!-- End Right Column -->

        <!-- The Modal -->
        <div class="modal fade" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Add your question</h4>
                        <button type="button" class="close" data-dismiss="modal">×</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <textarea class="form-control" ng-model="txtquestion" id="txtquestion" rows="4"></textarea>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" style="min-width: 80px;" ng-click="Save()">Submit</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
