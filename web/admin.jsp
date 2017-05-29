<%-- 
    Document   : admin
    Created on : Jul 5, 2015, 7:01:25 AM
    Author     : oshan
--%>

<%@include file="include/header.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    SysUser user6 = (SysUser) session.getAttribute("user");
    if (user6 != null) {
%>
<%@include file="include/sideMenu.jsp"%>

<div id="page-wrapper">

    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">
                    Dashboard <small>Statistics Overview</small>
                </h1>
                <ol class="breadcrumb">
                    <li class="active">
                        <i class="fa fa-dashboard"></i> Dashboard
                    </li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        <%  SysUser user = (SysUser) session.getAttribute("user");%>
        <input type="hidden" name="userHidden" id="userHidden" value="<%=user.getUsername()%>" />
        <%  if (user.getUserType().getUserType() == 2) {%>
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-list fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">        
                                    SELECT COUNT(DISTINCT id) as co FROM `lof_generaldata` INNER JOIN `customer` ON (`lof_generaldata`.`customer` = `customer`.`customer_id`) WHERE customer.`username`='<%=user.getUsername()%>' AND lof_generaldata.orderstatus = 'Delevered';
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Delevered Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="getAllDetails();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-check fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
                                    SELECT COUNT(DISTINCT id) as co FROM `lof_generaldata` INNER JOIN `customer` ON (`lof_generaldata`.`customer` = `customer`.`customer_id`) WHERE customer.`username`='<%=user.getUsername()%>' AND lof_generaldata.orderstatus = 'Complete';
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Completed Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="completedOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-yellow">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-spinner fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
                                    SELECT COUNT(DISTINCT id) as co FROM `lof_generaldata` INNER JOIN `customer` ON (`lof_generaldata`.`customer` = `customer`.`customer_id`) WHERE customer.`username`='<%=user.getUsername()%>' AND lof_generaldata.orderstatus IN ('STARTED');
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Processing Orders</div>
                            </div>
                        </div>
                    </div>
                    <a onclick="processingOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-red">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-shopping-cart fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
                                    SELECT COUNT(DISTINCT id) as co FROM `lof_generaldata` INNER JOIN `customer` ON (`lof_generaldata`.`customer` = `customer`.`customer_id`) WHERE customer.`username`='<%=user.getUsername()%>' AND lof_generaldata.orderstatus in ('HOLD','');
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Pending Orders</div>
                            </div>
                        </div>
                    </div>
                    <a  href="#" onclick="getPendingOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <%
        } else if (user.getUserType().getUserType() == 1) {
            String company_code = user.getCompanyId().getCompanyCode();
        %>
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-list fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                
                                    SELECT COUNT(DISTINCT id) AS co FROM lof_generaldata lg INNER JOIN customer c ON (lg.customer = c.customer_id) WHERE lg.supplier_no='<%=company_code%>' AND lg.orderstatus = 'Delevered';
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Delevered Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="getAllDetails();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-check fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">       
                                    SELECT COUNT(DISTINCT id) AS co FROM lof_generaldata lg INNER JOIN customer c ON (lg.customer = c.customer_id) WHERE lg.orderstatus = 'Complete' AND lg.supplier_no='<%=company_code%>';
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Completed Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="completedOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-yellow">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-spinner fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
                                    SELECT COUNT(DISTINCT id) as co FROM lof_generaldata lg INNER JOIN customer c ON (lg.customer = c.customer_id) WHERE lg.supplier_no='<%=company_code%>' AND lg.orderstatus IN ('STARTED');
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Processing Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="processingOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-red">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-shopping-cart fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
                                    SELECT COUNT(DISTINCT id) as co FROM lof_generaldata lg INNER JOIN customer c ON (lg.customer = c.customer_id) WHERE lg.supplier_no='<%=company_code%>' AND lg.orderstatus in ('HOLD','');
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Pending Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="getPendingOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <%  } else if (user.getUserType().getUserType() == 3) {  %> 
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-list fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
                                    SELECT COUNT(DISTINCT `id`) AS co FROM lof_generaldata WHERE orderstatus = 'Delevered';
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Delevered Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="getAllDetails();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-check fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
                                    SELECT COUNT(DISTINCT id) as co FROM lof_generaldata WHERE orderstatus = 'Complete';
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Completed Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="completedOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-yellow">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-spinner fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
                                    SELECT COUNT(DISTINCT `id`) as co FROM lof_generaldata lg WHERE lg.orderstatus IN ("STARTED");
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Processing Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="processingOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-red">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-shopping-cart fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">                               
                                    SELECT COUNT(DISTINCT `id`) as co FROM lof_generaldata lg WHERE lg.orderstatus in ('HOLD','');
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Pending Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="getPendingOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <%  } else if (user.getUserType().getUserType() == 5) {
            String company_code = user.getCompanyId().getCompanyCode();%> 
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-list fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">         
                                    SELECT COUNT(DISTINCT id) AS co FROM lof_generaldata lg WHERE lg.supplier_no IN ( SELECT `company_code` FROM `company` WHERE `cs` = '<%=user.getUsername()%>') AND lg.orderstatus = 'Delevered';
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Delevered Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="getAllDetails();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-check fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">   
                                    SELECT COUNT(DISTINCT id) AS co FROM lof_generaldata lg WHERE lg.supplier_no IN ( SELECT `company_code` FROM `company` WHERE `cs` = '<%=user.getUsername()%>') AND lg.orderstatus = 'Complete';
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Completed Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="completedOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-yellow">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-spinner fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb">    
                                    SELECT COUNT(DISTINCT id) AS co FROM lof_generaldata lg WHERE lg.supplier_no IN ( SELECT `company_code` FROM `company` WHERE `cs` = '<%=user.getUsername()%>') AND lg.orderstatus IN ("STARTED");
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Processing Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="processingOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="panel panel-red">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-shopping-cart fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <sql:query var="idQ2"  dataSource="jdbc/sdb"> 
                                    SELECT COUNT(DISTINCT id) AS co FROM lof_generaldata lg WHERE lg.supplier_no IN ( SELECT `company_code` FROM `company` WHERE `cs` = '<%=user.getUsername()%>') AND lg.orderstatus in ('HOLD','CANCEL','');
                                </sql:query>
                                <div class="huge">
                                    <c:forEach var="row2" items="${idQ2.rows}">                                                                                
                                        ${row2.co} 
                                    </c:forEach>
                                </div>
                                <div>Pending Orders</div>
                            </div>
                        </div>
                    </div>
                    <a href="#" onclick="getPendingOrders();">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <%  } else {

            }%>
        <!-- /.row -->
        <div id="tbl_orderDetails" class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span id="title" ></span></h3>
                    </div>
                    <div class="panel-body">
                        <div class="col-lg-5">
                            <div id="details_table" class="table-responsive">
                                <table class="table table-bordered table-hover table-striped" id="viewDetials_tbl" >
                                    <thead>
                                        <tr>
                                            <th bgcolor="#EFEFEF" >#</th>
                                            <th bgcolor="#EFEFEF" >Web Order No</th>
                                            <th bgcolor="#EFEFEF" >Purchase Order</th>
                                            <th bgcolor="#EFEFEF" >Style No</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <div id="lofdetails_div" class="table-responsive">
                                <table class="table table-bordered table-hover table-striped" id="lofDetials_tbl" >
                                    <thead>
                                        <tr>
                                            <th bgcolor="#EFEFEF" >#</th>
                                            <th bgcolor="#EFEFEF" >LOF ID</th>
                                            <th bgcolor="#EFEFEF" >Status</th>
                                            <th bgcolor="#EFEFEF" >Ordered Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--================================================================================================ /.row -->

        <!--================================================================================================ /.row -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog" style="width: 80%;">

                <!-- Modal content-->
                <div class="modal-content" style="width: 95%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Preview</h4>
                    </div>
                    <div class="modal-body">
                        <div id="details" style="width: 100%;">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">General Details</h3>
                                        </div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-hover table-striped" id="genww" >
                                                    <thead>
                                                        <tr>
                                                            <th bgcolor="#EFEFEF" >Key Field</th>
                                                            <th bgcolor="#EFEFEF">Value</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="gendata">

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">Concertina Labels</h3>
                                        </div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-hover table-striped" id="tecww" >
                                                    <thead>
                                                        <tr>
                                                            <th bgcolor="#EFEFEF">Label</th>
                                                            <th bgcolor="#EFEFEF">Reference</th>
                                                            <th bgcolor="#EFEFEF">Care Text</th>
                                                            <th bgcolor="#EFEFEF">Wash Symbol</th>
                                                            <th bgcolor="#EFEFEF">Fiber Composition 1</th>
                                                            <th bgcolor="#EFEFEF">Fiber Composition 2</th>
                                                            <th bgcolor="#EFEFEF">Fiber Composition 3</th>
                                                            <th bgcolor="#EFEFEF">Fiber Composition 4</th>
                                                            <th bgcolor="#EFEFEF">Group</th>
                                                            <th bgcolor="#EFEFEF">Description</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tecdata">

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>                             
                            <!--                            <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="panel panel-default">
                                                                    <div class="panel-heading">
                                                                        <h3 class="panel-title">Swing Tickets</h3>
                                                                    </div>
                                                                    <div class="panel-body">
                                                                        <div class="table-responsive">
                                                                            <table class="table table-bordered table-hover table-striped" id="swiww" >
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th bgcolor="#EFEFEF">Reference</th>
                                                                                        <th bgcolor="#EFEFEF">Trend Name</th>
                                                                                        <th bgcolor="#EFEFEF">Product Benefit</th>
                                                                                        <th bgcolor="#EFEFEF">Product Description</th>
                                                                                        <th bgcolor="#EFEFEF">Supplier ID</th>
                                                                                        <th bgcolor="#EFEFEF">Job No</th>
                                                                                        <th bgcolor="#EFEFEF">Care Info</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody id="swidata">
                            
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>-->
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">EAN Details</h3>
                                        </div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-hover table-striped" id="eanww" >
                                                    <thead>
                                                        <tr>
                                                            <th bgcolor="#EFEFEF">EAN No</th>
                                                            <th bgcolor="#EFEFEF">UK</th>
                                                            <th bgcolor="#EFEFEF">EUR</th>
                                                            <th bgcolor="#EFEFEF">US</th>
                                                            <th bgcolor="#EFEFEF">MX</th>
                                                            <th bgcolor="#EFEFEF">Sec Size 1</th>
                                                            <th bgcolor="#EFEFEF">Sec Size 2</th>
                                                            <th bgcolor="#EFEFEF">Sec Size 3</th>
                                                            <th bgcolor="#EFEFEF">Sec Size 4</th>
                                                            <th bgcolor="#EFEFEF">EURO</th>
                                                            <th bgcolor="#EFEFEF">POUNDS</th>
                                                            <th bgcolor="#EFEFEF">CZ</th>
                                                            <th bgcolor="#EFEFEF">SK</th>
                                                            <th bgcolor="#EFEFEF">OL</th>
                                                            <th bgcolor="#EFEFEF">HU</th>
                                                            <th bgcolor="#EFEFEF">TK</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="eandata">

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script type="text/javascript">

    //This is new javascript 2015-08-03

    $(document).on('click', '#viewDetials_tbl  tbody tr', function () {
//        alert($(this).find('td:nth-child(2)').text().trim());
        getOrderDetails($(this).find('td:nth-child(2)').text().trim());
    });

    $(document).on('click', '#lofDetials_tbl  tbody tr', function () {
        getCourseFee($(this).find('td:nth-child(2)').text().trim());
//        $('#myModal').modal('show');
    });

    function getOrderDetails(id) {
        $("#lofdetails_div").hide();
        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var y = reply.length;

                var tbl = document.getElementById('lofDetials_tbl').getElementsByTagName('tbody')[0];
                $("#lofDetials_tbl tbody").empty();
                if (y > 0) {
                    $("#lofdetails_div").show();
                    for (var j = 0; j < y; j++) {

                        var row = document.createElement("tr");

                        var cnt = document.createElement("td");
                        cnt.innerHTML = j + 1;

                        var lofid = document.createElement("td");
                        lofid.innerHTML = reply[j].lof_data;

                        var co = document.createElement("td");

                        var status = reply[j].conf_order;
                        if (status !== null) {
                            if (status === "NAR") {
                                status = "Not Requested";
                            } else if (status === "AR") {
                                status = "Artwork is Pending";
                            } else if (status === "CONA") {
                                status = "Order is confirmed";
                            } else if (status === "DEL") {
                                status = "Order is delivered";
                            } else if (status === "ASNC") {
                                status = "";
                            } else if (status === "UPD") {
                                status = "Order not Submited";
                            } else {
                                status = "Artwork is Received";
                            }
                        }
                        co.innerHTML = status;

                        var lof_data = document.createElement("td");
                        lof_data.innerHTML = reply[j].ordered_date;

                        document.getElementById("title").innerHTML = "LOF Details";

                        row.appendChild(cnt);
                        row.appendChild(lofid);
                        row.appendChild(co);
                        row.appendChild(lof_data);

                        tbl.appendChild(row);
                    }
                }
                $('html, body').animate({
                    scrollTop: $("#lofDetials_tbl").offset().top - 125},
                'slow', function () {
                    $("#lofDetials_tbl").focus();
                });
            }
        };
        xmlHttp.open("POST", "Controller?method=getLOFdetails&orderid=" + id, true);
        xmlHttp.send();
    }

    function getCourseFee(id) {
        $("#genww tbody").empty();
        $("#tecww tbody").empty();
        $("#swiww tbody").empty();
        $("#eanww tbody").empty();
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var res = xmlHttp.responseText.split("#");
                console.log(res);
                var parsedDatagen = JSON.parse(res[0]);

                if (parsedDatagen.constructor === Array) {

                } else {

                    var tablegen = document.getElementById("gendata");

                    var rowgen1 = tablegen.insertRow(0);
                    var rowgen2 = tablegen.insertRow(1);
                    var rowgen3 = tablegen.insertRow(2);
                    var rowgen4 = tablegen.insertRow(3);
                    var rowgen5 = tablegen.insertRow(4);
                    var rowgen6 = tablegen.insertRow(5);
                    var rowgen7 = tablegen.insertRow(6);
                    var rowgen8 = tablegen.insertRow(7);
                    var rowgen9 = tablegen.insertRow(8);
                    var rowgen10 = tablegen.insertRow(9);
                    var rowgen11 = tablegen.insertRow(10);
                    var rowgen12 = tablegen.insertRow(11);
                    var rowgen13 = tablegen.insertRow(12);
                    var rowgen14 = tablegen.insertRow(13);
                    var rowgen15 = tablegen.insertRow(14);
                    var rowgen16 = tablegen.insertRow(15);

                    var gcell11 = rowgen1.insertCell(0);
                    var gcell12 = rowgen1.insertCell(1);
                    var gcell21 = rowgen2.insertCell(0);
                    var gcell22 = rowgen2.insertCell(1);
                    var gcell31 = rowgen3.insertCell(0);
                    var gcell32 = rowgen3.insertCell(1);
                    var gcell41 = rowgen4.insertCell(0);
                    var gcell42 = rowgen4.insertCell(1);
                    var gcell51 = rowgen5.insertCell(0);
                    var gcell52 = rowgen5.insertCell(1);
                    var gcell61 = rowgen6.insertCell(0);
                    var gcell62 = rowgen6.insertCell(1);
                    var gcell71 = rowgen7.insertCell(0);
                    var gcell72 = rowgen7.insertCell(1);
                    var gcell81 = rowgen8.insertCell(0);
                    var gcell82 = rowgen8.insertCell(1);
                    var gcell91 = rowgen9.insertCell(0);
                    var gcell92 = rowgen9.insertCell(1);
//                    var gcell101 = rowgen10.insertCell(0);
//                    var gcell102 = rowgen10.insertCell(1);
                    var gcell111 = rowgen11.insertCell(0);
                    var gcell112 = rowgen11.insertCell(1);
                    var gcell121 = rowgen12.insertCell(0);
                    var gcell122 = rowgen12.insertCell(1);
                    var gcell131 = rowgen13.insertCell(0);
                    var gcell132 = rowgen13.insertCell(1);
                    var gcell141 = rowgen14.insertCell(0);
                    var gcell142 = rowgen14.insertCell(1);
                    var gcell143 = rowgen15.insertCell(0);
                    var gcell144 = rowgen15.insertCell(1);
                    var gcell145 = rowgen16.insertCell(0);
                    var gcell146 = rowgen16.insertCell(1);

                    gcell11.innerHTML = "Purchase Order";
                    gcell21.innerHTML = "Category";
                    gcell31.innerHTML = "Countryof Origin";
                    gcell41.innerHTML = "Additional Comment";
                    gcell51.innerHTML = "Style No";
                    gcell61.innerHTML = "Charactor of Description";
                    gcell71.innerHTML = "Season Code";
                    gcell81.innerHTML = "Brand";
                    gcell91.innerHTML = "Style Type";
//                    gcell101.innerHTML = "Department";
                    gcell111.innerHTML = "Supplier No";
                    gcell121.innerHTML = "Factory Code";
                    gcell131.innerHTML = "Lof No";
                    gcell141.innerHTML = "Confirm Order";
                    gcell143.innerHTML = "Customer PO";
                    gcell145.innerHTML = "Tog Value";

                    gcell12.innerHTML = parsedDatagen.purchase_order;
                    gcell22.innerHTML = parsedDatagen.category;
                    gcell32.innerHTML = parsedDatagen.country_of_origin;
                    gcell42.innerHTML = parsedDatagen.additional_comment;
                    gcell52.innerHTML = parsedDatagen.style_no;
                    gcell62.innerHTML = parsedDatagen.charactor_tf_des;
                    gcell72.innerHTML = parsedDatagen.season_code;
                    gcell82.innerHTML = parsedDatagen.brand;
                    gcell92.innerHTML = parsedDatagen.style_type;
//                    gcell102.innerHTML = parsedDatagen.department;
                    gcell112.innerHTML = parsedDatagen.supplier_no;
                    gcell122.innerHTML = parsedDatagen.factory_code;
                    gcell132.innerHTML = parsedDatagen.lof_data;
                    gcell144.innerHTML = parsedDatagen.customer_po;
                    gcell146.innerHTML = parsedDatagen.tog_value;

                    var status = parsedDatagen.conf_order;
                    if (status !== null) {
                        if (status === "NAR") {
                            status = "Not Requested";
                        } else if (status === "AR") {
                            status = "Artwork is Pending";
                        } else if (status === "CONA") {
                            status = "Order is confirmed";
                        } else if (status === "DEL") {
                            status = "Order is delivered";
                        } else if (status === "ASNC") {
                            status = "";
                        } else if (status === "ARS") {
                            status = "Artwork is Submited";
                        } else if (status === "UPD") {
                            status = "Order not Complete";
                        } else {
                            status = "Artwork is Received";
                        }
                    }

                    gcell142.innerHTML = status;


                }
                var parsedDatatec = JSON.parse(res[1]);
                var c = 0;

                if (parsedDatatec.constructor === Array) {

                    var tabletc = document.getElementById("tecdata");
                    var tec = "";
                    while (c < parsedDatatec.length) {
                        var rowtec = tabletc.insertRow(0);
                        var tcell1 = rowtec.insertCell(0);
                        var tcell2 = rowtec.insertCell(1);
                        var tcell3 = rowtec.insertCell(2);
                        var tcell4 = rowtec.insertCell(3);
                        var tcell5 = rowtec.insertCell(4);
                        var tcell6 = rowtec.insertCell(5);
                        var tcell7 = rowtec.insertCell(6);
                        var tcell8 = rowtec.insertCell(7);
                        var tcell9 = rowtec.insertCell(8);
                        var tcell10 = rowtec.insertCell(9);
                        tcell1.innerHTML = parsedDatatec[c].PLabel;
                        tcell2.innerHTML = parsedDatatec[c].Reference;
                        tcell3.innerHTML = parsedDatatec[c].Care_Text;
                        tcell4.innerHTML = parsedDatatec[c].Wash_Symbol;
                        tcell5.innerHTML = parsedDatatec[c].Fibre_Composition_1;
                        tcell6.innerHTML = parsedDatatec[c].Fibre_Composition_2;
                        tcell7.innerHTML = parsedDatatec[c].Fibre_Composition_3;
                        tcell8.innerHTML = parsedDatatec[c].Fibre_Composition_3;
                        tcell9.innerHTML = parsedDatatec[c].PGroup;
                        tcell10.innerHTML = parsedDatatec[c].Description;

                        c++;
                    }

                } else {

                }
                var parsedDatasw = JSON.parse(res[2]);
                var f = 0;

                if (parsedDatasw.constructor === Array) {

                    var tablesw = document.getElementById("swidata");

                    while (f < parsedDatasw.length) {

                        var rowtsw = tablesw.insertRow(0);
                        var scell1 = rowtsw.insertCell(0);
                        var scell2 = rowtsw.insertCell(1);
                        var scell3 = rowtsw.insertCell(2);
                        var scell4 = rowtsw.insertCell(3);
                        var scell5 = rowtsw.insertCell(4);
                        var scell6 = rowtsw.insertCell(5);
                        var scell7 = rowtsw.insertCell(6);
                        scell1.innerHTML = parsedDatasw[f].REFERENCE;
                        scell2.innerHTML = parsedDatasw[f].TREND_NAME;
                        scell3.innerHTML = parsedDatasw[f].PRODUCT_BENIFIT;
                        scell4.innerHTML = parsedDatasw[f].PRODUCT_DESCRIPTION;
                        scell5.innerHTML = parsedDatasw[f].SUPPLIER_ID;
                        scell6.innerHTML = parsedDatasw[f].JOB_NO;
                        scell7.innerHTML = parsedDatasw[f].CARE_TEXT;
                        f++;
                    }

                } else {

                }
                var parsedData = JSON.parse(res[3]);
                var i = 0;
                var table = document.getElementById("eandata");
                while (i < parsedData.length) {


                    var row = table.insertRow(0);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);
                    var cell9 = row.insertCell(8);
                    var cell10 = row.insertCell(9);
                    var cell11 = row.insertCell(10);
                    var cell12 = row.insertCell(11);
                    var cell13 = row.insertCell(12);
                    var cell14 = row.insertCell(13);
                    var cell15 = row.insertCell(14);
                    var cell16 = row.insertCell(15);
                    cell1.innerHTML = parsedData[i].EAN_No;
                    cell2.innerHTML = parsedData[i].UK;
                    cell3.innerHTML = parsedData[i].EUR;
                    cell4.innerHTML = parsedData[i].US;
                    cell5.innerHTML = parsedData[i].MX;
                    cell6.innerHTML = parsedData[i].Sec_Size1;
                    cell7.innerHTML = parsedData[i].Sec_Size2;
                    cell8.innerHTML = parsedData[i].Sec_Size3;
                    cell9.innerHTML = parsedData[i].Sec_Size4;
                    cell10.innerHTML = parsedData[i].Euro;
                    cell11.innerHTML = parsedData[i].pound;
                    cell12.innerHTML = parsedData[i].CZ;
                    cell13.innerHTML = parsedData[i].SK;
                    cell14.innerHTML = parsedData[i].PL;
                    cell15.innerHTML = parsedData[i].HU;
                    cell16.innerHTML = parsedData[i].TK;
                    i++;
                }
            }
        };
        xmlHttp.open("POST", "CSV?id=getlof&val=" + id, true);
        xmlHttp.send();
    }

