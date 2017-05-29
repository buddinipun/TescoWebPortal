/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.Company;
import com.impression.hibe.model.Customer;
import com.impression.hibe.model.MenuItem;
import com.impression.hibe.model.SysUser;
import com.impression.hibe.model.SysUserMenuItem;
import com.impression.util.ImpressionConstants;
import com.impression.util.NewHibernateUtil;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class UserDAO {

    public SysUser userLogin(SysUser user) {

        SysUser userTmp = new SysUser();
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                // Check User is already exist or not
                String loginHQLQuery = "FROM SysUser u WHERE u.username=:username AND u.password=:password";

                Query query = session.createQuery(loginHQLQuery);
                query.setParameter("username", user.getUsername());
                query.setParameter("password", user.getPassword());

                userTmp = (SysUser) query.uniqueResult();

                if (userTmp != null) {
                    boolean userStatus = userTmp.getIsActive();
                    if (userStatus == true) {

                        userTmp.setLoginStatus(ImpressionConstants.SUCCESS);

                    } else {

                        userTmp.setLoginStatus(ImpressionConstants.ERROR);
                    }
                    return userTmp;
                } else {
                    user.setLoginStatus(ImpressionConstants.INVALID_LOGIN);
                }
            } catch (Exception e) {
                user.setLoginStatus(ImpressionConstants.ERROR_MESSAGE);

            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        } else {
            user.setLoginStatus(ImpressionConstants.ERROR_MESSAGE);
        }

        return user;
    }

    public String signUp(SysUser sysUser) {
        Session s1 = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = s1.beginTransaction();

        if (s1 != null) {
            try {
                String uExistQuery = "From SysUser u Where u.username=:username OR u.emailAddress=:emailAddress";
                Query query = s1.createQuery(uExistQuery);
                query.setParameter("username", sysUser.getUsername());
                query.setParameter("emailAddress", sysUser.getEmailAddress());
                SysUser obj = (SysUser) query.uniqueResult();

                if (obj == null) {
                    s1.save(sysUser);
                    s1.flush();
                    t.commit();
                    return ImpressionConstants.SUCCESS;
                } else {
                    return ImpressionConstants.EXIST;
                }

            } catch (Exception e) {
                if (t != null && t.isActive()) {
                    t.rollback();
                }
                e.printStackTrace();
                return ImpressionConstants.ERROR;

            } finally {
                if (s1 != null) {
                    s1.close();
                }
            }
        }

        return null;
    }

    public String saveUserPermission(SysUserMenuItem sysUser) {
        Session s1 = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = s1.beginTransaction();

        if (s1 != null) {
            try {

                s1.save(sysUser);
                s1.flush();
                t.commit();
                return ImpressionConstants.SUCCESS;

            } catch (Exception e) {
                if (t != null && t.isActive()) {
                    t.rollback();
                }
                return ImpressionConstants.ERROR;
            } finally {
                if (s1 != null) {
                    s1.close();
                }
            }
        }

        return null;
    }

//    public String removeUserPermission(String uname, List<Integer> permission) {
//        Session s1 = NewHibernateUtil.getSessionFactory().openSession();
//        Transaction t = s1.beginTransaction();
//
//        if (s1 != null) {
//            try {
//
//                for (Integer aa : permission) {
//
//                    SysUserMenuItemPK pK = new SysUserMenuItemPK(uname, aa);
//
//                    String hql = "Update SysUserMenuItem s Set s.status=:status WHERE s.sysUserMenuItemPK.username=:username and s.sysUserMenuItemPK.menu_item=:pid";
//
//                    Query query = s1.createQuery(hql);
//                    query.setParameter("username", uname);
//                    query.setParameter("pid", aa);
//                    query.setParameter("status", false);
//                    query.executeUpdate();
//
//                    t.commit();
//
//                }
//
//                return ImpressionConstants.SUCCESS;
//            } catch (Exception e) {
//                e.printStackTrace();
//                return ImpressionConstants.ERROR;
//            } finally {
//                if (s1 != null) {
//                    s1.close();
//                }
//            }
//        }
//
//        return null;
//    }
    ///////////////////////////////////////////////////////////////////////////////////////////////// m
