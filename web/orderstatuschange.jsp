<%-- 
    Document   : admin
    Created on : Jul 5, 2015, 7:01:25 AM
    Author     : oshan
--%>

<%@include file="include/header.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    SysUser user3 = (SysUser) session.getAttribute("user");
    if (user3 != null) {
%>
<%@include file="include/sideMenu.jsp"%>

<div id="page-wrapper">

    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">
                    Order Status Change
                </h1>
                <ol class="breadcrumb">
                    <li class="active">
                        <i class="fa fa-dashboard"></i> Search Order By Web Order No
                    </li>
                </ol>
            </div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="form-group">
                        <%if (user3.getUserType().getUserType() == 5 || user3.getUserType().getUserType() == 3) {%>

                        <sql:query var="idQ9"  dataSource="jdbc/sdb">
                            SELECT DISTINCT(id) FROM `lof_generaldata` WHERE conf_order NOT IN ('UPD','ASNC') AND  supplier_no IN ( SELECT `company_code` FROM `company` WHERE `cs` = '<%=user3.getUsername()%>') ORDER BY ordered_date DESC;
                        </sql:query>

                        <select  name="lof" id="lof" class="form-control" onchange="getIDs();">

                            <option  selected disabled="true"> - Select Order - </option>
                            <c:forEach var="row9" items="${idQ9.rows}"> 
                                <option value="${row9.id}">${row9.id}</option>
                            </c:forEach>

                        </select> 

                        <%}%>

                    </div>
                </div>
                <form>
                    <input type="hidden" name="orderid" id="orderid" value="" />
                </form>

                <!--<div style="left: 45%;">-->


            </div>
            <div  class="row">

                <div class="col-lg-2 col-md-2 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <button id="Cancel" class="btn btn-warning" style="width: 100%;" onclick="CancelOrder();" >Cancel Order</button>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <button id="Hold" class="btn btn-info" style="width: 100%;"  onclick="HoldOrder();">Hold Order</button>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <button id="Start" class="btn btn-primary" style="width: 100%;" onclick="StartOrder();" >Start Order</button>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <button id="Complete" class="btn btn-primary" style="width: 100%;" onclick="Complete();" >Complete Order</button>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <button id="Delevered" class="btn btn-primary" style="width: 100%;" onclick="Delevered();" >Delevered Order</button>
                    </div>
                </div>
            </div>

        </div>

        <div class="raw">
            <div class="col-lg-8 col-md-8 col-lg-offset-2 col-md-offset-2">
                <table border="0" width="100%" id="lofData" class="table table-hover" style="left: 10px;">
                    <thead>
                        <tr >
                            <th bgcolor="#EFEFEF">#</th>                            
                            <th bgcolor="#EFEFEF">Lof ID</th>                            
                            <th bgcolor="#EFEFEF">Status</th>                            
                            <th bgcolor="#EFEFEF">Order Running Status</th>                            
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>

                </table>
            </div>


        </div>

    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->
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
        $("#menuItem13").addClass("active");

    });
</script>
<script type="text/javascript">

    function getIDs() {
        var po_no = document.getElementById("lof").value;

        $("#artView").attr("src", "");
        var xmlHttp = getAjaxObject();

        $("#lofData tbody").empty();
        xmlHttp.onreadystatechange = function () {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var tbllofData = document.getElementById('lofData').getElementsByTagName('tbody')[0];
                for (var a = 0; a < reply.id.length; a++) {
                    var lof = reply.id[a];

                    var elem1 = document.createElement("input");
                    elem1.id = lof.newid;
                    elem1.type = "radio";
                    elem1.name = "radioLOF";
                    elem1.value = "radioLOF";
                    var elem2 = document.createElement("input");
                    elem2.id = lof.newid;
                    elem2.type = "hidden";
                    elem2.name = "radioLOF";
                    elem2.value = lof.lofid + "@@@" + lof.status;
//alert("cHALI "+lof.statusorder);

                }
                var row = document.createElement("tr");

                var col1 = document.createElement("td");
                col1.innerHTML = a + 1;
                col1.appendChild(elem2);

                var col2 = document.createElement("td");
                col2.innerHTML = lof.lofid;
                var col3 = document.createElement("td");
                var col4 = document.createElement("td");
                col4.innerHTML = lof.statusorder;
                if (lof !== null) {
                    var status = lof.status;
                    if (status === "NAR") {
                        status = "Not Requested";
                        col3.innerHTML = status;
                        col3.style.color = "#FF0000";
                    } else if (status === "AR") {
                        status = "Artwork is Pending";
                        col3.innerHTML = status;
                        col3.style.color = "#CCCC00";
                    } else if (status === "CONA") {
                        status = "Order is confirmed";
                        col3.innerHTML = status;
                        col3.style.color = "#00008F";
                    } else if (status === "DEL") {
                        status = "Order is delivered";
                        col3.innerHTML = status;
                        col3.style.color = "#993333";
                    }
                    else if (status === "UPD") {
                        status = "Order not Submited";
                        col3.innerHTML = status;
                        col3.style.color = "#993333";
                    }
                    else if (status === "ARS") {
                        status = "Artwork Received";
                        col3.innerHTML = status;
                        col3.style.color = "#218221";
                    }
                    else if (status === "NARCONA") {
                        status = "Not Artwork Requested Confirmed";
                        col3.innerHTML = status;
                        col3.style.color = "#993333";
                    }
                    else if (status === "ARCONA") {
                        status = "Artwork Requested Confirmed";
                        col3.innerHTML = status;
                        col3.style.color = "#993333";
                    }
                    else {
                        status = "Artwork is Error";
                        col3.innerHTML = status;
                        col3.style.color = "#218221";
                    }
                }

                row.appendChild(col1);
                row.appendChild(col2);
                row.appendChild(col3);
                row.appendChild(col4);
                tbllofData.appendChild(row);

            }

        };
        xmlHttp.open("POST", "RequestAwController?actionType=getIdsFormwebOID&po_no=" + po_no, true);
        xmlHttp.send();
    }
