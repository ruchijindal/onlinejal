/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.jal;

import java.util.ArrayList;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.omg.PortableServer.REQUEST_PROCESSING_POLICY_ID;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

import org.w3c.dom.NodeList;

/**
 *
 * @author smp
 */
public class SelectSec_Div {

    boolean threaddone = false;
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
     org.w3c.dom.Document docxml = null;
 public ArrayList<String> getSectorList1(String div, String xmlPath) {

        ArrayList<String> arr = new ArrayList<String>();

        try {
             dbf = DocumentBuilderFactory.newInstance();
                        db = dbf.newDocumentBuilder();
                        docxml=db.parse(xmlPath);
            docxml.getDocumentElement().normalize();
            NodeList nl = docxml.getElementsByTagName(div);
            NodeList nl1 = nl.item(0).getChildNodes();
            for (int j = 1; j < nl1.getLength() && !threaddone; j = j + 2) {
                String sec = nl1.item(j).getTextContent().trim();
                 arr.add(sec);
            }


        } catch (Exception ex) {
            System.out.println("Exception in consumer reports:" + ex);
        }
        return arr;

    }
  
    public ArrayList getSectorList(String div, org.w3c.dom.Document docxml) {

        ArrayList<String> arr = new ArrayList<String>();

        try {
            docxml.getDocumentElement().normalize();
            NodeList nl = docxml.getElementsByTagName(div);
            NodeList nl1 = nl.item(0).getChildNodes();
            for (int j = 1; j < nl1.getLength() && !threaddone; j = j + 2) {
                String sec = nl1.item(j).getTextContent().trim();
                 arr.add(sec);
            }


        } catch (Exception ex) {
            System.out.println("Exception in consumer reports:" + ex);
        }
        return arr;

    }

    public String getDevision(String sec, org.w3c.dom.Document docxml) {
         //System.out.println("=-----sector-->"+sec);
        String div = "";
        NodeList nl = docxml.getElementsByTagName("SectorList");
        System.out.println("Length-->"+nl.getLength());
        NodeList nl1 = nl.item(0).getChildNodes();
        System.out.println("Length1-->"+nl1.getLength());
        for (int j = 1; j < nl1.getLength() && !threaddone; j = j + 2) {
         NodeList nl2 = nl1.item(j).getChildNodes();
         // System.out.println("division----------------------------------------------------------------------->"+nl1.item(j).getNodeName().trim());
         for (int k = 0; k < nl2.getLength() && !threaddone; k = k + 1) {


                   // System.out.println("sector-->"+((Node)nl2.item(k)).getTextContent());
                if (nl2.item(k).getTextContent().trim().equals(sec.trim())) {
                    div = nl1.item(j).getNodeName().trim();
                   //  System.out.println("div-->"+nl1.item(j).getNodeName().trim());
                    break;
                }

            }
            if (!div.equals("")) {
                break;
            }


        }

        //System.out.println("in div Div-->"+div+"=-----sector-->"+sec);
        return div;
}
}
