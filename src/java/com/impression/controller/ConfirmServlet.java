/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.Check_lof;
import com.impression.dao.Confarm_order;
import com.impression.dao.ConfirmDAOImp;
import com.impression.dao.GarmentDAOImp;
import com.impression.hibe.model.Company;
import com.impression.hibe.model.LofEandata;
import com.impression.hibe.model.LofGeneraldata;
import com.impression.hibe.model.LofLabeltechnicaldata;
import com.impression.hibe.model.LofSwingticletlabeldata;
import com.impression.hibe.model.SysUser;
import com.impression.util.ImpressionConstants;
import com.itextpdf.text.DocumentException;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Sandun
 */
public class ConfirmServlet extends HttpServlet {

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
            throws ServletException, IOException, ParseException, DocumentException {
        HttpSession session = request.getSession();
        SysUser user1 = (SysUser) session.getAttribute(ImpressionConstants.USER);
        Check_lof chk = new Check_lof();
        ConfirmDAOImp confirmDAOImp = new ConfirmDAOImp();

        JSONObject webOrderData = null;

        JSONObject generalData = new JSONObject();
        JSONArray enaArr = new JSONArray();
        JSONObject ean = new JSONObject();
        JSONArray technicalArr = new JSONArray();
        JSONObject technical = new JSONObject();
        JSONArray swingTickArr = new JSONArray();
        JSONObject swingTicket = new JSONObject();

        String method = request.getParameter("method");
        String ooNumer = request.getParameter("lofno").trim();

        if (method.equals("confirm")) {
            LofGeneraldata lg = confirmDAOImp.getGeneralDataNew(ooNumer);
            int web_order = lg.getWebOrderNo();
            String status = lg.getConfOrder();

            LofGeneraldata ge = confirmDAOImp.getGeneralData(lg.getWebOrderNo());

            GarmentDAOImp garmentDAOImp = new GarmentDAOImp();

            Company c = new Company();
            c = user1.getCompanyId();

            SysUser CS = garmentDAOImp.getCS(c);
            SysUser sales = garmentDAOImp.getSales(c);

            Thread t1 = new Thread(new Runnable() {
                public void run() {
                    String textBody = "This Order Has been Confirmed Successfully."
                            + "\n \n"
                            + "\t Web Order Number =" + lg.getId()
                            + "\n"
                            + "\t" + "Lof Number =" + lg.getLofData();
                    String subjectBody = "Order Confirmation Notification";

                    MailSender csMail = new MailSender(CS.getEmailAddress(), subjectBody, textBody);
                    csMail.sendTextMail();

                    MailSender salesMail = new MailSender(sales.getEmailAddress(), subjectBody, textBody);
                    salesMail.sendTextMail();

                    MailSender userMail = new MailSender(user1.getEmailAddress(), subjectBody, textBody);
                    userMail.sendTextMail();
                }
            });
            t1.start();

            JSONObject j = new JSONObject();
            j.put("message", "Success");

            response.getWriter().write(j.toString());

        }

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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(ConfirmServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DocumentException ex) {
            Logger.getLogger(ConfirmServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
