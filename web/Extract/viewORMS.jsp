<%-- 
    Document   : viewPDF
    Created on : Jul 17, 2015, 8:53:25 AM
    Author     : oshan
--%>


<%@page import="com.impression.hibe.model.Eannotb"%>
<%@page import="java.util.List"%>
<%@page import="com.impression.dao.PODataDAO"%>
<%@page import="com.impression.extractpdf.CommonData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>
<%@include file="../include/sideMenu.jsp"%>



<%  SysUser user = (SysUser) session.getAttribute("user");

    if (user != null) {
%>
<%    CommonData commonData = (CommonData) request.getSession().getAttribute("commonData");

    PODataDAO pODataDAO = new PODataDAO();
    List<Eannotb> eanSendArray = pODataDAO.getUkAndCeSize(commonData.getEanArr());

    String lofID = (String) request.getSession().getAttribute("lofID");

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

<script type="text/javascript">
    var isGeneralSaved = false;
    var isEANSaved = false;
    var isTechSaved = false;
    var iswashsymbol = false;
    $(document).ready(function () {
        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem3").addClass("active");

        $("#general_container").show();
//        $("#general_container").hide();
//        $("#ean_container").show();
        $("#ean_container").hide();
        $("#tech_Container").hide();
        $("#swing_Container").hide();
        $("#finish_container").hide();
        $("#tab_1").addClass("active");
        $("#selling_row").hide();

        $("#check_none").attr("disabled", "disabled");
        document.getElementById("check_none").checked = true;
        $("#secView").hide();
        $('#checkboxlist').find('input[type=checkbox]:checked').removeAttr('checked');


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
//                $("#uk_ean_no").removeAttr("disabled");
//                $("#ce_ean_no").attr("disabled", "disabled");
//                $("#uk_size").removeAttr("disabled");
//                $("#ce_size").attr("disabled", "disabled");
                document.getElementById("po_uk").value = po_number_uk;
                document.getElementById("style_uk").value = style_no_uk;
                document.getElementById("po_ce").value = "";
                document.getElementById("style_ce").value = "";

            }
            if (out === 2) {
//                checkForStyle();
                $("#style_ce_type").show();
                $("#style_uk_type").hide();
//                $("#uk_ean_no").attr("disabled", "disabled");
//                $("#ce_ean_no").removeAttr("disabled");
//                $("#ce_size").removeAttr("disabled");
//                $("#uk_size").attr("disabled", "disabled");
                document.getElementById("po_ce").value = po_number_uk;
                document.getElementById("style_ce").value = style_no_uk;
                document.getElementById("po_uk").value = "";
                document.getElementById("style_uk").value = "";
            }
            if (out === 3) {
                $("#style_ce_type").show();
                $("#style_uk_type").show();
//                $("#uk_ean_no").removeAttr("disabled");
//                $("#ce_ean_no").removeAttr("disabled");
                document.getElementById("po_uk").value = "";
                document.getElementById("style_uk").value = "";
                document.getElementById("po_ce").value = "";
                document.getElementById("style_ce").value = "";
            }
//            document.getElementById("uk_ean_no").value = "";
//            document.getElementById("ce_ean_no").value = "";
//            document.getElementById("uk_size").value = "";
//            document.getElementById("ce_size").value = "";

        });

        $("#check_none").change(function () {
            if (this.checked) {
                $("#secView").hide();
                $('#checkboxlist').find('input[type=checkbox]:checked').removeAttr('checked');
            } else {
                $("#secView").show();
            }
        });

        $("#technical").hide();
        $("#swing").hide();

        $("#btn_newTech").click(function () {
            document.getElementById("tech_add_ref").value = "";
            document.getElementById("tech_add_ref").readOnly = true;
            document.getElementById("ref_ff").disabled = true;
            document.getElementById("ref_ge").disabled = true;
            clearTechLabel();
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

        $("#tech_labelRefId").bind('input', function () {
            $("#technical option").each(function () {
                var id = this.id;
                $("#technical option[id='" + id + "']").removeAttr("disabled");
            });
            $("#techChild").prop('disabled', false);
            $("#btn_child").prop('disabled', false);
            btnTechWashClear();
            var techrefValue = document.getElementById("tech_labelRefId").value.trim();
            if (techrefValue.length <= 0) {
                return;
            }
            getref();
            var refSplit = [];
            refSplit = techrefValue.split("/");

            if (refSplit[0] === "FF") {
                document.getElementById("ref_ff").checked = true;
                document.getElementById("ref_ge").checked = false;
                document.getElementById("tech_add_ref").value = "FF";
                document.getElementById("ref_ff").disabled = true;
                document.getElementById("ref_ge").disabled = true;
                document.getElementById("tech_add_ref").readOnly = true;
                $("#tech_add_ref").hide();
            }
            if (refSplit[0] === "GE") {
                document.getElementById("ref_ff").checked = true;
                document.getElementById("ref_ge").checked = false;
                document.getElementById("ref_ff").disabled = false;
                document.getElementById("ref_ge").disabled = false;
                document.getElementById("tech_add_ref").value = "FF";
                document.getElementById("tech_add_ref").readOnly = true;
                $("#tech_add_ref").hide();
            }

        });

        $("#uk_size").bind('input', function () {
            var temp = document.getElementById("uk_size").value;
            if (temp.length > 0) {
                var sizes = temp.split("---");
                if (typeof (sizes[1]) !== 'undefined') {
                    document.getElementById("uk_size").value = sizes[0];
                    document.getElementById("ce_size").value = sizes[1];
                }
            }
            if (temp == "Free Type --- Free Type") {
                document.getElementById("check_none").checked = true;
                $("#secView").hide();
                $('#checkboxlist').find('input[type=checkbox]:checked').removeAttr('checked');
            }

        });

        $("#ce_size").bind('input', function () {
            var temp = document.getElementById("ce_size").value;
            if (temp.length > 0) {
                var sizes = temp.split("---");
                if (typeof (sizes[1]) !== 'undefined') {
                    document.getElementById("check_none").checked = true;
                    document.getElementById("uk_size").value = sizes[1];
                    document.getElementById("ce_size").value = sizes[0];
                }
            }
            if (temp == "Free Type --- Free Type") {
                $("#secView").hide();
                $('#checkboxlist').find('input[type=checkbox]:checked').removeAttr('checked');
            }
        });

//        $("#uk_ean_no").bind("keyup", function () {
//            checkExistEAN(this.id);
//        });
//        $("#ce_ean_no").bind("keyup", function () {
//            checkExistEAN(this.id);
//        });
//        $("#uk_ean_no").bind("input", function () {
//            checkExistEAN(this.id);
//        });
//        $("#ce_ean_no").bind("input", function () {
//            checkExistEAN(this.id);
//        });

        $("#tech_labelRefId").bind('input', function () {
            $("#technical option").each(function () {
                var id = this.id;
                $("#technical option[id='" + id + "']").removeAttr("disabled");
            });
            $("#techChild").prop('disabled', false);
            $("#btn_child").prop('disabled', false);
            btnTechWashClear();
            var techrefValue = document.getElementById("tech_labelRefId").value.trim();
            if (techrefValue.length <= 0) {
                return;
            }
//            getref();

            if (techrefValue === "FF/57/M9057G") {
                $("#techFireWarnings option[id=014]").prop('disabled', true);
                $("#techWarnings option[id=028]").prop('disabled', true);
                $("#techWarnings option[id=110]").prop('disabled', true);
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);
                document.getElementById("techWashSymbol").value = "W000B000D000I000C000"
                document.getElementById("btn_wash_tech_vertify").disabled = true;
                document.getElementById("btn_wash_tech_clear").disabled = true;
                document.getElementById("techWash_W").disabled = true;
                document.getElementById("techWash_B").disabled = true;
                document.getElementById("techWash_I").disabled = true;
                document.getElementById("techWash_D").disabled = true;
                document.getElementById("techWash_C").disabled = true;
                iswashsymbol = true;
            } else if (techrefValue === "FF/57/M9055G") {

            } else if (techrefValue === "FF/57/M9043G") {
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);
            } else if (techrefValue === "FF/57/M9058G") {
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);
            } else if (techrefValue === "FF/57/M9053G") {
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);
                $("#techWarnings option[id=110]").prop('disabled', true);
            } else if (techrefValue === "FF/57/M9051G") {
                $("#techFireWarnings option[id=014]").prop('disabled', true);
                $("#techWarnings option[id=028]").prop('disabled', true);
                $("#techWarnings option[id=109]").prop('disabled', true);
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);
            } else if (techrefValue === "FF/57/M9049G") {
                $("#techFireWarnings option[id=014]").prop('disabled', true);
                $("#techWarnings option[id=028]").prop('disabled', true);
                $("#techWarnings option[id=110]").prop('disabled', true);
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);

            } else if (techrefValue === "GE/57/M9056G") {
                $("#techFireWarnings option[id=014]").prop('disabled', true);
                $("#techWarnings option[id=028]").prop('disabled', true);
                $("#techWarnings option[id=110]").prop('disabled', true);
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);
                document.getElementById("techWashSymbol").value = "W000B000D000I000C000"
                document.getElementById("btn_wash_tech_vertify").disabled = true;
                document.getElementById("btn_wash_tech_clear").disabled = true;
                document.getElementById("techWash_W").disabled = true;
                document.getElementById("techWash_B").disabled = true;
                document.getElementById("techWash_I").disabled = true;
                document.getElementById("techWash_D").disabled = true;
                document.getElementById("techWash_C").disabled = true;
                iswashsymbol = true;
            } else if (techrefValue === "GE/57/M9054G") {

            } else if (techrefValue === "GE/57/M9067") {
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);
            } else if (techrefValue === "GE/57/M9059G") {
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);
            } else if (techrefValue === "GE/57/M9052G") {
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);
                $("#techWarnings option[id=110]").prop('disabled', true);
            } else if (techrefValue === "GE/57/M9050G") {
                $("#techFireWarnings option[id=014]").prop('disabled', true);
                $("#techWarnings option[id=028]").prop('disabled', true);
                $("#techWarnings option[id=109]").prop('disabled', true);
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);

            } else if (techrefValue === "GE/57/M9048G") {
                $("#techFireWarnings option[id=014]").prop('disabled', true);
                $("#techWarnings option[id=028]").prop('disabled', true);
                $("#techWarnings option[id=110]").prop('disabled', true);
                $("#techChild").prop('disabled', true);
                $("#btn_child").prop('disabled', true);

            } else if (techrefValue === "GE/57/M9117G") {
                $("#techFireWarnings option[id=014]").prop('disabled', true);
            } else if (techrefValue === "GE/57/M9117G") {
                $("#techFireWarnings option[id=014]").prop('disabled', true);
            } else {
            }



            var refSplit = [];
            refSplit = techrefValue.split("/");

            if (refSplit[0] === "FF") {
                document.getElementById("ref_ff").checked = true;
                document.getElementById("ref_ge").checked = false;
                document.getElementById("tech_add_ref").value = "FF";
                document.getElementById("ref_ff").disabled = true;
                document.getElementById("ref_ge").disabled = true;
                document.getElementById("tech_add_ref").readOnly = true;
                $("#tech_add_ref").hide();
            }
            if (refSplit[0] === "GE") {
                document.getElementById("ref_ff").checked = true;
                document.getElementById("ref_ge").checked = false;
                document.getElementById("ref_ff").disabled = false;
                document.getElementById("ref_ge").disabled = false;
                document.getElementById("tech_add_ref").value = "FF";
                document.getElementById("tech_add_ref").readOnly = true;
                $("#tech_add_ref").hide();
                if (techrefValue === "GE/57/M9117G") {
                    document.getElementById("ref_ff").checked = false;
                    document.getElementById("ref_ge").checked = false;
                    document.getElementById("ref_ff").disabled = false;
                    document.getElementById("ref_ge").disabled = false;
                    document.getElementById("tech_add_ref").value = "";
                    document.getElementById("tech_add_ref").readOnly = true;
                }
            }

        });


    });
    function getref() {
        var techrefValue = document.getElementById("tech_labelRefId").value.trim();
        var xmlHttp1 = getAjaxObject();
        xmlHttp1.onreadystatechange = function ()
        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
            {
                var data = eval('(' + xmlHttp1.responseText + ')');
                var tmp = data.vccran;
                var tmp1 = data.abc;
                var temp3 = data.forms;
                console.log(data);

                var adwash = temp3[0].aditional_washcare;
                var conpa = temp3[0].con_pa_non_text;
                var exclusive = temp3[0].exclusive_of_trims;
                var fibercom = temp3[0].fiber_comp;
                var kaff = temp3[0].kaff;
                var kidswar = temp3[0].kids_warning;
                var partset = temp3[0].part_of_set;
                var ref = temp3[0].ref;
                var refid = temp3[0].ref_id;
                var reftype = temp3[0].ref_type;
                var washsymbl = temp3[0].washcare_symbols;
                var refid1 = document.getElementById("techcareInfo").value;
                var refid2 = document.getElementById("techFireWarnings").value;
                var refid3 = document.getElementById("techWarnings").value;
                var refid4 = document.getElementById("techChild").value;
                if (adwash == "N") {
                    document.getElementById("techWash_W").disabled = true;
                    document.getElementById("techWash_B").disabled = true;
                    document.getElementById("techWash_I").disabled = true;
                    document.getElementById("techWash_D").disabled = true;
                    document.getElementById("techWash_C").disabled = true;
                }
                if (conpa == "N") {

                    $("#techWarnings option[id=110]").prop('disabled', true);
                }
                if (exclusive == "N") {
                    $("#techWarnings option[id=028]").prop('disabled', true);
                }
                if (kaff == "N") {
                    $("#techFireWarnings option[id=014]").prop('disabled', true);
                }
                if (fibercom == "N") {
                    document.getElementById("mainWord").disabled = true;
                    document.getElementById("fiberName").disabled = true;
                    document.getElementById("fiberQuantity").disabled = true;
                    $("#btn_addFiber").prop('disabled', true);
                }
                if (kidswar == "N") {
                    $("#techChild").prop('disabled', true);
                    $("#btn_child").prop('disabled', true);
                }
                if (partset == "N") {

                    $("#techWarnings option[id=109]").prop('disabled', true);
                }
                if (washsymbl == "N") {
                    document.getElementById("techWash_W").disabled = true;
                    document.getElementById("techWash_B").disabled = true;
                    document.getElementById("techWash_I").disabled = true;
                    document.getElementById("techWash_D").disabled = true;
                    document.getElementById("techWash_C").disabled = true;
                    $("#btn_wash_tech_clear").prop('disabled', true);
                    $("#btn_wash_tech_vertify").prop('disabled', true);
                }
            }
        };
        xmlHttp1.open("POST", "Controller?method=refernce&ref=" + techrefValue, true);
        xmlHttp1.send();

    }

