/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class CreateXls extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        String val = request.getParameter("mail");
//
//        Check_lof chk = new Check_lof();
//
//        List<LofEandata> lt = chk.getEAN(val);
//        List<LofGeneraldata> gData = chk.getGeneralData(val);
//        List<LofLabeltechnicaldata> tData = chk.getLabeltechnicaldata(val);
//        List<LofSwingticletlabeldata> swingData = chk.getSwingdata(val);
//
//        String prefix = val;
//        String suffix = ".xls";
//
//        // this temporary file remains after the jvm exits
//        File tempFile = File.createTempFile(prefix, suffix);
//        System.out.format("Canonical filename: %s\n", tempFile.getCanonicalFile());
//
//        File path = tempFile.getCanonicalFile();
//
//        try {
//
//            String PurchaseOrder = "";
//            String Lof = "";
//
//            //String filename = "C:/Users/Chathura/Desktop/xxxxddd.xls";
//            HSSFWorkbook workbook = new HSSFWorkbook();
//            HSSFSheet sheet = workbook.createSheet("General Data");
//
//            HSSFRow rowhead = sheet.createRow((short) 0);
//            rowhead.createCell(0).setCellValue("purchase_order");
//            rowhead.createCell(1).setCellValue("category");
//            rowhead.createCell(2).setCellValue("country_of_origin");
//            rowhead.createCell(3).setCellValue("additional_comment");
//            rowhead.createCell(4).setCellValue("style_no");
//            rowhead.createCell(5).setCellValue("charactor_tf_des");
//            rowhead.createCell(6).setCellValue("season_code");
//            rowhead.createCell(7).setCellValue("brand");
//            rowhead.createCell(8).setCellValue("style_type");
//            rowhead.createCell(9).setCellValue("department");
//            rowhead.createCell(10).setCellValue("supplier_no");
//            rowhead.createCell(11).setCellValue("factory_code");
//            rowhead.createCell(12).setCellValue("lof_data");
//            rowhead.createCell(13).setCellValue("conf_order");
//
//            for (LofGeneraldata le : gData) {
//                HSSFRow row = sheet.createRow((short) 1);
//                row.createCell(0).setCellValue(le.getPurchaseOrder());
//                row.createCell(1).setCellValue(le.getCategory());
//                row.createCell(2).setCellValue(le.getCountryOfOrigin());
//                row.createCell(3).setCellValue(le.getAdditionalComment());
//                row.createCell(4).setCellValue(le.getStyleNo());
//                row.createCell(5).setCellValue(le.getCharactorTfDes());
//                row.createCell(6).setCellValue(le.getSeasonCode());
//                row.createCell(7).setCellValue(le.getBrand());
//                row.createCell(8).setCellValue(le.getStyleType());
//                row.createCell(9).setCellValue(le.getDepartment());
//                row.createCell(10).setCellValue(le.getSupplierNo());
//                row.createCell(11).setCellValue(le.getFactoryCode());
//                row.createCell(12).setCellValue(le.getLofData());
//                row.createCell(13).setCellValue(le.getConfOrder());
//
//                PurchaseOrder = le.getPurchaseOrder();
//                Lof = le.getLofData();
//            }
//
//            HSSFSheet sheet1 = workbook.createSheet("Technical Labels");
//
//            HSSFRow rowhead1 = sheet1.createRow((short) 0);
//            rowhead1.createCell(0).setCellValue("Label");
//            rowhead1.createCell(1).setCellValue("Reference");
//            rowhead1.createCell(2).setCellValue("Care Text");
//            rowhead1.createCell(3).setCellValue("Wash Symbol");
//            rowhead1.createCell(4).setCellValue("Fiber Composition 1");
//            rowhead1.createCell(5).setCellValue("Fiber Composition 2");
//            rowhead1.createCell(6).setCellValue("Fiber Composition 3");
//            rowhead1.createCell(7).setCellValue("Fiber Composition 4");
//            rowhead1.createCell(8).setCellValue("Group");
//            rowhead1.createCell(9).setCellValue("Description");
//
//            int i = 1;
//            for (LofLabeltechnicaldata lb : tData) {
//
//                HSSFRow row1 = sheet1.createRow((short) i);
//                row1.createCell(0).setCellValue(lb.getPLabel());
//                row1.createCell(1).setCellValue(lb.getReference());
//                row1.createCell(2).setCellValue(lb.getCareText());
//                row1.createCell(3).setCellValue(lb.getWashSymbol());
//                row1.createCell(4).setCellValue(lb.getFibreComposition1());
//                row1.createCell(5).setCellValue(lb.getFibreComposition2());
//                row1.createCell(6).setCellValue(lb.getFibreComposition3());
//                row1.createCell(7).setCellValue(lb.getFibreComposition4());
//                row1.createCell(8).setCellValue(lb.getPGroup());
//                row1.createCell(9).setCellValue(lb.getDescription());
//
//                i++;
//            }
//
//            HSSFSheet sheet2 = workbook.createSheet("SwingTicket Labels");
//            HSSFRow rowhead2 = sheet2.createRow((short) 0);
//
//            rowhead2.createCell(0).setCellValue("REFERENCE");
//            rowhead2.createCell(1).setCellValue("TREND_NAME");
//            rowhead2.createCell(2).setCellValue("PRODUCT_BENIFIT");
//            rowhead2.createCell(3).setCellValue("PRODUCT_DESCRIPTION");
//            rowhead2.createCell(4).setCellValue("SUPPLIER_ID");
//            rowhead2.createCell(5).setCellValue("JOB_NO");
//            rowhead2.createCell(6).setCellValue("CARE_TEXT");
//
//            int j = 1;
//            for (LofSwingticletlabeldata slb : swingData) {
//
//                HSSFRow row1 = sheet2.createRow((short) j);
//                row1.createCell(0).setCellValue(slb.getReference());
//                row1.createCell(1).setCellValue(slb.getTrendName());
//                row1.createCell(2).setCellValue(slb.getProductBenifit());
//                row1.createCell(3).setCellValue(slb.getProductDescription());
//                row1.createCell(4).setCellValue(slb.getSupplierId());
//                row1.createCell(5).setCellValue(slb.getJobNo());
//                row1.createCell(6).setCellValue(slb.getCareText());
//
//                j++;
//            }
//
//            HSSFSheet sheet3 = workbook.createSheet("EAN Data");
//            HSSFRow rowhead3 = sheet3.createRow((short) 0);
//
//            rowhead3.createCell(0).setCellValue("EAN No");
//            rowhead3.createCell(1).setCellValue("UK");
//            rowhead3.createCell(2).setCellValue("EUR");
//            rowhead3.createCell(3).setCellValue("US");
//            rowhead3.createCell(4).setCellValue("MX");
//            rowhead3.createCell(5).setCellValue("Sec Size1");
//            rowhead3.createCell(6).setCellValue("Sec Size2");
//            rowhead3.createCell(7).setCellValue("Sec Size3");
//            rowhead3.createCell(8).setCellValue("Sec Size4");
//            rowhead3.createCell(9).setCellValue("EURO");
//            rowhead3.createCell(10).setCellValue("POUNDS");
//            rowhead3.createCell(11).setCellValue("CZ");
//            rowhead3.createCell(12).setCellValue("SK");
//            rowhead3.createCell(13).setCellValue("PL");
//            rowhead3.createCell(14).setCellValue("HU");
//            rowhead3.createCell(15).setCellValue("TK");
//
//            int k = 1;
//            for (LofEandata en : lt) {
//
//                HSSFRow row1 = sheet3.createRow((short) k);
//                row1.createCell(0).setCellValue(en.getEANNo());
//                row1.createCell(1).setCellValue(en.getUk());
//                row1.createCell(2).setCellValue(en.getEur());
//                row1.createCell(3).setCellValue(en.getUs());
//                row1.createCell(4).setCellValue(en.getMx());
//                row1.createCell(5).setCellValue(en.getSecSize1());
//                row1.createCell(6).setCellValue(en.getSecSize2());
//                row1.createCell(7).setCellValue(en.getSecSize3());
//                row1.createCell(8).setCellValue(en.getSecSize4());
//                row1.createCell(9).setCellValue(en.getEuro());
//                row1.createCell(10).setCellValue(en.getPound());
//                row1.createCell(11).setCellValue(en.getCz());
//                row1.createCell(12).setCellValue(en.getSk());
//                row1.createCell(13).setCellValue(en.getEn());
//                row1.createCell(14).setCellValue(en.getHu());
//                row1.createCell(15).setCellValue(en.getTr());
//
//                k++;
//            }
//            FileOutputStream fileOut = new FileOutputStream(tempFile.getCanonicalFile());
//            workbook.write(fileOut);
//            fileOut.close();
        //Save in to Online Order Table
        /**
         *
         *
         */
