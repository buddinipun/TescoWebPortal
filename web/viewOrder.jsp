<%-- 
    Document   : viewOrder
    Created on : Oct 9, 2015, 3:00:42 PM
    Author     : Oshan
--%>

<%@page import="com.impression.hibe.model.LofSwingticletlabeldata"%>
<%@page import="com.impression.hibe.model.LofLabeltechnicaldata"%>
<%@page import="com.impression.hibe.model.LofEandata"%>
<%@page import="java.util.List"%>
<%@page import="com.impression.hibe.model.LofGeneraldata"%>
<%@page import="com.impression.dao.Check_lof"%>
<%@page import="com.impression.hibe.model.SysUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    SysUser user6 = (SysUser) session.getAttribute("user");

    String lof_no = (String) request.getSession().getAttribute("order_id");

    Check_lof chk = new Check_lof();

    LofGeneraldata gData = chk.getGeneralDataById(Integer.parseInt(lof_no));

    List<LofEandata> lt = chk.getEAN(gData.getWebOrderNo());
    List<LofLabeltechnicaldata> tData = chk.getLabeltechnicaldata(gData.getWebOrderNo());
    List<LofSwingticletlabeldata> swingData = chk.getSwingdata(gData.getWebOrderNo());
    LofEandata swingPrices = chk.getSellingPrices(gData.getWebOrderNo());

    if (tData.size() > 0) {

    }

    if (user6 != null) {
%>

<html>
    <head>
        <title>E-Platform | Impressions</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="/IEPTescoNew/img/title_logo.png" type="image/png">
        <link rel="shortcut icon" type="image/png" href="/IEPTescoNew/img/title_logo.png" />
        <link href="/IEPTescoNew/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="/IEPTescoNew/css/imp_style.css" rel="stylesheet" type="text/css"/>

        <!-- Bootstrap Dialog CSS-->
        <link href="/IEPTescoNew/css/bootstrap-dialog.min.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="/IEPTescoNew/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <link href="/IEPTescoNew/css/jquery-ui.css" rel="stylesheet" type="text/css">


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>

        <script src="/IEPTescoNew/js/jquery.js"></script>

        <script src="/IEPTescoNew/js/jquery-ui.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="/IEPTescoNew/js/bootstrap.min.js"></script>

        <!-- Nice Scrolling -->
        <script src="/IEPTescoNew/js/jquery.nicescroll.min.js"></script>

        <!-- Ajax Object -->
        <script src="/IEPTescoNew/js/imp.js"></script>

        <!-- Bootstrap Dialog Object -->
        <script src="/IEPTescoNew/js/bootstrap-dialog.min.js"></script>


        <script>
            window.onload = function () {
                var d = new Date();
                var n = d.getFullYear();
                var dat = document.getElementById("year");
                dat.innerHTML = n;
            };
        </script>

        <script type="text/javascript">

            function closeView() {
                window.location = "/IEPTescoNew/Extract/pdfExtracter.jsp";
            }

            function requestArtWork() {
                var id = document.getElementById("lof_data").innerHTML;
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
                            type: BootstrapDialog.TYPE_INFO,
                            buttons: [{
                                    label: 'Close',
                                    action: function (dialogRef) {
                                        dialogRef.close();
                                        window.location = "/IEPTescoNew/Extract/pdfExtracter.jsp"
                                    }
                                }]
                        });

                    }
                };

                xmlHttp.open("POST", "RequestAwController?actionType=requestArtwork&id=" + id, true);
                xmlHttp.send();

            }

        </script>

    </head>
    <body style="overflow-y: auto;">
        <div id="top_div" >
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#"  style="padding: 10px 10px 10px 20px;">
                        <img alt="Brand" src="/IEPTescoNew/img/logo_head.png" class="img-responsive">
                    </a>
                    <a class="navbar-brand" href="/IEPTescoNew/admin.jsp">Impressions Labels E-Platform</a>
                </div>
                <ul class="nav navbar-nav navbar-right" style="margin-right: 10px;">

                    <li><a href="/IEPTescoNew/Extract/pdfExtracter.jsp">Close View</a></li>
                    <li onclick="requestArtWork()"><a href="#">Request Artwork</a></li>
                    <li><a href="/IEPTescoNew/DownloadPDF?lof_no=<%=gData.getLofData()%>">Print</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="text-transform: capitalize;" ><i class="fa fa-user"></i> <%=user6.getUsername()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="/IEPTescoNew/userDetails.jsp"><i class="fa fa-fw fa-user"></i> Profile</a>
                            </li>
                            <li role="separator" class="divider"></li>
                            <li>
                                <a href="/IEPTescoNew/LogoutController"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
        <script type="text/javascript">
            document.title = "View Order | E-Platform";
        </script>

        <div id="content"> 
            <div class="col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1 col-sm-12 col-xs-12 " style="overflow-y: auto; margin-bottom: 100px;">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><em><%=gData.getId()%> &nbsp;&nbsp;&nbsp;&nbsp; <%=gData.getLofData()%></em></h3>
                    </div>
                    <table border="0" class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td width="50%">
                                    <table border="0" class="table table-striped">
                                        <tbody>
                                            <tr>
                                                <td width="40%"><strong>Purchase Order</strong></td>
                                                <% if (gData.getStyleType().equalsIgnoreCase("uk")) {%>
                                                <td><%=gData.getPurchaseOrderUk()%></td>
                                                <% } else if (gData.getStyleType().equalsIgnoreCase("ce")) {%>
                                                <td><%=gData.getPurchaseOrderCe()%></td>
                                                <% } else {%>
                                                <td><%=gData.getPurchaseOrderUk() + "/" + gData.getPurchaseOrderCe()%></td>
                                                <%}%>
                                            </tr>
                                            <tr>
                                                <td><strong>Web Order No</strong></td>
                                                <td><%=gData.getId()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>LOF No</strong></td>
                                                <td id="lof_data" ><%=gData.getLofData()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Style No</strong></td>
                                                <% if (gData.getStyleType().equalsIgnoreCase("uk")) {%>
                                                <td><%=gData.getStyleNoUk()%></td>
                                                <% } else if (gData.getStyleType().equalsIgnoreCase("ce")) {%>
                                                <td><%=gData.getStyleNoCe()%></td>
                                                <% } else {%>
                                                <td><%=gData.getStyleNoUk() + "/" + gData.getStyleNoCe()%></td>
                                                <%}%>

                                            </tr>
                                            <tr>
                                                <td><strong>Style Type</strong></td>
                                                <td style="text-transform: uppercase;" ><%=gData.getStyleType()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Supplier Code</strong></td>
                                                <td><%=gData.getSupplierCode()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Factory Code</strong></td>
                                                <td><%=gData.getFactoryCode()%></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td>
                                    <table border="0" class="table table-striped">
                                        <tbody>
                                            <tr>
                                                <td width="40%"><strong>Country of Origin</strong></td>
                                                <td><%=gData.getCountryOfOrigin()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Category</strong></td>
                                                <td><%=gData.getCategory()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Season Code</strong></td>
                                                <td><%=gData.getSeasonCode()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Brand</strong></td>
                                                <td><%=gData.getBrand()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Additional Comments</strong></td>
                                                <td><%=gData.getAdditionalComment()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Tog value</strong></td>
                                                <td><%=gData.getTogValue()%></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Customer PO</strong></td>
                                                <td><%=gData.getCustomerPo()%></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <%
                                if (tData.size() > 0) {
                            %>
                            <tr>
                                <td colspan="2"><strong><em>Concertina Labels</em></strong></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table border="0" width="100%">
                                        <tbody>
                                            <%
                                                for (LofLabeltechnicaldata techData : tData) {


                                            %>
                                            <tr>
                                                <td>
                                                    <table border="0" class="table table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th colspan="5">
                                                                    <%=techData.getReference()%> ( <%=techData.getPGroup()%> )
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="2"><strong>Label Description</strong></td>
                                                                <td colspan="3"><%=techData.getDescription()%></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Care Text</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (techData.getCareText() != null) {
                                                                    %>
                                                                    <%=techData.getCareText()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Fiber Composition 1</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (techData.getFibreComposition1() != null) {
                                                                    %>
                                                                    <%=techData.getFibreComposition1()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Fiber Composition 2</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (techData.getFibreComposition2() != null) {
                                                                    %>
                                                                    <%=techData.getFibreComposition2()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Fiber Composition 3</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (techData.getFibreComposition3() != null) {
                                                                    %>
                                                                    <%=techData.getFibreComposition3()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Fiber Composition 4</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (techData.getFibreComposition4() != null) {
                                                                    %>
                                                                    <%=techData.getFibreComposition4()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Fiber Composition 5</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (techData.getFibreComposition5() != null) {
                                                                    %>
                                                                    <%=techData.getFibreComposition5()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Fiber Composition 6</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (techData.getFibreComposition6() != null) {
                                                                    %>
                                                                    <%=techData.getFibreComposition6()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Address</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (techData.getAddress() != null) {
                                                                    %>
                                                                    <%=techData.getAddress()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <%
                                                                String wash = techData.getWashSymbol();
                                                                if (!wash.substring(0, 4).equals("W000")) {
                                                                    if (wash != null || wash.length() != 20) {
                                                                        String[] symbols = new String[5];
                                                                        symbols[0] = wash.substring(0, 4);
                                                                        symbols[1] = wash.substring(4, 8);
                                                                        symbols[2] = wash.substring(8, 12);
                                                                        symbols[3] = wash.substring(12, 16);
                                                                        symbols[4] = wash.substring(16, 20);
                                                            %>
                                                            <tr>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[0]%>.png" alt="Wash Image"/></td>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[1]%>.png" alt="Bleach Image"/></td>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[2]%>.png" alt="Dry Image"/></td>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[3]%>.png" alt="Iron Image"/></td>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[4]%>.png" alt="Dry Clean Image"/></td>
                                                            </tr>


                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><br/></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            <%
                                if (swingData.size() > 0) {
                            %>
                            <tr>
                                <td colspan="2"><strong><em>Swing Tickets</em></strong></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table border="0" width="100%">
                                        <tbody>
                                            <%
                                                for (LofSwingticletlabeldata swiData : swingData) {
                                            %>
                                            <tr>
                                                <td>
                                                    <table border="0" class="table table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th colspan="5">
                                                                    <%=swiData.getReference()%> ( <%=swiData.getLblGroup()%> )
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="2"><strong>Label Description</strong></td>
                                                                <td colspan="3"><%=swiData.getLblDescription()%></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Care Text</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (swiData.getCareText() != null) {
                                                                    %>
                                                                    <%=swiData.getCareText()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Trend Name</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (swiData.getTrendName() != null) {
                                                                    %>
                                                                    <%=swiData.getTrendName()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Product Benefit</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (swiData.getProductBenifit() != null) {
                                                                    %>
                                                                    <%=swiData.getProductBenifit()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2"><strong>Product Description</strong></td>
                                                                <td colspan="3">
                                                                    <%
                                                                        if (swiData.getProductDescription() != null) {
                                                                    %>
                                                                    <%=swiData.getProductDescription()%>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <%
                                                                    String wash = swiData.getWashSymbol();
                                                                    if (wash != null || wash.length() != 20) {
                                                                        String[] symbols = new String[5];
                                                                        symbols[0] = wash.substring(0, 4);
                                                                        symbols[1] = wash.substring(4, 8);
                                                                        symbols[2] = wash.substring(8, 12);
                                                                        symbols[3] = wash.substring(12, 16);
                                                                        symbols[4] = wash.substring(16, 20);
                                                                %>
                                                            <tr>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[0]%>.png" alt="Wash Image"/></td>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[1]%>.png" alt="Bleach Image"/></td>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[2]%>.png" alt="Dry Image"/></td>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[3]%>.png" alt="Iron Image"/></td>
                                                                <td colspan="1"><img class="img-responsive" src="/IEPTescoNew/img/symbols/<%=symbols[4]%>.png" alt="Dry Clean Image"/></td>
                                                            </tr>
                                                            <%
                                                                }
                                                            %>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><br/></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            <%
                                if (lt.size() > 0) {
                            %>
                            <tr>
                                <td colspan="2"><strong><em>EAN Details</em></strong></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table border="0" class="table table-striped table-bordered">
                                        <thead>
                                            <tr>
                                                <th rowspan="2" style="text-align: center; padding-bottom: 18px;">EAN Number</th>
                                                <th colspan="2" style="text-align: center; padding: 4px">Primary Size</th>
                                                <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Department</th>
                                                <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Quantity</th>
                                                <!--<th rowspan="2" style="text-align: center; padding-bottom: 18px;">Color</th>-->
                                                <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Sec Size 1</th>
                                                <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Sec Size 2</th>
                                                <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Sec Size 3</th>
                                                <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Sec Size 4</th>
                                            </tr>
                                            <tr>
                                                <th width="10%" style="text-align: center; padding: 4px">UK Size</th>
                                                <th width="10%" style="text-align: center; padding: 4px">CE Size</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (LofEandata eandata : lt) {
                                            %>
                                            <tr>
                                                <td style="text-align: center; vertical-align: middle;"><%=eandata.getEANNouk()%></td>
                                                <td style="text-align: center; vertical-align: middle;"><%=eandata.getUk()%></td>
                                                <td style="text-align: center; vertical-align: middle;"><%=eandata.getEur()%></td>
                                                <td style="text-align: center; vertical-align: middle;"><%=eandata.getDept()%></td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <%
                                                        if (eandata.getQuantity() != null) {
                                                    %>
                                                    <%=eandata.getQuantity()%>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <!--                                                <td style="text-align: center; vertical-align: middle;">
                                                <%
                                                    if (eandata.getColor() != null) {
                                                %>
                                                <%=eandata.getColor()%>
                                                <%
                                                    }
                                                %>
                                            </td>-->
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <%
                                                        if (eandata.getSecSize1() != null) {
                                                    %>
                                                    <%=eandata.getSecSize1()%>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <%
                                                        if (eandata.getSecSize2() != null) {
                                                    %>
                                                    <%=eandata.getSecSize2()%>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <%
                                                        if (eandata.getSecSize3() != null) {
                                                    %>
                                                    <%=eandata.getSecSize3()%>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <%
                                                        if (eandata.getSecSize4() != null) {
                                                    %>
                                                    <%=eandata.getSecSize4()%>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            <%
                                if (swingPrices != null) {
                            %>
                            <!--                            <tr>
                                                            <td colspan="2"><strong><em>Selling Prices</em></strong></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <table border="0" class="table table-striped table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Euro</th>
                                                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">Pound</th>
                                                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">CZ</th>
                                                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">SK</th>
                                                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">EN</th>
                                                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">HU</th>
                                                                            <th rowspan="2" style="text-align: center; padding-bottom: 18px;">TR</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="text-align: center; vertical-align: middle;">
                            <%
                                if (swingPrices.getEuro() != null) {
                            %>
                            <%=swingPrices.getEuro()%>
                            <%
                                }
                            %>
                        </td>
                        <td style="text-align: center; vertical-align: middle;">
                            <%
                                if (swingPrices.getPound() != null) {
                            %>
                            <%=swingPrices.getPound()%>
                            <%
                                }
                            %>
                        </td>
                        <td style="text-align: center; vertical-align: middle;">
                            <%
                                if (swingPrices.getCz() != null) {
                            %>
                            <%=swingPrices.getCz()%>
                            <%
                                }
                            %>
                        </td>
                        <td style="text-align: center; vertical-align: middle;">
                            <%
                                if (swingPrices.getSk() != null) {
                            %>
                            <%=swingPrices.getSk()%>
                            <%
                                }
                            %>
                        </td>
                        <td style="text-align: center; vertical-align: middle;">
                            <%
                                if (swingPrices.getEn() != null) {
                            %>
                            <%=swingPrices.getEn()%>
                            <%
                                }
                            %>
                        </td>
                        <td style="text-align: center; vertical-align: middle;">
                            <%
                                if (swingPrices.getHu() != null) {
                            %>
                            <%=swingPrices.getHu()%>
                            <%
                                }
                            %>
                        </td>
                        <td style="text-align: center; vertical-align: middle;">
                            <%
                                if (swingPrices.getTr() != null) {
                            %>
                            <%=swingPrices.getTr()%>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                </tbody>
            </table>
        </td>
    </tr>-->
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="Searching_Modal" class="modal fade" tabindex="-1" role="dialog" data-keyboard="false" data-backdrop="static">
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

        <div id="footer_div" >
            <div class=" navbar navbar-blend navbar-fixed-bottom">
                <div class="container-fluid" style="padding-top: 20px; color: #c0c0c0; font-size: 12px;">
                    <div class="pull-right">
                        <p class="">Impressions Labels (PVT) Ltd &copy; <span id="year"><em></em></span></p>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
<% } else {
        response.sendRedirect("LogoutController");
    }%>