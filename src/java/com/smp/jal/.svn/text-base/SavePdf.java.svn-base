/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.jal;

import bill.generator.LedgerCalculation;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.ExceptionConverter;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

/**
 *
 * @author smp
 */
public class SavePdf extends HttpServlet {

    String sql;
    Connection con;
    String cons_no;
    String row_id;
    String sector;
    String cons_nm1;
    String con_tp;
    String cons_ctg;
    String flat_type;
    String flat_no;
    String blk_no;
    double plot_size;
    int pipe_size;
    String reg_no;
    String conn_dt;
    String esti_no;
    double esti_amt;
    double secu;
    String esti_dt;
    double esti1_amt;
    double nodue_amt;
    String nodue_dt;
    String trans_nm;
    String trf;
    String bl_per_fr;
    String bl_per_to;
    String due_dt;
    double bill_amt;
    double surcharge;
    double paid_amt;
    String pay_date;
    double arrear;
    double credit;
    String recp_no;
    String dis_cd;
    double noc;
    double t_fee;
    String bnk_cd;
    String br_nm;
    String userrole;
    String sess;
    String sec = null;
    int i;
    int t;
    int x;
    String division = null;
    String address;
    String plotSize;
    String pipeSize;
    String xmlpath;
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document docxml = null;

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
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        NumberFormat formatterno = new DecimalFormat("#0.00");
        try {
            cons_no = (String) session.getAttribute("userid");

            if (cons_no != null && !cons_no.equals("")) {
                int l = (int) cons_no.charAt(7);
                if (l >= 65 && l <= 90) {
                    x = Integer.parseInt(cons_no.substring(0, 2));
                } else {
                    x = Integer.parseInt(cons_no.substring(0, 3));
                }
                sec = Integer.toString(x);
                if (x < 10) {
                    sec = Integer.toString(x);
                    sec = "0" + sec;
                }
            }

            dbf = DocumentBuilderFactory.newInstance();
            db = dbf.newDocumentBuilder();
            xmlpath = getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";
            docxml = db.parse(xmlpath);
            SelectSec_Div sec_Div = new SelectSec_Div();
            division = sec_Div.getDevision(sec, docxml);
            Calendar billdate = Calendar.getInstance();
            LedgerCalculation ledgerCalculation = new LedgerCalculation();
           // billdate.set(billdate.get(Calendar.YEAR), 02, 31);
            ArrayList arrayList = ledgerCalculation.calbillCl(cons_no, billdate, sec, xmlpath);

//            if (sec.equals("01") || sec.equals("02") || sec.equals("03") || sec.equals("04") || sec.equals("05") || sec.equals("06") || sec.equals("07") || sec.equals("08") || sec.equals("09") || sec.equals("10") || sec.equals("11") || sec.equals("11IND") || sec.equals("12")
//                    || sec.equals("14") || sec.equals("14A") || sec.equals("15A") || sec.equals("16A") || sec.equals("15") || sec.equals("16") || sec.equals("17") || sec.equals("18") || sec.equals("19") || sec.equals("22") || sec.equals("23") || sec.equals("24") || sec.equals("27") || sec.equals("55") || sec.equals("56") || sec.equals("57")
//                    || sec.equals("58") || sec.equals("59") || sec.equals("60") || sec.equals("62") || sec.equals("63") || sec.equals("64") || sec.equals("65") || sec.equals("105")) {
//                division = "JAL1";
//            } else if (sec.equals("20") || sec.equals("21") || sec.equals("21A") || sec.equals("25") || sec.equals("26") || sec.equals("28") || sec.equals("29") || sec.equals("30") || sec.equals("31") || sec.equals("33") || sec.equals("33A") || sec.equals("34") || sec.equals("35")
//                    || sec.equals("36") || sec.equals("37") || sec.equals("37ADD") || sec.equals("52") || sec.equals("53") || sec.equals("61") || sec.equals("71") || sec.equals("72")) {
//                division = "JAL2";
//            } else if (sec.equals("39") || sec.equals("40") || sec.equals("41") || sec.equals("43") || sec.equals("44") || sec.equals("46") || sec.equals("47") || sec.equals("48") || sec.equals("49") || sec.equals("50") || sec.equals("51") || sec.equals("52") || sec.equals("73") || sec.equals("80") || sec.equals("81") || sec.equals("82") || sec.equals("83") || sec.equals("84") || sec.equals("94") || sec.equals("95") || sec.equals("92") || sec.equals("93")) {
//                division = "JAL3";
//            }

           char number = division.charAt((division.length() - 1));
            sector = "MASTER" + number;

            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            con = dataSource.getConnection();
            // con = (Connection) getServletContext().getAttribute("con");
            sql = "select cons_nm1,con_tp,cons_ctg,flat_type,flat_no,blk_no,plot_size,pipe_size,reg_no,to_char(conn_dt,'DD-MM-YYYY'),esti_no,esti_amt,secu,to_char(esti_dt,'DD-MM-YYYY'),esti1_amt,nodue_amt,to_char(nodue_dt,'DD-MM-YYYY'),trans_nm,trf,rowid from " + sector + " where trim(cons_no)=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, cons_no.trim());
            ResultSet rs = pst.executeQuery();


            if (rs.next()) {
                cons_nm1 = rs.getString(1);
                con_tp = rs.getString(2);
                if (con_tp.equalsIgnoreCase("R")) {
                    con_tp = "Residential";
                } else if (con_tp.equalsIgnoreCase("T")) {
                    con_tp = "Industrial";
                } else if (con_tp.equalsIgnoreCase("G")) {
                    con_tp = "Group Housing";
                } else if (con_tp.equalsIgnoreCase("C")) {
                    con_tp = "Commercial";
                } else if (con_tp.equalsIgnoreCase("S")) {
                    con_tp = "Staff";
                } else if (con_tp.equalsIgnoreCase("I")) {
                    con_tp = "Industrial";
                }

                cons_ctg = rs.getString(3);
                if (cons_ctg.equalsIgnoreCase("R")) {
                    cons_ctg = "Regular";
                } else if (cons_ctg.equalsIgnoreCase("T")) {
                    cons_ctg = "Temporary";
                }
                flat_type = rs.getString(4);

                flat_no = rs.getString(5);
                blk_no = rs.getString(6);
                if (blk_no == null) {
                    blk_no = "-";
                }
                plot_size = rs.getDouble(7);
                if (String.valueOf(formatterno.format(plot_size)) != null) {
                    plotSize = String.valueOf(formatterno.format(plot_size)) + " Sq Metre";
                }

                pipe_size = rs.getInt(8);
                if (String.valueOf(formatterno.format(pipe_size)) != null) {
                    pipeSize = String.valueOf(formatterno.format(pipe_size)) + " mm";
                }

                reg_no = rs.getString(9);
                if (reg_no == null) {
                    reg_no = "-";
                }
                conn_dt = rs.getString(10);
                if (conn_dt == null) {
                    conn_dt = "-";
                }
                esti_no = rs.getString(11);
                if (esti_no == null) {
                    esti_no = "-";
                }
                esti_amt = rs.getDouble(12);
                secu = rs.getDouble(13);
                esti_dt = rs.getString(14);
                if (esti_dt == null) {
                    esti_dt = "-";
                }
                esti1_amt = rs.getDouble(15);
                nodue_amt = rs.getDouble(16);
                nodue_dt = rs.getString(17);
                if (nodue_dt == null) {
                    nodue_dt = "-";
                }
                trans_nm = rs.getString(18);
                if (trans_nm == null) {
                    trans_nm = "-";
                }

                trf = rs.getString(19);
                if (trf != null && (!(trf.trim()).equals("null"))) {
                    cons_nm1 = trans_nm;
                }
                if (trf == null) {
                    trf = "-";
                }
            }

            address = sec + "/" + blk_no.trim() + "-" + flat_no.trim();

           char number1 = division.charAt((division.length() - 1));
            sector = "CHALLAN" +number1;

            //con = (Connection) getServletContext().getAttribute("con");
            sql = "select to_char(bl_per_fr,'DD-MM-YY'),to_char(bl_per_to,'DD-MM-YY'),to_char(due_dt,'DD-MM-YY'),bill_amt,surcharge,paid_amt,to_char(pay_date,'DD-MM-YY'),arrear,credit,recp_no,dis_cd,noc,secu,t_fee,bnk_cd,br_nm,rowid from " + sector + " where trim(cons_no)=? and bl_per_fr is not null order by bl_per_fr desc";
            pst = con.prepareStatement(sql);
            pst.setString(1, cons_no.trim());
            rs = pst.executeQuery();


            //  Rectangle pageSize = new Rectangle(648, 864);
            Document document = new Document(PageSize.A4);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PdfWriter docWriter = null;
            docWriter = PdfWriter.getInstance(document, baos);
             Eventr er = new Eventr();
            docWriter.setPageEvent(er);

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
            c1.setBorder(Rectangle.BOTTOM);
            c1.setPaddingBottom(10.0f);
            thead.addCell(c1);
            FontSelector fontselectorhd = new FontSelector();
            fontselectorhd.addFont(new Font(Font.BOLD, 10));
            Phrase ph1 = fontselectorhd.process("Date: " + dateFormat.format(new Date()));
            paragraph = new Paragraph(ph1);
            c1 = new PdfPCell(paragraph);
            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c1.setBorder(Rectangle.BOTTOM);

            thead.addCell(c1);
            document.add(thead);


            PdfPTable table = new PdfPTable(14);
            table.setWidthPercentage(100);

            fontselectorhd = new FontSelector();
            fontselectorhd.addFont(new Font(Font.BOLD, 13));
            ph1 = fontselectorhd.process("Consumer Details");
            PdfPCell cell = new PdfPCell(new Paragraph(ph1));

            cell.setBorder(Rectangle.BOTTOM);
            cell.setColspan(14);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPaddingBottom(10.0f);
            table.addCell(cell);


            cell = new PdfPCell(new Paragraph(""));

            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(14);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPaddingBottom(5.0f);
            table.addCell(cell);

            Font f = new Font();
            FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 8));
            Phrase ph;
            FontSelector fontselectorda = new FontSelector();
            fontselectorda.addFont(new Font(Font.TIMES_ROMAN, 8));
            Phrase phda;
            ph = fontselector.process("Consumer No.");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            phda = fontselectorda.process(cons_no);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            ph = fontselector.process("Registration No.");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
