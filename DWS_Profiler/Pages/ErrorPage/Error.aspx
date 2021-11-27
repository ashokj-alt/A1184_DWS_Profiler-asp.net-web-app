<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="DWS_Profiler.Pages.ErrorPage.Error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #notfound {
            position: relative;
            height: 100vh;
        }

            #notfound .notfound {
                position: absolute;
                left: 50%;
                top: 50%;
                -webkit-transform: translate(-50%,-50%);
                -ms-transform: translate(-50%,-50%);
                transform: translate(-50%,-50%);
            }

        .notfound {
            max-width: 560px;
            width: 100%;
            padding-left: 160px;
            line-height: 1.1;
        }

            .notfound .notfound-404 {
                position: absolute;
                left: 0;
                top: 0;
                display: inline-block;
                width: 140px;
                height: 140px;
                background-image: url(../img/emoji.png);
                background-size: cover;
            }

        .notfound {
            max-width: 560px;
            width: 100%;
            padding-left: 160px;
            line-height: 1.1;
        }

            .notfound .notfound-404:before {
                content: '';
                position: absolute;
                width: 100%;
                height: 100%;
                -webkit-transform: scale(2.4);
                -ms-transform: scale(2.4);
                transform: scale(2.4);
                border-radius: 50%;
                background-color: #f2f5f8;
                z-index: -1;
            }

            .notfound h1 {
                font-family: nunito,sans-serif;
                font-size: 65px;
                font-weight: 700;
                margin-top: 0;
                margin-bottom: 10px;
                color: #151723;
                text-transform: uppercase;
            }

        h1 {
            display: block;
            font-size: 2em;
            margin-block-start: 0.67em;
            margin-block-end: 0.67em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
            font-weight: bold;
        }

        .notfound h2 {
            font-family: nunito,sans-serif;
            font-size: 21px;
            font-weight: 400;
            margin: 0;
            text-transform: uppercase;
            color: #151723;
        }

        .notfound p {
            font-family: nunito,sans-serif;
            color: #999fa5;
            font-weight: 400;
        }

        .notfound a {
            font-family: nunito,sans-serif;
            display: inline-block;
            font-weight: 700;
            border-radius: 40px;
            text-decoration: none;
            color: #388dbc;
        }
    </style>
</head>
<body>
    <div id="notfound">
        <div class="notfound">
            <div class="notfound-404"></div>
            <h1>404</h1>
            <h2>Oops! Page Not Be Found</h2>
            <p>Sorry but the page you are looking for does not exist, have been removed. name changed or is temporarily unavailable</p>
            <a href="/login.aspx">Back to homepage</a>
        </div>
    </div>
</body>
</html>
