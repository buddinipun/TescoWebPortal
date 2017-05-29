
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%-- 
    Document   : artWorkUpload
    Created on : Aug 6, 2015, 8:57:34 AM
    Author     : User
--%>

<%@page import="com.impression.hibe.model.SysUser"%>
<%@include file="include/header.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    SysUser user6 = (SysUser) session.getAttribute("user");
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date date = new Date();
    String curDate = dateFormat.format(date);

    if (user6 != null) {

%>

<style type="text/css">
    tr.highlighted td{
        background:  #D8D8D8;
    }

</style>

<%@include file="include/sideMenu.jsp"%>

<div id="page-wrapper">

    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row">
            <div class="col-lg-6" style="padding-top: 1%">
                <div class="panel panel-info" style="height: 300px;">
                    <div class="panel-heading">
                        <h3 class="panel-title">Artwork Upload</h3>
                    </div>
                    <div class="panel-body" style="padding-top:50px;">
                        <form action="UploadArtworkController" method="post" enctype="multipart/form-data" class="form-horizontal" onsubmit="return checkImage()">
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="email">LOF No : </label>
                                <div class="col-sm-10">
                                    <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                        SELECT * FROM `imp_tesco`.`lof_generaldata` where conf_order IN ('AR','NARCONA','ARCONA') ORDER BY ordered_date DESC;
                                    </sql:query>
                                    <select  name="userEmail" id="id" class="form-control">

                                        <option disabled selected value="0" > - Select a LOF - </option>

                                        <c:forEach var="row9" items="${idQ9.rows}"> 
                                            <option value="${row9.lof_data}">${row9.lof_data}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="fileImage">File : </label>
                                <div class="col-sm-10"> 
                                    <input type="file" name="fileImage" id="fileImage" size="50" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group"> 
                                <div class="col-sm-offset-3 col-sm-9">
                                    <input class="btn btn-primary pull-right" type="submit" name="btn_submit" id="btn_submit"/>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-lg-6" style="padding-top: 1%">
                <div class="panel panel-info" style="height: 300px;">
                    <div class="panel-heading" style="padding: 0px;">
                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                            <div class="btn-group" role="group">
                                <input name="downList" id="btn_to" type="button" class="btn btn-info" onclick="downToday();" value="Today" />
                            </div>
                            <div class="btn-group" role="group">
                                <input name="downList" id="btn_pre" type="button" class="btn btn-info" onclick="downPreday();" value="Previous" />
                            </div>
                        </div>
                    </div>
                    <div class="panel-body" style="height: 260px; overflow-y: auto;" id='today'>                        
                        <table class="table table-striped">
                            <tbody>
                                <sql:query var="idQToday"  dataSource="jdbc/sdb">
                                    SELECT lg.lof_data FROM lof_generaldata lg WHERE lof_data NOT IN (SELECT a.lof_data FROM artwork_download_user a) AND conf_order IN('ARS','AR','NAR') AND `art_request_date` LIKE '<%=curDate%>%' ORDER BY lg.ordered_date DESC;
                                </sql:query>
                                <c:forEach var="rowToday" items="${idQToday.rows}">
                                    <tr>
                                        <td width="40%">
                                            ${rowToday.lof_data}
                                        </td>
                                        <td width="20%">
                                            ${rowToday.art_request_date}
                                        </td>
                                        <td>
                                            <a href="DownloadLOF?action_type=saveuser&lof_no=${rowToday.lof_data}">Download Link</a>
                                                                                    <!--<input type="button" name="downfile" id="${rowToday.lof_data}" value="Download" class="btn btn-info pull-right"/>-->
                                        </td>
                                    </tr>
                                </c:forEach> 
                            </tbody>
                        </table>
                    </div>
                    <div class="panel-body" style="height: 260px; overflow-y: auto;" id="preday">                        
                        <table class="table table-striped">
                            <tbody>
                                <sql:query var="idQBeday"  dataSource="jdbc/sdb">                                    
                                    SELECT lg.lof_data FROM lof_generaldata lg WHERE lof_data NOT IN (SELECT a.lof_data FROM artwork_download_user a)AND conf_order IN('ARS','AR','NAR') AND `art_request_date` < '<%=curDate%>%' ORDER BY lg.ordered_date DESC;
                                </sql:query>
                                <c:forEach var="rowBeday" items="${idQBeday.rows}">
                                    <tr>
                                        <td width="40%">
                                            ${rowBeday.lof_data}
                                        </td>
                                        <td width="60%">
                                            ${rowBeday.art_request_date}
                                        </td>
                                        <td>
                                            <a href="DownloadLOF?action_type=saveuser&lof_no=${rowBeday.lof_data}">Download Link</a>
                                            <!--<input type="button" name="downfile" id="${rowBeday.lof_data}" value="Download" class="btn btn-info pull-right"/>-->
                                        </td>
                                    </tr>
                                </c:forEach> 
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-10 col-lg-10 col-lg-offset-1 col-md-offset-1">
                <center>
                    <a id="imgURL" target="_blank" ><img id="artView" name="artView" class="img-responsive" /></a>
                </center>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12" style="padding-top: 2%">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Lof Filter By DATE</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="email">From Date</label>
                            <div class="col-sm-3">
                                <input type="date" name="date1" class="form-control" id="date1" value="" />   
                            </div>
                            <label class="control-label col-sm-2" for="email">To Date</label>
                            <div class="col-sm-3">
                                <input type="date" name="date2" class="form-control" id="date2" value="" />   
                            </div>

                            <div class="col-sm-2">
                                <input type="button" name="CheckByDate" id="CheckByDate" value="Check By Date" class="btn btn-primary" onclick="viewByDate();"/>
                            </div>

                        </div>
                        <br/>


                    </div>

                    <table border="0" id="viewLofTble" class="table table-responsive table-hover">
                        <thead>
                            <tr>
                                <th width="25%" style="text-align: center">Lof No</th>
                                <th width="25%" style="text-align: center">Status</th>
                                <th width="25%" style="text-align: center">Lof File</th>
                                <th width="25%" style="text-align: center">Pdf File</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table> 

                </div>
            </div>

        </div>
        <!-- /.row -->
    </div>
    <!-- /.container-fluid -->
    <div id="Searching_Modal" class="modal fade" tabindex="-1" role="dialog" data-keyboard="false"
         data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="text-align: center">
                    <h3>Loading Image...</h3>
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
<!-- /#page-wrapper -->

<!--<script type="text/javascript">

    $("#fileImage").change(function () {
        readURL(this);
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#artView').attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function uploadImage() {
        $('#uploadSymbol').submit();
    }

</script>-->

<script type="text/javascript">
    function checkImage() {
        var fileElement = document.getElementById("fileImage");
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension == "png" || fileExtension == "PNG") {
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
            return false;
        } else {
            BootstrapDialog.show({
                title: "Error",
                message: "You must select a .png file for upload.",
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
            return false;
        }
        return false;
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
    function viewByDate() {
        var date1 = document.getElementById("date1").value;
        var date2 = document.getElementById("date2").value;

        var tblTechFiber = document.getElementById('viewLofTble').getElementsByTagName('tbody')[0];


        if (date1 === "" || date2 === "") {
        } else {

            var new2Date = date1 + "_" + date2;
            var xmlHttp = getAjaxObject();
            xmlHttp.onreadystatechange = function ()
            {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                {
                    var reply = eval('(' + xmlHttp.responseText + ')');
                    console.log(reply);
                    console.log(reply.id[2].newid);


                    $("#viewLofTble").show()

                    for (var a = 0; a < reply.id.length; a++) {
                        var row = document.createElement("tr");

                        var id = document.createElement("td");
                        id.innerHTML = reply.id[a].newid;
                        id.style["text-align"] = "center";

//                            var status = document.createElement("td");
//                            status.innerHTML = reply.id[a].status;

                        var lofid = document.createElement("td");
                        lofid.innerHTML = reply.id[a].lofid;
                        lofid.style["text-align"] = "center";


                        var downloadLOFColom = document.createElement("td");
                        downloadLOFColom.style["text-align"] = "center";
                        var x = document.createElement("A");
                        x.className = "btn btn-info";
                        var t = document.createTextNode("Download Lof");
                        x.setAttribute("href", "LOF/" + reply.id[a].lofid + "_LOF" + ".docx");
                        x.appendChild(t);
                        downloadLOFColom.appendChild(x);

                        var downloadPDFColom = document.createElement("td");
                        downloadPDFColom.style["text-align"] = "center";
                        var x1 = document.createElement("A");
                        x1.className = "btn btn-info";
                        var t1 = document.createTextNode("Download Pdf");
                        x1.setAttribute("href", "PDF/" + reply.id[a].newid + ".pdf");
                        x1.appendChild(t1);
                        downloadPDFColom.appendChild(x1);

                        var col2 = document.createElement("td");
                        col2.style["text-align"] = "center";

                        if (reply !== null) {
                            var status = reply.id[a].status;
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
                            } else if (status === "ASNC") {
                                status = "";
                                col2.innerHTML = status;
                                col2.style.color = "#993333";
                            } else {
                                status = "Artwork is Received";
                                col2.innerHTML = status;
                                col2.style.color = "#218221";
                            }
                        }

                        row.appendChild(lofid);
                        row.appendChild(col2);
                        row.appendChild(downloadLOFColom);
                        row.appendChild(downloadPDFColom);
                        tblTechFiber.appendChild(row);


                    }
                }
            }
            ;
            xmlHttp.open("POST", "RequestAwController?actionType=GetByDate&new2Date=" + new2Date, true);
            xmlHttp.send();
        }
    }

    $(document).ready(function () {
        $("#viewLofTble").hide();
        $("#preday").hide();

        $("#menuItem1").removeClass("active");
        $("#menuItem2").removeClass("active");
        $("#menuItem3").removeClass("active");
        $("#menuItem4").removeClass("active");
        $("#menuItem5").removeClass("active");
        $("#menuItem6").removeClass("active");
        $("#menuItem7").removeClass("active");
        $("#menuItem1").addClass("active");


    });


    function downToday() {
        document.getElementById("btn_to").disabled = true;
        document.getElementById("btn_pre").disabled = false;
        $("#today").show();
        $("#preday").hide();
    }

    function downPreday() {
        document.getElementById("btn_to").disabled = false;
        document.getElementById("btn_pre").disabled = true;
        $("#today").hide();
        $("#preday").show();
    }

//    $(document).ready(function () {
//    $('input[name=downfile]').on("click", function () {
//    alert(this.id);
//            var lof_no = this.id;
//            var xmlHttp = getAjaxObject();
//            xmlHttp.onreadystatechange = function ()
//            {
//            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
//            {
//            var reply = eval('(' + xmlHttp.responseText + ')');
//                    if (reply == "1") {
//
//            BootstrapDialog.show({
//            message: 'Hi Apple!',
//                    closable: false,
//                    buttons: [{
//                    label: 'Dialog CLOSABLE!',
//                            cssClass: 'btn-success',
//                            action: function (dialogRef) {
//                            dialogRef.setClosable(true);
//                            }
//                    }, {
//                    label: 'Dialog UNCLOSABLE!',
//                            cssClass: 'btn-warning',
//                            action: function (dialogRef) {
//                            dialogRef.setClosable(false);
//                            }
//                    }, {
//                    label: 'Close the dialog',
//                            action: function (dialogRef) {
//                            dialogRef.close();
//                            }
//                    }]
//            });
//            } else if (reply == "0") {
//            sm_alert("File Downloading is failed.");
//            }
//
//            }
//            };
//            xmlHttp.open("POST", "RequestAwController?actionType=downloadLOF&lof_no=" + lof_no, true);
//            xmlHttp.send();
//    });
//    });

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
    function checkPDF() {
        //var card = document.getElementById("id");
//        if (card.selectedIndex == 0) {
//            alert('select one answer');
//        }
//        else {
//            var selectedText = card.options[card.selectedIndex].text;
//            alert(selectedText);
//        }

        if ($("#id").val() === "") {
            BootstrapDialog.show({
                title: "Error",
                message: "Select a LOF First",
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

            // alert('select one answer');
            return false;
        } else {

            var fileElement = document.getElementById("fileImage");
            var fileExtension = "";
            if (fileElement.value.lastIndexOf(".") > 0) {
                fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
            }
            if (fileExtension == "pdf" || fileExtension == "PDF") {
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
    }

</script>

<%@include file="include/footer.jsp"%>
<% } else {
        response.sendRedirect("LogoutController");
    }%>