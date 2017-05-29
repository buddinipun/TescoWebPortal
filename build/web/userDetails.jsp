<%-- 
    Document   : pdfExtracter
    Created on : Jul 5, 2015, 8:08:57 PM
    Author     : oshan
--%>




<%    SysUser user = (SysUser) session.getAttribute("user");
    if (user != null) {
        int company = user.getCompanyId().getCompanyId();
%>
<%@include file="./include/header.jsp"%>

<%@include file="./include/sideMenu.jsp"%>


<script>
    $(document).on('click', '#viewDetials_tbl tbody tr', function () {
        viewUserDetails($(this).find('td:first').text().trim());
    });
</script>
<script>
    function viewUserDetails(username) {

        var xmlHttp1 = getAjaxObject();
        xmlHttp1.onreadystatechange = function ()

        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200) {
                document.getElementById("detailsDiv").className = "hidden";

                if (!$('#noPermission tbody').empty()) {
                    $('#noPermission tbody').empty();
                }
                var reply = eval('(' + xmlHttp1.responseText + ')');
                console.log(reply);

                var replysize = reply.jArray2.length;
                var replysize1 = reply.jArray3.length;


                document.getElementById("detailsDiv").className = "";

                var noPermission = document.getElementById('noPermission').getElementsByTagName('tbody')[0];

                for (var f = 0; replysize > f; f++) {

                    var row = document.createElement("tr");
                    var td1 = document.createElement("td");
                    var td2 = document.createElement("td");

                    var id = reply.jArray2[f].menu_item_id;
                    var name = reply.jArray2[f].menu_item_name;
                    var landmarks = document.createElement("input");
                    var lablname = document.createElement("label");

                    lablname.innerHTML = name;
                    landmarks.type = "checkbox";
                    landmarks.id = id;
                    landmarks.name = "permission";
                    landmarks.class = "ckbx";
                    landmarks.value = id;
                    td1.appendChild(landmarks);
                    td2.appendChild(lablname);
                    row.appendChild(td1);
                    row.appendChild(td2);

                    noPermission.appendChild(row);

                }



                for (var g = 0; replysize1 > g; g++) {

                    var row = document.createElement("tr");
                    var td1 = document.createElement("td");
                    var td2 = document.createElement("td");

                    var id = reply.jArray3[g].menu_item_id;
                    var name = reply.jArray3[g].menu_item_name;
                    var landmarks = document.createElement("input");
                    var lablname = document.createElement("label");
                    lablname.innerHTML = name;
                    landmarks.type = "checkbox";
                    landmarks.id = id;
                    landmarks.name = "permission";
                    landmarks.class = "ckbx";
                    landmarks.checked = true;
                    landmarks.value = id;
                    td1.appendChild(landmarks);
                    td2.appendChild(lablname);
                    row.appendChild(td1);
                    row.appendChild(td2);

                    noPermission.appendChild(row);

                }
                if (replysize1 != 0 || replysize != 0) {

                    var row2 = document.createElement("tr");
                    var hidden = document.createElement("input");
                    hidden.type = "hidden";
                    hidden.value = username;
                    hidden.name = "username";
                    hidden.id = "usernew";
                    noPermission.appendChild(hidden);

                    var saveBtn = document.createElement("input");
                    saveBtn.type = "button";
                    saveBtn.value = "Set Permission";
                    saveBtn.name = "saveBtn";
                    saveBtn.id = "remPerm";

                    saveBtn.setAttribute("class", "btn btn-primary");
                    saveBtn.addEventListener("click", setPermission);

                    row2.appendChild(hidden);
                    row2.appendChild(saveBtn);
                    noPermission.appendChild(row2);
                }
                document.getElementById("username").innerHTML = reply.jArray3[0].username;
                //  console.log(userObject);

            }
        };
        xmlHttp1.open("POST", "UserController?actionType=BringPriviledges&username=" + username, true);
        xmlHttp1.send();

    }

    function setPermission() {

        var username = document.getElementById('usernew').value;
        var checkboxes = document.getElementsByName('permission');
        var checkboxesChecked = [];
        checkboxesChecked.push(username);
        for (var i = 0; i < checkboxes.length; i++) {
            // And stick the checked ones onto an array...
            if (checkboxes[i].checked) {
                checkboxesChecked.push(checkboxes[i].value);
            }
        }
        // Return the array if it is non-empty, or null

        var xmlHttp1 = getAjaxObject();
        xmlHttp1.onreadystatechange = function ()

        {
            if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200) {
                document.getElementById("detailsDiv").className = "hidden";


                var reply = eval('(' + xmlHttp1.responseText + ')');
                console.log(reply);
                viewUserDetails(username);


            }
        };
        xmlHttp1.open("POST", "UserController?actionType=SetAllPermission&permissionList=" + checkboxesChecked, true);
        xmlHttp1.send();

    }

