/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.Check_lof;
import com.impression.dao.UserDAO;
import com.impression.hibe.model.Customer;

import com.impression.hibe.model.LofEandata;
import com.impression.hibe.model.LofGeneraldata;
import com.impression.hibe.model.LofLabeltechnicaldata;
import com.impression.hibe.model.LofSwingticletlabeldata;
import com.impression.hibe.model.SysUser;
import com.impression.util.NewHibernateUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author User
 */
public class SavePdf extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

        RequestDispatcher requestDispatcher = null;

        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession();
            SysUser user = (SysUser) session.getAttribute("user");

            Customer c = new UserDAO().getUserdetailsss(user.getUsername());

            Customer c1 = new Customer();

            c1.setCustomerId(c.getCustomerId());

            String jsonString = request.getParameter("data");
            jsonString = jsonString.replaceAll("kbgz", "&");

            JSONParser parser = new JSONParser();

            Object obj;

            Check_lof check_lof = new Check_lof();

            LofGeneraldata oo1 = check_lof.getOrderNumber();

            //set order date----------------------------------------------------
            Date date = new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            //------------------------------------------------------------------

            int year = cal.get(Calendar.YEAR);
            String ONUM = "";
            String lofID = "";
            if (oo1 != null) {
                String rUserId = oo1.getId();
                String rUserIdArray[] = rUserId.split("_");
                String tNo = rUserIdArray[1].trim();
                int ia = Integer.parseInt(tNo);
                ++ia;
                if (ia < 10) {
                    ONUM = "IMP" + year + "_00000" + (ia);
                    lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "00000" + ia + "_1";
                } else if (ia < 100) {
                    ONUM = "IMP" + year + "_0000" + (ia);
                    lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "0000" + ia + "_1";
                } else if (ia < 1000) {
                    ONUM = "IMP" + year + "_000" + (ia);
                    lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "000" + ia + "_1";
                } else if (ia < 10000) {
                    ONUM = "IMP" + year + "_00" + (ia);
                    lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "00" + ia + "_1";
                } else if (ia < 100000) {
                    ONUM = "IMP" + year + "_0" + (ia);
                    lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "0" + ia + "_1";
                } else {
                    ONUM = "IMP" + year + "_" + (ia);
                    lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + ia + "_1";
                }
            } else {
                ONUM = "IMP" + year + "_00000" + "1";
                lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "000001_1";
            }

            try {
                obj = parser.parse(jsonString);
                JSONObject jSONObject = (JSONObject) obj;

//set general data---------------------------------------------------------
                //set customerId using session
                LofGeneraldata lofGeneraldata = new LofGeneraldata(
                        ONUM,
                        jSONObject.get("purchase_order_uk").toString(),
                        jSONObject.get("purchase_order_ce").toString(),
                        jSONObject.get("category").toString(),
                        jSONObject.get("country_of_origin").toString(),
                        jSONObject.get("comments").toString(),
                        jSONObject.get("style_no_uk").toString(),
                        jSONObject.get("style_no_ce").toString(),
                        //                        jSONObject.get("char_description").toString(),
                        jSONObject.get("season_code").toString(),
                        jSONObject.get("Brand").toString(),
                        jSONObject.get("style_type").toString(),
                        user.getCompanyId().getCompanyCode().toString(),
                        jSONObject.get("supplier_number").toString(),
                        jSONObject.get("factory_code").toString(),
                        lofID,
                        "NAR",
                        //                        jSONObject.get("carton_dimensions").toString(),
                        date,
                        c1,
                        jSONObject.get("customer_po").toString(),
                        jSONObject.get("customer_po").toString()
                );

//set selling prices --------------------------------------------------------------------------------------------   
                String catID = "";
                String cz = "";
                String sk = "";
                String en = "";
                String hu = "";
                String tr = "";
                String pound = "";
                String euro = "";

                JSONObject selling_prices = (JSONObject) jSONObject.get("selling_prices");

                if (!selling_prices.isEmpty()) {

                    catID = selling_prices.get("id").toString();

                    if (catID.equals("1")) {
                        cz = selling_prices.get("cz").toString();
                        sk = selling_prices.get("sk").toString();
                        en = selling_prices.get("en").toString();
                        hu = selling_prices.get("hu").toString();
                        tr = selling_prices.get("tr").toString();
                    } else {
                        pound = selling_prices.get("pound").toString();
                        euro = selling_prices.get("euro").toString();
                    }
                }

//End selling prices -------------------------------------------------------------------------------------------- 
//Set LofEandata ------------------------------------------------------------------------------------------------      
                JSONObject ean_details = (JSONObject) jSONObject.get("ean_details");
                Collection<LofEandata> eanData = new ArrayList<>();
                for (Iterator iterator = ean_details.keySet().iterator(); iterator.hasNext();) {

                    String key = (String) iterator.next();
                    JSONObject jSONObject1 = (JSONObject) ean_details.get(key);
                    String qun = jSONObject1.get("quantity").toString();
                    int quntity = 0;
                    if (qun.isEmpty() || qun.equals("")) {

                    } else {
                        quntity = Integer.parseInt(qun);
                    }
                    LofEandata lofEandata = lofEandata = new LofEandata();

                    lofEandata.setEANNouk(jSONObject1.get("uk_ean").toString());
                    lofEandata.setUk(jSONObject1.get("uk_size").toString());
                    lofEandata.setEur(jSONObject1.get("ce_size").toString());
                    lofEandata.setDept(jSONObject1.get("department").toString());
                    lofEandata.setColor(jSONObject1.get("color").toString());
                    lofEandata.setQuantity(quntity);

                    JSONArray secSize = (JSONArray) jSONObject1.get("secSize");
                    lofEandata.setSecSize1("");
                    lofEandata.setSecSize2("");
                    lofEandata.setSecSize3("");
                    lofEandata.setSecSize4("");
                    if (secSize != null) {
                        String[] secSizeArry = new String[4];

                        for (int i = 0; i < secSize.size(); i++) {
                            secSizeArry[i] = secSize.get(i).toString();
                        }

                        lofEandata.setSecSize1(secSizeArry[0]);
                        lofEandata.setSecSize2(secSizeArry[1]);
                        lofEandata.setSecSize3(secSizeArry[2]);
                        lofEandata.setSecSize4(secSizeArry[3]);
                    }

                    lofEandata.setEn(en);
                    lofEandata.setCz(cz);
                    lofEandata.setSk(sk);
                    lofEandata.setTr(tr);
                    lofEandata.setHu(hu);
                    lofEandata.setPound(pound);
                    lofEandata.setEuro(euro);

                    lofEandata.setWebOrderNo(lofGeneraldata);
                    eanData.add(lofEandata);
                }
                lofGeneraldata.setLofEandataCollection(eanData);
//End set LofEandata --------------------------------------------------------------------------------------------  

//set technical details------------------------------------------------------------------------------------------- 
                JSONObject technical_labels = (JSONObject) jSONObject.get("technical_labels");
                Collection<LofLabeltechnicaldata> labelDetailsCollection = new ArrayList<>();
                LofLabeltechnicaldata technicalDetails = new LofLabeltechnicaldata();

                for (Iterator iterator = technical_labels.keySet().iterator(); iterator.hasNext();) {
                    String techKey = (String) iterator.next();
                    JSONObject techLabel = (JSONObject) technical_labels.get(techKey);

                    String careText = "";
                    String washSymbol = "";

                    String fiberCompo[] = new String[4];
                    JSONObject technical_fiber = (JSONObject) techLabel.get("temp_technical_fiber");
                    int i = 0;
                    for (Iterator tec_fiber_Iterator = technical_fiber.keySet().iterator(); tec_fiber_Iterator.hasNext();) {

                        String techFiberkey = (String) tec_fiber_Iterator.next();

                        String data = technical_fiber.get(techFiberkey).toString();
                        fiberCompo[i] = data.replaceAll("ZXZY", "%");
                        i++;
                    }

                    careText = techLabel.get("temp_technical_care").toString();
                    washSymbol = techLabel.get("tech_wash_symbol").toString();
                    technicalDetails.setDescription(techLabel.get("tech_lbl_des").toString());
                    technicalDetails.setPGroup(techLabel.get("tech_labelGroup").toString());
                    technicalDetails.setReference(techLabel.get("tech_labelRef").toString());
                    technicalDetails.setPLabel("Technical Label");
                    technicalDetails.setCareText(careText);
                    technicalDetails.setFibreComposition1(fiberCompo[0]);
                    technicalDetails.setFibreComposition2(fiberCompo[1]);
                    technicalDetails.setFibreComposition3(fiberCompo[2]);
                    technicalDetails.setFibreComposition4(fiberCompo[3]);
                    technicalDetails.setWashSymbol(washSymbol);
                    technicalDetails.setWebOrderNo(lofGeneraldata);

                    labelDetailsCollection.add(technicalDetails);
                }
                lofGeneraldata.setLofLabeltechnicaldataCollection(labelDetailsCollection);
//End technical details --------------------------------------------------------------------------------------------

//Set swing ticket  ------------------------------------------------------------------------------------------------
                Collection<LofSwingticletlabeldata> swingCollection = new ArrayList<>();
                JSONObject swing_tickets = (JSONObject) jSONObject.get("swing_tickets");

                if (swing_tickets != null) {

                    for (Iterator swing_tickets_iterator = swing_tickets.keySet().iterator(); swing_tickets_iterator.hasNext();) {
                        String swing_careText = "";
//                        swing_careText = technical_labels.get("temp_swing_care").toString();

                        LofSwingticletlabeldata lofSwingticletlabeldata = new LofSwingticletlabeldata();

                        String swing_tickets_key = (String) swing_tickets_iterator.next();

                        JSONObject swing_tickets_JSONObject1 = (JSONObject) swing_tickets.get(swing_tickets_key);
                        swing_careText = swing_tickets_JSONObject1.get("temp_swing_care").toString();
                        lofSwingticletlabeldata = new LofSwingticletlabeldata(
                                swing_tickets_JSONObject1.get("swing_labelRef").toString(),
                                swing_tickets_JSONObject1.get("trend_name").toString(),
                                swing_tickets_JSONObject1.get("product_benefit").toString(),
                                swing_tickets_JSONObject1.get("product_description").toString(),
                                swing_careText,
                                "Swing Ticket",
                                swing_tickets_JSONObject1.get("swing_labelGroup").toString(),
                                swing_tickets_JSONObject1.get("swing_lbl_des").toString(),
                                swing_tickets_JSONObject1.get("swing_wash_symbol").toString(),
                                lofGeneraldata
                        );
                        swingCollection.add(lofSwingticletlabeldata);
                    }
                    lofGeneraldata.setLofSwingticletlabeldataCollection(swingCollection);
                }
//End swing ticket  ------------------------------------------------------------------------------------------------

                Session s = NewHibernateUtil.getSessionFactory().openSession();
                Transaction t = s.beginTransaction();
                s.save(lofGeneraldata);
                t.commit();
                // System.out.println("Success");
                request.getSession().setAttribute("lof_data", lofID);
                response.getWriter().write("1");
            } catch (ParseException ex) {
                Logger.getLogger(SavePdf.class.getName()).log(Level.SEVERE, null, ex);
                // System.out.println("Error");
                response.getWriter().write("0");
            }
        } catch (Exception e) {
            Logger.getLogger(SavePdf.class.getName()).log(Level.SEVERE, null, e);
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
