/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.OrderstatusDAOimpl;
import com.impression.hibe.model.Company;
import com.impression.hibe.model.LofGeneraldata;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 *
 * @author Intern
 */
public class Orderstatus extends HttpServlet {

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
        String action = request.getParameter("method");
        try {
            if (action.equals("CancelOrder")) {
                String dataArr = request.getParameter("dataArr");

                String values[] = dataArr.split(",");

                LofGeneraldata c = new LofGeneraldata();
                c.setId(values[1]);

                String result = new OrderstatusDAOimpl().cancelorder(c);

                JSONObject jSONObject = new JSONObject();
                jSONObject.put("result", result);

                response.getWriter().write(jSONObject.toString());

            } else if (action.equals("HoldOrder")) {
                String dataArr = request.getParameter("dataArr");

                String values[] = dataArr.split(",");

                LofGeneraldata c = new LofGeneraldata();
                c.setId(values[1]);

                String result = new OrderstatusDAOimpl().Holdorder(c);

                JSONObject jSONObject = new JSONObject();
                jSONObject.put("result", result);

                response.getWriter().write(jSONObject.toString());

            } else if (action.equals("StartOrder")) {
                String dataArr = request.getParameter("dataArr");

                String values[] = dataArr.split(",");

                LofGeneraldata c = new LofGeneraldata();
                c.setId(values[1]);

                String result = new OrderstatusDAOimpl().Startorder(c);

                JSONObject jSONObject = new JSONObject();
                jSONObject.put("result", result);

                response.getWriter().write(jSONObject.toString());

            } else if (action.equals("Delevered")) {
                String dataArr = request.getParameter("dataArr");

                String values[] = dataArr.split(",");

                LofGeneraldata c = new LofGeneraldata();
                c.setId(values[1]);

                String result = new OrderstatusDAOimpl().Delevered(c);

                JSONObject jSONObject = new JSONObject();
                jSONObject.put("result", result);

                response.getWriter().write(jSONObject.toString());

            } else if (action.equals("Complete")) {
                String dataArr = request.getParameter("dataArr");

                String values[] = dataArr.split(",");

                LofGeneraldata c = new LofGeneraldata();
                c.setId(values[1]);

                String result = new OrderstatusDAOimpl().Complete(c);

                JSONObject jSONObject = new JSONObject();
                jSONObject.put("result", result);

                response.getWriter().write(jSONObject.toString());

            }
        } catch (Exception e) {
            e.printStackTrace();
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
