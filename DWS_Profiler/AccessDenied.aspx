<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessDenied.aspx.cs" Inherits="DWS_Profiler.AccessDenied" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">--%>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/global/css/bootstrap.min.css"/>
    <script src="/JS/jquery-1.12.4.js"></script>
    <script src="/JS/bootstrap.min.js"></script>
  <title>Armstrong</title>
  
  <style type="text/css">
    
    .inner_box {float: left;width: 100%;}
    .inner_box img{width: 60px;}
    .inner_box h4 {
    font-size: 30px;
    margin: 0;
    font-weight: 700;
    margin-bottom: 10px;
}
    .text_line {
    display: block;
    color: #696969;
    font-size: 18px;
    margin-bottom: 20px;
}
    .out_wrap {
    width: 50%;
    margin: 18% auto;
    background-color: #f1f4f5;
    display: flex;
    padding: 20px;
    text-align: left;
    }
    .cust_btn img{width:24px;}
    .cust_btn .btn.btn-primary {
    padding: 3px 10px;
    background-color: #3e8ff7;
    border-color: #3e8ff7;
}
.cust_btn .btn.btn-primary:focus{outline: none !important;}
.cust_btn_login img{width: 24px;}
.cust_btn_login .btn {padding: 3px 10px; background-color: #e4eaec;}
.cust_btn_login .btn:focus {padding: 3px 10px; background-color: #e4eaec; outline: none !important;}
 </style>
    <script language="javascript" type="text/javascript">
   
  </script>
    
<%--  </asp:Content>--%>
</head>
<body class="main_wrap dash_wrap">
<%--<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">--%>
	<section>
        <div class="main_wrap dash_wrap">
		<div class="out_wrap">

    <div class="inner_box">
      <div class="col-md-12">
        <div class="row">
          <div class="col-md-2">
             <img src="global/images/lock.svg"/>
          </div>
          <div class="col-md-10">
            <div class="row">
              <div class="col-md-12">
              <div class="text_note">
                <h4>Access Locked</h4>
            </div>
            <div class="text_line">You don't have permission to view this screen</div>
            </div>
            <div class="col-md-3 cust_btn">
             <a href="javascript:history.go(-1);" type="button" class="btn btn-primary"> <img src="global/images/back_arrow.svg"/> Go Back</a>
            </div>
            <div class="col-md-7 cust_btn_login">
              <a href="Login.aspx"  type="button" class="btn"><img src="global/images/usergroup.svg"/> Log in from another account</a>
            </div>
              </div>
         
          </div>
        </div>
      </div>
     
     
    </div>  
    </div>
       </div>
	</section>

   <%-- </asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    </asp:Content>--%>
</body>

</html>
