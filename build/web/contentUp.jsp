<%-- 
    Document   : contentUploader
    Created on : Aug 27, 2015, 2:43:30 PM
    Author     : User
--%>


<%@include file="include/header.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    SysUser user6 = (SysUser) session.getAttribute("user");
    if (user6 != null) {
%>
<%@include file="include/sideMenu.jsp"%>

<div id="page-wrapper" >

    <div class="container-fluid">
        <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
            <div class="row" style="margin-bottom: 50px;">
                <nav class="navbar navbar-inverse">
                    <div class="container-fluid">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>

                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li id="l001" onclick="loadPanels('l001');"><a href="#">Label References</a></li>
                                <li id="l002" onclick="loadPanels('l002');"><a href="#">Label Groups</a></li>
                                <li id="l003" onclick="loadPanels('l003');"><a href="#">Fiber & Mainwords</a></li>
                                <li id="l004" onclick="loadPanels('l004');"><a href="#">Care Information</a></li>
                                <li id="l005" onclick="loadPanels('l005');"><a href="#">Wash Symbols</a></li>
                                <li id="l006" onclick="loadPanels('l006');"><a href="#">Size Chart</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
            <div class="row" id="lblRef">
                <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                    <div class="panel panel-default">
                        <div class="panel-heading"><strong>Label References</strong></div>
                        <div class="panel-body">
                            <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                                <form class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="cmbLblTypeRef">Label Type:</label>
                                        <div class="col-sm-9">
                                            <select name="cmbLblTypeRef" id="cmbLblTypeRef" class="form-control">
                                                <option selected disabled> - Select One - </option>
                                                <option value="TL">Technical Label</option>
                                                <option value="ST-F">Swing Ticket - Front</option>
                                                <option value="ST-B">Swing Ticket - Back</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="txt_reference">Reference:</label>
                                        <div class="col-sm-9"> 
                                            <input type="text" class="form-control" id="txt_reference" autocomplete="false" placeholder="Ex:- FF/13/M7116G" />
                                        </div>
                                    </div>
                                    <div class="form-group"> 
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <input type="button" class="btn btn-info pull-right" value="Submit" onclick="addLabelReferences();"/>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="panel-footer"  style="height: 260px; overflow-y: auto;">
                            <table class="table table-hover" id="ref_table"  style="height: 260px; overflow-y: auto;">
                                <thead>
                                    <tr>
                                        <th>Reference Type</th>
                                        <th>Reference </th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" id="lblGrp">
                <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                    <div class="panel panel-default">
                        <div class="panel-heading"><strong>Label Group</strong></div>
                        <div class="panel-body">
                            <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                                <form class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="cmbLblTypeGrp">Label Type:</label>
                                        <div class="col-sm-9">
                                            <select name="cmbLblTypeGrp" id="cmbLblTypeGrp" class="form-control">
                                                <option selected disabled> - Select One - </option>
                                                <option value="TL">Technical Label</option>
                                                <option value="ST">Swing Ticket</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="txt_grp">Group:</label>
                                        <div class="col-sm-9"> 
                                            <input type="text" class="form-control" id="txt_grp" autocomplete="false" placeholder="Ex:- Small" />
                                        </div>
                                    </div>
                                    <div class="form-group"> 
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <input type="button" class="btn btn-info pull-right" value="Submit" onclick="addLabelGroup();"/>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="panel-footer"  style="height: 260px; overflow-y: auto;">
                            <table class="table table-hover" id="grp_table"  style="height: 260px; overflow-y: auto;">
                                <thead>
                                    <tr>
                                        <th>Label Type</th> 
                                        <th>Group</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" id="lblFbMain">
                <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                    <div class="panel panel-default">
                        <div class="panel-heading"><strong>Fiber &amp; Mainwords</strong></div>
                        <div class="panel-body">
                            <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                                <form class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="cmbcontentType">Content Type:</label>
                                        <input type="hidden" value="" id="fiber_id" />
                                        <div class="col-sm-9">
                                            <select name="cmbcontentType" id="cmbcontentType" class="form-control">
                                                <option selected disabled> - Select One - </option>
                                                <option value="none">None</option>
                                                <option value="FIBER">Fiber</option>
                                                <option value="MAINWORD">Mainword</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="txt_fmvalue">Name:</label>
                                        <div class="col-sm-9"> 
                                            <input type="text" class="form-control" id="txt_fmvalue" autocomplete="false" placeholder="Ex:- Cotten" />
                                        </div>
                                    </div>
                                    <div class="form-group"> 
                                        <div class="col-lg-8">
                                            <input type="button" class="btn btn-info pull-right" value="Submit" id="sbmit" onclick="addFiberMain();"/>
                                        </div>
                                        <div class="col-lg-4">
                                            <input type="button" onclick="updatemain();" name="Update" class="form-control btn btn-warning" id="Update" value="Update"/>
                                        </div>
                                    </div>

                                </form>
                            </div>
                        </div>
                        <div class="panel-footer"  style="height: 260px; overflow-y: auto;">
                            <table class="table table-hover" id="fiberMain_table"  style="height: 260px; overflow-y: auto;">
                                <thead>
                                    <tr>
                                        <th>Content Type</th> 
                                        <th>Name</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" id="careInfo">
                <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                    <div class="panel panel-default">
                        <div class="panel-heading"><strong>Care Information</strong></div>
                        <div class="panel-body">
                            <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                                <form class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="cmbcareType">Type:</label>
                                        <div class="col-sm-9">
                                            <select name="cmbcareType" id="cmbcareType" class="form-control">
                                                <option selected disabled> - Select One - </option>
                                                <option value="FW">Fire Warning (FW)</option>
                                                <option value="CT">Care Text (CT)</option>
                                                <option value="PS">Part of Set (PS)</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="txt_careText">Care Text:</label>
                                        <div class="col-sm-9"> 
                                            <input type="text" class="form-control" id="txt_careText" autocomplete="false" placeholder="Ex:- WARNING: KEEP AWAY FROM FIRE">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="txt_careCode">Care Code:</label>
                                        <div class="col-sm-9"> 
                                            <input type="text" class="form-control" id="txt_careCode"  onkeypress="return event.charCode >= 48 && event.charCode <= 57" autocomplete="false">
                                        </div>
                                    </div>
                                    <div class="form-group"> 
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <input type="button" class="btn btn-info pull-right" value="Submit" onclick="addCareText();"/>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="panel-footer"  style="height: 260px; overflow-y: auto;">
                            <table class="table table-hover" id="careText_table"  style="height: 260px; overflow-y: auto;">
                                <thead>
                                    <tr>
                                        <th>Type</th> 
                                        <th>Care Text</th>
                                        <th>Care Code</th> 
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" id="washSym">
                <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                    <div class="panel panel-default">
                        <div class="panel-heading"><strong>Wash Symbol</strong></div>
                        <div class="panel-body">
                            <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                                <form action="ContentUpdateController" method="post" enctype="multipart/form-data" runat="server" class="form-horizontal" onsubmit=" return onsubmit1();">
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="txt_symbol">Symbol Code:</label>
                                        <div class="col-sm-9"> 
                                            <select class="form-control" id="sym_key" name="sym_key">
                                                <option selected disabled> - Symbol Type - </option>
                                                <option value="W">Wash</option>
                                                <option value="B">Bleach</option>
                                                <option value="D">Dry</option>
                                                <option value="I">Iron</option>
                                                <option value="C">Dry Clean</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="symbol_detils">Details:</label>
                                        <div class="col-sm-9"> 
                                            <input type="text" class="form-control" id="symbol_detils" name="symbol_detils" autocomplete="false">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="file_sym">Upload Image:</label>
                                        <div class="col-sm-9"> 
                                            <input type="file" class="form-control" name="file_sym" id="file_sym">
                                        </div>
                                    </div>
                                    <div class="form-group"> 
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <center>
                                                <img id="symView" name="symView" class="img-responsive" />
                                            </center>
                                        </div>
                                    </div>
                                    <div class="form-group"> 
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <input class="btn btn-info  pull-right" type="submit" name="btn_submit" id="btn_submit"/>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="panel-footer"  style="height: 260px; overflow-y: auto;">
                            <table class="table table-hover" id="washSim_table"  style="height: 260px; overflow-y: auto;">
                                <thead>
                                    <tr>
                                        <th>Symbol Code</th> 
                                        <th>Details</th>
                                        <th>Image</th> 
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" id="sizeChart">
                <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                    <div class="panel panel-default">
                        <div class="panel-heading"><strong>Size Chart</strong></div>
                        <div class="panel-body">
                            <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                                <form class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="file_size">Upload File:</label>
                                        <div class="col-sm-9"> 
                                            <input type="file" class="form-control" id="file_size">
                                        </div>
                                    </div>
                                    <div class="form-group"> 
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-info pull-right">Upload</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <table class="table">
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </div>
    <!-- /#page-wrapper -->
    <div id="Searching_Modal" class="modal fade" tabindex="-1" role="dialog" data-keyboard="false"
         data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="text-align: center">
                    <h3>Uploading File, Please Wait.....</h3>
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
</div>

<script>

    function addLabelReferences() {
        var txt_reference = document.getElementById("txt_reference").value;
        var reference_type_ref1 = document.getElementById("cmbLblTypeRef").selectedIndex;
        var reference_type_ref = document.getElementById("cmbLblTypeRef").value;
        if (reference_type_ref1 === 0) {


            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Select Lable Type'
            });

        } else if (txt_reference.length === 0) {
            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Enter Reference'
            });


        } else {
            var data = txt_reference + "@" + reference_type_ref;
            var xmlHttp = getAjaxObject();
            xmlHttp.onreadystatechange = function ()
            {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                {
                    var reply = eval('(' + xmlHttp.responseText + ')');
                    if (reply.message === 1) {
                        document.getElementById("txt_reference").value = "";
                        document.getElementById("cmbLblTypeRef").selectedIndex = 0;
                        sm_notify("Success");
                        getReferences();
                    } else {
                        sm_alert("Failed");
                    }
                }
            };
            xmlHttp.open("POST", "ContentUpController?actionType=addLabelReferences&data=" + data, true);
            xmlHttp.send();

        }

    }
    function onsubmit1() {
        var txt_reference = document.getElementById("symbol_detils").value;
        var reference_type_ref1 = document.getElementById("sym_key").selectedIndex;
//var reference_type_ref = document.getElementById("cmbLblTypeRef").value;
        if (reference_type_ref1 === 0) {


            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Select Symbol Type'
            });
            return false;
        } else if (txt_reference.length === 0) {
            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Enter Details'
            });

            return false;
        } else {

            var fileElement = document.getElementById("file_sym");
            var fileExtension = "";
            if (fileElement.value.lastIndexOf(".") > 0) {
                fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
            }
            if (fileExtension === "png" || fileExtension === "PNG" || fileExtension === "jpg" || fileExtension === "JPG") {
                sm_notify("Success");
                return true;
            } else if (fileExtension === "") {
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
                    message: "You must select a .png or .jpg file for upload.",
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


    }

    function addLabelGroup() {
        var txt_grp = document.getElementById("txt_grp").value;
        var reference_type_grp = document.getElementById("cmbLblTypeGrp").value;
        var reference_type_grp1 = document.getElementById("cmbLblTypeGrp").selectedIndex;
        if (reference_type_grp1 === 0) {


            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Select Lable Type'
            });

        } else if (txt_grp.length === 0) {
            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Enter Group '
            });


        } else {
            var data = txt_grp + "@" + reference_type_grp;

            var xmlHttp = getAjaxObject();
            xmlHttp.onreadystatechange = function ()
            {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                {
                    var reply = eval('(' + xmlHttp.responseText + ')');
                    if (reply.message === 1) {
                        document.getElementById("txt_grp").value = "";
                        document.getElementById("cmbLblTypeGrp").selectedIndex = 0;
                        sm_notify("Success");
                        getLableGroup();
                    } else {
                        sm_alert("Failed");
                    }
                }
            };


        }

        xmlHttp.open("POST", "ContentUpController?actionType=addLabelGroup&data=" + data, true);
        xmlHttp.send();


    }


    function addFiberMain() {
        var txt_fmvalue = document.getElementById("txt_fmvalue").value;
        var cmbcontentType = document.getElementById("cmbcontentType").value;
        var cmbcontentType1 = document.getElementById("cmbcontentType").selectedIndex;
        if (cmbcontentType1 === 0) {


            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Select Content Type'
            });

        } else if (txt_fmvalue.length === 0) {
            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Enter Name '
            });


        } else {
            var data = txt_fmvalue + "@" + cmbcontentType;

            var xmlHttp = getAjaxObject();
            xmlHttp.onreadystatechange = function ()
            {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                {
                    var reply = eval('(' + xmlHttp.responseText + ')');
                    if (reply.message === 1) {
                        document.getElementById("txt_fmvalue").value = "";
                        document.getElementById("cmbcontentType").selectedIndex = 0;
                        sm_notify("Success");
                        getFiberMain();
                    } else {
                        sm_alert("Failed");
                    }
                }
            };

        }

        xmlHttp.open("POST", "ContentUpController?actionType=addFiberMain&data=" + data, true);
        xmlHttp.send();
    }

    function addCareText() {
        var cmbcareType = document.getElementById("cmbcareType").value;
        var txt_careText = document.getElementById("txt_careText").value;
        var txt_careCode = document.getElementById("txt_careCode").value;
        var cmbcareType1 = document.getElementById("cmbcareType").selectedIndex;


        if (cmbcareType1 === 0) {


            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Select Type'
            });

        } else if (txt_careText.length === 0) {
            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Care Text '
            });


        } else if (txt_careCode.length === 0) {
            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Care Code '
            });


        } else {

            var data = cmbcareType + "@" + txt_careText + "@" + txt_careCode;

            var xmlHttp = getAjaxObject();
            xmlHttp.onreadystatechange = function ()
            {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                {
                    var reply = eval('(' + xmlHttp.responseText + ')');
                    if (reply.message === 1) {
                        document.getElementById("cmbcareType").selectedIndex = 0;
                        document.getElementById("txt_careText").value = "";
                        document.getElementById("txt_careCode").value = "";
                        sm_notify("Success");
                        getCareTexts();
                        
                    } else {
                        sm_alert("Failed");
                    }
                }
            };

            xmlHttp.open("POST", "ContentUpController?actionType=addCareText&data=" + data, true);
            xmlHttp.send();

        }


    }


