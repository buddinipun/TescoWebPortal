<%-- 
    Document   : orderTracking
    Created on : Jul 21, 2015, 11:35:25 AM
    Author     : Lakmal
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

<%
    SysUser user = (SysUser) session.getAttribute("user");
    String company = user.getCompanyId().getCompanyName().trim();
%>

<header>
    <%@include file="include/sideMenu.jsp"%>
    <div class="row" >
        <div class="container-fluid" style="position: fixed; right: 0; left: 0; margin-left: auto; margin-right: auto;   ">
            <!--<center>-->
            <nav style=" z-index: 999999999; margin-top: 20px" class="pull-right" >
                <ul class="pagination" style="margin: 0px; z-index: 999999999;" >
                    <li name="tabs" id="tab_1">
                        <span>Search Method 1<span class="sr-only"></span></span>
                    </li>
                    <li name="tabs" id="tab_2">
                        <span>Search Method 2<span class="sr-only"></span></span>
                    </li>
                </ul>
            </nav>
            <!--            </center>-->
        </div>
    </div>
</header>
<script>
    $(document).ready(function () {
        document.getElementById("btnArtwork").disabled = true;
        $("#container1").show();
        $("#container2").hide();

    });
    $(document).on("click", "li[name=tabs]", function () {
        var tab_id = this.id;
        if (tab_id === "tab_1") {
            $("#container1").show();
            $("#container2").hide();
//            tab0_next();
        } else if (tab_id === "tab_2") {
            $("#container1").hide();
            $("#container2").show();
//            tab1_next();
        }
    });

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
</script>
<script type="text/javascript">
    function artWork() {

        var btnTitle = document.getElementById("btnArtwork").value;
        var orderiid = document.getElementById("orderid").value;
        if (btnTitle === "Request Artwork") {
//            alert("Requesting Artwork is currently unavailable. Disable by developing team.");
            requestArtWork(orderiid);
        } else if (btnTitle === "View Artwork") {
            previewArtwork(orderiid);
        }
    }

    function getCourseFee1(id) {
        $("#genww1 tbody").empty();
        $("#tecww1 tbody").empty();
        $("#eanww1 tbody").empty();
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

                    var tablegen = document.getElementById("gendata1");

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

                    var status = parsedDatagen.conf_order;
                    if (status !== null) {
                        if (status === "NAR") {
                            status = "Not Requested";
                        } else if (status === "AR") {
                            status = "Artwork is Pending";
                        } else if (status === "ARS") {
                            status = "Artwork is Received";
                        } else if (status === "CONA") {
                            status = "Order is confirmed";
                        } else if (status === "NARCONA") {
                            status = "Artwork is Not Requested Confirmed";
                        } else if (status === "ARCONA") {
                            status = "Artwork Requested Confirmed";
                        } else if (status === "ARSCONA") {
                            status = "Artwork Requested Submitted Confirmed";
                        } else if (status === "DEL") {
                            status = "Order is delivered";
                        } else if (status === "ASNC") {
                            status = "";
                        } else if (status === "UPD") {
                            status = "Order not complete";
                        } else {
                            status = "Artwork is Error";
                        }
                    }

                    gcell142.innerHTML = status;


                }
                var parsedDatatec = JSON.parse(res[1]);
                var c = 0;

                if (parsedDatatec.constructor === Array) {

                    var tabletc = document.getElementById("tecdata1");
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
                var table = document.getElementById("eandata1");
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
        getCourseFee1(orderID);
        $('#myModal1').modal('show');
    }

    function updateOrder() {
        var orderID = document.getElementById("orderid").value;
        $('#updateOrder').modal('show');
//        document.getElementById("modelId").innerHTML = orderID;
    }

    function editOrder() {

        var order = document.getElementById("orderid").value.trim();
//        alert(order + "Order id");
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

</script>
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

    function getLofData(data) {
        document.getElementById("artView").src = "";
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

<div id="page-wrapper">
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row">
            <div class="col-lg-4">
                <h2><!--<h2 class="page-header">-->
                    Track the Order
                </h2>
            </div>
        </div>
        <div class="row" id="container1">
            <div class="col-lg-10 col-lg-offset-1" style="top: 25px;">
                <div class="row">
                    <div class="col-lg-6">
                        <table border="0" class="table" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                                <tr>
                                    <td width="25%">User</td>
                                    <td>
                                        <input type="text" class="form-control" value="<%=user.getUsername()%>" id="c_name" name="c_name" readonly/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>From : </td>
                                    <td>
                                        <input type="date" class="form-control" id="fromDate" name="fromDate"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type="submit" class="btn btn-primary pull-right"  name="web_order_no" value="Search" onclick="getByDate();"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>                                    
                    <div class="col-lg-6">
                        <table border="0" class="table" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                                <tr>
                                    <td width="25%">User</td>
                                    <td>
                                        <%if (user3.getUserType().getUserType() == 1 || user3.getUserType().getUserType() == 5) {%>

                                        <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                            SELECT * FROM sys_user WHERE company_id='<%= user3.getCompanyId().getCompanyId()%>';                                        
                                        </sql:query>

                                        <select  name="userEmail" id="userEmail" class="form-control" onchange="getDetailsUser();">

                                            <option  selected value="0" > - All - </option>

                                            <c:forEach var="row9" items="${idQ9.rows}"> 
                                                <option value="${row9.email_address}">${row9.email_address}</option>
                                            </c:forEach>
                                        </select> 

                                        <%} else {%>
                                        <select  name="userEmail" id="userEmail" class="form-control" disabled>
                                            <option  selected value="0" > - All - </option>
                                        </select>

                                        <%}%>
                                    </td>
                                </tr>
                                <tr >
                                    <td>To : </td>
                                    <td>
                                        <input type="date" class="form-control" id="toDate" name="toDate"/>  
                                    </td>
                                </tr>
                            </tbody>
                        </table> 
                    </div>
                </div>

                <div class="row">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">&nbsp;<div id="title" style="font-weight: bolder; " >Details</div></h3>
                        </div>
                        <div class="panel-body" id="orderTrack" style="overflow-y: auto; height: 250px;">
                            <div class="table-responsive">
                                <table border="0" class="table table-hover" id="tbl_orderTracking" >
                                    <thead>
                                        <tr>
                                            <th bgcolor="#EFEFEF" >No</th>
                                            <th bgcolor="#EFEFEF" >Web Order No</th>
                                            <th bgcolor="#EFEFEF" >Lof Data</th>
                                            <th bgcolor="#EFEFEF" >Order ID</th>
                                            <th bgcolor="#EFEFEF" >Purchase Order</th>
                                            <th bgcolor="#EFEFEF" >Factory Code</th>
                                            <th bgcolor="#EFEFEF" >Order Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div> 
                </div>
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

                <!--================================================================================================ /.row -->

                <!-- /.row -->

            </div>


        </div>
        <div class="container-fluid" style="margin-top: 45px;" id="container2">
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
                                        SELECT DISTINCT l.purchase_order_uk FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;
                                    </sql:query>
                                    <%} else if (user3.getUserType().getUserType() == 2) {%>
                                    <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                        SELECT DISTINCT l.purchase_order_uk FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.username='<%=user3.getUsername()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;
                                    </sql:query>
                                    <%} else if (user3.getUserType().getUserType() == 5) {%>
                                    <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                        SELECT DISTINCT l.purchase_order_uk FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;
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
                                        SELECT DISTINCT l.id FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;
                                    </sql:query>
                                    <%} else if (user3.getUserType().getUserType() == 2) {%>
                                    <sql:query var="idQ10"  dataSource="jdbc/sdb">
                                        SELECT DISTINCT l.id FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id WHERE c.username='<%=user3.getUsername()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;

                                    </sql:query>
                                    <%} else if (user3.getUserType().getUserType() == 5) {%>
                                    <sql:query var="idQ10"  dataSource="jdbc/sdb">
                                        SELECT DISTINCT l.id FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;
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
                                        SELECT DISTINCT `l`.`style_no_uk` FROM `lof_generaldata` l JOIN `customer`  c ON `l`.`customer`=`c`.`customer_id` JOIN `sys_user`  s ON `s`.`username` = `c`.`username` WHERE `s`.`company_id`='<%=user3.getCompanyId().getCompanyId()%>' AND `l`.`conf_order` NOT IN ('UPD') ORDER BY l.ordered_date DESC;
                                    </sql:query>
                                    <%} else if (user3.getUserType().getUserType() == 2) {%>
                                    <sql:query var="idQ11"  dataSource="jdbc/sdb">
                                        SELECT DISTINCT l.style_no_uk FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.username='<%=user3.getUsername()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;
                                    </sql:query>
                                    <%} else if (user3.getUserType().getUserType() == 5) {%>
                                    <sql:query var="idQ11"  dataSource="jdbc/sdb">                                            
                                        SELECT DISTINCT `l`.`style_no_uk` FROM `lof_generaldata` l JOIN `customer`  c ON `l`.`customer`=`c`.`customer_id` JOIN `sys_user`  s ON `s`.`username` = `c`.`username` WHERE `s`.`company_id`='<%=user3.getCompanyId().getCompanyId()%>' AND `l`.`conf_order` NOT IN ('UPD') ORDER BY l.ordered_date DESC;
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
                                        SELECT DISTINCT l.customer_po FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;
                                    </sql:query>
                                    <%} else if (user3.getUserType().getUserType() == 2) {%>
                                    <sql:query var="idQ12"  dataSource="jdbc/sdb">
                                        SELECT DISTINCT l.customer_po FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.username='<%=user3.getUsername()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;
                                    </sql:query>
                                    <%} else if (user3.getUserType().getUserType() == 5) {%>
                                    <sql:query var="idQ12"  dataSource="jdbc/sdb">
                                        SELECT DISTINCT l.customer_po FROM lof_generaldata l JOIN customer  c ON l.customer=c.customer_id JOIN sys_user  s ON s.username = c.username WHERE s.company_id='<%=user3.getCompanyId().getCompanyId()%>' AND l.conf_order NOT IN ('UPD') ORDER BY l.ordered_date DESC;
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
                <tbody style="text-align: center;">

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
                <tbody style="text-align: center;">

                </tbody>
            </table>
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

                    </div>
                </div>
                <div class="row" style="padding: 10px;">
                    <center><a id="imgURL" target="_blank" ><img id="artView" name="artView" class="img-responsive" /></a></center>
                </div>
            </div>
            <div id="myModal1" class="modal fade" role="dialog">
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
                                                    <table class="table table-bordered table-hover table-striped" id="genww1" >
                                                        <thead>
                                                            <tr>
                                                                <th bgcolor="#EFEFEF" >Key Field</th>
                                                                <th bgcolor="#EFEFEF">Value</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="gendata1">

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
                                                    <table class="table table-bordered table-hover table-striped" id="tecww1" >
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
                                                        <tbody id="tecdata1">

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
                                                    <table class="table table-bordered table-hover table-striped" id="eanww1" >
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
                                                        <tbody id="eandata1">

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
            <!--            <div id="myModal" class="modal fade" role="dialog">
                            <div class="modal-dialog" style="width: 80%;">
            
                                 Modal content
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
                        </div>-->
        </div><!--container2-->
    </div>

</div>
<!-- /.container-fluid -->

<!-- /#page-wrapper -->

<script type="text/javascript">
    //This is new javascript 2015-08-03

    $(document).on('click', '#tbl_orderTracking  tbody tr', function () {
//        getCourseFee($(this).find('td:nth-child(3)').text().trim());
//        $('#myModal').modal('show');
    });



    function getCourseFee(id) {
        $("#genww tbody").empty();
        $("#tecww tbody").empty();
        $("#eanww tbody").empty();
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var res = xmlHttp.responseText.split("#");

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
                    var gcell102 = rowgen10.insertCell(1);
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
                    gcell101.innerHTML = "Department";
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
                    gcell102.innerHTML = parsedDatagen.department;
                    gcell112.innerHTML = parsedDatagen.supplier_no;
                    gcell122.innerHTML = parsedDatagen.factory_code;
                    gcell132.innerHTML = parsedDatagen.lof_data;
                    gcell142.innerHTML = parsedDatagen.conf_order;


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
                //alert(parsedData);
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

    function getAllDetails() {
        document.getElementById("title").innerHTML = "Details";
        $("#tbl_orderTracking tbody").empty();
        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var y = reply.length;
                var tbl = document.getElementById('tbl_orderTracking').getElementsByTagName('tbody')[0];
                for (var j = 0; j < y; j++) {
//                for (var j = (y-1); j >= y; j--) {
                    var row = document.createElement("tr");
                    row.id = j;

                    var lineNo = document.createElement("td");
                    lineNo.innerHTML = j + 1;

                    var webOder = document.createElement("td");
                    webOder.innerHTML = reply[j].web_order_no;

                    var idOnline = document.createElement("td");
                    idOnline.innerHTML = reply[j].id;

                    var purchase_order = document.createElement("td");
                    purchase_order.innerHTML = reply[j].purchase_order;

                    var factory_code = document.createElement("td");
                    factory_code.innerHTML = reply[j].factory_code;

                    var conf_order = document.createElement("td");

                    var lof_data = document.createElement("td");
                    lof_data.innerHTML = reply[j].lof_data;


                    var status = reply[j].conf_order;
                    if (status !== null) {
                        if (status === "NAR") {
                            status = "Not Requested";
                        } else if (status === "AR") {
                            status = "Artwork is Pending";
                        } else if (status === "ARS") {
                            status = "Artwork is Received";
                        } else if (status === "CONA") {
                            status = "Order is confirmed";
                        } else if (status === "NARCONA") {
                            status = "Artwork is Not Requested Confirmed";
                        } else if (status === "ARCONA") {
                            status = "Artwork Requested Confirmed";
                        } else if (status === "ARSCONA") {
                            status = "Artwork Requested Submitted Confirmed";
                        } else if (status === "DEL") {
                            status = "Order is delivered";
                        } else if (status === "ASNC") {
                            status = "";
                        } else if (status === "UPD") {
                            status = "Order not complete";
                        } else {
                            status = "Artwork is Error";
                        }
                    }
                    conf_order.innerHTML = status;
                    row.appendChild(lineNo);
                    row.appendChild(webOder);
                    row.appendChild(lof_data);
                    row.appendChild(idOnline);
                    row.appendChild(purchase_order);
                    row.appendChild(factory_code);
                    row.appendChild(conf_order);

                    tbl.appendChild(row);
                }

            }
        };

        xmlHttp.open("POST", "ForTrackingController?method=getAlldetails", true);
        xmlHttp.send();
    }

    function getByDate() {
        var user = document.getElementById("userEmail").value;
        var fromDate = document.getElementById("fromDate").value;
        var toDate = document.getElementById("toDate").value;

        if (fromDate === null || fromDate === "" || toDate === null || toDate === "") {
            sm_alert("Please select date range.");
            return;
        }


        var data = {};
        data["user"] = user;
        data["fromDate"] = fromDate;
        data["toDate"] = toDate;

        document.getElementById("title").innerHTML = "Details &nbsp;&nbsp;&nbsp; From : " + fromDate + "&nbsp;  &nbsp; To : " + toDate

        var jData = JSON.stringify(data);

        $("#tbl_orderTracking tbody").empty();
        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var y = reply.length;
                var tbl = document.getElementById('tbl_orderTracking').getElementsByTagName('tbody')[0];
                for (var j = 0; j < y; j++) {
                    var row = document.createElement("tr");
                    row.id = j;

                    var lineNo = document.createElement("td");
                    lineNo.innerHTML = j + 1;

                    var webOder = document.createElement("td");
                    webOder.innerHTML = reply[j].web_order_no;

                    var idOnline = document.createElement("td");
                    idOnline.innerHTML = reply[j].id;

                    var purchase_order = document.createElement("td");
                    purchase_order.innerHTML = reply[j].purchase_order;

                    var factory_code = document.createElement("td");
                    factory_code.innerHTML = reply[j].factory_code;

                    var conf_order = document.createElement("td");

                    var lof_data = document.createElement("td");
                    lof_data.innerHTML = reply[j].lof_data;


                    var status = reply[j].conf_order;
                    if (status !== null) {
                        if (status === "NAR") {
                            status = "Not Requested";
                        } else if (status === "AR") {
                            status = "Artwork is Pending";
                        } else if (status === "ARS") {
                            status = "Artwork is Received";
                        } else if (status === "CONA") {
                            status = "Order is confirmed";
                        } else if (status === "NARCONA") {
                            status = "Artwork is Not Requested Confirmed";
                        } else if (status === "ARCONA") {
                            status = "Artwork Requested Confirmed";
                        } else if (status === "ARSCONA") {
                            status = "Artwork Requested Submitted Confirmed";
                        } else if (status === "DEL") {
                            status = "Order is delivered";
                        } else if (status === "ASNC") {
                            status = "";
                        } else if (status === "UPD") {
                            status = "Order not complete";
                        } else {
                            status = "Artwork is Error";
                        }
                    }
                    conf_order.innerHTML = status;
                    row.appendChild(lineNo);
                    row.appendChild(webOder);
                    row.appendChild(lof_data);
                    row.appendChild(idOnline);
                    row.appendChild(purchase_order);
                    row.appendChild(factory_code);
                    row.appendChild(conf_order);

                    tbl.appendChild(row);
                }

            }
        };

        xmlHttp.open("POST", "ForTrackingController?method=getByDate&data=" + jData, true);
        xmlHttp.send();
    }

    function getDetailsUser() {

        document.getElementById("title").innerHTML = "Details";

        var user = document.getElementById("userEmail").value;

        var fromDate = document.getElementById("fromDate").value = "";
        var toDate = document.getElementById("toDate").value = "";
        if (user == "0") {
            getAllDetails();
            return;
        }



        $("#tbl_orderTracking tbody").empty();


        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var y = reply.length;
                var tbl = document.getElementById('tbl_orderTracking').getElementsByTagName('tbody')[0];
                for (var j = 0; j < y; j++) {
                    var row = document.createElement("tr");
                    row.id = j;

                    var lineNo = document.createElement("td");
                    lineNo.innerHTML = j + 1;

                    var webOder = document.createElement("td");
                    webOder.innerHTML = reply[j].web_order_no;

                    var idOnline = document.createElement("td");
                    idOnline.innerHTML = reply[j].id;

                    var purchase_order = document.createElement("td");
                    purchase_order.innerHTML = reply[j].purchase_order;

                    var factory_code = document.createElement("td");
                    factory_code.innerHTML = reply[j].factory_code;

                    var conf_order = document.createElement("td");
                    var lof_data = document.createElement("td");
                    lof_data.innerHTML = reply[j].lof_data;


                    var status = reply[j].conf_order;
                    if (status !== null) {
                        if (status === "NAR") {
                            status = "Not Requested";
                        } else if (status === "AR") {
                            status = "Artwork is Pending";
                        } else if (status === "ARS") {
                            status = "Artwork is Received";
                        } else if (status === "CONA") {
                            status = "Order is confirmed";
                        } else if (status === "NARCONA") {
                            status = "Artwork is Not Requested Confirmed";
                        } else if (status === "ARCONA") {
                            status = "Artwork Requested Confirmed";
                        } else if (status === "ARSCONA") {
                            status = "Artwork Requested Submitted Confirmed";
                        } else if (status === "DEL") {
                            status = "Order is delivered";
                        } else if (status === "ASNC") {
                            status = "";
                        } else if (status === "UPD") {
                            status = "Order not complete";
                        } else {
                            status = "Artwork is Error";
                        }
                    }
                    conf_order.innerHTML = status;
                    row.appendChild(lineNo);
                    row.appendChild(webOder);
                    row.appendChild(lof_data);
                    row.appendChild(idOnline);
                    row.appendChild(purchase_order);
                    row.appendChild(factory_code);
                    row.appendChild(conf_order);

                    tbl.appendChild(row);
                }

            }
        };

        xmlHttp.open("POST", "ForTrackingController?method=getDetailsUser&user=" + user, true);
        xmlHttp.send();
    }

    function clear() {
        var user = document.getElementById("userEmail").selectedIndex = 0;
        var fromDate = document.getElementById("fromDate").value = "";
        var toDate = document.getElementById("toDate").value = "";
        getAllDetails();
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

    function getLofData(data) {

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
                                status = "Not Requested";
                                col2.innerHTML = status;
                                col2.style.color = "#FF0000";
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
                            }
                            else if (status === "UPD") {
                                status = "Order not Submited";
                                col2.innerHTML = status;
                                col2.style.color = "#993333";
                            } 
                            else if (status === "ARS") {
                                status = "Artwork Received";
                                col2.innerHTML = status;
                                col2.style.color = "#218221";
                            } 
                            else if (status === "NARCONA") {
                                status = "Not Artwork Requested Confirmed";
                                col2.innerHTML = status;
                                col2.style.color = "#993333";
                            } 
                            else if (status === "ARCONA") {
                                status = "Artwork Requested Confirmed";
                                col2.innerHTML = status;
                                col2.style.color = "#993333";
                            } 
                            else {
                                status = "Artwork is Error";
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
</script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#reviewCtrl").hide();

        $('input[name=search]').on("click", function () {
            var elem = this.id;
            document.getElementById("cmb_poNo").value = "";
            document.getElementById("cmb_webNo").value = "";
            document.getElementById("cmb_styNo").value = "";
            document.getElementById("cmb_cusNo").value = "";
            if (elem === "cmb_poNo") {
                document.getElementById("cmb_poNo").readOnly = false;
                document.getElementById("cmb_webNo").readOnly = true;
                document.getElementById("cmb_styNo").readOnly = true;
                document.getElementById("cmb_cusNo").readOnly = true;
            } else if (elem === "cmb_webNo") {
                document.getElementById("cmb_poNo").readOnly = true;
                document.getElementById("cmb_webNo").readOnly = false;
                document.getElementById("cmb_styNo").readOnly = true;
                document.getElementById("cmb_cusNo").readOnly = true;
            } else if (elem === "cmb_styNo") {
                document.getElementById("cmb_poNo").readOnly = true;
                document.getElementById("cmb_webNo").readOnly = true;
                document.getElementById("cmb_styNo").readOnly = false;
                document.getElementById("cmb_cusNo").readOnly = true;
            } else if (elem === "cmb_cusNo") {
                document.getElementById("cmb_poNo").readOnly = true;
                document.getElementById("cmb_webNo").readOnly = true;
                document.getElementById("cmb_styNo").readOnly = true;
                document.getElementById("cmb_cusNo").readOnly = false;
            }
        });

        $("#cmb_poNo").bind('input', function () {
            var temp = document.getElementById("cmb_poNo").value;
            var data = temp + "@@@purchaseorder";
            console.log(temp + " && " + data);
            getLofData(data);
        });

        $("#cmb_webNo").bind('input', function () {
            var temp = document.getElementById("cmb_webNo").value;
            var data = temp + "@@@weborder";
            console.log(temp + " && " + data);
            getLofData(data);
        });

        $("#cmb_styNo").bind('input', function () {
            var temp = document.getElementById("cmb_styNo").value;
            var data = temp + "@@@stylenumber";
            console.log(temp + " && " + data);
            getLofData(data);
        });

        $("#cmb_cusNo").bind('input', function () {
            var temp = document.getElementById("cmb_cusNo").value;
            var data = temp + "@@@customernumber";
            console.log(temp + " && " + data);
            getLofData(data);
        });

        //getAllDetails();
        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem4").addClass("active");
    });
</script>
<%@include file="include/footer.jsp"%>
<% } else {

        response.sendRedirect("LogoutController");
    }%>