//right
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
//cell = new PdfPCell (new Paragraph (due_dt));
            phda = fontselectorda.process(reg_no);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setColspan(3);
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);



            ph = fontselector.process("Consumer Name");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            phda = fontselectorda.process(cons_nm1);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);





            ph = fontselector.process("Connection Date");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
//table.addCell (flat_type);
            phda = fontselectorda.process(conn_dt);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            ph = fontselector.process("Address");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            phda = fontselectorda.process(address);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);


//table.addCell("Category");
            ph = fontselector.process("Estimation No.");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
//table.addCell (cons_ctg);
            phda = fontselectorda.process(esti_no);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            ph = fontselector.process("Connection Type");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            phda = fontselectorda.process(con_tp);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);




            ph = fontselector.process("Estimation Amount");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
//table.addCell (bl_per_fr);
            phda = fontselectorda.process(String.valueOf(formatterno.format(esti_amt)));
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            ph = fontselector.process("Connection Category");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            phda = fontselectorda.process(cons_ctg);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            ph = fontselector.process("Estimation Date");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
//table.addCell (bl_per_to);
            phda = fontselectorda.process(String.valueOf(esti_dt));
            cell = new PdfPCell(phda);
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            ph = fontselector.process("Flat Type");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            phda = fontselectorda.process(flat_type);
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            ph = fontselector.process("No Due Amount");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
//table.addCell (bl_per_to);
            phda = fontselectorda.process(formatterno.format(nodue_amt));
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
            table.setWidthPercentage(100);
            table.setHorizontalAlignment(Element.ALIGN_CENTER);


            ph = fontselector.process("Plot size");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            phda = fontselectorda.process(plotSize);
            cell = new PdfPCell(phda);
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);

            ph = fontselector.process("No Due Issued Upto");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
