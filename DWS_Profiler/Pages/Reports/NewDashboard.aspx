<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="NewDashboard.aspx.cs" Inherits="DWS_Profiler.Pages.Reports.NewDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../global/css/NewDashboard.css" rel="stylesheet" />
    <script src="../../JS/Highcharts/highcharts.js"></script>
    <script src="../../JS/bootstrap.bundle.min.js"></script>
    <script src="../../JS/dashboard/NewDashboard.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex dashboard_page scada_page" id="wrapper" ng-app="myApp" ng-controller="myController" ng-init="StartTimer()">
        <div id="page-content-wrapper">
            <div class="">
                <div class="dynamic_ht">
                    <div class="">
                        <div class="">
                        </div>
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-2 pl-0 pr-0">
                                    <div class="not_out_wrap">
                                        <div class="status_wrap">
                                            <h3>Connected Device Status</h3>
                                            <ul>
                                                <li ng-class="{'divgreen1':manual==1}">Manual <span class="dev_icon">
                                                    <img src="../../Images/manual_icon.png" alt="manual"></span></li>
                                                <li ng-class="{'divgreen1':auto==1}">Auto <span class="dev_icon">
                                                    <img src="../../Images/auto.png" alt="Auto"></span></li>
                                                <li ng-class="{'divRed':PLCLAN==1}">PLC <span class="dev_icon">
                                                    <img src="../../Images/plc.png"></span></li>
                                                <li ng-class="{'divRed':CameraLan==1}">Camera <span class="dev_icon">
                                                    <img src="../../Images/cam.png"></span></li>
                                                <li ng-class="{'divRed':CheckWeigherLAN==1}">Wheigher <span class="dev_icon">
                                                    <img src="../../Images/Wehig_icon.png"></span></li>
                                                <li ng-class="{'divRed':VMSLAN==1}">VMS <span class="dev_icon">
                                                    <img src="../../Images/VMS.png"></span></li>
                                                <li ng-class="{'divRed':HMILAN==1}">HMI <span class="dev_icon">
                                                    <img src="../../Images/hmi.png"></span></li>
                                            </ul>
                                        </div>
                                        <div class="sys_idle bg_sys">
                                            <h3 class="sys_txt">SYSTEM IDLE TIME</h3>
                                            <div id="idleTime">
                                                <div class="sys_time">{{Day}}:{{Hour1}}:{{Minute}}:{{Second}}</div>
                                                <div class="sys_time">D:H:M:S</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-10">

                                    <div class="mid_wrap">
                                        <div class="row">
                                            <div class="col-lg-3">
                                                <div class="tiles_wrap">
                                                    <div class="tile_title">AWB</div>
                                                    <div class="tile_cnt">{{Barcode}}</div>
                                                    <div class="tile_icon">
                                                        <img src="../../Images/awb_icon.png" alt="awb_icon">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="tiles_wrap">
                                                    <div class="tile_title">Today's Count</div>
                                                    <div class="tile_cnt">{{totalCount}}</div>
                                                    <div class="tile_icon">
                                                        <img src="../../Images/cnt_icon.png" alt="cnt_icon">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="tiles_wrap">
                                                    <div class="tile_title">Volume(cm3)</div>
                                                    <div class="tile_cnt">{{Volume}}</div>
                                                    <div class="tile_icon">
                                                        <img src="../../Images/vol_icon.png" alt="vol_icon">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="tiles_wrap">
                                                    <div class="tile_title">Real Volume(cm3)</div>
                                                    <div class="tile_cnt">{{RealVolume}}</div>
                                                    <div class="tile_icon">
                                                        <img src="../../Images/rvol_icon.png" alt="rvol_icon">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="tiles_wrap">
                                                    <div class="tile_title">Length(cm)</div>
                                                    <div class="tile_cnt">{{Length}}</div>
                                                    <div class="tile_icon">
                                                        <img src="../../Images/length.png" alt="length_icon">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="tiles_wrap">
                                                    <div class="tile_title">Width(cm)</div>
                                                    <div class="tile_cnt">{{Width}}</div>
                                                    <div class="tile_icon">
                                                        <img src="../../Images/width.png" alt="wid_icon">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="tiles_wrap">
                                                    <div class="tile_title">Height(cm)</div>
                                                    <div class="tile_cnt">{{Height}}</div>
                                                    <div class="tile_icon">
                                                        <img src="../../Images/height.png" alt="height_icon">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="tiles_wrap">
                                                    <div class="tile_title">Weight(g)</div>
                                                    <div class="tile_cnt">{{Weight}}</div>
                                                    <div class="tile_icon">
                                                        <img src="../../Images/weight1.png" alt="weight_icon">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="process_wrap">
                                        <div class="col-lg-12 pl-0 pr-0">
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <h3 class=""><i class="fa fa-table" aria-hidden="true"></i>Processed Packages (Last 5 Records)</h3>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="right_side">
                                                        <ul>
                                                            <li>
                                                                <span class="ser_box">
                                                                    <input type="text" name="" ng-model="txtSearch1" class="form-control" placeholder="Search Here" /></span>
                                                                <span class="ser_btn">
                                                                    <button type="button" style="min-width: 20px;" class="btn btn-primary" ng-click="SearchData()"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                                </span>
                                                            </li>
                                                            <li class="exp_btn" style="margin-top: 0px;">
                                                                <button type="button" id="exportbtn1" class="btn btn-primary" ng-click="Export()" title="Export today's data" style="box-shadow:none;border-radius:inherit;min-width:100px;background-color:#002f7e;padding-right:9px;padding: 3px 12px;">
                                                                    <span class="ex_txt">Export </span>
                                                                    <img src="../../Images/export.png" alt="export"></button>
                                                                <button type="button" style="display: none;box-shadow: none;border-radius: inherit;padding: 3px 12px;" id="Searchexportbtn" class="btn btn-primary inline" ng-click="SearchExport()" title="Export Searched data">
                                                                    <span class="ex_txt">Export </span>
                                                                    <img src="../../Images/export.png" alt="export"></button>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="proc_table_box">
                                            <div class="table-responsive table_data">
                                                <table class="table table-striped table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th title="Air Way Bill">AWB</th>
                                                            <th title="Length in cm">Length(cm)</th>
                                                            <th title="Width in cm">Wid(cm)</th>
                                                            <th title="Height in cm">Ht(cm)</th>
                                                            <th title="weight in gram">Wt(g)</th>
                                                            <th title="Volume in cm3">Vol(cm3)</th>
                                                            <th title="Real volume in cm3">Real Vol(cm3)</th>
                                                            <th title="Package Type">Pkg Type</th>
                                                            <th title="Data sent">Data Sent</th>
                                                            <th title="Failed Reason">Failed Reason</th>
                                                            <th title="Timestamp">Timestamp</th>
                                                            <th title="Responce time">Responce</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr ng-repeat="item in toplistData" ng-click="showData(item.Barcode,item.Length,item.Width,item.Height,item.Weight,item.Volume,item.RealVolume,item.PackageType,item.IsSend,item.ReasonForFailed,item.Timestamp)">
                                                            <td>{{item.Barcode}}</td>
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
                                                            <td>{{item.TimeDiffrence}}ms</td>
                                                        </tr>

                                                    </tbody>
                                                </table>
                                                <div class="out_wrap" id="NoDataDiv">
                                                    <div class="inner_box" style="background: #fff; padding: 25px;">
                                                        <img src="../../assets/images/announcement.svg">
                                                        <div class="text_note">
                                                            <h6>No Results Found</h6>
                                                        </div>
                                                        <div class="text_line">
                                                            No AWB processed today
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div id="searchtable" class="searchtable" style="margin-bottom: 0px; display: none;height:180px;">
                                                <button type="button" class="close" data-dismiss="searchtable" ng-click="close()">×</button>
                                                <p style="text-align: center;">{{searchTotal}} Records Found</p>
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th title="Air Way Bill">AWB</th>
                                                            <th title="Length in cm">Length(cm)</th>
                                                            <th title="Width in cm">Wid(cm)</th>
                                                            <th title="Height in cm">Ht(cm)</th>
                                                            <th title="weight in gram">Wt(g)</th>
                                                            <th title="Volume in cm3">Vol(cm3)</th>
                                                            <th title="Real volume in cm3">Real Vol(cm3)</th>
                                                            <th title="Package Type">Pkg Type</th>
                                                            <th title="Data sent">Data Sent</th>
                                                            <th title="Failed Reason">Failed Reason</th>
                                                            <th title="Timestamp">Timestamp</th>
                                                            <th title="Responce time">Responce</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr ng-repeat="item in listData1" ng-click="showData(item.Barcode,item.Length,item.Width,item.Height,item.Weight,item.Volume,item.RealVolume,item.PackageType,item.IsSend,item.ReasonForFailed,item.Timestamp)">
                                                            <td>{{item.Barcode}}</td>
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
                                                            <td>{{item.TimeDiffrence}}ms</td>
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

                                        </div>
                                    </div>
                                    <div class="bottom_box" style="float: left; width: 100%;">
                                        <div class="col-lg-12 pl-0 pr-0">
                                            <div class="row" style="width: 100%;">
                                                <div class="col-lg-6 pl-0">
                                                    <div class="Shipment_wrap">
                                                        <div class="chart_wrap">
                                                            <figure class="highcharts-figure" id="PerHourShipment">
                                                                <div id="container" style="height: 150px;"></div>
                                                                <p class="highcharts-description">
                                                                </p>
                                                            </figure>
                                                            <div class="out_wrap" id="NoPerHourShipment" ng-show="NoPerHourShipment">
                                                                <div class="inner_box">
                                                                    <img src="../../Content/Images/announcement.svg">
                                                                    <div class="text_note">
                                                                        <h4 style="margin-top: 0px; margin-bottom: 0px;">No Results Found</h4>
                                                                    </div>
                                                                    <div class="text_line">Search for another term or try changing filters</div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3">
                                                    <div class="img_wrap">
                                                        <div class="pallet_txt">Image Sent Count</div>
                                                        <div class="pallet_cnt">{{ImageSentCount}}</div>
                                                    </div>
                                                    <div class="awb_wrap">
                                                        <div class="pallet_txt">AWB Sent Count</div>
                                                        <div class="pallet_cnt">{{DataSentCount}}</div>
                                                    </div>

                                                </div>
                                                <div class="col-lg-3 pr-0">
                                                    <div class="status_wrap">
                                                        <h3>System Alerts  <span style="font-size:13px;">{{ActiveFaultCount}} active alerts</span></h3>
                                                        <ul>
                                                            <div class="alert alert-secondary alert-dismissible" ng-repeat="item in AlarmList">
                                                                <button type="button" class="close" data-dismiss="alert">×</button>
                                                                <span class="cell_icon">
                                                                    <img src={{AlertImagePath}} alt="info_icon"></span>{{item.ErrorDescription}}
                                         
                                                            </div>
                                                            <div class="alert alert-secondary alert-dismissible" id="NoAlarm" style="display: none;font-size:14px;">
                                                                <button type="button" class="close" data-dismiss="alert">×</button>
                                                                <span class="cell_icon">
                                                                    <img src="../../Images/notification.svg" alt="info_icon" style="color: green;"></span>Syatem is Healthy. No active alerts
                                         
                                                            </div>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer class="main-footer">
            <strong>Copyright © 2020 <a href="">Armstrong Machine Builders Pvt. Ltd</a>.</strong>
            All rights reserved.
        </footer>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script type="text/javascript">
        var elem, el;
        function openFullscreen(inpt) {

            el = $(inpt).parent().parent().find('div.abc').attr('id');
            elem = document.getElementById(el);
            if (elem.requestFullscreen) {
                elem.requestFullscreen();
            } else if (elem.webkitRequestFullscreen) {
                elem.webkitRequestFullscreen();
            } else if (elem.msRequestFullscreen) {
                elem.msRequestFullscreen();
            }
        }

        $("#btn_clk").on("click", function () {
            $(".scada_thumb").hide(100);
            $(".scada_thumb_new").show(100);
        });


        $("#bck_btn_clk").on("click", function () {
            $(".scada_thumb").show(100);
            $(".scada_thumb_new").hide(100);
        });
    </script>
</asp:Content>
