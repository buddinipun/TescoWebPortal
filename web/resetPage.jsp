<%-- 
    Document   : resetPage
    Created on : May 21, 2015, 3:25:10 AM
    Author     : Kalana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%String success_message = (String) request.getAttribute("Success_Message");
    String error_message = (String) request.getAttribute("Error_Message");%>
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
                var nice = $('html').niceScroll({cursorborder: "", cursorcolor: "transparent", cursorwidth: "1px", boxzoom: true, autohidemode: false});

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

        <script>

            function compare() {
                var pass = document.getElementById("pass").value;
                var repass = document.getElementById("repass").value;
                if (pass === repass) {
                    return true;
                } else {
                    return false;
                }
            }
        </script>

    </head>
    <%String username = request.getParameter("pin");

        out.print(username);

    %>

    <body>
        <div class="container-fluid" style="padding: 0px;">
            <div id="top_div" >
                <div class="row">
                    <div class="col-xs-12">

                        <img src="img/logo.png" class=""
                             alt="impressions labelk logo"  style="max-height: 80px; width: auto;"/>

                    </div>
                </div>
            </div>
            <div id="content">
                <div class="container">
                    <div class="container">
                        <div class="row" style="margin: 100px;">
                            <div class="col-lg-6 col-md-6 col-lg-offset-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Forget Password</h3>
                                    </div>
                                    <div class="panel-body">
                                        <form action="ResetPWController?method=newpass" method="post" onsubmit="return compare();">

                                            <p align="left"> Now you can reset a new password for your account <br>
                                                Please fill in the below.</p> 
                                            <div class="controls bootstrap-timepicker">    
                                                <input type="password" class="form-control"   id="pass" name="pass" placeholder="New password" />
                                            </div>
                                            <br/>
                                            <div class="controls bootstrap-timepicker">    
                                                <input type="password" class="form-control" id="repass" name="repass" placeholder="Retype Password"/>
                                                <input type="hidden" value="<%=username%>" name="email"/>
                                            </div>
                                            <br/>
                                            <div class="controls bootstrap-timepicker">
                                                <input type="submit" name="submit" class="btn btn-primary pull-right" style="width: 150px;" value="Reset Password"/>
                                                <i class="icon-time"></i>
                                            </div>
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

