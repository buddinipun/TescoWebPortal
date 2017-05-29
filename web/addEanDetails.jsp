<%-- 
    Document   : addEanDetails
    Created on : Sep 28, 2015, 10:23:52 AM
    Author     : Oshan
--%>


<%@page import="java.util.List"%>
<%@page import="com.impression.extractpdf.CommonData"%>
<%@page import="com.impression.hibe.model.SysUser"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="./include/header.jsp"%>
<%@include file="./include/sideMenu.jsp"%>

<%    List<String> eanSendArray = (List<String>) request.getAttribute("newList");

%>

<%    SysUser user6 = (SysUser) session.getAttribute("user");
    if (user6 != null) {

%>

<div id="page-wrapper">
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="row">
            <div class="col-lg-8 col-md-8 col-lg-offset-2 col-md-offset-2">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading"><strong>EAN Details</strong></div>
                    <div class="panel-body">
                        <form method="POST" class="form-horizontal">
                            <div class="col-lg-8 col-lg-offset-2">
                                <div class="form-group">
                                    <label class="control-label col-sm-4" for="style_type">Style Type:</label>
                                    <div class="col-sm-8">
                                        <select id="style_type" onchange="getPrimarySize();" class="form-control">
                                            <option disabled selected> - Select Type - </option>
                                            <option value="uk">UK</option>
                                            <option value="ce">CE</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Table -->
                    <table border="0" class="table table-responsive table-striped" id="eanTable">
                        <thead>
                            <tr>
                                <th width="40%" style="text-align: center" >EAN Number</th>
                                <th width="30%" style="text-align: center" >UK Primary Size</th>
                                <th style="text-align: center" >CE Primary Size</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < eanSendArray.size(); i++) {
                            %>

                            <tr>
                                <td style="text-align: center" ><%=eanSendArray.get(i)%></td>
                                <td>
                                    <input id="uk_siz<%=i%>" name="uk_siz<%=i%>" list="uk_prim_size"  value=""  class="form-control" />
                                    <datalist id="uk_prim_size"> 
                                    </datalist>
                                </td>
                                <td>
                                    <input id="ce_siz<%=i%>"  name="ce_siz<%=i%>" list="ce_prim_size"  value=""  class="form-control"/>
                                    <datalist id="ce_prim_size" > 
                                    </datalist>
                                </td>
                            </tr>
                            <% if (i == eanSendArray.size() - 1) {

                            %>
                        <script>
                            var val_update = [];
                            val_update.length = <%=i%>;
                        </script>
                        <%}
                        %>

                        <%
                            }
                        %>
                        </tbody>
                    </table>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-lg-12 col-md-12">
                                <center>
                                    <form id="next" action="Extract/viewORMS.jsp" method="post">
                                        <input type="button" id="btn_update_ean" name="btn_update_ean" value="Update & Next" class="btn btn-default" style="width: 100%;"/>
                                    </form>
                                </center>
                            </div>
                        </div>
                    </div>        
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">

        function getPrimarySize() {
            var style_type = document.getElementById("style_type").value;
            document.getElementById("uk_prim_size").options.length = 1;
            document.getElementById("ce_prim_size").options.length = 1;
            if (style_type === "uk") {
                $('input[name^=uk_siz]').attr("readOnly", false);
                $('input[name^=ce_siz]').attr("readOnly", true);
            }
            if (style_type === "ce") {
                $('input[name^=uk_siz]').attr("readOnly", true);
                $('input[name^=ce_siz]').attr("readOnly", false);
            }
            var xmlHttp1 = getAjaxObject();

            xmlHttp1.onreadystatechange = function ()
            {
                if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)
                {
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
                        option1.id = allSize[0] + " --- " + allSize[1];

                        var option2 = document.createElement("option");
                        option2.innerHTML = allSize[1] + " --- " + allSize[0];
                        option2.value = allSize[1] + " --- " + allSize[0];
                        option2.id = allSize[1] + " --- " + allSize[0];

                        datalistCE.appendChild(option2);
                        datalistUK.appendChild(option1);
                    }

                }
            };
            xmlHttp1.open("POST", "Controller?method=getAllPrimarySize", true);
            xmlHttp1.send();
        }

        function readEanTable() {

            var table = document.getElementById('eanTable').getElementsByTagName('tbody')[0];

            var eanDetails = [];

            for (var x = 0; x < table.rows.length; x++) {

                var eanDetail = {};
                var rw = table.rows[x];
                var eanDetailNo = rw.cells[0].innerHTML;
                var uk_primary_size = rw.cells[1].children[0].value;
                var ce_primary_size = rw.cells[2].children[0].value;

                eanDetail["eanDetailNo"] = eanDetailNo;
                eanDetail["uk_primary_size"] = uk_primary_size;
                eanDetail["ce_primary_size"] = ce_primary_size;
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
                    if (data1 == 1) {
                        BootstrapDialog.show({
                            title: 'Notification',
                            message: 'Success',
                            size: BootstrapDialog.SIZE_SMALL,
                            closable: true,
                            closeByBackdrop: false,
                            closeByKeyboard: false,
                            buttons: [{
                                    label: 'Next',
                                    action: function (dialogRef) {
                                        dialogRef.close();
                                        $("#next").submit();
                                    }
                                }]
                        });

                    } else {
                        BootstrapDialog.show({
                            title: 'Notification',
                            message: 'Fail',
                            size: BootstrapDialog.SIZE_SMALL,
                            title:BootstrapDialog.TYPE_WARNING
                        });
                    }
                }
            };
            xmlHttp1.open("POST", "Controller?method=addEanDetails&dataList=" + data, true);
            xmlHttp1.send();
        }

    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#btn_update_ean').click(function (e) {
                var isValid = true;
                $('input[name^=uk_siz]').each(function () {
                    if ($.trim($(this).val()) == '') {
                        isValid = false;
                        $(this).css({
                            "border": "1px solid red"
//                        "background": "#FFCECE"
                        });
                    }
                    else {
                        $(this).css({
                            "border": ""
//                        "background": ""
                        });
                    }
                });
                if (isValid == false) {
                    e.preventDefault();
                }
                else {
                    readEanTable();
                }
            });
        });
        var tmp = {};
        var tmpce = {};
        var tmp2 = {};
        var tmp2uk = {};

        $(document).ready(function () {
            $("input[name^=uk_siz]").bind('input', function () {

                var uk_id = this.id;
                var ce_id = "ce_siz" + uk_id.substr(6);
                var count = uk_id.substr(6);
                var temp = document.getElementById(uk_id).value;
                if (temp.length > 0) {
                    var sizes = temp.split("---");
                    if (typeof (sizes[1]) !== 'undefined') {
                        document.getElementById(uk_id).value = sizes[0];
                        document.getElementById(ce_id).value = sizes[1];
                        tmpce[this.id] = sizes[0];
//                        $('html').keyup(function(e){if(e.keyCode == 8)document.getElementById(ce_id).value = ""});
                        tmp[this.id] = temp;
                    }
                    $("#uk_prim_size option[value='" + temp + "']").attr('disabled', 'disabled');

                } else {
                    document.getElementById(ce_id).value = "";
                    $("#uk_prim_size option[id='" + tmp[this.id] + "']").removeAttr('disabled');
                }
                
                if (document.getElementById(uk_id).value != tmpce[this.id]) {
                    val_update[count] = 0;
                    $("#btn_update_ean").attr('disabled', 'disabled');
                } else {
                    val_update[count] = 1;
                    $("#btn_update_ean").removeAttr('disabled');
                }

                for (i = 0; i < val_update.length; i++) {
                    if(val_update[i] < 1){
                        $("#btn_update_ean").attr('disabled', 'disabled');
                        return;
                    }else{
                        $("#btn_update_ean").removeAttr('disabled');
                    }
                }


            });

            $("input[name^=ce_siz]").bind('input', function () {
                var ce_id = this.id;
                var uk_id = "uk_siz" + ce_id.substr(6);
                var count = uk_id.substr(6);
                var temp = document.getElementById(ce_id).value;
                if (temp.length > 0) {
                    var sizes = temp.split("---");
                    if (typeof (sizes[1]) !== 'undefined') {
                        document.getElementById(uk_id).value = sizes[1];
                        document.getElementById(ce_id).value = sizes[0];
                        tmp2uk[this.id] = sizes[0];
                        tmp2[this.id] = temp;
                    }
                    $("#ce_prim_size option[value='" + temp + "']").attr('disabled', 'disabled');
                } else {
                    document.getElementById(uk_id).value = "";
                    $("#ce_prim_size option[id='" + tmp2[this.id] + "']").removeAttr('disabled');
                }

                if (document.getElementById(ce_id).value != tmp2uk[this.id]) {
                    val_update[count] = 0;
                    $("#btn_update_ean").attr('disabled', 'disabled');
                } else {
                    val_update[count] = 1;
                    $("#btn_update_ean").removeAttr('disabled');
                }
                for (i = 0; i < val_update.length; i++) {
                    if(val_update[i] < 1){
                        $("#btn_update_ean").attr('disabled', 'disabled');
                        return;
                    }else{
                        $("#btn_update_ean").removeAttr('disabled');
                    }
                }
                
            });
        });


        $(document).ready(function () {
            $('input[name^=uk_siz]').attr("readOnly", true);
            $('input[name^=ce_siz]').attr("readOnly", true);
            $("#menuItem1").removeClass("active");
            $("#menuItem2").removeClass("active");
            $("#menuItem3").removeClass("active");
            $("#menuItem4").removeClass("active");
            $("#menuItem5").removeClass("active");
            $("#menuItem6").removeClass("active");
            $("#menuItem7").removeClass("active");
            $("#menuItem3").addClass("active");
        });
    </script>



</div>






<%@include file="include/footer.jsp"%>

<% } else {
        response.sendRedirect("LogoutController");
    }%>