</script>

<script type="text/javascript">



    $("#file_sym").change(function () {
        readURL(this);
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#symView').attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function uploadImage() {
        $('#uploadSymbol').submit();
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
    //Iresh's Updation.. For retrieving the table from the DB
    function getReferences() {
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log(reply);
                var table = document.getElementById('ref_table').getElementsByTagName('tbody')[0];
                if (reply.message) {

                    $("#ref_table tbody").empty();
                    var references = reply.references;
                    //console.log(references.length);
                    for (var i = 0; i < references.length; i++) {
                        var row1 = document.createElement("tr");
                        var rowCol1 = document.createElement("td");
                        var rowCol2 = document.createElement("td");

                        var ref_type = references[i].ref_type;
                        if (ref_type === "TL") {
                            rowCol1.innerHTML = "Technical Label";
                        } else if (ref_type === "ST-B") {
                            rowCol1.innerHTML = "Swing Ticket - Back";
                        } else if (ref_type === "ST-F") {
                            rowCol1.innerHTML = "Swing Ticket - Front";
                        }

                        rowCol2.innerHTML = references[i].refence;

                        row1.appendChild(rowCol1);
                        row1.appendChild(rowCol2);

                        table.appendChild(row1);
                    }
                }
            }
        };
        xmlHttp.open("POST", "ContentUpController?actionType=getLabelReference", true);
        xmlHttp.send();
    }
    function getLableGroup() {
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log("Label Group");
                console.log(reply);
                var table = document.getElementById('grp_table').getElementsByTagName('tbody')[0];
                if (reply.message) {

                    $("#grp_table tbody").empty();
                    var labelGroupp = reply.label_groups;
                    //   alert(labelGroupp.length);
                    for (var i = 0; i < labelGroupp.length; i++) {
                        var row1 = document.createElement("tr");
                        var rowCol1 = document.createElement("td");
                        var rowCol2 = document.createElement("td");

                        var label_type = labelGroupp[i].label_type;

                        rowCol1.innerHTML = labelGroupp[i].label_type;
                        rowCol2.innerHTML = labelGroupp[i].group;

                        row1.appendChild(rowCol1);
                        row1.appendChild(rowCol2);

                        table.appendChild(row1);
                    }
                }
            }
        };
        xmlHttp.open("POST", "ContentUpController?actionType=getLableGroup", true);
        xmlHttp.send();
    }
    function getFiberMain() {
        document.getElementById("sbmit").disabled = false;
        document.getElementById("Update").disabled = true;
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log("Fiber & Mainwords");
                console.log(reply);
                var table = document.getElementById('fiberMain_table').getElementsByTagName('tbody')[0];
                if (reply.message) {

                    $("#fiberMain_table tbody").empty();
                    var fiberMain = reply.content_type;
                    //alert(fiberMain.length);
                    for (var i = 0; i < fiberMain.length; i++) {
                        var row1 = document.createElement("tr");
                        var rowCol1 = document.createElement("td");
                        row1.id =  fiberMain[i].id;
                        
                        var rowCol2 = document.createElement("td");

                        var content_name = fiberMain[i].Name;
                        if (content_name === "" || content_name === null) {
                            rowCol1.innerHTML = "Not Assigned";
                        } else {
                            rowCol1.innerHTML = fiberMain[i].Name;
                        }

                        rowCol2.innerHTML = fiberMain[i].content_type;

                        row1.appendChild(rowCol1);
                        row1.appendChild(rowCol2);

                        table.appendChild(row1);
                    }
                }
            }
        };
        xmlHttp.open("POST", "ContentUpController?actionType=getFiberMain", true);
        xmlHttp.send();
    }
    function getCareTexts() {

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log("Care Text");
                console.log(reply);
                var table = document.getElementById('careText_table').getElementsByTagName('tbody')[0];
                if (reply.message) {

                    $("#careText_table tbody").empty();
                    var cTextsV = reply.cTexts;
                    //  alert(cTextsV.length);
                    for (var i = 0; i < cTextsV.length; i++) {
                        var row1 = document.createElement("tr");
                        var rowCol1 = document.createElement("td");
                        var rowCol2 = document.createElement("td");
                        var rowCol3 = document.createElement("td");

                        var type = cTextsV[i].type;

                        rowCol1.innerHTML = cTextsV[i].type;
                        rowCol2.innerHTML = cTextsV[i].care_text;
                        rowCol3.innerHTML = cTextsV[i].care_code;

                        row1.appendChild(rowCol1);
                        row1.appendChild(rowCol2);
                        row1.appendChild(rowCol3);

                        table.appendChild(row1);
                    }
                }
            }
        };
        xmlHttp.open("POST", "ContentUpController?actionType=getCareTexts", true);
        xmlHttp.send();
    }

