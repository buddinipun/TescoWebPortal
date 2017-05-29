<%-- 
    Document   : pdfExtracter
    Created on : Jul 5, 2015, 8:08:57 PM
    Author     : oshan
--%>


<%@include file="../include/headerInner.jsp"%>

<%@include file="../include/sideMenuInner.jsp"%>

<%    SysUser user = (SysUser) session.getAttribute("user");
    if (user != null) {


%>

<sql:query var="idQ2"  dataSource="jdbc/sdb">
    SELECT * FROM sys_user_menu_item WHERE username='<%=user.getUsername()%>'; 
</sql:query>

<c:set var="condition" value="false"/>
<c:forEach items="${idQ2.rows}" var="row2">
    <c:choose>
        <c:when test="${row2.menu_item==2}">
            <c:set var="condition" value="true"/>
        </c:when>
    </c:choose>
</c:forEach>

<c:choose>
    <c:when test="${condition==false}">
        <script type="text/javascript">
            window.location = '../forbiddenPage.jsp';
        </script>
    </c:when>
</c:choose>

<div id="page-wrapper">

    <div class="container-fluid">
        <div class="row" style="margin: 75px;">
            <div class="col-lg-8 col-md-8 col-lg-offset-2 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Place the Order</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row" style="padding: 20px;">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#po" data-toggle="tab">Automated Data Extractor</a></li>
                                <li><a href="#manual" data-toggle="tab">Manual Entry</a></li>
                                <!--<li><a href="#lof" data-toggle="tab">LOF Extractor</a></li>-->
                            </ul>
                            <div class="tab-content" id="tabs">
                                <div class="tab-pane active" id="po">
                                    <div class="col-lg-10 col-lg-offset-1">
                                        <div class="row">
                                            <br/>
                                            <div class="form-group">
                                                <label class="control-label col-sm-4" for="cmbDocType" style="padding-top: 5px;">Document Type:</label>
                                                <div class="col-sm-8">
                                                    <select name="cmbDocType" id="cmbDocType" class="form-control">
                                                        <option selected disabled> - Select Type - </option>
                                                        <option value="po">Buyer PO</option>
                                                        <option value="orms">ORMS</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <br/>
                                            <p class="lead" id="po_type" ></p>
                                        </div>
                                        <div class="row" id="type_po">
                                            <form id="po_form" role="form" action="/IEPTescoNew/PDFExtracter" enctype="multipart/form-data" method="POST" onsubmit="return checkPDF();">
                                                <div class="form-group">
                                                    <input class="form-control" type="file" size=20 name="fpdf" id="fpdf">
                                                    <!--                                                    <input class="form-control" type="text" size=20 name="actionType" id="actionType" value="insert">-->
                                                </div>
                                                <div class="form-group" style="padding-left: 25%; padding-right: 25%;">
                                                    <input class="form-control btn btn-primary" type="submit" value="Upload File"/>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="row" id="type_orms">
                                            <form id="po_form" role="form" action="/IEPTescoNew/ORMSExtracter" enctype="multipart/form-data" method="POST" onsubmit="return checkPDForms()();">
                                                <div class="form-group">
                                                    <input class="form-control" type="file" size=20 name="fpdf2" id="fpdf2">
                                                </div>
                                                <div class="form-group" style="padding-left: 25%; padding-right: 25%;">
                                                    <input class="form-control btn btn-primary" type="submit" value="Upload File"/>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="manual">
                                    <br/>
                                    <p class="lead">Click Next To Manual Entry</p>
                                    <br/>
                                    <form id="manual_form" role="form" action="../placeOrder.jsp" method="POST">
                                        <div class="form-group" style="padding-left: 25%; padding-right: 25%;">
                                            <input class="form-control btn btn-primary" type="submit" value="Next"/>
                                        </div>
                                    </form>
                                </div>
                                <div class="tab-pane" id="lof">
                                    <br/>
                                    <p class="lead">Some Description - LOF</p>
                                    <br/>
                                    <form id="lof_form" role="form" action="../UploadServlet" method="post"
                                          enctype="multipart/form-data" onsubmit="return Check();">
                                        <div class="form-group">
                                            <input class="form-control" type="file" name="fileu" id="fileu" size="50" />
                                        </div>
                                        <div class="form-group" style="padding-left: 25%; padding-right: 25%;">
                                            <input class="form-control btn btn-primary" type="submit" value="Upload File" width="50%"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>                                
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->

</div>
<!-- /#page-wrapper -->

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
    function Check() {
        var fileElement = document.getElementById("fileu");
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension == "docx") {
            return true;
        }
        else if (fileExtension == "doc") {
            BootstrapDialog.show({
                title: "Error",
                message: "You must select a .docx file \n You have to save this .doc file as .docx .",
                type: BootstrapDialog.TYPE_DANGER,
                closable: false,
                size: BootstrapDialog.SIZE_SMALL,
                buttons: [{
                        label: 'Close',
                        action: function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
            });
            //  alert("You must select a .docx file \n You have to save this .doc file as .docx");
            return false;
        } else if (fileExtension == "") {
            BootstrapDialog.show({
                title: "Error",
                message: "Please select file before upload.",
                type: BootstrapDialog.TYPE_DANGER,
                closable: false,
                size: BootstrapDialog.SIZE_SMALL,
                buttons: [{
                        label: 'Close',
                        action: function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
            });
            //  alert("Please select file before upload");
            return false;
        } else {
            BootstrapDialog.show({
                title: "Error",
                message: "You must select a .docx file for upload.",
                type: BootstrapDialog.TYPE_DANGER,
                closable: false,
                size: BootstrapDialog.SIZE_SMALL,
                buttons: [{
                        label: 'Close',
                        action: function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
            });
            //  alert("You must select a .docx file for upload");
            return false;
        }
        return false;
    }
</script>
<script type="text/javascript">
    function checkPDF() {
        var fileElement = document.getElementById("fpdf");
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension == "pdf" || fileExtension == "PDF") {
            return true;
        } else if (fileExtension == "") {
            BootstrapDialog.show({
                title: "Error",
                message: "Please select file before upload.",
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                closable: false,
                buttons: [{
                        label: 'Close',
                        action: function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
            });
            //  alert("Please select file before upload");
            return false;
        } else {
            BootstrapDialog.show({
                title: "Error",
                message: "You must select a .pdf file for upload.",
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                closable: false,
                buttons: [{
                        label: 'Close',
                        action: function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
            });
            //  alert("You must select a .docx file for upload");
            return false;
        }
        return false;
    }
    function checkPDForms() {
        var fileElement = document.getElementById("fpdf2");
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension == "pdf" || fileExtension == "PDF") {
            return true;
        } else if (fileExtension == "") {
            BootstrapDialog.show({
                title: "Error",
                message: "Please select file before upload.",
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                closable: false,
                buttons: [{
                        label: 'Close',
                        action: function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
            });
            //  alert("Please select file before upload");
            return false;
        } else {
            BootstrapDialog.show({
                title: "Error",
                message: "You must select a .pdf file for upload.",
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                closable: false,
                buttons: [{
                        label: 'Close',
                        action: function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
            });
            //  alert("You must select a .docx file for upload");
            return false;
        }
        return false;
    }
</script>

<script>
    function activaTab(tab) {
        $('.nav-tabs a[href="#' + tab + '"]').tab('show');
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
    });
</script>

<%@include file="../include/footerInner.jsp"%>
<% } else {

        response.sendRedirect("../LogoutController");
    }%>