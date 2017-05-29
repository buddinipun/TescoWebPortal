/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.extractpdf;

import com.impression.hibe.model.Sizes;
import com.impression.util.NewHibernateUtil;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class ExtractORMS {

    private static String poNumber;
    private static String styleNumber;
    private static CommonData commonData;

    public static CommonData getORMSData(List<Page> lstPage) {

        List<String> eanDat = new ArrayList<String>();
        commonData = new CommonData();

        for (Page page : lstPage) {
            String pageContent = page.getContent();
            StringTokenizer stringTokenizer = new StringTokenizer(pageContent, "\n");
            String[] contentArray = new String[stringTokenizer.countTokens()];
            int line = 0;
            while (stringTokenizer.hasMoreTokens()) {
                String nextElement = stringTokenizer.nextToken();
                contentArray[line] = nextElement;
                line++;
            }
            for (int i = 0; i < contentArray.length; i++) {
                String contentArray1 = contentArray[i];
                if (contentArray1.contains("RETEK ORDER NUMBER:")) {
                    String[] tempData = contentArray1.split("\\s+");
                    styleNumber = tempData[3];
                } else if (contentArray1.contains("VPN")) {
                    String[] tempData = contentArray[i + 2].split("\\s+");
                    poNumber = tempData[0];
                } else {

                    String[] tempData = contentArray1.split("\\s+");
                    for (String tempData1 : tempData) {
                        Pattern p = Pattern.compile("-?\\d+");
                        Matcher m = p.matcher(tempData1);
                        while (m.find()) {
                            if (m.group().length() == 13 && contentArray1.indexOf(m.group()) == 14) {
                                String tempSize = m.group();
                                eanDat.add(tempSize);
                            }
                        }
                    }
                }
            }
        }

        commonData.setEanArr(eanDat);

        for (int i = 0; i < eanDat.size(); i++) {
            String get = eanDat.get(i);
        }
        commonData.setStyleNoUK(styleNumber);
        commonData.setPoNumUK(poNumber);
        return commonData;
    }

    private static void checkStyle() {
        if (styleNumber.contains("-")) {
            int chaIndex = styleNumber.indexOf("-");
            if (chaIndex == 3) {
                commonData.setStyleNoUK(styleNumber);
                commonData.setPoNumUK(poNumber);
            }
            if (chaIndex == 4) {
                commonData.setStyleNoCE(styleNumber);
                commonData.setPoNumCE(poNumber);
            }
        } else {
            int digitCount = 0;
            for (int i = 0, len = styleNumber.length(); i < len; i++) {
                if (Character.isDigit(styleNumber.charAt(i))) {
                    digitCount++;
                }
            }
            if (digitCount == 6) {
                commonData.setStyleNoUK(styleNumber);
                commonData.setPoNumUK(poNumber);
            }
            if (digitCount == 8) {
                commonData.setStyleNoCE(styleNumber);
                commonData.setPoNumCE(poNumber);
            }
        }
    }

    public static List<String> checkForExistEAN(List<String> list) {//594387
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQL = "SELECT EANNO FROM eannotb WHERE EANNO IN (:listArray)";

                SQLQuery query = session.createSQLQuery(SQL);
                query.setParameterList("listArray", list);

                List<String> eanList = query.list();//549

                List<String> sendList = list;

                // System.out.println("eanList.size() :" + eanList.size());

                sendList.removeAll(eanList);

                // System.out.println("list :" + list.size());
                return sendList;

            } catch (Exception e) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
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
