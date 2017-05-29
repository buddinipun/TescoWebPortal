/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.EditLOFDetailsDao;
import com.impression.hibe.model.LofEandata;
import com.impression.hibe.model.LofGeneraldata;
import com.impression.hibe.model.LofLabeltechnicaldata;
import com.impression.hibe.model.LofSwingticletlabeldata;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Oshan Lahiru
 */
public class EditLOFDetails extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String actionType = request.getParameter("actionType");
            RequestDispatcher requestDispatcher;

            if ("getLOFDetails".equals(actionType)) {

                String webOrderNo = request.getParameter("reviewID");
                // System.out.println("Review Id : " + webOrderNo);
                EditLOFDetailsDao editLOFDetailsDao = new EditLOFDetailsDao();
                LofGeneraldata lofData = editLOFDetailsDao.getLofDetails(webOrderNo);

                JSONObject orderObject = new JSONObject();

                orderObject.put("id", lofData.getWebOrderNo());
                orderObject.put("webOrder", lofData.getId());
                orderObject.put("Brand", lofData.getBrand());
                orderObject.put("carton_dimensions", lofData.getCartoonDimention());
                orderObject.put("category", lofData.getCategory());
                orderObject.put("char_description", lofData.getCharactorTfDes());
                orderObject.put("comments", lofData.getAdditionalComment());
                orderObject.put("country_of_origin", lofData.getCountryOfOrigin());
                orderObject.put("factory_code", lofData.getFactoryCode());
                orderObject.put("purchase_order_uk", lofData.getPurchaseOrderUk());
                orderObject.put("purchase_order_ce", lofData.getPurchaseOrderCe());
                orderObject.put("season_code", lofData.getSeasonCode());
                orderObject.put("style_no_uk", lofData.getStyleNoUk());
                orderObject.put("style_no_ce", lofData.getStyleNoCe());
                orderObject.put("conf_order", lofData.getConfOrder());
                orderObject.put("style_type", lofData.getStyleType());
                orderObject.put("customer_po", lofData.getCustomerPo());

                JSONObject ean = new JSONObject();
                JSONObject sellingPrice = null;

                for (LofEandata eanDetail : lofData.getLofEandataCollection()) {

                    JSONObject eanDetails = new JSONObject();

                    eanDetails.put("color", eanDetail.getColor());
                    eanDetails.put("department", eanDetail.getDept());
                    eanDetails.put("ean_no", eanDetail.getEANNouk());
                    eanDetails.put("primary_size_uk", eanDetail.getUk());
                    eanDetails.put("primary_size_ce", eanDetail.getEur());
                    eanDetails.put("count", eanDetail.getCount());
                    eanDetails.put("quantity", eanDetail.getQuantity());

                    JSONArray secSize = new JSONArray();

                    if (eanDetail.getSecSize1() != null) {
                        secSize.add(eanDetail.getSecSize1());
                    }
                    if (eanDetail.getSecSize2() != null) {
                        secSize.add(eanDetail.getSecSize2());
                    }
                    if (eanDetail.getSecSize3() != null) {
                        secSize.add(eanDetail.getSecSize3());
                    }
                    if (eanDetail.getSecSize4() != null) {
                        secSize.add(eanDetail.getSecSize4());
                    }

                    eanDetails.put("secSize", secSize);
                    ean.put(eanDetail.getEANNouk(), eanDetails);

                    sellingPrice = new JSONObject();
                    sellingPrice.put("cz", eanDetail.getCz());
                    sellingPrice.put("en", eanDetail.getEn());
                    sellingPrice.put("hu", eanDetail.getHu());
                    sellingPrice.put("sk", eanDetail.getSk());
                    sellingPrice.put("tr", eanDetail.getTr());
                    sellingPrice.put("euro", eanDetail.getEuro());
                    sellingPrice.put("pound", eanDetail.getPound());
                }

                JSONObject swingticketDetails = new JSONObject();
                String[] swingArray = new String[100];
                for (LofSwingticletlabeldata swTicketDetail : lofData.getLofSwingticletlabeldataCollection()) {

                    JSONObject swingticketDetail = new JSONObject();

                    boolean isExit = true;
                    int ran = 0;
                    while (isExit) {
                        Random r = new Random();
                        int low = 1;
                        int high = 100;
                        ran = r.nextInt(high - low) + low;
                        String id = ran + "";
                        if (swingticketDetails.size() == 0) {
                            swingArray[0] = id;
                            isExit = false;
                        } else {
                            int cnt = swingticketDetails.size();
                            for (String lblkey : swingArray) {
                                if (!id.equalsIgnoreCase(lblkey)) {
                                    isExit = false;
                                    swingArray[cnt] = id;
                                }
                                if (!isExit) {
                                    break;
                                }
                            }
                        }
                    }

                    swingticketDetail.put("swing_key", ran);
                    swingticketDetail.put("product_benefit", swTicketDetail.getProductBenifit());
                    swingticketDetail.put("product_description", swTicketDetail.getProductDescription());
                    swingticketDetail.put("swing_labelGroup", swTicketDetail.getLblGroup());
                    swingticketDetail.put("swing_labelRef", swTicketDetail.getReference());
                    swingticketDetail.put("swing_lbl_des", swTicketDetail.getLblDescription());
                    swingticketDetail.put("swing_wash_symbol", swTicketDetail.getWashSymbol());
                    swingticketDetail.put("temp_swing_care", swTicketDetail.getCareText());
                    swingticketDetail.put("trend_name", swTicketDetail.getTrendName());
                    swingticketDetail.put("count", swTicketDetail.getCount());
                    swingticketDetails.put(ran, swingticketDetail);
                }

                JSONObject technicallabelDetails = new JSONObject();
                String[] techArray = new String[100];
                for (LofLabeltechnicaldata techlLabelDetail : lofData.getLofLabeltechnicaldataCollection()) {

                    JSONObject technicallabelDetail = new JSONObject();

                    boolean isExit = true;
                    int ran = 0;
                    while (isExit) {
                        Random r = new Random();
                        int low = 1;
                        int high = 100;
                        ran = r.nextInt(high - low) + low;
                        String id = ran + "";
                        if (technicallabelDetails.size() == 0) {
                            techArray[0] = id;
                            isExit = false;
                        } else {
                            int cnt = technicallabelDetails.size();
                            for (String lblkey : techArray) {
                                if (!id.equalsIgnoreCase(lblkey)) {
                                    isExit = false;
                                    techArray[cnt] = id;
                                }
                                if (!isExit) {
                                    break;
                                }
                            }
                        }
                    }

                    technicallabelDetail.put("tech_key", ran);
                    technicallabelDetail.put("tech_labelGroup", techlLabelDetail.getPGroup());
                    technicallabelDetail.put("tech_labelRef", techlLabelDetail.getReference());
                    technicallabelDetail.put("tech_lbl_des", techlLabelDetail.getDescription());
                    technicallabelDetail.put("tech_wash_symbol", techlLabelDetail.getWashSymbol());
                    technicallabelDetail.put("temp_technical_care", techlLabelDetail.getCareText());
                    technicallabelDetail.put("count", techlLabelDetail.getCounter());

                    JSONArray fiberComposition = new JSONArray();

                    if (techlLabelDetail.getFibreComposition1() != null) {
                        String f1 = techlLabelDetail.getFibreComposition1();
                        f1 = f1.replaceAll("%", "ZXZY");
                        fiberComposition.add(f1);
                    }
                    if (techlLabelDetail.getFibreComposition2() != null) {
                        String f1 = techlLabelDetail.getFibreComposition2();
                        f1 = f1.replaceAll("%", "ZXZY");
                        fiberComposition.add(f1);
                    }
                    if (techlLabelDetail.getFibreComposition3() != null) {
                        String f1 = techlLabelDetail.getFibreComposition3();
                        f1 = f1.replaceAll("%", "ZXZY");
                        fiberComposition.add(f1);
                    }
                    if (techlLabelDetail.getFibreComposition4() != null) {
                        String f1 = techlLabelDetail.getFibreComposition4();
                        f1 = f1.replaceAll("%", "ZXZY");
                        fiberComposition.add(f1);
                    }
                    technicallabelDetail.put("temp_technical_fiber", fiberComposition);
                    technicallabelDetails.put(ran, technicallabelDetail);

                }

                orderObject.put("ean_details", ean);
                orderObject.put("selling_prices", sellingPrice);
                orderObject.put("swing_tickets", swingticketDetails);
                orderObject.put("technical_labels", technicallabelDetails);

                response.getWriter().write(orderObject.toString());

            } else if ("deleteLOFTechDetails".equals(actionType)) {

                String idStr = request.getParameter("techID");

                // System.out.println("idStr HIK HIK : " + idStr);
                int id = Integer.parseInt(idStr);

                EditLOFDetailsDao elofdd = new EditLOFDetailsDao();
                int message = elofdd.deleteLofTechDetails(id);

                // System.out.println("message : " + message);
                JSONObject messageObject = new JSONObject();
                if (message == 1) {

                    messageObject.put("success", "Successfuly Deleted.");

                } else {
                    messageObject.put("success", "Try Again.");
                }

                response.getWriter().write(messageObject.toString());

            } else if ("deleteLOFSwingDetails".equals(actionType)) {

                String idStr = request.getParameter("swingID");

                int id = Integer.parseInt(idStr);

                EditLOFDetailsDao elofdd = new EditLOFDetailsDao();
                int message = elofdd.deleteLofSwingDetails(id);

                // System.out.println("message : " + message);
                JSONObject messageObject = new JSONObject();
                if (message == 1) {

                    messageObject.put("success", "Successfuly Deleted.");

                } else {
                    messageObject.put("success", "Try Again.");
                }

                response.getWriter().write(messageObject.toString());

            } else if ("updateLOFDetails".equals(actionType)) {
//
////===============================================================================================================
////===============================================================================================================
////===============================================================================================================
//                HttpSession session = request.getSession();
//                SysUser user = (SysUser) session.getAttribute("user");
//
//                Customer c = new UserDAO().getUserdetailsss(user.getUsername());
//
//                Customer c1 = new Customer();
//                c1.setCustomerId(c.getCustomerId());
//
//                String jsonString = request.getParameter("data");
//                System.out.println("jsonString :" + jsonString);
//
//                JSONParser parser = new JSONParser();
//
//                Object obj;
//
//                Check_lof check_lof = new Check_lof();
//
//                LofGeneraldata oo1 = check_lof.getOrderNumber();
//
//                //set order date----------------------------------------------------
//                Date date = new Date();
//                Calendar cal = Calendar.getInstance();
//                cal.setTime(date);
//                //------------------------------------------------------------------
//
//                int year = cal.get(Calendar.YEAR);
//
//                try {
//                    obj = parser.parse(jsonString);
//                    JSONObject jSONObject = (JSONObject) obj;
//
//                    int webId = Integer.parseInt(jSONObject.get("webId").toString());
//
////set general data---------------------------------------------------------
//                    //set customerId using session
//                    LofGeneraldata lofGeneraldata = new LofGeneraldata(
//                            webId,
//                            jSONObject.get("orderId").toString(),
//                            jSONObject.get("purchase_order").toString(),
//                            jSONObject.get("category").toString(),
//                            jSONObject.get("country_of_origin").toString(),
//                            jSONObject.get("comments").toString(),
//                            jSONObject.get("style_No").toString(),
//                            jSONObject.get("char_description").toString(),
//                            jSONObject.get("season_code").toString(),
//                            jSONObject.get("Brand").toString(),
//                            null,
//                            jSONObject.get("supplier_number").toString(),
//                            jSONObject.get("factory_code").toString(),
//                            jSONObject.get("lofno").toString(),
//                            "NAR",
//                            jSONObject.get("carton_dimensions").toString(),
//                            c1,
//                            date
//                    );
//
////set selling prices --------------------------------------------------------------------------------------------   
//                    String catID = "";
//                    String cz = "";
//                    String sk = "";
//                    String en = "";
//                    String hu = "";
//                    String tr = "";
//                    String pound = "";
//                    String euro = "";
//
//                    JSONObject selling_prices = (JSONObject) jSONObject.get("selling_prices");
//
//                    if (!selling_prices.isEmpty()) {
//
//                        catID = selling_prices.get("id").toString();
//
//                        if (catID.equals("1")) {
//                            cz = selling_prices.get("cz").toString();
//                            sk = selling_prices.get("sk").toString();
//                            en = selling_prices.get("en").toString();
//                            hu = selling_prices.get("hu").toString();
//                            tr = selling_prices.get("tr").toString();
//                        } else {
//                            pound = selling_prices.get("pound").toString();
//                            euro = selling_prices.get("euro").toString();
//                        }
//                    }
//
////End selling prices -------------------------------------------------------------------------------------------- 
////Set LofEandata ------------------------------------------------------------------------------------------------      
//                    JSONObject ean_details = (JSONObject) jSONObject.get("ean_details");
//                    Collection<LofEandata> eanData = new ArrayList<>();
//                    for (Iterator iterator = ean_details.keySet().iterator(); iterator.hasNext();) {
//
//                        String key = (String) iterator.next();
//                        JSONObject jSONObject1 = (JSONObject) ean_details.get(key);
//                        String qun = jSONObject1.get("quantity").toString();
//                        int quntity = 0;
//                        if (qun.isEmpty() || qun.equals("")) {
//
//                        } else {
//                            quntity = Integer.parseInt(qun);
//                        }
//                        LofEandata lofEandata = lofEandata = new LofEandata();
//
//                        int count = Integer.parseInt(jSONObject1.get("count").toString());
//
//                        lofEandata.setCount(count);
//                        lofEandata.setEANNo(jSONObject1.get("ean_no").toString());
//                        lofEandata.setUk(jSONObject1.get("primary_size").toString());
//                        lofEandata.setDept(jSONObject1.get("department").toString());
//                        lofEandata.setColor(jSONObject1.get("color").toString());
//                        lofEandata.setQuantity(quntity);
//
//                        JSONArray secSize = (JSONArray) jSONObject1.get("secSize");
//
//                        String[] secSizeArry = new String[4];
//
//                        for (int i = 0; i < secSize.size(); i++) {
//                            secSizeArry[i] = secSize.get(i).toString();
//                        }
//
//                        lofEandata.setSecSize1(secSizeArry[0]);
//                        lofEandata.setSecSize2(secSizeArry[1]);
//                        lofEandata.setSecSize3(secSizeArry[2]);
//                        lofEandata.setSecSize4(secSizeArry[3]);
//
//                        lofEandata.setEn(en);
//                        lofEandata.setCz(cz);
//                        lofEandata.setSk(sk);
//                        lofEandata.setTr(tr);
//                        lofEandata.setHu(hu);
//                        lofEandata.setPound(pound);
//                        lofEandata.setEuro(euro);
//                        lofEandata.setWebOrderNo(lofGeneraldata);
//
//                        eanData.add(lofEandata);
//                    }
//                    lofGeneraldata.setLofEandataCollection(eanData);
////End set LofEandata --------------------------------------------------------------------------------------------  
//
////set technical details------------------------------------------------------------------------------------------- 
//                    JSONObject technical_labels = (JSONObject) jSONObject.get("technical_labels");
//                    Collection<LofLabeltechnicaldata> labelDetailsCollection = new ArrayList<>();
//                    LofLabeltechnicaldata technicalDetails = new LofLabeltechnicaldata();
//
//                    for (Iterator iterator = technical_labels.keySet().iterator(); iterator.hasNext();) {
//                        String techKey = (String) iterator.next();
//                        JSONObject techLabel = (JSONObject) technical_labels.get(techKey);
//
//                        String careText = "";
//                        String washSymbol = "";
//
//                        String fiberCompo[] = new String[4];
//                        JSONObject technical_fiber = (JSONObject) techLabel.get("temp_technical_fiber");
//                        int i = 0;
//
//                        for (Iterator tec_fiber_Iterator = technical_fiber.keySet().iterator(); tec_fiber_Iterator.hasNext();) {
//
//                            String techFiberkey = (String) tec_fiber_Iterator.next();
//                            String data = technical_fiber.get(techFiberkey).toString();
//                            fiberCompo[i] = data.replaceAll("ZXZY", "%");
//                            i++;
//
//                        }
//
//                        careText = techLabel.get("temp_technical_care").toString();
//                        washSymbol = techLabel.get("tech_wash_symbol").toString();
//                        int count = Integer.parseInt(techLabel.get("count").toString());
//
//                        technicalDetails.setCount(count);
//                        technicalDetails.setDescription(techLabel.get("tech_lbl_des").toString());
//                        technicalDetails.setPGroup(techLabel.get("tech_labelGroup").toString());
//                        technicalDetails.setReference(techLabel.get("tech_labelRef").toString());
//                        technicalDetails.setPLabel("Technical Label");
//                        technicalDetails.setCareText(careText);
//                        technicalDetails.setFibreComposition1(fiberCompo[0]);
//                        technicalDetails.setFibreComposition2(fiberCompo[1]);
//                        technicalDetails.setFibreComposition3(fiberCompo[2]);
//                        technicalDetails.setFibreComposition4(fiberCompo[3]);
//                        technicalDetails.setWashSymbol(washSymbol);
//                        technicalDetails.setWebOrderNo(lofGeneraldata);
//
//                        labelDetailsCollection.add(technicalDetails);
//                    }
//                    lofGeneraldata.setLofLabeltechnicaldataCollection(labelDetailsCollection);
//
////End technical details --------------------------------------------------------------------------------------------
////Set swing ticket  ------------------------------------------------------------------------------------------------
//                    Collection<LofSwingticletlabeldata> swingCollection = new ArrayList<>();
//                    JSONObject swing_tickets = (JSONObject) jSONObject.get("swing_tickets");
//
//                    if (swing_tickets != null) {
//
//                        for (Iterator swing_tickets_iterator = swing_tickets.keySet().iterator(); swing_tickets_iterator.hasNext();) {
//                            String swing_careText = "";
////                        swing_careText = technical_labels.get("temp_swing_care").toString();
//
//                            LofSwingticletlabeldata lofSwingticletlabeldata = new LofSwingticletlabeldata();
//
//                            String swing_tickets_key = (String) swing_tickets_iterator.next();
//
//                            JSONObject swing_tickets_JSONObject1 = (JSONObject) swing_tickets.get(swing_tickets_key);
//                            swing_careText = swing_tickets_JSONObject1.get("temp_swing_care").toString();
//
//                            int count = Integer.parseInt(swing_tickets_JSONObject1.get("count").toString());
//                            lofSwingticletlabeldata = new LofSwingticletlabeldata(
//                                    count,
//                                    swing_tickets_JSONObject1.get("swing_labelRef").toString(),
//                                    swing_tickets_JSONObject1.get("trend_name").toString(),
//                                    swing_tickets_JSONObject1.get("product_benefit").toString(),
//                                    swing_tickets_JSONObject1.get("product_description").toString(),
//                                    swing_careText,
//                                    "Swing Ticket",
//                                    swing_tickets_JSONObject1.get("swing_labelGroup").toString(),
//                                    swing_tickets_JSONObject1.get("swing_lbl_des").toString(),
//                                    swing_tickets_JSONObject1.get("swing_wash_symbol").toString(),
//                                    lofGeneraldata
//                            );
//                            swingCollection.add(lofSwingticletlabeldata);
//                        }
//                        lofGeneraldata.setLofSwingticletlabeldataCollection(swingCollection);
//                    }
////End swing ticket  ------------------------------------------------------------------------------------------------
//
//                    Session s = NewHibernateUtil.getSessionFactory().openSession();
//                    Transaction t = s.beginTransaction();
//
//                    s.saveOrUpdate(lofGeneraldata);
//                    t.commit();
//
//                    response.getWriter().write("1");
//
//                } catch (ParseException ex) {
//
//                    response.getWriter().write("0");
//                    Logger.getLogger(SavePdf.class.getName()).log(Level.SEVERE, null, ex);
//                }

//===============================================================================================================
//===============================================================================================================
//===============================================================================================================
            }
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