//cell = new PdfPCell (new Paragraph (due_dt));
            phda = fontselectorda.process(nodue_dt);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setColspan(3);
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            ph = fontselector.process("Pipe Size");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);
            phda = fontselectorda.process(pipeSize);
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);



            table.setWidthPercentage(100);
            table.setHorizontalAlignment(Element.ALIGN_CENTER);

            ph = fontselector.process("Due Amount");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);
            phda = fontselectorda.process((String) arrayList.get(0) + "*");
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);


//            table.setWidthPercentage(100);
//            table.setHorizontalAlignment(Element.ALIGN_CENTER);

            ph = fontselector.process("Due Date");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell);
            phda = fontselectorda.process((String) arrayList.get(1));
            cell = new PdfPCell(new Paragraph(phda));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            ph = fontselector.process("");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
//table.addCell (bl_per_to);

            cell = new PdfPCell(new Paragraph());
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

//table.addCell("Pipe Size");
//table.addCell (String.valueOf(pipe_size));

//table.addCell("Bill Period Upto");

            table.setWidthPercentage(100);
            table.setHorizontalAlignment(Element.ALIGN_CENTER);

            cell = new PdfPCell(new Paragraph());
            cell.setBorder(Rectangle.BOTTOM);
            cell.setColspan(14);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPaddingBottom(2.0f);
            table.addCell(cell);



            ph1 = fontselectorhd.process("Challan Details");

            cell = new PdfPCell(new Paragraph(ph1));

            cell.setBorder(Rectangle.BOTTOM);
            cell.setColspan(14);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPaddingTop(20.0f);
            cell.setPaddingBottom(10.0f);
            table.addCell(cell);

            //float[] widths1 = {1.5f,1.8f,1f,0.7f};
            cell = new PdfPCell(new Paragraph(""));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(14);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPaddingTop(10.0f);
            cell.setPaddingBottom(10.0f);
            table.addCell(cell);
            document.add(table);

            fontselector.addFont(new Font(Font.TIMES_ROMAN, 8));
            float[] width = {5.8f, 5.8f, 5.8f, 6.0f, 6.0f, 6.0f, 5.8f, 6.0f, 7.8f, 6.0f, 7.0f};
            PdfPTable table1 = new PdfPTable(width);
            table1.setWidthPercentage(100);


            Chunk p;
            ph = fontselector.process("Bill Period");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setColspan(2);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);
            // p=new Chunk("Due Date");
            //p.setFont(f);
            ph = fontselector.process("Due Date");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);
            // p=new Chunk("Bill Amt");
            //p.setFont(f);
            ph = fontselector.process("Bill Amt");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);
            //p=new Chunk("Surcharge");
            //p.setFont(f);
            ph = fontselector.process("Surcharge");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);
            //p=new Chunk("Paid Amt");
            // p.setFont(f);
            ph = fontselector.process("Paid Amt");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);
            //p=new Chunk("Pay Date");
            //p.setFont(f);
            ph = fontselector.process("Pay Date");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);

            ph = fontselector.process("Receipt No");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);
            //p=new Chunk("Security");
            //p.setFont(f);
