

<%@page import="com.impression.hibe.model.SysUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%
    String success_message = (String) request.getAttribute("Success_Message");
    String error_message = (String) request.getAttribute("Error_Message");
%>
<html>
    <head>
        <title>E-Platform | Impressions</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="img/title_logo.png" type="image/png">
        <link rel="shortcut icon" type="image/png" href="img/title_logo.png" />
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/imp_style.css" rel="stylesheet" type="text/css"/>
        <link href="css/carousel.css" rel="stylesheet" type="text/css"/>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/jquery.nicescroll.min.js"></script>

        <script>
            $(document).ready(function () {
                checkResize();
                $(window).resize(function () {
                    checkResize();
                });

                function checkResize() {
                    var w_height = ($(window).height() - 140) + "px";
                    $(".carousel").css("height", w_height);
                    $(".carousel .item ").css("height", w_height);
                    $(".carousel-inner > .item > img").css("height", w_height);
                }
            });
        </script>
        <script>
            window.onload = function () {
                var d = new Date();
                var n = d.getFullYear();
                var dat = document.getElementById("year");
                dat.innerHTML = n;
            }
        </script>

    </head>
    <body style="overflow-y: auto;">
        <div id="top_div" >
            <div class="row">
                <div id="google_translate_element" style="float: right"></div>
                <div class="col-lg-3 col-xs-12">

                    <img src="./img/logo.png" class=""
                         alt="impressions labelk logo"  style="max-height: 80px; width: auto;"/>

                </div>
            </div>
        </div>
        <div id="login_panel" style="margin-bottom: 100px;">
            <div class="col-lg-4" style="top: 100px; margin-left: 5%; margin-right: 5%; margin-top: 2%; position: fixed; z-index:9999; ">
                <div class="panel panel-info" style="width: 100%;">
                    <div class="panel-heading">
                        <div class="panel-title">Sign In</div>
                        <div style="float: right; font-size: 80%; position: relative; top: -10px">
                            <a href="fogotPassword.jsp">Forgot password?</a>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div style="display: none" id="login-alert"
                             class="alert alert-danger col-sm-12"></div>

                        <form id="loginForm" class="form-horizontal" role="form" action="SignInController" method="POST">
                            <div class="input-group margin-top-20">
                                <span class="input-group-addon"><i
                                        class="glyphicon glyphicon-user"></i></span> <input id="login-username"
                                                                                    type="text" class="form-control" name="username" value=""
                                                                                    placeholder="Enter Username">

                            </div>

                            <div class="input-group margin-top-20" style="margin-top: 20px;">
                                <span class="input-group-addon"><i
                                        class="glyphicon glyphicon-lock"></i></span> <input id="login-password"
                                                                                    type="password" class="form-control" name="password" value=""
                                                                                    placeholder="Enter Password">

                            </div>

                            <div style="margin-top: 10px" class="form-group">
                                <!-- Button -->

                                <div class="col-lg-6">
                                    <input type="submit" name="submit" value="Login" class="btn btn-success"/>
                                </div>
                                <div class="col-lg-6">


                                </div>
                            </div>
                            <div style="margin-top: 10px" class="form-group">
                                <!-- Button -->

                                <div class="col-sm-12 controls ">
                                    <strong><font color="red">
                                        <% if (success_message != null) {
                                                out.println(success_message);
                                            }%>
                                        <% if (error_message != null) {
                                                out.println(error_message);
                                            }%>
                                        </font>
                                    </strong> 

                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-12 control">
                                    <div
                                        style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
                                        Don't have an account! <a href="signUp.jsp"
                                                                  onClick="$('#loginbox').hide();
                                                                          $('#signupbox').show()">
                                            Sign Up Here </a>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12 control">
                                    <div style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
                                        <font color="red"><b>Client Computer Recommendation:</b></font><br/>
                                        <b>Recommended Resolution:</b>    1366 x 768<br/>
                                        <b>Recommended Browser:</b>    Google Chrome<br/>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="myCarousel" class="carousel slide visible-lg" data-ride="carousel" style="margin-top: 100px;">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
                <li data-target="#myCarousel" data-slide-to="3"></li>
            </ol>
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img class="first-slide img-responsive" src="img/home/1.png" alt="First slide">
                    <div class="container">
                        <div class="carousel-caption" style="right: 10%;">
                            <h1 class="text-right"></h1>
                            <p class="text-right"></p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <img class="second-slide img-responsive" src="img/home/2.png" alt="Second slide">
                    <div class="container">
                        <div class="carousel-caption" style="right: 10%;">
                            <h1 class="text-right"></h1>
                            <p class="text-right"></p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <img class="third-slide img-responsive" src="img/home/3.png" alt="Third slide">
                    <div class="container">
                        <div class="carousel-caption" style="right: 10%;">
                            <h1 class="text-right"></h1>
                            <p class="text-right"></p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <img class="third-slide img-responsive" src="img/home/4.png" alt="Fourth slide">
                    <div class="container">
                        <div class="carousel-caption" style="right: 10%;">
                            <h1 class="text-right"></h1>
                            <p class="text-right"></p>
                        </div>
                    </div>
                </div>
            </div>
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <div id="footer_div" >
            <div class=" navbar navbar-blend navbar-fixed-bottom">
                <div class="container-fluid" style="padding-top: 20px; color: #c0c0c0; font-size: 12px;">
                    <div class="col-lg-3 pull-left">
                        <script type="text/javascript">
                            function googleTranslateElementInit() {
                                new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
                            }
                        </script>
                        <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

                        <p class="">Terms &  Conditions</p>
                    </div>
                    <div class="col-lg-6 hidden-sm hidden-xs">
                        <marquee scrolldelay="1" scrollamount="2">Sri Lanka &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; India &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; United Kingdom &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; China &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Bangladesh &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Cambodia &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Pakistan &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Turkey &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Vietnam &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Hong Kong   </marquee>
                    </div>
                    <div class="col-lg-3 pull-right">
                        <p class="pull-right">Impressions Labels &copy; <span id="year"><em></em></span></p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
