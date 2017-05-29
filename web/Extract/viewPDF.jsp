<%-- 
    Document   : viewPDF
    Created on : Jul 17, 2015, 8:53:25 AM
    Author     : oshan
--%>

<%@page import="java.io.Console"%>
<%@page import="com.impression.hibe.model.Eannotb"%>
<%@page import="com.impression.dao.PODataDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.impression.dao.UserDAO"%>
<%@page import="com.impression.dao.Check_lof"%>
<%@page import="com.impression.hibe.model.Customer"%>
<%@page import="com.impression.hibe.model.SysUser"%>
<%@page import="com.impression.extractpdf.CommonData"%>
<%@page import="com.impression.hibe.model.Fiber"%>
<%@page import="com.impression.hibe.model.CareText"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="../include/headerInner.jsp"%>
<%@include file="../include/sideMenuInner.jsp"%>


<%    CommonData commonData = (CommonData) request.getSession().getAttribute("commonData");

    PODataDAO pODataDAO = new PODataDAO();
    List<Eannotb> eanSendArray = pODataDAO.getUkAndCeSize(commonData.getEanArr());

    String lofID = (String) request.getSession().getAttribute("lofID");

%>
<%  SysUser user = (SysUser) session.getAttribute("user");

    if (user != null) {
%>



<sql:query var="idQ2"  dataSource="jdbc/sdb">
    SELECT * FROM sys_user_menu_item WHERE username='<%=user.getUsername()%>'; 
</sql:query>

<c:set var="condition" value="false"/>
<c:forEach items="${idQ2.rows}" var="row2">
    <c:choose>
        <c:when test="${row2.menu_item==3}">
            <c:set var="condition" value="true"/>
        </c:when>
    </c:choose>
</c:forEach>

<c:choose>
    <c:when test="${condition==false}">
        <script type="text/javascript">
            window.location = '/IEPTescoNew/forbiddenPage.jsp';
        </script>
    </c:when>
</c:choose>

<sql:query var="idQ5"  dataSource="jdbc/sdb">
    SELECT * FROM dept order by dept; 
</sql:query>


<div id="page-wrapper">

    <script type="text/javascript">
        var orderStatus = "";

        $(document).ready(function () {

            $("#menuItem1").removeClass("active");
            $("#menuItem2").removeClass("active");
            $("#menuItem3").removeClass("active");
            $("#menuItem4").removeClass("active");
            $("#menuItem5").removeClass("active");
            $("#menuItem6").removeClass("active");
            $("#menuItem7").removeClass("active");
            $("#menuItem3").addClass("active");

            $("#technical").hide();
            $("#swing").hide();

            $("#btn_newTech").click(function () {

                $("#technical").show();
                $('html, body').animate({
                    scrollTop: $("#technical").offset().top - 60},
                'slow', function () {
                    $("#technical").focus();
                });

            });

            $("#btn_newSwing").click(function () {

                $("#swing").show();
                $('html, body').animate({
                    scrollTop: $("#swing").offset().top - 60},
                'slow', function () {
                    $("#swing").focus();
                });

            });

            $("#check_none").change(function () {
                if (this.checked) {
                    $("#secView").show();
                } else {
                    $("#secView").hide();
                }
            });
        });

        $(document).on('click', '#techView input[type=button]', function () {
            var iii = "hidden_" + this.id;
            var iiii = this.id;
            var techlabelId = document.getElementById(iii).value;

            BootstrapDialog.show({
                title: "Notification",
                closable: false,
                buttons: [{
                        label: 'Edit Label',
                        cssClass: 'btn-primary',
                        action: function (dialogRef) {
                            editTechLabel(techlabelId);
                            dialogRef.close();
                        }
                    }, {
                        label: 'Delete Label',
                        cssClass: 'btn-primary',
                        action: function (dialogRef) {
                            delete technical_labels[iiii];
                            displayTechnical(technical_labels);
                            dialogRef.close();
                        }
                    }, {
                        label: 'Cancel',
                        action: function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
            });
        });

        $(document).on('click', '#swingView input[type=button]', function () {
            var iii = "hidden_" + this.id;
            var iiii = this.id;
            var swinglabelId = document.getElementById(iii).value;

            BootstrapDialog.show({
                title: "Notification",
                closable: false,
                buttons: [{
                        label: 'Edit Label',
                        cssClass: 'btn-primary',
                        action: function (dialogRef) {
                            editSwingLabel(swinglabelId);
                            dialogRef.close();
                        }
                    }, {
                        label: 'Delete Label',
                        cssClass: 'btn-primary',
                        action: function (dialogRef) {
                            delete swing_tickets[iiii];
                            displaySwing(swing_tickets);
                            dialogRef.close();
                        }
                    }, {
                        label: 'Cancel',
                        action: function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
            });
        });

        function editTechLabel(techlabelId) {
            clearTechLabel();
            var labelDetails = JSON.parse(techlabelId);
            $("#technical").show();
            $('html, body').animate({
                scrollTop: $("#technical").offset().top - 60},
            'slow', function () {
                $("#technical").focus();
            });
            document.getElementById("tech_labelRefId").value = labelDetails.tech_labelRef;
            document.getElementById("tech_labelGroupId").value = labelDetails.tech_labelGroup;
            document.getElementById("tech_lbl_des").value = labelDetails.tech_lbl_des;
            document.getElementById("tech_labelGroupId").readOnly = true;
            document.getElementById("tech_lbl_des").readOnly = true;
            document.getElementById("tech_labelRefId").readOnly = true;
            document.getElementById("techlabelId").value = labelDetails.tech_key;
        }

        function editSwingLabel(swinglabelId) {
            clearSwing();
            var labelDetails = JSON.parse(swinglabelId);
            $("#swing").show();
            $('html, body').animate({
                scrollTop: $("#swing").offset().top - 60},
            'slow', function () {
                $("#swing").focus();
            });
            var ref = labelDetails.swing_labelRef;
            var refA = ref.split(',');
            document.getElementById("swing_labelRef_frontId").value = refA[0];
            document.getElementById("swing_labelRef_backId").value = refA[1];
            document.getElementById("swing_labelGroupId").value = labelDetails.swing_labelGroup;
            document.getElementById("swing_lbl_des").value = labelDetails.swing_lbl_des;
            document.getElementById("swing_labelRef_frontId").readOnly = true;
            document.getElementById("swing_labelRef_backId").readOnly = true;
            document.getElementById("swing_labelGroupId").readOnly = true;
            document.getElementById("swing_lbl_des").readOnly = true;
            document.getElementById("txt_trend").value = labelDetails.trend_name;
            document.getElementById("txt_product_description").value = labelDetails.product_description;
            document.getElementById("txt_product_benefit").value = labelDetails.product_benefit;
            document.getElementById("swinglabelId").value = labelDetails.swing_key;
        }

        function closeTech() {
            clearTechLabel();
            $("#technical").hide();
        }

        function closeSwing() {
            clearSwing();
            $("#swing").hide();
        }

        $(document).on('click', '#tblTechCare span', function () {
            $(this).closest('tr').remove();
            $("#techcareInfo option[id='" + this.id + "']").prop('disabled', false);
            delete temp_technical_care[this.id];
        });

        $(document).on('click', '#tblSwingCare span', function () {
            $("#swingcareInfo option[id='" + this.id + "']").prop('disabled', false);
            $(this).closest('tr').remove();
            delete temp_swing_care[this.id];
        });

        $(document).on('click', '#tblFiber span', function () {
            var fiberType = this.id;
            var fiberQuantity = this.name;
            $(this).closest('tr').remove();
            delete temp_fiberDetail[this.id];
            $("#fiberName option[value='" + fiberType + "']").prop('disabled', false);
            document.getElementById("txt_fiberCount").value = parseInt(document.getElementById("txt_fiberCount").value) - 1;
            document.getElementById("fiberQuantity").placeholder = "Remain Amount : " + (parseInt(document.getElementById("txt_fiberQuantity").value) + parseInt(this.name));
            document.getElementById("txt_fiberQuantity").value = parseInt(document.getElementById("txt_fiberQuantity").value) + parseInt(this.name);
        });

        $(document).on('click', '#tbl_fiberCompo span', function () {

            $(this).closest('tr').remove();
            var cnt = document.getElementById("fiberComposition").value;
            if (cnt === "#") {
                document.getElementById("fiberComposition").value = 4;
            } else {
                document.getElementById("fiberComposition").value = parseInt(cnt) - 1;
            }
            document.getElementById("mainWord").disabled = false;
            document.getElementById("fiberName").disabled = false;
            document.getElementById("fiberQuantity").disabled = false;
            $("#mainWord option[value='" + this.name + "']").prop('disabled', false);
            delete temp_technical_fiber[this.id + this.name];
        });

        $(document).on('click', '#showDetails span', function () {
            $(this).closest('tr').remove();
            delete ean_details[this.id];
        });
    </script>

    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <label class="col-sm-4" for="supplier_number">Supplier No * :</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="supplier_number" id="supplier_number"  autocomplete="false" style="height: 30px;"  class="form-control" value="<%=user.getCompanyId().getCompanyCode()%>" readonly/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4" for="supplier_name">Supplier Name * :</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="supplier_name" id="supplier_name"  autocomplete="false" style="height: 30px; text-transform: capitalize;"  class="form-control" value="<%=user.getCompanyId().getCompanyName()%>" readonly/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <label class="col-sm-4" for="factory_code">Factory Code * :</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="factory_code" id="factory_code" autocomplete="false" style="height: 30px;"  class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4" for="lof_num">LOF No * :</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="lof_num" id="lof_num" style="height: 30px;"  autocomplete="false" class="form-control" value="<%=lofID%>" readonly/>
                                        <input type="hidden" name="order_id" id="order_id" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><strong>Style Details</strong></h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <label class="col-sm-5" for="style_type">Style Type :</label>
                                    <div class="col-sm-7">
                                        <select name="style_type" id="style_type" class="form-control" style="height: 30px;">
                                            <option  selected disabled> - Style Type -</option>
                                            <option  value="uk"> UK </option>
                                            <option  value="ce"> CE </option>
                                            <option  value="combine"> Combine </option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                                <div class="row" id="style_uk_type">
                                    <div class="form-group">
                                        <div class="col-lg-6 col-md-6 col-sm-6">
                                            <input type="text" name="po_uk" id="po_uk" autocomplete="false" style="height: 30px;"  class="form-control" placeholder="PO Number - UK"/>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6">
                                            <input type="text" name="style_uk" id="style_uk" autocomplete="false" style="height: 30px;"  class="form-control" placeholder="Style Number - UK"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" id="style_ce_type">
                                    <div class="form-group">
                                        <div class="col-lg-6 col-md-6 col-sm-6">
                                            <input type="text" name="po_ce" id="po_ce" autocomplete="false" style="height: 30px;"  class="form-control" placeholder="PO Number - CE"/>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6">
                                            <input type="text" name="style_ce" id="style_ce" autocomplete="false" style="height: 30px;"  class="form-control" placeholder="Style Number - CE"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>                            

        <div class="row">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>General Details</strong></h3>
                </div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4" for="category">Category * :</label>
                                <div class="col-sm-8">
                                    <%
                                        if (commonData.getCategory() != null) {
                                    %>
                                    <input type="text" name="category" id="category"  autocomplete="off" style="height: 30px;"  class="form-control" value="<%=commonData.getCategory()%>"/>
                                    <%
                                    } else {
                                    %>
                                    <input type="text" name="category" id="category"  autocomplete="off" style="height: 30px;"  class="form-control"/>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4" for="country_of_origin">Country of Origin * :</label>

                                <sql:query var="idQ45"  dataSource="jdbc/sdb">
                                    SELECT * FROM country ORDER BY country_name ASC; 
                                </sql:query>
                                <div class="col-sm-8">
                                    <%
                                        if (commonData.getCountry() != null) {
                                    %>
                                    <input class="form-control" list="country_list" name="country_of_origin" id="country_of_origin" style="width: 100%; height: 30px;" value="<%=commonData.getCountry()%>"/>
                                    <%
                                    } else {
                                    %>
                                    <input class="form-control" list="country_list" name="country_of_origin" id="country_of_origin" style="width: 100%; height: 30px;"/>
                                    <%
                                        }
                                    %>
                                    <datalist id="country_list">
                                        <option disabled selected> - Country - </option>
                                        <c:forEach var="row2" items="${idQ45.rows}">                                                                                
                                            <option value="${row2.country_name}">${row2.country_name}</option>
                                        </c:forEach>
                                    </datalist>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4" for="Brand">Brand * :</label>
                                <div class="col-sm-8">
                                    <%
                                        if (commonData.getBrand() != null) {
                                    %>
                                    <input type="text" name="Brand" id="Brand"  autocomplete="off" style="height: 30px;"  class="form-control" value="<%=commonData.getBrand()%>"/>
                                    <%
                                    } else {
                                    %>
                                    <input type="text" name="Brand" id="Brand"  autocomplete="off" style="height: 30px;"  class="form-control"/>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4" for="char_description">24 Char Description :</label>
                                <div class="col-sm-8">
                                    <%
                                        if (commonData.getChar24Des() != null) {
                                    %>
                                    <input type="text" name="char_description"  autocomplete="off" id="char_description" style="height: 30px;"  class="form-control" value="<%=commonData.getChar24Des()%>"/>
                                    <%
                                    } else {
                                    %>
                                    <input type="text" name="char_description"  autocomplete="off" id="char_description" style="height: 30px;"  class="form-control"/>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4" for="season_code">Season Code :</label>
                                <div class="col-sm-8">
                                    <%
                                        if (commonData.getSeasonCode() != null) {
                                    %>
                                    <input type="text" name="season_code"  autocomplete="off" id="season_code"  style="height: 30px;"  class="form-control" value="<%=commonData.getSeasonCode()%>"/>
                                    <%
                                    } else {
                                    %>
                                    <input type="text" name="season_code"  autocomplete="off" id="season_code"  style="height: 30px;"  class="form-control"/>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4" for="carton_dimensions">Carton Dimensions :</label>
                                <div class="col-sm-8">
                                    <%
                                        if (commonData.getCartonDimensions() != null) {
                                    %>
                                    <input type="text" name="carton_dimensions"  autocomplete="off" id="carton_dimensions" style="height: 30px;"  class="form-control" value="<%=commonData.getCartonDimensions()%>"/>
                                    <%
                                    } else {
                                    %>
                                    <input type="text" name="carton_dimensions"  autocomplete="off" id="carton_dimensions" style="height: 30px;"  class="form-control"/>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4" for="comments">Comments :</label>
                                <div class="col-sm-8">
                                    <%
                                        if (commonData.getCommentField() != null) {
                                    %>
                                    <input type="text" name="comments" id="comments"  autocomplete="off" style="height: 30px;"  class="form-control" value="<%=commonData.getCommentField()%>"/>
                                    <%
                                    } else {
                                    %>
                                    <input type="text" name="comments" id="comments"  autocomplete="off" style="height: 30px;"  class="form-control"/>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4" for="customer_po">Customer PO :</label>
                                <div class="col-sm-8">
                                    <input type="text" name="customer_po" id="customer_po"  autocomplete="off" style="height: 30px;"  class="form-control" value=""/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--EAN Panel-->                        
        <div class="row">
            <div class="panel panel-default">

                <div class="panel-heading">
                    <h3 class="panel-title"><strong>EAN Nos Primary Sizes </strong></h3>
                </div>

                <div class="panel-body">
                    <div class="form-inline">
                        <div class="row">
                            <table border="0" width="100%">               
                                <tr>
                                    <td>
                                        <div class="col-lg-3 col-md-3">
                                            <div class="form-group" style="width: 100%;">
                                                <sql:query var="idQ5"  dataSource="jdbc/sdb">
                                                    SELECT * FROM sizes GROUP BY dept; 
                                                </sql:query>
                                                <select  id="department_ID" name="department_ID" class="form-control" onchange="getSecondrySizes();" onclick="checkStyleNomber();" >
                                                    <option  selected disabled=""> Department </option>
                                                    <c:forEach var="row2" items="${idQ5.rows}">                                                                                
                                                        <option value="${row2.dept}">${row2.dept}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2">
                                            <div class="form-control" style="padding: 0 0">
                                                <input id="check_sec_size" type="button" value="Check" onclick="checkSecSizeSelectedOrNot()" class="btn btn-primary" disabled="true" style="width: 100%;"/>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4">
                                            <div>
                                                <div class="form-group">
                                                    <div class="col-sm-2">
                                                        <input id="check_none" type="checkbox" value="" class="btn btn-primary"/>
                                                    </div>
                                                    <label class="col-sm-10" for="check_none">Add Secondary Sizes</label>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="row">
                                            <div class="col-lg-10 col-lg-offset-1">
                                                <div id="checkboxlist">
                                                    <div class="row" id="secView">

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>                 
                            </table>
                        </div>
                        <br/>
                        <div class="row">
                            <div class="col-lg-12"> 

                                <table class="table table-striped table-hover table-bordered" width="100%" id="eanTable">
                                    <thead>
                                        <tr>
                                            <th rowspan="2" style="text-align: center;"></th>
                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">EAN Number</th>
                                            <th colspan="2" style="text-align: center; padding: 4px">Primary Size</th>
                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Secondary Size</th>
                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Department</th>
                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Quantity</th>
                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Color</th>
                                        </tr>
                                        <tr>
                                            <th width="10%" style="text-align: center; padding: 4px">UK Size</th>
                                            <th width="10%" style="text-align: center; padding: 4px">CE Size</th>
                                        </tr>
                                    </thead>
                                    <tbody style="text-align: center;">
                                        <%
                                            for (Eannotb data : eanSendArray) {
                                        %>                                        
                                        <tr>
                                            <td>
                                                <input type="checkbox" id="<%=data.getUkSize()%>" value="" disabled name="chk_ean" />
                                            </td>
                                            <td>
                                                <%=data.getEanno()%>
                                            </td>
                                            <td>
                                                <%=data.getUkSize()%>    
                                            </td>
                                            <td>
                                                <%=data.getCeSize()%>
                                            </td>
                                            <td>
                                                <div id="secSizeDiv"></div>
                                            </td>
                                            <td>
                                                <div id="department"></div>
                                            </td>
                                            <td width="15%">
                                                <input type="number" min="0" class="form-control" name="quantity"  id="quantity" placeholder="Amount" onkeypress="return checkForSecondDecimal(this, event);" style="width: 100%;"/>
                                            </td>
                                            <td width="15%">
                                                <input type="text" class="form-control" name="color"  id="color" placeholder="Color" style="width: 100%;" />
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                                <input class="btn btn-primary pull-right" type="submit" name="submit" value="Vertify EAN" onclick="getEanDetail();"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Technical View Table-->                                
        <div class="row">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-title"><strong>Technical Label</strong>&nbsp;&nbsp;<small onclick="displayTechnical();" class="badge" id="techCount">No of Technical Labels : 0</small></div>
                    <div style="float: right; font-size: 80%; position: relative; top: -28px">
                        <button id="btn_newTech" class="btn btn-default"><span><i class="glyphicon glyphicon-plus"></i></span>&nbsp;<Strong>New Technical Label</strong></button>
                    </div>
                    <!--                    <div style="float: right; font-size: 80%; position: relative; top: -28px; margin-right: 10px;">
                                            <button class="btn btn-default"><span><i class="glyphicon glyphicon-list"></i></span>&nbsp;<Strong>View</strong></button>
                                        </div>-->
                </div>
                <div id="techView" class="panel-body" style="padding-left: 35px; padding-right: 35px;">

                </div>
            </div>
        </div>

        <!--Technical Panel-->                                
        <div class="row" id="technical" >
            <div class="panel panel-info">
                <div class="panel-heading">
                    <div class="panel-title"><strong>New Technical Label</strong></div>
                    <div style="float: right; font-size: 80%; position: relative; top: -28px; margin-right: 10px;">
                        <button class="btn btn-default pull-right" onclick="closeTech();">Close</button>
                    </div>
                    <div style="float: right; font-size: 80%; position: relative; top: -28px; margin-right: 10px;">
                        <button class="btn btn-default pull-right" onclick="clearTechLabel();">Clear</button>
                    </div>
                </div>
                <div class="panel-body">
                    <table border="0" class="table table-hover table-responsive">                
                        <thead>                       
                        </thead>                
                        <tbody>
                            <tr>
                                <td colspan="2" style="padding-top: 20px;">
                                    <div class="row-fluid">
                                        <div class="col-lg-6">
                                            <div class="row-fluid">
                                                <div class="form-group">
                                                    <label for="tech_labelRef">Label Reference : </label>
                                                    &nbsp;
                                                    <input class="form-control" list="tech_labelRef" name="tech_labelRef" id="tech_labelRefId" style="width: 100%;"/>
                                                    <datalist id="tech_labelRef">
                                                        <sql:query var="idQ61"  dataSource="jdbc/sdb">
                                                            SELECT * FROM reference r where r.ref_type="TL" ORDER BY ref ASC; 
                                                        </sql:query>
                                                        <option disabled selected> - Reference - </option>
                                                        <c:forEach var="row2" items="${idQ61.rows}">                                                                                
                                                            <option value="${row2.ref}">${row2.ref}</option>
                                                        </c:forEach>
                                                    </datalist>
                                                    <input type="hidden" value="" name="techlabelId" id="techlabelId"/>
                                                </div>
                                            </div>
                                            <div class="row-fluid">
                                                <div class="form-group">
                                                    <label for="tech_labelGroup">Label Group :</label>
                                                    &nbsp;
                                                    <input class="form-control" list="tech_labelGroup" name="tech_labelGroup" id="tech_labelGroupId" style="width: 100%;"/>
                                                    <datalist id="tech_labelGroup">
                                                        <sql:query var="idQ62"  dataSource="jdbc/sdb">
                                                            SELECT * FROM label_group r where r.label_type="TL" ORDER BY grp ASC; 
                                                        </sql:query>
                                                        <option disabled selected> - Group - </option>
                                                        <c:forEach var="row3" items="${idQ62.rows}">                                                                                
                                                            <option value="${row3.grp}">${row3.grp}</option>
                                                        </c:forEach>
                                                    </datalist>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6" style="padding-left: 15px; padding-right: 15px;">
                                        <div class="form-group">
                                            <label for="tech_lbl_des">Label Description : </label>
                                            &nbsp;
                                            <textarea class="form-control textarea" name="tech_lbl_des" id="tech_lbl_des" rows="5"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" bgcolor="#EFEFEF" style="font-size: 110%;">&nbsp;&nbsp;&nbsp;<span><i class="glyphicon glyphicon-arrow-right"></i></span>&nbsp;<strong>Care Text</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top: 20px;">
                                    <div class="row-fluid">
                                        <div class="col-lg-6">
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <sql:query var="idQ6"  dataSource="jdbc/sdb">
                                                    SELECT * FROM care_text order by ct_id ASC; 
                                                </sql:query>

                                                <select  id="techcareInfo" name="techcareInfo" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Select Care Text --</option>
                                                    <c:forEach var="row2" items="${idQ6.rows}"> 
                                                        <option id="${row2.ct_code}" value="${row2.ct_code})${row2.english}">${row2.ct_id} ) ${row2.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addTechCare();">Add</button>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <div class="table-responsive">
                                                    <table class="table table-striped" id="tblTechCare" >
                                                        <thead>
                                                            <tr> 
                                                                <th bgcolor="#efefef" width="25%">Code</th> 
                                                                <th bgcolor="#efefef" >Care Text Description</th>
                                                                <th bgcolor="#efefef" width="10%"></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody> 
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" bgcolor="#EFEFEF" style="font-size: 110%;">&nbsp;&nbsp;&nbsp;<span><i class="glyphicon glyphicon-arrow-right"></i></span>&nbsp;<strong>Wash Symbol</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top: 20px;">
                                    <div class="row-fluid">
                                        <div class="col-lg-3">
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='W' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="techWash_W" name="techWash_W" class="form-control" style="height: 30px;" onchange="loadTechWash();">
                                                    <option  selected disabled> Wash </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option value="${row2.symbol_code}">${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='B' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="techWash_B" name="techWash_B" class="form-control" style="height: 30px;" onchange="loadTechBleach();">
                                                    <option  selected disabled> Bleach </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option value="${row2.symbol_code}">${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='D' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="techWash_D" name="techWash_D" class="form-control" style="height: 30px;" onchange="loadTechDry();">
                                                    <option  selected disabled> Dry </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option value="${row2.symbol_code}">${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='I' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="techWash_I" name="techWash_I" class="form-control" style="height: 30px;" onchange="loadTechIron();">
                                                    <option  selected disabled> Iron </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option value="${row2.symbol_code}">${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='C' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="techWash_C" name="techWash_C" class="form-control" style="height: 30px;" onchange="loadTechDryClean();">
                                                    <option  selected disabled> Dry Clean </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option value="${row2.symbol_code}">${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                        </div>
                                        <div class="col-lg-9">
                                            <table border="0" cellpadding="1" class="table table-responsive table-striped" style="width: 100%;">
                                                <thead>
                                                    <tr>
                                                        <th width="20%">Wash</th>
                                                        <th width="20%">Bleach</th>
                                                        <th width="20%">Dry</th>
                                                        <th width="20%">Iron</th>
                                                        <th width="20%">Dry Clean</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <img id="techWashImg_W" name="techWashImg_W" />
                                                            <input type="hidden" name="techWashTxt_W" id="techWashTxt_W" value="" />
                                                        </td>
                                                        <td>
                                                            <img id="techWashImg_B" name="techWashImg_B" />
                                                            <input type="hidden" name="techWashTxt_B" id="techWashTxt_B" value="" />
                                                        </td>
                                                        <td>
                                                            <img id="techWashImg_D" name="techWashImg_D" />
                                                            <input type="hidden" name="techWashTxt_D" id="techWashTxt_D" value="" />
                                                        </td>
                                                        <td>
                                                            <img id="techWashImg_I" name="techWashImg_I" />
                                                            <input type="hidden" name="techWashTxt_I" id="techWashTxt_I" value="" />
                                                        </td>
                                                        <td>
                                                            <img id="techWashImg_C" name="techWashImg_C" />
                                                            <input type="hidden" name="techWashTxt_C" id="techWashTxt_C" value="" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                    <tr> 
                                                        <td colspan="5">
                                                            <input class="btn btn-primary pull-left" type="button" id="btn_wash_tech_clear" value="Clear" onclick="btnTechWashClear();"/>
                                                            <input class="btn btn-primary pull-right" type="button" id="btn_wash_tech_vertify" value="Vertify Wash Symbol" onclick="btnTechWashVertify();"/>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" bgcolor="#EFEFEF" style="font-size: 110%;">&nbsp;&nbsp;&nbsp;<span><i class="glyphicon glyphicon-arrow-right"></i></span>&nbsp;<strong>Fiber Details</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top: 20px;">
                                    <div class="row-fluid">  
                                        <div class="col-lg-6">
                                            <form class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <label class="control-label col-sm-4" for="fiberComposition">Fiber Composition : </label>
                                                    <div class="col-sm-2">
                                                        <input type="text" class="form-control" id="fiberComposition" value="1" readonly style="text-align: center; height: 30px;"/>
                                                        <input type="hidden" id="txt_mainWord" value=""/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-sm-4" for="mainWord">Main Word : </label>
                                                    <div class="col-sm-8"> 
                                                        <sql:query var="idQ7"  dataSource="jdbc/sdb">
                                                            SELECT * FROM fiber f where f.d_type="MAINWORD" ORDER BY english ASC; 
                                                        </sql:query>

                                                        <select  id="mainWord" name="mainWord" class="form-control" style="height: 30px;" onchange="getMainWord();">
                                                            <option  selected disabled> - Main Word -</option>
                                                            <option  value="None">None</option>
                                                            <c:forEach var="row3" items="${idQ7.rows}">                                                                                
                                                                <option value="${row3.english}">${row3.english}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-sm-4" for="fiberName">Fiber : </label>
                                                    <div class="col-sm-8"> 
                                                        <sql:query var="idQ8"  dataSource="jdbc/sdb">
                                                            SELECT * FROM fiber f where f.d_type="FIBER" ORDER BY english ASC; 
                                                        </sql:query>
                                                        <select name="fiberName" id="fiberName" size="" class="form-control" style="height: 30px;">
                                                            <option  selected disabled> - Fiber -</option>
                                                            <c:forEach var="row4" items="${idQ8.rows}">                                                                                
                                                                <option value="${row4.english}">${row4.english}</option>
                                                            </c:forEach>
                                                        </select>
                                                        <input type="hidden" id="txt_fiberCount" value="1"/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-sm-4" for="fiberQuantity">Amount : </label>
                                                    <div class="col-sm-5"> 
                                                        <input type="text" class="form-control" id="fiberQuantity" placeholder="Remain Amount : 100" style="text-align: right; height: 30px;" onkeypress="return checkForSecondDecimal(this, event)"/>
                                                        <input type="hidden" id="txt_fiberQuantity" value="100"/>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <input id="btn_addFiber" class="btn btn-default pull-right" type="button" value="Add" style="height: 30px;" onclick="addFiber();" disabled/>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="row-fluid">
                                                <div class="form-group">
                                                    <div class="col-sm-11 pull-right">
                                                        <div class="table-responsive">
                                                            <table border="0" id="tblFiber" class="table table-hover table-striped" width="100%">
                                                                <thead>
                                                                    <tr>
                                                                        <!--<th bgcolor="#efefef" width="10%" style="text-align: center;">#</th>-->
                                                                        <th bgcolor="#efefef">&nbsp;Fiber</th>
                                                                        <th bgcolor="#efefef">&nbsp;Value</th>
                                                                        <th bgcolor="#efefef" width="10%" ></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>

                                                                </tbody>
                                                                <tfoot>
                                                                    <tr>
                                                                        <td colspan="3"><input id="btn_addFiberCompo" class="btn btn-default pull-right" type="button" value="Done" disabled onclick="addFiberCompo();"/></td>
                                                                    </tr>
                                                                </tfoot>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="col-lg-10 col-lg-offset-1">
                                            <div class="table-responsive">
                                                <table border="0" id="tbl_fiberCompo" class="table table-hover table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th bgcolor="#efefef" style="text-align: center;">Fiber Composition</th>
                                                            <th bgcolor="#efefef" width="10%"></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2"> <input id="btn_addTechnicalLabel" class="btn btn-primary pull-right" type="button" value="Add to Technical Label" onclick="addTechLabel();"/> </td>
                            </tr>
                        </tfoot>
                    </table>

                </div>
            </div>
        </div>

        <!--Swing View Table-->                                
        <div class="row">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-title"><strong>Swing Ticket</strong>&nbsp;&nbsp;<small class="badge" id="swingCount">No of Swing Tickets : 0</small></div>
                    <div style="float: right; font-size: 80%; position: relative; top: -28px">
                        <button id="btn_newSwing" class="btn btn-default"><span><i class="glyphicon glyphicon-plus"></i></span>&nbsp;<Strong>New Swing Ticket</strong></button>
                    </div>
                    <!--                    <div style="float: right; font-size: 80%; position: relative; top: -28px; margin-right: 10px;">
                                            <button class="btn btn-default"><span><i class="glyphicon glyphicon-list"></i></span>&nbsp;<Strong>View</strong></button>
                                        </div>-->
                </div>
                <div id="swingView" class="panel-body" style="padding-left: 35px; padding-right: 35px;">

                </div>
            </div>
        </div>

        <!--SWing Panel-->                                
        <div class="row" id="swing" >
            <div class="panel panel-info">
                <div class="panel-heading">
                    <div class="panel-title"><strong>New Swing Ticket</strong></div>
                    <div style="float: right; font-size: 80%; position: relative; top: -28px; margin-right: 10px;">
                        <button class="btn btn-default pull-right" onclick="closeSwing();">Close</button>
                    </div>
                    <div style="float: right; font-size: 80%; position: relative; top: -28px; margin-right: 10px;">
                        <button class="btn btn-default pull-right" onclick="clearSwing()">Clear</button>
                    </div>
                </div>
                <div class="panel-body">
                    <table border="0" class="table table-hover table-responsive">                
                        <thead>                       
                        </thead>                
                        <tbody>
                            <tr>
                                <td colspan="2" style="padding-top: 20px;">
                                    <div class="row-fluid">
                                        <div class="col-lg-6">
                                            <div class="row-fluid">
                                                <div class="form-group">
                                                    <label for="swing_labelRef">Label Reference : </label>
                                                    &nbsp;
                                                    <input class="form-control" list="swing_labelRef_front" name="swing_labelRef_front" id="swing_labelRef_frontId" style="width: 100%;" placeholder="Front"/>
                                                    <datalist id="swing_labelRef_front">                                
                                                        <sql:query var="idQ61"  dataSource="jdbc/sdb">
                                                            SELECT * FROM reference r where r.ref_type="ST-F" ORDER BY ref ASC; 
                                                        </sql:query>
                                                        <option disabled selected> - Reference - </option>
                                                        <c:forEach var="row2" items="${idQ61.rows}">                                                                                
                                                            <option value="${row2.ref}">${row2.ref}</option>
                                                        </c:forEach>
                                                    </datalist>
                                                    <input type="hidden" value="" name="swinglabelId" id="swinglabelId"/>
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" list="swing_labelRef_back" name="swing_labelRef_back" id="swing_labelRef_backId" style="width: 100%;" placeholder="Back"/>
                                                    <datalist id="swing_labelRef_back">                             
                                                        <sql:query var="idQ61"  dataSource="jdbc/sdb">
                                                            SELECT * FROM reference r where r.ref_type="ST-B" ORDER BY ref ASC; 
                                                        </sql:query>
                                                        <option disabled selected> - Reference - </option>
                                                        <c:forEach var="row2" items="${idQ61.rows}">                                                                                
                                                            <option value="${row2.ref}">${row2.ref}</option>
                                                        </c:forEach>
                                                    </datalist>
                                                </div>
                                            </div>
                                            <div class="row-fluid">
                                                <div class="form-group">
                                                    <label for="swing_labelGroup">Label Group :</label>
                                                    &nbsp;
                                                    <input class="form-control" list="swing_labelGroup" name="swing_labelGroup" id="swing_labelGroupId" style="width: 100%;"/>
                                                    <datalist id="swing_labelGroup">
                                                        <sql:query var="idQ64"  dataSource="jdbc/sdb">
                                                            SELECT * FROM label_group r where r.label_type="ST" ORDER BY grp ASC; 
                                                        </sql:query>
                                                        <option disabled selected> - Group - </option>
                                                        <c:forEach var="row4" items="${idQ64.rows}">                                                                                
                                                            <option value="${row4.grp}">${row4.grp}</option>
                                                        </c:forEach>
                                                    </datalist>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6" style="padding-left: 15px; padding-right: 15px;">
                                        <div class="form-group">
                                            <label for="swing_lbl_des">Label Description : </label>
                                            &nbsp;
                                            <textarea class="form-control textarea" name="swing_lbl_des" id="swing_lbl_des" rows="5"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" bgcolor="#EFEFEF" style="font-size: 110%;">&nbsp;&nbsp;&nbsp;<span><i class="glyphicon glyphicon-arrow-right"></i></span>&nbsp;<strong>Product Details</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top: 20px;">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group form-inline">
                                                <label for="txt_trend">Trend Name :</label>
                                                &nbsp;
                                                <input class="form-control" type="text" name="txt_trend" id="txt_trend" style="width: 100%; height: 30px;" />
                                            </div>  
                                            <div class="form-group form-inline">
                                                <label for="txt_product_description">Product Description :</label>
                                                &nbsp;
                                                <textarea class="form-control" name="txt_product_description" id="txt_product_description" style="width: 100%;" rows="2"></textarea>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="form-group form-inline">
                                                <label for="txt_product_benefit">Product Benefit :</label>
                                                &nbsp;
                                                <input class="form-control" type="text" name="txt_product_benefit" id="txt_product_benefit" style="width: 100%; height: 30px;" value="" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" bgcolor="#EFEFEF" style="font-size: 110%;">&nbsp;&nbsp;&nbsp;<span><i class="glyphicon glyphicon-arrow-right"></i></span>&nbsp;<strong>Care Text</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top: 20px;">
                                    <div class="row-fluid">
                                        <div class="col-lg-6">
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <sql:query var="idQ6"  dataSource="jdbc/sdb">
                                                    SELECT * FROM care_text order by ct_id ASC; 
                                                </sql:query>

                                                <select  id="swingcareInfo" name="swingcareInfo" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Select Care Text --</option>
                                                    <c:forEach var="row2" items="${idQ6.rows}"> 
                                                        <option id="${row2.ct_code}" value="${row2.ct_code})${row2.english}">${row2.ct_id} ) ${row2.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addSwingCare();">Add</button>
                                            </div>
                                        </div>
                                        <div class="col-lg-6"
                                             <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <div class="table-responsive">
                                                    <table border="0" id="tblSwingCare" class="table table-hover table-striped">
                                                        <thead>
                                                            <tr> 
                                                                <th bgcolor="#efefef" width="25%">Code</th> 
                                                                <th bgcolor="#efefef" >Care Text Description</th>
                                                                <th bgcolor="#efefef" width="10%"></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody> 
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" bgcolor="#EFEFEF" style="font-size: 110%;">&nbsp;&nbsp;&nbsp;<span><i class="glyphicon glyphicon-arrow-right"></i></span>&nbsp;<strong>Wash Symbol</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top: 20px;">
                                    <div class="row-fluid">
                                        <div class="col-lg-3">
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='W' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="swingWash_W" name="swingWash_W" class="form-control" style="height: 30px;" onchange="loadSwingWash();">
                                                    <option  selected disabled> Wash </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option id="${row2.symbol_code}" value="${row2.symbol_code}">${row2.symbol_code} - ${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='B' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="swingWash_B" name="swingWash_B" class="form-control" style="height: 30px;" onchange="loadSwingBleach();">
                                                    <option  selected disabled> Bleach </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option id="${row2.symbol_code}" value="${row2.symbol_code}">${row2.symbol_code} - ${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='D' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="swingWash_D" name="swingWash_D" class="form-control" style="height: 30px;" onchange="loadSwingDry();">
                                                    <option  selected disabled> Dry </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option id="${row2.symbol_code}" value="${row2.symbol_code}">${row2.symbol_code} - ${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='I' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="swingWash_I" name="swingWash_I" class="form-control" style="height: 30px;" onchange="loadSwingIron();">
                                                    <option  selected disabled> Iron </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option id="${row2.symbol_code}" value="${row2.symbol_code}">${row2.symbol_code} - ${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                            <div class="row" style="margin-left: 1px; margin-right: 1px;">
                                                <sql:query var="idWash"  dataSource="jdbc/sdb">
                                                    SELECT * FROM wash_symbol where symbol_type='C' order by symbol_code ASC; 
                                                </sql:query>
                                                <select  id="swingWash_C" name="swingWash_C" class="form-control" style="height: 30px;" onchange="loadSwingDryClean();">
                                                    <option  selected disabled> Dry Clean </option>
                                                    <c:forEach var="row2" items="${idWash.rows}"> 
                                                        <option id="${row2.symbol_code}" value="${row2.symbol_code}">${row2.symbol_code} - ${row2.details}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <br/>
                                        </div>
                                        <div class="col-lg-9">
                                            <table border="0" cellpadding="1" class="table table-responsive table-striped" style="width: 100%;">
                                                <thead>
                                                    <tr>
                                                        <th width="20%">Wash</th>
                                                        <th width="20%">Bleach</th>
                                                        <th width="20%">Dry</th>
                                                        <th width="20%">Iron</th>
                                                        <th width="20%">Dry Clean</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <img id="swingWashImg_W" name="swingWashImg_W" />
                                                            <input type="hidden" name="swingWashTxt_W" id="swingWashTxt_W" value="" />
                                                        </td>
                                                        <td>
                                                            <img id="swingWashImg_B" name="swingWashImg_B" />
                                                            <input type="hidden" name="swingWashTxt_B" id="swingWashTxt_B" value="" />
                                                        </td>
                                                        <td>
                                                            <img id="swingWashImg_D" name="swingWashImg_D" />
                                                            <input type="hidden" name="swingWashTxt_D" id="swingWashTxt_D" value="" />
                                                        </td>
                                                        <td>
                                                            <img id="swingWashImg_I" name="swingWashImg_I" />
                                                            <input type="hidden" name="swingWashTxt_I" id="swingWashTxt_I" value="" />
                                                        </td>
                                                        <td>
                                                            <img id="swingWashImg_C" name="swingWashImg_C" />
                                                            <input type="hidden" name="swingWashTxt_C" id="swingWashTxt_C" value="" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                    <tr> 
                                                        <td colspan="5">
                                                            <input class="btn btn-primary pull-left" type="button" id="btn_wash_swing_clear" value="Clear" onclick="btnSwingWashClear();"/>
                                                            <input class="btn btn-primary pull-right" type="button" id="btn_wash_swing_vertify" value="Vertify Wash Symbol" onclick="btnSwingWashVertify();"/>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2"> <input id="btn_addSwingLabel" class="btn btn-primary pull-right" type="button" value="Add to Swing Ticket" onclick="addSwingLabel();"/> </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>


        <!--Selling Panel-->                                
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Selling Prices</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive" style="overflow-x: hidden;">
                            <table border="0" class="table table-striped" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <td width="50%">
                                            Category A
                                            <input type="radio" name="grp_price" id="grp_price_1" onchange="disable_grp_price();" value="value_1"  />
                                        </td>
                                        <td>Category B
                                            <input type="radio" name="grp_price" id="grp_price_2" onchange="disable_grp_price();" value="value_2"/>
                                        </td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="row-fluid">
                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-2" for="cz">CZ</label>
                                                        <div class="col-sm-9">
                                                            <input class="form-control" type="number" name="submit" value="" id="cz" disabled style="height: 30px;" onkeypress="return checkForSecondDecimal(this, event)"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-2" for="sk">SK</label>
                                                        <div class="col-sm-9">
                                                            <input class="form-control" type="number" name="submit" value="" id="sk" disabled style="height: 30px;" onkeypress="return checkForSecondDecimal(this, event)"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-2" for="en">EN</label>
                                                        <div class="col-sm-9">
                                                            <input class="form-control" type="number" name="submit" value="" id="en" disabled style="height: 30px;" onkeypress="return checkForSecondDecimal(this, event)"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-2" for="hu">HU</label>
                                                        <div class="col-sm-9">
                                                            <input class="form-control" type="number" name="submit" value="" id="hu" disabled style="height: 30px;" onkeypress="return checkForSecondDecimal(this, event)"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-2" for="tr">TR</label>
                                                        <div class="col-sm-9">
                                                            <input class="form-control" type="number" name="submit" value="" id="tr" disabled style="height: 30px;" onkeypress="return checkForSecondDecimal(this, event)"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="row-fluid">
                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-2" for="pound">&pound;</label>
                                                        <div class="col-sm-9">
                                                            <input class="form-control" type="number" name="submit" value="" id="pound" disabled style="height: 30px;" onkeypress="return checkForSecondDecimal(this, event)"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-2" for="euro">&euro;</label>
                                                        <div class="col-sm-9">
                                                            <input class="form-control" type="number" name="submit" value="" id="euro" disabled style="height: 30px;" onkeypress="return checkForSecondDecimal(this, event)"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Submit Button-->
        <div class="row">
            <center>
                <input class="btn btn-primary" type="button" value="Submit" name="btn_submit" id="btn_submit" style="width: 25%;" onclick="checkForSubmit();"/>
            </center>
        </div>
    </div>
    <!-- /.container-fluid -->

    <div id="viewModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Wash Symbol Details</h4>
                </div>
                <div class="modal-body">
                    <image id="sizeWash" name="sizeWash" class="img-responsive"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

</div>
<!-- /#page-wrapper -->

<script type="text/javascript">

    function loadTechWash() {
        var val = document.getElementById("techWash_W").value;
        document.getElementById("techWashTxt_W").value = val;
        $("#techWashImg_W").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function loadTechBleach() {
        var val = document.getElementById("techWash_B").value;
        document.getElementById("techWashTxt_B").value = val;
        $("#techWashImg_B").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function loadTechIron() {
        var val = document.getElementById("techWash_I").value;
        document.getElementById("techWashTxt_I").value = val;
        $("#techWashImg_I").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function loadTechDry() {
        var val = document.getElementById("techWash_D").value;
        document.getElementById("techWashTxt_D").value = val;
        $("#techWashImg_D").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function loadTechDryClean() {
        var val = document.getElementById("techWash_C").value;
        document.getElementById("techWashTxt_C").value = val;
        $("#techWashImg_C").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function loadSwingWash() {
        var val = document.getElementById("swingWash_W").value;
        document.getElementById("swingWashTxt_W").value = val;
        $("#swingWashImg_W").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function loadSwingBleach() {
        var val = document.getElementById("swingWash_B").value;
        document.getElementById("swingWashTxt_B").value = val;
        $("#swingWashImg_B").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function loadSwingIron() {
        var val = document.getElementById("swingWash_I").value;
        document.getElementById("swingWashTxt_I").value = val;
        $("#swingWashImg_I").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function loadSwingDry() {
        var val = document.getElementById("swingWash_D").value;
        document.getElementById("swingWashTxt_D").value = val;
        $("#swingWashImg_D").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function loadSwingDryClean() {
        var val = document.getElementById("swingWash_C").value;
        document.getElementById("swingWashTxt_C").value = val;
        $("#swingWashImg_C").attr("src", "/IEPTescoNew/img/symbols/" + val + ".png");
    }

    function btnSwingWashVertify() {
        document.getElementById("btn_wash_swing_vertify").disabled = true;
        document.getElementById("swingWash_W").disabled = true;
        document.getElementById("swingWash_B").disabled = true;
        document.getElementById("swingWash_I").disabled = true;
        document.getElementById("swingWash_D").disabled = true;
        document.getElementById("swingWash_C").disabled = true;
        btn_wash_swing_vertify
    }

    function  btnSwingWashClear() {
        document.getElementById("btn_wash_swing_vertify").disabled = false;
        document.getElementById("swingWash_W").disabled = false;
        document.getElementById("swingWash_B").disabled = false;
        document.getElementById("swingWash_I").disabled = false;
        document.getElementById("swingWash_D").disabled = false;
        document.getElementById("swingWash_C").disabled = false;
        document.getElementById("swingWash_W").selectedIndex = 0;
        document.getElementById("swingWash_B").selectedIndex = 0;
        document.getElementById("swingWash_I").selectedIndex = 0;
        document.getElementById("swingWash_D").selectedIndex = 0;
        document.getElementById("swingWash_C").selectedIndex = 0;
        document.getElementById("swingWashTxt_W").value = "";
        document.getElementById("swingWashTxt_B").value = "";
        document.getElementById("swingWashTxt_I").value = "";
        document.getElementById("swingWashTxt_D").value = "";
        document.getElementById("swingWashTxt_C").value = "";
        $("#swingWashImg_W").attr("src", "");
        $("#swingWashImg_B").attr("src", "");
        $("#swingWashImg_I").attr("src", "");
        $("#swingWashImg_D").attr("src", "");
        $("#swingWashImg_C").attr("src", "");
    }

    function btnTechWashVertify() {
        document.getElementById("btn_wash_tech_vertify").disabled = true;
        document.getElementById("techWash_W").disabled = true;
        document.getElementById("techWash_B").disabled = true;
        document.getElementById("techWash_I").disabled = true;
        document.getElementById("techWash_D").disabled = true;
        document.getElementById("techWash_C").disabled = true;
    }

    function  btnTechWashClear() {
        document.getElementById("btn_wash_tech_vertify").disabled = false;
        document.getElementById("techWash_W").disabled = false;
        document.getElementById("techWash_B").disabled = false;
        document.getElementById("techWash_I").disabled = false;
        document.getElementById("techWash_D").disabled = false;
        document.getElementById("techWash_C").disabled = false;
        document.getElementById("techWash_W").selectedIndex = 0;
        document.getElementById("techWash_B").selectedIndex = 0;
        document.getElementById("techWash_I").selectedIndex = 0;
        document.getElementById("techWash_D").selectedIndex = 0;
        document.getElementById("techWash_C").selectedIndex = 0;
        document.getElementById("techWashTxt_W").value = "";
        document.getElementById("techWashTxt_B").value = "";
        document.getElementById("techWashTxt_I").value = "";
        document.getElementById("techWashTxt_D").value = "";
        document.getElementById("techWashTxt_C").value = "";
        $("#techWashImg_W").attr("src", "");
        $("#techWashImg_B").attr("src", "");
        $("#techWashImg_I").attr("src", "");
        $("#techWashImg_D").attr("src", "");
        $("#techWashImg_C").attr("src", "");
    }


</script>


<script type="text/javascript">
    var technical_labels = {};
    var swing_tickets = {};
    var ean_details = {};
    var styleType;
    var sellingCat = "0";
    var isSellingValidate = false;

    function checkForSubmit() {
        var purchase_order_ce = document.getElementById("po_ce").value.trim();
        var purchase_order_uk = document.getElementById("po_uk").value.trim();
        var style_no_uk = document.getElementById("style_uk").value.trim();
        var style_no_ce = document.getElementById("style_ce").value.trim();
        var supplier_number = document.getElementById('supplier_number').value.trim();
        var factory_code = document.getElementById('factory_code').value.trim();
        var category = document.getElementById('category').value.trim();
        var country_of_origin = document.getElementById('country_of_origin').value.trim();
        var Brand = document.getElementById('Brand').value.trim();
        var cz = document.getElementById("cz").value.trim();
        var sk = document.getElementById("sk").value.trim();
        var en = document.getElementById("en").value.trim();
        var hu = document.getElementById("hu").value.trim();
        var tr = document.getElementById("tr").value.trim();
        var euro = document.getElementById("euro").value.trim();
        var pound = document.getElementById("pound").value.trim();

        var style = document.getElementById("style_type").selectedIndex;

        var techCnt = Object.keys(technical_labels).length;
        var eanCnt = Object.keys(ean_details).length;

        if (sellingCat === "1") {
            if ((cz !== "" && cz !== null) && (sk !== "" && sk !== null) && (en !== "" && en !== null) && (hu !== "" && hu !== null) && (tr !== "" && tr !== null)) {
                isSellingValidate = true;
            }
        } else if (sellingCat === "2") {
            if (euro !== "" && euro !== null && pound !== "" && pound !== null) {
                isSellingValidate = true;
            }
        }

        if (style === 1) {
            if (purchase_order_uk === "" || purchase_order_uk === null) {
                BootstrapDialog.alert('Purchase Order is Required.', function () {
                    $('html, body').animate({
                        scrollTop: $("#po_uk").offset().top - 125},
                    'slow', function () {
                        $("#po_uk").focus();
                    });
                    return;
                });
            }
            if (style_no_uk === "" || style_no_uk === null) {
                BootstrapDialog.alert('Style Number is Required.', function () {
                    $('html, body').animate({
                        scrollTop: $("#style_uk").offset().top - 125},
                    'slow', function () {
                        $("#style_uk").focus();
                    });
                    return;
                });
            }
        } else if (style === 2) {
            if (purchase_order_ce === "" || purchase_order_ce === null) {
                BootstrapDialog.alert('Purchase Order is Required.', function () {
                    $('html, body').animate({
                        scrollTop: $("#po_ce").offset().top - 125},
                    'slow', function () {
                        $("#po_ce").focus();
                    });
                    return;
                });
            }
            if (style_no_ce === "" || style_no_ce === null) {
                BootstrapDialog.alert('Style Number is Required.', function () {
                    $('html, body').animate({
                        scrollTop: $("#style_ce").offset().top - 125},
                    'slow', function () {
                        $("#style_ce").focus();
                    });
                    return;
                });
            }
        } else if (style === 3) {
            if ((purchase_order_ce === "" || purchase_order_ce === null) && (purchase_order_uk === "" || purchase_order_uk === null)) {
                BootstrapDialog.alert('Purchase Orders are required. ', function () {
                    $('html, body').animate({
                        scrollTop: $("#po_uk").offset().top - 125},
                    'slow', function () {
                        $("#po_uk").focus();
                    });
                    return;
                });
            }
            if ((style_no_uk === "" || style_no_uk === null) && (style_no_ce === "" || style_no_ce === null)) {
                BootstrapDialog.alert('Style Numbers are required. ', function () {
                    $('html, body').animate({
                        scrollTop: $("#style_uk").offset().top - 125},
                    'slow', function () {
                        $("#style_uk").focus();
                    });
                    return;
                });
            }
        }

        if (supplier_number === "" || supplier_number === null) {
            BootstrapDialog.alert('Supplier Number reqiured.', function () {
                $("#supplier_number").focus();
                return;
            });
        } else if (factory_code === "" || factory_code === null) {
            BootstrapDialog.alert('Factory Code reqiured.', function () {
                $("#factory_code").focus();
                return;
            });
        } else if (category === "" || category === null) {
            BootstrapDialog.alert('Category reqiured.', function () {
                $("#category").focus();
                return;
            });
        } else if (country_of_origin === "" || country_of_origin === null) {
            BootstrapDialog.alert('Supplier Number reqiured.', function () {
                $("#country_of_origin").focus();
                return;
            });
        } else if (Brand === "" || Brand === null) {
            BootstrapDialog.alert('Brand reqiured.', function () {
                $("#Brand").focus();
                return;
            });
        } else if (eanCnt === 0) {
            BootstrapDialog.alert('Mininum EAN Details Count One(1).', function () {
                return;
            });
        } else if (techCnt === 0) {
            BootstrapDialog.alert('Mininum Technical Label Count One(1).', function () {
                return;
            });
        } else {
            submitData();
        }

    }

    function submitData() {
        var purchase_order_uk = "";
        var purchase_order_ce = "";
        var style_no_uk = "";
        var style_no_ce = "";
        var style_type = document.getElementById("style_type").value;

        purchase_order_ce = document.getElementById("po_ce").value.trim();
        purchase_order_uk = document.getElementById("po_uk").value.trim();
        style_no_uk = document.getElementById("style_uk").value.trim();
        style_no_ce = document.getElementById("style_ce").value.trim();

        var supplier_number = document.getElementById('supplier_number').value.trim();
        var factory_code = document.getElementById('factory_code').value.trim();
        var category = document.getElementById('category').value.trim();
        var country_of_origin = document.getElementById('country_of_origin').value.trim();
        var Brand = document.getElementById('Brand').value.trim();
        var char_description = document.getElementById('char_description').value.trim();
        var season_code = document.getElementById('season_code').value.trim();
        var carton_dimensions = document.getElementById('carton_dimensions').value.trim();
        var comments = document.getElementById('comments').value.trim();
        var customer_po = document.getElementById('customer_po').value.trim();

        var value = {};
        var cz = document.getElementById("cz").value.trim();
        var sk = document.getElementById("sk").value.trim();
        var en = document.getElementById("en").value.trim();
        var hu = document.getElementById("hu").value.trim();
        var tr = document.getElementById("tr").value.trim();
        var euro = document.getElementById("euro").value.trim();
        var pound = document.getElementById("pound").value.trim();

        if (sellingCat === "1") {
            value["id"] = sellingCat;
            value["cz"] = cz;
            value["sk"] = sk;
            value["en"] = en;
            value["hu"] = hu;
            value["tr"] = tr;
        } else if (sellingCat === "2") {
            value["id"] = sellingCat;
            value["euro"] = euro;
            value["pound"] = pound;
        }

        var data = {};

        if (style_type == "uk" || style_type == "ce") {
            data["purchase_order_uk"] = purchase_order_uk;
            data["style_no_uk"] = style_no_uk;
        } else {
            data["purchase_order_uk"] = purchase_order_uk + " / " + purchase_order_ce;
            data["style_no_uk"] = style_no_uk + " / " + style_no_ce;
        }

        data["style_type"] = style_type;
        data["supplier_number"] = supplier_number;
        data["factory_code"] = factory_code;
        data["purchase_order_ce"] = "";
        data["category"] = category;
        data["country_of_origin"] = country_of_origin;
        data["style_no_ce"] = "";
        data["Brand"] = Brand;
        data["char_description"] = char_description;
        data["season_code"] = season_code;
        data["carton_dimensions"] = carton_dimensions;
        data["comments"] = comments;
        data["customer_po"] = customer_po;
        data["technical_labels"] = technical_labels;
        data["swing_tickets"] = swing_tickets;
        data["ean_details"] = ean_details;
        data["selling_prices"] = value;

        console.log(data);

        var jsonDetails = JSON.stringify(data);
        var jsonDetails = jsonDetails.replace(/&/g, "kbgz");
        
        console.log(jsonDetails);

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function () {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');
                if (reply === 1) {
                    BootstrapDialog.show({
                        message: 'Order has been submitted.',
                        closable: false,
                        type: BootstrapDialog.TYPE_SUCCESS,
                        size: BootstrapDialog.SIZE_SMALL,
                        buttons: [{label: 'Ok',
                                action: function (dialogRef) {
                                    dialogRef.close();
                                    window.location = "/IEPTescoNew/viewOrder.jsp";
                                }
                            }]
                    });
                } else {
                    sm_alert("Order has not been submitted.");
                }

            }
        };

        xmlHttp.open("POST", "/IEPTescoNew/SavePdf?data=" + jsonDetails, true);
        xmlHttp.send();

    }

</script>

<script type="text/javascript">

    function disable_grp_price() {

        if (document.getElementById("grp_price_2").checked) {
            sellingCat = "2";
            document.getElementById("euro").disabled = false;
            document.getElementById("pound").disabled = false;
            document.getElementById("cz").disabled = true;
            document.getElementById("sk").disabled = true;
            document.getElementById("en").disabled = true;
            document.getElementById("hu").disabled = true;
            document.getElementById("tr").disabled = true;

        }
        if (document.getElementById("grp_price_1").checked) {
            sellingCat = "1";
            document.getElementById("cz").disabled = false;
            document.getElementById("sk").disabled = false;
            document.getElementById("en").disabled = false;
            document.getElementById("hu").disabled = false;
            document.getElementById("tr").disabled = false;
            document.getElementById("euro").disabled = true;
            document.getElementById("pound").disabled = true;
        }

    }

    function validateDecimal(sender) {
        if (sender.value.match(/^(\d+)?\.\d$/))
            alert("YES");// Approval, No Message Required
        else
            alert("NO");// Can output a friendly message to the user here
    }

    function checkForSecondDecimal(sender, e) {
        formatBox = document.getElementById(sender.id);
        strLen = sender.value.length;
        strVal = sender.value;
        hasDec = false;
        e = (e) ? e : (window.event) ? event : null;


        if (e) {
            var charCode = (e.charCode) ? e.charCode :
                    ((e.keyCode) ? e.keyCode :
                            ((e.which) ? e.which : 0));

            if (charCode > 47) {
                if (charCode < 58) {
                    return true;
                }
            } else if (charCode > 95) {
                if (charCode < 106) {
                    return true;
                }

            } else if ((charCode === 46) || (charCode === 110) || (charCode === 190)) {
                for (var i = 0; i < strLen; i++) {
                    hasDec = (strVal.charAt(i) === '.');
                    if (hasDec) {
                        return false;
                    }
                }
                return true;
            }
        }
        return false;
    }

    function isNumber(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }

</script>



<script type="text/javascript">

    function getSizebyEAN() {
        var eanNo = document.getElementById('ean_no').value;
        var styleno = document.getElementById("style_No");
        var size = styleno.value.replace(/[^0-9]/g, "").length;
        eanNo = eanNo + '_' + size;
        document.getElementById("department_ID").options.length = 1;
        var xmlHttp1 = getAjaxObject();
        xmlHttp1.onreadystatechange = function ()
        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
            {
                var deptObj = eval('(' + xmlHttp1.responseText + ')');
                var size1 = deptObj.size;

                var dept = deptObj.dept.length;
                document.getElementById('primary_size_ID').value = size1;
                var oon = document.getElementById("department_ID");
                for (var k = 0; k < dept; k++) {
                    var opt = deptObj.dept[k];
                    var el = document.createElement("option");
                    el.textContent = opt;
                    el.value = opt;
                    oon.appendChild(el);
                }
            }
        };
        xmlHttp1.open("POST", "/IEPTescoNew/ExtracterController?action=getSizes&eanNo=" + eanNo, true);
        xmlHttp1.send();
    }

    function checkSecSizeSelectedOrNot() {
        var isChecked = $('#check_none').is(':checked');
        if (isChecked) {
            var chkArrayforSecSize = [];
            $("#checkboxlist input:checked").each(function () {
                chkArrayforSecSize.push($(this).val());
            });

            if (chkArrayforSecSize.length > 4) {
                nom_warning("Maximum Secondary Sizes Count is Four(4). ");
                return;
            }

            var ch = "";
            if (chkArrayforSecSize.length > 0) {
                ch = chkArrayforSecSize[0];
                for (var ii = 1; ii < chkArrayforSecSize.length; ii++) {
                    ch += " / " + chkArrayforSecSize[ii];
                }
            }

            if ($('#checkboxlist input').length === 1) {
                checkUKandCEPrimarySizesWithDept();
            } else {
                if (ch.length === 0) {
                    sm_warning("Please Select Secondary Size : ");
                } else {
                    checkUKandCEPrimarySizesWithDept();
                }
            }

        } else {
            checkUKandCEPrimarySizesWithDept();
        }

//        document.getElementById("check_sec_size").disabled = true;

    }

    function checkStyleNomber() {
        var style_No = document.getElementById('style_type').selectedIndex;
        if (style_No <= 0) {
            BootstrapDialog.alert({
                title: 'WARNING',
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Select a Style Type.',
                type: BootstrapDialog.TYPE_WARNING,
                callback: function (result) {
                    $('html, body').animate({
                        scrollTop: $("#style_type").offset().top - 125},
                    'slow', function () {
                        $("#style_type").focus();
                    });
                }
            });
        }
    }

    var EAN_Detail = {};

    function getSecondrySizes() {
        document.getElementById("check_none").checked = false;
        var dept = document.getElementById("department_ID").value;
        var xmlHttp1 = getAjaxObject();

        xmlHttp1.onreadystatechange = function ()
        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
            {

                var data = eval('(' + xmlHttp1.responseText + ')');

                var secView = document.getElementById("secView");
                $("#secView").empty();
                $("#secView").hide();

                var secSizeData = data.second_sizes;
                var outerDiv;
                var innerDiv;
                var secSize = [];

                if (secSizeData.length > 0) {
                    document.getElementById("check_sec_size").disabled = false;
                    document.getElementById("check_none").disabled = false;
                } else {
                    document.getElementById("check_none").disabled = true;
                }

                for (var k in secSizeData) {

                    outerDiv = document.createElement("div");
                    outerDiv.className = "col-lg-2 form-inline";

                    innerDiv = document.createElement("div");
                    innerDiv.className = "form-group";

                    var tempLabel = document.createElement("label");
                    tempLabel.innerHTML = " &nbsp; &nbsp;" + secSizeData[k];
                    tempLabel.className = "control-label";
                    var tempCheck = document.createElement("input");
                    tempCheck.type = "checkbox";
                    tempCheck.className = "form-control";
                    tempCheck.name = secSizeData[k];
                    tempCheck.value = secSizeData[k];
                    tempCheck.id = "secSizeCheck";
                    innerDiv.appendChild(tempCheck);
                    innerDiv.appendChild(tempLabel);
                    outerDiv.appendChild(innerDiv);
                    secSize[tempCheck];
                    secView.appendChild(outerDiv);


                }
            }
        };
        xmlHttp1.open("POST", "/IEPTescoNew/Controller?method=getSizes2&department=" + dept, true);
        xmlHttp1.send();

    }

    function checkUKandCEPrimarySizesWithDept() {

        "use strict";
        var dept = document.getElementById("department_ID").value;
        var styleTypeforUkCe = document.getElementById("style_type").value;

        var xmlHttp1 = getAjaxObject();

        var table = document.getElementById('eanTable').getElementsByTagName('tbody')[0];
        var dataArr = [];

        for (var x = 0; x < table.rows.length; x++) {
            var rw = table.rows[x];
            var secSize = rw.cells[2].innerHTML;
            dataArr.push(secSize.trim());
        }

        var data = {};
        data["sizes"] = dataArr;
        data["department"] = dept;
        data["style_type"] = styleTypeforUkCe;

        var sendData = JSON.stringify(data);


        xmlHttp1.onreadystatechange = function () {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200) {

                var eanDetails = eval('(' + xmlHttp1.responseText + ')');

                var eans = eanDetails.exsistingPrimary;
                var chkArray = [];
                $("#checkboxlist input:checked").each(function () {
                    chkArray.push($(this).val());
                });

                var ch = "";
                if (chkArray.length > 0) {
                    ch = chkArray[0];
                    for (var ii = 1; ii < chkArray.length; ii++) {
                        ch += " / " + chkArray[ii];
                    }
                }

                for (var x = 0; x < table.rows.length; x++) {
                    var rw = table.rows[x];
                    var primrySize = rw.cells[2].innerHTML;
                    for (var ii = 0; ii < eans.length; ii++) {
                        if (primrySize.trim() === eans[ii].trim()) {
                            var arrMarkMail = document.getElementById(eans[ii]);
                            arrMarkMail.checked = true;

                            var rws = table.rows[x];
                            rws.cells[4].innerHTML = ch;
                            var departmentFortble = table.rows[x];
                            departmentFortble.cells[5].innerHTML = dept;
                        }
                    }
                }
                $("#secView").empty();
            }
        };
        xmlHttp1.open("POST", "/IEPTescoNew/Controller?method=checkUKandCEPrimarySizesWithDept&data=" + sendData, true);
        xmlHttp1.send();
    }

    function FcheckForExist() {
        var ean_no = document.getElementById("ean_no").value;
        var eanCount = Object.keys(ean_details).length;
        if (eanCount > 0) {
            for (var key in ean_details) {
                if (key === ean_no) {
                    sm_alert("EAN No already exists.");
                    document.getElementById(ean_no).value = "";
                    return;
                }
            }
        }
    }

    function checkEAN() {
        var ean_no = document.getElementById("ean_no").value;
        if (ean_no.length !== 13) {
            sm_alert("Incorrect EAN Format");
        } else {
            checkForExist();
        }
    }

    function getEanDetail() {
        var eanchkCount = $("#eanTable tbody tr").length;
        var checkboxes = $("#eanTable [type='checkbox']:checked").length;

        if (eanchkCount !== checkboxes) {
            sm_alert("Please fill all required fields.");
            return;
        }


        var table = document.getElementById('eanTable').getElementsByTagName('tbody')[0];
        var style_te = document.getElementById("style_type").selectedIndex;
        var secSize = [];
        for (var x = 0; x < table.rows.length; x++) {
            var eanDetail = {};

            var rw = table.rows[x];

            var eanDetailNo = rw.cells[1].innerHTML;
            var ukPrime = rw.cells[2].innerHTML;
            var cePrime = rw.cells[3].innerHTML;
            var secondarySize = rw.cells[4].innerHTML;
            secondarySize = secondarySize.trim();

            secSize = secondarySize.split('/');

            var dept = rw.cells[5].innerHTML;
            var tblquantity = rw.cells[6].children[0];
            var tblcolor = rw.cells[7].children[0];

            var ean = eanDetailNo.trim();

//            if (style_te == 1) {
//                eanDetail["uk_size"] = primarySize.trim();
//                eanDetail["uk_ean"] = ean;
//                eanDetail["ce_size"] = "";
//                eanDetail["ce_ean"] = "";
//            } else if (style_te == 2) {
//                eanDetail["uk_size"] = "";
//                eanDetail["uk_ean"] = "ean";
//                eanDetail["ce_size"] = primarySize.trim();
//                eanDetail["ce_ean"] = ean;
//            }

            eanDetail["uk_ean"] = ean;
            eanDetail["uk_size"] = ukPrime;
            eanDetail["ce_size"] = cePrime;
            eanDetail["department"] = dept;
            eanDetail["quantity"] = tblquantity.value;
            eanDetail["color"] = tblcolor.value;
            eanDetail["secSize"] = secSize;
            ean_details[ean] = eanDetail;

        }
        sm_notify("EAN Details Verified Successfully.");
    }

</script>

<script type="text/javascript">
    var temp_technical_care = {};
    var temp_technical_fiber = {};
    function addTechCare() {
        var tempTechCare = {};
        var tblTechCare = document.getElementById('tblTechCare').getElementsByTagName('tbody')[0];
        var techcareInfo = document.getElementById('techcareInfo');
        if (techcareInfo.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("techcareInfo").focus();
            return;
        }
        var careInfo = techcareInfo.value;
        $("#techcareInfo option[value='" + careInfo + "']").prop('disabled', true);
        var spliter = careInfo.split(')');
        var ct_code = spliter[0].trim();
        var ct_name = spliter[1].trim();
        var row = document.createElement("tr");
        row.id = ct_code;
        var col1 = document.createElement("td");
        col1.type = "text";
        col1.value = ct_code;
        col1.innerHTML = ct_code;
        var col2 = document.createElement("td");
        col2.type = "text";
        col2.value = ct_name;
        col2.innerHTML = ct_name;
        var col3 = document.createElement("td");
        var elem1 = document.createElement("span");
        elem1.id = ct_code;
        elem1.name = ct_name;
        elem1.type = "button";
        elem1.className = "btn btn-default glyphicon glyphicon-remove text-center";
        col3.appendChild(elem1);
        row.appendChild(col1);
        row.appendChild(col2);
        row.appendChild(col3);
        tempTechCare["ct_code"] = ct_code;
        tempTechCare["ct_name"] = ct_name;
        temp_technical_care[ct_code] = tempTechCare;
        tblTechCare.appendChild(row);
        techcareInfo.options.selectedIndex = 0;
    }

    var temp_fiberDetail = {};
    function addFiber() {
        var tempTechFiber = {};
        var fiberType = document.getElementById("fiberName");
        var fiberQuantity = document.getElementById("fiberQuantity").value;
        var remainQuantity = parseInt(document.getElementById("txt_fiberQuantity").value);
        var fiberCount = document.getElementById("txt_fiberCount").value;
        if ((fiberType.selectedIndex === 0) && (fiberQuantity === "" || fiberQuantity === null)) {
            sm_alert("Please enter Fiber Type & Fiber Quantity.");
            document.getElementById("fiberName").focus();
            return;
        } else if (fiberType.selectedIndex === 0) {
            sm_alert("Please enter Fiber Type.");
            document.getElementById("fiberName").focus();
            return;
        } else if (fiberQuantity === "" || fiberQuantity === null) {
            sm_alert("Please enter Fiber Quantity.");
            document.getElementById("fiberQuantity").focus();
            return;
        } else if (fiberCount > 6) {
            sm_alert("Maximum Fiber Count Reached. Maximum count is Six(6).");
            document.getElementById("fiberName").selectedIndex = 0;
            document.getElementById("fiberQuantity").value = "";
            document.getElementById("fiberQuantity").placeholder = "Remain Amount : " + remainQuantity;
            return;
        } else if (fiberQuantity > remainQuantity) {
            sm_alert("Maximum Fiber Amount Reached. Maximum Amount is Hundred(100). ");
            document.getElementById("fiberName").selectedIndex = 0;
            document.getElementById("fiberQuantity").value = "";
            document.getElementById("fiberQuantity").placeholder = "Remain Amount : " + remainQuantity;
            return;
        }

        var mainWord = document.getElementById("txt_mainWord").value;
        if (mainWord === "" || mainWord === null) {
            mainWord = document.getElementById("mainWord").value;
            document.getElementById("txt_mainWord").value = mainWord;
            document.getElementById("mainWord").disabled = true;
        }

        var tblTechFiber = document.getElementById('tblFiber').getElementsByTagName('tbody')[0];
        var row = document.createElement("tr");
        row.id = fiberType;
        var col2 = document.createElement("td");
        col2.type = "text";
        col2.value = fiberType.value;
        col2.innerHTML = fiberType.value;
        var col3 = document.createElement("td");
        col3.type = "text";
        col3.value = fiberQuantity;
        col3.innerHTML = fiberQuantity;
        var col4 = document.createElement("td");
        var elem1 = document.createElement("span");
        elem1.id = fiberType.value;
        elem1.name = fiberQuantity;
        elem1.type = "button";
        elem1.className = "btn btn-default glyphicon glyphicon-remove text-center";
        col4.appendChild(elem1);
        row.appendChild(col2);
        row.appendChild(col3);
        row.appendChild(col4);
        tblTechFiber.appendChild(row);
        tempTechFiber["fiber_type"] = fiberType.value;
        tempTechFiber["fiber_quantity"] = fiberQuantity;
        temp_fiberDetail["mainword"] = mainWord;
        temp_fiberDetail["fiber_" + fiberCount] = tempTechFiber;
        document.getElementById("txt_fiberCount").value = parseInt(fiberCount) + 1;
        remainQuantity = remainQuantity - parseInt(fiberQuantity);
        $("#fiberName option[value='" + fiberType.value + "']").prop('disabled', true);
        document.getElementById("fiberQuantity").value = "";
        document.getElementById("fiberQuantity").placeholder = "Remain Amount : " + remainQuantity;
        document.getElementById("txt_fiberQuantity").value = remainQuantity;
        document.getElementById("fiberName").selectedIndex = 0;
        if (remainQuantity === 0) {
            document.getElementById("btn_addFiberCompo").disabled = false;
        }
    }

    function addFiberCompo() {
        var count = Object.keys(temp_fiberDetail).length;
        var noOfFiberComposition = document.getElementById("fiberComposition").value;
        var txt_fiberCompo = temp_fiberDetail["mainword"] + " : " + temp_fiberDetail["fiber_1"].fiber_quantity + "ZXZY " + temp_fiberDetail["fiber_1"].fiber_type;
        $("#fiberName option[value='" + temp_fiberDetail["fiber_1"].fiber_type + "']").prop('disabled', false);
        $("#mainWord option[value='" + temp_fiberDetail["mainword"] + "'").prop('disabled', true);
        for (i = 2; i < count; i++) {
            txt_fiberCompo += ", " + temp_fiberDetail["fiber_" + i].fiber_quantity + "ZXZY " + temp_fiberDetail["fiber_" + i].fiber_type;
            $("#fiberName option[value='" + temp_fiberDetail["fiber_" + i].fiber_type + "']").prop('disabled', false);
        }

        var tbl_fiberCompo = document.getElementById('tbl_fiberCompo').getElementsByTagName('tbody')[0];
        var row = document.createElement("tr");
        row.id = "Fiber Composition " + noOfFiberComposition;

        var col2 = document.createElement("td");
        col2.type = "text";
        col2.value = txt_fiberCompo.replace(/ZXZY/g, "%");
        col2.innerHTML = txt_fiberCompo.replace(/ZXZY/g, "%");
        var col3 = document.createElement("td");
        var elem1 = document.createElement("span");
        elem1.id = "Fiber Composition : ";
        elem1.name = temp_fiberDetail["mainword"];
        elem1.type = "button";
        elem1.className = "btn btn-default glyphicon glyphicon-remove text-center";
        col3.appendChild(elem1);
        row.appendChild(col2);
        row.appendChild(col3);
        tbl_fiberCompo.appendChild(row);
        temp_technical_fiber["Fiber Composition : " + temp_fiberDetail["mainword"]] = txt_fiberCompo;
        document.getElementById("fiberComposition").value = parseInt(noOfFiberComposition) + 1;
        document.getElementById("mainWord").disabled = false;
        document.getElementById("mainWord").selectedIndex = 0;
        document.getElementById("fiberName").selectedIndex = 0;
        document.getElementById("fiberQuantity").value = "";
        document.getElementById("fiberQuantity").placeholder = "Remain Amount : 100";
        document.getElementById("txt_mainWord").value = "";
        document.getElementById("txt_fiberCount").value = 1;
        document.getElementById("txt_fiberQuantity").value = 100;
        document.getElementById("btn_addFiber").disabled = true;
        document.getElementById("btn_addFiberCompo").disabled = true;
        if (document.getElementById("fiberComposition").value === "7") {
            document.getElementById("fiberComposition").value = "#";
            document.getElementById("mainWord").disabled = true;
            document.getElementById("fiberName").disabled = true;
            document.getElementById("fiberQuantity").disabled = true;
        }

        temp_fiberDetail = {};
        $("#tblFiber tbody").empty();
    }

    function clearTechLabel() {
        btnTechWashClear();
        document.getElementById("techlabelId").value = "";
        document.getElementById("tech_labelRefId").value = "";
        document.getElementById("tech_labelGroupId").value = "";
        document.getElementById("tech_lbl_des").value = "";
        document.getElementById("techcareInfo").selectedIndex = 0;
        document.getElementById("fiberComposition").value = 1;
        document.getElementById("txt_mainWord").value = "";
        document.getElementById("mainWord").selectedIndex = 0;
        document.getElementById("mainWord").disabled = false;
        document.getElementById("fiberName").selectedIndex = 0;
        document.getElementById("fiberName").disabled = false;
        document.getElementById("fiberQuantity").value = "";
        document.getElementById("fiberQuantity").disabled = false;
        document.getElementById("txt_fiberCount").value = 1;
        document.getElementById("txt_fiberQuantity").value = 100;
        document.getElementById("tech_labelGroupId").readOnly = false;
        document.getElementById("tech_lbl_des").readOnly = false;
        document.getElementById("tech_labelRefId").readOnly = false;
        $("#sizeTechImage").attr("src", "");
        $("#tblTechCare tbody").empty();
        $("#tblFiber tbody").empty();
        $("#tbl_fiberCompo tbody").empty();
        var techCareCount = Object.keys(temp_technical_care).length;
        if (techCareCount > 0) {
            for (var key in temp_technical_care) {
                $("#techcareInfo option[id='" + key + "'").prop('disabled', false);
            }
        }

        var techFiberDetail = Object.keys(temp_fiberDetail).length;
        if (techFiberDetail > 0) {
            $("#mainWord option[value='" + techFiberDetail["mainword"] + "'").prop('disabled', false);
        }

        var techLabel = Object.keys(temp_technical_fiber).length;
        if (techLabel > 0) {
            for (var key in temp_technical_fiber) {
                data = [];
                data = key.split(" : ");
                $("#mainWord option[value='" + data[1] + "'").prop('disabled', false);
            }
        }

    }

    function confirmTechLabel() {
        BootstrapDialog.confirm({
            title: 'Notification',
            message: 'Do you want to add this label details ?',
            type: BootstrapDialog.TYPE_PRIMARY,
            closable: true,
            draggable: true,
            btnCancelLabel: 'No',
            btnOKLabel: 'Yes',
            callback: function (result) {
                if (result) {
                    addTechLabel();
                } else {
                    return;
                }
            }
        });
    }

    function addTechLabel() {

        var techAllCareArray = [];
        for (var key in temp_technical_care) {
            techAllCareArray.push(key);
        }
        var techAllCare = "";
        if (techAllCareArray.length > 0) {
            techAllCare = techAllCareArray[0];
            for (i = 1; i < techAllCareArray.length; i++) {
                techAllCare += " / " + techAllCareArray[i];
            }
        }

        var tech_labelRef = document.getElementById("tech_labelRefId");
        var tech_labelGroup = document.getElementById("tech_labelGroupId");
        var tech_lbl_des = document.getElementById("tech_lbl_des").value.trim();
        var tech_wash_symbol = document.getElementById("techWashTxt_W").value.trim() + document.getElementById("techWashTxt_B").value.trim() + document.getElementById("techWashTxt_D").value.trim() + document.getElementById("techWashTxt_I").value.trim() + document.getElementById("techWashTxt_C").value.trim();
        var techFiberCount = Object.keys(temp_technical_fiber).length;
        var techCareCount = Object.keys(temp_technical_care).length;
        if (tech_labelRef.value === "" || tech_labelRef.value === null) {
            sm_alert("Label Reference is a required feild.");
            $('html, body').animate({
                scrollTop: $("#tech_labelRefId").offset().top - 125},
            'slow', function () {
                $("#tech_labelRefId").focus();
                return;
            });
        } else if (tech_labelGroup.value === "" || tech_labelGroup.value === null) {
            sm_alert("Label Group is a required feild.");
            $('html, body').animate({
                scrollTop: $("#tech_labelGroupId").offset().top - 125},
            'slow', function () {
                $("#tech_labelRefId").focus();
                return;
            });
        } else if (tech_lbl_des === "" || tech_lbl_des === null) {
            sm_alert("Label Description is a required feild.");
            $('html, body').animate({
                scrollTop: $("#tech_lbl_des").offset().top - 125},
            'slow', function () {
                $("#tech_lbl_des").focus();
                return;
            });
        } else if (techFiberCount === 0) {
            sm_alert("Minimum Fiber Composition count is 1.");
            return;
        } else if (techCareCount === 0) {
            sm_alert("Minimum Care Information count is 1.");
            return;
        } else if (tech_wash_symbol.length !== 20) {
            sm_alert("Wash Symbol is a required feild.");
            $('html, body').animate({
                scrollTop: $("#techWash_W").offset().top - 125},
            'slow', function () {
                $("#techWash_W").focus();
                return;
            });
        } else {
            var temp_technical_label = {};
            var technical_labels_count = Object.keys(technical_labels).length;
            var labeId = document.getElementById("techlabelId").value;
            var isExit = true;
            var randomKey = "";
            if (labeId.length > 0) {
                randomKey = labeId;
            } else {
                while (isExit) {
                    randomKey = Math.floor(Math.random() * 100) + 1;
                    if (technical_labels_count > 0) {
                        for (var key in technical_labels) {
                            if (key != randomKey) {
                                isExit = false;
                                break;
                            }
                        }
                    } else {
                        isExit = false;
                        break;
                    }
                }
            }

            temp_technical_label["tech_key"] = randomKey;
            temp_technical_label["tech_labelRef"] = tech_labelRef.value.trim();
            temp_technical_label["tech_labelGroup"] = tech_labelGroup.value.trim();
            temp_technical_label["tech_lbl_des"] = tech_lbl_des;
            temp_technical_label["temp_technical_care"] = techAllCare;
            temp_technical_label["temp_technical_fiber"] = temp_technical_fiber;
            temp_technical_label["tech_wash_symbol"] = tech_wash_symbol;
            technical_labels[randomKey] = temp_technical_label;
            $("#tblTechCare tbody").empty();
            tech_labelRef.value = "";
            tech_labelGroup.value = "";
            document.getElementById("tech_lbl_des").value = "";
            tech_wash_symbol.selectedIndex = 0;
            document.getElementById("fiberComposition").value = 1;
            document.getElementById("mainWord").disabled = false;
            document.getElementById("fiberName").disabled = false;
            document.getElementById("fiberQuantity").disabled = false;
            for (var key in temp_technical_fiber) {
                data = [];
                data = key.split(" : ");
                $("#mainWord option[value='" + data[1] + "'").prop('disabled', false);
            }

            for (var key in temp_technical_care) {
                var keyVal = temp_technical_care[key].ct_code;
                $("#techcareInfo option[id='" + keyVal + "'").prop('disabled', false);
            }

            temp_technical_care = {};
            temp_technical_fiber = {};
            displayTechnical(technical_labels);
            closeTech();
        }
    }

    function displayTechnical(technicallabels) {
        $("#techView").empty();
        var techLabelCount = Object.keys(technicallabels).length;

        document.getElementById("techCount").innerHTML = "No of Technical Labels : " + techLabelCount;
        if (techLabelCount > 0) {
            var fico = [];
            fico[0] = "";
            fico[1] = "";
            fico[2] = "";
            fico[3] = "";
            for (var key in technicallabels) {
                var fico = [];
                fico[0] = "";
                fico[1] = "";
                fico[2] = "";
                fico[3] = "";
                var keyVal = technicallabels[key];
                i = 0;
                for (var k in keyVal.temp_technical_fiber) {
                    var data = keyVal.temp_technical_fiber[k];
                    fico[i] = data.replace(/ZXZY/g, "%");
                    i++;
                }

                var techView = document.getElementById("techView");
                var techDiv = document.createElement("div");
                techDiv.id = key;
                var techTabel = document.createElement("table");
                techTabel.className = "table table-bordered table-striped";
                techTabel.width = "100%";
                var techTbody = document.createElement("tbody");
                var techRow1 = document.createElement("tr");
                var techRow2 = document.createElement("tr");
                var techRow3 = document.createElement("tr");
                var techRow4 = document.createElement("tr");
                var techRow5 = document.createElement("tr");
                var techRow6 = document.createElement("tr");
                var techRow7 = document.createElement("tr");
                var techRow8 = document.createElement("tr");
                var techRow9 = document.createElement("tr");
                var techR1Col1 = document.createElement("td");
                techR1Col1.innerHTML = "Reference";
                techR1Col1.width = "15%";
                var techR1Col2 = document.createElement("td");
                techR1Col2.innerHTML = keyVal.tech_labelRef;
                var techR1Col3 = document.createElement("td");
                techR1Col3.width = "30%";
                techR1Col3.rowSpan = "1";
                var elem1 = document.createElement("input");
                elem1.id = "hidden_" + key;
                elem1.value = JSON.stringify(keyVal);
                elem1.name = "techlabel";
                elem1.type = "hidden";
                var elem2 = document.createElement("input");
                elem2.id = key;
                elem2.value = "Options";
                elem2.name = "tech_label";
                elem2.type = "button";
                elem2.className = "form-control btn btn-info";
                techR1Col3.appendChild(elem1);
                techR1Col3.appendChild(elem2);
                var techR2Col1 = document.createElement("td");
                techR2Col1.innerHTML = "Description";
                var techR2Col2 = document.createElement("td");
                techR2Col2.innerHTML = keyVal.tech_lbl_des + "(" + keyVal.tech_labelGroup + ")";
                var techR3Col1 = document.createElement("td");
                techR3Col1.innerHTML = "Wash Symbol";
                var techR3Col2 = document.createElement("td");
                techR3Col2.innerHTML = keyVal.tech_wash_symbol;
                var techR4Col1 = document.createElement("td");
                techR4Col1.innerHTML = "Additional Care Info";
                var techR4Col2 = document.createElement("td");
                techR4Col2.innerHTML = keyVal.temp_technical_care;
                var techR5Col1 = document.createElement("td");
                techR5Col1.innerHTML = "Fiber Composition 1";
                var techR5Col2 = document.createElement("td");
                techR5Col2.innerHTML = fico[0];
                var techR6Col1 = document.createElement("td");
                techR6Col1.innerHTML = "Fiber Composition 2";
                var techR6Col2 = document.createElement("td");
                techR6Col2.innerHTML = fico[1];
                var techR7Col1 = document.createElement("td");
                techR7Col1.innerHTML = "Fiber Composition 3";
                var techR7Col2 = document.createElement("td");
                techR7Col2.innerHTML = fico[2];
                var techR8Col1 = document.createElement("td");
                techR8Col1.innerHTML = "Fiber Composition 4";
                var techR8Col2 = document.createElement("td");
                techR8Col2.innerHTML = fico[3];
                techRow1.appendChild(techR1Col1);
                techRow1.appendChild(techR1Col2);
                techRow1.appendChild(techR1Col3);
                techRow2.appendChild(techR2Col1);
                techRow2.appendChild(techR2Col2);
                techRow3.appendChild(techR3Col1);
                techRow3.appendChild(techR3Col2);
                techRow4.appendChild(techR4Col1);
                techRow4.appendChild(techR4Col2);
                techRow5.appendChild(techR5Col1);
                techRow5.appendChild(techR5Col2);
                techRow6.appendChild(techR6Col1);
                techRow6.appendChild(techR6Col2);
                techRow7.appendChild(techR7Col1);
                techRow7.appendChild(techR7Col2);
                techRow8.appendChild(techR8Col1);
                techRow8.appendChild(techR8Col2);
                techTbody.appendChild(techRow1);
                techTbody.appendChild(techRow2);
                techTbody.appendChild(techRow3);
                techTbody.appendChild(techRow4);
                techTbody.appendChild(techRow5);
                techTbody.appendChild(techRow6);
                techTbody.appendChild(techRow7);
                techTbody.appendChild(techRow8);
                techTabel.appendChild(techTbody);
                techDiv.appendChild(techTabel);
                techView.appendChild(techDiv);
            }
        }
    }

    function getMainWord() {
        document.getElementById("btn_addFiber").disabled = false;
    }

</script>

<script type="text/javascript">
    var temp_swing_care = {};
    function addSwingCare() {
        var tempSwingCare = {};
        var tblSwingCare = document.getElementById('tblSwingCare').getElementsByTagName('tbody')[0];
        var swingcareInfo = document.getElementById('swingcareInfo');
        if (swingcareInfo.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("swingcareInfo").focus();
            return;
        }
        var careInfo = swingcareInfo.value;
        $("#swingcareInfo option[value='" + careInfo + "']").prop('disabled', true);
        var spliter = careInfo.split(')');
        var ct_code = spliter[0].trim();
        var ct_name = spliter[1].trim();
        var row = document.createElement("tr");
        row.id = ct_code;
        var col1 = document.createElement("td");
        col1.type = "text";
        col1.value = ct_code;
        col1.innerHTML = ct_code;
        var col2 = document.createElement("td");
        col2.type = "text";
        col2.value = ct_name;
        col2.innerHTML = ct_name;
        var col3 = document.createElement("td");
        var elem1 = document.createElement("span");
        elem1.id = ct_code;
        elem1.name = ct_name;
        elem1.type = "button";
        elem1.className = "btn btn-default glyphicon glyphicon-remove text-center";
        col3.appendChild(elem1);
        row.appendChild(col1);
        row.appendChild(col2);
        row.appendChild(col3);
        tempSwingCare["ct_code"] = ct_code;
        tempSwingCare["ct_name"] = ct_name;
        temp_swing_care[ct_code] = tempSwingCare;
        tblSwingCare.appendChild(row);
        document.getElementById("swingcareInfo").selectedIndex = 0;
    }

    function addSwingLabel() {

        var swingAllCareArray = [];
        for (var key in temp_swing_care) {
            swingAllCareArray.push(key);
        }
        var swingAllCare = "";
        if (swingAllCareArray.length > 0) {
            swingAllCare = swingAllCareArray[0];
            for (i = 1; i < swingAllCareArray.length; i++) {
                swingAllCare += " / " + swingAllCareArray[i];
            }
        }

        var swing_labelRef_front = document.getElementById("swing_labelRef_frontId");
        var swing_labelRef_back = document.getElementById("swing_labelRef_backId");
        var swing_labelGroup = document.getElementById("swing_labelGroupId");
        var swing_lbl_des = document.getElementById("swing_lbl_des").value.trim();
        var swing_wash_symbol = document.getElementById("swingWashTxt_W").value.trim() + document.getElementById("swingWashTxt_B").value.trim() + document.getElementById("swingWashTxt_D").value.trim() + document.getElementById("swingWashTxt_I").value.trim() + document.getElementById("swingWashTxt_C").value.trim();
        var trendName = document.getElementById("txt_trend");
        var productBenefit = document.getElementById("txt_product_benefit");
        var productDescription = document.getElementById("txt_product_description");
        if ((swing_labelRef_front.value === "" || swing_labelRef_front.value === null) && (swing_labelRef_back.value === "" || swing_labelRef_back.value === null)) {
            sm_alert("Please add at least one referense.");
            $('html, body').animate({
                scrollTop: $("#swing_labelRef_frontId").offset().top - 125},
            'slow', function () {
                $("#swing_labelRef_frontId").focus();
                return;
            });
        } else if (swing_labelRef_front.value === swing_labelRef_back.value) {
            sm_alert("Similar Label References.");
            $('html, body').animate({
                scrollTop: $("#swing_labelRef_frontId").offset().top - 125},
            'slow', function () {
                $("#swing_labelRef_frontId").focus();
                return;
            });
        } else if (swing_labelGroup.value === "" || swing_labelGroup.value === null) {
            sm_alert("Label Group is a required feild.");
            $('html, body').animate({
                scrollTop: $("#swing_labelGroupId").offset().top - 125},
            'slow', function () {
                $("#swing_labelGroupId").focus();
                return;
            });
        } else if (swing_lbl_des === "" || swing_lbl_des === null) {
            sm_alert("Label Description is a required feild.");
            $('html, body').animate({
                scrollTop: $("#swing_lbl_des").offset().top - 125},
            'slow', function () {
                $("#swing_lbl_des").focus();
                return;
            });
        } else {
            var ref = "";
            if (swing_labelRef_front.value !== "" && swing_labelRef_back.value !== "") {
                ref = swing_labelRef_front.value + ", " + swing_labelRef_back.value;
            } else if (swing_labelRef_front.value !== "") {
                ref = swing_labelRef_front.value;
            } else if (swing_labelRef_back.value !== "") {
                ref = "__ , " + swing_labelRef_back.value;
            }

            var temp_swing_ticket = {};
            var swing_ticket_count = Object.keys(swing_tickets).length;
            var labelId = document.getElementById("swinglabelId").value;

            var isExit = true;
            var randomKey = "";
            if (labelId.length > 0) {
                randomKey = labelId;
            } else {
                while (isExit) {
                    randomKey = Math.floor(Math.random() * 100) + 1;
                    if (swing_ticket_count > 0) {
                        for (var key in swing_tickets) {
                            if (key != randomKey) {
                                isExit = false;
                                break;
                            }
                        }
                    } else {
                        isExit = false;
                        break;
                    }
                }
            }

            temp_swing_ticket["swing_key"] = randomKey;
            temp_swing_ticket["swing_labelRef"] = ref;
            temp_swing_ticket["swing_labelGroup"] = swing_labelGroup.value.trim();
            temp_swing_ticket["swing_lbl_des"] = swing_lbl_des;
            temp_swing_ticket["temp_swing_care"] = swingAllCare;
            temp_swing_ticket["swing_wash_symbol"] = swing_wash_symbol;
            temp_swing_ticket["trend_name"] = trendName.value;
            temp_swing_ticket["product_benefit"] = productBenefit.value;
            temp_swing_ticket["product_description"] = productDescription.value;
            swing_tickets[randomKey] = temp_swing_ticket;
            document.getElementById("swingCount").innerHTML = "No of Swing Tickets : " + (swing_ticket_count + 1);
            $("#tblSwingCare tbody").empty();
            swing_labelRef_back.value = "";
            swing_labelRef_front.value = "";
            swing_labelGroup.value = "";
            document.getElementById("swing_lbl_des").value = "";
            swing_wash_symbol.selectedIndex = 0;
            for (var key in temp_swing_care) {
                keyVal = temp_swing_care[key].ct_code;
                $("#swingcareInfo option[id='" + keyVal + "'").prop('disabled', false);
            }
            temp_swing_care = {};
            displaySwing(swing_tickets);
            closeSwing();
            clearSwing();
            $("#swing").hide();
        }
    }

    function displaySwing(swingTickets) {
        $("#swingView").empty();
        var swingTicketCount = Object.keys(swingTickets).length;
        document.getElementById("swingCount").innerHTML = "No of Technical Labels : " + swingTicketCount;
        if (swingTicketCount > 0) {

            for (var key in swingTickets) {

                var keyVal = swingTickets[key];
                var swingView = document.getElementById("swingView");
                var swingDiv = document.createElement("div");
                var swingTabel = document.createElement("table");
                swingTabel.className = "table table-bordered table-striped";
                swingTabel.width = "100%";
                var swingTbody = document.createElement("tbody");
                var swingRow1 = document.createElement("tr");
                var swingRow2 = document.createElement("tr");
                var swingRow3 = document.createElement("tr");
                var swingRow4 = document.createElement("tr");
                var swingRow5 = document.createElement("tr");
                var swingRow6 = document.createElement("tr");
                var swingRow7 = document.createElement("tr");
                var swingR1Col1 = document.createElement("td");
                swingR1Col1.innerHTML = "Reference";
                swingR1Col1.width = "15%";
                var swingR1Col2 = document.createElement("td");
                swingR1Col2.innerHTML = keyVal.swing_labelRef;
                var swingR1Col3 = document.createElement("td");
                swingR1Col3.width = "30%";
                swingR1Col3.rowSpan = "1";
                var elem1 = document.createElement("input");
                elem1.id = "hidden_" + key;
                elem1.value = JSON.stringify(keyVal);
                elem1.name = "swingTicket";
                elem1.type = "hidden";
                var elem2 = document.createElement("input");
                elem2.id = key;
                elem2.value = "Options";
                elem2.name = "swing_ticket";
                elem2.type = "button";
                elem2.className = "form-control btn btn-info";

                swingR1Col3.appendChild(elem1);
                swingR1Col3.appendChild(elem2);
                var swingR2Col1 = document.createElement("td");
                swingR2Col1.innerHTML = "Description";
                var swingR2Col2 = document.createElement("td");
                swingR2Col2.innerHTML = keyVal.swing_lbl_des + "(" + keyVal.swing_labelGroup + ")";
                var swingR3Col1 = document.createElement("td");
                swingR3Col1.innerHTML = "Trend Name";
                var swingR3Col2 = document.createElement("td");
                swingR3Col2.innerHTML = keyVal.trend_name;
                var swingR4Col1 = document.createElement("td");
                swingR4Col1.innerHTML = "Product Benefit";
                var swingR4Col2 = document.createElement("td");
                swingR4Col2.innerHTML = keyVal.product_benefit;
                var swingR5Col1 = document.createElement("td");
                swingR5Col1.innerHTML = "Product Description";
                var swingR5Col2 = document.createElement("td");
                swingR5Col2.innerHTML = keyVal.product_description;
                var swingR6Col1 = document.createElement("td");
                swingR6Col1.innerHTML = "Wash Symbol";
                var swingR6Col2 = document.createElement("td");
                swingR6Col2.innerHTML = keyVal.swing_wash_symbol;
                var swingR7Col1 = document.createElement("td");
                swingR7Col1.innerHTML = "Additional Care Info";
                var swingR7Col2 = document.createElement("td");
                swingR7Col2.innerHTML = keyVal.temp_swing_care;
                swingRow1.appendChild(swingR1Col1);
                swingRow1.appendChild(swingR1Col2);
                swingRow1.appendChild(swingR1Col3);
                swingRow2.appendChild(swingR2Col1);
                swingRow2.appendChild(swingR2Col2);
                swingRow3.appendChild(swingR3Col1);
                swingRow3.appendChild(swingR3Col2);
                swingRow4.appendChild(swingR4Col1);
                swingRow4.appendChild(swingR4Col2);
                swingRow5.appendChild(swingR5Col1);
                swingRow5.appendChild(swingR5Col2);
                swingRow6.appendChild(swingR6Col1);
                swingRow6.appendChild(swingR6Col2);
                swingRow7.appendChild(swingR7Col1);
                swingRow7.appendChild(swingR7Col2);
                swingTbody.appendChild(swingRow1);
                swingTbody.appendChild(swingRow2);
                swingTbody.appendChild(swingRow3);
                swingTbody.appendChild(swingRow4);
                swingTbody.appendChild(swingRow5);
                swingTbody.appendChild(swingRow6);
                swingTbody.appendChild(swingRow7);
                swingTabel.appendChild(swingTbody);
                swingDiv.appendChild(swingTabel);
                swingView.appendChild(swingDiv);
            }

        }
    }

    function clearSwing() {
        document.getElementById("swing_labelRef_frontId").value = "";
        document.getElementById("swing_labelRef_backId").value = "";
        document.getElementById("swing_labelGroupId").value = "";
        document.getElementById("swing_lbl_des").value = "";
        document.getElementById("txt_trend").value = "";
        document.getElementById("txt_product_description").value = "";
        document.getElementById("txt_product_benefit").value = "";
        document.getElementById("swingcareInfo").selectedIndex = 0;
        document.getElementById("swing_labelRef_frontId").readOnly = false;
        document.getElementById("swing_labelRef_backId").readOnly = false;
        document.getElementById("swing_labelGroupId").readOnly = false;
        document.getElementById("swing_lbl_des").readOnly = false;
        $("#sizeImage").attr("src", "");
        $("#tblSwingCare tbody").empty();
        var swingCareCount = Object.keys(temp_swing_care).length;
        if (swingCareCount > 0) {
            for (var key in temp_swing_care) {
                $("#swingcareInfo option[id='" + key + "'").prop('disabled', false);
            }
        }
    }

    function confirmSwingTicket() {
        BootstrapDialog.confirm({
            title: 'Notification',
            message: 'Do you want to add this label details ?',
            type: BootstrapDialog.TYPE_PRIMARY,
            closable: true,
            draggable: true,
            btnCancelLabel: 'No',
            btnOKLabel: 'Yes',
            callback: function (result) {
                if (result) {
                    addSwingLabel();
                    closeSwing();
                    clearSwing();
                } else {
                    return;
                }
            }
        });
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
        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem3").addClass("active");
    });</script>

<script type="text/javascript">
    document.title = "Place Order | E-Platform";
</script>

<script type="text/javascript">
    $(document).ready(function () {

        var po_number_uk = "<%=commonData.getPoNumUK()%>";
//        var po_number_ce = "<=commonData.getPoNumCE()%>";
        var style_no_uk = "<%=commonData.getStyleNoUK()%>";
//        var style_no_ce = "<=commonData.getStyleNoCE()%>";

        $("#style_ce_type").hide();
        $("#style_uk_type").hide();

        $("#style_type").on('change', function () {
            var out = document.getElementById("style_type").selectedIndex;
            if (out === 1) {
//                checkForStyle();
                $("#style_ce_type").hide();
                $("#style_uk_type").show();
                document.getElementById("po_uk").value = po_number_uk;
                document.getElementById("style_uk").value = style_no_uk;
                document.getElementById("po_ce").value = "";
                document.getElementById("style_ce").value = "";
            }
            if (out === 2) {
//                checkForStyle();
                $("#style_ce_type").show();
                $("#style_uk_type").hide();
                document.getElementById("po_ce").value = po_number_uk;
                document.getElementById("style_ce").value = style_no_uk;
                document.getElementById("po_uk").value = "";
                document.getElementById("style_uk").value = "";
            }
            if (out === 3) {
                $("#style_ce_type").show();
                $("#style_uk_type").show();
                document.getElementById("po_uk").value = "";
                document.getElementById("style_uk").value = "";
                document.getElementById("po_ce").value = "";
                document.getElementById("style_ce").value = "";
            }
        });
    });

    function getPrimarySize() {

        var table = document.getElementById('eanTable').getElementsByTagName('tbody')[0];

        var eanDetails = [];

        for (var x = 0; x < table.rows.length; x++) {

            var eanDetail = {};
            var rw = table.rows[x];
            var eanDetailNo = rw.cells[1].innerHTML;

            eanDetail["eanDetailNo"] = eanDetailNo;
            eanDetails.push(eanDetail);
        }

        var data = JSON.stringify(eanDetails);

        var dataList = data;

        var xmlHttp1 = getAjaxObject();

        xmlHttp1.onreadystatechange = function ()
        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
            {
                var reply9 = eval('(' + xmlHttp1.responseText + ')');

                for (var i = 0; i < reply9.length; i++) {
                    var rowData = reply9[i];
                    var rw = table.rows[i];

                    rw.cells[0].children[0].id = rowData["uk_size"].trim();
                    rw.cells[1].innerHTML = rowData["ean_no"];
                    rw.cells[2].innerHTML = rowData["uk_size"].trim();
                    rw.cells[3].innerHTML = rowData["ce_size"].trim();

//                    if (style_type == "uk") {
//                        rw.cells[2].innerHTML = rowData["uk_size"].trim();
//                        rw.cells[0].children[0].id = rowData["uk_size"].trim();
//                    }
//                    if (style_type == "ce") {
//                        rw.cells[2].innerHTML = rowData["ce_size"].trim();
//                        rw.cells[0].children[0].id = rowData["ce_size"].trim();
//                    }

                }



//                if (style_type === "uk" || style_type === "ce") {
//                    var datalist = document.getElementById("prim_size");
//                    for (var i = 0; i < data.length; i++) {
//                        var option = document.createElement("option");
//                        option.innerHTML = data[i];
//                        option.value = data[i];
//
//                        datalist.appendChild(option);
//                    }
//                }




            }
        };
        xmlHttp1.open("POST", "/IEPTescoNew/Controller?method=getPrimarySize&dataList=" + dataList, true);
        xmlHttp1.send();
    }

</script>

<%@include file="../include/footerInner.jsp"%>
<% } else {
        response.sendRedirect("LogoutController");
    }%>