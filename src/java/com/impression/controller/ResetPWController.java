/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.Encrypt;
import com.impression.dao.PassResetDAO;
import com.impression.hibe.model.SysUser;
import com.impression.util.ImpressionConstants;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResetPWController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, GeneralSecurityException {
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email").trim();
        String method = request.getParameter("method");
        
        if (method != null && method.equals("reset")) {
            try {
                if (email != null) {
                PassResetDAO pass = new PassResetDAO();
                SysUser list = pass.existingEmailAddress(email);

                Encrypt e = new Encrypt();
                String ew = e.encrypt(list.getUsername());
                RequestDispatcher requestDispatcher;
                if (list == null) {
                    request.setAttribute(ImpressionConstants.Failed, ImpressionConstants.Failed);
                    requestDispatcher = request.getRequestDispatcher("fogotPassword.jsp");
                    requestDispatcher.forward(request, response);
                } else {
                    String link = getServletContext().getInitParameter("forgotw") + "&pin=" + ew;
                    String companyEmail = email;
                    String subject = "Reset Password";
                    String textBody = "\n"
                            + "Please Click  This Link to Reset Your Password."
                            + "\n\n"
                            + "\t Link : " + link;
                    MailSender mailSender = new MailSender(companyEmail, subject, textBody);
                    mailSender.sendTextMail();
                    request.setAttribute("username", email);
                    requestDispatcher = request.getRequestDispatcher("b4ResetPage.jsp");
                    requestDispatcher.forward(request, response);
                }

            } else {
                RequestDispatcher requestDispatcher;
                request.setAttribute(ImpressionConstants.Failed, ImpressionConstants.Failed);
                requestDispatcher = request.getRequestDispatcher("fogotPassword.jsp");
                requestDispatcher.forward(request, response);
            }
            } catch (Exception e) {
                RequestDispatcher requestDispatcher;
                request.setAttribute("email_error", ImpressionConstants.Failed);
                requestDispatcher = request.getRequestDispatcher("fogotPassword.jsp");
                requestDispatcher.forward(request, response);
            }
        } else if (method != null && method.equals("newpass")) {

            String uname = request.getParameter("email").trim();
            String pass = request.getParameter("pass");
            String repass = request.getParameter("repass");

            List<SysUser> userList = PassResetDAO.getList();

            List<String> userListNew = new ArrayList<>();
            for (SysUser su : userList) {
                Encrypt e = new Encrypt();
                String ew = e.encrypt(su.getUsername());

                if (ew.equals(uname)) {
                    userListNew.add(su.getUsername());
                }
            }

            RequestDispatcher requestDispatcher;
            boolean isValidated = true;
            if (uname != null && uname.length() == 0) {
                isValidated = false;
                request.setAttribute("username", uname);
                request.setAttribute("ERROR_MESSAGE", "Please Enter Company Name");
                requestDispatcher = request.getRequestDispatcher("resetPage.jsp");
                requestDispatcher.forward(request, response);
            } else if (pass != null && pass.length() == 0) {
                isValidated = false;
                request.setAttribute("username", uname);
                request.setAttribute("ERROR_MESSAGE", "Please Enter Password");
                requestDispatcher = request.getRequestDispatcher("resetPage.jsp");
                requestDispatcher.forward(request, response);

            }
            if (isValidated) {
                if (!userListNew.isEmpty()) {

                    Encrypt encrypt = new Encrypt();
                    String encryptPassword = encrypt.encrypt(pass);
                    for (String as : userListNew) {
                        SysUser sysUser = new SysUser();
                        sysUser.setUsername(as);
                        sysUser.setPassword(encryptPassword);

                        String result = new PassResetDAO().updateUserPassword(sysUser);

                        switch (result) {
                            case ImpressionConstants.SUCCESS:
                                request.setAttribute("Success_Message", "Password Updated Successfully");
                                requestDispatcher = request.getRequestDispatcher("index.jsp");
                                requestDispatcher.forward(request, response);
                                break;
                            case ImpressionConstants.ERROR_MESSAGE:
                                request.setAttribute("username", uname);
                                request.setAttribute("Error_Message", "Something Wrong.Re Enter Password");
                                requestDispatcher = request.getRequestDispatcher("fogotPassword.jsp");
                                requestDispatcher.forward(request, response);
                                break;
                        }
                    }
                }
            } else {
                request.setAttribute("Error_Message", "Something Wrong.Re Enter Password");
                requestDispatcher = request.getRequestDispatcher("fogotPassword.jsp");
                requestDispatcher.forward(request, response);
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);

        } catch (GeneralSecurityException ex) {
            Logger.getLogger(ResetPWController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
