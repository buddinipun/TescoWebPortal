<%-- 
    Document   : addSuperUser
    Created on : Jul 5, 2015, 2:45:48 PM
    Author     : oshan
--%>

<%@include file="include/header.jsp"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="include/sideMenu.jsp"%>
<%    SysUser user6 = (SysUser) session.getAttribute("user");
    if (user6 != null) {


%>
<%    SysUser user = (SysUser) session.getAttribute("user");
%>

<sql:query var="idQ2"  dataSource="jdbc/sdb">
    SELECT * FROM sys_user_menu_item sm INNER JOIN sys_user s ON sm.`username`=s.`username` WHERE sm.username='<%=user.getUsername()%>'; 
</sql:query>
<sql:query var="idQ3"  dataSource="jdbc/sdb">
    SELECT * FROM user_type; 
</sql:query>

<c:set var="condition" value="false"/>
<c:forEach items="${idQ2.rows}" var="row2">
    <c:choose>
        <c:when test="${row2.menu_item==1 && row2.user_type==3}">
            <c:set var="condition" value="true"/>
        </c:when>
    </c:choose>
</c:forEach>

<c:choose>
    <c:when test="${condition==false}">
        <script type="text/javascript">
            window.location = 'forbiddenPage.jsp';
        </script>
    </c:when>
</c:choose>

<div id="page-wrapper">
    <%  String success = (String) request.getAttribute("SUCCESS_MESSAGE");
        String error = (String) request.getAttribute("ERROR_MESSAGE");
    %>
    <div class="container-fluid">

        <div class="row">
            <br/>
            <div class="col-lg-8 col-md-8 col-lg-offset-2 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add Superuser</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal" action="UserController?actionType=addUser" method="POST" id="register-form">
                            <div class="form-group">
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
                                    <label for="inputEmail" class="control-label col-xs-5 lbl_name">Email : </label>
                                    <div class="col-xs-7">
                                        <input  type="email" class="form-control" name="emailAdd" id="emailAdd" placeholder="Enter Email Address" onblur="checkDomainValid();" required >
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputUsername" class="control-label col-xs-5 lbl_name">Username : </label>
                                    <div class="col-xs-7">
                                        <input type="text" name="username" class="form-control" id="inputUsername" placeholder="Enter Username" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPass" class="control-label col-xs-5 lbl_name">Password : </label>
                                    <div class="col-xs-7">
                                        <input type="password" name="password" class="form-control" id="password" placeholder="Enter Password" required autocomplete="off">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputAddress" class="control-label col-xs-5 lbl_name">Confirm Password : </label>
                                    <div class="col-xs-7">
                                        <input type="password" name="cpassword" class="form-control" id="cpassword" placeholder="Re-enter Password" onblur="checkPassword();" required autocomplete="off">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputFirst" class="control-label col-xs-5 lbl_name">First Name :</label>
                                    <div class="col-xs-7">
                                        <input type="text" name="inputFirst" class="form-control" id="inputFirst" placeholder="Enter First Name" required autocomplete="off">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputLast" class="control-label col-xs-5 lbl_name">Last Name :</label>
                                    <div class="col-xs-7">
                                        <input type="text" name="inputLast" class="form-control" id="inputLast" placeholder="Enter Last Name" required autocomplete="off">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputLast" class="control-label col-xs-5 lbl_name">User Type :</label>
                                    <div class="col-xs-7">
                                        <select class="form-control" name="usertype" id="usertype" F">
                                                <c:forEach var="row2" items="${idQ3.rows}">                                                                                
                                                    <option value="${row2.user_type}">${row2.type_name}</option>
                                                </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputTelephone" class="control-label col-xs-5 lbl_name">Contact Number : </label>
                                    <div class="col-xs-7">
                                        <input type="number" name="inputTelephone" class="form-control" id="inputTelephone" placeholder="Enter Telephone Number" required autocomplete="off">
                                    </div>
                                </div>
                                <br/>
                                <div class="form-group" style="padding-right: 50px;">
                                    <div class="col-xs-offset-4 col-xs-4">
                                        <input type="hidden" name="addedUser" id="addedUser" value="<%=user.getUsername()%>" />
                                        <input type="submit" class="btn btn-primary" style="width: 250px;" value="Submit" />
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!-- /.container-fluid -->

</div>
<!-- /#page-wrapper -->

<script type="text/javascript">
    $(document).ready(function () {
        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem2").addClass("active");
    });
</script>

<script type="text/javascript">
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
                    nom_Success("Entered Email Address is correct");
//                    document.getElementById("otherData").className = '';
                } else if (reply === "alreadyExistUser") {
                    sm_warning("Email address already exist with E Platform");
                    document.getElementById('emailAdd').value = "";
                } else {
                    sm_alert("Entered Email Address is not correct");
                    document.getElementById('emailAdd').value = "";
                }

            }
        };
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
    function checkEmpty() {
        var mail = $("#emailAdd").val();
        var user = $("#inputUsername").val();
        var pass = $("#inputPass").val();
        var repass = $("#inputRePass").val();
        var fname = $("#inputFirst").val();
        var lname = $("#inputLast").val();
        var contact = $("#inputTelephone").val();

        if ((mail === null || mail === "") && (user === null || user === "") && (pass === null || pass === "") && (repass === null || repass === "") && (fname === null || fname === "") && (lname === null || lname === "") && (contact === null || contact === "")) {
            return false;
        } else {
            return true;
        }

    }
</script>

<%@include file="include/footer.jsp"%>
<% } else {

        response.sendRedirect("LogoutController");
    }%>