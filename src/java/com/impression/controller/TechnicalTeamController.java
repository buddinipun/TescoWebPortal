/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.TechTeamDAO;
import com.impression.hibe.model.TechnicalTeam;
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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Intern
 */
public class TechnicalTeamController extends HttpServlet {

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

            RequestDispatcher requestDispatcher;
            String tempPath = getServletContext().getInitParameter("users_img");

            DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();

            fileItemFactory.setSizeThreshold(5 * 1024 * 1024);

            File fileLocation = File.createTempFile("MyCMS", "UplaodedFile");

            fileItemFactory.setRepository(fileLocation);

            ServletFileUpload fileUpload = new ServletFileUpload(fileItemFactory);
            String fName = null;
            FileItem item = null;

            String emailAdd = "";
            String username = "";
            String contact_no = "";
            String contact_no_dep = "";
            String skype = "";
            String viber = "";
            String other = "";
            String country_save = "";
            String image_url = "";

            try {

                List items = fileUpload.parseRequest(request);
                TechnicalTeam technicalTeam = new TechnicalTeam();
                for (Object object : items) {
                    item = (FileItem) object;

                    if (item.isFormField()) {

                        //contact_no_dep
//                            if (values) {
//                                responnceObject.put("message", true);
//                            }
                        if ("emailAdd".equals(item.getFieldName())) {
                            emailAdd = item.getString();
                            // System.out.println("emailAdd :" + emailAdd);

                        }
                        if ("username".equals(item.getFieldName())) {
                            username = item.getString();
                            // System.out.println("username :" + username);

                        }
                        if ("contact_no".equals(item.getFieldName())) {
                            contact_no = item.getString();
                            // System.out.println("contact_no :" + contact_no);

                        }
                        if ("contact_no_dep".equals(item.getFieldName())) {
                            contact_no_dep = item.getString();
                            // System.out.println("contact_no_dep :" + contact_no_dep);

                        }
                        if ("skype".equals(item.getFieldName())) {
                            skype = item.getString();
                            // System.out.println("skype :" + skype);

                        }
                        if ("viber".equals(item.getFieldName())) {
                            viber = item.getString();
                            // System.out.println("viber :" + viber);

                        }
                        if ("other".equals(item.getFieldName())) {
                            other = item.getString();
                            // System.out.println("other :" + other);

                        }
                        if ("country_save".equals(item.getFieldName())) {
                            country_save = item.getString();
                            // System.out.println("country_save :" + country_save);

                        }

                    } else {

//                        String names[] = item.getName().split(".");
                        fName = item.getName();

//                        File file = new File(tempPath + fName + ".png");
                        File file = new File(tempPath + fName);
                        item.write(file);
                        // System.out.println("Name : " + fName);

//                    requestAwDao.sendEmail(fName, tempPath, user1);
//                    requestAwDao.updateconfOrderForImageUpload("ARS", fName, tempPath);
                    }

                }
                technicalTeam.setEmail(emailAdd);
                technicalTeam.setUsername(username);
                technicalTeam.setContactNo(contact_no);
                technicalTeam.setContactNoDep(contact_no_dep);
                technicalTeam.setSkype(skype);
                technicalTeam.setViber(viber);
                technicalTeam.setOther(other);
                technicalTeam.setCountry(country_save);
                technicalTeam.setImageUrl(fName);

                TechTeamDAO techTeamDAO = new TechTeamDAO();
                boolean values = techTeamDAO.saveMenuItem(technicalTeam);
                 response.sendRedirect("techTeam.jsp");

            } catch (Exception e) {
                e.printStackTrace();
            }
//            response.sendRedirect("techTeam.jsp");

            try {
                String actionType = request.getParameter("actionType");
                String selectedCountry = request.getParameter("country_select");

                if (null != actionType) {
                    switch (actionType) {
                        case "getTechTeamData": {

                            JSONObject responceObj = new JSONObject();
                            responceObj.put("message", false);

                            TechTeamDAO techTeamDAO = new TechTeamDAO();
                            List techTeamDetails = techTeamDAO.getTechTeamData(selectedCountry);
                            JSONArray jSONArray = new JSONArray();
                            for (Object eachDetail : techTeamDetails) {
                                JSONObject jSONObject = new JSONObject();
                                if (eachDetail instanceof TechnicalTeam) {
                                    TechnicalTeam technicalTeam = (TechnicalTeam) eachDetail;

                                    String emailAddress = technicalTeam.getEmail();
                                    String userName = technicalTeam.getUsername();
                                    String contactNo = technicalTeam.getContactNo();
                                    String contactNoDep = technicalTeam.getContactNoDep();
                                    String skypeName = technicalTeam.getSkype();
                                    String viberName = technicalTeam.getViber();
                                    String otherData = technicalTeam.getOther();
                                    String imageUrl = technicalTeam.getImageUrl();

                                    jSONObject.put("emailAddress", emailAddress);
                                    jSONObject.put("userName", userName);
                                    jSONObject.put("contactNo", contactNo);
                                    jSONObject.put("contactNoDep", contactNoDep);
                                    jSONObject.put("skypeName", skypeName);
                                    jSONObject.put("viberName", viberName);
                                    jSONObject.put("otherData", otherData);
                                    jSONObject.put("imageUrl", imageUrl);

                                    jSONArray.add(jSONObject);

                                }
                            }
                            // System.out.println("jsonArray : " + jSONArray);
                            responceObj.put("message", true);
                            responceObj.put("techTeamData", jSONArray);
                            response.getWriter().write(responceObj.toString());
                            break;

                        }
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
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
