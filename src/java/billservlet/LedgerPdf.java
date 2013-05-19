/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package billservlet;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.FontSelector;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
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
public class LedgerPdf extends HttpServlet {

    class Eventr extends PdfPageEventHelper {

        public PdfPTable footer;

        public void onEndPage(PdfWriter writer, Document document) {
            try {
                Rectangle page = document.getPageSize();
                PdfPTable table = new PdfPTable(1);
                table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
                ;
                int i = writer.getPageNumber();
                table.setFooterRows(i);
                table.addCell(" ");
                PdfPCell cell = new PdfPCell(new Phrase("Page-" + i));
                cell.setHorizontalAlignment(cell.ALIGN_CENTER);
                cell.setBorder(Rectangle.NO_BORDER);
                table.addCell(cell);

                table.setTotalWidth(page.getWidth() - document.leftMargin() - document.rightMargin());
                table.writeSelectedRows(0, -1, document.leftMargin(), document.bottomMargin() + 20, writer.getDirectContent());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cons_no = null;
        boolean flag3 = false;
        int k = 0;

        java.util.Date dt1;
        String path;
        ByteArrayOutputStream baos;



        try {

            Document document1 = new Document(PageSize.A4);

            baos = new ByteArrayOutputStream();
            PdfWriter docWriter = null;
            docWriter = PdfWriter.getInstance(document1, baos);
            Eventr er = new Eventr();
            docWriter.setPageEvent(er);
            document1.open();
            float[] widths1 = {1.4f, 1f, 1f, 1f, 1f, 1f, 1f, 1.2f, 1f};
            PdfPTable table = new PdfPTable(widths1);



            table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
            FontSelector fontselectorhd = new FontSelector();
            fontselectorhd.addFont(new Font(Font.TIMES_ROMAN, 13));
            Phrase ph1 = fontselectorhd.process("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY");
            PdfPCell cell = new PdfPCell(new Paragraph(ph1));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(9);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(10.0f);
            table.addCell(cell);

            cons_no = request.getParameter("cons_no");

            FontSelector fontselectorhd1 = new FontSelector();
            fontselectorhd1.addFont(new Font(Font.TIMES_ROMAN, 11));
            Phrase ph2 = fontselectorhd1.process("LEDGER FOR CONSUMER NUMBER - " + cons_no);
            cell = new PdfPCell(new Paragraph(ph2));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(9);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(20.0f);
            table.addCell(cell);
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


            Node cons = consumer.item(0);
            if (cons.getNodeType() == Node.ELEMENT_NODE) {
                k = k + 1;
                org.w3c.dom.Element consElement = (org.w3c.dom.Element) cons;
                NodeList cons_no_list = consElement.getElementsByTagName("cons_no");
                org.w3c.dom.Element cons_noElement = (org.w3c.dom.Element) cons_no_list.item(0);
                NodeList cons_no_text = cons_noElement.getChildNodes();

                FontSelector fontselector1 = new FontSelector();
                fontselector1.addFont(new Font(Font.TIMES_ROMAN, 12));
                Phrase ph3 = fontselector1.process("Consumer No:");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setPaddingBottom(10.0f);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);


                ph3 = fontselector1.process(((Node) cons_no_text.item(0)).getNodeValue().trim());
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setPaddingBottom(10.0f);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);

                NodeList cons_name_list = consElement.getElementsByTagName("cons_nm1");
                org.w3c.dom.Element consNameElement = (org.w3c.dom.Element) cons_name_list.item(0);
                NodeList cons_nm_text = consNameElement.getChildNodes();

                ph3 = fontselector1.process("Consumer Name:");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setPaddingBottom(10.0f);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cell.setColspan(2);
                table.addCell(cell);


                ph3 = fontselector1.process(((Node) cons_nm_text.item(0)).getNodeValue().trim());
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setPaddingBottom(10.0f);
                cell.setColspan(3);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);


                NodeList address_list = consElement.getElementsByTagName("address");
                org.w3c.dom.Element ageElement = (org.w3c.dom.Element) address_list.item(0);
                NodeList address_text = ageElement.getChildNodes();

                ph3 = fontselector1.process("Address:");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setPaddingBottom(10.0f);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);

                String address = ((Node) address_text.item(0)).getNodeValue().trim();
                ph3 = fontselector1.process(address.replaceAll("and", ","));
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setPaddingBottom(10.0f);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);