//            ph = fontselector.process("Security");
//            cell = new PdfPCell(new Paragraph(ph));
//            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
//            table1.addCell(cell);
            //p=new Chunk("Transfer fees");
            //p.setFont(f);
            ph = fontselector.process("Transfer Fees");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);
            //p=new Chunk("Bank Code");
            //p.setFont(f);
            ph = fontselector.process("Bank Code");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);
            //p=new Chunk("Bank Name");
            //p.setFont(f);
            ph = fontselector.process("Bank Name");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell);


            while (rs.next()) {
                bl_per_fr = rs.getString(1);
                if (bl_per_fr == null) {
                    bl_per_fr = "-";
                }
                bl_per_to = rs.getString(2);
                if (bl_per_to == null) {
                    bl_per_to = "-";
                }
                due_dt = rs.getString(3);
                if (due_dt == null) {
                    due_dt = "-";
                }
                bill_amt = rs.getDouble(4);
                surcharge = rs.getDouble(5);
                paid_amt = rs.getDouble(6);
                pay_date = rs.getString(7);
                if (pay_date == null) {
                    pay_date = "-";
                }
                // arrear = rs.getDouble(8);
                //credit = rs.getDouble(9);
                recp_no = rs.getString(10);
                if (recp_no == null) {
                    recp_no = "-";
                }
                dis_cd = rs.getString(11);
                if (dis_cd == null) {
                    dis_cd = "-";
                }
                noc = rs.getDouble(12);

                t_fee = rs.getDouble(14);
                bnk_cd = rs.getString(15);
                if (bnk_cd == null) {
                    bnk_cd = "-";
                }
                br_nm = rs.getString(16);
                if (br_nm == null) {
                    br_nm = "-";
                }

                FontSelector fontselector1 = new FontSelector();
                fontselector1.addFont(new Font(Font.BOLD, 7));
                ph = fontselector1.process(bl_per_fr);
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table1.addCell(cell);

                ph = fontselector1.process(bl_per_to);
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table1.addCell(cell);
                ph = fontselector1.process(due_dt);
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table1.addCell(cell);

                ph = fontselector1.process(formatterno.format(bill_amt));
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table1.addCell(cell);
                ph = fontselector1.process(formatterno.format(surcharge));
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table1.addCell(cell);
                ph = fontselector1.process(formatterno.format(paid_amt));
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table1.addCell(cell);
                ph = fontselector1.process(pay_date);
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table1.addCell(cell);
//                ph = fontselector1.process(formatterno.format(arrear));
//                table1.addCell(new Phrase(ph));
//                ph = fontselector1.process(formatterno.format(credit));
//                table1.addCell(new Phrase(ph));
                ph = fontselector1.process(recp_no);
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table1.addCell(cell);
//                ph = fontselector1.process(formatterno.format(secu));
//                cell = new PdfPCell(new Paragraph(ph));
//                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
//                table1.addCell(cell);
                ph = fontselector1.process(formatterno.format(t_fee));
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table1.addCell(cell);
                ph = fontselector1.process(bnk_cd);
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table1.addCell(cell);
                ph = fontselector1.process(br_nm);
                cell = new PdfPCell(new Paragraph(ph));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table1.addCell(cell);


            }


            document.add(table1);
            // document.add(table1);


            PdfPTable table2 = new PdfPTable(2);
            table2.setWidthPercentage(100);
            table2.setSpacingAfter(10);
            ph = fontselector.process("*This amount is calculated on the records available in our database. The actual amount may be differ.If already paid please ignore.(E. & O.E)");

            cell = new PdfPCell(new Paragraph(ph));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(2);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.setWidthPercentage(100);
            table2.addCell(cell);

            cell = new PdfPCell(new Paragraph());
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(2);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.setWidthPercentage(100);
            table2.addCell(cell);

            cell = new PdfPCell(new Paragraph());
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(2);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.setWidthPercentage(100);
            table2.addCell(cell);

            FontSelector fontselector1 = new FontSelector();
            fontselector1.addFont(new Font(Font.BOLD, 8));
            ph = fontselector1.process("SAVE WATER FOR NATION");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setBorder(Rectangle.NO_BORDER);

            table2.addCell(cell);

            ph = fontselector1.process("CLEAN NOIDA GREEN NOIDA");
            cell = new PdfPCell(new Paragraph(ph));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

            cell.setBorder(Rectangle.NO_BORDER);
            table2.addCell(cell);

            document.add(table2);
             document.add(new Paragraph("  "));
            document.close();
            docWriter.close();

            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment;filename=" + cons_no + ".pdf");
            response.setContentLength(baos.size());
            //System.out.println("ByteArrayOutputStream size"+baos.size());
            ServletOutputStream sos = response.getOutputStream();
            baos.writeTo(sos);
            sos.flush();
             pst.close();
            rs.close();

            con.close();
        } catch (Exception e) {
            System.err.println("Exception in dopost" + e);
            //RequestDispatcher rd=request.getRequestDispatcher("jsppages/billing/billgen.jsp");
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
