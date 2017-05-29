<%-- 
    Document   : copy_forgot
    Created on : Jul 5, 2015, 3:36:24 PM
    Author     : oshan
--%>

<%@include file="include/header.jsp"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%    SysUser user3 = (SysUser) session.getAttribute("user");
    if (user3 != null) {
%>

<sql:query var="idQ2"  dataSource="jdbc/sdb">
    SELECT * FROM sys_user_menu_item WHERE username='<%=user3.getUsername()%>';
</sql:query>

<c:set var="condition" value="false"/>
<c:forEach items="${idQ2.rows}" var="row2">
    <c:choose>
        <c:when test="${row2.menu_item==4}">
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

<%@include file="include/sideMenu.jsp"%>

<style type="text/css">
    tr.highlighted td{
        background:  #999999;
    }
</style>



<div id="page-wrapper">

    <div class="container-fluid">
        <br/>
        <div class="row">
            <div class="col-lg-10 col-lg-offset-1">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong>Order Panel</strong>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <%if (user3.getUserType().getUserType() == 1) {%>

                                    <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                        SELECT DISTINCT(id) FROM `lof_generaldata` WHERE conf_order IN ('NAR','AR','ARS') AND `customer` IN (SELECT `customer` FROM `sys_user` WHERE `company_id` = '<%= user3.getCompanyId().getCompanyId()%>') ORDER BY ordered_date DESC;
                                    </sql:query>

                                    <select  name="lof" id="lof" class="form-control" onchange="getIDs();">

                                        <option  selected disabled="true"> - Select Order - </option>
                                        <c:forEach var="row9" items="${idQ9.rows}"> 
                                            <option value="${row9.id}">${row9.id}</option>
                                        </c:forEach>

                                    </select> 

                                    <%} else {%>

                                    <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                        SELECT DISTINCT(id) FROM `lof_generaldata` WHERE conf_order IN ('NAR','AR','ARS') AND `customer` IN (SELECT `customer_id` FROM `customer` WHERE `username` = '<%= user3.getUsername()%>') ORDER BY ordered_date DESC;
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
                            <div class="col-lg-2 col-md-2 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <button id="btn_orderview" class="btn btn-warning" style="width: 100%;" disabled onclick="viewOrder();" >Edit Order</button>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <button id="btn_artwork" class="btn btn-info" style="width: 100%;" disabled onclick="artWork();">View Artwork</button>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <button id="btn_confirm" class="btn btn-success" style="width: 100%;" onclick="confirmOrder();" disabled>Confirm</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="raw">
            <div class="col-lg-8 col-md-8 col-lg-offset-2 col-md-offset-2">
                <table border="0" width="100%" id="lofData" class="table table-hover">
                    <thead>
                        <tr >
                            <th bgcolor="#EFEFEF">#</th>                            
                            <th bgcolor="#EFEFEF">Lof ID</th>                            
                            <th colspan="2"  bgcolor="#EFEFEF">Status</th>                            
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4">
                                <div class="row" style="padding: 10px;">
                                    <center><a id="imgURL" target="_blank" ><img id="artView" name="artView" class="img-responsive" /></a></center>
                                </div>
                            </td>
                        </tr>
                    </tfoot>
                </table>
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
                                        <h3 class="panel-title">Technical Labels</h3>
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
                    <h3>Please Wait...</h3>
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
            $("#menuItem1").removeClass("active");
            $("#menuItem2").removeClass("active");
            $("#menuItem3").removeClass("active");
            $("#menuItem4").removeClass("active");
            $("#menuItem5").removeClass("active");
            $("#menuItem6").removeClass("active");
            $("#menuItem7").removeClass("active");
            $("#menuItem12").removeClass("active");
            $("#menuItem12").addClass("active");
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
                type: BootstrapDialog.TYPE_WARNING, message: text,
                size: BootstrapDialog.SIZE_NORMAL
            });
        }
    </script>

    <script type="text/javascript">
        document.title = "Order Confirm | E-Platform"
    </script>

    <script type="text/javascript">

        function previewArtwork(data) {

            var id = document.getElementById("artView");


            var xmlHttp = getAjaxObject();

            xmlHttp.onreadystatechange = function ()
            {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                {
                    var reply = eval('(' + xmlHttp.responseText + ')');
                    if (reply.result === undefined) {
                        id.src = "artwork/NoImage.jpg";
                    } else {
                        document.getElementById("imgURL").href = "artwork/" + data + ".png";
                        id.src = "artwork/" + data + ".png";
                    }
                }
            };

            xmlHttp.open("POST", "RequestAwController?actionType=checkArtwork&id=" + data, true);
            xmlHttp.send();

        }

        function viewOrder() {
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

        //        function viewArtwork() {
        //            var orderID = document.getElementById("orderid").value;
        //            previewArtwork(orderID);
        //        }
        function artWork() {

            var btnTitle = document.getElementById("btn_artwork").innerHTML;
            var orderiid = document.getElementById("orderid").value;
            if (btnTitle === "Request") {
                //            alert("Requesting Artwork is currently unavailable. Disable by developing team.");
                requestArtWork(orderiid);
            } else if (btnTitle === "View Artwork") {
                previewArtwork(orderiid);
            }
        }
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

        function getCourseFee(id) {
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
                        //                        var rowgen10 = tablegen.insertRow(9);
                        var rowgen11 = tablegen.insertRow(10);
                        var rowgen12 = tablegen.insertRow(11);
                        var rowgen13 = tablegen.insertRow(12);
                        var rowgen14 = tablegen.insertRow(13);

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
                        var gcell101 = rowgen10.insertCell(0);
                        //                        var gcell102 = rowgen10.insertCell(1);
                        var gcell111 = rowgen11.insertCell(0);
                        var gcell112 = rowgen11.insertCell(1);
                        var gcell121 = rowgen12.insertCell(0);
                        var gcell122 = rowgen12.insertCell(1);
                        var gcell131 = rowgen13.insertCell(0);
                        var gcell132 = rowgen13.insertCell(1);
                        var gcell141 = rowgen14.insertCell(0);
                        var gcell142 = rowgen14.insertCell(1);

                        gcell11.innerHTML = "Purchase Order";
                        gcell21.innerHTML = "Category";
                        gcell31.innerHTML = "Countryof Origin";
                        gcell41.innerHTML = "Additional Comment";
                        gcell51.innerHTML = "Style No";
                        gcell61.innerHTML = "Charactor of Description";
                        gcell71.innerHTML = "Season Code";
                        gcell81.innerHTML = "Brand";
                        gcell91.innerHTML = "Style Type";
                        //                        gcell101.innerHTML = "Department";
                        gcell111.innerHTML = "Supplier No";
                        gcell121.innerHTML = "Factory Code";
                        gcell131.innerHTML = "Lof No";
                        gcell141.innerHTML = "Confirm Order";

                        gcell12.innerHTML = parsedDatagen.purchase_order;
                        gcell22.innerHTML = parsedDatagen.category;
                        gcell32.innerHTML = parsedDatagen.country_of_origin;
                        gcell42.innerHTML = parsedDatagen.additional_comment;
                        gcell52.innerHTML = parsedDatagen.style_no;
                        gcell62.innerHTML = parsedDatagen.charactor_tf_des;
                        gcell72.innerHTML = parsedDatagen.season_code;
                        gcell82.innerHTML = parsedDatagen.brand;
                        gcell92.innerHTML = parsedDatagen.style_type;
                        //                        gcell102.innerHTML = parsedDatagen.department;
                        gcell112.innerHTML = parsedDatagen.supplier_no;
                        gcell122.innerHTML = parsedDatagen.factory_code;
                        gcell132.innerHTML = parsedDatagen.lof_data;

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
                            } else if (status === "UPD") {
                                status = "Order not complete";
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

        function send_mail() {
            var id = document.getElementById('lof').value;
            var mail = document.getElementById('email').value;
            var path = document.getElementById('path').value;

            var xmlHttp = getAjaxObject();
            xmlHttp.onreadystatechange = function ()
            {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                {
                    var res = xmlHttp.responseText;
                    console.log("line no : 630" + res);
                }
            };
            xmlHttp.open("POST", "Email?id=sendmail&mail=" + mail + "&path=" + path, true);
            xmlHttp.send();
        }

        function createXls() {

            var id = document.getElementById('lof').value;
            var mail = document.getElementById('lof').value;

            document.getElementById('loadingDiv').style.display = "block";

            var xmlHttp = getAjaxObject();
            xmlHttp.onreadystatechange = function ()
            {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                {

                    var res = xmlHttp.responseText;

                    document.getElementById('path').value = res;
                    document.getElementById('loadingDiv').style.display = "none";
                }

            };
            xmlHttp.open("POST", "CreateXls?id=sendmail&mail=" + mail, true);
            xmlHttp.send();
        }

        function myFunction(dataFromServer) {
            var parsedJSON = JSON.parse(dataFromServer);
            for (var i = 0; i < parsedJSON.length; i++) {
                console.log("line no : 630" + parsedJSON[i].EAN_No);
            }
        }

        function hide() {
            document.getElementById("genww").style.display = 'none';
            document.getElementById("tecww").style.display = 'none';
            document.getElementById("swiww").style.display = 'none';
            document.getElementById("eanww").style.display = 'none';
        }
        function show() {
            document.getElementById("genww").style.display = '';
            document.getElementById("tecww").style.display = '';
            document.getElementById("swiww").style.display = '';
            document.getElementById("eanww").style.display = '';
        }
        function cctv() {
            var myTable = document.getElementById("genww");
            var rowCount = myTable.rows.length;
            for (var x = rowCount - 1; x > 0; x--) {
                myTable.deleteRow(x);
            }
            var myTable1 = document.getElementById("tecww");
            var rowCount = myTable1.rows.length;
            for (var x = rowCount - 1; x > 0; x--) {
                myTable1.deleteRow(x);
            }
            var myTable2 = document.getElementById("swiww");
            var rowCount = myTable2.rows.length;
            for (var x = rowCount - 1; x > 0; x--) {
                myTable2.deleteRow(x);
            }
            var myTable3 = document.getElementById("eanww");
            var rowCount = myTable3.rows.length;
            for (var x = rowCount - 1; x > 0; x--) {
                myTable3.deleteRow(x);
            }

            document.getElementById("genww").style.display = 'none';
            document.getElementById("tecww").style.display = 'none';
            document.getElementById("swiww").style.display = 'none';
            document.getElementById("eanww").style.display = 'none';
        }

    </script>

    <script type="text/javascript">

        $(document).on('click', '#lofData  tbody tr', function () {
            $('#lofData tbody tr').removeClass('highlighted');
            $(this).addClass('highlighted');

            var tex = $(this).find('input[type=hidden]').val();
            var sli = tex.split("@@@");
            document.getElementById("orderid").value = sli[0];

            var status = sli[1];
            if (status !== null) {
                document.getElementById("btn_orderview").disabled = false;
                if (status === "NAR") {
                    document.getElementById("btn_artwork").innerHTML = "Request";
                    document.getElementById("btn_artwork").disabled = false;
                    document.getElementById("btn_confirm").disabled = false;
                } else if (status === "AR") {
                    document.getElementById("btn_artwork").disabled = true;
                    document.getElementById("btn_confirm").disabled = false;
                } else if (status === "ARS") {
                    document.getElementById("btn_confirm").disabled = false;
                    document.getElementById("btn_artwork").innerHTML = "View Artwork";
                    document.getElementById("btn_artwork").disabled = false;
                }
                else if (status === "NARCONA") {
                    document.getElementById("btn_confirm").disabled = true;
                    document.getElementById("btn_artwork").innerHTML = "View Artwork";
                    document.getElementById("btn_artwork").disabled = true;
                }
                else if (status === "ARCONA") {
                    document.getElementById("btn_confirm").disabled = true;
                    document.getElementById("btn_artwork").innerHTML = "View Artwork";
                    document.getElementById("btn_artwork").disabled = true;
                }
                else if (status === "ARSCONA") {
                    document.getElementById("btn_confirm").disabled = true;
                    document.getElementById("btn_artwork").innerHTML = "View Artwork";
                    document.getElementById("btn_artwork").disabled = true;
                }
                else if (status === "CONA") {
                    document.getElementById("btn_confirm").disabled = true;
                    document.getElementById("btn_artwork").innerHTML = "View Artwork";
                    document.getElementById("btn_artwork").disabled = true;
                }
            }
            //        getCourseFee($(this).find('td:nth-child(2)').text().trim());
        });
        function confirmOrder() {
            var orderId = document.getElementById('orderid').value;
            BootstrapDialog.confirm({
                title: 'Submit the Order',
                message: 'Do you want to confirm the order?',
                type: BootstrapDialog.TYPE_PRIMARY,
                closable: true,
                draggable: true,
                btnCancelLabel: 'No',
                btnOKLabel: 'Yes',
                callback: function (result) {
                    if (result) {
                        $('#Searching_Modal').modal('show');
                        var lof = document.getElementById("lof").value;
                        var xmlHttp = getAjaxObject();
                        xmlHttp.onreadystatechange = function ()
                        {
                            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                            {
                                var reply = eval('(' + xmlHttp.responseText + ')');
                                $('#Searching_Modal').modal('hide');
                                BootstrapDialog.show({
                                    title: 'Notification',
                                    size: BootstrapDialog.SIZE_SMALL,
                                    type: BootstrapDialog.TYPE_SUCCESS,
                                    message: 'Confirmed Successfully.',
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
                        xmlHttp.open("POST", "ConfirmServlet?method=confirm&&lofno=" + orderId, true);
                        xmlHttp.send();


                    } else {
                        nom_notify("Order has not been Confirmed.");
                    }
                }});

        }

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


                        var row = document.createElement("tr");

                        var col1 = document.createElement("td");
                        col1.innerHTML = a + 1;
                        col1.appendChild(elem2);

                        var col2 = document.createElement("td");
                        col2.innerHTML = lof.lofid;
                        var col3 = document.createElement("td");
                        var col4 = document.createElement("td");

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
                }

            };
            xmlHttp.open("POST", "RequestAwController?actionType=getIdsFormwebOID&po_no=" + po_no, true);
            xmlHttp.send();
        }
    </script>

    <%@include file="include/footer.jsp"%>

    <% } else {
            response.sendRedirect("LogoutController");
        }%>