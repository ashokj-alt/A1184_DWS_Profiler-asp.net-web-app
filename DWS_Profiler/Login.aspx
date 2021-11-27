<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DWS_Profiler.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <script src="/JS/jquery-3.2.1.min.js"></script>
    <script src="/JS/angular.min.js"></script>

    <title>Delhivery | Login </title>
    <link href="/global/css/base.css" rel="stylesheet" />
    <link href="/global/css/style.css" rel="stylesheet" />
    <link href="/global/css/media.css" rel="stylesheet" />
    <link href="/global/css/bootstrap.min.css" rel="stylesheet" />

    <link href="/global/fonts/IBM_Fonts/stylesheet.css" rel="stylesheet" />
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
    <script>
        
        var myApp = angular.module("myApp", []);
        myApp.controller("myController", function ($scope, $http, $location, $window) {
            $scope.errorMsg = "";
            $scope.inputName = "";
            $scope.inputPassword = "";

            $scope.showPassword = false;

            $scope.toggleShowPassword = function () {
                $scope.showPassword = !$scope.showPassword;
            }
            
            var input = document.getElementById("inputPassword");
            input.addEventListener("keyup", function (event) {
                event.preventDefault();
                if (event.keyCode === 13) {
                    document.getElementById("btnlogin").click();
                }
            });



            $scope.login = function () {
                var httpreq = {
                    method: "POST",
                    url: "login.aspx/Signin",
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                        'dataType': 'json'
                    },
                    data: { username: $scope.inputName, password: $scope.inputPassword },
                }
                $http(httpreq).success(function (response) {
                    $scope.Result = angular.fromJson(response.d);
                    if ($scope.Result.length > 0) {
                        $scope.UserId = $scope.Result[0].Id;
                    }
                    if (response.d == "1") {
                        $window.location.href = 'homepage.aspx';
                    }
                    else {
                        $scope.errorMsg = "Invalid Login Credentials..!";
                    }
                });
                $http(httpreq).error(function (response) {
                    $scope.errorMsg = "Enter username and password to login";

                });
            };

        });
    </script>



</head>
<body class="app sidebar-mini body-fluid main_body">
    <div class="loader-wrap">
        <div class="loader"></div>
    </div>
    <main class="origa-app-content login-page" ng-app="myApp" ng-controller="myController">
        <div id="comman-flow-carousel " class="cust_wid carousel carousel-fade slide" data-ride="carousel" data-interval="false">
            <div class="carousel-inner">
                <!--login form-->
                <div class="carousel-item active" id="mdlLogin">
                    <div class="col-md-12 ">
                        <div class="cust_logo_wrap">
                            <img src="/Images/logo_Delhivery.png" />
                        </div>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12">

                        <div class="comman-flow-card-outer">
                            <div class="card comman-flow-card posi-rel">
                                <div class="card-body">
                                    <div class="row justify-content-center align-items-center comman-flow-card-inner-row">
                                        <div class="col-lg-12 login-form-wrapper">
                                            <h2 class="text-gray2 mb35">Log in</h2>
                                            <div class="form-body login-flow-form">
                                                <form action="login.html" method="post">
                                                    <div class="form-group custom-form-group origa-icon-form-group">
                                                        <label class="form-label" for="inputName">Username</label>
                                                        <input class="effect-border" id="inputName" ng-model="inputName" required name="name" placeholder="Enter Username" type="text" />
                                                        <span class="focus-border"></span>
                                                    </div>
                                                    <div class="form-group custom-form-group origa-icon-form-group">
                                                        <label class="form-label" for="inputPassword">Password</label>
                                                        <input class="effect-border" id="inputPassword" autocomplete="off" ng-model="inputPassword" required name="password" placeholder="Enter Password" type="password"  ng-attr-type="{{ showPassword ? 'text':'password'}}" />
                                                       <div ng-click="toggleShowPassword()" ng-class="{'fa fa-eye': showPassword,'fa fa-eye-slash': !showPassword}" style="cursor: pointer;margin-left:85%;"></div>
                                                        <span class="focus-border"></span>
                                                    </div>
                                                    <div class="btn-group-wrap clearfix cust_log">

                                                        <button type="button" class="btn btn-primary1 btn-block" id="btnlogin" ng-click="login()"><span>Log in</span><img src="/Images/arrow_right.svg" alt="" /></button>
                                                    </div>
                                                    <div class="form-group custom-form-group origa-icon-form-group"></div>

                                                    <div class="form-group custom-form-group origa-icon-form-group">
                                                        <label class="error" style="font-weight: 200; font-weight: 600; color: orangered;">{{errorMsg}}</label>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="logo_wrap">
                   <img src="Images/ArmstrongLogo_white.png" />
                </div>
            </div>
        </div>
    </main>
    <script src="/JS/jquery.min.js"></script>
    <script src="/JS/popper.min.js"></script>
    <script src="/JS/bootstrap.min.js"></script>
    <script src="/JS/custom.js"></script>
</body>

</html>
