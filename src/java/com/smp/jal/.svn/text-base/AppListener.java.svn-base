/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.jal;

import bill.utility.DBConnection1;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;

public class AppListener implements ServletContextListener {

    Connection con;

    public void contextInitialized(ServletContextEvent sce) {
        ServletContext sc = sce.getServletContext();
        String ph1 = DBConnection1.getPhone1(sc.getRealPath("") + "/resources/jalutilXML/" + "jal.xml");
        String ph2 = DBConnection1.getPhone2(sc.getRealPath("") + "/resources/jalutilXML/" + "jal.xml");
        sc.setAttribute("ph1", ph1);
        sc.setAttribute("ph2", ph2);


        try {
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            con = dataSource.getConnection();
            // Class.forName(dbdriver);
            //con = DriverManager.getConnection(dburl, dbuser, dbpassword);
            sc.setAttribute("con", con);
            System.out.println(con);

            System.out.println("Connected:");
        } catch (Exception ex) {
            System.out.println("Exception:++++++++++++++++" + ex);
        }
    }

    public void contextDestroyed(ServletContextEvent arg) {
        try {
            if (!con.isClosed()) {
                con.close();
            }

        } catch (SQLException ex) {
            System.out.println("Exception:-----------------------" + ex);
        }
    }
}
