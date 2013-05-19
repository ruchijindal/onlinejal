/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package billservlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 *
 * @author smp
 */
public class LedgerExcel extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cons_no = null;
        boolean flag3 = false;
        int k = 0;

        java.util.Date dt1;
        String path;
        ByteArrayOutputStream baos;
        boolean flag = false;
        String cons_nm1 = null;

        String bl_per_fr = null;
        String bl_per_to = null;
        String address;
        String pay_date = null;
        String paid_amt;
        String credit;
        String principal;
        String interest;
        String rate;
        String arrear;

        try {
            cons_no = request.getParameter("cons_no");
            response.setHeader("Cache-Control", "Max-age=0");
            response.setHeader("Pragma", "public");
            response.setDateHeader("Expires", 0);
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment;filename=" + cons_no + ".xls");



            String ledger = "LEDGER FOR CONSUMER NUMBER-" + cons_no;

            PrintWriter out = response.getWriter();
            out.println("<table border=\"0\" width=\"100%\">");
            out.println("<tr></tr>");
            out.println("<tr><th rowspan=2 colspan=18><font size=\"3\" weight=\"normal\">NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY</font></th></tr>");
            out.println("<tr></tr>");
            out.println("<tr><th rowspan=2 colspan=18><font size=\"3\" weight=\"normal\">" + ledger + "</font></th></tr>");
            out.println("<tr></tr>");


            flag3 = false;
            // path=request.getParameter("path");
            HttpSession session = request.getSession();
            String userid = (String) session.getAttribute("userid");
            ServletContext context = getServletContext();
            path = context.getRealPath("") + "/resources/ledger/" + userid + ".xml";

            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            org.w3c.dom.Document docxml = docBuilder.parse(path);

            // normalize text representation
            docxml.getDocumentElement().normalize();
            System.out.println("Root element of the doc is "
                    + docxml.getDocumentElement().getNodeName());


            NodeList consumer = docxml.getElementsByTagName("cons_chl_details");
            int total_cons = consumer.getLength();
            System.out.println("Total no of consumers : " + total_cons);

            flag = true;
            Node cons = consumer.item(0);
            if (cons.getNodeType() == Node.ELEMENT_NODE) {
                k = k + 1;
                org.w3c.dom.Element consElement = (org.w3c.dom.Element) cons;
                NodeList cons_no_list = consElement.getElementsByTagName("cons_no");
                org.w3c.dom.Element cons_noElement = (org.w3c.dom.Element) cons_no_list.item(0);
                NodeList cons_no_text = cons_noElement.getChildNodes();




                cons_no = ((Node) cons_no_text.item(0)).getNodeValue().trim();


                NodeList cons_name_list = consElement.getElementsByTagName("cons_nm1");
                org.w3c.dom.Element consNameElement = (org.w3c.dom.Element) cons_name_list.item(0);
                NodeList cons_nm_text = consNameElement.getChildNodes();



                cons_nm1 = ((Node) cons_nm_text.item(0)).getNodeValue().trim();

                NodeList address_list = consElement.getElementsByTagName("address");
                org.w3c.dom.Element ageElement = (org.w3c.dom.Element) address_list.item(0);
                NodeList address_text = ageElement.getChildNodes();




                address = ((Node) address_text.item(0)).getNodeValue().trim();
                address = address.replace("and", ",");

                if (flag == true) {
                    out.println("<tr><th rowspan=2 colspan=18><font size=\"3\">&nbsp;&nbsp;Consumer No.:&nbsp;&nbsp;" + cons_no.trim() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Consumer Name:&nbsp;&nbsp;" + cons_nm1.trim() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address:&nbsp;&nbsp;" + address + "</font></th></tr>");
                    out.println("<tr></tr>");


                    out.println("<tr><th rowspan=2 colspan=2><font size=\"3\">Bill From</font></th><th rowspan=2 colspan=2><font size=\"3\">Bill Upto</font></th><th rowspan=2 colspan=2><font size=\"3\">Rate</font></th><th rowspan=2 colspan=2><font size=\"3\">Paid Amt</font></th><th rowspan=2  colspan=2><font size=\"3\">Pay Date</font></th><th rowspan=2 colspan=2><font size=\"3\">Credit</font></th><th rowspan=2 colspan=2><font size=\"3\">Principal</font></th><th rowspan=2 colspan=2><font size=\"3\">Interest</font></th><th rowspan=2 colspan=2><font size=\"3\">Arrear</font></th></tr>");
                    out.println("<tr></tr>");
                }
                flag = false;



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



                        bl_per_fr = ((Node) bl_per_fr_text.item(0)).getNodeValue().trim();



                        bl_per_to = ((Node) bl_per_to_text.item(0)).getNodeValue().trim();



                        NodeList ratelist = challanElement.getElementsByTagName("rate");
                        org.w3c.dom.Element rateElement = (org.w3c.dom.Element) ratelist.item(0);
                        NodeList ratetext = rateElement.getChildNodes();


                        rate = ((Node) ratetext.item(0)).getNodeValue().trim();


                        NodeList paid_amtlist = challanElement.getElementsByTagName("paid_amt");
                        org.w3c.dom.Element paid_amtElement = (org.w3c.dom.Element) paid_amtlist.item(0);
                        NodeList paid_amttext = paid_amtElement.getChildNodes();


                        paid_amt = ((Node) paid_amttext.item(0)).getNodeValue().trim();


                        NodeList pay_datelist = challanElement.getElementsByTagName("pay_date");
                        org.w3c.dom.Element pay_dateElement = (org.w3c.dom.Element) pay_datelist.item(0);
                        NodeList pay_datetext = pay_dateElement.getChildNodes();


                        pay_date = ((Node) pay_datetext.item(0)).getNodeValue().trim();


                        NodeList creditlist = challanElement.getElementsByTagName("credit");
                        org.w3c.dom.Element creditElement = (org.w3c.dom.Element) creditlist.item(0);
                        NodeList credittext = creditElement.getChildNodes();


                        credit = ((Node) credittext.item(0)).getNodeValue().trim();


                        NodeList principallist = challanElement.getElementsByTagName("principal");
                        org.w3c.dom.Element principalElement = (org.w3c.dom.Element) principallist.item(0);
                        NodeList principaltext = principalElement.getChildNodes();


                        principal = ((Node) principaltext.item(0)).getNodeValue().trim().replace("-0.0", "0.0");


                        NodeList interestlist = challanElement.getElementsByTagName("interest");
                        org.w3c.dom.Element interestElement = (org.w3c.dom.Element) interestlist.item(0);
                        NodeList interesttext = interestElement.getChildNodes();


                        interest = ((Node) interesttext.item(0)).getNodeValue().trim();


                        NodeList arrearlist = challanElement.getElementsByTagName("arrear");
                        org.w3c.dom.Element arrearElement = (org.w3c.dom.Element) arrearlist.item(0);
                        NodeList arreartext = arrearElement.getChildNodes();


                        arrear = ((Node) arreartext.item(0)).getNodeValue().trim();

                        out.println("<tr><th colspan=2><font size=\"3\">" + bl_per_fr + "</font></th><th colspan=2><font size=\"3\">" + bl_per_to + "</font></th><th colspan=2><font size=\"3\">" + rate + "</font></th><th colspan=2><font size=\"3\">" + paid_amt + "</font></th><th colspan=2><font size=\"3\">" + pay_date + "</font></th><th colspan=2><font size=\"3\">" + credit + "</font></th><th colspan=2><font size=\"3\">" + principal + "</font></th><th colspan=2><font size=\"3\">" + interest + "</font></th><th colspan=2><font size=\"3\">" + arrear + "</font></th></tr>");

                    }//end of inner if clause

                }//end of inner for loop with s var

            }//end of outer if clause





        } catch (SAXParseException err) {
            System.out.println("** Parsing error" + ", line "
                    + err.getLineNumber() + ", uri " + err.getSystemId());
            System.out.println(" " + err.getMessage());
            response.sendRedirect("jsppages/consumer/cons_details.jsp?cons_no=" + cons_no);
            return;

        } catch (SAXException e) {
            Exception x = e.getException();
            ((x == null) ? e : x).printStackTrace();

        } catch (Throwable et) {
            et.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
