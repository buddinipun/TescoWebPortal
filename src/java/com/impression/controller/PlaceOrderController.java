/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class PlaceOrderController extends HttpServlet {

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
        
        String po_number=request.getParameter("po_number");
        String supplier_number=request.getParameter("supplier_number");
        String supplier_name=request.getParameter("supplier_name");
        String factory_code=request.getParameter("factory_code");
        String lof_num=request.getParameter("lof_num");

        String purchase_order=request.getParameter("purchase_order");
        String category=request.getParameter("category");
        String country_of_origin=request.getParameter("country_of_origin");
        String style_No=request.getParameter("style_No");
        String Brand=request.getParameter("Brand");
        String product_description=request.getParameter("product_description");
        String char_description=request.getParameter("char_description");
        String season_code=request.getParameter("season_code");
        String fabric_composition=request.getParameter("fabric_composition");
        String carton_dimensions=request.getParameter("carton_dimensions");
        String comments=request.getParameter("comments");

        String department=request.getParameter("department");
        String uk_num=request.getParameter("uk_num");
        String ean_nos_primary=request.getParameter("ean_nos_primary");

        String labelType=request.getParameter("labelType");
        String labelDes=request.getParameter("labelDes");
        String labelGroup=request.getParameter("labelGroup");
        String labelRef=request.getParameter("labelRef");
        

        String allCaretextData=request.getParameter("allCaretextData");
        String feeling=request.getParameter("feeling");
        
        
        String allData=request.getParameter("allData");

        
        
        
        
        
        
        
        
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
