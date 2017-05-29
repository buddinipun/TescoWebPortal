<%-- 
    Document   : requestArtwork
    Created on : Aug 5, 2015, 12:28:50 PM
    Author     : User
--%>

<%@page import="com.impression.hibe.model.SysUser"%>
<%@include file="include/header.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--<%@include file="include/sideMenu.jsp"%>--%>
<%    SysUser user3 = (SysUser) session.getAttribute("user");
    if (user3 != null) {
%>

<%@include file="include/sideMenu.jsp"%>

<style type="text/css">
    td {
        text-align: center;
        vertical-align: middle;
    }
</style>

<script type="text/javascript">

    $(document).on('click', '#lofData tbody tr', function () {

        $('#lofData tbody tr').removeClass('highlighted');
        $(this).addClass('highlighted');
        var tex = $(this).find('input[type=hidden]').val();
        var sli = tex.split("@@@");
        document.getElementById("orderid").value = sli[0];
        var orderF = sli[0];
        document.getElementById("print_id").href = "/IEPTescoNew/DownloadPDF?lof_no=" + orderF;
        var status = sli[1];
        if (status !== null) {
            $("#reviewCtrl").show();
            if (status === "NAR") {
                document.getElementById("btnArtwork").value = "Request Artwork";
                document.getElementById("btnArtwork").disabled = false;
            } else if (status === "AR") {
                document.getElementById("btnArtwork").disabled = true;
            } else if (status === "ARS") {
                document.getElementById("btnArtwork").value = "View Artwork";
                document.getElementById("btnArtwork").disabled = false;
            }
        }

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var label = reply.labels;
                var tbllofData = document.getElementById('labelData').getElementsByTagName('tbody')[0];
                $("#labelData tbody").empty();
                for (var i = 0; i < label.length; i++) {

                    var row = document.createElement("tr");
                    var col1 = document.createElement("td");
                    col1.innerHTML = label[i].refno;
                    var col2 = document.createElement("td");
                    var elem1 = document.createElement("form");
                    elem1.method = "POST";
                    elem1.id = orderF + "__" + label[i].refno + "__" + label[i].id;
                    elem1.action = "/IEPTescoNew/PreviewController";
                    var elem2 = document.createElement("input");
                    elem2.type = "submit";
                    elem2.id = orderF + "__" + label[i].refno + "__" + label[i].id;
                    elem2.value = "View"

                    var elem3 = document.createElement("input");
                    elem3.type = "hidden";
                    elem3.id = "label_id";
                    elem3.name = "label_id";
                    elem3.value = orderF + "__" + label[i].refno + "__" + label[i].id;
                    elem1.appendChild(elem2);
                    elem1.appendChild(elem3);
                    col2.appendChild(elem1);
                    row.appendChild(col1);
                    row.appendChild(col2);
                    tbllofData.appendChild(row);
                }

            }
        };
        xmlHttp.open("POST", "RequestAwController?actionType=getTechLabels&order_id=" + orderF, true);
        xmlHttp.send();
    });
    $(document).on('click', '#labelData tbody tr input[type=submit]', function () {

        var id = this.id;
        alert(id);
        document.getElementById(id).submit();
    });
    function requestArtWork(id) {

        $('#Searching_Modal').modal('show');
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                $('#Searching_Modal').modal('hide');
                BootstrapDialog.show({
                    message: reply.result,
                    closable: false,
                    size: BootstrapDialog.SIZE_SMALL,
                    buttons: [{
                            label: 'Close',
                            action: function (dialogRef) {
                                dialogRef.close();
                                location.reload();
                            }
                        }]
                });
            }
        };
        xmlHttp.open("POST", "RequestAwController?actionType=requestArtwork&id=" + id, true);
        xmlHttp.send();
    }

    function previewArtwork(data) {
        var id = document.getElementById("artView");
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log(reply);
                alert(reply.result);
                alert(data);
//                id.src = "artwork/NoImage.jpg";
                if (reply.result == "false") {
                    id.src = "artwork/NoImage.jpg";
                } else if (reply.result == "true") {
                    document.getElementById("imgURL").href = "artwork/" + data + ".png";
                    id.src = "artwork/" + data + ".png";
                }else{
                    alert(reply.result);
                }
            }
        };
        xmlHttp.open("POST", "RequestAwController?actionType=checkArtwork&id=" + data, true);
        xmlHttp.send();
    }

    function getLofData(data) {
        document.getElementById("artView").src = "";
        $("#labelData tbody").empty();
        $("#labelData tbody").empty();
        $("#reviewCtrl").hide();
        $("#lofData tbody").empty();
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var tbllofData = document.getElementById('lofData').getElementsByTagName('tbody')[0];
                for (a = 0; a < reply.length; a++) {

                    var lof = reply[a];
                    var row = document.createElement("tr");
                    var col0 = document.createElement("td");
                    col0.innerHTML = lof.id;
                    var col1 = document.createElement("td");
                    col1.innerHTML = lof.lofid;
                    var col2 = document.createElement("td");
                    var col3 = document.createElement("td");
                    var elem2 = document.createElement("input");
                    elem2.id = lof.lofid;
                    elem2.type = "button";
                    elem2.value = "Request";
                    elem2.className = "btn btn-default pull-right";
                    if (lof !== null) {
                        var status = lof.status;
                        if (status === "NAR") {
                            status = "Order Processing is Holded temporarily until the Confirm Order";
                            col2.innerHTML = status;
                            col2.style.color = "#FF0000";
                            col3.appendChild(elem2);
                        } else if (status === "AR") {
                            status = "Artwork is Pending";
                            col2.innerHTML = status;
                            col2.style.color = "#CCCC00";
                        } else if (status === "CONA") {
                            status = "Order is confirmed";
                            col2.innerHTML = status;
                            col2.style.color = "#00008F";
                        } else if (status === "DEL") {
                            status = "Order is delivered";
                            col2.innerHTML = status;
                            col2.style.color = "#993333";
                        } else if (status === "ASNC") {
                            status = "";
                            col2.innerHTML = status;
                            col2.style.color = "#993333";
                        } else if (status === "UPD") {
                            status = "Order Is Not Submitted";
                            col2.innerHTML = status;
                            col2.style.color = "#993333";
                        } else if (status === "ARS") {
                            status = "Artwork is Received";
                            col2.innerHTML = status;
                            col2.style.color = "#218221";
                        }
                    }

                    var elem1 = document.createElement("input");
                    elem1.id = lof.lofid;
                    elem1.type = "hidden";
                    elem1.value = lof.lofid + "@@@" + lof.status;
                    col2.appendChild(elem1);
                    row.appendChild(col0);
                    row.appendChild(col1);
                    row.appendChild(col2);
//                    row.appendChild(col3);
                    tbllofData.appendChild(row);
                }
            }
        };
        xmlHttp.open("POST", "RequestAwController?actionType=getLofData&data=" + data, true);
        xmlHttp.send();
    }

    function getIDs() {
        var po_no = document.getElementById("cmb_poNo").value;
        $("#reviewCtrl").hide();
        $("#lofData tbody").empty();
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {

                var reply = eval('(' + xmlHttp.responseText + ')');
                var idList = [];
                $.each(reply.id, function (l, el) {
                    if ($.inArray(el, idList) === -1)
                        idList.push(el);
                });
                var prmSizeElem = document.getElementById("cmb_webOrder");
                for (i = 0; i < idList.length; i++) {
                    var prmSize = idList[i];
                    var opt = document.createElement("option");
                    opt.textContent = prmSize;
                    opt.value = prmSize;
                    prmSizeElem.appendChild(opt);
                }
            }

        };
        xmlHttp.open("POST", "RequestAwController?actionType=getIdsFormPo&po_no=" + po_no, true);
        xmlHttp.send();
    }


