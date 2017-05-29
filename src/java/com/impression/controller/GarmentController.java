/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.GarmentDAOImp;
import com.impression.hibe.model.Company;
import com.impression.util.ImpressionConstants;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 *
 * @author User
 */
public class GarmentController extends HttpServlet {

    GarmentDAOImp garmentDAOImp = new GarmentDAOImp();

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

        String action = request.getParameter("method");

        if (action.equals("UpdateGarment")) {
            String dataArr = request.getParameter("dataArr");

            String values[] = dataArr.split(",");
            int garmentId = Integer.parseInt(values[0]);

            Company c = new Company();
            c.setCompanyId(garmentId);
            c.setCompanyCode(values[1]);
            c.setCompanyName(values[2]);
            c.setCompanyDomain(values[3]);
            c.setCs(values[5]);
            c.setSales(values[6]);
            c.setArtwork(values[4]);

            String result = garmentDAOImp.updateGarment(c);

            JSONObject jSONObject = new JSONObject();
            jSONObject.put("result", result);

            response.getWriter().write(jSONObject.toString());

        } else if (action.equals("SaveGarment")) {

            String dataArr = request.getParameter("dataArr");
            String values[] = dataArr.split(",");
            int garmentId = Integer.parseInt(values[0]);
            Company c = new Company(garmentId, values[2], values[3], values[1], values[6], values[5], values[4]);
            String result = garmentDAOImp.saveGarment(c);

            JSONObject jSONObject = new JSONObject();
            jSONObject.put("result", result);

            response.getWriter().write(jSONObject.toString());

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
