

<%-- 
    Document   : signUp
    Created on : May 15, 2015, 11:46:38 PM
    Author     : Oshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>E-Platform | Sign Up</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="img/title_logo.png" type="image/png">
        <link rel="shortcut icon" type="image/png" href="img/title_logo.png" />
        <link href="css/bootstrap.min.css"  rel="stylesheet" type="text/css"/>
        <link href="css/imp_style.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/imp.js"></script>
        <script src="js/jquery.nicescroll.min.js"></script>
        <link href="css/bootstrap-dialog.min.css"  rel="stylesheet" type="text/css"/>
        <script src="js/bootstrap-dialog.min.js"></script>
        <script>
            function sm_notify(text) {
                BootstrapDialog.show({
                    title: 'Notification',
                    message: text,
                    size: BootstrapDialog.SIZE_SMALL
                });
            }

            function sm_alert(text) {
                BootstrapDialog.alert({
                    title: 'Alert',
                    type: BootstrapDialog.TYPE_DANGER,
                    message: text,
                    size: BootstrapDialog.SIZE_SMALL
                });
            }

            function sm_warning(text) {
                BootstrapDialog.show({
                    title: 'Warning',
                    type: BootstrapDialog.TYPE_WARNING,
                    message: text,
                    size: BootstrapDialog.SIZE_SMALL
                });
            }


            function nom_Success(text) {
                BootstrapDialog.show({
                    title: 'Notification',
                    type: BootstrapDialog.TYPE_SUCCESS,
                    message: text,
                    size: BootstrapDialog.SIZE_NORMAL
                });
            }

            function nom_notify(text) {
                BootstrapDialog.show({
                    title: 'Notification',
                    message: text,
                    size: BootstrapDialog.SIZE_NORMAL
                });
            }

            function nom_alert(text) {
                BootstrapDialog.alert({
                    title: 'Alert',
                    type: BootstrapDialog.TYPE_DANGER,
                    message: text,
                    size: BootstrapDialog.SIZE_NORMAL
                });
            }

            function nom_warning(text) {
                BootstrapDialog.show({
                    title: 'Warning',
                    type: BootstrapDialog.TYPE_WARNING,
                    message: text,
                    size: BootstrapDialog.SIZE_NORMAL
                });
            }
        </script>
        <script>
            $(window).load(function () {
                $("body").css("overflow", "visible");
                var nice = $('html').niceScroll({cursorborder: "", cursorcolor: "transparent", cursorwidth: "10px", boxzoom: true, autohidemode: false});

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
            function checkPass() {
                document.getElementById("")
            }

            function checkDomainValid() {

                var emailAdd = document.getElementById('emailAdd').value;
                var xmlHttp = getAjaxObject();
                xmlHttp.onreadystatechange = function ()
                {
                    if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
                    {
                        var reply = xmlHttp.responseText;
                        console.log(reply);
                        if (reply === "exist") {
                            sm_notify("Success");
                            document.getElementById("otherData").className = '';
                            document.getElementById("btn_Next").className = 'hidden';
                            document.getElementById("emailAdd").readOnly = true;

                        } else if (reply === "alreadyExistUser") {
                            nom_warning("Email address already exist with E Platform");
                            document.getElementById("otherData").className = 'hidden';
                            document.getElementById("emailAdd").value = "";
                        } else {
                            nom_alert("Entered Email Address is not correct");
                            document.getElementById("otherData").className = 'hidden';
                            document.getElementById("emailAdd").value = "";
                        }

                    }
                }
                xmlHttp.open("POST", "UserController?actionType=CheckDomain&emailAdd=" + emailAdd, true);
                xmlHttp.send();
            }

            function checkPassword() {

                var password = document.getElementById('password').value;
                var cpassword = document.getElementById('cpassword').value;


                if (password === cpassword) {
                    return true;
                } else {
                    sm_alert("Confirm Password is not matched");
                    document.getElementById("cpassword").value = "";
                }

            }
        </script>

        <script>
            function showCoords() {
                $('html').getNiceScroll().resize();
            }
        </script>

    </head>
    <body onmousemove="showCoords()">
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
                    <%
                        String success = (String) request.getAttribute("SUCCESS_MESSAGE");
                        String error = (String) request.getAttribute("ERROR_MESSAGE");
                    %>
                    <div class="row" style="padding-top: 50px; padding-bottom: 60px;">
                        <div class="col-lg-8 col-lg-offset-2">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">Sign Up</h3>
                                </div>

                                <form class="form-horizontal" action="UserController?actionType=Signup" method="POST" id="register-form">
                                    <div class="panel-body" style="padding-right: 50px;"><div class="form-group">
                                            <div class="col-xs-offset-3 col-xs-9">
                                                <strong>
                                                    <font color="green"><% if (success != null) {
                                                            out.println(success);
                                                        }%></font>
                                                    <font color="red"><% if (error != null) {
                                                            out.println(error);
                                                        }%></font>

                                                </strong> 

                                            </div>
                                        </div>
                                        <div class="raw" style="padding-right: 50px;">
                                            <div class="form-group">
                                                <label for="email" class="control-label col-xs-5 lbl_name">Email : </label>
                                                <div class="col-xs-7">
                                                    <input  type="email" class="form-control" name="emailAdd" id="emailAdd" placeholder="Enter Email" required/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="hidden" id="otherData" style="padding-right: 50px;">
                                            <div class="form-group">
                                                <label for="username" class="control-label col-xs-5 lbl_name">Username : </label>
                                                <div class="col-xs-7">
                                                    <input type="text" name="username" class="form-control" id="username" placeholder="Enter Username" required/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="password" class="control-label col-xs-5 lbl_name">Password : </label>
                                                <div class="col-xs-7">
                                                    <input type="password" name="password" class="form-control" id="password" placeholder="Enter Password" required/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="cpassword" class="control-label col-xs-5 lbl_name">Confirm Password : </label>
                                                <div class="col-xs-7">
                                                    <input type="password" name="cpassword" class="form-control" id="cpassword" placeholder="Confirm Password" onblur="checkPassword();" required/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="firstName" class="control-label col-xs-5 lbl_name">First Name :</label>
                                                <div class="col-xs-7">
                                                    <input type="text" name="firstName" class="form-control" id="firstName" placeholder="Enter First Name" required/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="lastName" class="control-label col-xs-5 lbl_name">Last Name :</label>
                                                <div class="col-xs-7">
                                                    <input type="text" name="lastName" class="form-control" id="lastName" placeholder="Enter Last Name" required/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputTelephone" class="control-label col-xs-5 lbl_name">Contact Number : </label>
                                                <div class="col-xs-7">
                                                    <input type="number" name="telephone" class="form-control" id="inputTelephone" placeholder="Enter Telephone Number" required/>
                                                </div>
                                            </div>
                                            <br/>
                                            <div class="form-group" style="padding-right: 50px;">
                                                <div class="col-xs-offset-6 col-xs-6">
                                                    <center><button type="submit" class="btn btn-primary"  >Register</button></center>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="raw" style="padding-right: 50px;">
                                            <div class="form-group">
                                                <div class="col-xs-7 pull-right">
                                                    <input  type="button" class="form-control btn btn-primary" name="btn_Next" id="btn_Next" value="Next" onclick="checkDomainValid();"/>
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>

                <script type="text/javascript">
                    var country_list = ["Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Anguilla", "Antigua &amp; Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia &amp; Herzegovina", "Botswana", "Brazil", "British Virgin Islands", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Cape Verde", "Cayman Islands", "Chad", "Chile", "China", "Colombia", "Congo", "Cook Islands", "Costa Rica", "Cote D Ivoire", "Croatia", "Cruise Ship", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Estonia", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Polynesia", "French West Indies", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea Bissau", "Guyana", "Haiti", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kuwait", "Kyrgyz Republic", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Mauritania", "Mauritius", "Mexico", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Namibia", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russia", "Rwanda", "Saint Pierre &amp; Miquelon", "Samoa", "San Marino", "Satellite", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "South Africa", "South Korea", "Spain", "Sri Lanka", "St Kitts &amp; Nevis", "St Lucia", "St Vincent", "St. Lucia", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor L'Este", "Togo", "Tonga", "Trinidad &amp; Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks &amp; Caicos", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "Uruguay", "Uzbekistan", "Venezuela", "Vietnam", "Virgin Islands (US)", "Yemen", "Zambia", "Zimbabwe"];

                    var sel = document.getElementById('selectCountry');
                    for (var i = 0; i < country_list.length; i++) {
                        var opt = document.createElement('option');
                        opt.innerHTML = country_list[i];
                        opt.value = country_list[i];
                        sel.appendChild(opt);
                    }
                </script>
            </div>
            <div id="footer_div" >
                <div class="navbar navbar-blend navbar-fixed-bottom">
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

