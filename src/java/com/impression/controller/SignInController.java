/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.Encrypt;
import com.impression.dao.UserDAO;
import com.impression.hibe.model.SysUser;
import com.impression.util.ImpressionConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.GeneralSecurityException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
public class SignInController extends HttpServlet {

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
            throws ServletException, IOException, GeneralSecurityException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        RequestDispatcher requestDispatcher;
        boolean isValidated = true;

        if (username.length() == 0 && password.length() == 0) {
            isValidated = false;
            request.setAttribute("Error_Message", "Please Enter Username and password");
            requestDispatcher = request.getRequestDispatcher("index.jsp");
            requestDispatcher.forward(request, response);
        } else if (password.length() == 0 && password != null) {
            isValidated = false;
            request.setAttribute("Error_Message", "Please Enter Password");
            requestDispatcher = request.getRequestDispatcher("index.jsp");
            requestDispatcher.forward(request, response);
        } else if (username.length() == 0 & username != null) {
            isValidated = false;
            request.setAttribute("Error_Message", "Please Enter Username");
            requestDispatcher = request.getRequestDispatcher("index.jsp");
            requestDispatcher.forward(request, response);
        }

        if (isValidated) {

            SysUser user = new SysUser();
            user.setUsername(username);
            Encrypt encrypt = new Encrypt();
            String encryptPassword = encrypt.encrypt(password);
            user.setPassword(encryptPassword);

            UserDAO userDAO = new UserDAO();
            SysUser user1 = userDAO.userLogin(user);

            String loginStatus = user1.getLoginStatus();

            if (loginStatus.equals(ImpressionConstants.SUCCESS)) {

                int userType = user1.getUserType().getUserType();
                HttpSession session = request.getSession();
                session.setAttribute("user", user1);
                if (user1 != null) {

                    if (userType == 1) {
                        request.setAttribute("username", user1.getUsername());

                        request.setAttribute("Success_Message", "User Logged SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("admin.jsp");

//                        requestDispatcher = request.getRequestDispatcher("Users/superUser.jsp");
                        requestDispatcher.forward(request, response);
                    } else if (userType == 2) {
                        request.setAttribute("username", user1.getUsername());

                        request.setAttribute("Success_Message", "User Logged SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("admin.jsp");

//                        requestDispatcher = request.getRequestDispatcher("Users/normalUser.jsp");
                        requestDispatcher.forward(request, response);
                    } else if (userType == 3) {
                        request.setAttribute("username", user1.getUsername());

                        request.setAttribute("Success_Message", "User Logged SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("admin.jsp");
                        requestDispatcher.forward(request, response);
                    } else if (userType == 4) {
                        request.setAttribute("username", user1.getUsername());

                        request.setAttribute("Success_Message", "User Logged SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("admin.jsp");
                        requestDispatcher.forward(request, response);
                    } else if (userType == 5) {
                        request.setAttribute("username", user1.getUsername());

                        request.setAttribute("Success_Message", "User Logged SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("admin.jsp");
                        requestDispatcher.forward(request, response);
                    } else if (userType == 6) {
                        request.setAttribute("username", user1.getUsername());

                        request.setAttribute("Success_Message", "User Logged SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("admin.jsp");
                        requestDispatcher.forward(request, response);
                    } else if (userType == 7) {
                        request.setAttribute("username", user1.getUsername());

                        request.setAttribute("Success_Message", "User Logged SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("admin.jsp");
                        requestDispatcher.forward(request, response);
                    }

                }

            } else if (loginStatus.equals(ImpressionConstants.ERROR)) {
                request.setAttribute("Error_Message", "User Account is deactivated.Please Contact Administrator");
                requestDispatcher = request.getRequestDispatcher("index.jsp");
                requestDispatcher.forward(request, response);
            } else if (loginStatus.equals(ImpressionConstants.INVALID_LOGIN)) {
                request.setAttribute("Error_Message", "Invalid Login Details");
                requestDispatcher = request.getRequestDispatcher("index.jsp");
                requestDispatcher.forward(request, response);
            } else if (loginStatus.equals(ImpressionConstants.ERROR_MESSAGE)) {
                request.setAttribute("Error_Message", "Please Contact System Administrator");
                requestDispatcher = request.getRequestDispatcher("index.jsp");
                requestDispatcher.forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    
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
        } catch (GeneralSecurityException ex) {
            Logger.getLogger(SignInController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
