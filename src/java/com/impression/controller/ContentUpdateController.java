/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.ContentUpdateDAO;
import com.impression.hibe.model.WashSymbol;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author User
 */
public class ContentUpdateController extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        RequestDispatcher requestDispatcher;
        String tempPath = getServletContext().getInitParameter("symbols");
        String symbol = "";
        String details = "";
        DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();

        fileItemFactory.setSizeThreshold(5 * 1024 * 1024);

        File fileLocation = File.createTempFile("MyCMS", "UplaodedFile");

        fileItemFactory.setRepository(fileLocation);

        ServletFileUpload fileUpload = new ServletFileUpload(fileItemFactory);
        String fName = null;
        FileItem item = null;

        try {

            List items = fileUpload.parseRequest(request);
            for (Object object : items) {
                item = (FileItem) object;
                if (item.isFormField()) {
                    if ("sym_key".equals(item.getFieldName())) {
                        symbol = item.getString();
                        
                    }
                    if ("symbol_detils".equals(item.getFieldName())) {
                        details = item.getString();
                    }
                } else {
                    int data = ContentUpdateDAO.getLastIndex(symbol);
                    ++data;
                    if (data < 10) {
                        fName = symbol + "00" + data;
                    } else if (data < 100) {
                        fName = symbol + "0" + data;
                    } else if (data < 1000) {
                        fName = symbol + data;
                    }
                    File file = new File(tempPath + fName + ".png");
                    item.write(file);
                    WashSymbol washSymbol = new WashSymbol(fName, fName + ".png", details, symbol);
                    boolean stat = ContentUpdateDAO.saveWashSymbol(washSymbol);
                    if (stat) {
                        request.setAttribute("message", "success");
                    } else {
                        request.setAttribute("message", "error");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
//        requestDispatcher = request.getRequestDispatcher("contentUp.jsp");
//        requestDispatcher.forward(request, response);
        response.sendRedirect("contentUp.jsp");
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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