</script>
<header>
    <div class="container-fluid" style="position: fixed; right: 0; left: 0; margin-left: auto; margin-right: auto; z-index: 10;  ">
        <center>
            <nav >
                <ul class="pagination" style="margin: 0px;">
                    <li class="disabled">
                        <span aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </span>
                    </li>
                    <li name="tabs" id="tab_1">
                        <span>General Details<span class="sr-only"></span></span>
                    </li>
                    <li name="tabs" id="tab_2" class="disabled">
                        <span>EAN Details<span class="sr-only"></span></span>
                    </li>
                    <li name="tabs" id="tab_3" class="disabled">
                        <span>Concertina Label<span class="sr-only"></span></span>
                    </li>
                    <!--                    <li name="tabs" id="tab_4" class="disabled">
                                            <span>Swing Ticket<span class="sr-only"></span></span>
                                        </li>-->
                    <li name="tabs" id="tab_5" class="disabled">
                        <span>Finish the Order<span class="sr-only"></span></span>
                    </li>
                    <li class="disabled">
                        <span aria-label="Next" class="disabled">
                            <span aria-hidden="true">&raquo;</span>
                        </span>
                    </li>
                </ul>
            </nav>
        </center>
    </div>
</header>
<div id="page-wrapper">

    <div class="container-fluid" style="margin-top: 45px;" id="general_container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <label class="col-sm-4" for="supplier_number">Supplier Code * :</label>
                                    <div class="col-sm-8">
                                        <%
                                            if (commonData.getSupplierno() != null) {
                                        %>
                                        <input type="text" name="supplier_number" id="supplier_number"  autocomplete="off" style="height: 30px;"  class="form-control" value="<%=commonData.getSupplierno()%>"/>
                                        <%
                                        } else {
                                        %>
                                        <input type="text" name="supplier_number" id="supplier_number"  autocomplete="off" style="height: 30px;"  class="form-control" value=""/>
                                        <%
                                            }
                                        %>
                                        <input type="hidden" name="counter_techlabel" id="counter_techlabel" value="">      
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4" for="supplier_name">Supplier Name * :</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="supplier_name" id="supplier_name"  autocomplete="off" style="height: 30px; text-transform: capitalize;"  class="form-control" value="<%=user.getCompanyId().getCompanyName()%>" readonly/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <label class="col-sm-4" for="factory_code">Factory Code * :</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="factory_code" id="factory_code" autocomplete="off" style="height: 30px;"  class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4" for="lof_num">LOF No * :</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="lof_num" id="lof_num" style="height: 30px;"  autocomplete="off" class="form-control" value="<%=lofID%>" readonly/>
                                        <input type="hidden" name="order_id" id="order_id" value="-1"/>
                                        <input type="hidden" name="web_order_id" id="web_order_id" value="-1"/>
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
                                            <input type="text" name="po_uk" id="po_uk" autocomplete="off" style="height: 30px;"  class="form-control" placeholder="PO Number - UK"/>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6">
                                            <input type="text" name="style_uk" id="style_uk" autocomplete="off" style="height: 30px;"  class="form-control" placeholder="Style Number - UK"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" id="style_ce_type">
                                    <div class="form-group">
                                        <div class="col-lg-6 col-md-6 col-sm-6">
                                            <input type="text" name="po_ce" id="po_ce" autocomplete="off" style="height: 30px;"  class="form-control" placeholder="PO Number - CE"/>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6">
                                            <input type="text" name="style_ce" id="style_ce" autocomplete="off" style="height: 30px;"  class="form-control" placeholder="Style Number - CE"/>
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
                                <label class="col-sm-4" for="tog_value">Tog Value :</label>
                                <div class="col-sm-8">
                                    <select class="form-control" list="tog_list" name="tog_value" id="tog_value" style="width: 100%; height: 30px;">
                                        <option value="0.0"  selected="">0.0</option>
                                        <option value="1.0" >1.0</option>
                                        <option value="1.5" >1.5</option>
                                        <option value="2.0" >2.0</option>
                                        <option value="2.5" >2.5</option>
                                        <option value="3.0" >3.0</option>
                                        <option value="3.5" >3.5</option>
                                        <option value="4.0" >4.0</option>
                                        <option value="4.5" >4.5</option>
                                        <option value="5.0" >5.0</option>
                                    </select>
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
                            <!--                            <div class="form-group">
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
                    </div>-->
                            <div class="form-group">
                                <label class="col-sm-4" for="comments">Additional Comments :</label>
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
                            <div class="form-group">
                                <label class="col-sm-5" for="identification_code">Leather and Suede Identification code :</label>
                                <div class="col-sm-7">
                                    <input type="text" name="identification_code" id="identification_code"  autocomplete="off" style="height: 30px;"  class="form-control" value=""/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <input id="btn_tab1_next" class="btn btn-primary pull-right" type="button" name="submit" value="Next" onclick="tab1_next()" style="margin: 25px;" disabled/>
                <input id="btn_save_general" class="btn btn-primary pull-right" type="button" name="submit" value="Save General Data" onclick="checkGeneral()" style="margin-top: 25px; "/>
            </div>
        </div>
    </div>
    <div class="container-fluid" style="margin-top: 45px;" id="ean_container">              
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
                                                <select  id="department_ID" name="department_ID" class="form-control" onchange="getSecondrySizes();">
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
                                                    <label class="col-sm-10" for="check_none">Drop Secondary Sizes</label>
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
                                            <!--<th rowspan="2" style="text-align: center; padding-bottom: 18px;">Color</th>-->
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
                                                <% String tmp = data.getUkSize().trim();
                                                    if (tmp.equals("Free Type")) {
                                                %>
                                                <input type="checkbox" id="<%=data.getUkSize().trim()%>" disabled name="chk_ean" checked="true"/>
                                                <%
                                                } else {
                                                %>
                                                <input type="checkbox" id="<%=data.getUkSize().trim()%>" disabled name="chk_ean" />
                                                <%
                                                    }
                                                %>
                                            </td>
                                            <td>
                                                <%=data.getEanno().trim()%>
                                            </td>
                                            <td>
                                                <%=data.getUkSize().trim()%>    
                                            </td>
                                            <td>
                                                <%=data.getCeSize().trim()%>
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
                                            <!--                                            <td width="15%">
                                                                                            <input type="text" class="form-control" name="color"  id="color" placeholder="Color" style="width: 100%;" />
                                                                                        </td>-->
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>                               </table>
                                <input id="btn_tab2_next" class="btn btn-primary pull-right" type="button" value="Next" onclick="tab2_next()" style="margin: 25px;"/>
                                <input id="btn_tab2_prev" class="btn btn-primary pull-left" type="button" value="Previous" onclick="tab0_next()" style="margin: 25px;"/>
                                <input id="btn_save_ean" class="btn btn-primary pull-right" type="button" value="Save EAN Details" onclick="getEanDetail();" style="margin-top: 25px; "/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>    
    <div class="container-fluid" style="margin-top: 45px;" id="tech_Container">
        <!--Technical View Table-->                                
        <div class="row">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <!--delete this methode on 2015/11/11 onclick="displayTechnical();"-->
                    <div class="panel-title"><strong>Concertina Label</strong>&nbsp;&nbsp;<small  class="badge" id="techCount">No of Concertina Labels : 0</small></div>
                    <div style="float: right; font-size: 80%; position: relative; top: -28px">
                        <button id="btn_newTech" class="btn btn-default"><span><i class="glyphicon glyphicon-plus"></i></span>&nbsp;<Strong>New Concertina Label</strong></button>
                    </div>
                </div>
                <div id="techView" class="panel-body" style="padding-left: 35px; padding-right: 35px;">

                </div>
            </div>
        </div>

        <!--Technical Panel-->                                
        <div class="row" id="technical" >
            <div class="panel panel-info">
                <div class="panel-heading">
                    <div class="panel-title"><strong>New Concertina Label</strong></div>
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
                                                    <input class="form-control" list="tech_labelRef" name="tech_labelRef" id="tech_labelRefId" style="width: 100%;" onClick="this.setSelectionRange(0, this.value.length)"/>
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
                                                    <label for="tech_labelGroup">Garment Type :</label>
                                                    &nbsp;
                                                    <input class="form-control" list="tech_labelGroup" name="tech_labelGroup" id="tech_labelGroupId" style="width: 100%;" onClick="this.setSelectionRange(0, this.value.length)"/>
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
                                            <div class="row-fluid">
                                                <div class="form-group">
                                                    <div class="col-lg-4 col-lg-offset-2" >
                                                        <center><input type="radio" name="add_ref" value="FF" id="ref_ff" disabled onclick="disbleRef()"/>&nbsp;&nbsp;&nbsp;<label>FF</label></center>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <center><input type="radio" name="add_ref" value="GE" id="ref_ge" disabled onclick="disbleRef()"/>&nbsp;&nbsp;&nbsp;<label>GE</label></center>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row-fluid">
                                                <div class="form-group">
                                                    <textarea class="form-control textarea" name="tech_add_ref" id="tech_add_ref" rows="5"></textarea>
                                                </div>                                                
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
                                                <sql:query var="idQ65"  dataSource="jdbc/sdb">
                                                    SELECT * FROM caretext where d_type = 'CT' order by ct_code ASC; 
                                                </sql:query>

                                                <select  id="techcareInfo" name="techcareInfo" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Care Text --</option>
                                                    <c:forEach var="row25" items="${idQ65.rows}"> 
                                                        <option id="${row25.ct_code}" value="${row25.ct_code})${row25.english}">${row25.ct_code} ) ${row25.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button id="btn_care" class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addTechCare();">Add</button>
                                            </div>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <sql:query var="idQ66"  dataSource="jdbc/sdb">
                                                    SELECT * FROM caretext where d_type = 'FW' order by ct_code ASC; 
                                                </sql:query>

                                                <select  id="techFireWarnings" name="techFireWarnings" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Fire Warnings --</option>
                                                    <c:forEach var="row26" items="${idQ66.rows}"> 
                                                        <option id="${row26.ct_code}" value="${row26.ct_code})${row26.english}">${row26.ct_code} ) ${row26.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button id="btn_fire" class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addTechFireWarnings();">Add</button>
                                            </div>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <sql:query var="idQ67"  dataSource="jdbc/sdb">
                                                    SELECT * FROM caretext where d_type = 'ZC' order by ct_code ASC; 
                                                </sql:query>

                                                <select  id="techWarnings" name="techWarnings" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Warnings --</option>
                                                    <c:forEach var="row27" items="${idQ67.rows}"> 
                                                        <option id="${row27.ct_code}" value="${row27.ct_code})${row27.english}">${row27.ct_code} ) ${row27.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button id="btn_warn" class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addTechWarning();">Add</button>
                                            </div>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <sql:query var="idQ68"  dataSource="jdbc/sdb">
                                                    SELECT * FROM caretext where d_type = 'CW' order by ct_code ASC; 
                                                </sql:query>

                                                <select  id="techChild" name="techChild" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Children Warnings --</option>
                                                    <c:forEach var="row28" items="${idQ68.rows}"> 
                                                        <option id="${row28.ct_code}" value="${row28.ct_code})${row28.english}">${row28.ct_code} ) ${row28.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button id="btn_child" class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addTechChild();">Add</button>
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
                                                            <input type="hidden" name="techWashSymbol" id="techWashSymbol" value="" />
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
                                                            <input class="btn btn-primary pull-right" type="button" id="btn_wash_tech_vertify" value="Save Wash Symbol" onclick="btnTechWashVertify();"/>
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
                                                    <label class="control-label col-sm-4" for="fiberComposition">Component No : </label>
                                                    <div class="col-sm-2">
                                                        <input type="text" class="form-control" id="fiberComposition" value="1" readonly style="text-align: center; height: 30px;"/>
                                                        <input type="hidden" id="txt_mainWord" value=""/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-sm-4" for="mainWord">Component Type : </label>
                                                    <div class="col-sm-8"> 
                                                        <sql:query var="idQ7"  dataSource="jdbc/sdb">
                                                            SELECT * FROM fiber f where f.d_type="MAINWORD" ORDER BY english ASC; 
                                                        </sql:query>

                                                        <select  id="mainWord" name="mainWord" class="form-control" style="height: 30px;" onchange="getMainWord();">
                                                            <option  selected disabled> - Component -</option>
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
                                                        <input type="text" class="form-control" id="fiberQuantity" placeholder="Remain Amount : 100" style="text-align: right; height: 30px;" onkeypress="return isNumber()"/>
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
                                                            <th bgcolor="#efefef" style="text-align: center;">Garment Components</th>
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
                                <td colspan="2"> <input id="btn_addTechnicalLabel" class="btn btn-primary pull-right" type="button" value="Add to Concertina Label" onclick="addTechLabel();"/> </td>
                            </tr>
                        </tfoot>
                    </table>

                </div>
            </div>
        </div>
        <div class="row">
            <input id="btn_tab2_next" class="btn btn-primary pull-right" type="button" value="Next" onclick="tab4_next()" style="margin: 25px;"/>
            <input id="btn_tab2_prev" class="btn btn-primary pull-left" type="button" value="Previous" onclick="tab1_next()" style="margin: 25px;"/>
        </div>
    </div>
    <div class="container-fluid" style="margin-top: 45px;" id="swing_Container">
        <!--Swing View Table-->                                
        <div class="row">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-title"><strong>Swing Ticket</strong>&nbsp;&nbsp;<small class="badge" id="swingCount">No of Swing Tickets : 0</small></div>
                    <div style="float: right; font-size: 80%; position: relative; top: -28px">
                        <button id="btn_newSwing" class="btn btn-default"><span><i class="glyphicon glyphicon-plus"></i></span>&nbsp;<Strong>New Swing Ticket</strong></button>
                    </div>
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
                                                    <input class="form-control" list="swing_labelRef_back" name="swing_labelRef_back" id="swing_labelRef_backId" style="width: 100%;" placeholder="Back" onClick="this.setSelectionRange(0, this.value.length)"/>
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
                                                    <label for="swing_labelGroup">Garment Type :</label>
                                                    &nbsp;
                                                    <input class="form-control" list="swing_labelGroup" name="swing_labelGroup" id="swing_labelGroupId" style="width: 100%;" onClick="this.setSelectionRange(0, this.value.length)"/>
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
                                                <sql:query var="idQ65"  dataSource="jdbc/sdb">
                                                    SELECT * FROM caretext where d_type = 'CT' order by ct_code ASC; 
                                                </sql:query>

                                                <select  id="swingcareInfo" name="swingcareInfo" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Care Text --</option>
                                                    <c:forEach var="row25" items="${idQ65.rows}"> 
                                                        <option id="${row25.ct_code}" value="${row25.ct_code})${row25.english}">${row25.ct_code} ) ${row25.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addSwingCare();">Add</button>
                                            </div>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <sql:query var="idQ66"  dataSource="jdbc/sdb">
                                                    SELECT * FROM caretext where d_type = 'FW' order by ct_code ASC; 
                                                </sql:query>

                                                <select  id="swingFireWarnings" name="swingFireWarnings" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Fire Warnings --</option>
                                                    <c:forEach var="row26" items="${idQ66.rows}"> 
                                                        <option id="${row26.ct_code}" value="${row26.ct_code})${row26.english}">${row26.ct_code} ) ${row26.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addSwingFireWarnings();">Add</button>
                                            </div>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <sql:query var="idQ67"  dataSource="jdbc/sdb">
                                                    SELECT * FROM caretext where d_type = 'ZC' order by ct_code ASC; 
                                                </sql:query>

                                                <select  id="swingWarnings" name="swingWarnings" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Warnings --</option>
                                                    <c:forEach var="row27" items="${idQ67.rows}"> 
                                                        <option id="${row27.ct_code}" value="${row27.ct_code})${row27.english}">${row27.ct_code} ) ${row27.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addSwingWarning();">Add</button>
                                            </div>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <sql:query var="idQ68"  dataSource="jdbc/sdb">
                                                    SELECT * FROM caretext where d_type = 'CW' order by ct_code ASC; 
                                                </sql:query>

                                                <select  id="swingChild" name="swingChild" class="form-control" style="height: 30px;">
                                                    <option  selected disabled>-- Children Warnings --</option>
                                                    <c:forEach var="row28" items="${idQ68.rows}"> 
                                                        <option id="${row28.ct_code}" value="${row28.ct_code})${row28.english}">${row28.ct_code} ) ${row28.english}</option>
                                                    </c:forEach>
                                                </select> 
                                            </div>
                                            <br/>
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <button class="btn btn-primary pull-right" type="button" style="margin-bottom: 30px; height: 30px;" onclick="addSwingChild();">Add</button>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <div class="table-responsive">
                                                    <table class="table table-striped" id="tblSwingCare" >
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
                                                            <input class="btn btn-primary pull-right" type="button" id="btn_wash_swing_vertify" value="Save Wash Symbol" onclick="btnSwingWashVertify();"/>
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
        <div class="row" id="selling_row">
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
                <input type="button" value="Add Selling Prices" class="form-control btn btn-default pull-right" onclick="addSellingPrices();" >
            </div>
        </div>

        <div class="row">

            <input id="btn_tab4_next" class="btn btn-primary pull-right" type="button" value="Next" onclick="tab4_next()" style="margin: 25px;"/>
            <input id="btn_tab4_prev" class="btn btn-primary pull-left" type="button" value="Previous" onclick="tab2_next()" style="margin: 25px;"/>
        </div>
    </div>
    <div class="container-fluid" style="" id="finish_container">
        <div class="row" style="padding: 200px;">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">Finish the Order</h3>
                </div>
                <div class="panel-body" style="margin-top: 50px; margin-bottom: 50px;">
                    <center><input type="button" class="btn btn-success btn-lg" value="Finish" onclick="submitOrder();"/></center>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