//    function addWashSymbol() {
//
//
//        var Symbl_Code = document.getElementById("sym_key").value;
//        var Symle_Code_Index = document.getElementById("sym_key").selectedIndex;
//
//        var Get_Detail = document.getElementById("symbol_detils").value;
//        var Upload_Image = document.getElementById("file_sym").value;
//
//
//        if (Symle_Code_Index === 0) {
//            BootstrapDialog.show({
//                title: 'Alert',
//                type: BootstrapDialog.TYPE_DANGER,
//                size: BootstrapDialog.SIZE_SMALL,
//                message: 'Please Select Care Type'
//            });
//
//        }
//        $("#file_sym").change(function () {
//            readURL(this);
//        });
//
//        function readURL(input) {
//            if (input.files && input.files[0]) {
//                var reader = new FileReader();
//
//                reader.onload = function (e) {
//                    $('#symView').attr('src', e.target.result);
//                };
//                reader.readAsDataURL(input.files[0]);
//            }
//        }
//
//        function uploadImage() {
//            $('#uploadSymbol').submit();
//        }
//
//
//    }


    function getWashSymbols() {

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function () {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log("Wash Simbol");
                console.log(reply);
                var table = document.getElementById('washSim_table').getElementsByTagName('tbody')[0];
                if (reply.message) {
                    $("#washSim_table tbody").empty();
                    var wshSblV = reply.wshSbl;
                    for (var i = 0; i < wshSblV.length; i++) {
                        var row1 = document.createElement("tr");
                        row1.id = wshSblV[i].id;
                        
                        var rowCol1 = document.createElement("td");
                        var rowCol2 = document.createElement("td");
                        var rowCol3 = document.createElement("img");
                        
                        // var symbol_code = wshSblV[i].symbol_code;

                        rowCol1.innerHTML = wshSblV[i].symbol_code;
                        rowCol2.innerHTML = wshSblV[i].details;
                        rowCol3.src = "/IEPTescoNew/img/symbols/" + wshSblV[i].url;

                        row1.appendChild(rowCol1);
                        row1.appendChild(rowCol2);
                        row1.appendChild(rowCol3);
                        table.appendChild(row1);
                    }
                }

            }
        };
        xmlHttp.open("POST", "ContentUpController?actionType=getWashSymbol", true);
        xmlHttp.send();
    }
    $(document).on('click', '#fiberMain_table  tbody tr', function () {
        //alert(this.id);
//        $("#Add").hide();
        //$("#Delete").show();
        // $("#Update").show();
        // $("#clear").show();
        document.getElementById("sbmit").disabled = true;
        document.getElementById("Update").disabled = false;
      document.getElementById("fiber_id").value=this.id;
//          var de=this.id;
//          alert(de);
        var da = [];
        var a = ($(this).find('td:nth-child(1)').text().trim());
        var b = ($(this).find('td:nth-child(2)').text().trim());


        viewGarment(a, b);
    });

