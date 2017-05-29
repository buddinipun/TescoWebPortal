/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.LofGeneraldata;
import com.impression.util.ImpressionConstants;
import com.impression.util.NewHibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class ConfirmDAOImp {

    public LofGeneraldata getGeneralData(int id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "select * from lof_generaldata le where le.web_order_no=:id";
                SQLQuery query = session.createSQLQuery(SQL);
                query.addEntity(LofGeneraldata.class);
                query.setParameter("id", id);
                LofGeneraldata emp = (LofGeneraldata) query.uniqueResult();

//                String res = new ConfirmDAOImp().updateConfirmation(emp.getId());
                String res2 = new ConfirmDAOImp().updateConfirmation2(id);
                if (res2.equals(ImpressionConstants.SUCCESS)) {
                    return emp;
                } else {
                    return null;
                }

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

    public LofGeneraldata getGeneralDataNew(String id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "select * from lof_generaldata le where le.lof_data=:id";
                SQLQuery query = session.createSQLQuery(SQL);
                query.addEntity(LofGeneraldata.class);
                query.setParameter("id", id);
                LofGeneraldata emp = (LofGeneraldata) query.uniqueResult();

                return emp;

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

    public String updateConfirmation(String id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                List<LofGeneraldata> newList = getHaveToUpdateConfirmStatus(id);
                for (LofGeneraldata lg : newList) {
                    String HQL = "UPDATE LofGeneraldata u set u.confOrder=:yes WHERE u.webOrderNo=:id";
                    Query query = session.createQuery(HQL);
                    query.setParameter("id", lg.getWebOrderNo());
                    query.setParameter("yes", "ASNC");
                    query.executeUpdate();
                }
                transaction.commit();
                session.flush();

                return ImpressionConstants.SUCCESS;
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

    public String updateConfirmation2(int id) {
        String conf_order = "";
        conf_order = getOrderStatus(id);
        if (conf_order.equals("ARS")) {
            conf_order = "CONA";
        } else if (conf_order.equals("AR")) {
            conf_order = "ARCONA";
        } else if(conf_order.equals("NAR")){
            conf_order = "NARCONA";
        }else{
            conf_order = "ERROR";
        }
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "UPDATE LofGeneraldata u set u.confOrder=:yes WHERE u.webOrderNo=:id";
                Query query = session.createQuery(HQL);
                query.setParameter("id", id);
                query.setParameter("yes", conf_order);
                query.executeUpdate();
                transaction.commit();
                session.flush();

                return ImpressionConstants.SUCCESS;
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

    public static List<LofGeneraldata> getHaveToUpdateConfirmStatus(String id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From LofGeneraldata l Where l.id=:id";
                Query query = session.createQuery(HQL);
                query.setParameter("id", id);
                List<LofGeneraldata> newList = query.list();
                return newList;
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

    public String getOrderStatus(int id) {
        String a = "";
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "select * from lof_generaldata where web_order_no=:id";
                SQLQuery query = session.createSQLQuery(SQL);
                query.addEntity(LofGeneraldata.class);
                query.setParameter("id", id);
                LofGeneraldata emp = (LofGeneraldata) query.uniqueResult();
                a = emp.getConfOrder().toString();
                return a;

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
}