//    $(document).on('click', '#eanTable span', function () {
//        var eantmp2 = $(this).closest('tr').find('td:eq(1)').text();
//        $("#uk_ean_no_list option[value='" + eantmp2 + "'btnTechWashVertify();]").removeAttr('disabled');
//        $("#ce_ean_no_list option[value='" + eantmp2 + "']").removeAttr('disabled');
//        $(this).closest('tr').remove();
//    });
    var technical_labels = {};
    var swing_tickets = {};
    var ean_details = {};
    var styleType;
    var sellingCat = "0";
    var isSellingValidate = false;

    function loadTechWash() {
        iswashsymbol = false;
        isTechSaved = false;
        var val = document.getElementById("techWash_W").value;
        document.getElementById("techWashTxt_W").value = val;
        $("#techWashImg_W").attr("src", "./img/symbols/" + val + ".png");
    }

    function loadTechBleach() {
        isTechSaved = false;
        var val = document.getElementById("techWash_B").value;
        document.getElementById("techWashTxt_B").value = val;
        $("#techWashImg_B").attr("src", "./img/symbols/" + val + ".png");
    }

    function loadTechIron() {
        isTechSaved = false;
        var val = document.getElementById("techWash_I").value;
        document.getElementById("techWashTxt_I").value = val;
        $("#techWashImg_I").attr("src", "./img/symbols/" + val + ".png");
    }

    function loadTechDry() {
        isTechSaved = false;
        var val = document.getElementById("techWash_D").value;
        document.getElementById("techWashTxt_D").value = val;
        $("#techWashImg_D").attr("src", "./img/symbols/" + val + ".png");
    }

    function loadTechDryClean() {
        isTechSaved = false;
        var val = document.getElementById("techWash_C").value;
        document.getElementById("techWashTxt_C").value = val;
        $("#techWashImg_C").attr("src", "./img/symbols/" + val + ".png");
    }

    function loadSwingWash() {
        isTechSaved = false;
        var val = document.getElementById("swingWash_W").value;
        document.getElementById("swingWashTxt_W").value = val;
        $("#swingWashImg_W").attr("src", "./img/symbols/" + val + ".png");
    }

    function loadSwingBleach() {
        var val = document.getElementById("swingWash_B").value;
        document.getElementById("swingWashTxt_B").value = val;
        $("#swingWashImg_B").attr("src", "./img/symbols/" + val + ".png");
    }

    function loadSwingIron() {
        var val = document.getElementById("swingWash_I").value;
        document.getElementById("swingWashTxt_I").value = val;
        $("#swingWashImg_I").attr("src", "./img/symbols/" + val + ".png");
    }

    function loadSwingDry() {
        var val = document.getElementById("swingWash_D").value;
        document.getElementById("swingWashTxt_D").value = val;
        $("#swingWashImg_D").attr("src", "./img/symbols/" + val + ".png");
    }

    function loadSwingDryClean() {
        var val = document.getElementById("swingWash_C").value;
        document.getElementById("swingWashTxt_C").value = val;
        $("#swingWashImg_C").attr("src", "./img/symbols/" + val + ".png");
    }

    function btnSwingWashVertify() {
        var swing_wash_symbo = document.getElementById("swingWashTxt_W").value.trim() + document.getElementById("swingWashTxt_B").value.trim() + document.getElementById("swingWashTxt_D").value.trim() + document.getElementById("swingWashTxt_I").value.trim() + document.getElementById("swingWashTxt_C").value.trim();
        if (swing_wash_symbo.length !== 20) {
            sm_alert("Please Select Wash Symbol");
            $('html, body').animate({
                scrollTop: $("#swingWash_W").offset().top - 125},
            'slow', function () {
                $("#swingWash_W").focus();
                return;
            });
        } else {
            document.getElementById("btn_wash_swing_vertify").disabled = true;
            document.getElementById("swingWash_W").disabled = true;
            document.getElementById("swingWash_B").disabled = true;
            document.getElementById("swingWash_I").disabled = true;
            document.getElementById("swingWash_D").disabled = true;
            document.getElementById("swingWash_C").disabled = true;
        }
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
        iswashsymbol = true;
        var tech_wash_symbo = document.getElementById("techWashTxt_W").value.trim() + document.getElementById("techWashTxt_B").value.trim() + document.getElementById("techWashTxt_D").value.trim() + document.getElementById("techWashTxt_I").value.trim() + document.getElementById("techWashTxt_C").value.trim();
        if (tech_wash_symbo.length != 20) {
            sm_alert("Please Select Wash Symbol");
            $('html, body').animate({
                scrollTop: $("#techWash_W").offset().top - 125},
            'slow', function () {
                $("#techWash_W").focus();
                return;
            });
        } else {
            document.getElementById("techWashSymbol").value = tech_wash_symbo;
            document.getElementById("btn_wash_tech_vertify").disabled = true;
            document.getElementById("techWash_W").disabled = true;
            document.getElementById("techWash_B").disabled = true;
            document.getElementById("techWash_I").disabled = true;
            document.getElementById("techWash_D").disabled = true;
            document.getElementById("techWash_C").disabled = true;
        }
    }

    function  btnTechWashClear() {
        isTechSaved = false;
        var techWash_W = document.getElementById("techWash_W").getElementsByTagName("option");
        for (var i = 1; i < techWash_W.length; i++) {
            techWash_W[i].disabled = false;
        }
        var techWash_B = document.getElementById("techWash_B").getElementsByTagName("option");
        for (var i = 1; i < techWash_B.length; i++) {
            techWash_B[i].disabled = false;
        }
        var techWash_D = document.getElementById("techWash_D").getElementsByTagName("option");
        for (var i = 1; i < techWash_D.length; i++) {
            techWash_D[i].disabled = false;
        }
        var techWash_I = document.getElementById("techWash_I").getElementsByTagName("option");
        for (var i = 1; i < techWash_I.length; i++) {
            techWash_I[i].disabled = false;
        }
        var techWash_C = document.getElementById("techWash_C").getElementsByTagName("option");
        for (var i = 1; i < techWash_C.length; i++) {
            techWash_C[i].disabled = false;
        }
        document.getElementById("techWashSymbol").value = "";
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

    function techRefChange() {
        var tech_ref = document.getElementById("tech_labelRefId").value;

    }

</script>

<script type="text/javascript">

    function submitOrder() {
        var order_id = document.getElementById("order_id").value;
        var id = document.getElementById("web_order_id").value;
        var data = order_id + "XXYY" + id;
        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function () {

            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');
                var status = reply.message;
                if (status) {
                    window.location = "/IEPTescoNew/viewOrder.jsp";
                } else {
                    nom_warning("Failed");
                }
            }
        };

        xmlHttp.open("POST", "/IEPTescoNew/SaveOrder?actionType=submitOrder&data=" + data, true);
        xmlHttp.send();
    }

    function disbleRef() {
        if (document.getElementById("ref_ff").checked) {
            document.getElementById("tech_add_ref").value = "FF";
            document.getElementById("tech_add_ref").readOnly = true;
            $("#tech_add_ref").hide();
        }
        if (document.getElementById("ref_ge").checked) {
            document.getElementById("tech_add_ref").value = "";
            document.getElementById("tech_add_ref").readOnly = false;
            $("#tech_add_ref").show();
        }
    }

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
//        if (sender.value.match(/^(\d+)?\.\d$/))
//            alert("YES");// Approval, No Message Required
//        else
//            alert("NO");// Can output a friendly message to the user here
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

    function isNumber() {
        if (event.charCode >= 48 && event.charCode <= 57) {
            return true;
        }
        return false;
    }

    $(document).on('click', '#techView input[type=button]', function () {
        var iii = "hidden_" + this.id;
        var orderid = this.id;

        var iiii = this.id;
        var techlabelId = document.getElementById(iii).value;
        document.getElementById("counter_techlabel").value = this.id;

        BootstrapDialog.show({
            title: "Notification",
            closable: false,
            buttons: [{
                    label: 'Edit Label',
                    cssClass: 'btn-primary',
                    action: function (dialogRef) {
                        editTechLabel(iiii);
                        dialogRef.close();
                    }
                }, {
                    label: 'Delete Label',
                    cssClass: 'btn-primary',
                    action: function (dialogRef) {
                        deleteTechLabel(orderid);
//                        displayTechnical(technical_labels);
                        dialogRef.close();
                    }
                }, {
                    label: 'Cancel', action: function (dialogRef) {
                        dialogRef.close();
                    }
                }]
        });
    });

    $(document).on('click', '#swingView input[type=button]', function () {
        var iii = "hidden_" + this.id;
        var iiii = this.id;
        var swingTickertID = this.id;

        var swinglabelId = document.getElementById(iii).value;

        BootstrapDialog.show({
            title: "Notification",
            closable: false,
            buttons: [{
                    label: 'Edit Label',
                    cssClass: 'btn-primary', action: function (dialogRef) {
                        editSwingLabel(swinglabelId);
                        dialogRef.close();
                    }
                }, {
                    label: 'Delete Label',
                    cssClass: 'btn-primary',
                    action: function (dialogRef) {
                        deleteSwingLabel(swingTickertID);
                        displaySwing(swingTickertID);
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
        var xmlHttp = getAjaxObject();
        var data1 = techlabelId;
        xmlHttp.onreadystatechange = function () {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log(reply);
                console.log(reply.tech_details);
                if (reply.message) {
                    clearTechLabel();
                    var labelDetails = reply.tech_details;
                    $("#technical").show();
                    $('html, body').animate({
                        scrollTop: $("#technical").offset().top - 60},
                    'slow', function () {
                        $("#technical").focus();
                    });
                    document.getElementById("tech_labelRefId").value = labelDetails.tech_labelRef;
                    document.getElementById("tech_labelGroupId").value = labelDetails.tech_labelGroup;
                    document.getElementById("tech_lbl_des").value = labelDetails.tech_lbl_des;
                    document.getElementById("techlabelId").value = labelDetails.tech_key;
                    var tech_ref_add = labelDetails.tech_ref_add;
                    if (tech_ref_add == "FF") {
                        document.getElementById("ref_ff").disabled = true;
                        document.getElementById("ref_ff").checked = true;
                        document.getElementById("ref_ge").checked = false;
                        document.getElementById("ref_ge").disabled = true;
                        document.getElementById("tech_add_ref").value = "FF";
                        document.getElementById("tech_add_ref").readOnly = true;
                        $("#tech_add_ref").hide();
                    } else {
                        document.getElementById("ref_ff").disabled = false;
                        document.getElementById("ref_ge").disabled = false;
                        document.getElementById("ref_ff").checked = false;
                        document.getElementById("ref_ge").checked = true;
                        document.getElementById("tech_add_ref").value = tech_ref_add;
                        document.getElementById("tech_add_ref").readOnly = false;
                        $("#tech_add_ref").show();
                    }

                    var tech_wash_symbol = labelDetails.tech_wash_symbol;
                    var wash = tech_wash_symbol.substring(0, 4);
                    var bleach = tech_wash_symbol.substring(4, 8);
                    var dry = tech_wash_symbol.substring(8, 12);
                    var iron = tech_wash_symbol.substring(12, 16);
                    var dclean = tech_wash_symbol.substring(16, 20);

                    var tech_care_lable = labelDetails.temp_technical_care;
                    var tmp = [];
                    tmp = tech_care_lable.split("/");
                    $("#technical option").each(function () {
                        for (var i = 0; i < tmp.length; i++) {
                            $("#technical option[id='" + tmp[i].trim() + "']").attr('disabled', 'disabled');
                            if (this.id == tmp[i].trim()) {
                                var tempTechCare = {};
                                var careInfo = $("#technical option[id='" + tmp[i].trim() + "']").text();
                                var tblTechCare = document.getElementById('tblTechCare').getElementsByTagName('tbody')[0];
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
                            }
                        }
                    });

                    $("#technical option").each(function () {
                        var tmp = this.id;
                        $("#technical option[value='" + wash + "']").attr('disabled', 'disabled');
                        $("#technical option[value='" + bleach + "']").attr('disabled', 'disabled');
                        $("#technical option[value='" + dry + "']").attr('disabled', 'disabled');
                        $("#technical option[value='" + iron + "']").attr('disabled', 'disabled');
                        $("#technical option[value='" + dclean + "']").attr('disabled', 'disabled');
                        $("#technical option[value='" + wash + "']").attr('selected', 'selected');
                        $("#technical option[value='" + bleach + "']").attr('selected', 'selected');
                        $("#technical option[value='" + dry + "']").attr('selected', 'selected');
                        $("#technical option[value='" + iron + "']").attr('selected', 'selected');
                        $("#technical option[value='" + dclean + "']").attr('selected', 'selected');
                        $("#techWashImg_W").attr("src", "./img/symbols/" + wash + ".png");
                        $("#techWashImg_B").attr("src", "./img/symbols/" + bleach + ".png");
                        $("#techWashImg_I").attr("src", "./img/symbols/" + dry + ".png");
                        $("#techWashImg_D").attr("src", "./img/symbols/" + iron + ".png");
                        $("#techWashImg_C").attr("src", "./img/symbols/" + dclean + ".png");
                        document.getElementById("techWashTxt_W").value = wash;
                        document.getElementById("techWashTxt_B").value = bleach;
                        document.getElementById("techWashTxt_D").value = dry;
                        document.getElementById("techWashTxt_I").value = iron;
                        document.getElementById("techWashTxt_C").value = dclean;
                    });

                    var tech_fiber = labelDetails.temp_technical_fiber;
                    var mainword = "";
                    var fiber_name = "";
                    var fiber_array = [];
                    var fiber_array_sub = [];
                    for (var i = 0; i < tech_fiber.length; i++) {

//                        temp_technical_fiber[i] = tech_fiber[i];
                        var noOfFiberComposition = document.getElementById("fiberComposition").value;
                        fiber_array = tech_fiber[i].split(":");
                        mainword = fiber_array[0].trim();
                        fiber_array_sub = fiber_array[1].split("ZXZY");
                        fiber_name = fiber_array_sub[1].trim();
                        temp_technical_fiber["Fiber Composition : " + mainword] = tech_fiber[i];
                        $("#mainWord option[value='" + mainword + "']").prop('disabled', true);
                        if (mainword == "None") {
                            document.getElementById("fiberComposition").value = parseInt(noOfFiberComposition) + 7;
                            document.getElementById("fiberComposition").value = "*";
                            document.getElementById("mainWord").disabled = true;
                            document.getElementById("fiberName").disabled = true;
                            document.getElementById("fiberQuantity").disabled = true;
                        } else {
                            document.getElementById("fiberComposition").value = parseInt(noOfFiberComposition) + 1;
                        }

                        if (document.getElementById("fiberComposition").value > "6") {
                            document.getElementById("fiberComposition").value = "#";
                            document.getElementById("mainWord").disabled = true;
                            document.getElementById("fiberName").disabled = true;
                            document.getElementById("fiberQuantity").disabled = true;
                        }
                        if (parseInt(noOfFiberComposition) > 0 && parseInt(noOfFiberComposition) < 7) {
                            $("#mainWord option[value='None']").prop('disabled', true);
                        }



                        var tbl_fiberCompo = document.getElementById('tbl_fiberCompo').getElementsByTagName('tbody')[0];
                        var row = document.createElement("tr");
                        row.id = "Fiber Composition " + noOfFiberComposition;
                        var col2 = document.createElement("td");
                        col2.type = "text";
                        col2.value = tech_fiber[i].replace(/ZXZY/g, "%");
                        col2.innerHTML = tech_fiber[i].replace(/ZXZY/g, "%");
                        var col3 = document.createElement("td");
                        var elem1 = document.createElement("span");
                        elem1.id = "Fiber Composition : ";
                        elem1.name = mainword;
                        elem1.type = "button";
                        elem1.className = "btn btn-default glyphicon glyphicon-remove text-center";
                        col3.appendChild(elem1);
                        row.appendChild(col2);
                        row.appendChild(col3);
                        tbl_fiberCompo.appendChild(row);
                    }

                }//reply end
            }
        };
        xmlHttp.open("POST", "/IEPTescoNew/Controller?method=getTechLabel&techData=" + data1, true);
        xmlHttp.send();
    }

    function deleteTechLabel(techlabelId) {
        var xmlHttp = getAjaxObject();
        var webOrderId = document.getElementById("order_id").value;
        var data1 = techlabelId + "XXYY" + webOrderId;
        xmlHttp.onreadystatechange = function () {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');
                if (reply.message) {
                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_SUCCESS,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Delete Success'
                    });

                    $("#tblTechCare tbody").empty();
                    tech_labelRef.value = "";
                    tech_labelGroup.value = "";
                    document.getElementById("tech_lbl_des").value = "";
//                    tech_wash_symbol.selectedIndex = 0;
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

//                    temp_technical_care = {};
//                    temp_technical_fiber = {};
//                    var techlabels = reply.tech_details;
//                    console(techlabels);
//                    displayTechnical(techlabels);
//                    closeTech();

                    temp_technical_care = {};
                    temp_technical_fiber = {};
                    var techlabels = reply.tech_details;
                    console.log(techlabels);
                    clearTechLabel();
                    closeTech();
                    displayTechnical(techlabels);
                    document.getElementById("counter_techlabel").value = "";

                } else {
                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_WARNING,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Fail'
                    });
                }
            }
        };
        xmlHttp.open("POST", "/IEPTescoNew/Controller?method=deleteTechLabel&techData=" + data1, true);
        xmlHttp.send();
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

    function deleteSwingLabel(swingTickertID) {
        clearTechLabel();
        var xmlHttp = getAjaxObject();
        var webOrderId = document.getElementById("order_id").value;
        var data = swingTickertID + "####" + webOrderId;
        xmlHttp.onreadystatechange = function () {

            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log(reply);
                if (reply.message) {

                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_SUCCESS,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Success'
                    });

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
                    technical_labels = reply.tech_details;
                    closeTech();
                    displayTechnical(technical_labels);

                } else {
                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_WARNING,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Fail'
                    });
                }
            }
        };

        xmlHttp.open("POST", "/IEPTescoNew/Controller?method=deleteTechLabel&techData=" + data, true);
        xmlHttp.send();

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
        isTechSaved = false;
        $("#techcareInfo option[id='" + this.id + "']").prop('disabled', false);
        $("#techFireWarnings option[id='" + this.id + "']").prop('disabled', false);
        $("#techWarnings option[id='" + this.id + "']").prop('disabled', false);
        $("#techChild option[id='" + this.id + "']").prop('disabled', false);
        delete temp_technical_care[this.id];
    });

    $(document).on('click', '#tblSwingCare span', function () {
        $("#swingcareInfo option[id='" + this.id + "']").prop('disabled', false);
        $("#swingFireWarnings option[id='" + this.id + "']").prop('disabled', false);
        $("#swingWarnings option[id='" + this.id + "']").prop('disabled', false);
        $("#swingChild option[id='" + this.id + "']").prop('disabled', false);
        $(this).closest('tr').remove();
        delete temp_swing_care[this.id];
    });

    $(document).on('click', '#tblFiber span', function () {
        var fiberType = this.id;
        var fiberQuantity = this.name;
        $(this).closest('tr').remove();
        delete temp_fiberDetail[this.id];
        $("#mainWord").prop('disabled', true);
//        $("#btn_addFiber").prop('disabled', true);
        $("#fiberName option[value='" + fiberType + "']").prop('disabled', false);
        document.getElementById("txt_fiberCount").value = parseInt(document.getElementById("txt_fiberCount").value) - 1;
        document.getElementById("fiberQuantity").placeholder = "Remain Amount : " + (parseInt(document.getElementById("txt_fiberQuantity").value) + parseInt(this.name));
        document.getElementById("txt_fiberQuantity").value = parseInt(document.getElementById("txt_fiberQuantity").value) + parseInt(this.name);

        if (document.getElementById("txt_fiberCount").value == 1) {

            document.getElementById("mainWord").disabled = false;
            document.getElementById("mainWord").selectedIndex = 0;
        }
        document.getElementById("btn_addFiberCompo").disabled = true;
    });


    $(document).on('click', '#tbl_fiberCompo span', function () {
        $(this).closest('tr').remove();
        $(this).closest('tr').get

        var cnt = document.getElementById("fiberComposition").value;
        if (cnt === "2") {
            $("#mainWord option[value='None']").prop('disabled', false);
        }
        if (cnt === "#") {
            document.getElementById("fiberComposition").value = 6;
            $("#mainWord option[value='None']").prop('disabled', 'disabled');
        } else if (cnt === "*") {
            document.getElementById("fiberComposition").value = 1;
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

<script type="text/javascript">

    function checkGeneral() {
        var isStyle = true;
        var purchase_order_uk = "";
        var purchase_order_ce = "";
        var style_no_uk = "";
        var style_no_ce = "";
        var style_type = document.getElementById("style_type").value;
        var style = document.getElementById("style_type").selectedIndex;

        purchase_order_ce = document.getElementById("po_ce").value.trim();
        purchase_order_uk = document.getElementById("po_uk").value.trim();
        style_no_uk = document.getElementById("style_uk").value.trim();
        style_no_ce = document.getElementById("style_ce").value.trim();

        var supplier_number = document.getElementById('supplier_number').value.trim();
        var factory_code = document.getElementById('factory_code').value.trim();
        var category = document.getElementById('category').value.trim();
        var country_of_origin = document.getElementById('country_of_origin').value.trim();
        var Brand = document.getElementById('Brand').value.trim();
//        var char_description = document.getElementById('char_description').value.trim();
        var season_code = document.getElementById('season_code').value.trim();
//        var carton_dimensions = document.getElementById('carton_dimensions').value.trim();
        var comments = document.getElementById('comments').value.trim();
        var customer_po = document.getElementById('customer_po').value.trim();

        if (style > 0) {
            if (style === 1) {
                if (purchase_order_uk === "" || purchase_order_uk === null) {
                    BootstrapDialog.alert('Please Enter Purchase Order', function () {
                        $('html, body').animate({
                            scrollTop: $("#po_uk").offset().top - 125},
                        'slow', function () {
                            $("#po_uk").focus();

                        });


                    });
                    return;
                }
                if (style_no_uk === "" || style_no_uk === null) {
                    BootstrapDialog.alert('Please Enter Style Number', function () {
                        $('html, body').animate({
                            scrollTop: $("#style_uk").offset().top - 125},
                        'slow', function () {
                            $("#style_uk").focus();
                        });

                    });
                    return;
                }
            } else if (style === 2) {
                if (purchase_order_ce === "" || purchase_order_ce === null) {
                    BootstrapDialog.alert('Please Enter Purchase Order', function () {
                        $('html, body').animate({
                            scrollTop: $("#po_ce").offset().top - 125},
                        'slow', function () {
                            $("#po_ce").focus();
                        });

                    });
                    return;
                }
                if (style_no_ce === "" || style_no_ce === null) {
                    BootstrapDialog.alert('Please Enter Style Number', function () {
                        $('html, body').animate({
                            scrollTop: $("#style_ce").offset().top - 125},
                        'slow', function () {
                            $("#style_ce").focus();
                        });

                    });
                    return;
                }
            } else if (style === 3) {
                if ((purchase_order_ce === "" || purchase_order_ce === null) || (purchase_order_uk === "" || purchase_order_uk === null)) {
                    BootstrapDialog.alert('Please Enter Purchase Order', function () {
                        $('html, body').animate({
                            scrollTop: $("#po_uk").offset().top - 125},
                        'slow', function () {
                            $("#po_uk").focus();
                        });

                    });
                    return;
                }
                if ((style_no_uk === "" || style_no_uk === null) || (style_no_ce === "" || style_no_ce === null)) {
                    BootstrapDialog.alert('Please Enter Style Number', function () {
                        $('html, body').animate({
                            scrollTop: $("#style_uk").offset().top - 125},
                        'slow', function () {
                            $("#style_uk").focus();
                        });

                    });
                    return;
                }

            }
        } else {
            isStyle = false;
            BootstrapDialog.alert('Please select a style type. ', function () {
                $('html, body').animate({
                    scrollTop: $("#style_type").offset().top - 125},
                'slow', function () {
                    $("#style_type").focus();
                });

            });
            return;
        }


        if (supplier_number === "" || supplier_number === null) {
            BootstrapDialog.alert('Please Enter Supplier', function () {
                $('html, body').animate({
                    scrollTop: $("#supplier_number").offset().top - 125},
                'slow', function () {
                    $("#supplier_number").focus();
                });
                return;
            });
        } else if (factory_code === "" || factory_code === null) {
            BootstrapDialog.alert('Please Enter Factory Code', function () {
                $('html, body').animate({
                    scrollTop: $("#factory_code").offset().top - 125},
                'slow', function () {
                    $("#factory_code").focus();
                });
                return;
            });
        } else if (category === "" || category === null) {
            BootstrapDialog.alert('Please Enter Category', function () {
                $('html, body').animate({
                    scrollTop: $("#category").offset().top - 125},
                'slow', function () {
                    $("#category").focus();
                });
                return;
            });
        } else if (country_of_origin === "" || country_of_origin === null) {
            BootstrapDialog.alert('Please Enter Supplier', function () {
                $('html, body').animate({
                    scrollTop: $("#country_of_origin").offset().top - 125},
                'slow', function () {
                    $("#country_of_origin").focus();
                });
                return;
            });
        } else if (Brand === "" || Brand === null) {
            BootstrapDialog.alert('Please Enter Brand', function () {
                $('html, body').animate({
                    scrollTop: $("#Brand").offset().top - 125},
                'slow', function () {
                    $("#Brand").focus();
                });
                return;
            });
        } else {
            if (isStyle) {
                submitGenaral();
            }
        }



    }

    function submitGenaral() {
        var iswashsymbol = false;
        var purchase_order_uk = "";
        var purchase_order_ce = "";
        var style_no_uk = "";
        var style_no_ce = "";
        var style_type = document.getElementById("style_type").value;
        var style = document.getElementById("style_type").selectedIndex;
        var order_ID = document.getElementById("order_id").value.trim();

        purchase_order_ce = document.getElementById("po_ce").value.trim();
        purchase_order_uk = document.getElementById("po_uk").value.trim();
        style_no_uk = document.getElementById("style_uk").value.trim();
        style_no_ce = document.getElementById("style_ce").value.trim();

        var supplier_number = document.getElementById('supplier_number').value.trim();
        var factory_code = document.getElementById('factory_code').value.trim();
        var category = document.getElementById('category').value.trim();
        var country_of_origin = document.getElementById('country_of_origin').value.trim();
        var Brand = document.getElementById('Brand').value.trim();
//        var char_description = document.getElementById('char_description').value.trim();
        var season_code = document.getElementById('season_code').value.trim();
//        var carton_dimensions = document.getElementById('carton_dimensions').value.trim();
        var comments = document.getElementById('comments').value.trim();
        var customer_po = document.getElementById('customer_po').value.trim();
        var tog_value = document.getElementById('tog_value').value.trim();
        var lof_num = document.getElementById('lof_num').value.trim();
        var web_order_id = document.getElementById('web_order_id').value.trim();

        var data = {};

        data["purchase_order_uk"] = purchase_order_uk;
        data["style_no_uk"] = style_no_uk;
        data["purchase_order_ce"] = purchase_order_ce;
        data["style_no_ce"] = style_no_ce;

        data["style_type"] = style_type;
        data["supplier_number"] = supplier_number;
        data["factory_code"] = factory_code;
        data["category"] = category;
        data["country_of_origin"] = country_of_origin;
        data["Brand"] = Brand;
//        data["char_description"] = char_description;
        data["season_code"] = season_code;
//        data["carton_dimensions"] = carton_dimensions;
        data["comments"] = comments;
        data["customer_po"] = customer_po;
        data["tog_value"] = tog_value;
        data["order_id"] = order_ID;
        data["lof_num"] = lof_num;
        data["web_order_id"] = web_order_id;

        console.log(data);

        var jsonDetails = JSON.stringify(data);
        jsonDetails = jsonDetails.replace(/&/g, "kbgz");

        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function () {

            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');

                var status = reply.message;
                if (status) {
                    document.getElementById("order_id").value = reply.order_id;
                    document.getElementById("web_order_id").value = reply.web_order_id;
                    isGeneralSaved = true;
                    nom_Success("Success");
                    tab1_next();
//                    document.getElementById("btn_save_general").disabled = true;
                    document.getElementById("btn_tab1_next").disabled = false;

                } else {
                    nom_warning("Failed");
                }
            }
        };

        xmlHttp.open("POST", "/IEPTescoNew/SaveOrder?actionType=generalData&generalData=" + jsonDetails, true);
        xmlHttp.send();
        $("#tab_2").removeClass("disabled");
        $("#tab_3").removeClass("disabled");
        $("#tab_4").removeClass("disabled");
        $("#tab_5").removeClass("disabled");
    }

</script>                                    

<script type="text/javascript">

    function getSecondrySizes() {
//        getDeptsizes();
        document.getElementById("check_none").checked = false;
        var dept = document.getElementById("department_ID").value;
        var xmlHttp1 = getAjaxObject();
        xmlHttp1.onreadystatechange = function ()
        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
            {

                var data = eval('(' + xmlHttp1.responseText + ')');

                var secView = document.getElementById("secView");
                document.getElementById("check_sec_size").disabled = false;
                $("#secView").empty();
                $("#secView").show();

                var secSizeData = data.second_sizes;
                var outerDiv;
                var innerDiv;
                var secSize = [];

                if (secSizeData.length > 0) {
                    document.getElementById("check_sec_size").disabled = false;
                    document.getElementById("check_none").disabled = false;
                } else {
                    document.getElementById("check_none").disabled = true;
                    document.getElementById("check_none").checked = true;
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
                    tempCheck.name = "secSizeCheck";
                    tempCheck.value = secSizeData[k];
                    tempCheck.id = secSizeData[k];
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
    function getDeptsizes() {
        var style_type = document.getElementById("style_type").value;
        var dept = document.getElementById("department_ID").value;
//        document.getElementById("uk_prim_size").options.length = 1;
//        document.getElementById("ce_prim_size").options.length = 1;
//        if (style_type === "uk") {
//            $('input[name^=uk_siz]').attr("readOnly", false);
//            $('input[name^=ce_siz]').attr("readOnly", true);
//        }
//        if (style_type === "ce") {
//            $('input[name^=uk_siz]').attr("readOnly", true);
//            $('input[name^=ce_siz]').attr("readOnly", false);
//        }
        var xmlHttp1 = getAjaxObject();

        xmlHttp1.onreadystatechange = function ()
        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
            {

//                $('#uk_prim_size option').remove();
//                $('#ce_prim_size option').remove();
                var data = eval('(' + xmlHttp1.responseText + ')');
                var datalistUK = document.getElementById("uk_prim_size");
                var datalistCE = document.getElementById("ce_prim_size");

                var option3 = document.createElement("option");
                option3.innerHTML = "Free Type --- Free Type";
                option3.value = "Free Type --- Free Type";
                option3.id = "Free Type --- Free Type";

                var option4 = document.createElement("option");
                option4.innerHTML = "Free Type --- Free Type";
                option4.value = "Free Type --- Free Type";
                option4.id = "Free Type --- Free Type";

                datalistCE.appendChild(option4);
                datalistUK.appendChild(option3);

                for (var i = 0; i < data.length; i++) {

                    var allSize = data[i].split("#$#");

                    var option1 = document.createElement("option");
                    option1.innerHTML = allSize[0] + " --- " + allSize[1];
                    option1.value = allSize[0] + " --- " + allSize[1];
                    option1.id = allSize[0];

                    var option2 = document.createElement("option");
                    option2.innerHTML = allSize[1] + " --- " + allSize[0];
                    option2.value = allSize[1] + " --- " + allSize[0];
                    option2.id = allSize[1];

                    datalistCE.appendChild(option2);
                    datalistUK.appendChild(option1);
                }


            }
        };
        xmlHttp1.open("POST", "Controller?method=getDeptsizes&dept=" + dept, true);
        xmlHttp1.send();
    }

    function checkSecSizeSelectedOrNot() {
        var isChecked = $('#check_none').is(':checked');
        var elemCount = $('#sec_view').children().length;


        if (!isChecked) {
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
//                document.getElementById("check_sec_size").disabled = true;
            } else {
                if (ch.length === 0) {
                    sm_warning("Please Select Secondary Size.");
                } else {
                    checkUKandCEPrimarySizesWithDept();
//                    document.getElementById("check_sec_size").disabled = true;
                }

            }

        } else {
            checkUKandCEPrimarySizesWithDept();
//            document.getElementById("check_sec_size").disabled = true;
        }



    }
    function addToList() {
        var uk_size = document.getElementById("uk_size").value;
        var ce_size = document.getElementById("ce_size").value;
        var sizeval = true;
        if (uk_size == "" || uk_size == null || ce_size == "" || ce_size == null) {
            sizeval = false;
        }
        if (sizeval) {

            var dept = document.getElementById("department_ID").value;
            var uk_size = document.getElementById("uk_size").value;
            var ce_size = document.getElementById("ce_size").value;
            var uk_ean_no = document.getElementById("uk_ean_no").value;
            var ce_ean_no = document.getElementById("ce_ean_no").value;
            var size = "";
            if (uk_ean_no.length < 12) {
                size = ce_ean_no;
            } else if (ce_ean_no.length < 12) {
                size = uk_ean_no;
            } else {
                size = uk_ean_no + "/" + ce_ean_no;
            }

            var xmlHttp1 = getAjaxObject();
            var data = {};
            data["department"] = dept;
            data["uk_size"] = uk_size;
            data["ce_size"] = ce_size;


            var sendData = JSON.stringify(data);
            xmlHttp1.onreadystatechange = function () {
                if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200) {

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
                    if (uk_size.trim() == "Free Type") {
                        dept = "Free Type";
                        ch = "Free Type";
                    }

                    var eanDetails = eval('(' + xmlHttp1.responseText + ')');
                    var eans = eanDetails.exsistingPrimary;
                    console.log(eans);
                    var table = document.getElementById('eanTable').getElementsByTagName('tbody')[0];
                    var row = document.createElement("tr");

                    var col1 = document.createElement("td");

                    var elem1 = document.createElement("input");
                    elem1.type = "checkbox";
                    elem1.id = uk_size;
                    elem1.disabled = true;
                    elem1.checked = true;
                    elem1.name = "chk_ean";
                    col1.appendChild(elem1);

                    var col2 = document.createElement("td");
                    col2.innerHTML = size;

                    var col3 = document.createElement("td");
                    col3.innerHTML = uk_size;

                    var col4 = document.createElement("td");
                    col4.innerHTML = ce_size;

                    var col5 = document.createElement("td");
                    col5.innerHTML = ch;

                    var col6 = document.createElement("td");
                    col6.innerHTML = dept;

                    var col7 = document.createElement("td");

                    var elem4 = document.createElement("input");
                    elem4.type = "number";
                    elem4.min = "0";
                    elem4.className = "form-control";
                    elem4.name = "quantity";
                    elem4.id = "quantity";
                    elem4.placeholder = "Amount";
                    elem4.setAttribute("style", "width: 100%");
                    elem4.setAttribute("onkeypress", "javascript: return checkForSecondDecimal(this, event);");
                    col7.appendChild(elem4);

                    var col8 = document.createElement("td");

//                    var elem5 = document.createElement("input");
//                    elem5.type = "text";
//                    elem5.className = "form-control";
//                    elem5.name = "color";
//                    elem5.id = "color";
//                    elem5.placeholder = "Color";
//                    elem5.setAttribute("style", "width: 100%");
//                    col8.appendChild(elem5);

                    var col9 = document.createElement("td");
                    var elem6 = document.createElement("span");
                    elem6.id = uk_size;
                    elem6.name = uk_size;
                    elem6.className = "btn btn-default glyphicon glyphicon-remove text-center";
                    col9.appendChild(elem6);

                    row.appendChild(col1);
                    row.appendChild(col2);
                    row.appendChild(col3);
                    row.appendChild(col4);
                    row.appendChild(col5);
                    row.appendChild(col6);
                    row.appendChild(col7);
//                    row.appendChild(col8);
                    row.appendChild(col9);

                    table.appendChild(row);

                    $("#uk_ean_no_list option[value='" + uk_ean_no + "']").attr('disabled', 'disabled');
                    $("#ce_ean_no_list option[value='" + ce_ean_no + "']").attr('disabled', 'disabled');
                    document.getElementById("uk_ean_no").value = "";
                    document.getElementById("ce_ean_no").value = "";
                    document.getElementById("uk_size").value = "";
                    document.getElementById("ce_size").value = "";
                }
            };
            xmlHttp1.open("POST", "/IEPTescoNew/Controller?method=checkUKandCEPrimarySizesWithDept1&data=" + sendData, true);
            xmlHttp1.send();
        } else {
            sm_warning("You Must Enter UK Size and CE Size");
        }
    }

    var saveid = {};
    var Gsize = {};
    var Geanupdate = {};
    function checkExistEAN(id) {
        saveid[id] = "";
        Gsize [id] = "";
        Geanupdate [id] = "";
        var ean_no = document.getElementById(id).value;
        var style_type = "";
        if (id == "uk_ean_no") {
            style_type = "UK";
        } else if (id == "ce_ean_no") {
            style_type = "CE";
        }

        var data = ean_no + "XX" + style_type;
        $("#add_to_list").attr('disabled', 'disabled');
        if (ean_no.length !== 13) {
            return;
        }

        var final_digit = ean_no.substring(ean_no.length - 1, ean_no.length);

        var totalVal = 0;
        for (var i = 1; i < ean_no.length; i++) {
            var current_digit = ean_no.substring(i - 1, i);
            if (i % 2 == 0) {
                totalVal += current_digit * 3;
            } else {
                totalVal += current_digit * 1;
            }
        }

        var totalMax = Math.ceil(totalVal / 10) * 10;
        var cnt = totalMax - totalVal;
        if (final_digit != cnt) {
            nom_alert("Invalid EAN Number.");
            return;
        }

        var table = document.getElementById('eanTable').getElementsByTagName('tbody')[0];
        var isExist = false;
        for (var x = 0; x < table.rows.length; x++) {
            var rw = table.rows[x];
            var eanDetailNo = rw.cells[1].innerHTML;
            if (ean_no === eanDetailNo) {
                isExist = true;
                break;
            }
        }
        if (isExist) {
            sm_warning("EAN No Already Existed in Table.");
//            document.getElementById("ean_no").value = "";
            return;
        } else {
            var xmlHttp1 = getAjaxObject();

            xmlHttp1.onreadystatechange = function ()
            {
                if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
                {
                    var data = eval('(' + xmlHttp1.responseText + ')');
                    console.log(data);
                    var message = data.message;
                    if (message === 1) {
                        var ean_id = data.ean_details.id;
                        Geanupdate [id] = ean_id;
                        if (id == "uk_ean_no") {
                            document.getElementById("uk_size").value = data.ean_details.size;
                            Gsize ["uk_ean_no"] = data.ean_details.size;
                            var uk_size = document.getElementById("uk_size").value;
                            var tmpuk = 0;
                            $("#uk_div option").each(function () {
                                if (uk_size.trim() == this.id) {
                                    tmpuk = 1;
                                }
                            });

                            if (tmpuk != 1) {
                                sm_alert("Selected Department and Ean Number Dosen't Match, Please Check");
                            }
                        } else
                        if (id == "ce_ean_no") {
                            document.getElementById("ce_size").value = data.ean_details.size;
                            Gsize ["ce_ean_no"] = data.ean_details.size;
                            var ce_size = document.getElementById("ce_size").value;
                            var tmpce = 0;
                            $("#ce_div option").each(function () {
                                if (ce_size.trim() == this.id) {
                                    tmpce = 1;
                                }
                            });

                            if (tmpce != 1) {
                                sm_alert("Selected Department and Ean Number Dosen't Match, Please Check");
                            }
                        }
                    } else if (message === 0) {
                        saveid [id] = "new";
                        sm_warning("Please add relevent Primary Sizes.");
                    }
                    $("#add_to_list").removeAttr('disabled');
                }
            };
            xmlHttp1.open("POST", "Controller?method=checkExistEAN1&data=" + data, true);
            xmlHttp1.send();
        }
    }
    function saveEan() {
//        Geanupdate ["uk_ean_no"] = "";
//        Geanupdate ["ce_ean_no"] = "";
        if (saveid["uk_ean_no"] == "new" || saveid["ce_ean_no"] == "new") {
            var uk_ean_no = document.getElementById("uk_ean_no").value;
            var ce_ean_no = document.getElementById("ce_ean_no").value;
            var uk_size = document.getElementById("uk_size").value;
            var ce_size = document.getElementById("ce_size").value;

            var eanDetails = [];
            var ean = "";
            var styleType = "";
            var size = "";
            var eanUK = uk_ean_no;
            var eanCE = ce_ean_no;
            var sizeUK = uk_size;
            var sizeCE = ce_size;

            if (uk_ean_no.length > 10 && saveid["uk_ean_no"] == "new") {
                ean = eanUK;
                styleType = "UK";
                size = sizeUK;
                var eanDetail = {};
                eanDetail["ean"] = ean;
                eanDetail["size"] = size;
                eanDetail["styleType"] = styleType;
                eanDetails.push(eanDetail);

            }
            if (ce_ean_no.length > 10 && saveid["ce_ean_no"] == "new") {
                ean = eanCE;
                styleType = "CE";
                size = sizeCE;
                var eanDetail = {};
                eanDetail["ean"] = ean;
                eanDetail["size"] = size;
                eanDetail["styleType"] = styleType;
                eanDetails.push(eanDetail);

            }
            console.log(eanDetails);
            console.log(eanDetails.length);
            var data = JSON.stringify(eanDetails);
            console.log(data);

            var xmlHttp1 = getAjaxObject();

            xmlHttp1.onreadystatechange = function ()
            {
                if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
                {
                    var data1 = eval('(' + xmlHttp1.responseText + ')');
                    var data1var = data1.reply;
                    data1var.toString().length;
                    console.log(data1);
                    if (data1var.toString().length > 1) {
                        if (saveid["uk_ean_no"] == "new") {
                            Geanupdate ["uk_ean_no"] = data1var.toString();
                            saveid["uk_ean_no"] = "";
                        } else if (saveid["ce_ean_no"] == "new") {
                            Geanupdate ["ce_ean_no"] = data1var.toString();
                            saveid["ce_ean_no"] = "";
                        }

                    } else {
                    }
                }
            };
            xmlHttp1.open("POST", "Controller?method=addEanDetails1&dataList=" + data, true);
            xmlHttp1.send();
        }

        var uk_ean_no = document.getElementById("uk_ean_no").value;
        var ce_ean_no = document.getElementById("ce_ean_no").value;
        var uk_size = Gsize["uk_ean_no"]; // database saved size
        var ce_size = Gsize["ce_ean_no"];  // database saved size
        var uk_size1 = document.getElementById("uk_size").value;
        var ce_size1 = document.getElementById("ce_size").value;
        var uk_update_id = Geanupdate["uk_ean_no"];
        var ce_update_id = Geanupdate["ce_ean_no"];


        if (typeof (uk_size) === "undefined" || uk_size == "") {
        } else {
            if (uk_size == uk_size1) {
//                alert("uk size ok");
            } else {
//                alert("uk size changed  " + uk_update_id);
                updateEan(uk_ean_no, uk_update_id, "UK");
            }
        }

        if (typeof (ce_size) === "undefined" || ce_size == "") {
        } else {
            if (ce_size == ce_size1) {
//                alert("ce size ok");
            } else {
//                alert("ce size changed  " + ce_update_id);
                updateEan(ce_ean_no, ce_update_id, "CE");
            }
        }

    }

    function updateEan(ean, id, styleType) {
//        var size = "";
        var uk_size = "";
        var ce_size = "";
//        if (styleType == "UK") {
//            size = document.getElementById("uk_size").value;
//        } else
//        if (styleType == "CE") {
//            size = document.getElementById("ce_size").value;
//        }

        uk_size = document.getElementById("uk_size").value;
        ce_size = document.getElementById("ce_size").value;
//        alert("-----------------------" + size);

        var eanDetails = [];
        var eanDetail = {};
        eanDetail["ean"] = ean;
        eanDetail["uk_size"] = uk_size;
        eanDetail["ce_size"] = ce_size;
        eanDetail["styleType"] = styleType;
        eanDetail["id"] = id;
        eanDetails.push(eanDetail);


        console.log(eanDetails);
        var data = JSON.stringify(eanDetails);
        console.log(data);

        var xmlHttp1 = getAjaxObject();

        xmlHttp1.onreadystatechange = function ()
        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
            {
                var data1 = eval('(' + xmlHttp1.responseText + ')');
                var data1var = data1.reply;
                data1var.toString().length;
                console.log(data1);
//                    if (data1var.toString().length > 1) {
//                        if (saveid["uk_ean_no"] == "new") {
//                            Geanupdate ["uk_ean_no"] = data1var.toString();
//                        } else if (saveid["ce_ean_no"] == "new") {
//                            Geanupdate ["ce_ean_no"] = data1var.toString();
//                        }
//
//                    } else {
//                        alert("bbbb");
//                    }
            }
        };
        xmlHttp1.open("POST", "Controller?method=updatekExistEAN1&dataList=" + data, true);
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
                console.log(eans);
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
                        $("#Save_EAN").removeAttr("disabled");
                    }
                    if (primrySize.trim() == "Free Type") {
                        var rws = table.rows[x];
                        rws.cells[4].innerHTML = "Free Type";
                        rws.cells[5].innerHTML = "Free Type";
                    }
                }
                $("#secView").empty();
                $("#check_none").checked = false;
                $("#check_none").readOnly = true;
                document.getElementById("department_ID").selectedIndex = 0;
            }
        };
        xmlHttp1.open("POST", "/IEPTescoNew/Controller?method=checkUKandCEPrimarySizesWithDept&data=" + sendData, true);
        xmlHttp1.send();
    }

    function getEanDetail() {
        var ean_det = {};
        var eanchkCount = $("#eanTable tbody tr").length;
        var checkboxes = $("#eanTable [type='checkbox']:checked").length;

        if (eanchkCount !== checkboxes) {
            sm_alert("Please select relevent Department and Check.");
            return;
        }
        if (eanchkCount <= 0) {
            sm_alert("Please add atleast one EAN to save");
            isEANSaved = false;
            return;
        }
        var table = document.getElementById('eanTable').getElementsByTagName('tbody')[0];
        var style_te = document.getElementById("style_type").selectedIndex;
        var secSize = [];
        for (var x = 0; x < table.rows.length; x++) {
            var eanDetail = {};
            var rw = table.rows[x];
            var ean = rw.cells[1].innerHTML;
            var ukPrime = rw.cells[2].innerHTML;
            var cePrime = rw.cells[3].innerHTML;
            var secondarySize = rw.cells[4].innerHTML;
            secondarySize = secondarySize.trim();
            secSize = secondarySize.split(' / ');
            var dept = rw.cells[5].innerHTML;
            var tblquantity = rw.cells[6].children[0];
//            var tblcolor = rw.cells[7].children[0];

            ean = ean.trim();
            var style = document.getElementById("style_type").selectedIndex;
            if (style == 3) {
                eanDetail["uk_ean"] = ean.trim() + "/" + ean.trim();
            } else {
                eanDetail["uk_ean"] = ean.trim();
            }
            eanDetail["uk_size"] = ukPrime.trim();
            eanDetail["ce_size"] = cePrime.trim();
            eanDetail["department"] = dept.trim();
            eanDetail["quantity"] = tblquantity.value.trim();
//            eanDetail["color"] = tblcolor.value.trim();
            eanDetail["secSize"] = secSize;
            ean_det[ean] = eanDetail;
            console.log(ean_det);
        }

        var data = {};
        data["order_id"] = document.getElementById("order_id").value;
        data["ean_details"] = ean_det

        var jsonDetails = JSON.stringify(data);
        jsonDetails = jsonDetails.replace(/&/g, "kbgz");

        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function () {

            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');
                if (reply.message) {
                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_SUCCESS,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Success'
                    });
                    isEANSaved = true;
                    tab2_next();
                } else {
                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_WARNING,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Fail'
                    });
                }
            }
        };
        xmlHttp.open("POST", "/IEPTescoNew/SaveOrder?actionType=eanData&eanData=" + jsonDetails, true);
        xmlHttp.send();
    }

    function addSellingPrices() {

        var value = {};
        var cz = document.getElementById("cz").value.trim();
        var sk = document.getElementById("sk").value.trim();
        var en = document.getElementById("en").value.trim();
        var hu = document.getElementById("hu").value.trim();
        var tr = document.getElementById("tr").value.trim();
        var euro = document.getElementById("euro").value.trim();
        var pound = document.getElementById("pound").value.trim();

        value["cz"] = cz;
        value["sk"] = sk;
        value["en"] = en;
        value["tr"] = tr;
        value["hu"] = hu;
        value["euro"] = euro;
        value["pound"] = pound;
        value["order_id"] = document.getElementById("order_id").value;

        var data = JSON.stringify(value);
        console.log(data);


        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function () {

            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log(reply);
                if (reply.message) {
                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_SUCCESS,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Success'
                    });
                } else {
                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_WARNING,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Fail'
                    });
                }
            }
        };

        xmlHttp.open("POST", "/IEPTescoNew/SaveOrder?actionType=sellingData&sellingData=" + data, true);
        xmlHttp.send();

    }

