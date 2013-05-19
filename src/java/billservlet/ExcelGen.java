/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package billservlet;

import java.io.PrintWriter;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.NodeList;
import org.w3c.dom.Node;

import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 *
 * @author smp
 */
public class ExcelGen extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cons_no = null;
        String sec = null;
        String form;

        int k = 0;

        String path;

        String ledger;

        response.setHeader("Cache-Control", "Max-age=0");
        response.setHeader("Pragma", "public");
        response.setDateHeader("Expires", 0);
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + "LedgerReport.xls");

        form = request.getParameter("form");

        if (form.equals("f1")) {
            cons_no = request.getParameter("cons_no");
            ledger = "LEDGER FOR CONSUMER NUMBER-" + cons_no;
        } else {
            sec = request.getParameter("sec");
            ledger = "LEDGER FOR SECTOR-" + sec;
        }

        path = request.getParameter("path");
        try {
            PrintWriter out = response.getWriter();
            out.println("<table border=\"1\" width=\"100%\">");
            out.println("<tr></tr>");
            out.println("<tr><th rowspan=2 colspan=18><font size=\"4\">NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY</font></th></tr>");
            out.println("<tr></tr>");
            out.println("<tr><th rowspan=2 colspan=18><font size=\"3\">" + ledger + "</font></th></tr>");
            out.println("<tr></tr>");

            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            org.w3c.dom.Document docxml = docBuilder.parse(path);

            // normalize text representation
            docxml.getDocumentElement().normalize();

            NodeList consumer = docxml.getElementsByTagName("cons_chl_details");
            int total_cons = consumer.getLength();
            //System.out.println("Total no of consumers : " +total_cons);

            for (int s = 0; s < consumer.getLength(); s++) {
                Node cons = consumer.item(s);
                if (cons.getNodeType() == Node.ELEMENT_NODE) {
                    k = k + 1;
                    org.w3c.dom.Element consElement = (org.w3c.dom.Element) cons;

                    NodeList cons_no_list = consElement.getElementsByTagName("cons_no");
                    org.w3c.dom.Element cons_noElement = (org.w3c.dom.Element) cons_no_list.item(0);
                    NodeList cons_no_text = cons_noElement.getChildNodes();

                    NodeList cons_name_list = consElement.getElementsByTagName("cons_nm1");
                    org.w3c.dom.Element consNameElement = (org.w3c.dom.Element) cons_name_list.item(0);
                    NodeList cons_nm_text = consNameElement.getChildNodes();

                    NodeList address_list = consElement.getElementsByTagName("address");
                    org.w3c.dom.Element ageElement = (org.w3c.dom.Element) address_list.item(0);
                    NodeList address_text = ageElement.getChildNodes();

                    out.println("<tr><th rowspan=2 colspan=18><font size=\"3\">" + k + ".&nbsp;&nbsp;Consumer No.:&nbsp;&nbsp;" + (((Node) cons_no_text.item(0)).getNodeValue().trim()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Consumer Name:&nbsp;&nbsp;" + (((Node) cons_nm_text.item(0)).getNodeValue().trim()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address:&nbsp;&nbsp;" + (((Node) address_text.item(0)).getNodeValue().trim()) + "</font></th></tr>");
                    out.println("<tr></tr>");


                    out.println("<tr><th rowspan=2 colspan=2><font size=\"3\">Bill From</font></th><th rowspan=2 colspan=2><font size=\"3\">Bill Upto</font></th><th rowspan=2 colspan=2><font size=\"3\">Rate</font></th><th rowspan=2 colspan=2><font size=\"3\">Paid Amt</font></th><th rowspan=2  colspan=2><font size=\"3\">Pay Date</font></th><th rowspan=2 colspan=2><font size=\"3\">Credit</font></th><th rowspan=2 colspan=2><font size=\"3\">Principal</font></th><th rowspan=2 colspan=2><font size=\"3\">Interest</font></th><th rowspan=2 colspan=2><font size=\"3\">Arrear</font></th></tr>");
                    out.println("<tr></tr>");

                    NodeList challan = consElement.getElementsByTagName("challan");
                    int total_challans = challan.getLength();
                    //System.out.println("Total no of challan : " +total_challans);
                    for (int chls = 0; chls < challan.getLength(); chls++) {
                        Node challans = challan.item(chls);
                        if (challans.getNodeType() == Node.ELEMENT_NODE) {
                            org.w3c.dom.Element challanElement = (org.w3c.dom.Element) challans;

                            NodeList bl_per_fr_list = challanElement.getElementsByTagName("bl_per_fr");
                            org.w3c.dom.Element bl_per_frElement = (org.w3c.dom.Element) bl_per_fr_list.item(0);
                            NodeList bl_per_fr_text = bl_per_frElement.getChildNodes();



                            NodeList bl_per_to_list = challanElement.getElementsByTagName("bl_per_to");
                            org.w3c.dom.Element bl_per_toElement = (org.w3c.dom.Element) bl_per_to_list.item(0);
                            NodeList bl_per_to_text = bl_per_toElement.getChildNodes();



                            NodeList ratelist = challanElement.getElementsByTagName("rate");
                            org.w3c.dom.Element rateElement = (org.w3c.dom.Element) ratelist.item(0);
                            NodeList ratetext = rateElement.getChildNodes();



                            NodeList paid_amtlist = challanElement.getElementsByTagName("paid_amt");
                            org.w3c.dom.Element paid_amtElement = (org.w3c.dom.Element) paid_amtlist.item(0);
                            NodeList paid_amttext = paid_amtElement.getChildNodes();



                            NodeList pay_datelist = challanElement.getElementsByTagName("pay_date");
                            org.w3c.dom.Element pay_dateElement = (org.w3c.dom.Element) pay_datelist.item(0);
                            NodeList pay_datetext = pay_dateElement.getChildNodes();



                            NodeList creditlist = challanElement.getElementsByTagName("credit");
                            org.w3c.dom.Element creditElement = (org.w3c.dom.Element) creditlist.item(0);
                            NodeList credittext = creditElement.getChildNodes();



                            NodeList principallist = challanElement.getElementsByTagName("principal");
                            org.w3c.dom.Element principalElement = (org.w3c.dom.Element) principallist.item(0);
                            NodeList principaltext = principalElement.getChildNodes();



                            NodeList interestlist = challanElement.getElementsByTagName("interest");
                            org.w3c.dom.Element interestElement = (org.w3c.dom.Element) interestlist.item(0);
                            NodeList interesttext = interestElement.getChildNodes();


                            NodeList arrearlist = challanElement.getElementsByTagName("arrear");
                            org.w3c.dom.Element arrearElement = (org.w3c.dom.Element) arrearlist.item(0);
                            NodeList arreartext = arrearElement.getChildNodes();

                            out.println("<tr><th colspan=2><font size=\"3\">" + (((Node) bl_per_fr_text.item(0)).getNodeValue().trim()) + "</font></th><th colspan=2><font size=\"3\">" + (((Node) bl_per_to_text.item(0)).getNodeValue().trim()) + "</font></th><th colspan=2><font size=\"3\">" + (((Node) ratetext.item(0)).getNodeValue().trim()) + "</font></th><th colspan=2><font size=\"3\">" + (((Node) paid_amttext.item(0)).getNodeValue().trim()) + "</font></th><th colspan=2><font size=\"3\">" + (((Node) pay_datetext.item(0)).getNodeValue().trim()) + "</font></th><th colspan=2><font size=\"3\">" + (((Node) credittext.item(0)).getNodeValue().trim()) + "</font></th><th colspan=2><font size=\"3\">" + (((Node) principaltext.item(0)).getNodeValue().trim().replace("-0.0", "0.0")) + "</font></th><th colspan=2><font size=\"3\">" + (((Node) interesttext.item(0)).getNodeValue().trim()) + "</font></th><th colspan=2><font size=\"3\">" + (((Node) arreartext.item(0)).getNodeValue().trim()) + "</font></th></tr>");
                            //out.println("<tr></tr>");


                        }//end of inner if clause

                    }//end of inner for loop with s var

                }//end of outer if clause


            }//end of outer for loop with s var



            out.println("</table>");

        } catch (SAXParseException err) {
            System.out.println("** Parsing error" + ", line "
                    + err.getLineNumber() + ", uri " + err.getSystemId());
            System.out.println(" " + err.getMessage());
            response.sendRedirect("jsppages/billing/ledgergen.jsp");
            return;

        } catch (SAXException e) {
            Exception x = e.getException();
            ((x == null) ? e : x).printStackTrace();

        } catch (Throwable et) {
            et.printStackTrace();
        }


    }
}
