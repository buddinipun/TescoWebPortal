/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.Eannotb;
import com.impression.hibe.model.Sizes;
import com.impression.util.NewHibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author User
 */
public class SizeDAO {

    public Eannotb getSizesForEAN(String ean) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From eannotb Where eanno=:ean";
                Query query = session.createQuery(HQL);
                query.setParameter(ean, "ean");
                Eannotb sizes = (Eannotb) query.uniqueResult();
                return sizes;
            } catch (Exception e) {
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

    public List<Sizes> getSizesUsingUKAndDept(String dept, String uk) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            Transaction transaction = session.beginTransaction();

            try {

                Query query = session.createQuery("FROM Sizes s where dept=:dept and uk=:uk");
                query.setParameter("dept", dept);
                query.setParameter("uk", uk);

                List<Sizes> list = query.list();

                return list;

            } catch (Exception ex) {
                ex.printStackTrace();

                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();

                }

            } finally {

                if (session != null) {
                    session.close();
                }
            }
        } else {

        }
        return null;
    }

    public static List<String> getUKPrimarySize() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                String SQuery = "SELECT distinct uk_code FROM sizes";
                SQLQuery query = session.createSQLQuery(SQuery);
                List<String> list = query.list();

                return list;
            } catch (Exception e) {
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

    public static List<String> getCEPrimarySize() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                String SQuery = "SELECT distinct ce_code FROM sizes";
                SQLQuery query = session.createSQLQuery(SQuery);
                List<String> list = query.list();

                return list;
            } catch (Exception e) {
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

    public static List<Sizes> getAllPrimarySize() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                String SQuery = "SELECT * FROM sizes GROUP BY uk_code";
                SQLQuery query = session.createSQLQuery(SQuery);
                query.addEntity(Sizes.class);
                List<Sizes> list = query.list();
                // System.out.println("Inne list Sizes " + list.size());
                return list;
            } catch (Exception e) {
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

    public static List<Sizes> getDeptsizes(String dept) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                String SQuery = "SELECT * FROM sizes where dept = '" + dept + "' GROUP BY uk_code";
                SQLQuery query = session.createSQLQuery(SQuery);
                query.addEntity(Sizes.class);
                List<Sizes> list = query.list();
                // System.out.println("Inne list Sizes " + list.size());
                return list;
            } catch (Exception e) {
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

    public static String addEanDetails(JSONArray eannotb) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                for (Object eannotb2 : eannotb) {
                    JSONObject jsonObject = (JSONObject) eannotb2;
                    String eanDetailNo = jsonObject.get("eanDetailNo").toString();
                    String uk_primary_size = jsonObject.get("uk_primary_size").toString();
                    String ce_primary_size = jsonObject.get("ce_primary_size").toString();
                    Eannotb eannotb1 = new Eannotb();
                    eannotb1.setEanno(eanDetailNo);
                    eannotb1.setCeSize(ce_primary_size);
                    eannotb1.setUkSize(uk_primary_size);
                    session.save(eannotb1);
                }
                transaction.commit();
            } catch (Exception e) {
                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
            } finally {
                if (session != null && session.isOpen()) {
                    session.flush();
                    session.close();
                }
            }
        }
        return null;
    }

    public static int addEanDetails1(JSONArray eannotb) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                for (Object eannotb2 : eannotb) {
                    JSONObject jsonObject = (JSONObject) eannotb2;
                    String ean = jsonObject.get("ean").toString();
                    String uk_size = jsonObject.get("uk_size").toString();
                    String ce_size = jsonObject.get("ce_size").toString();
                    String styleType = jsonObject.get("styleType").toString();

                    Eannotb eannotb1 = new Eannotb();
//                    if (styleType.equals("UK")) {
                        eannotb1.setEanno(ean);
                        eannotb1.setCeSize(ce_size);
                        eannotb1.setUkSize(uk_size);
                        eannotb1.setStyleType("UK");
//                    } else if (styleType.equals("CE")) {
//                        eannotb1.setEanno(ean);
//                        eannotb1.setUkSize(uk_size);
//                        eannotb1.setCeSize(ce_size);
//                        eannotb1.setStyleType(styleType);
//                    } else {
//                        System.out.println("-------------------------------------------------------------------------");
//                        System.out.println("addEanDetails1 style type != UK or CE");
//                    }

                    int tmp = (int) session.save(eannotb1);
                    // System.out.println("ean save--" + tmp);
                    return tmp;
                }
                transaction.commit();
            } catch (Exception e) {
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
        return -1;
    }

    public static boolean updatekExistEAN1(JSONArray eannotb) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                for (Object eannotb2 : eannotb) {
                    JSONObject jsonObject = (JSONObject) eannotb2;
                    String ean = jsonObject.get("ean").toString();
                    String uk_size = jsonObject.get("uk_size").toString();
                    String ce_size = jsonObject.get("ce_size").toString();
                    String styleType = jsonObject.get("styleType").toString();
                    int id = Integer.parseInt(jsonObject.get("id").toString());
                    // System.out.println("id    " + id);

                    Query query = session.createQuery("UPDATE Eannotb set EANNO=:setEanno, ce_size =:setCeSize, uk_size=:setUkSize, style_type=:setStyleType  where id=:setId ");
                    query.setParameter("setEanno", ean);
                    query.setParameter("setCeSize", ce_size);
                    query.setParameter("setUkSize", uk_size);
                    query.setParameter("setStyleType", styleType);
                    query.setParameter("setId", id);
                    int i = query.executeUpdate();
                    transaction.commit();

//                    Eannotb eannotb1 = new Eannotb();
//                    eannotb1.setEanno(ean);
//                    eannotb1.setCeSize("100");
//                    eannotb1.setUkSize("100");
//                    eannotb1.setStyleType(styleType);
//                    eannotb1.setId(id);
//                    session.update(eannotb1);
                    // System.out.println("ean saveor update ok--");
                    return true;
                }
                transaction.commit();
            } catch (Exception e) {
                e.printStackTrace();
                // System.out.println("ean saveor update  not ok--");
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                return false;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return false;
    }
}
