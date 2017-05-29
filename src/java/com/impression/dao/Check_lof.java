/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.LofEandata;
import com.impression.hibe.model.LofGeneraldata;
import com.impression.hibe.model.LofLabeltechnicaldata;
import com.impression.hibe.model.LofSwingticletlabeldata;
//import com.impression.hibe.model.OnlineOrder;
import com.impression.util.Log4jUtil;
import com.impression.util.NewHibernateUtil;
import java.io.IOException;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class Check_lof {

    public List<LofEandata> getEAN(int id) throws IOException {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "select * from lof_eandata le where le.web_order_no=:id";
                SQLQuery query = session.createSQLQuery(SQL);
                query.addEntity(LofEandata.class);
                query.setParameter("id", id);
                List<LofEandata> emp = query.list();
                return emp;
            } catch (Exception e) {
                Log4jUtil.logDebugMessage(e);
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public List<LofGeneraldata> getGeneralData(String id) throws IOException {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "select * from lof_generaldata le where le.lof_data=:id";
                SQLQuery query = session.createSQLQuery(SQL);
                query.addEntity(LofGeneraldata.class);
                query.setParameter("id", id);
                List<LofGeneraldata> emp = query.list();
                return emp;
            } catch (Exception e) {
                Log4jUtil.logDebugMessage(e);
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public List<LofLabeltechnicaldata> getLabeltechnicaldata(int id) throws IOException {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "select * From lof_labeltechnicaldata le where le.web_order_no=:id";
                SQLQuery query = session.createSQLQuery(SQL);
                query.addEntity(LofLabeltechnicaldata.class);
                query.setParameter("id", id);
                List<LofLabeltechnicaldata> emp = query.list();
                return emp;

//                String HQL="From LofLabeltechnicaldata le where le.web_order_no=:id";
//                Query query = session.createQuery(HQL);
//                query.setParameter("id", wid);
//                List<LofLabeltechnicaldata> LabeltechnicaldataList = query.list();
//                return LabeltechnicaldataList;
            } catch (Exception e) {
                Log4jUtil.logDebugMessage(e);
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public List<LofSwingticletlabeldata> getSwingdata(int id) throws IOException {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                String SQL = "select * From lof_swingticletlabeldata le where le.web_order_no=:id";
                SQLQuery query = session.createSQLQuery(SQL);
                query.addEntity(LofSwingticletlabeldata.class);
                query.setParameter("id", id);
                List<LofSwingticletlabeldata> emp = query.list();
                return emp;

//                String HQL="From LofSwingticletlabeldata le where le.web_order_no=:id";
//                Query query = session.createQuery(HQL);
//                query.setParameter("id", wid);
//                List<LofSwingticletlabeldata> SwingdataList = query.list();
//                return SwingdataList;
            } catch (Exception e) {
                Log4jUtil.logDebugMessage(e);
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public LofEandata getSellingPrices(int id) throws IOException {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "select * from lof_eandata le where le.web_order_no=:id GROUP BY web_order_no";
                SQLQuery query = session.createSQLQuery(SQL);
                query.addEntity(LofEandata.class);
                query.setParameter("id", id);
                LofEandata emp = (LofEandata) query.uniqueResult();
                return emp;
            } catch (Exception e) {
                Log4jUtil.logDebugMessage(e);
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public LofGeneraldata getOrderNumber() throws IOException {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "select * from lof_generaldata order by id DESC limit 1";
                SQLQuery query = session.createSQLQuery(HQL);
                query.addEntity(LofGeneraldata.class);

                LofGeneraldata oo = (LofGeneraldata) query.uniqueResult();
                return oo;
            } catch (Exception e) {
                Log4jUtil.logDebugMessage(e);
                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();

                }
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;

    }
    
       public LofGeneraldata getOrderNumberPDF(int customerId) throws IOException {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "select * from lof_generaldata lg Where lg.customer=:customer order by id DESC limit 1";
                SQLQuery query = session.createSQLQuery(HQL);
                query.addEntity(LofGeneraldata.class);
                query.setParameter("customer", customerId);
                LofGeneraldata oo = (LofGeneraldata) query.uniqueResult();
                return oo;
            } catch (Exception e) {
                Log4jUtil.logDebugMessage(e);
                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();

                }
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;

    }

//    public String saveOrder(OnlineOrder oo) {
//
//        Session session = NewHibernateUtil.getSessionFactory().openSession();
//        Transaction transaction = session.beginTransaction();
//
//        if (session != null) {
//            try {
//
//                session.save(oo);
//                session.flush();
//                transaction.commit();
//                return ImpressionConstants.SUCCESS;
//            } catch (Exception e) {
//                Log4jUtil.logDebugMessage(e);                e.printStackTrace();
//                if (transaction != null && transaction.isActive()) {
//                    transaction.rollback();
//
//                }
//            } finally {
//                if (session != null && session.isOpen()) {
//                    session.close();
//                }
//            }
//        }
//
//        return null;
//
//    }

    public LofGeneraldata getGeneralDataById(int id) throws IOException {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "from LofGeneraldata le where le.webOrderNo=:id";
                Query query = session.createQuery(SQL);
                query.setParameter("id", id);
                LofGeneraldata emp = (LofGeneraldata) query.uniqueResult();
                return emp;
            } catch (Exception e) {
                Log4jUtil.logDebugMessage(e);
                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
            } finally {

                if (session != null) {
                    session.close();
                }
            }
        }

        return null;
    }

    public LofGeneraldata getGeneralDataByLofId(String lofData) throws IOException {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "from LofGeneraldata le where le.lofData=:lofData";
                Query query = session.createQuery(SQL);
                query.setParameter("lofData", lofData);
                LofGeneraldata emp = (LofGeneraldata) query.uniqueResult();
                
                // System.out.println("Hexxxxxxx" + emp.getLofData());
                
                return emp;
            } catch (Exception e) {
                Log4jUtil.logDebugMessage(e);
                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
            } finally {

                if (session != null) {
                    session.close();
                }
            }
        }

        return null;
    }
}