//            Check_lof check_lof = new Check_lof();
//            OnlineOrder oo1 = check_lof.getOrderNumber();
//
//            Date date = new Date();
//            Calendar cal = Calendar.getInstance();
//            cal.setTime(date);
//            int year = cal.get(Calendar.YEAR);
//            String ONUM = "";
//            if (oo1 != null) {
//                String rUserId = oo1.getOrderNo();
//                String rUserIdArray[] = rUserId.split("_");
//                String tNo = rUserIdArray[1].trim();
//                int ia = Integer.parseInt(tNo);
//                ++ia;
//                if (ia < 10) {
//
//                    ONUM = "IMP" + year + "_00000" + (ia);
//                } else if (ia < 100) {
//
//                    ONUM = "IMP" + year + "_0000" + (ia);
//                } else if (ia < 1000) {
//
//                    ONUM = "IMP" + year + "_000" + (ia);
//                } else if (ia < 1000) {
//                    ONUM = "IMP" + year + "_00" + (ia);
//                } else if (ia < 10000) {
//                    ONUM = "IMP" + year + "_0" + (ia);
//                } else {
//                    ONUM = "IMP" + year + "_" + (ia);
//                }
//            } else {
//                ONUM = "IMP" + year + "_00000" + "1";
//            }
//
//            SimpleDateFormat ft = new SimpleDateFormat("E yyyy.MM.dd '@' hh:mm:ss a zzz");
//            String dateori = ft.format(date);
//
//            String arr[] = dateori.split("@");
//            String datenow = arr[0];
//            String timenow = arr[1];
//
//            OnlineOrder oo = new OnlineOrder();
//            oo.setOrderNo(ONUM);
//            oo.setOrderStatus("Order Confirmed");
//            oo.setOrderedDate(datenow);
//            oo.setOrderedTime(timenow);
//            oo.setPurchaseOrder(PurchaseOrder);
//
//            HttpSession session = request.getSession();
//            SysUser user = (SysUser) session.getAttribute("user");
//            String cus = user.getUsername();
//
//            SysUser su = new SysUser();
//            su.setUsername(cus);
//
//            LofGeneraldata generaldata = new LofGeneraldata();
//            generaldata.setLofData(Lof);
//
//            oo.setWebOrderNo(generaldata);
//            oo.setSysUser(user);
//
//            String result = check_lof.saveOrder(oo);
//            RequestDispatcher requestDispatcher;
//            if (result.equals(ImpressionConstants.SUCCESS)) {
//                request.setAttribute("SUCCESS_MESSAGE", "Successfully registared");
//                requestDispatcher = request.getRequestDispatcher("admin.jsp");
//                requestDispatcher.forward(request, response);
//            } else {
//                request.setAttribute("ERROR_MESSAGE", "Please try again");
//                requestDispatcher = request.getRequestDispatcher("copy_forgot.jsp");
//                requestDispatcher.forward(request, response);
//
//            }

//        } catch (Exception ex) {
//            System.out.println(ex);
//
//        }
//
//        response.getWriter().write(path.getAbsolutePath());
//    }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
