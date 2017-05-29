<%-- 
    Document   : pageNotFound
    Created on : Jun 9, 2015, 10:32:06 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<%String success_message = (String) request.getAttribute("Success_Message");
    String error_message = (String) request.getAttribute("Error_Message");%>
<html>
    <head>
        <title>E-Platform | Impressions</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="/IEPTescoNew/img/title_logo.png" type="image/png">
        <link rel="shortcut icon" type="image/png" href="/IEPTescoNew/img/title_logo.png" />
        <link href="/IEPTescoNew/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="/IEPTescoNew/css/imp_style.css" rel="stylesheet" type="text/css"/>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>
        <script src="/IEPTescoNew/js/jquery.js"></script>
        <script src="/IEPTescoNew/js/bootstrap.js"></script>
        <script src="/IEPTescoNew/js/jquery.nicescroll.min.js"></script>
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
                <div class="col-lg-3 col-xs-12">

                    <img src="/IEPTescoNew/img/logo.png" class=""
                         alt="impressions labelk logo"  style="max-height: 80px; width: auto;"/>

                </div>
            </div>
        </div>
        <script type="text/javascript">
            document.title = "Internal Server error | E-Platform"
        </script>

        <div id="content"> 
            <br/>
            <div class="col-lg-4 col-lg-offset-4 col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-8 col-xs-offset-2" style="overflow-y: auto; ">
                <span>
                    <img class="img-responsive" src="/IEPTescoNew/img/ServerError.GIF" alt="Internal Server error." />
                </span>
                <div style="width:100%;">
                    <form name="backtoadmin" action="index.jsp">
                        <input class="btn btn-lg btn-info" type="submit" value="Back to Home" style="width: 100%;"/>
                    </form>
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
    </body>
</html>

