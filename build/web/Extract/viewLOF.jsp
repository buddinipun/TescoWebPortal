<%-- 
    Document   : viewLOF
    Created on : Jul 16, 2015, 2:39:34 PM
    Author     : root
--%>

<%@page import="java.util.StringTokenizer"%>
<%@include file="../include/header.jsp"%>
<%@include file="../include/sideMenu.jsp"%>
<%    SysUser user = (SysUser) session.getAttribute("user");
    if (user != null) {


%>

<div id="page-wrapper">
    <div class="container-fluid">

        <%            String aaa = (String) request.getAttribute("AAA");
            String bbb = (String) request.getAttribute("BBB");
            String ccc = (String) request.getAttribute("CCC");
            String ddd = (String) request.getAttribute("DDD");
            String LOF_NO = (String) request.getAttribute("LOF_NO");

            String[] gd = aaa.split("@");
            String[] ld = bbb.split("##");
            String[] ean = ccc.split("@");
            String[] swl = ddd.split("@@");

            String key = "";
            String val = "";

            String Label = "";
            String Reference = "";
            String Care_Text = "";
            String Wash_Symbol = "";
            String Fibre_Composition_1 = "";
            String Fibre_Composition_2 = "";
            String Fibre_Composition_3 = "";
            String Fibre_Composition_4 = "";
            String Group = "";
            String Description = "";

            String EAN_No = "";
            String UK = "";
            String EUR = "";
            String US = "";
            String MX = "";
            String Sec_Size1 = "";
            String Sec_Size2 = "";
            String Sec_Size3 = "";
            String Sec_Size4 = "";
            String Euro = "";
            String pound = "";
            String CZ = "";
            String SK = "";
            String PL = "";
            String HU = "";
            String TK = "";

            String REFERENCE = "";
            String TREND_NAME = "";
            String PRODUCT_BENIFIT = "";
            String PRODUCT_DESCRIPTION = "";
            String SUPPLIER_ID = "";
            String JOB_NO = "";
            String CARE_TEXT = "";
        %>

        <!-- Page Heading -->
        <div class="row">
            <div class="col-lg-12">
                <fieldset id="ext-comp-1001" class="scheduler-border">
                    <legend id="ext-gen44" class="scheduler-border">
                        <h3>
                            <b>General Data</b>
                        </h3>
                    </legend>
                    <TABLE class="table table-bordered" BORDER="1">
                        <TR>
                            <TH>Key</TH>
                            <TH>Name</TH>
                        </TR>
                        <%
                            for (int x = 0; x < gd.length; x++) {

                                StringTokenizer st = new StringTokenizer(gd[x], ">");

                                if (st.hasMoreTokens()) {

                                    key = st.nextToken();
                                    val = st.nextToken();

                                }
                        %>


                        <TR>
                            <TD><%=key%></TD>
                            <TD><%=val%></TD>
                        </TR>



                        <%
                            }
                        %>

                    </TABLE>
                </fieldset>

            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <fieldset id="ext-comp-1001" class="scheduler-border">
                    <legend id="ext-gen44" class="scheduler-border">
                        <h3>
                            <b>LABEL TECHNICAL DATA </b>
                        </h3>
                    </legend>
                    <TABLE class="table table-bordered" BORDER="1">
                        <TR>
                            <TH>Label</TH>
                            <TH>Reference</TH>
                            <TH>Care Text</TH>
                            <TH>Wash Symbol</TH>
                            <TH>Fiber Composition 1</TH>
                            <TH>Fiber Composition 2</TH>
                            <TH>Fiber Composition 3</TH>
                            <TH>Fiber Composition 4</TH>
                            <TH>Group</TH>
                            <TH>Description</TH>


                        </TR>
                        <%
                            for (int x = 0; x < ld.length; x++) {

                                String[] gd1 = ld[x].split("@");

                                Label = gd1[0];
                                Reference = gd1[1];
                                Care_Text = gd1[2];
                                Wash_Symbol = gd1[3];
                                Fibre_Composition_1 = gd1[4];
                                Fibre_Composition_2 = gd1[5];
                                Fibre_Composition_3 = gd1[6];
                                Fibre_Composition_4 = gd1[7];
                                Group = gd1[8];
                                Description = gd1[9];

                                        // out.println(gd1.length);
                                // out.println(ld[x]);
                                // out.println("<br/>");
                                //  for (int s = 0; s < gd1.length; s++) {
                                //     out.println(gd1[s]);
                                //     out.println("<br/>");
                                // }
%>


                        <TR>
                            <TD><%=Label%></TD>
                            <TD><%=Reference%></TD>
                            <TD><%=Care_Text%></TD>
                            <TD><%=Wash_Symbol%></TD>
                            <TD><%=Fibre_Composition_1%></TD>
                            <TD><%=Fibre_Composition_2%></TD>
                            <TD><%=Fibre_Composition_3%></TD>
                            <TD><%=Fibre_Composition_4%></TD>
                            <TD><%=Group%></TD>
                            <TD><%=Description%></TD>



                        </TR>



                        <%
                            }
                        %>

                    </TABLE>
                </fieldset>

            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <fieldset id="ext-comp-1001" class="scheduler-border">
                    <legend id="ext-gen44" class="scheduler-border">
                        <h3>
                            <b> SWING TICKET LABEL DATA </b>
                        </h3>
                    </legend>
                    <TABLE class="table table-bordered" BORDER="1">
                        <TR>
                            <TH>REFERENCE</TH>
                            <TH>TREND_NAME</TH>
                            <TH>PRODUCT_BENIFIT</TH>
                            <TH>PRODUCT_DESCRIPTION</TH>
                            <TH>SUPPLIER_ID</TH>
                            <TH>JOB_NO</TH>
                            <TH>CARE_TEXT</TH>

                        </TR>
                        <%
                            for (int x = 0; x < swl.length; x++) {

                                String[] gd1 = swl[x].split("#");

                                REFERENCE = gd1[0];
                                TREND_NAME = gd1[1];
                                PRODUCT_BENIFIT = gd1[2];
                                PRODUCT_DESCRIPTION = gd1[3];
                                SUPPLIER_ID = gd1[4];
                                JOB_NO = gd1[5];
                                CARE_TEXT = gd1[6];

                                        // out.println(gd1.length);
                                // out.println(ld[x]);
                                // out.println("<br/>");
                                //  for (int s = 0; s < gd1.length; s++) {
                                //     out.println(gd1[s]);
                                //     out.println("<br/>");
                                // }
%>


                        <TR>
                            <TD><%=REFERENCE%></TD>
                            <TD><%=TREND_NAME%></TD>
                            <TD><%=PRODUCT_BENIFIT%></TD>
                            <TD><%=PRODUCT_DESCRIPTION%></TD>
                            <TD><%=SUPPLIER_ID%></TD>
                            <TD><%=JOB_NO%></TD>
                            <TD><%=CARE_TEXT%></TD>

                        </TR>



                        <%
                            }
                        %>

                    </TABLE>
                </fieldset>
            </div>

            <!-- /.row -->

            <div class="row">
                <div class="col-lg-12">

                    <fieldset id="ext-comp-1001" class="scheduler-border">
                        <legend id="ext-gen44" class="scheduler-border">
                            <h3>
                                <b>EAN DATA </b>
                            </h3>
                        </legend>
                        <TABLE class="table table-bordered" BORDER="1">
                            <TR>
                                <%
                                    StringTokenizer ea1 = new StringTokenizer(ean[0], "|");
                                    if (ea1.countTokens() == 11) {
                                %>
                                <TH>EAN No</TH>
                                <TH>UK</TH>
                                <TH>EUR</TH>
                                <TH>US</TH>
                                <TH>MX</TH>
                                <TH>Sec Size1</TH>
                                <TH>Sec Size2</TH>
                                <TH>Sec Size3</TH>
                                <TH>Sec Size4</TH>
                                <TH>EURO</TH>
                                <TH>POUNDS</TH>

                                <%
                                } else {
                                %>



                                <TH>EAN No</TH>
                                <TH>UK</TH>
                                <TH>EUR</TH>
                                <TH>US</TH>
                                <TH>MX</TH>
                                <TH>Sec Size1</TH>
                                <TH>Sec Size2</TH>
                                <TH>Sec Size3</TH>
                                <TH>Sec Size4</TH>
                                <TH>CZ</TH>
                                <TH>SK</TH>
                                <TH>OL</TH>
                                <TH>HU</TH>
                                <TH>TK</TH>


                                <%
                                    }
                                %>
                            </TR>
                            <%
                                StringTokenizer ea = new StringTokenizer(ean[0], "|");
                                if (ea.countTokens() == 11) {

                                    for (int x = 0; x < ean.length; x++) {

                                        StringTokenizer st = new StringTokenizer(ean[x], "|");

                                        if (st.hasMoreTokens()) {

                                            EAN_No = st.nextToken();
                                            UK = st.nextToken();
                                            EUR = st.nextToken();
                                            US = st.nextToken();
                                            MX = st.nextToken();
                                            Sec_Size1 = st.nextToken();
                                            Sec_Size2 = st.nextToken();
                                            Sec_Size3 = st.nextToken();
                                            Sec_Size4 = st.nextToken();
                                            Euro = st.nextToken();
                                            pound = st.nextToken();

                                        }

                            %>


                            <TR>
                                <TD><%=EAN_No%></TD>
                                <TD><%=UK%></TD>
                                <TD><%=EUR%></TD>
                                <TD><%=US%></TD>
                                <TD><%=MX%></TD>
                                <TD><%=Sec_Size1%></TD>
                                <TD><%=Sec_Size2%></TD>
                                <TD><%=Sec_Size3%></TD>
                                <TD><%=Sec_Size4%></TD>
                                <TD><%=Euro%></TD>
                                <TD><%=pound%></TD>



                            </TR>



                            <%
                                }
                            } else {

                                for (int x = 0; x < ean.length; x++) {

                                    StringTokenizer st = new StringTokenizer(ean[x], "|");

                                    if (st.hasMoreTokens()) {

                                        EAN_No = st.nextToken();
                                        UK = st.nextToken();
                                        EUR = st.nextToken();
                                        US = st.nextToken();
                                        MX = st.nextToken();
                                        Sec_Size1 = st.nextToken();
                                        Sec_Size2 = st.nextToken();
                                        Sec_Size3 = st.nextToken();
                                        Sec_Size4 = st.nextToken();
                                        CZ = st.nextToken();
                                        SK = st.nextToken();
                                        PL = st.nextToken();
                                        HU = st.nextToken();
                                        TK = st.nextToken();

                                    }


                            %>


                            <TR>
                                <TD><%=EAN_No%></TD>
                                <TD><%=UK%></TD>
                                <TD><%=EUR%></TD>
                                <TD><%=US%></TD>
                                <TD><%=MX%></TD>
                                <TD><%=Sec_Size1%></TD>
                                <TD><%=Sec_Size1%></TD>
                                <TD><%=Sec_Size1%></TD>
                                <TD><%=Sec_Size1%></TD>
                                <TD><%=CZ%></TD>
                                <TD><%=SK%></TD>
                                <TD><%=PL%></TD>
                                <TD><%=HU%></TD>
                                <TD><%=TK%></TD>




                            </TR>



                            <%
                                    }
                                }
                            %>

                        </TABLE>
                    </fieldset>

                </div>


            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-lg-12">
                    <form role="form"  id="insert_data" class="form-horizontal" action="NewSaveController"
                          method="post">
                        <div class="form-group">
                            <center> <input type="button"  value="Submit LOF" class="btn btn-primary" onclick="submitLOF();" /></center>
                        </div>
                        <div class="form-group">
                            <input type="hidden" name="gen" id="gen" value="<%=aaa%>" />
                        </div>
                        <div class="form-group">
                            <input type="hidden" name="lbl" id="lbl" value="<%=bbb%>" />
                        </div>
                        <div class="form-group">
                            <input type="hidden" name="swi" id="swi" value="<%=ddd%>" />
                        </div>
                        <div class="form-group">
                            <input type="hidden" name="ean" id="ean" value="<%=ccc%>" />
                        </div>
                        <div class="form-group">
                            <input type="hidden" name="LOF_NO" id="LOF_NO"
                                   value="<%=LOF_NO%>" />
                        </div>
                    </form>
                </div>


            </div>
            <!-- /.row -->

        </div>
        <!-- /.container-fluid -->

    </div>
    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->


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

<script type="text/javascript">
    document.title = "LOF Extracter | E-Platform";

    function submitLOF() {
        BootstrapDialog.confirm({
            title: 'Submit the Order',
            message: 'Do you want to submit the order?',
            type: BootstrapDialog.TYPE_PRIMARY,
            closable: true,
            draggable: true,
            btnCancelLabel: 'No',
            btnOKLabel: 'Yes',
            callback: function (result) {
                // result will be true if button was click, while it will be false if users close the dialog directly.
                if (result) {
                    $("#insert_data").submit();
                    nom_Success("Order has been submitted.");
                } else {
                    nom_notify("Order has not been submitted.");
                }
            }
        });
    }

</script>

<%@include file="../include/footer.jsp"%>
<% } else {

        response.sendRedirect("../LogoutController");
    }%>
