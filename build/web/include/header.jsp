<%-- 
    Document   : header
    Created on : Jul 5, 2015, 7:05:38 AM
    Author     : oshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="/IEPTescoNew/img/title_logo.png" type="image/png">
        <link rel="shortcut icon" type="image/png" href="/IEPTescoNew/img/title_logo.png" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>


        <title>E-Platform | Impressions</title>

        <!-- Bootstrap Core CSS -->
        <link href="/IEPTescoNew/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="/IEPTescoNew/css/sb-admin.css" rel="stylesheet">

        <!-- Morris Charts CSS -->
        <link href="/IEPTescoNew/css/plugins/morris.css" rel="stylesheet">

        <!-- IMP CSS-->
        <link href="/IEPTescoNew/css/imp_style.css" rel="stylesheet">

        <!-- Bootstrap Dialog CSS-->
        <link href="/IEPTescoNew/css/bootstrap-dialog.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="/IEPTescoNew/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">

        <link href="/IEPTescoNew/css/jquery-ui.css" rel="stylesheet" type="text/css">

        <style type="text/css">
            .no-js #loader { display: none;  }
            .js #loader { display: block; position: absolute; left: 100px; top: 0; }
            .se-pre-con {
                position: fixed;
                left: 0px;
                top: 0px;
                width: 100%;
                height: 100%;
                z-index: 9999;
                background: url(/IEPTescoNew/img/Preloader_2.gif) center no-repeat #fff;
            }
        </style>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
        <script>
            $(window).load(function () {
                $(".se-pre-con").fadeOut("slow");
            });
        </script>
    </head>



    <body>

        <div class="se-pre-con"></div>
        <div id="wrapper" style="padding-bottom: 40px;">
