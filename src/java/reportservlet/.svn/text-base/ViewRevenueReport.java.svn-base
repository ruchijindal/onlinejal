/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package reportservlet;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.ExceptionConverter;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.FontSelector;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/**
 *
 * @author smp
 */
public class ViewRevenueReport extends HttpServlet {

    class Eventr extends PdfPageEventHelper {

        public PdfPTable footer;
 protected PdfTemplate total;
        protected BaseFont helv;

        public void onOpenDocument(PdfWriter writer, Document document) {
            total = writer.getDirectContent().createTemplate(100, 100);
            total.setBoundingBox(new Rectangle(-20, -20, 100, 100));
            try {
                helv = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);

            } catch (Exception e) {
                throw new ExceptionConverter(e);
            }
        }

        public void onEndPage(PdfWriter writer, Document document) {
            PdfContentByte cb = writer.getDirectContent();
            cb.saveState();
            String text = "Page " + writer.getPageNumber() + " of ";
            float textBase = document.bottom() - 20;
            float textSize = helv.getWidthPoint(text, 12);
            cb.beginText();
            cb.setFontAndSize(helv, 12);


                float adjust = helv.getWidthPoint("0", 12);
                cb.setTextMatrix(
                        document.right() - textSize - adjust, textBase);
                cb.showText(text);
                cb.endText();
                cb.addTemplate(total, document.right() - adjust, textBase);
//            }
            cb.restoreState();
        }

        public void onCloseDocument(PdfWriter writer, Document document) {
            total.beginText();
            total.setFontAndSize(helv, 12);
            total.setTextMatrix(0, 0);
            total.showText(String.valueOf(writer.getPageNumber() - 1));
            total.endText();
        }

//        @Override
//        public void onEndPage(PdfWriter writer, Document document) {
//            try {
//                Rectangle page = document.getPageSize();
//                PdfPTable table = new PdfPTable(1);
//                table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
//
//                int i = writer.getPageNumber();
//                table.setFooterRows(i);
//                table.addCell(" ");
//                FontSelector fontselectorhd = new FontSelector();
//                fontselectorhd.addFont(new Font(Font.BOLD, 8));
//                Phrase ph1 = fontselectorhd.process("Page-" + i );
//                PdfPCell cell = new PdfPCell(new Phrase(ph1));
//                cell.setHorizontalAlignment(cell.ALIGN_RIGHT);
//                cell.setBorder(Rectangle.NO_BORDER);
//                table.addCell(cell);
//                //this cell will be blank. Yes! we can directly type in a string too above, but in order to
//                //use special fonts for special cell values, we are using a Phrase above
//                table.setTotalWidth(page.getWidth() - document.leftMargin() - document.rightMargin());
//                table.writeSelectedRows(0, -1, document.leftMargin(), document.bottomMargin() + 20, writer.getDirectContent());
//            } catch (Exception ex) {
//                ex.printStackTrace();
//            }
        
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sec;
        String xmlfile = null;
        PreparedStatement pst;
        Connection con;
        ResultSet rs;
        String division;
        NodeList nl;
        ServletContext context;
        ByteArrayOutputStream baos;
        String year;

        sec = request.getParameter("sec");
        division = request.getParameter("division");

        String sql = "select xmlfile from reports_tab where report_type='revenue_report' order by update_dt desc";

