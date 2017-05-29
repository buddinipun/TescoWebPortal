<%-- 
    Document   : orderTracking
    Created on : Jul 21, 2015, 11:35:25 AM
    Author     : Sandun
--%>


<%@page import="com.impression.hibe.model.SysUser"%>
<%@include file="include/header.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    SysUser user3 = (SysUser) session.getAttribute("user");
    if (user3 != null) {
%>

<sql:query var="idQ2"  dataSource="jdbc/sdb">
    SELECT * FROM sys_user_menu_item WHERE username='<%=user3.getUsername()%>'; 
</sql:query>

<c:set var="condition" value="false"/>
<c:forEach items="${idQ2.rows}" var="row2">
    <c:choose>
        <c:when test="${row2.menu_item==8}">
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

<%
    SysUser user = (SysUser) session.getAttribute("user");
    String company = user.getCompanyId().getCompanyName().trim();
%>

<%@include file="include/sideMenu.jsp"%>
<div id="page-wrapper">
    <sql:query var="sa"  dataSource="jdbc/sdb">
        SELECT * FROM sys_user WHERE user_type=6; 
    </sql:query>
    <sql:query var="cs"  dataSource="jdbc/sdb">
        SELECT * FROM sys_user WHERE user_type=5; 
    </sql:query>
    <sql:query var="art"  dataSource="jdbc/sdb">
        SELECT * FROM sys_user WHERE user_type=4; 
    </sql:query>
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row">

            <div class="col-lg-2">
                <input type="text" name="garmentId" class="form-control" id="garmentId" placeholder="ID" required/>
            </div>
            <div class="col-lg-2">
                <input type="text" name="garmentCode" class="form-control" id="garmentCode" placeholder="Enter Garment Code" required/>
            </div>
            <div class="col-lg-4">
                <input type="text" name="garmentName" class="form-control" id="garmentName" placeholder="Enter Garment Name" required/>
            </div>
            <div class="col-lg-4">
                <input type="text" name="domain" class="form-control" id="domain" placeholder="Enter Company Domain" required/>
            </div>
        </div>
        <br/>
        <div class="row">
            <div class="col-lg-4">
                <select  name="cs" id="cs" class="form-control">

                    <option disabled selected value="0" > - Select a CS- </option>

                    <c:forEach var="row9" items="${cs.rows}"> 
                        <option value="${row9.username}">${row9.username}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-lg-4">
                <select  name="sm" id="sm" class="form-control">

                    <option disabled selected value="0" > - Select a Sales Manager- </option>

                    <c:forEach var="row9" items="${sa.rows}"> 
                        <option value="${row9.username}">${row9.username}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-lg-4">
                <select  name="ad" id="ad" class="form-control">

                    <option disabled selected value="0" > - Select a Artwork Designer- </option>

                    <c:forEach var="row9" items="${art.rows}"> 
                        <option value="${row9.username}">${row9.username}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <br/>
        <div class="row">
            <div class="col-lg-1">
            </div>
            <div class="col-lg-4">
                <input type="button" onclick="saveGarment();" name="Add" class="form-control btn btn-success" id="Add" value="Add Garment"/>
            </div>
            <div class="col-lg-4">
                <input type="button" onclick="updateGarment();" name="Update" class="form-control btn btn-warning" id="Update" value="Update Garment"/>
            </div>
            <div class="col-lg-2">
                <input type="button" onclick="clearForms();" name="clear" class="form-control btn btn-info" id="clear" value="Clear"/>
            </div>
            <div class="col-lg-1">
            </div>
        </div>
        <br/>
        <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
            SELECT * FROM `company` ;
        </sql:query>
        <div class="row">
            <table class="table table-bordered table-hover table-striped" id="viewDetials_tbl" >
                <thead>
                    <tr>
                        <th bgcolor="#EFEFEF" >ID</th>
                        <th bgcolor="#EFEFEF" >Garment Name</th>
                        <th bgcolor="#EFEFEF" >Garment Code</th>
                        <th bgcolor="#EFEFEF" >Domain</th>
                        <th bgcolor="#EFEFEF" >CS</th>
                        <th bgcolor="#EFEFEF" >Sales</th>
                        <th bgcolor="#EFEFEF" >Artwork D</th>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                        <tr>
                            <td>${row2.company_id} </td>
                            <td>${row2.company_name} </td>
                            <td>${row2.company_code} </td>
                            <td>${row2.company_domain} </td>
                            <td>${row2.cs} </td>
                            <td>${row2.sales} </td>
                            <td>${row2.artwork} </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
    <!-- /.container-fluid -->

</div>
<!-- /#page-wrapper -->




<script type="text/javascript">

    $(document).on('click', '#viewDetials_tbl  tbody tr', function () {
        $("#Add").hide();
        $("#Update").show();
        var da = [];
        var a = ($(this).find('td:nth-child(1)').text().trim());
        var b = ($(this).find('td:nth-child(2)').text().trim());
        var c = ($(this).find('td:nth-child(3)').text().trim());
        var d = ($(this).find('td:nth-child(4)').text().trim());
        viewGarment(a, b, c, d);
    });
    function saveGarment() {
        var id = document.getElementById('garmentId').value;
        var name = document.getElementById('garmentName').value;
        var code = document.getElementById('garmentCode').value;
        var domain = document.getElementById('domain').value;
        var artwork = document.getElementById('ad').value;
        var cs = document.getElementById('cs').value;
        var sales = document.getElementById('sm').value;


        var dataArr = [id, name, code, domain, artwork, cs, sales];

//garment ID eka validation

        if (document.getElementById('garmentId').value.length === 0) {
            BootstrapDialog.show({
                title: 'Notification',
                type: BootstrapDialog.TYPE_SUCCESS,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Give a ID'
            });
        } else {
            if (document.getElementById('garmentCode').value.length === 0) {
                BootstrapDialog.show({
                    title: 'Notification',
                    type: BootstrapDialog.TYPE_SUCCESS,
                    size: BootstrapDialog.SIZE_SMALL,
                    message: 'Please Give a Garment Code'
                });

            } else {
                if (document.getElementById('garmentName').value.length === 0) {
                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_SUCCESS,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Please Give a Garment Name'
                    });

                } else {
                    if (document.getElementById('domain').value.length === 0) {
                        BootstrapDialog.show({
                            title: 'Notification',
                            type: BootstrapDialog.TYPE_SUCCESS,
                            size: BootstrapDialog.SIZE_SMALL,
                            message: 'Please Give a Company Domain'
                        });

                    } else {
                        if (document.getElementById('cs').value.length === 0) {
                            BootstrapDialog.show({
                                title: 'Notification',
                                type: BootstrapDialog.TYPE_SUCCESS,
                                size: BootstrapDialog.SIZE_SMALL,
                                message: 'Please Give a Company Domain'
                            });
                        }
                        var xmlHttp = getAjaxObject();
                        xmlHttp.onreadystatechange = function ()
                        {
                            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                            {
                                var reply = eval('(' + xmlHttp.responseText + ')');
                                document.getElementById('garmentId').value = '';
                                document.getElementById('garmentName').value = '';
                                document.getElementById('garmentCode').value = '';
                                document.getElementById('domain').value = '';
                                document.getElementById('garmentId').readOnly = false;
                                location.reload();
                            }
                        };

                        xmlHttp.open("POST", "GarmentController?method=SaveGarment&dataArr=" + dataArr, true);
                        xmlHttp.send();
                    }
                }
            }

        }

    }
    function updateGarment() {
        var id = document.getElementById('garmentId').value;
        var name = document.getElementById('garmentName').value;
        var code = document.getElementById('garmentCode').value;
        var domain = document.getElementById('domain').value;
        var artwork = document.getElementById('ad').value;
        var cs = document.getElementById('cs').value;
        var sales = document.getElementById('sm').value;

        var dataArr = [id, code, name, domain, artwork, cs, sales];

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');


                document.getElementById('garmentId').value = '';
                document.getElementById('garmentName').value = '';
                document.getElementById('garmentCode').value = '';
                document.getElementById('domain').value = '';
                document.getElementById('garmentId').readOnly = false;


                location.reload();





            }
        };

        xmlHttp.open("POST", "GarmentController?method=UpdateGarment&dataArr=" + dataArr, true);
        xmlHttp.send();

    }
    function clearForms() {

        document.getElementById('garmentId').value = '';
        document.getElementById('garmentName').value = '';
        document.getElementById('garmentCode').value = '';
        document.getElementById('domain').value = '';
        document.getElementById('garmentId').readOnly = false;
    }
    function viewGarment(id, name, code, domain) {


        document.getElementById('garmentId').value = id;
        document.getElementById('garmentName').value = name;
        document.getElementById('garmentCode').value = code;
        document.getElementById('domain').value = domain;
        document.getElementById('garmentId').setAttribute("readonly", "true");

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
        $("#Update").hide();
        $("#Add").show();
    });
</script>
<script type="text/javascript">




</script>
<%@include file="include/footer.jsp"%>
<% } else {

        response.sendRedirect("LogoutController");
    }%>