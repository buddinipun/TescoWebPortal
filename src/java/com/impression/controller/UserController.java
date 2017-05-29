/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.CompanyDAOImpl;
import com.impression.dao.Encrypt;
import com.impression.dao.UserDAO;
import com.impression.hibe.model.Company;
import com.impression.hibe.model.Customer;
import com.impression.hibe.model.MenuItem;
import com.impression.hibe.model.SysUser;
import com.impression.hibe.model.SysUserMenuItem;
import com.impression.hibe.model.UserType;
import com.impression.util.ImpressionConstants;
import com.impression.util.NewHibernateUtil;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author User
 */
public class UserController extends HttpServlet {

    private UserDAO udao = new UserDAO();

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

        String actionType = request.getParameter("actionType");
        RequestDispatcher requestDispatcher;
        if (actionType.equals("Signup")) {

            String email = request.getParameter("emailAdd").toLowerCase();
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String cpassword = request.getParameter("cpassword");
            String telephone = request.getParameter("telephone");
            String firstName = request.getParameter("firstName").trim();
            String lastName = request.getParameter("lastName").trim();
            String contactPerson = firstName + " " + lastName;

            boolean isValidated = true;

            if (username != null && username.length() == 0) {
                isValidated = false;
                request.setAttribute("ERROR_MESSAGE", "Please Enter Username");
                requestDispatcher = request.getRequestDispatcher("signUp.jsp");
                requestDispatcher.forward(request, response);
            } else if (password != null && password.length() == 0) {
                isValidated = false;
                request.setAttribute("ERROR_MESSAGE", "Please Enter Password");
                requestDispatcher = request.getRequestDispatcher("signUp.jsp");
                requestDispatcher.forward(request, response);
            } else if (telephone != null && telephone.length() == 0) {
                isValidated = false;
                request.setAttribute("ERROR_MESSAGE", "Please Enter Contact Number");
                requestDispatcher = request.getRequestDispatcher("signUp.jsp");
                requestDispatcher.forward(request, response);
            } else if (email != null && email.length() == 0) {
                isValidated = false;
                request.setAttribute("ERROR_MESSAGE", "Please Enter Email Address");
                requestDispatcher = request.getRequestDispatcher("signUp.jsp");
                requestDispatcher.forward(request, response);
            }
            if (isValidated) {
                Set s = new HashSet();

                String[] arr = email.split(("@"));
                String domain = arr[1];
                // System.out.println("domain   " + domain);
                Company c = new UserDAO().getUserCompany(domain);
                // System.out.println("getCompanyCode    " + c.getCompanyCode());
                // System.out.println("getCompanyID    " + c.getCompanyId());
                Integer cId = c.getCompanyId();
                // System.out.println("cId    " + cId);

                UserType title = new UserType();
                title.setUserType(2);

                Date date = new Date();
                String abc = date.toString();

                Calendar cal = Calendar.getInstance();
                String ttt = cal.getTime().toString();

                SysUser sysUser = new SysUser();

                sysUser.setUsername(username);
                sysUser.setUserType(title);
                sysUser.setEmailAddress(email);
                sysUser.setIsActive(false);
                sysUser.setAddedBy("SignUp");
                sysUser.setAddedDate(abc);
                sysUser.setAddedTime(ttt);
                Encrypt encrypt = new Encrypt();
                String encryptPassword = encrypt.encrypt(password);

                sysUser.setPassword(encryptPassword);
                sysUser.setCompanyId(c);

                Customer customer = new Customer();

                customer.setBrands("NA");
                customer.setCountry("NA");
                customer.setEmail(email);
                customer.setFax("NA");
                customer.setEnquiry("NA");
                customer.setCustomerName(contactPerson);

                //customer.setPhoneAlternative(username);
                customer.setPhonePrimary(telephone);
                customer.setPostCode("NA");
                customer.setSupplierCode("NA");
                customer.setUsername(sysUser);
                s.add(customer);

                sysUser.setCustomerCollection(s);

                UserDAO userDAO = new UserDAO();
                String result = userDAO.signUp(sysUser);

                switch (result) {
                    case ImpressionConstants.SUCCESS:
                        //get company email address------------------------------------
                        List<SysUser> conpanyEmailAddress = userDAO.getCompanyEmailAddress(c.getCompanyId());
                        for (SysUser su : conpanyEmailAddress) {
                            String companyEmail = su.getEmailAddress();
                            String subject = "New Registration";
                            String textBody = "\n"
                                    + "Here new registrations with Your Company."
                                    + "\n\n"
                                    + "Please Give Access to this User."
                                    + "\n\n"
                                    + "\t User Name : " + username + ""
                                    + "\n"
                                    + "\t Telephone : " + telephone + ""
                                    + "\n"
                                    + "\t Email Address : " + email;
                            MailSender mailSender = new MailSender(companyEmail, subject, textBody);
                            mailSender.sendTextMail();
                        }
                        request.setAttribute("SUCCESS_MESSAGE", "User added SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("index.jsp");
                        requestDispatcher.forward(request, response);
                        break;
                    case ImpressionConstants.EXIST:
                        request.setAttribute("ERROR_MESSAGE", "Entered username or password already registered with system.Please Try again");
                        requestDispatcher = request.getRequestDispatcher("signUp.jsp");
                        requestDispatcher.forward(request, response);
                        break;
                    case ImpressionConstants.ERROR:
                        request.setAttribute("ERROR_MESSAGE", "There is some error.Please Contact System Administrator.");
                        requestDispatcher = request.getRequestDispatcher("signUp.jsp");
                        requestDispatcher.forward(request, response);
                        break;
                }
            }
        } else if (actionType.equals("addUser")) {
            try {

                String email = request.getParameter("emailAdd").trim();
                String username = request.getParameter("username").trim();
                String password = request.getParameter("password").trim();
                String cpassword = request.getParameter("cpassword").trim();
                String telephone = request.getParameter("inputTelephone").trim();
                String firstName = request.getParameter("inputFirst").trim();
                String lastName = request.getParameter("inputLast").trim();
                String addedUser = request.getParameter("addedUser").trim();
                String usertype = request.getParameter("usertype").trim();
                String contactPerson = firstName + " " + lastName;

                boolean isValidated = true;

                if (username != null && username.length() == 0) {
                    isValidated = false;
                    request.setAttribute("ERROR_MESSAGE", "Please Enter Username");
                    requestDispatcher = request.getRequestDispatcher("addSuperUser.jsp");
                    requestDispatcher.forward(request, response);
                } else if (password != null && password.length() == 0) {
                    isValidated = false;
                    request.setAttribute("ERROR_MESSAGE", "Please Enter Password");
                    requestDispatcher = request.getRequestDispatcher("addSuperUser.jsp");
                    requestDispatcher.forward(request, response);
                } else if (telephone != null && telephone.length() == 0) {
                    isValidated = false;
                    request.setAttribute("ERROR_MESSAGE", "Please Enter Contact Number");
                    requestDispatcher = request.getRequestDispatcher("addSuperUser.jsp");
                    requestDispatcher.forward(request, response);
                } else if (email != null && email.length() == 0) {
                    isValidated = false;
                    request.setAttribute("ERROR_MESSAGE", "Please Enter Email Address");
                    requestDispatcher = request.getRequestDispatcher("addSuperUser.jsp");
                    requestDispatcher.forward(request, response);
                }
                if (isValidated) {
                    Set s = new HashSet();

                    int utypeId = Integer.parseInt(usertype);
                    String[] arr = email.split(("@"));
                    String domain = arr[1];

                    Company c = new UserDAO().getUserCompany(domain);

                    c.setCompanyCode(c.getCompanyCode());

                    Company cId = new CompanyDAOImpl().getCompanyId(c);

                    c.setCompanyId(cId.getCompanyId());

                    UserType title = new UserType();
                    title.setUserType(utypeId);

                    Date date = new Date();
                    String aDate = date.toString();

                    Calendar cal = Calendar.getInstance();
                    String time = cal.getTime().toString();

                    SysUser sysUser = new SysUser();

                    sysUser.setUsername(username);
                    sysUser.setUserType(title);
                    sysUser.setEmailAddress(email);
                    sysUser.setIsActive(true);
                    sysUser.setAddedBy(addedUser);
                    sysUser.setAddedDate(aDate);
                    sysUser.setAddedTime(time);
                    Encrypt encrypt = new Encrypt();
                    String encryptPassword = encrypt.encrypt(password);

                    sysUser.setPassword(encryptPassword);
                    sysUser.setCompanyId(c);

                    Customer customer = new Customer();

                    customer.setBrands("NA");
                    customer.setCountry("NA");
                    customer.setEmail(email);
                    customer.setFax("NA");
                    customer.setEnquiry("NA");
                    customer.setCustomerName(contactPerson);

                    //customer.setPhoneAlternative(username);
                    customer.setPhonePrimary(telephone);
                    customer.setPostCode("NA");
                    customer.setSupplierCode("NA");
                    customer.setUsername(sysUser);
                    s.add(customer);

                    List<SysUserMenuItem> newList = new ArrayList<>();
                    if (utypeId == 1 || utypeId == 3) {
                        MenuItem menuItem = new MenuItem(6);
                        SysUserMenuItem sysUserMenuItem = new SysUserMenuItem(true, true, true, true, true, menuItem, sysUser);
                        newList.add(sysUserMenuItem);
                    }
                    sysUser.setSysUserMenuItemCollection(newList);

                    sysUser.setCustomerCollection(s);

                    UserDAO userDAO = new UserDAO();
                    String result = userDAO.signUp(sysUser);

                    if (result.equals(ImpressionConstants.SUCCESS)) {
                        request.setAttribute("SUCCESS_MESSAGE", "User added SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("addSuperUser.jsp");
                        requestDispatcher.forward(request, response);
                    } else if (result.equals(ImpressionConstants.EXIST)) {
                        request.setAttribute("ERROR_MESSAGE", "Entered username or password already registered with system.Please Try again");
                        requestDispatcher = request.getRequestDispatcher("addSuperUser.jsp");
                        requestDispatcher.forward(request, response);
                    } else if (result.equals(ImpressionConstants.ERROR)) {
                        request.setAttribute("ERROR_MESSAGE", "There is some error.Please Contact System Administrator.");
                        requestDispatcher = request.getRequestDispatcher("addSuperUser.jsp");
                        requestDispatcher.forward(request, response);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else if (actionType.equals("ChangeActiveStatus")) {
            String username = request.getParameter("username").trim();

            boolean isValidated = true;

            if (username != null && username.length() == 0) {
                isValidated = false;
                request.setAttribute("ERROR_MESSAGE", "Please Select Username");
                requestDispatcher = request.getRequestDispatcher("addSuperUser.jsp");
                requestDispatcher.forward(request, response);
            }
            if (isValidated) {

                SysUser sysUser = new SysUser();
                sysUser.setIsActive(true);
                sysUser.setUsername(username);

                String result = new UserDAO().updateUserStatus(sysUser);

                switch (result) {
                    case ImpressionConstants.SUCCESS:
                        request.setAttribute("SUCCESS_MESSAGE", "User Permissions added SuccessFully");
                        requestDispatcher = request.getRequestDispatcher("admin.jsp");
                        requestDispatcher.forward(request, response);
                        break;
                    case ImpressionConstants.ERROR:
                        request.setAttribute("ERROR_MESSAGE", "There is an Error.Please Try again");
                        requestDispatcher = request.getRequestDispatcher("admin.jsp");
                        requestDispatcher.forward(request, response);
                        break;
                }
            }

        } //        else if (actionType.equals("GiveUserPermission")) {
        //
        //            String username = request.getParameter("username");
        //            if (username != null) {
        //                username = username.trim();
        //            }
        //            UserDAO userDAO = new UserDAO();
        //            SysUser user = userDAO.getUserdetails(username);
        //            Customer customer = userDAO.getUserdetailsss(username);
        //
        //            JSONObject jSONObject = new JSONObject();
        //            jSONObject.put("email", user.getEmailAddress());
        //            jSONObject.put("isActive", user.getIsActive());
        //            jSONObject.put("name", customer.getCustomerName());
        //            jSONObject.put("c_num", customer.getPhonePrimary());
        //            jSONObject.put("username", user.getUsername());
        //
        //            response.getWriter().write(jSONObject.toString());
        //
        //        } 
        else if (actionType.equals("SaveStatusUpdateUser")) {
            String dataset = request.getParameter("dataset");

            String[] j = dataset.split("@");

            boolean isActive = Boolean.parseBoolean(j[0]);

            UserDAO userDAO = new UserDAO();

            SysUser sysUser = new SysUser();
            sysUser.setUsername(j[1]);
            String result = userDAO.updateUserStatusB(sysUser, isActive);
            //==================================================================
            //========================== Set permission =======================================
            //==================================================================
            // String permission = request.getParameter("permissionList").trim();
            String permission = j[2];

            String permissionArr[] = permission.split(",");

            String username = permissionArr[0];

            List<SysUserMenuItem> su = new UserDAO().getAllUserMenusNew(username);
            if (su.size() != 0) {
                userDAO.deletePermissions(new SysUser(username));
            }
            //List of Permission Id that already Have
            List<Integer> hadPermission = new ArrayList<>();

            //List of Permission that newly sellected
            List<Integer> newPermList = new ArrayList();

            //Set that get id's that need to do status=0
            Set unique = new HashSet();

            //Set that get id's that need to do status=1
            ArrayList<Integer> commonMenuID = new ArrayList<Integer>();

            for (int a = 1; a < permissionArr.length; a++) {
                newPermList.add(Integer.parseInt(permissionArr[a]));
            }
            String res = "";
            for (int ne : newPermList) {

                sysUser.setUsername(username);

                MenuItem menuItem = new MenuItem();
                menuItem.setMenuItemId(ne);

                SysUserMenuItem sumi = new SysUserMenuItem();
                sumi.setUsername(sysUser);
                sumi.setMenuItem(menuItem);
                sumi.setHasDeleteBtn(true);
                sumi.setHasPrintBtn(true);
                sumi.setHasSaveBtn(true);
                sumi.setHasUpdateBtn(true);
                sumi.setStatus(true);

                res = userDAO.setPermissions(sumi);
            }

            JSONObject jo = new JSONObject();

// JSONObject jSONObject = new JSONObject();
//            
//
//            response.getWriter().write(jSONObject.toString());
//            
//            
            if (res.equals(ImpressionConstants.SUCCESS)) {
                jo.put("resultnew", result);
                jo.put("res", "Success");
                response.getWriter().write(String.valueOf(jo));
            } else {
                jo.put("res", "Error");
                response.getWriter().write(String.valueOf(jo));
            }

            //==================================================================
            //==================================================================
            //==================================================================
        } //        else if (actionType.equals("BringPriviledges")) {
        //            
        //            String username = request.getParameter("username");            
        //            UserDAO userDAO = new UserDAO();
        //
        //            List<SysUserMenuItem> su = userDAO.getAllUserMenus(username);
        //            List<MenuItem> su1 = userDAO.getNotAllUserMenus(username);
        //
        //            JSONObject jSONObject1 = new JSONObject();
        //
        //            JSONArray jArray2 = new JSONArray();
        //            for (MenuItem sum : su1) {
        //
        //                JSONObject jSONObject2 = new JSONObject();
        //                jSONObject2.put("menu_item_id", sum.getMenuItemId());
        //                jSONObject2.put("menu_item_name", sum.getMenuItemName());
        //
        //                jArray2.add(jSONObject2);
        //            }
        //            JSONArray jArray3 = new JSONArray();
        //
        //            for (SysUserMenuItem sum : su) {
        //
        //                JSONObject jSONObject3 = new JSONObject();
        //
        //                jSONObject3.put("menu_item_id", sum.getMenuItem().getMenuItemId());
        //                jSONObject3.put("menu_item_name", sum.getMenuItem().getMenuItemName());
        //                jSONObject3.put("username", sum.getUsername().getUsername());
        //
        //                jArray3.add(jSONObject3);
        //
        //            }
        //
        //            jSONObject1.put("jArray2", jArray2);
        //            jSONObject1.put("jArray3", jArray3);
        //
        //            response.getWriter().write(String.valueOf(jSONObject1));
        //        }
        else if (actionType.equals("BringPriviledges")) {// importance()

            // System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXbring");
            String username = request.getParameter("username");
            // System.out.println("User Name : " + username);
            UserDAO userDAO = new UserDAO();
            if (username != null) {
                username = username.trim();
            }
            SysUser suser = userDAO.getUserdetails(username);
            List<SysUserMenuItem> su = userDAO.getAllUserMenus(username);
            List<MenuItem> su1 = userDAO.getNotAllUserMenus(username);

            JSONObject jSONObject1 = new JSONObject();

            JSONArray jArray2 = new JSONArray();

            for (MenuItem sum : su1) {
                if (suser.getUserType().getUserType() != 3 && sum.getMenuItemId() == 1) {
                } else if (suser.getUserType().getUserType() >= 3 && sum.getMenuItemId() == 3) {
                } else if (suser.getUserType().getUserType() >= 3 && sum.getMenuItemId() == 2) {
                } else if (suser.getUserType().getUserType() >= 3 && sum.getMenuItemId() == 4) {
                } else if (suser.getUserType().getUserType() >= 3 && sum.getMenuItemId() == 5) {
                } else if (suser.getUserType().getUserType() != 1 && suser.getUserType().getUserType() != 3 && sum.getMenuItemId() == 6) {
                } else if (suser.getUserType().getUserType() < 3 && sum.getMenuItemId() == 7) {
                } else if (suser.getUserType().getUserType() != 3 && sum.getMenuItemId() == 8) {
                } else if (suser.getUserType().getUserType() < 3 && sum.getMenuItemId() == 9) {
                } else {
                    JSONObject jSONObject2 = new JSONObject();
                    jSONObject2.put("menu_item_id", sum.getMenuItemId());
                    jSONObject2.put("menu_item_name", sum.getMenuItemName());
                    jArray2.add(jSONObject2);
                }
            }
            JSONArray jArray3 = new JSONArray();

            for (SysUserMenuItem sum : su) {
                if (sum.getUsername().getUserType().getUserType() != 3 && sum.getMenuItem().getMenuItemId() == 1) {
                } else if (sum.getUsername().getUserType().getUserType() >= 3 && sum.getMenuItem().getMenuItemId() == 2) {
                } else if (sum.getUsername().getUserType().getUserType() >= 3 && sum.getMenuItem().getMenuItemId() == 3) {
                } else if (sum.getUsername().getUserType().getUserType() >= 3 && sum.getMenuItem().getMenuItemId() == 4) {
                } else if (sum.getUsername().getUserType().getUserType() >= 3 && sum.getMenuItem().getMenuItemId() == 5) {
                } else if (sum.getUsername().getUserType().getUserType() != 1 && sum.getUsername().getUserType().getUserType() != 3 && sum.getMenuItem().getMenuItemId() == 6) {
                } else if (sum.getUsername().getUserType().getUserType() < 3 && sum.getMenuItem().getMenuItemId() == 7) {
                } else if (sum.getUsername().getUserType().getUserType() != 3 && sum.getMenuItem().getMenuItemId() == 8) {
                } else if (sum.getUsername().getUserType().getUserType() < 3 && sum.getMenuItem().getMenuItemId() == 9) {
                } else {
                    JSONObject jSONObject3 = new JSONObject();
                    jSONObject3.put("menu_item_id", sum.getMenuItem().getMenuItemId());
                    jSONObject3.put("menu_item_name", sum.getMenuItem().getMenuItemName());
                    jSONObject3.put("username", sum.getUsername().getUsername());
                    jArray3.add(jSONObject3);
                }
            }
//==============================================================================
//==============================================================================
//==============================================================================

            SysUser user = userDAO.getUserdetails(username);
            Customer customer = userDAO.getUserdetailsss(username);

            jSONObject1.put("email", user.getEmailAddress());
            jSONObject1.put("isActive", user.getIsActive());
            jSONObject1.put("name", customer.getCustomerName());
            jSONObject1.put("c_num", customer.getPhonePrimary());
            jSONObject1.put("username", user.getUsername());

//===================================================================
//===================================================================
//===================================================================
            jSONObject1.put("jArray2", jArray2);
            jSONObject1.put("jArray3", jArray3);

            response.getWriter().write(String.valueOf(jSONObject1));
        } else if (actionType.equals("CheckDomain")) {
            String email = request.getParameter("emailAdd").trim();
            String status = "";

            if (email.contains("@")) {
                String[] arr = email.split(("@"));
                String domain = arr[1];

                Session session = NewHibernateUtil.getSessionFactory().openSession();
                Transaction transaction = session.beginTransaction();
                // String status = "";
                if (session != null) {
                    try {
                        String HQL = "From Company c where c.companyDomain=:domain";
                        Query query = session.createQuery(HQL);
                        query.setParameter("domain", domain);
                        Company c = (Company) query.uniqueResult();
                        if (c != null) {
                            status = ImpressionConstants.EXIST;
                        } else {
                            status = ImpressionConstants.NOT_EXIST;
                        }
                    } catch (Exception e) {
                    }
                } else {
                    status = ImpressionConstants.ERROR;
                }

                switch (status) {
                    case ImpressionConstants.EXIST:
                        response.getWriter().write(status);
                        break;
                    case ImpressionConstants.NOT_EXIST:
                        response.getWriter().write(status);
                        break;
                }
            } else {
                response.getWriter().write(status);
            }

            //Use this action is to set permissions to users 
        } //        else if (actionType.equals("SetAllPermission")) {
        //            String permission = request.getParameter("permissionList").trim();
        //
        //            String permissionArr[] = permission.split(",");
        //
        //            String username = permissionArr[0];
        //            UserDAO userDAO = new UserDAO();
        //            List<SysUserMenuItem> su = new UserDAO().getAllUserMenusNew(username);
        //            if (su.size() != 0) {
        //                userDAO.deletePermissions(new SysUser(username));
        //            }
        //            //List of Permission Id that already Have
        //            List<Integer> hadPermission = new ArrayList<>();
        //
        //            //List of Permission that newly sellected
        //            List<Integer> newPermList = new ArrayList();
        //
        //            //Set that get id's that need to do status=0
        //            Set unique = new HashSet();
        //
        //            //Set that get id's that need to do status=1
        //            ArrayList<Integer> commonMenuID = new ArrayList<Integer>();
        //
        //            for (int a = 1; a < permissionArr.length; a++) {
        //                newPermList.add(Integer.parseInt(permissionArr[a]));
        //            }
        //            String res = "";
        //            for (int ne : newPermList) {
        //                SysUser sysUser = new SysUser();
        //                sysUser.setUsername(username);
        //
        //                MenuItem menuItem = new MenuItem();
        //                menuItem.setMenuItemId(ne);
        //
        //                SysUserMenuItem sumi = new SysUserMenuItem();
        //                sumi.setUsername(sysUser);
        //                sumi.setMenuItem(menuItem);
        //                sumi.setHasDeleteBtn(true);
        //                sumi.setHasPrintBtn(true);
        //                sumi.setHasSaveBtn(true);
        //                sumi.setHasUpdateBtn(true);
        //                sumi.setStatus(true);
        //
        //                res = userDAO.setPermissions(sumi);
        //            }
        //
        //            JSONObject jo = new JSONObject();
        //
        //            if (res.equals(ImpressionConstants.SUCCESS)) {
        //                jo.put("res", "Success");
        //                response.getWriter().write(String.valueOf(jo));
        //            } else {
        //                jo.put("res", "Error");
        //                response.getWriter().write(String.valueOf(jo));
        //            }
        //
        //        }
        else if (actionType.equals("updateUserDetails")) {

            String customer_idStr = request.getParameter("customer_id").trim();
            String username = request.getParameter("username").trim();
            String email_address = request.getParameter("email_address").trim();
            String customer_name = request.getParameter("customer_name").trim();
            String phone_primary = request.getParameter("phone_primary").trim();
            String fax = request.getParameter("fax").trim();
            String country = request.getParameter("country").trim();
            String brands = request.getParameter("brands").trim();
            String enquiry = request.getParameter("enquiry").trim();
            String supplier_code = request.getParameter("supplier_code").trim();

            SysUser sysUser = new SysUser();
            sysUser.setUsername(username);
            int customer_id = 0;
            if (customer_idStr != null) {
                customer_id = Integer.parseInt(customer_idStr);
            }
            Customer customer = new Customer(customer_id, customer_name, email_address, phone_primary, fax, country, brands, enquiry, supplier_code, sysUser);

            UserDAO userDAO = new UserDAO();

            String updataStatus = userDAO.updateUserDetails(customer);

            request.setAttribute("updataStatus", updataStatus);

            requestDispatcher = request.getRequestDispatcher("userDetails.jsp");
            requestDispatcher.forward(request, response);

        } else if (actionType.equals("updateUserPassword")) {
            JSONObject responceObj = new JSONObject();
            responceObj.put("message", false);
            HttpSession session = request.getSession();
            try {
                String data = request.getParameter("data");
                // System.out.println("data    " + data);
                String[] datalist = data.split("@");
                String currentPass = datalist[0];
                String newPass = datalist[1];
                String rePass = datalist[2];
                String customerUsername = datalist[3];

                SysUser user = (SysUser) session.getAttribute("user");
                Encrypt encrypt = new Encrypt();
                String encryptPassword = encrypt.encrypt(newPass);
                user.setPassword(encryptPassword);

                UserDAO userDAO = new UserDAO();
                String user1 = userDAO.updateUserPassword(user);
                responceObj.put("message", true);
                // System.out.println("success");

            } catch (Exception e) {
                responceObj.put("message", false);
                e.printStackTrace();
            }

           response.getWriter().write(responceObj.toString());

        } else if (actionType.equals("checkPassword")) {
            JSONObject responceObj = new JSONObject();
            responceObj.put("message", false);
            try {
                String data = request.getParameter("data");
                // System.out.println("data    " + data);
                String[] datalist = data.split("@");
                String customerUsername = datalist[0];
                String currentPass = datalist[1];

                SysUser user = new SysUser();
                user.setUsername(customerUsername);
                Encrypt encrypt = new Encrypt();
                String encryptPassword = encrypt.encrypt(currentPass);
                user.setPassword(encryptPassword);

                UserDAO userDAO = new UserDAO();
                SysUser user1 = userDAO.userLogin(user);

                String loginStatus = user1.getLoginStatus();

                if (loginStatus.equals(ImpressionConstants.SUCCESS)) {
                    responceObj.put("message", true);

                } else if (loginStatus.equals(ImpressionConstants.INVALID_LOGIN)) {
                    responceObj.put("message", false);
                } else {
                    responceObj.put("message", false);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
            response.getWriter().write(responceObj.toString());

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
            Logger.getLogger(UserController.class
                    .getName()).log(Level.SEVERE, null, ex);
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
