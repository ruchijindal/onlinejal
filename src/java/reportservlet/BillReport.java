/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package reportservlet;

import bill.generator.*;
//import bill.utility.DBConnection1;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.smp.jal.ConvertToDate;
import com.smp.jal.SelectSec_Div;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
//import oracle.jdbc.OracleConnection;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.NodeList;

/**
 *
 * @author smp
 */
public class BillReport extends HttpServlet {

    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document doc = null;
    NodeList nl = null;
    String xmlpath = null;
    ServletContext context = null;
    String div = null;

    double roundTwoDecimals(double d) {
        DecimalFormat df = new DecimalFormat("#.##");
        return Double.valueOf(df.format(d));
    }

    public class MyPdf implements Runnable {

        int p = 0;
        float p1 = 0;
        int j = 0;
        String cons_no = "-1";
        String sec;
        java.sql.Date due_dt;
        String discount;
        LedgerCalculation bc1;
        Connection con;
        String sector;
        Calendar calbilldate = Calendar.getInstance();
        java.sql.Date billdate;
        String bdate = null;
        ConvertToDate ctd;
        int rows;
        ArrayList<ArrayList<ArrayList>> alsec;
        ArrayList<ArrayList> al;
        ArrayList alrow;
        ResultSet rs;
        ResultSet rs1;
//RequestDispatcher rd;
        PreparedStatement ps;
        int i = 0;
        int totcons = -1;
        Object o;
        String division;
        DocumentBuilderFactory dbf = null;
        DocumentBuilder db = null;
        org.w3c.dom.Document doc = null;
        NodeList nl = null;
        String xmlpath = null;
        ServletContext context = null;
        String div = null;
        java.sql.Date dt;
        String con_tp;
        String blk;
        boolean threaddone = false;
        double arr_sec = 0.0;
        Calendar bl_per_fr = Calendar.getInstance();
        Calendar bl_per_to = Calendar.getInstance();
        int month = -1;
        int year;
        String cons_nm1;
        String cons_ctg;
        String flat_type;
        int pipe_size;
        float plot_size;
        java.sql.Date conn_dt;
        java.sql.Date nodue_dt;
        double rate;
        double bill_amt = 0;
        double totalbill_amt = 0;
        double totalbill_amtformonth = 0;
        java.sql.Date sql_blfr;
        int totcons1 = 0;
        int totcons2 = 0;
        int totcons3 = 0;

        MyPdf() {
        }

        MyPdf(Calendar billdate, String sec1, String div) {
            calbilldate = billdate;
            sec = sec1;
            division = div;

            bc1 = new LedgerCalculation();
            al = new ArrayList<ArrayList>();
            alsec = new ArrayList<ArrayList<ArrayList>>();
            alrow = new ArrayList();
        }

        public void done(boolean b) {
            threaddone = b;
            p = totcons;
        }

