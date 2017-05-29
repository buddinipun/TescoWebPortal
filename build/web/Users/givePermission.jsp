
<%-- 
    Document   : pdfExtracter
    Created on : Jul 5, 2015, 8:08:57 PM
    Author     : oshan
--%>


<%@include file="../include/headerInner.jsp"%>

<%@include file="../include/sideMenuInner.jsp"%>

<%    SysUser user = (SysUser) session.getAttribute("user");
    if (user != null) {
        int company = user.getCompanyId().getCompanyId();
%>

<sql:query var="idQ2"  dataSource="jdbc/sdb">
    SELECT * FROM sys_user_menu_item WHERE username='<%=user.getUsername()%>'; 
</sql:query>

<c:set var="condition" value="false"/>
<c:forEach items="${idQ2.rows}" var="row2">
    <c:choose>
        <c:when test="${row2.menu_item==6}">
            <c:set var="condition" value="true"/>
        </c:when>
    </c:choose>
</c:forEach>

<c:choose>
    <c:when test="${condition==false}">
        <script type="text/javascript">
            window.location = '../forbiddenPage.jsp';
        </script>
    </c:when>
</c:choose>

<script>
    $(document).on('click', '#viewDetials_tbl tbody tr', function () {
        viewUserDetails($(this).find('td:first').text().trim());
    });
</script>

<script>
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

        var username = document.getElementById("username").value;

        var username = document.getElementById('usernew').value;
        var checkboxes = document.getElementsByName('permission');


        var checkboxesChecked = [];
        checkboxesChecked.push(username);
        for (var i = 0; i < checkboxes.length; i++) {
            // And stick the checked ones onto an array...
            if (checkboxes[i].checked) {
                checkboxesChecked.push(checkboxes[i].value);
            }
        }

        var isActive;
        if (document.getElementById("rbutton").checked) {
            isActive = true;
        } else {
            isActive = false;
        }

        var dataset = isActive + "@" + username + "@" + checkboxesChecked;



        var xmlHttp1 = getAjaxObject();

        xmlHttp1.onreadystatechange = function () {

            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
            {
                var userObject = eval('(' + xmlHttp1.responseText + ')');
                location.reload();
            }
        };

        xmlHttp1.open("POST", "../UserController?actionType=SaveStatusUpdateUser&dataset=" + dataset, true);
        xmlHttp1.send();

    }




    function checkOnOff() {

        if (document.getElementById("rbutton").checked) {
            document.getElementById("noPermissionDiv").className = '';

        } else {
            document.getElementById("noPermissionDiv").className = 'hidden';
        }

    }


    function viewUserDetails(username) {
        $("#noPermissionDiv").empty();
        var xmlHttp1 = getAjaxObject();
        xmlHttp1.onreadystatechange = function ()

        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200) {


                var reply = eval('(' + xmlHttp1.responseText + ')');

                var replysize = reply.jArray2.length;

                var replysize1 = reply.jArray3.length;

                var email = reply.email;
                var name = reply.name;
                var c_num = reply.c_num;
                var isActive = reply.isActive;
                var username1 = reply.username;

                document.getElementById("email").value = email;
                document.getElementById("con_num").value = c_num;
                document.getElementById("cu_name").value = name;
                document.getElementById("username").value = username1;

                if (isActive === false) {
                    document.getElementById("rbutton1").checked = true;
                    document.getElementById("noPermissionDiv").className = 'hidden';
                } else {
                    document.getElementById("rbutton").checked = true;
                    document.getElementById("noPermissionDiv").className = '';
                }

//                var noPermission = document.getElementById('noPermission').getElementsByTagName('tbody')[0];
                var noPermission = document.getElementById('noPermissionDiv');

                for (var f = 0; replysize > f; f++) {

                    var id = reply.jArray2[f].menu_item_id;
                    var name = reply.jArray2[f].menu_item_name;

                    var row = document.createElement("div");
                    row.className = "form-group";

                    var td1 = document.createElement("label");
                    td1.className = "control-label";
                    td1.innerHTML = name;
                    td1.for = id;

                    var td2 = document.createElement("input");
                    td2.type = "checkbox";
                    td2.name = "permission";
                    td2.className = "pull-right";
                    td2.value = id;
                    td2.checked = false;

                    row.appendChild(td1);
                    row.appendChild(td2);
                    noPermission.appendChild(row);
                }

                for (var g = 0; replysize1 > g; g++) {

                    var id = reply.jArray3[g].menu_item_id;
                    var name = reply.jArray3[g].menu_item_name;

                    var row = document.createElement("div");
                    row.className = "form-group";

                    var td1 = document.createElement("label");
                    td1.className = "control-label";
                    td1.innerHTML = name;
                    td1.for = id;

                    var td2 = document.createElement("input");
                    td2.type = "checkbox";
                    td2.name = "permission";
                    td2.className = "pull-right";
                    td2.value = id;
                    td2.checked = true;

                    row.appendChild(td1);
                    row.appendChild(td2);
                    noPermission.appendChild(row);
                }

                if (replysize1 !== 0 || replysize !== 0) {

                    if (replysize1 !== 0 || replysize !== 0) {

                        var row2 = document.createElement("div");
                        row2.className = "form-froup";
                        var hidden = document.createElement("input");
                        hidden.type = "hidden";
                        hidden.value = username;
                        hidden.name = "username";
                        hidden.id = "usernew";

                        row2.appendChild(hidden);
                        noPermission.appendChild(row2);
                    }
                    document.getElementById("username").innerHTML = reply.jArray3[0].username;
                }
            }
        };
        xmlHttp1.open("POST", "../UserController?actionType=BringPriviledges&username=" + username, true);
        xmlHttp1.send();


    }
