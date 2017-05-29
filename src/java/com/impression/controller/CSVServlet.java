/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.Check_lof;
import com.impression.hibe.model.LofEandata;
import com.impression.hibe.model.LofGeneraldata;
import com.impression.hibe.model.LofLabeltechnicaldata;
import com.impression.hibe.model.LofSwingticletlabeldata;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Sandun
 */
public class CSVServlet extends HttpServlet {

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

        JSONObject jo = null;
        JSONArray ja = new JSONArray();
        JSONObject ge = null;
        JSONArray gen = new JSONArray();
        JSONObject te = null;
        JSONArray tec = new JSONArray();
        JSONObject sw = null;
        JSONArray swi = new JSONArray();
        String all = "";

        try {
            String m = request.getParameter("id");
            String val = request.getParameter("val");

            String json1 = null;
            String json2 = null;
            String json3 = null;
            String json4 = null;
            
            Check_lof chk = new Check_lof();

            List<LofGeneraldata> gData = chk.getGeneralData(val);

            int web_order = 0;

            for (LofGeneraldata le : gData) {
                ge = new JSONObject();

                ge.put("purchase_order", le.getPurchaseOrderUk());
                ge.put("category", le.getCategory());
                ge.put("country_of_origin", le.getCountryOfOrigin());
                ge.put("additional_comment", le.getAdditionalComment());
                ge.put("style_no", le.getStyleNoUk());
                ge.put("charactor_tf_des", le.getCharactorTfDes());
                ge.put("season_code", le.getSeasonCode());
                ge.put("brand", le.getBrand());
                ge.put("style_type", le.getStyleType());
                ge.put("department", le.getDepartment());
                ge.put("supplier_no", le.getSupplierNo());
                ge.put("factory_code", le.getFactoryCode());
                ge.put("lof_data", le.getLofData());
                ge.put("conf_order", le.getConfOrder());
                ge.put("customer", le.getCustomer().getCustomerId());
                ge.put("tog_value", le.getTogValue());
                ge.put("customer_po", le.getCustomerPo());

                web_order = le.getWebOrderNo();

                gen.add(ge);
            }

            List<LofEandata> lt = chk.getEAN(web_order);

            List<LofLabeltechnicaldata> tData = chk.getLabeltechnicaldata(web_order);
            List<LofSwingticletlabeldata> swingData = chk.getSwingdata(web_order);

            for (LofEandata le : lt) {
                jo = new JSONObject();

                jo.put("EAN_No", le.getEANNouk());
                jo.put("UK", le.getUk());
                jo.put("EUR", le.getEur());
                jo.put("US", le.getUs());
                jo.put("MX", le.getMx());
                jo.put("Sec_Size1", le.getSecSize1());
                jo.put("Sec_Size2", le.getSecSize2());
                jo.put("Sec_Size3", le.getSecSize3());
                jo.put("Sec_Size4", le.getSecSize4());
                jo.put("Euro", le.getEuro());
                jo.put("pound", le.getPound());
                jo.put("CZ", le.getCz());
                jo.put("SK", le.getSk());
                jo.put("PL", le.getEn());
                jo.put("HU", le.getHu());
                jo.put("TK", le.getTr());

                ja.add(jo);
            }

            for (LofLabeltechnicaldata ltd : tData) {

                te = new JSONObject();

                te.put("PLabel", ltd.getPLabel());
                te.put("Reference", ltd.getReference());
                te.put("Address", ltd.getAddress());
                te.put("Care_Text", ltd.getCareText());
                te.put("Wash_Symbol", ltd.getWashSymbol());
                te.put("Fibre_Composition_1", ltd.getFibreComposition1());
                te.put("Fibre_Composition_2", ltd.getFibreComposition2());
                te.put("Fibre_Composition_3", ltd.getFibreComposition3());
                te.put("Fibre_Composition_4", ltd.getFibreComposition4());
                te.put("Fibre_Composition_5", ltd.getFibreComposition5());
                te.put("Fibre_Composition_6", ltd.getFibreComposition6());
                te.put("PGroup", ltd.getPGroup());
                te.put("Description", ltd.getDescription());

                tec.add(te);
            }
            for (LofSwingticletlabeldata std : swingData) {
                sw = new JSONObject();

                sw.put("REFERENCE", std.getReference());
                sw.put("TREND_NAME", std.getTrendName());
                sw.put("PRODUCT_BENIFIT", std.getProductBenifit());
                sw.put("PRODUCT_DESCRIPTION", std.getProductDescription());
                sw.put("SUPPLIER_ID", std.getSupplierId());
                sw.put("JOB_NO", std.getJobNo());
                sw.put("CARE_TEXT", std.getCareText());

                swi.add(sw);
            }
            String gen_d = ge.toString();
            String lbl_d = tec.toString();
            String sw_d = swi.toString();
            String ean_d = ja.toString();

            all = gen_d + "#" + lbl_d + "#" + sw_d + "#" + ean_d;

            response.getWriter().write(all);
        } catch (Exception ex) {
            Logger.getLogger(CSVServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
