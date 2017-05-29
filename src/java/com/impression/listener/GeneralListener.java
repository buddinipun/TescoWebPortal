/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.listener;

import com.impression.util.NewHibernateUtil;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author User
 */
public class GeneralListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        NewHibernateUtil.CreateSessionFactory();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        NewHibernateUtil.closeSessionFactory();
    }

}
