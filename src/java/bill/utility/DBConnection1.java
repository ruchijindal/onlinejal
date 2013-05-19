/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bill.utility;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.pool.OracleDataSource;
import org.w3c.dom.NodeList;
import org.w3c.dom.Document;

public class DBConnection1 {

    static OracleConnection con;

    public static OracleConnection dbConnection(String xmlpath) {
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(xmlpath);
            NodeList nl = doc.getElementsByTagName("dburl");
            String dburl = nl.item(0).getFirstChild().getNodeValue().trim();
            NodeList n1 = doc.getElementsByTagName("dbuser");
            String dbuser = n1.item(0).getFirstChild().getNodeValue().trim();
            NodeList n2 = doc.getElementsByTagName("dbpassword");
            String dbpassword = n2.item(0).getFirstChild().getNodeValue().trim();
            OracleDataSource ods = new OracleDataSource();
            ods.setURL(dburl);
            ods.setUser(dbuser);
            ods.setPassword(dbpassword);
            con = (OracleConnection) ods.getConnection();
            con.setReadOnly(true);

        } catch (Exception ex) {
            System.out.println("Database  not connected--------------- " + ex);
        }
        return con;
    }

    public static String getPhone1(String xmlpath) {
        String ph1 = "";
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(xmlpath);
            NodeList nl = doc.getElementsByTagName("ph1");
            ph1 = nl.item(0).getFirstChild().getNodeValue().trim();


        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return ph1;
    }

    public static String getPhone2(String xmlpath) {
        String ph2 = "";
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(xmlpath);
            NodeList n1 = doc.getElementsByTagName("ph2");
            ph2 = n1.item(0).getFirstChild().getNodeValue().trim();


        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return ph2;
    }
}
