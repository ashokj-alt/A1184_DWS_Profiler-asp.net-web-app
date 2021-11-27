<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="homepage.aspx.cs" Inherits="DWS_Profiler.homepage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Delhivery | Homepage </title>
    <script src="/JS/webapp/Homepage.js"></script>
    <link href="global/webapp/Homepage.css" rel="stylesheet" />
    <style>
        .card {
            transition: 0.3s;
            border-radius: 5px;
            background-color: #c4e0f9;
            text-align: CENTER;
            cursor: pointer;
        }

            .card:hover {
                box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
            }


        .carousel {
            position: relative;
            padding: 50px 20px;
        }


        .services .service-item h4 {
            margin-top: 20px;
            font-size: 22px;
            color: #121212;
            font-weight: 300;
            margin-bottom: 0px;
            text-align: center;
            letter-spacing: 2px;
        }

        .reports {
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #fff;
            padding: 12px 20px;
        }

        .dashboard {
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f1f1f1;
            padding: 12px 20px;
        }

        .calibration {
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f1f1f1;
            padding: 12px 20px;
        }

        .user {
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f1f1f1;
            padding: 12px 20px;
        }

        .main {
            padding-bottom: 50px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="main" style="background-color: #eee; height: 92vh;">

        <div class="container-fluid" style="padding-top: 0px;">

            <div id="carouselExampleIndicators" class="carousel" data-ride="carousel" data-interval="false">
                
                <div class="carousel-inner" style="background-color: #fff; padding: 20px 0px;" id="mainHeading">
                    <div class="carousel-item active">
                        <div class="one" style="display: flex;">
                            <div class="col-md-3 center">
                                <div class="card active" id="reports" onclick="reports()">
                                    <div class="row" style="padding: 10px;">
                                        <div class="col-sm-3">
                                            <img src="global/images/report.svg">
                                        </div>
                                        <div class="col-sm-9">
                                            <h4>Reports</h4>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-3 center">
                                <div class="card" id="dashboard" onclick="dashboard()">
                                    <div class="row" style="padding: 10px;">
                                        <div class="col-sm-3">
                                            <img src="global/images/dashboard.svg">
                                        </div>
                                        <div class="col-sm-9">
                                            <h4>Dashboard</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 center">
                                <div class="card" id="calibration" onclick="calibration()">
                                    <div class="row" style="padding: 10px;">
                                        <div class="col-sm-3">
                                            <img src="global/images/settings.svg">
                                        </div>
                                        <div class="col-sm-9">
                                            <h4>Calibration Setting</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="card" id="UserManagement" onclick="UserManagement()">
                                    <div class="row" style="padding: 10px;">
                                        <div class="col-sm-3">
                                            <img src="global/images/user_management.svg">
                                        </div>
                                        <div class="col-sm-9">
                                            <h4>User Management</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="container">
            <section class="reports">

                <div class="row">
                    <div class="col-md-3 col-sm-6 col-xs-12" style="text-align: CENTER;">
                        <div class="service-item">
                            <a href="Pages/Reports/DataReport.aspx">
                                <img style="height: 60px;" src="global/images/report_data.svg" />
                                <h6>DWS Statistics Report</h6>
                            </a>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 col-xs-12" style="text-align: CENTER;">
                        <div class="service-item">
                            <a href="Pages/Reports/ProductionReport.aspx">
                                <img style="height: 60px;" src="global/images/chart_pie.svg" />
                                <h6>Production Report</h6>
                            </a>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 col-xs-12" style="text-align: CENTER;">
                        <div class="service-item">
                            <a href="Pages/Reports/ProductionAnalysis.aspx">
                                <img style="height: 60px;" src="global/images/System_analytics.svg" />
                                <h6>Analysis Report</h6>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12" style="text-align: CENTER;">
                        <div class="service-item">
                            <a href="Pages/faultscreen.aspx">
                                <img style="height: 60px;" src="global/images/warning.svg" />
                                <h6>System Alerts Report</h6>
                            </a>
                        </div>
                    </div>

                </div>
            </section>
        </div>

        <div class="container">
            <section class="dashboard" style="display: none;">

                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: CENTER;">
                        <div class="service-item">
                            <a href="Pages/reports/dashboard.aspx">
                                <img style="height: 60px;" src="global/images/Dashboard_1.svg" />
                                <h6>Dashboard</h6>
                            </a>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <div class="container">
            <section class="calibration" style="display: none;">

                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: CENTER;">
                        <div class="service-item">
                            <a href="Pages/Setting/BoxCalibrationSetting.aspx">
                                <img style="height: 60px;" src="global/images/settings_1.svg" />
                                <h6>Calibration Setting</h6>
                            </a>
                        </div>
                    </div>
                </div>

            </section>
        </div>

        <div class="container">
            <section class="user" style="display: none;">

                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: CENTER;">
                        <div class="service-item">
                            <a href="Pages/user_management.aspx">
                                <img style="height: 60px;" src="global/images/user_admin.svg" />
                                <h6>User Management</h6>
                            </a>
                        </div>
                    </div>
                </div>

            </section>
        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div id="IDannounciation" style="display: none;" class="footer" ng-click="open()" ng-controller="myController_HeartBit" ng-app="myApp" ng-init="startHeartBit()">
        <div class="fr_scroll">

            <table class="table_wrap table" ng-click="open()">
                <thead>
                    <tr>
                        <th class="">Sr.No</th>
                        <th class="">Time</th>
                        <th class="">Date</th>
                        <th class="">Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="item in AnnunciationData" ng-click="open()">
                        <td class="text-left">{{item.RowNum}}</td>
                        <td class="text-left">{{item.Time}}</td>
                        <td class="text-left">{{item.Date}}</td>
                        <td class="text-left">{{item.ErrorDescription}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>