//End of the Iresh's Updation.. For retrieving the table from the DB

</script>
<script type="text/javascript">
    function updatemain() {

         updateFiberMain();
//        alert(id);
//        alert(txt_fmvalue);
//        addFiberMain();
//        getFiberMain();
//try {
//    alert("try enterd")
//    String hql = "UPDATE fiber f set f.d_type = :id f.mx= :name"  + 
//             "WHERE f.d_type = :id AND f.mx= :name";
// Query query = session.createQuery(hql);
// query.setParameter("d_type", id);
// query.setParameter("mx", name);
// int result = query.executeUpdate();
// System.out.println("Rows affected: " + result);
//
// }
    }



</script>
<script type="text/javascript">
    function updateFiberMain() {
       
        var txt_fmvalue = document.getElementById("txt_fmvalue").value.trim();
        var cmbcontentType = document.getElementById("cmbcontentType").value.trim();
        var fiber_id = document.getElementById("fiber_id").value.trim();
        var cmbcontentType1 = document.getElementById("cmbcontentType").selectedIndex;
        if (cmbcontentType1 === 0) {


            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Select Content Type'
            });

        } else if (txt_fmvalue.length === 0) {
            BootstrapDialog.show({
                title: 'Alert',
                type: BootstrapDialog.TYPE_DANGER,
                size: BootstrapDialog.SIZE_SMALL,
                message: 'Please Enter Name '
            });


        } else {
            var data = txt_fmvalue + "@" + cmbcontentType + "@" + fiber_id;
    console.log(data);
            var xmlHttp = getAjaxObject();
            xmlHttp.onreadystatechange = function ()
            {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                {
                    var reply = eval('(' + xmlHttp.responseText + ')');
                    if (reply.message === 1) {
                        document.getElementById("txt_fmvalue").value = "";
                        document.getElementById("cmbcontentType").selectedIndex = 0;
                        sm_notify("Success");
                        getFiberMain();
                    } else {
                        sm_alert("Failed");
                    }
                }
            };

        }

        xmlHttp.open("POST", "ContentUpController?actionType=updateFiberMain&data=" + data, true);
        xmlHttp.send();
    }
    function viewGarment(cmbcontentType, txt_fmvalue) {


        if (cmbcontentType === "Not Assigned") {
            document.getElementById('cmbcontentType').selectedIndex = 1;

            document.getElementById('txt_fmvalue').value = txt_fmvalue;


        } else {
            document.getElementById('cmbcontentType').value = cmbcontentType;

            document.getElementById('txt_fmvalue').value = txt_fmvalue;
        }

    }