        public void run() {

            try {
                FindRate fr = new FindRate();
                ConsumerDetail cd = new ConsumerDetail();


                dbf = DocumentBuilderFactory.newInstance();
                db = dbf.newDocumentBuilder();
                context = getServletContext();
                xmlpath = context.getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                // con = DBConnection1.dbConnection(xmlpath);
                doc = db.parse(xmlpath);
                context = getServletContext();
                String path = context.getRealPath("") + "/resources/xmlreports/bill_report_" + sec + ".xml";
                File file = new File(path);
                if (file.exists()) {
                    file.delete();
                }




                PrintWriter w = new PrintWriter(new FileWriter(path));

                w.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                w.println("<details>");



                w.println("<" + division + ">");
                char number1 = division.charAt((division.length() - 1));
                sector = "Master" + number1;

                String sql1 = "select COUNT(DISTINCT CONS_NO) from " + sector + " where trim(sector)='" + sec + "' and (status= 'A' or status is null) and CONS_NO is not null and (CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and ((FLAT_TYPE is not null and FLAT_TYPE !='PLOT') or (FLAT_TYPE='PLOT' and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null and to_char(CONN_DT,'YYYY-MM-DD')<='" + sql_blfr + "')"
                        + " order by cons_no";

                ps = con.prepareStatement(sql1);

                rs = ps.executeQuery();

                if (rs.next()) {
                    totcons = rs.getInt(1);
                }



                w.println("<sec_" + String.valueOf(sec) + ">");


                month = 3;
                year = 1990;
                while (year != bl_per_to.get(Calendar.YEAR) && month != bl_per_to.get(Calendar.MONTH) && !threaddone) {

                    w.println("<year_" + String.valueOf(year) + "-" + String.valueOf((year + 1)) + ">");
                    for (int m = 0; m < 12 && year != bl_per_to.get(Calendar.YEAR) && !threaddone; m++) {
                        bl_per_fr.set(year, month, 1);

                        sql_blfr = new java.sql.Date(bl_per_fr.getTimeInMillis());


                        String sql = "select distinct cons_no from " + sector + " where  trim()='" + sec + "' and (status= 'A' or status is null) and  CONS_NO is not null and (CONS_NM1 is  not null and CON_TP is not null and CONS_CTG is not null and ((FLAT_TYPE is not null and FLAT_TYPE !='PLOT') or (FLAT_TYPE='PLOT' and PLOT_SIZE is not null)) and PIPE_SIZE is not null and CONN_DT is not null and to_char(CONN_DT,'YYYY-MM-DD')<='" + sql_blfr + "')"
                                + " order by cons_no";


                        ps = con.prepareStatement(sql);

                        rs = ps.executeQuery();



                        while (rs.next() && !threaddone) {

                            //p++;
                            cons_no = rs.getString(1);
                            rs1 = cd.getConsumerDetails(cons_no, sec, xmlpath);

                            if (rs1.next()) {
                                cons_nm1 = (String) rs1.getString(1);
                                if (cons_nm1 != null) {
                                    cons_nm1 = cons_nm1.trim();
                                }
                                con_tp = (String) rs1.getString(2);
                                if (con_tp != null) {
                                    con_tp = con_tp.trim();
                                }
                                cons_ctg = (String) rs1.getString(3);
                                if (cons_ctg != null) {
                                    cons_ctg = cons_ctg.trim();
                                }
                                flat_type = (String) rs1.getString(4);
                                if (flat_type != null) {
                                    flat_type = flat_type.trim();
                                }
                                pipe_size = (int) rs1.getInt(5);

                                plot_size = (float) rs1.getFloat(6);
                                conn_dt = rs1.getDate(7);

                                if (flat_type.equals("PLOT")) {
                                    rate = fr.getRatePlot(con_tp, cons_ctg, flat_type, plot_size, pipe_size, bl_per_fr);
                                } //Rate function for flat
                                else {
                                    rate = fr.getRateFlat(con_tp, cons_ctg, flat_type, pipe_size, bl_per_fr, sec);
                                }

                                //bill_amt=rate*12;
                            }
                            totalbill_amtformonth = totalbill_amtformonth + rate;

                        }

                        w.println("<billamt" + (month + 1) + ">");
                        w.println(totalbill_amtformonth);
                        w.println("</billamt" + (month + 1) + ">");

                        totalbill_amt = totalbill_amt + totalbill_amtformonth;
                        totalbill_amtformonth = 0;
                        if (month != 11) {
                            month++;
                        } else {
                            month = 0;
                        }

                    }

                    w.println("<yearbillamt>");
                    w.println(totalbill_amt);
                    w.println("</yearbillamt>");
                    w.println("</year_" + String.valueOf(year) + "-" + String.valueOf((year + 1)) + ">");
                    year++;
                    totalbill_amt = 0;
                }

                w.println("</sec_" + String.valueOf(sec) + ">");



                p = totcons;
                w.println("</" + division + ">");

                w.println("</details>");
                w.close();

                ps.close();
                rs.close();
                con.commit();
                con.close();
//                if (!con.isClosed()) {
//                    con.close();
//                }
            } catch (Exception ex) {
                System.out.println("Exception in RevenueReport:" + ex);
            }

        }

        public Double calAl() {

            return totalbill_amtformonth;
        }