</script>

<div id="Searching_Modal" class="modal fade" tabindex="-1" role="dialog" data-keyboard="false" data-backdrop="static">
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
<div id="page-wrapper">
    <%  String success = (String) request.getAttribute("SUCCESS_MESSAGE");
        String error = (String) request.getAttribute("ERROR_MESSAGE");
    %>
    <div class="container-fluid">
        <div class="row">
            <br/>
            <div class="col-lg-8 col-md-8 col-lg-offset-2 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">User Details</h3>
                    </div>
                    <sql:query var="idQss" dataSource="jdbc/sdb">
                        SELECT * FROM sys_user s INNER JOIN customer c on s.username=c.username WHERE s.username='<%=user.getUsername()%>';
                    </sql:query>
                    <div class="panel-body">
                        <form action="UserController?actionType=updateUserDetails" method="post">
                            <table border="0" width="50%" class="table table-responsive rcorners1">
                                <thead>
                                </thead>
                                <c:forEach var="row3" items="${idQss.rows}">
                                    <tbody>
                                        <tr>
                                            <td>Username :</td>
                                            <td><input type="text" name="username" value="${row3.username}" class="form-control" id="inputAddress" style="height: 27px;" readonly>
                                                <input type="hidden" name="customer_id" value="${row3.customer_id}"/>
                                                <input type="hidden" name="enquiry" value="${row3.enquiry}"/>
                                                <input type="hidden" name="supplier_code" value="${row3.supplier_code}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Email :</td>
                                            <td><input type="text" name="email_address" value="${row3.email_address}" class="form-control" id="inputAddress" readonly style="height: 27px;"></td>
                                        </tr>
                                        <tr>
                                            <td>Customer Name :</td>
                                            <td><input type="text" name="customer_name" value="${row3.customer_name}" class="form-control" id="inputAddress"  style="height: 27px;"></td>
                                        </tr>
                                        <tr>
                                            <td>Phone :</td>
                                            <td><input type="text" name="phone_primary" value="${row3.phone_primary}" class="form-control" id="inputAddress"  style="height: 27px;"></td>
                                        </tr>
                                        <tr>
                                            <td>Fax :</td>
                                            <td><input type="text" name="fax" value="${row3.fax}" class="form-control" id="inputAddress"  style="height: 27px;"></td>
                                        </tr>
                                        <tr>
                                            <td>Country :</td>
                                            <td><input type="text" name="country" value="${row3.country}" class="form-control" id="inputAddress"  style="height: 27px;"></td>
                                        </tr>
                                        <tr>
                                            <td>Brand :</td>
                                            <td><input type="text" name="brands" value="${row3.brands}" class="form-control" id="inputAddress"  style="height: 27px;"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><center><input type="submit" name="brands" value="Submit" class="btn btn-primary" style="width: 25%;"/></center></td>
                                    </tr>


                                </c:forEach>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <br/>
            <div class="col-lg-8 col-md-8 col-lg-offset-2 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Change Password</h3>
                    </div>
                    <sql:query var="idQss" dataSource="jdbc/sdb">
                        SELECT * FROM sys_user s INNER JOIN customer c on s.username=c.username WHERE s.username='<%=user.getUsername()%>';
                    </sql:query>
                    <div class="panel-body">
                        <table border="0" width="50%" class="table table-responsive rcorners1">
                            <thead>
                            </thead>
                            <c:forEach var="row3" items="${idQss.rows}">
                                <tbody>
                                    <tr>
                                        <td>Current Password </td>
                                        <td>
                                            <input type="password" name="currentPass" class="form-control" id="currentPass" style="height: 27px;" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>New Password </td>
                                        <td>
                                            <input type="password" name="newPass" class="form-control" id="newPass" style="height: 27px;" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Re-type Password </td>
                                        <td>
                                            <input type="password" name="rePass" class="form-control" id="rePass" style="height: 27px;" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <input type="button" name="btn_change"  class="form-control btn btn-primary pull-right" id="btn_change" value="Update" style="width: 25%;" onclick="confirmUpdate()">
                                        </td>
                                    </tr>
                                </tbody>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script type="text/javascript">
    function confirmUpdate() {
        var cpass = document.getElementById("currentPass").value;
        var newpass = document.getElementById("newPass").value;
        var repass = document.getElementById("rePass").value;
        
        if (newpass === repass){
            BootstrapDialog.show({
            message: 'Do you want to update password ?',
            closable: false,
            buttons: [{
                    label: 'Yes',
                    action: function (dialogRef) {
                        dialogRef.close();
                        if (cpass === null || cpass === "" || newpass === null || newpass === "" || repass === null || repass === "") {
                            sm_alert("All feilds must be filled.");
                        } else {
                            checkPass();
                        }
                    }
                }, {
                    label: 'No',
                    action: function (dialogRef) {
                        dialogRef.close();
                    }
                }]
        });
        }else{
            sm_alert("New Password Dosen't Match")
            document.getElementById("repass").value="";
        }
    }

    function updatePass() {
        var customerUsername = document.getElementById("inputAddress").value;
        var currentPass = document.getElementById("currentPass").value;
        var newPass = document.getElementById("newPass").value;
        var rePass = document.getElementById("rePass").value;

        var datalist = currentPass + "@" + newPass + "@" + rePass + "@" + customerUsername;

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                if (reply.message) {
                    BootstrapDialog.show({
                        message: "Password Successfuly Changed... You will redirect to login page",
                        closable: false,
                        size: BootstrapDialog.SIZE_SMALL,
                        buttons: [{
                                label: 'Close',
                                action: function (dialogRef) {
                                    dialogRef.close();
                                    window.location = "/IEPTescoNew/LogoutController";
                                }
                            }]
                    });
                } else {
//                    alert("update not ok");
                }
            }
        };
        xmlHttp.open("POST", "UserController?actionType=updateUserPassword&data=" + datalist, true);
        xmlHttp.send();

    }

    function checkPass() {
        $('#Searching_Modal').modal('show');
        var xmlHttp = getAjaxObject();
        var customerUsername = document.getElementById("inputAddress").value;
        var currentPass = document.getElementById("currentPass").value;

        var datalist = customerUsername + "@" + currentPass;

        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function () {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = eval('(' + xmlHttp.responseText + ')');
                if (reply.message) {
                    $('#Searching_Modal').modal('hide');
                    updatePass();

                } else {
                    $('#Searching_Modal').modal('hide');
                    BootstrapDialog.show({
                        message: "Your Current Password Did not Match",
                        closable: false,
                        size: BootstrapDialog.SIZE_SMALL,
                        buttons: [{
                                label: 'Close',
                                action: function (dialogRef) {
                                    dialogRef.close();
                                    window.location.reload();
                                }
                            }]
                    });
                }


            }

        };
        xmlHttp.open("POST", "UserController?actionType=checkPassword&data=" + datalist, true);
        xmlHttp.send();
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
        $("#menuItem2").addClass("active");
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

<%@include file="include/footer.jsp"%>
<% } else {

        response.sendRedirect("LogoutController");
    }%>