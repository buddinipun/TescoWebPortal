<%-- 
    Document   : giveUserAccess
    Created on : Jul 5, 2015, 4:55:14 PM
    Author     : oshan
--%>

<%@include file="include/header.jsp"%>

<%@page import="com.impression.hibe.model.SysUser"%>
<%
    SysUser user = (SysUser) session.getAttribute("user");
    if(user!=null){
    int company = user.getCompanyId().getCompanyId();
%>

<%@page import="com.impression.hibe.model.Fiber"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="include/sideMenu.jsp"%>
<script>
    $(document).on('click', '#viewDetials_tbl tbody tr', function () {
        viewUserDetails($(this).find('td:first').text().trim());
    });
</script>
<script>
    function viewUserDetails(username) {

        var xmlHttp1 = getAjaxObject();
        xmlHttp1.onreadystatechange = function ()

        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200) {

                document.getElementById("rbutton1").checked = false;
                document.getElementById("rbutton").checked = false;
                document.getElementById("email").value = "";
                document.getElementById("con_num").value = "";
                document.getElementById("cu_name").value = "";

                var userObject = eval('(' + xmlHttp1.responseText + ')');
                var email = userObject.email;
                var name = userObject.name;
                var c_num = userObject.c_num;
                var isActive = userObject.isActive;
                var username1 = userObject.username;

                document.getElementById("email").value = "Email -- " + email;
                document.getElementById("con_num").value = c_num;
                document.getElementById("cu_name").value = name;
                document.getElementById("username").value = username1;

                if (isActive === false) {
                    document.getElementById("rbutton1").checked = true;
                } else {
                    document.getElementById("rbutton").checked = true;
                }
            }
        };
        xmlHttp1.open("POST", "UserController?actionType=GiveUserPermission&username=" + username, true);
        xmlHttp1.send();
    }

    function checkForStyle() {
        var em = document.getElementById("email").value;
        var cn = document.getElementById("con_num").value;
        var cus = document.getElementById("cu_name").value;
        var un = document.getElementById("username").value;

        if (em === null || em === "" && cn === null || cn === "" && cus === null || cus === "" && un === null || un === "") {
            sm_alert("Please Select a User to Update.");
        } else {
            updateUser();
        }




    }

    function updateUser() {
        BootstrapDialog.confirm({
            title: "Notification",
            message: "Do you want to update details?",
            type: BootstrapDialog.TYPE_PRIMARY,
            closable: true,
            draggable: true,
            btnCancelLabel: 'No',
            btnOKLabel: 'Yes',
            callback: function (result) {
                if (result) {
                    var username = document.getElementById("username").value;
                    var isActive;
                    if (document.getElementById("rbutton").checked) {
                        isActive = true;
                    } else {
                        isActive = false;
                    }


                    var dataset = isActive + "@" + username;

                    var xmlHttp1 = getAjaxObject();

                    xmlHttp1.onreadystatechange = function () {

                        if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
                        {
                            var userObject = eval('(' + xmlHttp1.responseText + ')');
                            location.reload();
                        }
                    };
                    xmlHttp1.open("POST", "UserController?actionType=SaveStatusUpdateUser&dataset=" + dataset, true);
                    xmlHttp1.send();
                } else {
                    return;
                }
            }
        });



    }


</script>
<sql:query var="idQ2"  dataSource="jdbc/sdb">
    SELECT * FROM sys_user_menu_item WHERE username='<%=user.getUsername()%>'; 
</sql:query>

<c:set var="condition" value="false"/>
<c:forEach items="${idQ2.rows}" var="row2">
    <c:choose>
        <c:when test="${row2.menu_item==5}">
            <c:set var="condition" value="true"/>
        </c:when>
    </c:choose>
</c:forEach>

<c:choose>
    <c:when test="${condition==false}">
        <script type="text/javascript">
            window.location = './forbiddenPage.jsp';
        </script>
    </c:when>
</c:choose>

<div id="page-wrapper">
    <%  String success = (String) request.getAttribute("SUCCESS_MESSAGE");
        String error = (String) request.getAttribute("ERROR_MESSAGE");
    %>
    <div class="container-fluid">

        <div class="row">
            <div class="row col-lg-12"> 
                <br/>
                <div class="col-lg-6">
                    <sql:query var="active0"  dataSource="jdbc/sdb">
                        SELECT * FROM sys_user s WHERE s.company_id=<%=company%> and s.is_active=0;
                    </sql:query> 
                    <div class="panel panel-yellow">
                        <div class="panel-heading">
                            <h3 class="panel-title">Deactivated Users</h3>
                        </div>
                        <div class="panel-body">
                            <table border="0" class="table table-hover table-responsive" id="viewDetials_tbl">
                                <c:forEach var="row" items="${active0.rows}">  
                                    <tr>
                                        <td>${row.username}</td>
                                    </tr>         
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                    <sql:query var="avtive1"  dataSource="jdbc/sdb">
                        SELECT * FROM sys_user s WHERE s.company_id=<%=company%> and s.is_active=1;
                    </sql:query>    
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <h3 class="panel-title">Active Users</h3>
                        </div>
                        <div class="panel-body">      
                            <table border="0" class="table table-hover table-responsive" id="viewDetials_tbl" >                  
                                <c:forEach var="row1" items="${avtive1.rows}">  
                                    <tr>
                                        <td>${row1.username}</td>
                                    </tr>         
                                </c:forEach>                        
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title" id="panel_title">User Details</h3>
                        </div>
                        <div class="panel-body" style="padding: 25px;">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <input type="text" id="cu_name" name="cu_name" class="form-control" placeholder=" Customer Name" readonly>
                                </div>
                                <div class="form-group">
                                    <input type="text" id="con_num" name="con_num" class="form-control" placeholder=" Contact Number" readonly>
                                </div>
                                <div class="form-group">
                                    <input type="text" id="username" name="username" class="form-control" placeholder=" Username" readonly>
                                </div>
                                <div class="form-group">
                                    <input type="text" id="email" name="email" class="form-control" placeholder="Email Address" readonly>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-6">
                                        <label for="rbutton" style="float: right;">&nbsp; &nbsp; ON</label>
                                        <input type="radio" name="status" value="on" id="rbutton" style="float: right;"/>
                                    </div>
                                    <div class="col-lg-6">
                                        <input type="radio" name="status" value="off" id="rbutton1" />
                                        <label for="rbutton">&nbsp; &nbsp; OFF</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="submit" class="btn btn-primary pull-right" name="submit" onclick="checkForStyle();" value="Save" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </div>
    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script>
    function clear() {

    }
</script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem6").addClass("active");
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


<%@include file="include/footer.jsp"%>

<% }else{
       
       response.sendRedirect("LogoutController");
   }%>