</script>

<sql:query var="idQ2"  dataSource="jdbc/sdb">
    SELECT * FROM sys_user_menu_item WHERE username='<%=user.getUsername()%>' and status=1; 
</sql:query>

<c:set var="condition" value="false"/>
<c:forEach items="${idQ2.rows}" var="row2">
    <c:choose>
        <c:when test="${row2.menu_item==6}">
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

                <% if (user5.getUserType().getUserType() == 1) {%>

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
                                        <td>${row.email_address}</td>
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
                                        <td>${row1.email_address}</td>
                                    </tr>         
                                </c:forEach>                        
                            </table>
                        </div>
                    </div>
                </div>

                <%} else if (user5.getUserType().getUserType() == 3) {%>

                <div class="col-lg-6">
                    <sql:query var="active0"  dataSource="jdbc/sdb">
                        SELECT * FROM sys_user s WHERE s.is_active=0 ORDER BY company_id,user_type;
                    </sql:query> 
                    <div class="panel panel-red">
                        <div class="panel-heading">
                            <h3 class="panel-title">Deactivated Users</h3>
                        </div>
                        <div class="panel-body" style="overflow: scroll; height: 100px;">
                            <table border="0" class="table table-hover table-responsive" id="viewDetials_tbl">
                                <c:forEach var="row" items="${active0.rows}">  
                                    <tr>
                                        <td>${row.username}</td>
                                        <td>${row.email_address}</td>
                                    </tr>

                                </c:forEach>
                            </table>
                        </div>
                    </div>
                    <sql:query var="avtive1"  dataSource="jdbc/sdb">
                        SELECT * FROM sys_user s WHERE s.is_active=1 and s.company_id=<%=company%> ORDER BY user_type;
                    </sql:query>  
                    <div class="panel panel-yellow">
                        <div class="panel-heading">
                            <h3 class="panel-title">Impressions Active Users</h3>
                        </div>
                        <div class="panel-body" style="overflow: scroll; height: 200px;">      
                            <table border="0" class="table table-hover table-responsive" id="viewDetials_tbl" >                  
                                <c:forEach var="row1" items="${avtive1.rows}">  
                                    <c:choose>
                                        <c:when test="${row1.user_type==1}">
                                            <tr class="bg-vccran">
                                                <td>${row1.username}</td>
                                                <td>${row1.email_address}</td>
                                            </tr>                                           
                                        </c:when>
                                        <c:when test="${row1.user_type==3}">
                                            <tr class="bg-danger">
                                                <td>${row1.username}</td>
                                                <td>${row1.email_address}</td>
                                            </tr>                                           
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td>${row1.username}</td>
                                                <td>${row1.email_address}</td>
                                            </tr>   
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>                        
                            </table>
                        </div>
                    </div>
                    <sql:query var="avtive1"  dataSource="jdbc/sdb">
                        SELECT * FROM sys_user s WHERE s.is_active=1 and company_id not in (1) ORDER BY company_id,user_type;
                    </sql:query>  
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <h3 class="panel-title">Other Active Users</h3>
                        </div>
                        <div class="panel-body" style="overflow: scroll; height: 300px;">      
                            <table border="0" class="table table-hover table-responsive" id="viewDetials_tbl" >                  


                                <c:forEach var="row1" items="${avtive1.rows}">  


                                    <c:choose>
                                        <c:when test="${row1.user_type==1}">
                                            <tr class="bg-vccran">
                                                <td>${row1.username}</td>
                                                <td>${row1.email_address}</td>
                                            </tr>                                           
                                        </c:when>
                                        <c:when test="${row1.user_type==3}">
                                            <tr class="bg-danger">
                                                <td>${row1.username}</td>
                                                <td>${row1.email_address}</td>
                                            </tr>                                           
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td>${row1.username}</td>
                                                <td>${row1.email_address}</td>
                                            </tr>   
                                        </c:otherwise>
                                    </c:choose>


                                </c:forEach>                        
                            </table>
                        </div>
                    </div>
                </div>
                <%}%>
                <div class="col-lg-6">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="panel-title" id="panel_title">User Details</div>
                            <div style="float: right; font-size: 80%; position: relative; top: -28px">
                                <button id="submit" name="submit" class="btn btn-default" onclick="checkForStyle();">Save</button>
                            </div>
                        </div>
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
                                    <input type="radio" name="status" value="on" id="rbutton" style="float: right;" onchange="checkOnOff();"/>
                                </div>
                                <div class="col-lg-6">
                                    <input type="radio" name="status" value="off" id="rbutton1" onchange="checkOnOff();" />
                                    <label for="rbutton">&nbsp; &nbsp; OFF</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div id="noPermissionDiv" style="padding-left: 50px; padding-right: 50px;">

                                </div>
                            </div>
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

<script type="text/javascript">
    $(document).ready(function () {
        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem7").addClass("active");
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

<%@include file="../include/footerInner.jsp"%>
<% } else {

        response.sendRedirect("../LogoutController");
    }%>