        public int getPercentage() {
            return p;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String cons_no = null;
        String sec = null;

        Connection con;
        PreparedStatement pst;
        Calendar calbilldate = Calendar.getInstance();
        java.sql.Date billdate;
        String bdate = null;
        ConvertToDate ctd = null;

        String errcons;
        double billamt_permonth = 0;
        ResultSet rs;
//RequestDispatcher rd;
        PreparedStatement ps;
        int i = 0;
        int totcons = 0;
        Object o;

        String division = "Jal1";
        String sql;

        java.sql.Date update_dt = new java.sql.Date(new java.util.Date().getTime());
        String strbill_date = null;

        int x;
        int rows = 0;
        boolean flag4 = false;

        String cons_nm1;

        double principal = 0;

        String dt_mon;
        int mon;
        int yr;

        HttpSession session = request.getSession(true);
        //System.out.print("Inside doGet()");
        MyPdf pdf;

        try {
            String userid = (String) session.getAttribute("userid");
            ctd = new ConvertToDate();
            sec = request.getParameter("sec");
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
            dbf = DocumentBuilderFactory.newInstance();
            db = dbf.newDocumentBuilder();
            doc = db.parse(xmlpath);
            SelectSec_Div sec_Div = new SelectSec_Div();
            division = sec_Div.getDevision(sec, doc);
            o = session.getAttribute("myPdf");
            if (o == null) {
                pdf = new MyPdf(calbilldate, sec, division);
                session.setAttribute("myPdf", pdf);
                Thread t = new Thread(pdf);
                t.start();
            } else {
                pdf = (MyPdf) o;
            }
            response.setContentType("text/html");

            switch (pdf.getPercentage()) {
                case -1:
                    isError(response.getOutputStream());
                    return;

                default:
                    totcons = pdf.totcons;
                    billamt_permonth = pdf.calAl();
                    context = getServletContext();
                    String path = context.getRealPath("") + "/resources/xmlreports/bill_report_" + sec + ".xml";

                    if (pdf.getPercentage() == totcons) {
                        session.removeAttribute("mypdf");
                        //------Insert xml file into database--------------//

                        context = getServletContext();
                        xmlpath = context.getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                        //con = DBConnection1.dbConnection(xmlpath);
                        InitialContext initialContext = new InitialContext();
                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                        con = dataSource.getConnection();
                        path = context.getRealPath("") + "/resources/xmlreports/bill_report_" + sec + ".xml";

                        File xmlfile = new File(path);
                        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                        DocumentBuilder builder = factory.newDocumentBuilder();
                        org.w3c.dom.Document doc = builder.parse(xmlfile);

                        TransformerFactory transformerFactory = TransformerFactory.newInstance();
                        Transformer transformer = transformerFactory.newTransformer();
                        //transformer.setOutputProperty(OutputKeys.INDENT, "yes");

                        StringWriter writer = new StringWriter();
                        StreamResult result = new StreamResult(writer);
                        DOMSource source = new DOMSource(doc);
                        transformer.transform(source, result);
                        String string = writer.toString();
                        System.out.println(string);
                        sql = "select max(id) as high from reports_tab";
                        pst = con.prepareStatement(sql);
                        rs = pst.executeQuery(sql);
                        Long content_id = new Long(0);

                        while (rs.next()) {
                            content_id = rs.getLong("high");
                        }
                        //  {
                        //
                        //if(content_id<rs.getLong("con_id"))
                        //content_id=rs.getLong("con_id");
                        //}
                        if (content_id != null) {
                            content_id = content_id + 1;
                        } else {
                            content_id = new Long(1);
                        }
                        String sql1 = "insert into reports_tab(id,sec,update_dt,xmlfile,report_type) values(" + content_id + ",?,?,?,?)";


                        pst = con.prepareStatement(sql1);
                        pst.setString(1, sec);
                        pst.setDate(2, update_dt);
                        pst.setString(3, string);
                        pst.setString(4, "bill_report");
                        int j = pst.executeUpdate();
//-----------------------------------------------------------------------------------------//

                        isFinished(response.getOutputStream(), sec, path, userid);
                        con.close();
                        System.out.println("bill calculated-----------------------------");
                        return;
                    }

                    isBusy(pdf, response.getOutputStream(), totcons, sec, path, userid);
                    return;
            }
        } catch (Exception ex) {
            System.out.println(ex);
            i = 0;
            response.sendRedirect("jsppages/reports/billamtreport.jsp");
            return;
        }
    }

