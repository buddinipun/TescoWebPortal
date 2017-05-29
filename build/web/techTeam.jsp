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
                    Technical Team
                </h1>
                <!--                <div class="breadcrumb panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse1"> <i class="fa fa-dashboard"></i> SignUp as a Technical Team Member.</a>
                                    </h4>
                                </div>-->
                <!--                <ol class="">
                                    <li class="active">
                                        <i class="fa fa-dashboard"></i> SignUp as a Technical Team Member.
                                    </li>
                                </ol>-->
            </div>
        </div>

        <div class="panel-group">
            <div class="panel panel-default">
                <div class="breadcrumb panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse1"> <i class="fa fa-dashboard"></i> SignUp as a Technical Team Member.</a>
                    </h4>
                </div>
                <div id="collapse1" class="panel-collapse collapse">
                    <div class="panel-body">
                        <form action="TechnicalTeamController" id="uploadImage" method="post" enctype="multipart/form-data" runat="server" class="form-horizontal">
                            <div class="row">

                                <div class="raw" style="padding-right: 50px;">
                                    <div class="form-group">
                                        <%if (user3.getUserType().getUserType() == 5 || user3.getUserType().getUserType() == 3) {%>
                                        <div class="form-group">
                                            <label for="email" class="control-label col-xs-5 lbl_name">Email : </label>
                                            <div class="col-xs-7">
                                                <input  type="email" class="form-control" name="emailAdd" id="emailAdd" placeholder="Enter Email" required/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="username" class="control-label col-xs-5 lbl_name">Username : </label>
                                            <div class="col-xs-7">
                                                <input type="text" name="username" class="form-control" id="username" placeholder="Enter Username" required/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="contact_no" class="control-label col-xs-5 lbl_name">Personal Contact No : </label>
                                            <div class="col-xs-7">
                                                <input type="text" name="contact_no" class="form-control" id="contact_no" placeholder="Enter Contact No" required/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="contact_no" class="control-label col-xs-5 lbl_name">Department Contact No : </label>
                                            <div class="col-xs-7">
                                                <input type="text" name="contact_no_dep" class="form-control" id="contact_no_dep" placeholder="Enter Contact No" required/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="skype" class="control-label col-xs-5 lbl_name">Skype : </label>
                                            <div class="col-xs-7">
                                                <input type="text" name="skype" class="form-control" id="skype" placeholder="Enter Skype    " required/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="viber" class="control-label col-xs-5 lbl_name">Viber : </label>
                                            <div class="col-xs-7">
                                                <input type="text" name="viber" class="form-control" id="viber" placeholder="Enter Viber" required/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="other" class="control-label col-xs-5 lbl_name">Other : </label>
                                            <div class="col-xs-7">
                                                <input type="text" name="other" class="form-control" id="other" placeholder="Enter Other Details" required/>
                                            </div>
                                        </div>
                                        <!--<div class="form-group-sm" style="padding-left: 266px">-->
                                        <div class="form-group">
                                            <!--<div class="col-xs-8">-->

                                            <label for="country_save" class="control-label col-xs-5 lbl_name">Select Your Country :</label>
                                            <div class="col-xs-7">
                                                <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                                    SELECT * FROM country;
                                                </sql:query>

                                                <select  name="country_save" id="country_save" class="form-control">
                                                    <option  selected disabled="true"> - Select a country - </option>
                                                    <c:forEach var="row9" items="${idQ9.rows}"> 
                                                        <option value="${row9.country_name}">${row9.country_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                    </div>
                                    <%}%>

                                    <!--                            <div class="raw" style="padding-right: 50px;">
                                                                    <div class="form-group">
                                                                        <div class="col-xs-7 pull-left">
                                                                            <input  type="button" class="form-control btn btn-primary" name="btn_Next" id="btn_Next" value="Next" onclick="saveTechTeamData();"/>
                                                                        </div>
                                                                    </div>
                                                                </div>-->
                                    <!--file upload Coding-->
                                    <div class="raw" style="padding-right: 50px;">

                                        <div class="form-group">
                                            <label class="control-label col-md-6 " for="file_sym">Upload Image:</label>
                                            <div class="col-md-6 pull-right"> 
                                                <input type="file" class="form-control" name="file_sym" id="file_sym">
                                            </div>
                                        </div>
                                        <div class="form-group"> 
                                            <div class="col-xs-7">
                                                <input class="btn btn-info  pull-right" type="submit" name="btn_submit" id="btn_submit" onsubmit="onSubmit()"/>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div>
                    </div>
                </div>
            </div>
        </div>
        </form>




    </div>

    <div class="panel-body">
        <div class="raw">
            <div class="panel panel-default">

                <div class="panel-body">
                    <div class="form-group">
                        <label for="country_save" class="control-label col-xs-5 lbl_name">Select Your Country To get Technical member Details :</label>
                        <div class="col-xs-7">

                            <sql:query var="idQ9"  dataSource="jdbc/sdb">
                                SELECT * FROM country;
                            </sql:query>

                            <select  name="country_select" id="country_select" class="form-control" onchange="getTechTeamData();">

                                <option  selected disabled="true"> - Select a country - </option>
                                <c:forEach var="row9" items="${idQ9.rows}"> 
                                    <option value="${row9.country_name}">${row9.country_name}</option>
                                </c:forEach>

                            </select> 
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel panel-body">
                    <div class="col-lg-12">
                        <table border="0" width="100%" id="view_data_table" class="table table-striped" style="left: 10px;">
                            <thead>
                                <tr class="info">
                                    <th>Members</th>                                                                              
                                    <th>Email</th>                                                                               
                                    <th>Contact No Dep.</th>                                                                               
                                    <th>Contact No Pers.</th>                                                                               
                                    <th>Skype</th>                                                                               
                                    <th>Viber</th>                                                                               
                                    <th>Other Data</th>                                                                               
                                    <th>Image</th>                                                                               
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>

            <!--            <div class="col-lg-6">
                            <table border="0" width="100%" id="lofData" class="table table-hover" style="left: 10px;">
                                <thead>
                                    <tr >
                                        <th>Technical Member Details</th>                                                                            
                                    </tr>
                                </thead>
                                <tbody>
            
                                </tbody>
            
                            </table>
                        </div>-->

        </div>

    </div>
</div>

</div>

<script type="text/javascript">
    function getTechTeamData() {

        var country_select = document.getElementById("country_select").value;

        var xmlHttp = getAjaxObject();

        xmlHttp.onreadystatechange = function () {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
                var reply = eval('(' + xmlHttp.responseText + ')');
                console.log(reply)
                if (reply.message) {
                    var techTeamData = reply.techTeamData;
                    console.log("techTeamData");
                    console.log(techTeamData);
                    
                    if(techTeamData.length === 0){
                        
                          BootstrapDialog.show({
                            title: 'Notification',
                            type: BootstrapDialog.TYPE_WARNING,
                            size: BootstrapDialog.SIZE_SMALL,
                            message: 'No Technical Members for the selected country! Please Select Sri Lanka for More Details!'
                        });
                    }else{


                    BootstrapDialog.show({
                        title: 'Notification',
                        type: BootstrapDialog.TYPE_SUCCESS,
                        size: BootstrapDialog.SIZE_SMALL,
                        message: 'Success'
                    });
                    
                    for (var key in techTeamData) {
                        var view_data_table = document.getElementById('view_data_table').getElementsByTagName('tbody')[0];

                        var username = techTeamData[key].userName;
                        var row = document.createElement("tr");
                        row.id = username;

                        var col1 = document.createElement("td");
                        col1.type = "text";
                        col1.value = username;
                        col1.innerHTML = username;
                        row.appendChild(col1);
                        console.log("username");
                        console.log(username);

                        var email = techTeamData[key].emailAddress;
                        var col2 = document.createElement("td");
                        col2.type = "text";
                        col2.value = email;
                        col2.innerHTML = email;
                        row.appendChild(col2);
                        console.log("email");
                        console.log(email);

                        var contact_no_per = techTeamData[key].contactNo;
                        var col3 = document.createElement("td");
                        col3.type = "text";
                        col3.value = contact_no_per;
                        col3.innerHTML = contact_no_per;
                        row.appendChild(col3);
                        console.log("contact_no_per");
                        console.log(contact_no_per);


                        var contact_no_dep = techTeamData[key].contactNoDep;
                        var col4 = document.createElement("td");
                        col4.type = "text";
                        col4.value = contact_no_dep;
                        col4.innerHTML = contact_no_dep;
                        row.appendChild(col4);
                        console.log("contact_no_dep");
                        console.log(contact_no_dep);

                        var skype = techTeamData[key].skypeName;
                        var col5 = document.createElement("td");
                        col5.type = "text";
                        col5.value = skype;
                        col5.innerHTML = skype;
                        row.appendChild(col5);
                        console.log("skype");
                        console.log(skype);

                        var viber = techTeamData[key].viberName;
                        var col6 = document.createElement("td");
                        col6.type = "text";
                        col6.value = viber;
                        col6.innerHTML = viber;
                        row.appendChild(col6);
                        console.log("viber");
                        console.log(viber);

                        var other_data = techTeamData[key].otherData;
                        var col7 = document.createElement("td");
                        col7.type = "text";
                        col7.value = other_data;
                        col7.innerHTML = other_data;
                        row.appendChild(col7);
                        console.log("other_data");
                        console.log(other_data);

                        var image_url = techTeamData[key].imageUrl;
                        var col8 = document.createElement("img");
                        col8.type = "text";
                        col8.value = image_url;
                        col8.src = "/IEPTescoNew/img/TechUsers/" + image_url;
                        col8.style.height = "65px";
                        col8.style.width = "65px";
                        row.appendChild(col8);
                        console.log("image_url");
                        console.log(image_url);
//                        
//                        var techR3Col2 = document.createElement("img");
////        techR3Col2.innerHTML = tech_data.washSymbol;
//        techR3Col2.src = "/MulBerry/img/symbols/" + urlW + ".png";
//        techR3Col2.style.height = "35px";
//        techR3Col2.style.width = "35px";

                        view_data_table.appendChild(row);
                    }

                    document.getElementById("country_select").value = "";
                    }
                } else {
                    alert("Failed");
                }
            }
        };
        xmlHttp.open("POST", "TechnicalTeamController?actionType=getTechTeamData&country_select=" + country_select, true);
        xmlHttp.send();
    }
    
    function onSubmit() {

        alert("Inside");
//        var emailAdd = document.getElementById("emailAdd").value;
//        var username = document.getElementById("username").value;
//        var contact_no = document.getElementById("contact_no").value;
//        var contact_no_dep = document.getElementById("contact_no_dep").value;
//        var skype = document.getElementById("skype").value;
//        var viber = document.getElementById("viber").value;
//        var other = document.getElementById("other").value;
//        var country_save = document.getElementById("country_save").value;

        var fileExtension = "";
        var fileElement = document.getElementById("file_sym");

        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension === "png" || fileExtension === "PNG" || fileExtension === "jpg" || fileExtension === "JPG") {
            alert("Success Image");
            return true;
        }
        else if (fileExtension === "") {
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

//        var data = emailAdd + "/" + username + "/" + contact_no + "/" + contact_no_dep + "/" + skype + "/" + viber + "/" + other + "/" + country_save + "/" + fileElement;
    }
</script>

<%@include file="include/footer.jsp"%>
<% } else {
        response.sendRedirect("LogoutController");
    }%>