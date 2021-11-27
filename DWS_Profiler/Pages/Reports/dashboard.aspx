<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="DWS_Profiler.Pages.Reports.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head runat="server">
        <title>Delhivery | Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="/../../JS/dashboard/dashboard.js"></script>
        <link href="../../global/css/font-awesome.min.css" rel="stylesheet" />
        <script src="../../JS/9226cb70eb.js"></script>

        <style>
            .divRed1 {
                color: red !important;
            }

            .btn-text {
                text-align: left !important;
            }

            .divgreen {
                color: green !important;
            }

            .button5 {
                border-radius: 25px;
                background-color: #ebebeb;
                border: none;
                color: black;
                padding: 4px;
                width: 79px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                margin: -3px 2px;
            }

            .divGreen {
                background-color: #04AA6D !important;
                color: white !important;
            }

            .divRed {
                background-color: #ff2b2b !important;
                color: white !important;
            }

            .modal-content .modal-body .table_wrap tbody tr td {
                background-color: red;
                color: white;
            }


            #Modal_Notify_announciation .modal-body {
                height: 400px;
                overflow-y: auto;
                padding: 5px 15px;
            }

            .modal-backdrop {
                z-index: 1074;
            }

            #Modal_Notify_announciation.modal {
                z-index: 9999;
            }

            #noti {
                margin: auto;
                margin-top: 8px;
                width: 100%;
                position: absolute;
                padding: 8px;
                z-index: 9999;
                top: 0;
                font-weight: 500;
                text-align: center;
                background-color: #dcdbdb;
                width: auto;
                color: #ff0a0a;
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
                margin-bottom: 6px;
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
                    width: 20%;
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

            #IDannounciation {
                position: fixed;
                bottom: 0;
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
        </style>
    </head>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="dashboard" class="mdash" ng-app="myApp" ng-controller="myController" ng-init="StartTimer()">
        <div id="Modal_Notify_Notification" style="margin: auto; width: 30%;">
            <p id="noti">System is Idle from last {{Day}} Day {{Hour}}  Hour {{Minute}} minutes {{Second}} Seconds</p>

        </div>
        <div class="container-fluid">
            <div id="icons" class="col-md-12 mrtop10">
                <div class="row">

                    <div class="col-md-3 col-xs-12 mrbot10  pl-0 pr-0">
                        <div class="card" style="">
                            <div class="row">
                                <div class="col-md-3 icon">
                                    <img class="img-fluid" src="../../global/Images/barcode.svg" alt="...">
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h4 class="card-title text-center">AWB</h4>
                                        <h4 class="card-text text-center">{{Barcode}}</h4>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-xs-12 mrbot10">
                        <div class="card" style="">
                            <div class="row">
                                <div class="col-md-3 icon1">
                                    <img class="img-fluid" src="../../global/images/total_count.svg" alt="...">
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h4 class="card-title text-center">Today's Count</h4>
                                        <h4 class="card-text text-center">{{totalCount}}</h4>

                                    </div>
                                </div>
                            </div>



                        </div>
                    </div>

                    <div class="col-md-3 col-xs-12 mrbot10">
                        <div class="card" style="">
                            <div class="row">
                                <div class="col-md-3 icon2">
                                    <img class="img-fluid" src="../../global/images/Volume_31.png" />
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h4 class="card-title text-center">Volume(cm3)</h4>
                                        <h4 class="card-text text-center">{{Volume}}</h4>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-xs-12 mrbot10  pl-0 pr-0">
                        <div class="card" style="">
                            <div class="row">
                                <div class="col-md-3 icon3">
                                    <img class="img-fluid" src="../../global/images/Volume_31.png" />
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h4 class="card-title text-center">Real Volume(cm3)</h4>
                                        <h4 class="card-text text-center">{{RealVolume}}</h4>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>

                <div class="row">

                    <div class="col-md-3 col-xs-12 mrbot10 pl-0 pr-0">
                        <div class="card" style="">
                            <div class="row">
                                <div class="col-md-3 icon4">
                                    <img src="../../global/images/Length_31.png" />
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h4 class="card-title text-center">Length(cm)</h4>
                                        <h4 class="card-text text-center">{{Length}}</h4>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-xs-12 mrbot10 ">
                        <div class="card" style="">
                            <div class="row">
                                <div class="col-md-3 icon5">
                                    <img src="../../global/images/Width_11.png" />
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h4 class="card-title text-center">Width(cm)</h4>
                                        <h4 class="card-text text-center">{{Width}}</h4>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-xs-12 mrbot10">
                        <div class="card" style="">
                            <div class="row">
                                <div class="col-md-3 icon6">
                                    <img src="../../global/images/Height_11.png" />
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h4 class="card-title text-center">Height(cm)</h4>
                                        <h4 class="card-text text-center">{{Height}}</h4>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="col-md-3 col-xs-12 mrbot10  pl-0 pr-0">
                        <div class="card" style="">
                            <div class="row">
                                <div class="col-md-3 icon7">
                                    <img class="img-fluid" src="../../Images/weight.png" alt="...">
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h4 class="card-title text-center">Weight(g)</h4>
                                        <h4 class="card-text text-center">{{Weight}}</h4>

                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>


                </div>
            </div>
            <div class="col-md-12 mrbot10">
                <div class="main_table">

                    <div class="row no-gutters">
                        <div class="col-md-10">
                            <div class="row">
                                <div class="col-md-8">
                                    <button class="button button5" ng-class="{'divGreen':ManualStatus==1}">Manunal</button>
                                    <button class="button button5" ng-class="{'divGreen':AutoStatus==1}">Auto</button>
                                    <button class="button button5" ng-class="{'divRed':PLCLAN==1}">PLC</button>
                                    <button class="button button5" ng-class="{'divRed':CameraLan==1}">Camera</button>
                                    <button class="button button5" ng-class="{'divRed':CheckWeigherLAN==1}">Wheigher</button>
                                    <button class="button button5" ng-class="{'divRed':VMSLAN==1}">VMS</button>
                                    <button class="button button5" ng-class="{'divRed':HMILAN==1}">HMI</button>
                                </div>
                                <div class="col-md-4">

                                    <div style="display: flex;">
                                        <h6 style="margin-right: 8%;" id="tabletitle">Processed Packages (Last 10 Records)</h6>

                                        <input id="searchTextBox" ng-model="txtSearch1" type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' required class="inline clearable inlinesearch" placeholder="Search Barcode..">
                                        <button id="searchbutton" class="inlinesearch btn btn-info" ng-click="SearchData()" style="display: none; min-width: 55px; margin-left: 10px; height: 34px;">

                                            <img src="../../Images/search_white.png" style="margin-bottom: 2px;" />
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div style="display: flex; justify-content: flex-end; margin-bottom: 10px;">

                                <button type="button" id="serachbtn" class="btn btn-primary search_btn inline" ng-click="Search()" title="Search Barcode." style="margin-right: 10px;">
                                    Search
                <img src="../../images/search_white.png" style="margin-bottom: 1px;" /></button>
                                <button type="button" id="serachclose" class="btn btn-default search_btn inline" ng-click="close()" style="display: none; margin-right: 10px; min-width: 55px;">

                                    <img src="../../global/images/x-mark.png" style="margin-bottom: 1px;" /></button>

                                <button type="button" id="exportbtn" class="btn btn-primary inline" ng-click="Export()" title="Export Today's Data">

                                    <img style="margin-left: 1px; margin-bottom: 2px;" src="../../global/images/export.svg"></button>
                                <button type="button" style="display: none;" id="Searchexportbtn" class="btn btn-primary inline" ng-click="SearchExport()" title="Export Searched data">

                                    <img style="margin-left: 1px; margin-bottom: 2px;" src="../../global/images/export.svg"></button>
                            </div>
                        </div>
                    </div>


                    <div class="table_data" style="margin-bottom: 0px;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Sr.No</th>
                                    <th scope="col">AWB</th>

                                    <th scope="col">Length(cm)</th>
                                    <th scope="col">Width(cm)</th>
                                    <th scope="col">Height(cm)</th>
                                    <th scope="col">Weight(g)</th>
                                    <th scope="col">Volume(cm3)</th>
                                    <th scope="col" class="w130">Real Volume(cm3)</th>
                                    <th scope="col" class="w100">Package Type</th>
                                    <th scope="col" class="w90">Data Sent</th>
                                    <th scope="col">Failed Reason </th>
                                    <th scope="col" class="w150">Timestamp</th>

                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="item in listData" ng-dblclick="showData(item.Barcode,item.Length,item.Width,item.Height,item.Weight,item.Volume,item.RealVolume,item.PackageType,item.IsSend,item.ReasonForFailed,item.Timestamp)">
                                    <td>{{$index+1}}</td>
                                    <td title="{{item.Barcode}}"><span class="tabulator-cell" style="width: 130px;">{{item.Barcode}}</td>

                                    <td>{{item.Length}}</td>
                                    <td>{{item.Width}}</td>
                                    <td>{{item.Height}}</td>
                                    <td>{{item.Weight}}</td>
                                    <td>{{item.Volume}}</td>
                                    <td>{{item.RealVolume}}</td>
                                    <td>{{item.PackageType}}</td>
                                    <td ng-class="{'divRed1': item.IsSend == 'Failed','divgreen': item.IsSend == 'Success'}">{{item.IsSend}}</td>
                                    <td title="{{item.ReasonForFailed}}"><span class="tabulator-cell" style="width: 100px;">{{item.ReasonForFailed}}</span></td>
                                    <td>{{item.Timestamp}}</td>
                                </tr>
                                <%--<tr>

                                    <td colspan="12" class="text-center" style="font-size: 15px; background-color: white; border-bottom: 1px solid white; border-right: 1px solid white; border-left: 1px solid white;">
                                        <div ng-switch="(listData | filter:txtSearch).length">
                                            <span class="ng-empty text-danger" ng-switch-when="0">No Record(s) Found</span>
                                        </div>
                                    </td>
                                </tr>--%>
                            </tbody>
                        </table>
                        <div class="out_wrap" id="NoDataDiv">
                            <div class="inner_box" style="background: #fff; padding: 50px;">
                                <img src="../../assets/images/announcement.svg">
                                <div class="text_note">
                                    <h4>No Results Found</h4>
                                </div>
                                <div class="text_line">No AWB processed today
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table_data" id="searchtable" style="margin-bottom: 0px; display: none;">
                        <p style="text-align: center;">{{searchTotal}} Records Found</p>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Sr.No</th>
                                    <th scope="col">AWB</th>

                                    <th scope="col">Length(cm)</th>
                                    <th scope="col">Width(cm)</th>
                                    <th scope="col">Height(cm)</th>
                                    <th scope="col">Weight(g)</th>
                                    <th scope="col">Volume(mm3)</th>
                                    <th scope="col">Real Volume(mm3)</th>
                                    <th scope="col">Package Type</th>
                                    <th scope="col">Data Send</th>
                                    <th scope="col">Reason for Failed </th>
                                    <th scope="col">Datetime</th>

                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="item in listData1">
                                    <td>{{$index+1}}</td>
                                    <td>{{item.Barcode}}</td>

                                    <td>{{item.Length}}</td>
                                    <td>{{item.Width}}</td>
                                    <td>{{item.Height}}</td>
                                    <td>{{item.Weight}}</td>
                                    <td>{{item.Volume}}</td>
                                    <td>{{item.RealVolume}}</td>
                                    <td>{{item.PackageType}}</td>
                                    <td ng-class="{'divRed1': item.IsSend == 'Failed','divgreen': item.IsSend == 'Success'}">{{item.IsSend}}</td>
                                    <td title="{{item.ReasonForFailed}}"><span class="tabulator-cell" style="width: 130px;">{{item.ReasonForFailed}}</span></td>
                                    <td>{{item.Datetime}}</td>
                                </tr>
                                <tr>
                                    <td colspan="12" class="text-center" style="font-size: 15px; background-color: white; border-bottom: 1px solid white; border-right: 1px solid white; border-left: 1px solid white;">
                                        <div ng-switch="(listData1 | filter:txtSearch1).length">
                                            <span class="ng-empty text-danger" ng-switch-when="0">No Record(s) Found</span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <%-- Model--%>

                    <div class="modal fade" id="Modal_Notify_announciation" role="dialog" tabindex="-1" style="padding-right: 17px; display: none;">
                        <div class="modal-dialog" style="max-width: 750px; min-height: 100px; margin-top: 80px;">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Active alarm's</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body" style="min-height: 100px;">
                                    <div class="">

                                        <table class="table_wrap table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th class="w30">Sr.No</th>
                                                    <th class="w100">Time</th>
                                                    <th class="w100">Date</th>
                                                    <th class="w450">Error Description</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr ng-repeat="item in AnnunciationData" ng-click="open()">
                                                    <td>{{item.RowNum}}</td>
                                                    <td>{{item.Time}}</td>
                                                    <td>{{item.Date}}</td>
                                                    <td>{{item.ErrorDescription}}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>

                        </div>
                    </div>


                    <%-- Model End--%>


                    <div id="IDannounciation" style="display: none;" ng-click="open()">
                        <div class="fr_scroll">

                            <table class="table_wrap table" ng-click="open()">
                                <tbody>
                                    <tr ng-repeat="item in AnnunciationData" ng-click="open()">
                                        <td style="text-align: left; font-weight: 600; color: red; border-top: none; padding-top: 0px; padding-bottom: 0px; cursor: pointer;" ng-click="open()"><i class="far fa-bell" style="margin-right: 4px;"></i>{{item.ErrorDescription}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <%-- Model--%>

                    <div class="modal fade" id="Modal_Barcode_details" role="dialog" tabindex="-1" style="padding-right: 17px; display: none; z-index: 999999;">
                        <div class="modal-dialog" style="max-width: 1200px; min-height: 100px; margin-top: 80px;">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title"><i class="fas fa-barcode"></i>AWB Detail</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body" style="min-height: 100px;">
                                    <div class="">

                                        <div class="colums">
                                            <div class="item">
                                                <label for="txtAWB">AWB</label>
                                                <input id="txtAWB" ng-model="txtAWB" type="text" name="txtAWB" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtLength">Length(cm)</label>
                                                <input id="txtLength" ng-model="txtLength" type="text" name="txtLength" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtWidth">Width(cm)</label>
                                                <input id="txtWidth" ng-model="txtWidth" type="text" name="txtWidth" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtHeight">Height(cm)</label>
                                                <input id="txtHeight" ng-model="txtHeight" type="text" name="txtHeight" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtWeight">Weight(g)</label>
                                                <input id="txtWeight" ng-model="txtWeight" type="text" name="txtWeight" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtVolume">Volume(mm3)</label>
                                                <input id="txtVolume" ng-model="txtVolume" type="text" name="txtVolume" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtReal">Real Volume(mm3)</label>
                                                <input id="txtReal" ng-model="txtReal" type="text" name="txtReal" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtPackage">Package Type</label>
                                                <input id="txtPackage" ng-model="txtPackage" type="text" name="txtPackage" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtData">Data Send</label>
                                                <input id="txtData" ng-class="{'divRed1': txtData == 'Failed','divgreen': txtData == 'Success'}" ng-model="txtData" type="tel" name="txtData" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtDatetime">Datetime</label>
                                                <input id="txtDatetime" ng-model="txtDatetime" type="text" name="txtDatetime" disabled />
                                            </div>
                                            <div class="item">
                                                <label for="txtFailed">Reason for Failed</label>
                                                <textarea style="width: 1158px;" rows="1" cols="50" id="txtFailed" ng-model="txtFailed" type="textarea" name="txtFailed" disabled />
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
            </div>
        </div>

        <footer>
            <div class="foot_wrap">
                <span class="fot_txt">Copyright © 2020  Armstrong Machine Builders Pvt. Ltd  All rights reserved.</span>
            </div>
        </footer>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