    private void isBusy(MyPdf pdf, ServletOutputStream stream, int totcons, String sec, String path, String userid)
            throws IOException {
        stream.print("<html><head><title>Please wait...</title><meta http-equiv=\"Refresh\" content=\"5\">"
                + "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" /></head>"
                + "<div id=\"canvas\"><div id=\"header\"><div class=\"inside\"><div class=\"container\"><div id=\"logo\">"
                + "<img SRC=\"resources/images/logo.png\" alt=\"noida_logo\" /></div><div id=\"toolbar\">"
                + "<div class=\"logout\"> <a href=\"/OnlineJal_Example/RedirectToCP?page=BillReport\" >Change Password</a>&nbsp;|&nbsp;<a href=\"jsppages/common/logout.jsp\">Logout</a>"
                + "</div><div class=\"wel\">Welcome " + userid + "</div></div></div></div></div></div>"
                + "<div id=\"heading\"><div class=\"inside\"><div class=\"container\"><div id=\"headinger\"><div class=\"head\"><div class=\"content\">"
                + "<h2>OnlineJal</h2><p>Out of it might be hyperspace hadnt immediate sense of embarrassingly enough</p></div> </div></div> <div id=\"arrowhide\">"
                + "<a href=\"#\" title=\"Hide/Show Slideshow\"></a></div></div></div></div>");
        stream.print("<div id=\"content\"><div class=\"inside\"><div class=\"container\"><div id=\"centerrail\"><div id=\"content\"> <div class=\"inside\">"
                + "<div class=\"container\"><div id=\"contentrail\" class=\"full\"><br/><br/>");

        stream.print("Bill/arrear for year " + pdf.year + " being calculated.");
        stream.print("&nbsp;<br>\nPlease Wait while this page refreshes automatically (every 5 seconds)</div><form action=\"/OnlineJal_Example/CancelBillReport\" method=\"Post\">"
                + "<input type=\"hidden\" name=\"path\" value=\"" + path + "\">"
                + "<input type=\"hidden\" name=\"sec\" value=\"" + sec + "\">"
                + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type=\"Submit\"  class=\"submit\" value=\"Cancel\"></form></div></div></div></div></div></div></div>"
                + "<div id=\"footer\"><div class=\"inside\"><div class=\"container\"><div class=\"left\"><ul><li class=\"first\">"
                + "Copyright &copy; 2009 Developed for NOIDA-JAL by &nbsp;&nbsp; <a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a>"
                + "</li> </ul></div> <div class=\"right\"><ul><li><a href=\"#\">Terms &amp; Condition</a>&nbsp;&nbsp;|&nbsp;&nbsp;"
                + "<a href=\"#\">Privacy Policy</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"#\">Sitemap</a></li><li class=\"last\">"
                + "<a href=\"#canvas\" class=\"scroll\" title=\"Top\">Top</a> &uArr;</li></ul></div></div></div> </div> "
                + "</div></body>\n</html>");

    }

    public void isFinished(ServletOutputStream stream, String sec, String path, String userid) throws IOException {


        stream.print("<html><head><title>Please wait...</title><meta http-equiv=\"Refresh\" content=\"5\">"
                + "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" /></head>"
                + "<div id=\"canvas\"><div id=\"header\"><div class=\"inside\"><div class=\"container\"><div id=\"logo\">"
                + "<img SRC=\"resources/images/logo.png\" alt=\"noida_logo\" /></div><div id=\"toolbar\">"
                + "<div class=\"logout\"> <a href=\"jsppages/common/ch_pwd.jsp\">Change Password</a>&nbsp;|&nbsp;<a href=\"jsppages/common/logout.jsp\">Logout</a>"
                + "</div><div class=\"wel\">Welcome " + userid + "</div></div></div></div></div></div>"
                + "<div id=\"heading\"><div class=\"inside\"><div class=\"container\"><div id=\"headinger\"><div class=\"head\"><div class=\"content\">"
                + "<h2>OnlineJal</h2><p>Out of it might be hyperspace hadnt immediate sense of embarrassingly enough</p></div> </div></div> <div id=\"arrowhide\">"
                + "<a href=\"#\" title=\"Hide/Show Slideshow\"></a></div></div></div></div>");
        stream.print("<div id=\"content\"><div class=\"inside\"><div class=\"container\"><div id=\"centerrail\"><div id=\"content\"> <div class=\"inside\">"
                + "<div class=\"container\"><div id=\"contentrail\" class=\"full\">");

        stream.print("<br/><br/>The document is finished:&nbsp;&nbsp;&nbsp;&nbsp;</div></div><form method=\"POST\" action=\"/OnlineJal_Example/BillReport\">"
                + "<input type=\"hidden\" name=\"path\" value=\"" + path + "\">"
                + "<input type=\"hidden\" name=\"sec\" value=\"" + sec + "\">"
                + "<input type=\"Submit\"  class=\"submit\" value=\"Get PDF\"> <a href=\"jsppages/reports/billamtreport.jsp\"><input type=\"button\"  class=\"submit\" value=\"Back\"></a></form>"
                + "</div></div></div></div></div></div></div></div>"
                + "<div id=\"footer\"><div class=\"inside\"><div class=\"container\"><div class=\"left\"><ul><li class=\"first\">"
                + "Copyright &copy; 2009 Developed for NOIDA-JAL by &nbsp;&nbsp; <a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a>"
                + "</li> </ul></div> <div class=\"right\"><ul><li><a href=\"#\">Terms &amp; Condition</a>&nbsp;&nbsp;|&nbsp;&nbsp;"
                + "<a href=\"#\">Privacy Policy</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"#\">Sitemap</a></li><li class=\"last\">"
                + "<a href=\"#canvas\" class=\"scroll\" title=\"Top\">Top</a> &uArr;</li></ul></div></div></div> </div> "
                + "</div></body>\n</html>");

    }