</script>

<style type="text/css">
    tr.highlighted td{
        background:  #D8D8D8;
    }

</style>

<div id="page-wrapper">

    <div class="container-fluid">
        <div class="col-lg-10 col-lg-offset-1" style="padding-top: 3%;">
            <div class="row">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading"><strong>Request Artwork</strong></div>
                    <div class="panel-body">
                        <form class="form-horizontal" role="form">
                            <div class="row">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center;" width="25%">
                                                Purchase Order
                                            </th>
                                            <th style="text-align: center;" width="25%">
                                                Web Order
                                            </th>
                                            <th style="text-align: center;" width="25%">
                                                Style No
                                            </th>
                                            <th style="text-align: center;" width="25%">
                                                Customer Purchase Order
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="search">
                                        <tr>
                                            <td style="padding: 2px;">
                                                <!--<input class="form-control" list="po_numbers" name="search" id="cmb_poNo" style="width: 100%;" readonly/>-->
                                                <!--<datalist id="po_numbers">-->
                                                <%if (user3.getUserType().getUserType() == 1) {%>
                                                <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.purchase_order_uk FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else if (user3.getUserType().getUserType() == 2) {%>
                                                <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.purchase_order_uk FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.username='<%=user3.getUsername()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else if (user3.getUserType().getUserType() == 5) {%>
                                                <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.purchase_order_uk FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else {%>
                                                <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT purchase_order_uk FROM lof_generaldata WHERE conf_order IN('NAR','AR','ARS') GROUP BY id ORDER BY ordered_date DESC;
                                                </sql:query>
                                                <%}%>
                                                <select class="form-control" name="search" id="cmb_poNo" style="width: 100%;">
                                                    <option value="0" selected="selected" disabled="disabled">Search using PO No</option>
                                                    <c:forEach var="row9" items="${idQ9.rows}"> 
                                                        <option value="${row9.purchase_order_uk}">${row9.purchase_order_uk}</option>
                                                    </c:forEach>
                                                </select>
                                                <!--</datalist>-->
                                            </td>
                                            <td style="padding: 2px;">
                                                <!--<input class="form-control"  list="web_numbers" name="search" id="cmb_webNo" style="width: 100%;" readonly/>-->
                                                <!--<datalist id="web_numbers">-->
                                                <%if (user3.getUserType().getUserType() == 1) {%>
                                                <sql:query var="idQ10"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.id FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else if (user3.getUserType().getUserType() == 2) {%>
                                                <sql:query var="idQ10"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.id FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id WHERE c.username='<%=user3.getUsername()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;

                                                </sql:query>
                                                <%} else if (user3.getUserType().getUserType() == 5) {%>
                                                <sql:query var="idQ10"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.id FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else {%>
                                                <sql:query var="idQ10"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT id FROM lof_generaldata WHERE conf_order IN('NAR','AR','ARS') GROUP BY id ORDER BY ordered_date DESC;
                                                </sql:query>
                                                <%}%>
                                                <select class="form-control"  name="search" id="cmb_webNo" style="width: 100%;">
                                                    <option value="0" selected="selected"  disabled="disabled">Search using web order</option>
                                                    <c:forEach var="row10" items="${idQ10.rows}"> 
                                                        <option value="${row10.id}">${row10.id}</option>
                                                    </c:forEach>
                                                    <!--</datalist>-->
                                                </select>
                                            </td>
                                            <td style="padding: 2px;">
                                                <!--                                                <input class="form-control" list="style_numbers" name="search" id="cmb_styNo" style="width: 100%;" readonly/>-->
                                                <!--<datalist id="style_numbers">-->
                                                <%if (user3.getUserType().getUserType() == 1) {%>
                                                <sql:query var="idQ11"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT `l`.`style_no_uk` FROM `lof_generaldata` l JOIN `customer`  c ON `l`.`customer`=`c`.`customer_id` JOIN `sys_user`  s ON `s`.`username` = `c`.`username` WHERE `s`.`company_id`='<%=user3.getCompanyId().getCompanyId()%>' AND `l`.`conf_order` IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else if (user3.getUserType().getUserType() == 2) {%>
                                                <sql:query var="idQ11"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.style_no_uk FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.username='<%=user3.getUsername()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else if (user3.getUserType().getUserType() == 5) {%>
                                                <sql:query var="idQ11"  dataSource="jdbc/sdb">                                            
                                                    SELECT DISTINCT `l`.`style_no_uk` FROM `lof_generaldata` l JOIN `customer`  c ON `l`.`customer`=`c`.`customer_id` JOIN `sys_user`  s ON `s`.`username` = `c`.`username` WHERE `s`.`company_id`='<%=user3.getCompanyId().getCompanyId()%>' AND `l`.`conf_order` IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else {%>
                                                <sql:query var="idQ11"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT style_no_uk FROM lof_generaldata WHERE conf_order IN('NAR','AR','ARS') ORDER BY lof_data DESC;
                                                </sql:query>
                                                <%}%>
                                                <select class="form-control" name="search" id="cmb_styNo" style="width: 100%;">
                                                    <option value="0" selected="selected"  disabled="disabled">Search using Style No</option>
                                                    <c:forEach var="row11" items="${idQ11.rows}"> 
                                                        <option value="${row11.style_no_uk}">${row11.style_no_uk}</option>
                                                    </c:forEach>
                                                </select>
                                                <!--</datalist>-->
                                            </td>
                                            <td style="padding: 2px;">
                                                <!--<input class="form-control" list="cus_numbers" name="search" id="cmb_cusNo" style="width: 100%;" readonly/>-->
                                                <!--<datalist id="cus_numbers">-->
                                                <%if (user3.getUserType().getUserType() == 1) {%>
                                                <sql:query var="idQ12"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.customer_po FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else if (user3.getUserType().getUserType() == 2) {%>
                                                <sql:query var="idQ12"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.customer_po FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.username='<%=user3.getUsername()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else if (user3.getUserType().getUserType() == 5) {%>
                                                <sql:query var="idQ12"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT l.customer_po FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order IN ('NAR','AR','ARS') ORDER BY l.ordered_date DESC;
                                                </sql:query>
                                                <%} else {%>
                                                <sql:query var="idQ12"  dataSource="jdbc/sdb">
                                                    SELECT DISTINCT customer_po FROM lof_generaldata WHERE conf_order IN('NAR','AR','ARS') ORDER BY lof_data DESC;
                                                </sql:query>
                                                <%}%>
                                                <select class="form-control" name="search" id="cmb_cusNo" style="width: 100%;">
                                                    <option value="0" selected="selected"  disabled="disabled">Search using Customer PO No</option>
                                                    <c:forEach var="row12" items="${idQ12.rows}"> 
                                                        <option value="${row12.customer_po}">${row12.customer_po}</option>
                                                    </c:forEach>
                                                </select>
                                                <!--</datalist>-->
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                            </div>
                        </form> 
                        <table border="0" width="100%" id="lofData" class="table table-hover">
                            <thead>
                                <tr >
                                    <th width="30%" style="text-align: center;">Order No</th>                            
                                    <th width="30%" style="text-align: center;">LOF Reviews</th>                            
                                    <th style="text-align: center;">Status</th>                            
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                        <br/>
                        <br/>
                        <table border="0" width="100%" id="labelData" class="table table-hover">
                            <thead>
                                <tr >
                                    <th style="text-align: center;">Reference</th>                            
                                    <th style="text-align: center;">View</th>                         
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>


                    <!-- Table -->

                    <div class="panel-footer">
                        <div class="row" id="reviewCtrl">
                            <div class="col-lg-3">
                                <form>
                                    <input type="hidden" name="orderid" id="orderid" value="" />
                                </form>
                                <a class="btn btn-primary" id="print_id" style="width: 100%;">Print</a>
                                <!--<input type="button" id="btnView" value="Print" class="btn btn-primary" onclick="viewOrder();" style="width: 100%;"/>-->
                            </div>
                            <div class="col-lg-3">
                                <input type="button" id="btnView" value="View Order" class="btn btn-primary" onclick="viewOrder();" style="width: 100%;"/></div>
                            <div class="col-lg-3">
                                <input type="button" id="btnArtwork" value="Request Artwork" class="btn btn-primary" onclick="artWork();" style="width: 100%;"/></div>
                            <div class="col-lg-3">
                                <input type="button" value="Edit" class="btn btn-primary" onclick="editOrder();" style="width: 100%;"/>
                                <!--<div class="btn-group pull-left"  >-->
                                <!--<span class="btn btn-primary" >Edit</span>-->
                                <!--<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" onclick="editOrder();">-->
                                <!--                                        <span class="caret"></span>
                                                                        <span class="sr-only">Edit</span>-->
                                <!--</button>-->
                                <!--                                    <ul class="dropdown-menu">
                                                                        <li><a href='javascript:viewArtwork()'>Preview Artwork</a></li>
                                                                        <li><a href='javascript:editOrder()'>Using Selected Order</a></li>
                                                                    </ul>-->
                                <!--</div>-->
                            </div>
                        </div>
                        <div class="row" style="padding: 10px;">
                            <center><a id="imgURL" target="_blank" ><img id="artView" name="artView" class="img-responsive" /></a></center>
                        </div>
                    </div>
                </div>
            </div>
            <!--            <div class="row">
                            <iframe src="http://docs.google.com/gview?url=/IEPTescoNew/preview/web/order/FFz57zM9049G__38/Main_clip.pdf" style="width:100%; height:500px;" frameborder="0"></iframe>
                        </div>-->

        </div>
    </div>
</div>

<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog" style="width: 80%;">

        <!-- Modal content-->
        <div class="modal-content" style="width: 95%;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Order Details</h4>
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
                                        <table class="table table-bordered table-hover table-striped" id="genw" >
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

<div id="Searching_Modal" class="modal fade" tabindex="-1" role="dialog" data-keyboard="false"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="text-align: center">
                <h3>Requesting Artwork, Please Wait.....</h3>
            </div>
            <div class="modal-body" >
                <div style="height:200px; padding-top: 10px;">
                    <center><img id="searching_spinner_center" src="img/loading_spinner.gif"/></center>
                </div>
            </div>
            <div class="modal-footer" style="text-align: center"></div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(document).ready(function () {
        document.getElementById("btnArtwork").disabled = true;
        $("#cmb_poNo").bind('input', function () {
            var temp = document.getElementById("cmb_poNo").value;
            var data = temp + "@@@purchaseorder";
            console.log(temp + " && " + data);
            getLofData(data);
            document.getElementById("cmb_webNo").selectedIndex = 0;
            document.getElementById("cmb_styNo").selectedIndex = 0;
            document.getElementById("cmb_cusNo").selectedIndex = 0;
        });
        $("#cmb_webNo").bind('input', function () {
            var temp = document.getElementById("cmb_webNo").value;
            var data = temp + "@@@weborder";
            console.log(temp + " && " + data);
            getLofData(data);
            document.getElementById("cmb_poNo").selectedIndex = 0;
            document.getElementById("cmb_styNo").selectedIndex = 0;
            document.getElementById("cmb_cusNo").selectedIndex = 0;
        });
        $("#cmb_styNo").bind('input', function () {
            var temp = document.getElementById("cmb_styNo").value;
            var data = temp + "@@@stylenumber";
            console.log(temp + " && " + data);
            getLofData(data);
            document.getElementById("cmb_poNo").selectedIndex = 0;
            document.getElementById("cmb_webNo").selectedIndex = 0;
            document.getElementById("cmb_cusNo").selectedIndex = 0;
        });
        $("#cmb_cusNo").bind('input', function () {
            var temp = document.getElementById("cmb_cusNo").value;
            var data = temp + "@@@customernumber";
            console.log(temp + " && " + data);
            getLofData(data);
            document.getElementById("cmb_poNo").selectedIndex = 0;
            document.getElementById("cmb_webNo").selectedIndex = 0;
            document.getElementById("cmb_styNo").selectedIndex = 0;
        });
    });
    function artWork() {
        var btnTitle = document.getElementById("btnArtwork").value;
        var orderiid = document.getElementById("orderid").value;
        if (btnTitle === "Request Artwork") {
            requestArtWork(orderiid);
        } else if (btnTitle === "View Artwork") {
            previewArtwork(orderiid);
        }
    }

    function getCourseFee(id) {
        $("#genw tbody").empty();
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
                            status = "Order Processing is Holded temporarily until the Confirm Order";
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
                        var tcell11 = rowtec.insertCell(10);
                        var tcell12 = rowtec.insertCell(11);
                        var tcell13 = rowtec.insertCell(12);
                        tcell1.innerHTML = parsedDatatec[c].PLabel;
                        tcell2.innerHTML = parsedDatatec[c].Reference;
                        tcell3.innerHTML = parsedDatatec[c].Address;
                        tcell4.innerHTML = parsedDatatec[c].Care_Text;
                        tcell5.innerHTML = parsedDatatec[c].Wash_Symbol;
                        tcell6.innerHTML = parsedDatatec[c].Fibre_Composition_1;
                        tcell7.innerHTML = parsedDatatec[c].Fibre_Composition_2;
                        tcell8.innerHTML = parsedDatatec[c].Fibre_Composition_3;
                        tcell9.innerHTML = parsedDatatec[c].Fibre_Composition_4;
                        tcell10.innerHTML = parsedDatatec[c].Fibre_Composition_5;
                        tcell11.innerHTML = parsedDatatec[c].Fibre_Composition_6;
                        tcell12.innerHTML = parsedDatatec[c].PGroup;
                        tcell13.innerHTML = parsedDatatec[c].Description;
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

    function viewOrder() {
        var orderID = document.getElementById("orderid").value;
        getCourseFee(orderID);
        $('#myModal').modal('show');
    }

    function editOrder() {

        var order = document.getElementById("orderid").value.trim();
        var tForm = document.createElement("form");
        tForm.method = "post";
        tForm.action = "editLofDetails.jsp";
        var hidden = document.createElement("input");
        hidden.value = order;
        hidden.type = "hidden";
        hidden.name = "orderid";
        tForm.appendChild(hidden);
        tForm.submit();
    }

    function viewArtwork() {

        var order = document.getElementById("orderid").value.trim();
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {

            }
        };
        xmlHttp.open("POST", "PreviewController?orderno=" + order, true);
        xmlHttp.send();
    }

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

<script type="text/javascript">
    $(document).ready(function () {
        $("#reviewCtrl").hide();
        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem5").addClass("active");
    });</script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#type_po").hide();
        $("#type_orms").hide();
        $("#cmbDocType").on('change', function () {
            var out = document.getElementById("cmbDocType").selectedIndex;
            if (out === 1) {

                $("#type_po").show();
                $("#type_orms").hide();
                document.getElementById("po_type").innerHTML = "PO";
            }
            if (out === 2) {
                $("#type_po").hide();
                $("#type_orms").show();
                document.getElementById("po_type").innerHTML = "ORMS";
            }
        });
    });
</script>

<%@include file="include/footer.jsp"%>
<% } else {
        response.sendRedirect("LogoutController");
    }%>