<%-- 
    Document   : fogotPassword
    Created on : May 15, 2015, 10:47:51 PM
    Author     : Oshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%String success_message = (String) request.getAttribute("Success_Message");
    String error_message = (String) request.getAttribute("Error_Message");
%>
<html>
    <head>
        <title>Forget Password | E-Platform</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="img/title_logo.png" type="image/png">
        <link rel="shortcut icon" type="image/png" href="img/title_logo.png" />
        <link href="css/bootstrap.min.css"  rel="stylesheet" type="text/css"/>
        <link href="css/imp_style.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>
        <link rel="stylesheet" href="./css/jquery.sidr.dark.css">
        <script src="js/bootstrap.js"></script>
        <script src="js/jquery.nicescroll.min.js"></script>
        <script>
            $(window).load(function () {
                $("body").css("overflow", "visible");
                var nice = $('html').niceScroll({cursorborder: "", cursorcolor: "#000", cursorwidth: "2px", boxzoom: true, autohidemode: false});

            });
        </script>
        <style type="text/css">
            body{
                margin: 0px;
            }
        </style>
        <script>
            window.onload = function () {
                var d = new Date();
                var n = d.getFullYear();
                var dat = document.getElementById("year");
                dat.innerHTML = n;
            }
        </script>

    </head>
    <body>
        <div class="container-fluid" style="padding: 0px;">
            <div id="top_div" >
                <div class="row">
                    <div class="col-xs-12">

                        <img src="./img/logo.png" class=""
                             alt="impressions labelk logo"  style="max-height: 80px; width: auto;"/>

                    </div>
                </div>
            </div>

            <div id="content">
                <div class="container">
                    <div class="container">
                        <div class="row" style="margin: 150px;">
                            <div class="col-lg-6 col-md-6 col-lg-offset-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Forget Password</h3>
                                    </div>
                                    <div class="panel-body">
                                        <form action="ResetPWController" method="post">
                                            <input type="hidden" name="method" value="reset" />
                                            <%
                                             String email_error = (String) request.getAttribute("email_error"); 
                                             if(email_error==null){                       
                                            %>
                                            <p align="left">Please enter you email address to receive
                                                details for new password.</p>
                                            <% }else{%>
                                            <p id="error" align="left"><font color="red">Your Email address is not in our System<br/> Please Contact The System Administrator</font></p>
                                            <%}%>
                                            <div >
                                                <input type="email" class="form-control" id="email"
                                                       name="email" placeholder="Enter Your Email Address" required/>
                                            </div>
                                            <br />
                                            <div class="col-lg-4">
                                                <input type="submit" name="submit" class="btn btn-primary btn-group-justified"
                                                       style="width: 150px;" value="Send" />
                                                <i class="icon-time"></i>
                                             
                                            </div>
                                            <div class="panel-heading">
                                                <div style="float: right; font-size: 90%; position: relative; top: 6px">
                            <a href="index.jsp">Back To Login</a>
                        </div>
                    </div>
<!--                                             <div class="col-lg-4">
                                                <input type="submit" name="Back To Home" class="btn btn-primary pull-right"
                                                       style="width: 150px;" value="Send" />
                                                <i class="icon-time"></i>
                                            </div>-->
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footer_div" >
                <div class=" navbar navbar-blend navbar-fixed-bottom">
                    <div class="container-fluid" style="padding-top: 20px; color: #c0c0c0; font-size: 12px;">
                        <div class="pull-right">
                            <p class="">Impressions Labels (PVT) Ltd &copy; <span id="year"><em></em></span></p>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </body>
</html>