    private void isError(ServletOutputStream stream) throws IOException {
        stream.print("<html>\n\t<head>\n\t\t<title>Error</title>\n\t</head>\n\t<body>");
        stream.print("An error occured.\n\t</body>\n</html>");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, DocumentException {


        String sec;
        int year;
        int month;
        Object o;

        Calendar bl_fr = Calendar.getInstance();



        ByteArrayOutputStream baos;

        String path;
        sec = (String) request.getParameter("sec");

        context = getServletContext();

        //path=request.getParameter("path");
        path = context.getRealPath("") + "/resources/xmlreports/bill_report_" + sec + ".xml";

        // bl_fr.set(year,month,1);
        int y = bl_fr.get(Calendar.YEAR);
        int m = bl_fr.get(Calendar.MONTH) + 1;

        //response.setContentType("application/pdf");
        Rectangle pageSize = new Rectangle(720, 864);
        Document document = new Document(pageSize);
        try {

            NumberFormat formatterno = new DecimalFormat("#0.00");

            baos = new ByteArrayOutputStream();
            PdfWriter docWriter = null;
            docWriter = PdfWriter.getInstance(document, baos);
            //document.setPageSize(PageSize.ARCH_B);
            document.open();

            float[] widths1 = {1f, 2.5f, 2.5f, 2.5f, 1f};
            PdfPTable table = new PdfPTable(widths1);
            table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);

            PdfPCell cell = new PdfPCell(new Paragraph("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY"));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(20.0f);
            table.addCell(cell);


            cell = new PdfPCell(new Paragraph("BILL AMOUNT REPORT FOR SECTOR-" + sec));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(15.0f);
            table.addCell(cell);

            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            org.w3c.dom.Document docxml = docBuilder.parse(path);

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

            cell = new PdfPCell(new Paragraph("BILL AMOUNT   "));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cell.setPaddingBottom(15.0f);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph(""));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(15.0f);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph(""));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(10.0f);
            cell.setPaddingTop(10.0f);
            table.addCell(cell);

            NodeList nl = docxml.getElementsByTagName("sec_" + sec);
            NodeList nl1 = nl.item(0).getChildNodes();

            NodeList nl2 = docxml.getElementsByTagName("yearbillamt");

            for (int n = 1, l = 0; n < nl1.getLength() && l < nl2.getLength(); n = n + 2, l++) {

                String strbillamt = nl2.item(l).getTextContent().trim();
                String yy = nl1.item(n).getNodeName().trim();

                yy = yy.substring(5);
                System.out.println(yy);

                System.out.println(strbillamt);

                cell = new PdfPCell(new Paragraph("BILL AMOUNT FOR YEAR " + yy));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                cell.setPaddingBottom(10.0f);
                cell.setPaddingTop(10.0f);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph(""));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cell.setPaddingBottom(10.0f);
                cell.setPaddingTop(10.0f);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph(formatterno.format(Double.parseDouble(strbillamt))));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cell.setPaddingBottom(10.0f);
                cell.setPaddingTop(10.0f);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph(""));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(10.0f);
                cell.setPaddingTop(10.0f);
                table.addCell(cell);

                ///////////////////////////////////

                cell = new PdfPCell(new Paragraph(""));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(10.0f);
                cell.setPaddingTop(10.0f);
                table.addCell(cell);

            }


            ////////////////////////////////



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

            File f = new File(path);
            if (f.exists()) {
                f.delete();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {


            processRequest(request, response);
            HttpSession session = request.getSession(false);
            session.removeAttribute("myPdf");
            session.removeAttribute("myPdfcons");


        } catch (DocumentException e) {
            e.printStackTrace();
            response.sendRedirect("jsppages/manager/billamtreport.jsp");
        }
    }
}
