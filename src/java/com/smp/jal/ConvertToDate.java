/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.jal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * @author smp
 */
public class ConvertToDate {

    Calendar dt = Calendar.getInstance();
    DateFormat formatter;
    java.sql.Date sqldt = null;
    java.util.Date utildt = null;

    public java.sql.Date convertStringToDate(String strdt) {

        formatter = new SimpleDateFormat("dd/MM/yy");
        try {
            utildt = (java.util.Date) formatter.parse(strdt);
        } catch (ParseException ex) {
            System.out.println("Exception in ConvertToDate:" + ex);
        }
        sqldt = new java.sql.Date(utildt.getTime());

        return sqldt;

    }

    public Calendar convertStringToCLDate(String strdt) {
        formatter = new SimpleDateFormat("dd/MM/yy");
        try {
            utildt = (java.util.Date) formatter.parse(strdt);
        } catch (ParseException ex) {
            System.out.println("Exception in ConvertToDate:" + ex);
        }
        dt.setTime(utildt);
        return dt;
    }

    public boolean checkNewsMonth(String year, String month, String content_type) {
        //System.out.println("month=====> "+month+content_type);
        boolean flag = false;
        try {
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            Connection con;
            con = dataSource.getConnection();
            //con = (Connection) pageContext.getServletContext().getAttribute("con");
            PreparedStatement pst;

            pst = con.prepareStatement("select to_char(con_date,'Month,yyyy') from jal_content  where content_type=  '" + content_type + "' and to_char(con_date,'dd-mm-yyyy') like '__-" + month + "-" + year + "'");
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                flag = true;
            } else {
                flag = false;
            }
            con.close();
        } catch (Exception ex) {
            System.out.println(ex);
        }
        // System.out.println("flag=====> "+flag);

        return flag;
    }

    public boolean checkYear(String year, String content_type) {
        // System.out.println("year=====> "+year);
        boolean flag = false;
        try {
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            Connection con;
            con = dataSource.getConnection();
            //con = (Connection) pageContext.getServletContext().getAttribute("con");
            PreparedStatement pst;

            pst = con.prepareStatement("select to_char(con_date,'Month,yyyy') from jal_content  where content_type='" + content_type + "' and to_char(con_date,'dd-mm-yyyy') like '__-__-" + year + "'");
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                flag = true;
            } else {
                flag = false;
            }
            con.close();
        } catch (Exception ex) {
            System.out.println(ex);
        }
        // System.out.println("flag=====> "+flag);

        return flag;
    }
}