        try {
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            con = dataSource.getConnection();
            //context = getServletContext();
            //con = (Connection) context.getAttribute("con");
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            if (rs.next()) {
                xmlfile = rs.getString(1);
            }

System.out.println("xmlfile+++++++++ "+xmlfile);
            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            org.w3c.dom.Document docxml = docBuilder.parse(new InputSource(new StringReader(xmlfile)));


            System.out.println("Root element of the doc is " + docxml.getDocumentElement().getNodeName());




            Rectangle pageSize = new Rectangle(720, 864);
            Document document = new Document(pageSize);

            //PdfWriter.getInstance(document,new FileOutputStream("C:/DEFAULTER"+chll_table+".pdf") );


            NumberFormat formatterno = new DecimalFormat("#0.00");

            baos = new ByteArrayOutputStream();
            PdfWriter docWriter = null;
            docWriter = PdfWriter.getInstance(document, baos);
            Eventr er = new Eventr();
            docWriter.setPageEvent(er);
            //document.setPageSize(PageSize.ARCH_B);
            document.open();

            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            Paragraph paragraph = new Paragraph("");

            PdfPTable thead = new PdfPTable(2);
            thead.setWidthPercentage(100);
            thead.getDefaultCell().setBorder(PdfPCell.BOTTOM);

            String relativeWebPath = "/resources/images/logo.png";
            String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);


            Image image1 = Image.getInstance(absoluteDiskPath);
            image1.scaleAbsolute(100, 30);
            PdfPCell c1 = new PdfPCell();
            c1.addElement(image1);
            c1.setHorizontalAlignment(Element.ALIGN_LEFT);
            c1.setBorder(Rectangle.NO_BORDER);
            c1.setPaddingBottom(10.0f);
            thead.addCell(c1);
            FontSelector fontselectorhd = new FontSelector();
            fontselectorhd.addFont(new Font(Font.BOLD, 10));
            Phrase ph1 = fontselectorhd.process("Date: " + dateFormat.format(new Date()));
            paragraph = new Paragraph(ph1);
            c1 = new PdfPCell(paragraph);
            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c1.setBorder(Rectangle.NO_BORDER);

            thead.addCell(c1);
            document.add(thead);