</script>
<script type="text/javascript">

    function loadPanels(panelNo) {
        var id = panelNo;
        switch (id) {
            case 'l001':
                $('#lblRef').show();
                $('#lblGrp').hide();
                $('#lblFbMain').hide();
                $('#careInfo').hide();
                $('#washSym').hide();
                $('#sizeChart').hide();

                $('#l001').removeClass("active");
                $('#l002').removeClass("active");
                $('#l003').removeClass("active");
                $('#l004').removeClass("active");
                $('#l005').removeClass("active");
                $('#l006').removeClass("active");
                $('#l001').addClass("active");
                break;
            case 'l002':
                $('#lblRef').hide();
                $('#lblGrp').show();
                $('#lblFbMain').hide();
                $('#careInfo').hide();
                $('#washSym').hide();
                $('#sizeChart').hide();

                $('#l001').removeClass("active");
                $('#l002').removeClass("active");
                $('#l003').removeClass("active");
                $('#l004').removeClass("active");
                $('#l005').removeClass("active");
                $('#l006').removeClass("active");
                $('#l002').addClass("active");
                break;
            case 'l003':
                $('#lblRef').hide();
                $('#lblGrp').hide();
                $('#lblFbMain').show();
                $('#careInfo').hide();
                $('#washSym').hide();
                $('#sizeChart').hide();

                $('#l001').removeClass("active");
                $('#l002').removeClass("active");
                $('#l003').removeClass("active");
                $('#l004').removeClass("active");
                $('#l005').removeClass("active");
                $('#l006').removeClass("active");
                $('#l003').addClass("active");
                break;
            case 'l004':
                $('#lblRef').hide();
                $('#lblGrp').hide();
                $('#lblFbMain').hide();
                $('#careInfo').show();
                $('#washSym').hide();
                $('#sizeChart').hide();

                $('#l001').removeClass("active");
                $('#l002').removeClass("active");
                $('#l003').removeClass("active");
                $('#l004').removeClass("active");
                $('#l005').removeClass("active");
                $('#l006').removeClass("active");
                $('#l004').addClass("active");
                break;
            case 'l005':
                $('#lblRef').hide();
                $('#lblGrp').hide();
                $('#lblFbMain').hide();
                $('#careInfo').hide();
                $('#washSym').show();
                $('#sizeChart').hide();

                $('#l001').removeClass("active");
                $('#l002').removeClass("active");
                $('#l003').removeClass("active");
                $('#l004').removeClass("active");
                $('#l005').removeClass("active");
                $('#l006').removeClass("active");
                $('#l005').addClass("active");
                break;
            case 'l006':
                $('#lblRef').hide();
                $('#lblGrp').hide();
                $('#lblFbMain').hide();
                $('#careInfo').hide();
                $('#washSym').hide();
                $('#sizeChart').show();

                $('#l001').removeClass("active");
                $('#l002').removeClass("active");
                $('#l003').removeClass("active");
                $('#l004').removeClass("active");
                $('#l005').removeClass("active");
                $('#l006').removeClass("active");
                $('#l006').addClass("active");
                break;
        }
    }


    $(document).ready(function () {

        getReferences();
        getLableGroup();
        getFiberMain();
        getCareTexts();
        getWashSymbols();

        $('#lblRef').show();
        $('#lblGrp').hide();
        $('#lblFbMain').hide();
        $('#careInfo').hide();
        $('#washSym').hide();
        $('#sizeChart').hide();

        $('#l001').removeClass("active");
        $('#l002').removeClass("active");
        $('#l003').removeClass("active");
        $('#l004').removeClass("active");
        $('#l005').removeClass("active");
        $('#l006').removeClass("active");
        $('#l001').addClass("active");

        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem8").addClass("active");
    });
</script>
<%@include file="include/footer.jsp"%>
<% } else {
        response.sendRedirect("LogoutController");
    }%>