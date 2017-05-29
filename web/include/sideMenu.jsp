<%-- 
    Document   : sideMenuInner
    Created on : Jul 5, 2015, 10:26:16 AM
    Author     : root
--%>


<%@page import="com.impression.hibe.model.SysUser"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    SysUser user5 = (SysUser) session.getAttribute("user");
    // System.out.println(user5.getUsername());
%>

<sql:query var="idQ2"  dataSource="jdbc/sdb">
    SELECT * FROM sys_user_menu_item sm INNER JOIN sys_user s ON sm.`username`=s.`username` WHERE sm.username='<%=user5.getUsername()%>'; 
</sql:query> 

<sql:query var="idQ5"  dataSource="jdbc/sdb">
    SELECT COUNT(username) as cnt FROM sys_user where company_id='<%= user5.getCompanyId().getCompanyId()%>' AND is_active=false;         
</sql:query>

<sql:query var="idQ6"  dataSource="jdbc/sdb">
    SELECT COUNT(username) as cnt FROM sys_user where company_id='<%= user5.getCompanyId().getCompanyId()%>' AND is_active=false;         
</sql:query>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#"  style="padding: 10px 10px 10px 20px;">
            <img alt="Brand" src="/IEPTescoNew/img/logo_head.png" class="img-responsive">
        </a>
        <a class="navbar-brand" href="/IEPTescoNew/admin.jsp">Impressions Labels E-Platform</a>
    </div>
    <!-- Top Menu Items -->
    <ul class="nav navbar-right top-nav">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="text-transform: capitalize;" ><i class="fa fa-user"></i> <%=user5.getUsername()%> <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li>
                    <a href="/IEPTescoNew/userDetails.jsp"><i class="fa fa-fw fa-user"></i> Profile</a>
                </li>
                <li class="divider"></li>
                <li>
                    <a href="/IEPTescoNew/LogoutController"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                </li>
            </ul>
        </li>
    </ul>
    <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
    <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav side-nav">
            <li id="menuItem1" class="active">
                <a href="/IEPTescoNew/admin.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
            </li>
            <c:forEach items="${idQ2.rows}" var="row2">
                <c:choose>
                    <c:when test="${row2.menu_item==1 && row2.user_type==3}">
                        <li id="menuItem2" class="">
                            <a href="/IEPTescoNew/addSuperUser.jsp"><i class="fa fa-fw fa-user"></i> Add User</a>
                        </li>
                    </c:when>
                    <c:when test="${row2.menu_item==2 && row2.user_type<=3}">
                        <li id="menuItem3" class="">
                            <a href="/IEPTescoNew/Extract/pdfExtracter.jsp"><i class="fa fa-fw fa-hand-o-right"></i> Place The Order</a>
                        </li>                        
                        <li id="menuItem3" class="">
                            <a href="/IEPTescoNew/techTeam.jsp"><i class="fa fa-fw fa-hand-o-right"></i> Tech Team</a>
                        </li>                        
                    </c:when>
                    <c:when test="${row2.menu_item==3 && row2.user_type<=3}">
                        <li id="menuItem5" class="">
                            <a href="/IEPTescoNew/requestArtwork.jsp"><i class="fa fa-fw fa-gavel"></i>Request Artwork</a>
                        </li>
                    </c:when>
                    <c:when test="${row2.menu_item==4 && row2.user_type<=3}">
                        <li id="menuItem12" class="">
                            <a href="/IEPTescoNew/copy_forgot.jsp"><i class="fa fa-fw fa-gavel"></i> Confirm Order</a>
                        </li>
                    </c:when>
                    <c:when test="${row2.menu_item==5 && (row2.user_type<=3)}">
                        <li id="menuItem4" class="">
                            <a href="/IEPTescoNew/orderTracking.jsp"><i class="fa fa-fw fa-map-marker"></i> Order Tracking</a>
                        </li>
                    </c:when>
                    <c:when test="${row2.menu_item==12 && row2.user_type == 5}">
                        <li id="menuItem12" class="">
                            <a href="/IEPTescoNew/cs_orderTracking.jsp"><i class="fa fa-fw fa-map-marker"></i> Order Tracking</a>
                        </li>

                        <li id="menuItem13" class="">
                            <a href="/IEPTescoNew/orderstatuschange.jsp"><i class="fa fa-fw fa-map-marker"></i>Order Canceling</a>
                        </li>
                    </c:when>

                    <c:when test="${row2.menu_item==9 && row2.user_type>=3 && row2.user_type<6}">
                        <li id="menuItem10" class="">
                            <a href="/IEPTescoNew/artWorkUpload.jsp"><i class="fa fa-fw fa-group"></i> Upload Artwork</a>
                        </li>
                    </c:when>
                    <c:when test="${row2.menu_item==8 && row2.user_type==3}">
                        <li id="menuItem6" class="">
                            <a href="/IEPTescoNew/registerGarment.jsp"><i class="fa fa-fw fa-group"></i> Register Garment 

                            </a>
                        </li>
                    </c:when>

                    <c:when test="${row2.menu_item==7 && row2.user_type>=3}">
                        <li id="menuItem8" class="">
                            <a href="/IEPTescoNew/contentUp.jsp"><i class="fa fa-fw fa-group"></i> Content Updating</a>
                        </li>
                    </c:when>


                    <c:when test="${row2.menu_item==6}">
                        <li id="menuItem7" class="">
                            <a href="/IEPTescoNew/Users/givePermission.jsp"><i class="fa fa-fw fa-group"></i> User Permission Control</a>
                        </li>
                    </c:when>
                </c:choose>
            </c:forEach>
        </ul>
    </div>
    <!-- /.navbar-collapse -->
</nav>