            float[] widths1 = {1f, 2.5f, 2.5f, 2.5f, 1f};
            PdfPTable table = new PdfPTable(widths1);
            table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);

            PdfPCell cell = new PdfPCell(new Paragraph("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY"));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(20.0f);
            table.addCell(cell);

            if (sec.equals("") || sec == null) {
                if (division.equalsIgnoreCase("jal")) {
                    nl = docxml.getElementsByTagName("revenue_details");


                    NodeList nl1 = nl.item(0).getChildNodes();
                    for (int j = 1; j < nl1.getLength(); j = j + 2) {
                        division = nl1.item(j).getNodeName().trim();

                        cell = new PdfPCell(new Paragraph("REVENUE COLLECTION REPORT FOR " + division.toUpperCase()));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(5);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        if (nl1.item(j).hasChildNodes()) {
                            NodeList nl2 = nl1.item(j).getChildNodes();
                            System.out.println("length is" + nl2.getLength());
                            for (int i = 1; i < nl2.getLength(); i = i + 2) {
                                sec = nl2.item(i).getNodeName().trim();
                                sec = sec.substring(4).toUpperCase();
                                System.out.println("Children is" + sec);

                                cell = new PdfPCell(new Paragraph("REVENUE COLLECTION REPORT FOR SECTOR-" + sec));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setColspan(5);
                                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                cell.setPaddingBottom(15.0f);
                                table.addCell(cell);

                                cell = new PdfPCell(new Paragraph(""));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                cell.setPaddingBottom(15.0f);
                                table.addCell(cell);

                                cell = new PdfPCell(new Paragraph(" PARTICULARS"));
                                cell.setBorder(Rectangle.BOTTOM);
                                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                                cell.setPaddingBottom(15.0f);
                                table.addCell(cell);

                                cell = new PdfPCell(new Paragraph(""));
                                cell.setBorder(Rectangle.BOTTOM);
                                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                cell.setPaddingBottom(15.0f);
                                table.addCell(cell);

                                cell = new PdfPCell(new Paragraph("AMOUNT   "));
                                cell.setBorder(Rectangle.BOTTOM);
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                cell.setPaddingBottom(15.0f);
                                table.addCell(cell);

                                cell = new PdfPCell(new Paragraph(""));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                cell.setPaddingBottom(15.0f);
                                table.addCell(cell);




                                if (nl2.item(i).hasChildNodes()) {
                                    NodeList nl3 = nl2.item(i).getChildNodes();
                                    System.out.println("length is" + nl3.getLength());
                                    for (int k = 1; k < nl3.getLength(); k = k + 2) {
                                        year = nl3.item(k).getNodeName().trim();
                                        System.out.println("Children is" + year);
                                        year = year.substring(5);

                                        if (nl3.item(k).hasChildNodes()) {
                                            NodeList nl4 = nl3.item(k).getChildNodes();
                                            System.out.println("length is" + nl4.getLength());


                                            // normalize text representation
                                            docxml.getDocumentElement().normalize();
                                            System.out.println("Root element of the doc is "
                                                    + docxml.getDocumentElement().getNodeName());

                                            //Total consumer/connections



                                            String str_paidamt = nl4.item(5).getTextContent().trim();


                                            cell = new PdfPCell(new Paragraph(""));
                                            cell.setBorder(Rectangle.NO_BORDER);
                                            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                            cell.setPaddingBottom(10.0f);
                                            cell.setPaddingTop(10.0f);
                                            table.addCell(cell);

                                            cell = new PdfPCell(new Paragraph("TOTAL REVENUE COLLECTION For " + year));
                                            cell.setBorder(Rectangle.NO_BORDER);
                                            cell.setColspan(2);
                                            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                                            cell.setPaddingTop(15.0f);
                                            table.addCell(cell);

                                            cell = new PdfPCell(new Paragraph("Rs. " + formatterno.format(Double.parseDouble(str_paidamt))));
                                            cell.setBorder(Rectangle.NO_BORDER);
                                            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                            cell.setPaddingTop(15.0f);
                                            table.addCell(cell);

                                            cell = new PdfPCell(new Paragraph(""));
                                            cell.setBorder(Rectangle.NO_BORDER);
                                            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                            cell.setPaddingTop(15.0f);
                                            table.addCell(cell);

                                        }
                                    }
                                }
                                cell = new PdfPCell(new Paragraph(""));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setColspan(5);
                                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                cell.setPaddingTop(15.0f);
                                table.addCell(cell);

                                cell = new PdfPCell(new Paragraph(""));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setColspan(5);
                                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                cell.setPaddingTop(15.0f);
                                table.addCell(cell);
                            }
                        }
                        cell = new PdfPCell(new Paragraph(""));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(5);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingTop(15.0f);
                        table.addCell(cell);
                    }

                } else {
                    nl = docxml.getElementsByTagName(division);
                    cell = new PdfPCell(new Paragraph("REVENUE COLLECTION REPORT FOR " + division.toUpperCase()));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(5);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cell.setPaddingBottom(15.0f);
                    table.addCell(cell);
                    NodeList nl2 = nl.item(0).getChildNodes();
                    System.out.println("length is" + nl2.getLength());
                    for (int i = 1; i < nl2.getLength(); i = i + 2) {
                        sec = nl2.item(i).getNodeName().trim();
                        sec = sec.substring(4).toUpperCase();
                        System.out.println("Children is" + sec);

                        // normalize text representation
                        docxml.getDocumentElement().normalize();
                        System.out.println("Root element of the doc is "
                                + docxml.getDocumentElement().getNodeName());

                        //Total consumer/connections

                        cell = new PdfPCell(new Paragraph("REVENUE COLLECTION REPORT FOR SECTOR-" + sec));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(5);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph(""));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph(" PARTICULARS"));
                        cell.setBorder(Rectangle.BOTTOM);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph(""));
                        cell.setBorder(Rectangle.BOTTOM);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph("AMOUNT   "));
                        cell.setBorder(Rectangle.BOTTOM);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph(""));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        if (nl2.item(i).hasChildNodes()) {
                            NodeList nl3 = nl2.item(i).getChildNodes();
                            System.out.println("length is" + nl3.getLength());
                            for (int k = 1; k < nl3.getLength(); k = k + 2) {
                                year = nl3.item(k).getNodeName().trim();
                                System.out.println("Children is" + year);
                                year = year.substring(5);


                                if (nl3.item(k).hasChildNodes()) {
                                    NodeList nl4 = nl3.item(k).getChildNodes();
                                    System.out.println("length is" + nl4.getLength());



                                    cell = new PdfPCell(new Paragraph(""));
                                    cell.setBorder(Rectangle.NO_BORDER);
                                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                    cell.setPaddingBottom(10.0f);
                                    cell.setPaddingTop(10.0f);
                                    table.addCell(cell);


                                    String str_paidamt = nl4.item(5).getTextContent().trim();

                                    cell = new PdfPCell(new Paragraph("TOTAL REVENUE COLLECTION For " + year));
                                    cell.setBorder(Rectangle.NO_BORDER);
                                    cell.setColspan(2);
                                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                                    cell.setPaddingTop(15.0f);
                                    table.addCell(cell);

                                    cell = new PdfPCell(new Paragraph("Rs. " + formatterno.format(Double.parseDouble(str_paidamt))));
                                    cell.setBorder(Rectangle.NO_BORDER);
                                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                    cell.setPaddingTop(15.0f);
                                    table.addCell(cell);

                                    cell = new PdfPCell(new Paragraph(""));
                                    cell.setBorder(Rectangle.NO_BORDER);
                                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                    cell.setPaddingTop(15.0f);
                                    table.addCell(cell);

                                }
                            }

                        }
                        cell = new PdfPCell(new Paragraph(""));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(5);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingTop(15.0f);
                        table.addCell(cell);
                    }
                }
            } else {
                cell = new PdfPCell(new Paragraph("REVENUE COLLECTION REPORT FOR SECTOR-" + sec));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setColspan(5);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(15.0f);
                table.addCell(cell);


                // normalize text representation
                docxml.getDocumentElement().normalize();
                System.out.println("Root element of the doc is "
                        + docxml.getDocumentElement().getNodeName());

                //Total consumer/connections

                cell = new PdfPCell(new Paragraph(""));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(15.0f);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph(" PARTICULARS"));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                cell.setPaddingBottom(15.0f);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph(""));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(15.0f);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph("AMOUNT   "));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cell.setPaddingBottom(15.0f);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph(""));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(15.0f);
                table.addCell(cell);

                nl = docxml.getElementsByTagName("sec_" + sec.trim());
                NodeList nl3 = nl.item(0).getChildNodes();
                System.out.println("length is" + nl3.getLength());
                for (int k = 1; k < nl3.getLength(); k = k + 2) {
                    year = nl3.item(k).getNodeName().trim();
                    System.out.println("Children is" + year);
                    year = year.substring(5);


                    if (nl3.item(k).hasChildNodes()) {
                        NodeList nl4 = nl3.item(k).getChildNodes();
                        System.out.println("length is" + nl4.getLength());


                        cell = new PdfPCell(new Paragraph(""));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingBottom(10.0f);
                        cell.setPaddingTop(10.0f);
                        table.addCell(cell);


                        String str_paidamt = nl4.item(5).getTextContent().trim();


                        cell = new PdfPCell(new Paragraph("TOTAL REVENUE COLLECTION For " + year));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(2);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        cell.setPaddingTop(15.0f);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph("Rs. " + formatterno.format(Double.parseDouble(str_paidamt))));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        cell.setPaddingTop(15.0f);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph(""));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingTop(15.0f);
                        table.addCell(cell);



                    }
                }


            }

            table.setWidthPercentage(100);
            table.setHorizontalAlignment(Element.ALIGN_CENTER);

            document.add(table);

            document.add(new Paragraph("  "));
            document.close();
            docWriter.close();

            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            response.setContentType("application/pdf");
            response.setContentLength(baos.size());
            //System.out.println("ByteArrayOutputStream size"+baos.size());
            ServletOutputStream out = response.getOutputStream();
            baos.writeTo(out);
            out.flush();
            pst.close();
            rs.close();

            con.close();
        } catch (Exception ex) {
            System.out.println(ex);
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