</script>
<script>
    function CancelOrder() {
        var id = document.getElementById("lof").value;
        var id2 = document.getElementById("lof").value;

        var dataArr = [id, id2];

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                BootstrapDialog.show({
                    title: 'Notification',
                    size: BootstrapDialog.SIZE_SMALL,
                    type: BootstrapDialog.TYPE_SUCCESS,
                    message: 'Order Canceled',
                    buttons: [{
                            label: 'Ok',
                            action: function (dialogRef) {
                                dialogRef.close();
                                location.reload();
                            }
                        }]
                });

            }
        };

        xmlHttp.open("POST", "Orderstatus?method=CancelOrder&dataArr=" + dataArr, true);
        xmlHttp.send();

    }
</script>
<script>
    function HoldOrder() {
        var id = document.getElementById("lof").value;
        var id2 = document.getElementById("lof").value;

        var dataArr = [id, id2];

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                BootstrapDialog.show({
                    title: 'Notification',
                    size: BootstrapDialog.SIZE_SMALL,
                    type: BootstrapDialog.TYPE_SUCCESS,
                    message: 'Order Hold.',
                    buttons: [{
                            label: 'Ok',
                            action: function (dialogRef) {
                                dialogRef.close();
                                location.reload();
                            }
                        }]
                });
            }
        };

        xmlHttp.open("POST", "Orderstatus?method=HoldOrder&dataArr=" + dataArr, true);
        xmlHttp.send();

    }
</script>
<script>
    function StartOrder() {
        var id = document.getElementById("lof").value;
        var id2 = document.getElementById("lof").value;

        var dataArr = [id, id2];

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                BootstrapDialog.show({
                    title: 'Notification',
                    size: BootstrapDialog.SIZE_SMALL,
                    type: BootstrapDialog.TYPE_SUCCESS,
                    message: 'Order Started',
                    buttons: [{
                            label: 'Ok',
                            action: function (dialogRef) {
                                dialogRef.close();
                                location.reload();
                            }
                        }]
                });
            }
        };

        xmlHttp.open("POST", "Orderstatus?method=StartOrder&dataArr=" + dataArr, true);
        xmlHttp.send();

    }
</script>
<script>
    function Complete() {
        var id = document.getElementById("lof").value;
        var id2 = document.getElementById("lof").value;

        var dataArr = [id, id2];

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                BootstrapDialog.show({
                    title: 'Notification',
                    size: BootstrapDialog.SIZE_SMALL,
                    type: BootstrapDialog.TYPE_SUCCESS,
                    message: 'Order Complete',
                    buttons: [{
                            label: 'Ok',
                            action: function (dialogRef) {
                                dialogRef.close();
                                location.reload();
                            }
                        }]
                });
            }
        };

        xmlHttp.open("POST", "Orderstatus?method=Complete&dataArr=" + dataArr, true);
        xmlHttp.send();

    }
</script>
<script>
    function Delevered() {
        var id = document.getElementById("lof").value;
        var id2 = document.getElementById("lof").value;

        var dataArr = [id, id2];

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                BootstrapDialog.show({
                    title: 'Notification',
                    size: BootstrapDialog.SIZE_SMALL,
                    type: BootstrapDialog.TYPE_SUCCESS,
                    message: 'Order Delevered',
                    buttons: [{
                            label: 'Ok',
                            action: function (dialogRef) {
                                dialogRef.close();
                                location.reload();
                            }
                        }]
                });
            }
        };

        xmlHttp.open("POST", "Orderstatus?method=Delevered&dataArr=" + dataArr, true);
        xmlHttp.send();

    }
</script>
<%@include file="include/footer.jsp"%>
<% } else {
        response.sendRedirect("LogoutController");
    }%>