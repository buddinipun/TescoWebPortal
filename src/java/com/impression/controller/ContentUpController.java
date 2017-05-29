/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.ContentUpdateDAO;
import com.impression.hibe.model.Caretext;
import com.impression.hibe.model.Fiber;
import com.impression.hibe.model.LabelGroup;
import com.impression.hibe.model.Reference;
import com.impression.hibe.model.WashSymbol;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author User
 */
public class ContentUpController extends HttpServlet {

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

        String actionType = request.getParameter("actionType");
        if (null != actionType) {
            switch (actionType) {
                case "addLabelReferences": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", 0);
                    String data = request.getParameter("data");
                    String dataValues[] = data.split("@");
                    String txt_reference = dataValues[0];
                    String reference_type = dataValues[1];
                    Reference reference = new Reference(reference_type, txt_reference);
                    boolean values = ContentUpdateDAO.addLabelReferences(reference);
                    int stat = (values) ? 1 : 0;
                    jSONObject.put("message", stat);
                    response.getWriter().write(jSONObject.toString());
                    break;
                }
                case "addLabelGroup": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", 0);
                    String data = request.getParameter("data");
                    String dataValues[] = data.split("@");
                    String txt_grp = dataValues[0];
                    String reference_type_grp = dataValues[1];
                    LabelGroup labelGroup = new LabelGroup(reference_type_grp, txt_grp);
                    boolean values = ContentUpdateDAO.addLabelGroup(labelGroup);
                    int stat = (values) ? 1 : 0;
                    jSONObject.put("message", stat);
                    response.getWriter().write(jSONObject.toString());
                    break;
                }
                case "addFiberMain": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", 0);
                    String data = request.getParameter("data");
                    String dataValues[] = data.split("@");
                    String txt_fmvalue = dataValues[0];
                    String cmbcontentType = dataValues[1];
                    if (cmbcontentType.equals("none")) {
                        cmbcontentType = "";
                    }
                    Fiber fiber = new Fiber(txt_fmvalue, cmbcontentType);
                    boolean values = ContentUpdateDAO.addFiberMain(fiber);
                    int stat = (values) ? 1 : 0;
                    jSONObject.put("message", stat);
                    response.getWriter().write(jSONObject.toString());
                    break;
                }
                case "updateFiberMain": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", 0);
                    String data = request.getParameter("data");
                    // System.out.println(data);
                    String dataValues[] = data.split("@");
                    String txt_fmvalue = dataValues[0];
                    String cmbcontentType = dataValues[1];
                     String cmbcontentType12 = dataValues[2];
                    int id = Integer.parseInt(cmbcontentType12);
                    if (cmbcontentType.equals("none")) {
                        cmbcontentType = "";
                    }
                    Fiber fiber = new Fiber(id, txt_fmvalue, cmbcontentType);
                    boolean values = ContentUpdateDAO.updatehiberMain(fiber);
                    int stat = (values) ? 1 : 0;
                    jSONObject.put("message", stat);
                    response.getWriter().write(jSONObject.toString());
                    break;
                }
                case "addCareText": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", 0);
                    String data = request.getParameter("data");
                    String dataValues[] = data.split("@");
                    String cmbcareType = dataValues[0];
                    String txt_careText = dataValues[1];
                    String txt_careCode = dataValues[2];
                    Caretext careText = new Caretext(txt_careCode, txt_careText, cmbcareType);
                    boolean values = ContentUpdateDAO.addCareText(careText);
                    int stat = (values) ? 1 : 0;
                    jSONObject.put("message", stat);
                    response.getWriter().write(jSONObject.toString());
                    break;
                }
                //Iresh's Updation.. For retrieving the table from the DB
                case "getLabelReference": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", false);
                    ContentUpdateDAO contentUpdateDAO = new ContentUpdateDAO();
                    List<Reference> ref = contentUpdateDAO.getLableRef();
                    JSONArray jSONArray = new JSONArray();
                    for (Reference reference : ref) {
                        JSONObject jSONObject1 = new JSONObject();
                        jSONObject1.put("ref_type", reference.getRefType());
                        jSONObject1.put("refence", reference.getRef());
                        jSONArray.add(jSONObject1);
                    }
                    if (jSONArray.size() > 0) {
                        jSONObject.put("message", true);
                        jSONObject.put("references", jSONArray);
                    }
                    response.getWriter().write(jSONObject.toString());
                    break;
                }
                case "getLableGroup": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", false);
                    ContentUpdateDAO contentUpdateDAO = new ContentUpdateDAO();
                    List<LabelGroup> grp = contentUpdateDAO.getLableGroup();
                    JSONArray jSONArray = new JSONArray();
                    for (LabelGroup labelGroup : grp) {
                        JSONObject jSONObject1 = new JSONObject();
                        jSONObject1.put("label_type", labelGroup.getLabelType());
                        jSONObject1.put("group", labelGroup.getGrp());
                        jSONArray.add(jSONObject1);
                    }
                    if (jSONArray.size() > 0) {
                        jSONObject.put("message", true);
                        jSONObject.put("label_groups", jSONArray);
                    }
                    response.getWriter().write(jSONObject.toString());
                    break;
                }
                case "getFiberMain": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", false);
                    ContentUpdateDAO contentUpdateDAO = new ContentUpdateDAO();
                    List<Fiber> fbm = contentUpdateDAO.getFiberMain();
                    JSONArray jSONArray = new JSONArray();
                    for (Fiber fiberMain : fbm) {
                        JSONObject jSONObject1 = new JSONObject();
                        jSONObject1.put("id", fiberMain.getFId());
                        jSONObject1.put("content_type", fiberMain.getEnglish());
                        jSONObject1.put("Name", fiberMain.getDType());
                        jSONArray.add(jSONObject1);
                    }
                    if (jSONArray.size() > 0) {
                        jSONObject.put("message", true);
                        jSONObject.put("content_type", jSONArray);
                    }
                    response.getWriter().write(jSONObject.toString());
                    break;

                }
                case "getCareTexts": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", false);
                    ContentUpdateDAO contentUpdateDAO = new ContentUpdateDAO();
                    List<Caretext> cxt = contentUpdateDAO.getCareTexts();
                    JSONArray jSONArray = new JSONArray();
                    for (Caretext careText : cxt) {
                        JSONObject jSONObject1 = new JSONObject();
                        jSONObject1.put("type", careText.getDType());
                        jSONObject1.put("care_text", careText.getEnglish());
                        jSONObject1.put("care_code", careText.getCtCode());
                        jSONArray.add(jSONObject1);
                    }
                    if (jSONArray.size() > 0) {
                        jSONObject.put("message", true);
                        jSONObject.put("cTexts", jSONArray);
                    }
                    response.getWriter().write(jSONObject.toString());
                    break;
                }
                case "getWashSymbol": {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put("message", false);
                    ContentUpdateDAO contentUpdateDAO = new ContentUpdateDAO();
                    List<WashSymbol> wsb = contentUpdateDAO.getWashSymbols();
                    JSONArray jSONArray = new JSONArray();
                    for (WashSymbol washSymbol : wsb) {
                        JSONObject jSONObject1 = new JSONObject();
                        jSONObject1.put("id", washSymbol.getSymbolId());
                        jSONObject1.put("symbol_code", washSymbol.getSymbolCode());
                        jSONObject1.put("details", washSymbol.getDetails());
                        jSONObject1.put("url", washSymbol.getImageUrl());
                        jSONArray.add(jSONObject1);
                    }
                    if (jSONArray.size() > 0) {
                        jSONObject.put("message", true);
                        jSONObject.put("wshSbl", jSONArray);
                        // System.out.println("test 2 success");
                    }
                    response.getWriter().write(jSONObject.toString());
                    break;
                }
                //End of the Iresh's Updation.. For retrieving the table from the DB
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