</script>




<script type="text/javascript">



    function getAllDetails()
    {
        $("#tbl_orderDetails").hide();
        $("#tbl_orderDetails tbody").empty();
        $("#lofdetails_div").hide();

        var userName = document.getElementById('userHidden').value;

        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');

                var y = reply.length;

                var tbl = document.getElementById('viewDetials_tbl').getElementsByTagName('tbody')[0];

                if (y > 0) {
                    $("#tbl_orderDetails").show();
                    for (var j = 0; j < y; j++) {

                        var row = document.createElement("tr");

                        var orderNo = document.createElement("td");
                        orderNo.innerHTML = j + 1;

                        var id = document.createElement("td");
                        id.innerHTML = reply[j].id;

                        var po = document.createElement("td");
                        po.innerHTML = reply[j].purchase_order;

                        var lof_data = document.createElement("td");
                        lof_data.innerHTML = reply[j].lof_data;

                        var style_no = document.createElement("td");
                        style_no.innerHTML = reply[j].style_no;

                        document.getElementById("title").innerHTML = "All Orders";

                        row.appendChild(orderNo);
                        row.appendChild(id);
                        row.appendChild(po);
//                        row.appendChild(lof_data);
                        row.appendChild(style_no);

                        tbl.appendChild(row);

                    }
                }
            }
        };
        xmlHttp.open("POST", "Controller?method=getAlldetails&userName=" + userName, true);
        xmlHttp.send();
    }
    function getPendingOrders()
    {
        $("#tbl_orderDetails").hide();
        $("#tbl_orderDetails tbody").empty();
        $("#lofdetails_div").hide();
        var userName = document.getElementById('userHidden').value;
        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var y = reply.length;

                var tbl = document.getElementById('viewDetials_tbl').getElementsByTagName('tbody')[0];

                if (y > 0) {
                    $("#tbl_orderDetails").show();
                    for (var j = 0; j < y; j++) {

                        var row = document.createElement("tr");

                        var orderNo = document.createElement("td");
                        orderNo.innerHTML = j + 1;

                        var id = document.createElement("td");
                        id.innerHTML = reply[j].id;

                        var po = document.createElement("td");
                        po.innerHTML = reply[j].purchase_order;

                        var lof_data = document.createElement("td");
                        lof_data.innerHTML = reply[j].lof_data;

                        var style_no = document.createElement("td");
                        style_no.innerHTML = reply[j].style_no;

                        document.getElementById("title").innerHTML = "All Orders";

                        row.appendChild(orderNo);
                        row.appendChild(id);
                        row.appendChild(po);
//                        row.appendChild(lof_data);
                        row.appendChild(style_no);

                        tbl.appendChild(row);

                    }
                }
            }
        };
        xmlHttp.open("POST", "Controller?method=getPendingOrders&userName=" + userName, true);
        xmlHttp.send();

    }

    function processingOrders()
    {
        $("#tbl_orderDetails").hide();
        $("#tbl_orderDetails tbody").empty();
        $("#lofdetails_div").hide();
        var userName = document.getElementById('userHidden').value;

        document.getElementById("details_table").className = "";


        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var y = reply.length;

                var tbl = document.getElementById('viewDetials_tbl').getElementsByTagName('tbody')[0];

                if (y > 0) {
                    $("#tbl_orderDetails").show();

                    for (var j = 0; j < y; j++) {

                        var row = document.createElement("tr");

                        var orderNo = document.createElement("td");
                        orderNo.innerHTML = j + 1;

                        var id = document.createElement("td");
                        id.innerHTML = reply[j].id;

                        var po = document.createElement("td");
                        po.innerHTML = reply[j].purchase_order;

                        var lof_data = document.createElement("td");
                        lof_data.innerHTML = reply[j].lof_data;

                        var style_no = document.createElement("td");
                        style_no.innerHTML = reply[j].style_no;

                        document.getElementById("title").innerHTML = "All Orders";

                        row.appendChild(orderNo);
                        row.appendChild(id);
                        row.appendChild(po);
//                        row.appendChild(lof_data);
                        row.appendChild(style_no);

                        tbl.appendChild(row);

                    }
                }
            }
        };

        xmlHttp.open("POST", "Controller?method=getprocessingOrders&userName=" + userName, true);
        xmlHttp.send();

    }

    function completedOrders() {
        $("#tbl_orderDetails").hide();
        $("#tbl_orderDetails tbody").empty();
        $("#lofdetails_div").hide();
        var userName = document.getElementById('userHidden').value;

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var y = reply.length;

                var tbl = document.getElementById('viewDetials_tbl').getElementsByTagName('tbody')[0];

                if (y > 0) {
                    $("#tbl_orderDetails").show();

                    for (var j = 0; j < y; j++) {

                        var row = document.createElement("tr");

                        var orderNo = document.createElement("td");
                        orderNo.innerHTML = j + 1;

                        var id = document.createElement("td");
                        id.innerHTML = reply[j].id;

                        var po = document.createElement("td");
                        po.innerHTML = reply[j].purchase_order;

                        var lof_data = document.createElement("td");
                        lof_data.innerHTML = reply[j].lof_data;

                        var style_no = document.createElement("td");
                        style_no.innerHTML = reply[j].style_no;

                        document.getElementById("title").innerHTML = "All Orders";

                        row.appendChild(orderNo);
                        row.appendChild(id);
                        row.appendChild(po);
//                        row.appendChild(lof_data);
                        row.appendChild(style_no);

                        tbl.appendChild(row);

                    }
                }
            }
        };

        xmlHttp.open("POST", "Controller?method=getcompletedOrders&userName=" + userName, true);
        xmlHttp.send();

    }

</script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#tbl_orderDetails").hide();
        $("#lofdetails_div").hide();
        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem1").addClass("active");
    });
</script>
<%@include file="include/footer.jsp"%>
<% } else {
        response.sendRedirect("LogoutController");
    }%>