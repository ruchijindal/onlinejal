/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package reportservlet;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.NodeList;

/**
 *
 * @author smp
 */
public class ParseXml {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {

            String path = "/home/smp/Desktop/jal.xml";
            String s1, s2, s3, s4;

            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            org.w3c.dom.Document docxml = docBuilder.parse(path);

            // normalize text representation
            //docxml.getDocumentElement ().normalize ();
            System.out.println("Root element of the doc is " + docxml.getDocumentElement().getNodeName());

            NodeList nl = docxml.getElementsByTagName("SectorList");
            NodeList nl1 = nl.item(0).getChildNodes();
            for (int j = 1; j < nl1.getLength(); j = j + 2) {
                s1 = nl1.item(j).getNodeName().trim();
                System.out.println("--------------- " + s1);
                if (nl1.item(j).hasChildNodes()) {
                    NodeList nl2 = nl1.item(j).getChildNodes();
                    System.out.println("length is" + nl2.getLength());
                    for (int i = 1; i < nl2.getLength(); i = i + 2) {
                        s3 = nl2.item(i).getTextContent().trim();
                        System.out.println("Children of " + s1 + " is" + s3);

                    }
                }
            }




        } catch (Exception ex) {
            System.out.println(ex);
        }

    }
}