</script>  

<script type="text/javascript">
    var temp_technical_care = {};
    var temp_technical_fiber = {};

    function addTechCare() {
        var tempTechCare = {};
        var tblTechCare = document.getElementById('tblTechCare').getElementsByTagName('tbody')[0];
        var techcareInfo = document.getElementById('techcareInfo');

        var optionsArr = $('#techcareInfo').map(function () {
            return $(this).find('option:disabled').length;
        }).toArray();



        var rawCount = $("#tblTechCare > tbody > tr").length;
        if (techcareInfo.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("techcareInfo").focus();
            return;
        }
        if (optionsArr > 3) {
            sm_warning("Maximum Care Count Reached.");
            document.getElementById("techcareInfo").selectedIndex = 0;
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

    function addTechFireWarnings() {
        var tempTechCare = {};
        var tblTechCare = document.getElementById('tblTechCare').getElementsByTagName('tbody')[0];
        var techFireWarnings = document.getElementById('techFireWarnings');
        if (techFireWarnings.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("techFireWarnings").focus();
            return;
        }
        var careInfo = techFireWarnings.value;
        $("#techFireWarnings option[value='" + careInfo + "']").prop('disabled', true);
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
        techFireWarnings.options.selectedIndex = 0;
    }

    function addTechWarning() {
        var tempTechCare = {};
        var tblTechCare = document.getElementById('tblTechCare').getElementsByTagName('tbody')[0];
        var techWarnings = document.getElementById('techWarnings');
        if (techWarnings.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("techWarnings").focus();
            return;
        }
        var careInfo = techWarnings.value;
        $("#techWarnings option[value='" + careInfo + "']").prop('disabled', true);
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
        techWarnings.options.selectedIndex = 0;
    }

    function addTechChild() {
        var tempTechCare = {};
        var tblTechCare = document.getElementById('tblTechCare').getElementsByTagName('tbody')[0];
        var techChild = document.getElementById('techChild');
        if (techChild.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("techChild").focus();
            return;
        }
        var careInfo = techChild.value;
        $("#techChild option[value='" + careInfo + "']").prop('disabled', true);
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
        techChild.options.selectedIndex = 0;
    }

    var temp_fiberDetail = {};
    function addFiber() {
        $("#mainWord").prop('disabled', true);
        var tempTechFiber = {};
        var fiberType = document.getElementById("fiberName");
        var fiberQuantity = document.getElementById("fiberQuantity").value;
        var remainQuantity = parseInt(document.getElementById("txt_fiberQuantity").value);
        var fiberCount = document.getElementById("txt_fiberCount").value;
        var fib1 = parseInt(document.getElementById("fiberQuantity").value);

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
        } else if (fib1 === 0) {
            sm_alert("Fiber Quantity Cannot be '0'");
            document.getElementById("fiberQuantity").focus();
            return;

        } else if (fiberCount > 6) {
            sm_alert("Maximum Fiber Count Reached(6)");
            document.getElementById("fiberName").selectedIndex = 0;
            document.getElementById("fiberQuantity").value = "";
            document.getElementById("fiberQuantity").placeholder = "Remain Amount : " + remainQuantity;
            return;
        } else if (fiberQuantity > remainQuantity) {
            sm_alert("Maximum Fiber Amount Reached(100)");
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
        $("#mainWord option[value='" + temp_fiberDetail["mainword"] + "']").prop('disabled', true);
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
        // to check none fiber compression
        $("#mainWord option[value='None']").prop('disabled', false);
        if (parseInt(noOfFiberComposition) > 0 && parseInt(noOfFiberComposition) < 6) {
            $("#mainWord option[value='None']").prop('disabled', true);
        }
        temp_technical_fiber["Fiber Composition : " + temp_fiberDetail["mainword"]] = txt_fiberCompo;
        //
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
        if (temp_fiberDetail["mainword"] == "None") {
//            document.getElementById("fiberComposition").value = parseInt(noOfFiberComposition) + 7;
            document.getElementById("fiberComposition").value = "*";
            document.getElementById("mainWord").disabled = true;
            document.getElementById("fiberName").disabled = true;
            document.getElementById("fiberQuantity").disabled = true;
        } else {
            document.getElementById("fiberComposition").value = parseInt(noOfFiberComposition) + 1;
        }
        if (document.getElementById("fiberComposition").value > "7") {
            document.getElementById("fiberComposition").value = "*";
            document.getElementById("mainWord").disabled = true;
            document.getElementById("fiberName").disabled = true;
            document.getElementById("fiberQuantity").disabled = true;
        } else if (document.getElementById("fiberComposition").value > "6") {
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

        var caretext = document.getElementById("techcareInfo").getElementsByTagName("option");
        for (var i = 1; i < caretext.length; i++) {
            caretext[i].disabled = false;
        }
        var techFireWarnings = document.getElementById("techFireWarnings").getElementsByTagName("option");
        for (var i = 1; i < techFireWarnings.length; i++) {
            techFireWarnings[i].disabled = false;
        }
        var techWarnings = document.getElementById("techWarnings").getElementsByTagName("option");
        for (var i = 1; i < techWarnings.length; i++) {
            techWarnings[i].disabled = false;
        }
        var techChild = document.getElementById("techChild").getElementsByTagName("option");
        for (var i = 1; i < techChild.length; i++) {
            techChild[i].disabled = false;
        }
        var mainWord = document.getElementById("mainWord").getElementsByTagName("option");
        for (var i = 1; i < mainWord.length; i++) {
            mainWord[i].disabled = false;
        }
        var fiberName = document.getElementById("fiberName").getElementsByTagName("option");
        for (var i = 1; i < fiberName.length; i++) {
            fiberName[i].disabled = false;
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
        var tech_ref_add = document.getElementById("tech_add_ref");
        var tech_lbl_des = document.getElementById("tech_lbl_des").value.trim();
//        var tech_wash_symbol = document.getElementById("techWashTxt_W").value.trim() + document.getElementById("techWashTxt_B").value.trim() + document.getElementById("techWashTxt_D").value.trim() + document.getElementById("techWashTxt_I").value.trim() + document.getElementById("techWashTxt_C").value.trim();
        var tech_wash_symbol = document.getElementById("techWashSymbol").value.trim();
        var techFiberCount = Object.keys(temp_technical_fiber).length;
        var techCareCount = Object.keys(temp_technical_care).length;
        if (tech_labelRef.value === "" || tech_labelRef.value === null) {
            sm_alert("Label Reference is a required field.");
            $('html, body').animate({
                scrollTop: $("#tech_labelRefId").offset().top - 125},
            'slow', function () {
                $("#tech_labelRefId").focus();
                return;
            });
        } else if (tech_labelGroup.value === "" || tech_labelGroup.value === null) {
            sm_alert("Please Enter Garment Type");
            $('html, body').animate({
                scrollTop: $("#tech_labelGroupId").offset().top - 125},
            'slow', function () {
                $("#tech_labelRefId").focus();
                return;
            });
//        } else if (tech_lbl_des === "" || tech_lbl_des === null) {
//            sm_alert("Please Enter Label Descrepion");
//            $('html, body').animate({
//                scrollTop: $("#tech_lbl_des").offset().top - 125},
//            'slow', function () {
//                $("#tech_lbl_des").focus();
//                return;
//            });
        } else if (techFiberCount === 0) {
            sm_alert("Minimum Fiber Composition count is 1.");
            return;
        } else if (tech_wash_symbol.length !== 20) {
            sm_alert("Wash Symbol is a required field.");
            $('html, body').animate({
                scrollTop: $("#techWash_W").offset().top - 125},
            'slow', function () {
                $("#techWash_W").focus();
                return;
            });
        } else if (tech_ref_add.value.length <= 0 || tech_ref_add.value.length >= 255) {
            sm_alert("Please add valid free type");
            $('html, body').animate({
                scrollTop: $("#tech_add_ref").offset().top - 125},
            'slow', function () {
                $("#tech_add_ref").focus();
                return;
            });
        } else if (iswashsymbol == false) {
            sm_alert("Please Save the Wash Symbol");
            $('html, body').animate({
                scrollTop: $("#btn_wash_tech_vertify").offset().top - 125},
            'slow', function () {
                $("#btn_wash_tech_vertify").focus();
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
            temp_technical_label["counter"] = document.getElementById("counter_techlabel").value;
            temp_technical_label["tech_labelRef"] = tech_labelRef.value.trim();
            temp_technical_label["tech_labelGroup"] = tech_labelGroup.value.trim();
            temp_technical_label["tech_lbl_des"] = tech_lbl_des;
            temp_technical_label["temp_technical_care"] = techAllCare;
            temp_technical_label["temp_technical_fiber"] = temp_technical_fiber;
            temp_technical_label["tech_wash_symbol"] = tech_wash_symbol;
            temp_technical_label["tech_ref_add"] = tech_ref_add.value.trim();

//            technical_labels[randomKey] = temp_technical_label;

            var data = {};
            data["order_id"] = document.getElementById("order_id").value;
            data["technical_labels"] = temp_technical_label;

            console.log(data);

            var jsonDetails = JSON.stringify(data);
            jsonDetails = jsonDetails.replace(/&/g, "kbgz");

            var xmlHttp = getAjaxObject();

            xmlHttp.onreadystatechange = function () {

                if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                    var reply = eval('(' + xmlHttp.responseText + ')');
                    console.log(reply);
                    if (reply.message) {

                        BootstrapDialog.show({
                            title: 'Notification',
                            type: BootstrapDialog.TYPE_SUCCESS,
                            size: BootstrapDialog.SIZE_SMALL,
                            message: 'Success'
                        });
                        isTechSaved = true;
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
                        var techlabels = reply.tech_details;
                        closeTech();
                        displayTechnical(techlabels);
                        document.getElementById("counter_techlabel").value = "";
                    } else {
                        BootstrapDialog.show({
                            title: 'Notification',
                            type: BootstrapDialog.TYPE_WARNING,
                            size: BootstrapDialog.SIZE_SMALL,
                            message: 'Fail'
                        });
                    }
                }
            };

            xmlHttp.open("POST", "/IEPTescoNew/SaveOrder?actionType=techData&techData=" + jsonDetails, true);
            xmlHttp.send();

        }
    }

    function displayTechnical(technicallabels) {
        $("#techView").empty();
        var techLabelCount = Object.keys(technicallabels).length;

        document.getElementById("techCount").innerHTML = "No of Concertina Labels : " + techLabelCount;
        if (techLabelCount > 0) {
            isTechSaved = true;
            var fico = [];
            fico[0] = "";
            fico[1] = "";
            fico[2] = "";
            fico[3] = "";
            fico[4] = "";
            fico[5] = "";
            for (var key in technicallabels) {
                var fico = [];
                fico[0] = "";
                fico[1] = "";
                fico[2] = "";
                fico[3] = "";
                fico[4] = "";
                fico[5] = "";
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
                var techRow10 = document.createElement("tr");
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
                var techR9Col1 = document.createElement("td");
                techR9Col1.innerHTML = "Fiber Composition 5";
                var techR9Col2 = document.createElement("td");
                techR9Col2.innerHTML = fico[4];
                var techR10Col1 = document.createElement("td");
                techR10Col1.innerHTML = "Fiber Composition 6";
                var techR10Col2 = document.createElement("td");
                techR10Col2.innerHTML = fico[5];
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
                techRow9.appendChild(techR9Col1);
                techRow9.appendChild(techR9Col2);
                techRow10.appendChild(techR10Col1);
                techRow10.appendChild(techR10Col2);
                techTbody.appendChild(techRow1);
                techTbody.appendChild(techRow2);
                techTbody.appendChild(techRow3);
                techTbody.appendChild(techRow4);
                techTbody.appendChild(techRow5);
                techTbody.appendChild(techRow6);
                techTbody.appendChild(techRow7);
                techTbody.appendChild(techRow8);
                techTbody.appendChild(techRow9);
                techTbody.appendChild(techRow10);
                techTabel.appendChild(techTbody);
                techDiv.appendChild(techTabel);
                techView.appendChild(techDiv);
            }
        } else {
            isTechSaved = false;
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
        var rawCount = $("#tblSwingCare > tbody > tr").length;
        if (swingcareInfo.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("swingcareInfo").focus();
            return;
        }
        if (rawCount === 3) {
            sm_warning("Maximum Care Count Reached.");
            document.getElementById("swingcareInfo").selectedIndex = 0;
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

    function addSwingFireWarnings() {
        var tempSwingCare = {};
        var tblSwingCare = document.getElementById('tblSwingCare').getElementsByTagName('tbody')[0];
        var swingFireWarnings = document.getElementById('swingFireWarnings');
        if (swingFireWarnings.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("swingFireWarnings").focus();
            return;
        }
        var careInfo = swingFireWarnings.value;
        $("#swingFireWarnings option[value='" + careInfo + "']").prop('disabled', true);
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
        document.getElementById("swingFireWarnings").selectedIndex = 0;
    }

    function addSwingWarning() {
        var tempSwingCare = {};
        var tblSwingCare = document.getElementById('tblSwingCare').getElementsByTagName('tbody')[0];
        var swingWarnings = document.getElementById('swingWarnings');
        if (swingWarnings.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("swingWarnings").focus();
            return;
        }
        var careInfo = swingWarnings.value;
        $("#swingWarnings option[value='" + careInfo + "']").prop('disabled', true);
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
        document.getElementById("swingWarnings").selectedIndex = 0;
    }

    function addSwingChild() {
        var tempSwingCare = {};
        var tblSwingCare = document.getElementById('tblSwingCare').getElementsByTagName('tbody')[0];
        var swingChild = document.getElementById('swingChild');
        if (swingChild.selectedIndex === 0) {
            sm_warning("Please select a Care Text");
            document.getElementById("swingcareInfo").focus();
            return;
        }
        var careInfo = swingChild.value;
        $("#swingChild option[value='" + careInfo + "']").prop('disabled', true);
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
        document.getElementById("swingChild").selectedIndex = 0;
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
            sm_alert("Please Enter at least one Referense.");
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
            sm_alert("Please Enter Garment Type");
            $('html, body').animate({
                scrollTop: $("#swing_labelGroupId").offset().top - 125},
            'slow', function () {
                $("#swing_labelGroupId").focus();
                return;
            });
        } else if (swing_lbl_des === "" || swing_lbl_des === null) {
            sm_alert("Please Enter Label Description");
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

            temp_swing_ticket["swing_labelRef"] = ref;
            temp_swing_ticket["swing_labelGroup"] = swing_labelGroup.value.trim();
            temp_swing_ticket["swing_lbl_des"] = swing_lbl_des;
            temp_swing_ticket["temp_swing_care"] = swingAllCare;
            temp_swing_ticket["swing_wash_symbol"] = swing_wash_symbol;
            temp_swing_ticket["trend_name"] = trendName.value;
            temp_swing_ticket["product_benefit"] = productBenefit.value;
            temp_swing_ticket["product_description"] = productDescription.value;

            swing_tickets[randomKey] = temp_swing_ticket;

            var data = {};
            data["order_id"] = document.getElementById("order_id").value;
            data["swing_tickets"] = swing_tickets;

            console.log(data);

            var jsonDetails = JSON.stringify(data);
            jsonDetails = jsonDetails.replace(/&/g, "kbgz");

            var xmlHttp = getAjaxObject();

            xmlHttp.onreadystatechange = function () {

                if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                    var reply = eval('(' + xmlHttp.responseText + ')');
                    if (reply.message) {
                        BootstrapDialog.show({
                            title: 'Notification',
                            type: BootstrapDialog.TYPE_SUCCESS,
                            size: BootstrapDialog.SIZE_SMALL,
                            message: 'Success'
                        });


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

                    } else {
                        BootstrapDialog.show({
                            title: 'Notification',
                            type: BootstrapDialog.TYPE_WARNING,
                            size: BootstrapDialog.SIZE_SMALL,
                            message: 'Fail'
                        });
                    }
                }
            };

            xmlHttp.open("POST", "/IEPTescoNew/SaveOrder?actionType=swingData&swingData=" + jsonDetails, true);
            xmlHttp.send();

        }


    }

    function displaySwing(swingTickets) {
        $("#swingView").empty();
        var swingTicketCount = Object.keys(swingTickets).length;
        document.getElementById("swingCount").innerHTML = "No of Concertina Labels : " + swingTicketCount;
        if (swingTicketCount > 0) {
            $("#selling_row").show();
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
        btnSwingWashClear();
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
    $(document).on("click", "li[name=tabs]", function () {
        var tab_id = this.id;
        if (tab_id === "tab_1") {
            tab0_next();
        } else if (tab_id === "tab_2" && isGeneralSaved) {
            tab1_next();
        } else if (tab_id === "tab_3" && isGeneralSaved) {
            tab2_next();
        }
//        else if (tab_id === "tab_4" && isGeneralSaved) {
//            tab3_next();
//        } 
        else if (tab_id === "tab_5" && isGeneralSaved && isEANSaved && isTechSaved) {
            tab4_next();
        }
    });

    function tab0_next() {
        $("#tab_1").addClass("active");
        $("#tab_2").removeClass("active");
        $("#tab_3").removeClass("active");
        $("#tab_4").removeClass("active");
        $("#tab_5").removeClass("active");

        $("#general_container").show();
        $("#ean_container").hide();
        $("#tech_Container").hide();
        $("#swing_Container").hide();
        $("#finish_container").hide();
        $('html, body').animate({
            scrollTop: $("#general_container").offset().top - 125},
        'slow', function () {
            $("#general_container").focus();
            return;
        });
    }

    function tab1_next() {
        $("#tab_1").removeClass("active");
        $("#tab_2").addClass("active");
        $("#tab_3").removeClass("active");
        $("#tab_4").removeClass("active");
        $("#tab_5").removeClass("active");

        $("#general_container").hide();
        $("#ean_container").show();
        $("#tech_Container").hide();
        $("#swing_Container").hide();
        $("#finish_container").hide();
        $('html, body').animate({
            scrollTop: $("#ean_container").offset().top - 125},
        'slow', function () {
            $("#ean_container").focus();
            return;
        });
    }

    function tab2_next() {
        $("#tab_1").removeClass("active");
        $("#tab_2").removeClass("active");
        $("#tab_3").addClass("active");
        $("#tab_4").removeClass("active");
        $("#tab_5").removeClass("active");

        $("#general_container").hide();
        $("#ean_container").hide();
        $("#tech_Container").show();
        $("#swing_Container").hide();
        $("#finish_container").hide();
        $('html, body').animate({
            scrollTop: $("#tech_Container").offset().top - 125},
        'slow', function () {
            $("#tech_Container").focus();
            return;
        });
    }

    function tab3_next() {
        $("#tab_1").removeClass("active");
        $("#tab_2").removeClass("active");
        $("#tab_3").removeClass("active");
        $("#tab_4").addClass("active");
        $("#tab_5").removeClass("active");

        $("#general_container").hide();
        $("#ean_container").hide();
        $("#tech_Container").hide();
        $("#swing_Container").show();
        $("#finish_container").hide();
        $('html, body').animate({
            scrollTop: $("#swing_Container").offset().top - 125},
        'slow', function () {
            $("#swing_Container").focus();
            return;
        });
    }

    function tab4_next() {
        if (!isGeneralSaved) {
            sm_alert("Please save Genaral Details");
        } else if (!isEANSaved) {
            sm_alert("Please save EAN Details");
        } else if (!isTechSaved) {
            sm_alert("Please save Technical Details");
        } else {
            $("#tab_1").removeClass("active");
            $("#tab_2").removeClass("active");
            $("#tab_3").removeClass("active");
            $("#tab_4").removeClass("active");
            $("#tab_5").addClass("active");

            $("#general_container").hide();
            $("#ean_container").hide();
            $("#tech_Container").hide();
            $("#swing_Container").hide();
            $("#finish_container").show();
        }
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

<%@include file="../include/footer.jsp"%>

<%
    } else {
        response.sendRedirect("LogoutController");
    }
%>