                ph3 = fontselector1.process("Bill Period");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setColspan(2);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                ph3 = fontselector1.process("Rate");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);

                ph3 = fontselector1.process("Paid Amount");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);

                ph3 = fontselector1.process("Pay Date");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);

                ph3 = fontselector1.process("Credit");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);

                ph3 = fontselector1.process("Principal Amount");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);

                ph3 = fontselector1.process("Remaining Interest");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);

                ph3 = fontselector1.process("Arrear");
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);


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



                        fontselector1.addFont(new Font(Font.BOLD, 10));
                        ph3 = fontselector1.process(((Node) bl_per_fr_text.item(0)).getNodeValue().trim());
                        cell = new PdfPCell(new Paragraph(ph3));
                        cell.setBorder(Rectangle.NO_BORDER);
                        //cell.setPaddingBottom(10.0f);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);


                        ph3 = fontselector1.process(((Node) bl_per_to_text.item(0)).getNodeValue().trim());
                        cell = new PdfPCell(new Paragraph(ph3));
                        cell.setBorder(Rectangle.NO_BORDER);
                        //cell.setPaddingBottom(10.0f);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);


                        NodeList ratelist = challanElement.getElementsByTagName("rate");
                        org.w3c.dom.Element rateElement = (org.w3c.dom.Element) ratelist.item(0);
                        NodeList ratetext = rateElement.getChildNodes();


                        ph3 = fontselector1.process(((Node) ratetext.item(0)).getNodeValue().trim());
                        cell = new PdfPCell(new Paragraph(ph3));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);

                        NodeList paid_amtlist = challanElement.getElementsByTagName("paid_amt");
                        org.w3c.dom.Element paid_amtElement = (org.w3c.dom.Element) paid_amtlist.item(0);
                        NodeList paid_amttext = paid_amtElement.getChildNodes();


                        ph3 = fontselector1.process(((Node) paid_amttext.item(0)).getNodeValue().trim());
                        cell = new PdfPCell(new Paragraph(ph3));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);

                        NodeList pay_datelist = challanElement.getElementsByTagName("pay_date");
                        org.w3c.dom.Element pay_dateElement = (org.w3c.dom.Element) pay_datelist.item(0);
                        NodeList pay_datetext = pay_dateElement.getChildNodes();


                        ph3 = fontselector1.process(((Node) pay_datetext.item(0)).getNodeValue().trim());
                        cell = new PdfPCell(new Paragraph(ph3));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);

                        NodeList creditlist = challanElement.getElementsByTagName("credit");
                        org.w3c.dom.Element creditElement = (org.w3c.dom.Element) creditlist.item(0);
                        NodeList credittext = creditElement.getChildNodes();


                        ph3 = fontselector1.process(((Node) credittext.item(0)).getNodeValue().trim());
                        cell = new PdfPCell(new Paragraph(ph3));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);

                        NodeList principallist = challanElement.getElementsByTagName("principal");
                        org.w3c.dom.Element principalElement = (org.w3c.dom.Element) principallist.item(0);
                        NodeList principaltext = principalElement.getChildNodes();


                        ph3 = fontselector1.process(((Node) principaltext.item(0)).getNodeValue().trim().replace("-0.0", "0.0"));
                        cell = new PdfPCell(new Paragraph(ph3));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);

                        NodeList interestlist = challanElement.getElementsByTagName("interest");
                        org.w3c.dom.Element interestElement = (org.w3c.dom.Element) interestlist.item(0);
                        NodeList interesttext = interestElement.getChildNodes();


                        ph3 = fontselector1.process(((Node) interesttext.item(0)).getNodeValue().trim());
                        cell = new PdfPCell(new Paragraph(ph3));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);

                        NodeList arrearlist = challanElement.getElementsByTagName("arrear");
                        org.w3c.dom.Element arrearElement = (org.w3c.dom.Element) arrearlist.item(0);
                        NodeList arreartext = arrearElement.getChildNodes();


                        ph3 = fontselector1.process(((Node) arreartext.item(0)).getNodeValue().trim());
                        cell = new PdfPCell(new Paragraph(ph3));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);

                    }//end of inner if clause

                }//end of inner for loop with s var

            }//end of outer if clause
            cell = new PdfPCell(new Paragraph(""));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(12);
            cell.setPaddingBottom(20.0f);
            table.addCell(cell);

            table.setWidthPercentage(100);
            table.setHorizontalAlignment(Element.ALIGN_CENTER);
            document1.add(table);
            //document1.newPage();

            document1.add(new Paragraph("  "));
            document1.close();
            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment;filename=" + cons_no + ".pdf");
            response.setContentLength(baos.size());

            ServletOutputStream out = response.getOutputStream();
            baos.writeTo(out);
            out.flush();

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