///////////////////////////////////////////////////////////////////////////////////////////////// m
    public String updateUserStatus(SysUser sysUser) {
        Session s1 = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = s1.beginTransaction();

        if (s1 != null) {
            try {

                Query query = s1.createQuery("UPDATE SysUser as s set  s.isActive=:true where s.username =:username");

                query.setParameter("username", sysUser.getUsername());
                query.setParameter("true", true);

                query.executeUpdate();

                t.commit();
                return ImpressionConstants.UPDATED;

            } catch (Exception e) {
                if (t != null && t.isActive()) {
                    t.rollback();
                }
                return ImpressionConstants.ERROR;
            } finally {
                if (s1 != null) {
                    s1.close();
                }
            }
        }

        return null;
    }

    public String updateUserStatusB(SysUser sysUser, boolean h) {
        Session s1 = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = s1.beginTransaction();

        if (s1 != null) {
            try {

                Query query = s1.createQuery("UPDATE SysUser as s set  s.isActive=:isActive where s.username =:username");

                query.setParameter("username", sysUser.getUsername());
                query.setParameter("isActive", h);

                query.executeUpdate();

                t.commit();
                return ImpressionConstants.UPDATED;

            } catch (Exception e) {
                if (t != null && t.isActive()) {
                    t.rollback();
                }
                return ImpressionConstants.ERROR;
            } finally {
                if (s1 != null) {
                    s1.close();
                }
            }
        }

        return null;
    }

    public SysUser getUserdetails(String username) {
        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();

        if (s != null) {
            try {
                String SQuery = "From SysUser s Where s.username=:username";
                Query query = s.createQuery(SQuery);
                query.setParameter("username", username);
                SysUser user = (SysUser) query.uniqueResult();
                return user;
            } catch (Exception e) {
                e.printStackTrace();
                if (t != null && t.isActive()) {
                    t.rollback();
                }
            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }
        return null;
    }

    public Customer getUserdetailsss(String username) {
        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = s.beginTransaction();

        if (s != null) {
            try {
                String SQuery = "From Customer s Where s.username.username=:username";
                Query query = s.createQuery(SQuery);
                query.setParameter("username", username);
                Customer user = (Customer) query.uniqueResult();
                return user;
            } catch (Exception e) {
                e.printStackTrace();                
            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }
        return null;
    }

    public List<SysUserMenuItem> getAllUserMenus(String username) {
        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = s.beginTransaction();

        if (s != null) {
            try {
                String SQuery = "From SysUserMenuItem s Where s.username.username=:username and status=1";
                Query query = s.createQuery(SQuery);
                query.setParameter("username", username);
                List<SysUserMenuItem> user = query.list();
                return user;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }
        return null;
    }

    public List<SysUserMenuItem> getAllUserMenusNew(String username) {
        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = s.beginTransaction();

        if (s != null) {
            try {
                String SQuery = "From SysUserMenuItem s Where s.username.username=:username";
                Query query = s.createQuery(SQuery);
                query.setParameter("username", username);
                List<SysUserMenuItem> user = query.list();
                return user;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }
        return null;
    }

    public List<MenuItem> getNotAllUserMenus(String username) {
        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = s.beginTransaction();

        if (s != null) {
            try {
                String SQuery = "SELECT * FROM menu_item where menu_item_id not in (select menu_item from sys_user_menu_item where username=:username and status=1) ;";
                SQLQuery query = s.createSQLQuery(SQuery);
                query.addEntity(MenuItem.class);
                query.setParameter("username", username);
                List<MenuItem> user = query.list();
                return user;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }
        return null;
    }

    public List<SysUser> getCompanyEmailAddress(int companyID) {
        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = s.beginTransaction();

        if (s != null) {
            try {
                String SQuery = "SELECT * FROM sys_user  INNER JOIN company ON (sys_user.company_id = company.company_id) WHERE sys_user.company_id=:companyID AND sys_user.user_type=1";
                SQLQuery query = s.createSQLQuery(SQuery);
                query.addEntity(SysUser.class);
                query.setParameter("companyID", companyID);
                List<SysUser> user = query.list();
                return user;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }
        return null;
    }

    public Company getUserCompany(String domain) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        String status = "";
        if (session != null) {
            try {
                String HQL = "From Company c where c.companyDomain=:domain";
                Query query = session.createQuery(HQL);
                query.setParameter("domain", domain);
                Company c = (Company) query.uniqueResult();
                return c;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public String deletePermissions(SysUser user) {

        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = s.beginTransaction();
        if (s != null) {
            try {
                String SQuery = "DELETE FROM SysUserMenuItem WHERE username=:username";

                Query query = s.createQuery(SQuery);

                query.setParameter("username", user);

                query.executeUpdate();
                transaction.commit();

                return ImpressionConstants.SUCCESS;

            } catch (Exception e) {

                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                return ImpressionConstants.ERROR;

            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }

        return null;
    }

    public String setPermissions(SysUserMenuItem menuItem) {

        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = s.beginTransaction();
        if (s != null) {
            try {
                s.save(menuItem);
                s.flush();
                transaction.commit();
                return ImpressionConstants.SUCCESS;
            } catch (Exception e) {

                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                return ImpressionConstants.ERROR;

            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }

        return null;
    }

    public String updateUserDetails(Customer customer) {

        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = s.beginTransaction();
        if (s != null) {
            try {
                s.update(customer);

                transaction.commit();
                return ImpressionConstants.SUCCESS;
            } catch (Exception e) {

                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                return ImpressionConstants.ERROR;

            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }

        return null;
    }
    public String updateUserPassword(SysUser user) {

        Session s = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = s.beginTransaction();
        if (s != null) {
            try {
                s.update(user);

                transaction.commit();
                return ImpressionConstants.SUCCESS;
            } catch (Exception e) {

                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                return ImpressionConstants.ERROR;

            } finally {
                if (s != null && s.isOpen()) {
                    s.close();
                }
            }
        }

        return null;
    }
    
}
