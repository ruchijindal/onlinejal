/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package billservlet;

import bill.generator.*;
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
import java.text.Format;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 *
 * @author smp
 */
public class CreditorGen extends HttpServlet {

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
        BillCalculation bc;
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
        RequestDispatcher rd;
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
                dbf = DocumentBuilderFactory.newInstance();
                db = dbf.newDocumentBuilder();
                context = getServletContext();
                xmlpath = context.getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                  InitialContext initialContext=new InitialContext();
        DataSource dataSource=(DataSource)initialContext.lookup("OnlineJal");
        con=dataSource.getConnection();
                //con = DBConnection1.dbConnection(xmlpath);


                doc = db.parse(xmlpath);
                 char number = division.charAt((division.length() - 1));
                sector = "MASTER" + number;

                String sql1 = "select COUNT(DISTINCT CONS_NO) from " + sector + " where trim(sector)='" + sec + "' and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CON_TP!='S' and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null"
                        + " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'" + billdate + "') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'" + billdate + "')) order by cons_no";

                ps =  con.prepareStatement(sql1);

                rs = ps.executeQuery();

                if (rs.next()) {
                    totcons = rs.getInt(1);
                }


                String sql = "select DISTINCT CONS_NO from " + sector + " where trim(sector)='" + sec + "' and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CON_TP!='S' and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null"
                        + " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'" + billdate + "') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'" + billdate + "')) order by cons_no";


                ps =  con.prepareStatement(sql);

                rs =  ps.executeQuery();

                while (rs.next() && !threaddone) {

                    p++;
                    cons_no = rs.getString(1);
                    al = bc1.calbillCl(cons_no, calbilldate, sec, xmlpath);
                    for (int m = 0; m < al.size(); m++) {
                        alrow = al.get(m);

                        if (alrow.get(11) != null) {
                            dt = new java.sql.Date(((Calendar) alrow.get(11)).getTimeInMillis());
                            // alrow.set(11, dt);

                            alrow.add(11, dt);
                            alrow.remove(12);
                        }
                        if (alrow.get(12) != null) {
                            dt = new java.sql.Date(((Calendar) alrow.get(12)).getTimeInMillis());
                            //alrow.set(12, dt);

                            alrow.add(12, dt);
                            alrow.remove(13);
                        }
                        if (alrow.get(17) != null) {
                            dt = new java.sql.Date(((Calendar) alrow.get(17)).getTimeInMillis());
                            // alrow.set(17, dt);

                            alrow.add(17, dt);
                            alrow.remove(18);
                        }
                        if (alrow.get(21) != null) {
                            dt = new java.sql.Date(((Calendar) alrow.get(21)).getTimeInMillis());
                            //alrow.set(21, dt);

                            alrow.add(21, dt);
                            alrow.remove(22);
                        }

                        if (alrow.get(23) != null) {
                            dt = new java.sql.Date(((Calendar) alrow.get(23)).getTimeInMillis());
                            //alrow.set(21, dt);

                            alrow.add(23, dt);
                            alrow.remove(24);
                        }

                    }
                    if (al.size() != 0) {
                        alsec.add(new <ArrayList>ArrayList(al));
                    }
                    al.clear();
                    //Thread.sleep(500);
                }
                rs.close();
                con.commit();
                con.close();
//                if (!con.isClosed()) {
//                    con.close();
//                }
            } catch (Exception ex) {
                System.out.println("Exception in DefaulterGen:" + ex);
            }
            //  p=totcons;

        }

        public ArrayList<ArrayList<ArrayList>> calAl() {

            return alsec;
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

        String f1 = null;
        String f2 = null;
        Connection con;
        String sector;


        Calendar calbilldate = Calendar.getInstance();
        java.sql.Date billdate;
        String bdate = null;
        ConvertToDate ctd = null;

        String errcons;
        ArrayList<ArrayList<ArrayList>> alsec;
        ArrayList<ArrayList> al;
        ArrayList alrow;
        ResultSet rs;
        RequestDispatcher rd;
       PreparedStatement ps;
        int i = 0;
        int totcons = 0;
        Object o;

        String division = null;
        String sql;

        String blk = null;
        String con_tp = null;
        String cons_no_fr = null;
        String cons_no_to = null;
        String strbill_date = null;

        int x;
        int rows = 0;
        boolean flag4 = false;

        String cons_nm1;

        String blk_no;
        String flat_no;

        String bl_per_fr = null;
        String bl_per_to = null;
        double rate = 0;
        PreparedStatement pst;
        java.sql.Date update_dt = new java.sql.Date(new java.util.Date().getTime());
        double arrear = 0;
        double interest = 0;
        String pay_date = null;
        double paid_amt = 0;
        double credit = 0;
        double principal = 0;

        java.sql.Date dt;
        java.util.Date dt_upto = null;
        Format formatter;

        HttpSession session = request.getSession(true);
        //System.out.print("Inside doGet()");
        MyPdf pdf;

        try {
            String userid = (String) session.getAttribute("userid");
            alsec = new <ArrayList>ArrayList();
            ctd = new ConvertToDate();
            sec = request.getParameter("sec");
            sec = sec.trim();
//            if (sec.equals("01") || sec.equals("02") || sec.equals("03") || sec.equals("04") || sec.equals("05") || sec.equals("06") || sec.equals("07") || sec.equals("08") || sec.equals("09") || sec.equals("10") || sec.equals("11") || sec.equals("11IND") || sec.equals("12")
//                    || sec.equals("14") || sec.equals("14A") || sec.equals("15A") || sec.equals("16A") || sec.equals("15") || sec.equals("16") || sec.equals("17") || sec.equals("18") || sec.equals("19") || sec.equals("22") || sec.equals("23") || sec.equals("24") || sec.equals("27") || sec.equals("55") || sec.equals("56") || sec.equals("57")
//                    || sec.equals("58") || sec.equals("59") || sec.equals("60") || sec.equals("62") || sec.equals("63") || sec.equals("64") || sec.equals("65") || sec.equals("105")) {
//                division = "JAL1";
//            } else if (sec.equals("20") || sec.equals("21") || sec.equals("21A") || sec.equals("25") || sec.equals("26") || sec.equals("28") || sec.equals("29") || sec.equals("30") || sec.equals("31") || sec.equals("33") || sec.equals("33A") || sec.equals("34") || sec.equals("35")
//                    || sec.equals("36") || sec.equals("37") || sec.equals("37ADD") || sec.equals("52") || sec.equals("53") || sec.equals("61") || sec.equals("71") || sec.equals("72")) {
//                division = "JAL2";
//            } else if (sec.equals("39") || sec.equals("40") || sec.equals("41") || sec.equals("43") || sec.equals("44") || sec.equals("46") || sec.equals("47") || sec.equals("48") || sec.equals("49") || sec.equals("50") || sec.equals("51") || sec.equals("52") || sec.equals("73") || sec.equals("80") || sec.equals("81") || sec.equals("82") || sec.equals("83") || sec.equals("84") || sec.equals("92") || sec.equals("93") || sec.equals("94") || sec.equals("95")) {
//                division = "JAL3";
//            }
            dbf = DocumentBuilderFactory.newInstance();
            db = dbf.newDocumentBuilder();
            doc = db.parse(xmlpath);
            SelectSec_Div sec_Div = new SelectSec_Div();
            division = sec_Div.getDevision(sec, doc);

            bdate = request.getParameter("billdate");
            strbill_date = bdate;
            if (bdate.equals("")) {
                billdate = null;
                calbilldate = null;
            } else {
                calbilldate.setTimeInMillis(ctd.convertStringToCLDate(bdate).getTimeInMillis());
                billdate = new java.sql.Date(calbilldate.getTimeInMillis());
            }


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
                    alsec = pdf.calAl();
                    context = getServletContext();
                    String path = context.getRealPath("") + "/resources/xmlreports/creditor_report_" + sec.trim() + ".xml";
                    File file = new File(path);
                    if (file.exists()) {
                        file.delete();
                    }
                    PrintWriter w = new PrintWriter(new FileWriter(path));
                    rows = alsec.size();
                    w.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                    w.println("<details>");


                    for (int k = 0; k < rows; k++) {
                        al = (ArrayList<ArrayList>) alsec.get(k);

                        int r = al.size();

                        alrow = (ArrayList) al.get(r - 1);
                        arrear = Double.parseDouble(alrow.get(20).toString());
                        if (arrear > 0) {
                            w.println("<cons_chl_details>");
                            cons_no = (String) alrow.get(0);
                            if (cons_no == null) {
                                cons_no = " ";
                            }
                            w.println("<cons_no>");
                            w.println(cons_no);
                            w.println("</cons_no>");
                            cons_nm1 = (String) alrow.get(1);
                            if (cons_nm1 == null) {
                                cons_nm1 = " ";
                            }
                            w.println("<cons_nm1>");
                            w.println(cons_nm1.replaceAll("&", "and"));
                            w.println("</cons_nm1>");
                            sec = (String) alrow.get(8);
                            if (sec == null) {
                                sec = " ";
                            }
                            blk_no = (String) alrow.get(7);
                            if (blk_no == null) {
                                blk_no = " ";
                            }
                            flat_no = (String) alrow.get(6);
                            if (flat_no == null) {
                                flat_no = " ";
                            }
                            w.println("<address>");
                            w.println(blk_no.replaceAll("&", "and").trim() + "-" + flat_no.replaceAll("&", "and").trim() + "/" + sec.replaceAll("&", "and").trim());
                            w.println("</address>");
                            //w.println("<challans>");

                            rate = Double.parseDouble(alrow.get(14).toString());


                            paid_amt = Double.parseDouble(alrow.get(16).toString());


                            credit = Double.parseDouble(alrow.get(20).toString());


                            principal = Double.parseDouble(alrow.get(28).toString());

                            arrear = Double.parseDouble(alrow.get(19).toString());

                            interest = Double.parseDouble(alrow.get(34).toString());

                            rate = roundTwoDecimals(rate);


                            arrear = roundTwoDecimals(arrear);
                            w.println("<credit>");
                            w.println(credit);
                            w.println("</credit>");

                            w.println("</cons_chl_details>");
                        }
                    }
                    w.println("</details>");
                    w.close();
                    if (pdf.getPercentage() == totcons) {
                        session.removeAttribute("mypdf");

                        //------Insert xml file into database--------------//

                        context = getServletContext();
                        xmlpath = context.getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                          InitialContext initialContext=new InitialContext();
        DataSource dataSource=(DataSource)initialContext.lookup("OnlineJal");
        con=dataSource.getConnection();
                       // con = DBConnection1.dbConnection(xmlpath);
                        path = context.getRealPath("") + "/resources/xmlreports/creditor_report_" + sec.trim() + ".xml";

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
          sql="select max(id) as high from reports_tab";
                 pst=con.prepareStatement(sql);
          rs=pst.executeQuery(sql);
                   Long content_id=new Long(0);

                 while(rs.next())
                     {
                     content_id=rs.getLong("high");
                     }
                   //  {
                     //
                       //if(content_id<rs.getLong("con_id"))
                        //content_id=rs.getLong("con_id");
                     //}
                     if(content_id!=null){
                 content_id=content_id+1;}
                 else{
                     content_id=new Long(1);
                     }
                        String sql1 = "insert into reports_tab(id,sec,dt_to,update_dt,xmlfile,report_type) values("+content_id+",?,?,?,?,?)";


                        pst = con.prepareStatement(sql1);
                        pst.setString(1, sec);
                        pst.setDate(2, billdate);
                        pst.setDate(3, update_dt);
                        pst.setString(4, string);
                        pst.setString(5, "creditor_report");

                        int j = pst.executeUpdate();
//-----------------------------------------------------------------------------------------//
                        isFinished(response.getOutputStream(), strbill_date, sec, path, userid);
                        System.out.println("bill calculated-----------------------------");
                        con.close();
                        return;
                    }
                  
                    isBusy(pdf, response.getOutputStream(), totcons, strbill_date, sec, path, userid);
                    return;
            }
        } catch (Exception ex) {
            System.out.println(ex);
            i = 0;
            response.sendRedirect("jsppages/reports/defaulters_creditors.jsp");
            return;
        }
    }

    private void isBusy(MyPdf pdf, ServletOutputStream stream, int totcons, String bill_date, String sec, String path, String userid)
            throws IOException {
        stream.print("<html><head><title>Please wait...</title><meta http-equiv=\"Refresh\" content=\"5\">"
                + "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" /></head>"
                + "<div id=\"canvas\"><div id=\"header\"><div class=\"inside\"><div class=\"container\"><div id=\"logo\">"
                + "<img SRC=\"resources/images/logo.png\" alt=\"noida_logo\" /></div><div id=\"toolbar\">"
                + "<div class=\"logout\"> <a href=\"/OnlineJal_Example/RedirectToCP?page=CreditorGen\" >Change Password</a>&nbsp;|&nbsp;<a href=\"jsppages/common/logout.jsp\">Logout</a>"
                + "</div><div class=\"wel\">Welcome " + userid + "</div></div></div></div></div></div>"
                + "<div id=\"heading\"><div class=\"inside\"><div class=\"container\"><div id=\"headinger\"><div class=\"head\"><div class=\"content\">"
                + "<h2>OnlineJal</h2><p>Out of it might be hyperspace hadnt immediate sense of embarrassingly enough</p></div> </div></div> <div id=\"arrowhide\">"
                + "<a href=\"#\" title=\"Hide/Show Slideshow\"></a></div></div></div></div>");
        stream.print("<div id=\"content\"><div class=\"inside\"><div class=\"container\"><div id=\"centerrail\"><div id=\"content\"> <div class=\"inside\">"
                + "<div class=\"container\"><div id=\"contentrail\" class=\"full\"><br/>");
        stream.print("Ledger for " + pdf.cons_no + " is being calculated." + String.valueOf(totcons - pdf.getPercentage()));
        stream.print("&nbsp;consumers are left.<br>\nPlease Wait while this page refreshes automatically (every 5 seconds)</div><form action=\"/OnlineJal_Example/CancelCrdt\">"
                + "<input type=\"hidden\" name=\"path\" value=\"" + path + "\">"
                + "<input type=\"hidden\" name=\"sec\" value=\"" + sec + "\"><input type=\"hidden\" name=\"billdate\" value=\"" + bill_date + "\">"
                + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type=\"Submit\"  class=\"submit\" value=\"Cancel\"></form>"
                + "</div></div></div></div></div></div></div>"
                + "<div id=\"footer\"><div class=\"inside\"><div class=\"container\"><div class=\"left\"><ul><li class=\"first\">"
                + "Copyright &copy; 2009 Developed for NOIDA-JAL by &nbsp;&nbsp; <a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a>"
                + "</li> </ul></div> <div class=\"right\"><ul><li><a href=\"#\">Terms &amp; Condition</a>&nbsp;&nbsp;|&nbsp;&nbsp;"
                + "<a href=\"#\">Privacy Policy</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"#\">Sitemap</a></li><li class=\"last\">"
                + "<a href=\"#canvas\" class=\"scroll\" title=\"Top\">Top</a> &uArr;</li></ul></div></div></div> </div> "
                + "</div></body>\n</html>");

    }

    public void isFinished(ServletOutputStream stream, String bill_date, String sec, String path, String userid) throws IOException {


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
        stream.print("The document is finished:&nbsp;&nbsp;&nbsp;&nbsp;</div></div><form method=\"POST\" action=\"/OnlineJal_Example/CreditorGen\">"
                + "<input type=\"hidden\" name=\"path\" value=\"" + path + "\">"
                + "<input type=\"hidden\" name=\"sec\" value=\"" + sec + "\"><input type=\"hidden\" name=\"billdate\" value=\"" + bill_date + "\">"
                + "<input type=\"Submit\"  class=\"submit\" value=\"Get PDF\"> <a href=\"jsppages/reports/defaulters_creditors.jsp\"><input type=\"button\"  class=\"submit\" value=\"Back\"></a></form>"
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
        String sec = null;
        //String form;
        int k = 0;

        String billdate;
        billdate = request.getParameter("billdate");

        java.util.Date dt1;
        String path;
        ByteArrayOutputStream baos;

        double credit = 0;

        Rectangle pageSize = new Rectangle(864, 1080);
        Document document1 = new Document(pageSize);

        baos = new ByteArrayOutputStream();
        PdfWriter docWriter = null;
        docWriter = PdfWriter.getInstance(document1, baos);

        document1.open();
        float[] widths1 = {0.5f, 1f, 3f, 2f, 1f, 0.5f};
        PdfPTable table = new PdfPTable(widths1);
        //form=request.getParameter("form");

        table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);

        PdfPCell cell = new PdfPCell(new Paragraph("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY"));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setColspan(6);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPaddingBottom(10.0f);
        table.addCell(cell);


        sec = request.getParameter("sec");

        cell = new PdfPCell(new Paragraph("CREDITOR'S LIST FOR SECTOR - " + sec.trim() + "(CREDIT UPTO-" + billdate + ")"));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setColspan(6);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPaddingBottom(20.0f);
        table.addCell(cell);

        cell = new PdfPCell(new Paragraph(""));
        cell.setBorder(Rectangle.NO_BORDER);
        table.addCell(cell);

        cell = new PdfPCell(new Paragraph("Consumer No:"));
        cell.setBorder(Rectangle.BOTTOM);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cell);

        cell = new PdfPCell(new Paragraph("Consumer Name:"));
        cell.setBorder(Rectangle.BOTTOM);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cell);

        cell = new PdfPCell(new Paragraph("Address:"));
        cell.setBorder(Rectangle.BOTTOM);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cell);

        cell = new PdfPCell(new Paragraph("Credit Amount"));
        cell.setBorder(Rectangle.BOTTOM);
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(cell);

        cell = new PdfPCell(new Paragraph(""));
        cell.setBorder(Rectangle.NO_BORDER);
        table.addCell(cell);


        path = request.getParameter("path");


        //Number formatter
        NumberFormat formatterno = new DecimalFormat("#0.00");

        try {

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

            for (int s = 0; s < consumer.getLength(); s++) {
                Node cons = consumer.item(s);
                if (cons.getNodeType() == Node.ELEMENT_NODE) {
                    k = k + 1;
                    org.w3c.dom.Element consElement = (org.w3c.dom.Element) cons;

                    NodeList cons_no_list = consElement.getElementsByTagName("cons_no");
                    org.w3c.dom.Element cons_noElement = (org.w3c.dom.Element) cons_no_list.item(0);
                    NodeList cons_no_text = cons_noElement.getChildNodes();

                    cell = new PdfPCell(new Paragraph(""));
                    cell.setBorder(Rectangle.NO_BORDER);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph(k + ". " + ((Node) cons_no_text.item(0)).getNodeValue().trim()));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(cell);

                    NodeList cons_name_list = consElement.getElementsByTagName("cons_nm1");
                    org.w3c.dom.Element consNameElement = (org.w3c.dom.Element) cons_name_list.item(0);
                    NodeList cons_nm_text = consNameElement.getChildNodes();

                    cell = new PdfPCell(new Paragraph(((Node) cons_nm_text.item(0)).getNodeValue().trim()));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(cell);

                    NodeList address_list = consElement.getElementsByTagName("address");
                    org.w3c.dom.Element ageElement = (org.w3c.dom.Element) address_list.item(0);
                    NodeList address_text = ageElement.getChildNodes();

                    cell = new PdfPCell(new Paragraph(((Node) address_text.item(0)).getNodeValue().trim()));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(cell);

                    NodeList creditlist = consElement.getElementsByTagName("credit");
                    org.w3c.dom.Element creditElement = (org.w3c.dom.Element) creditlist.item(0);
                    NodeList credittext = creditElement.getChildNodes();

                    credit = Double.parseDouble(((Node) credittext.item(0)).getNodeValue().trim());

                    cell = new PdfPCell(new Paragraph(formatterno.format(credit)));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph(""));
                    cell.setBorder(Rectangle.NO_BORDER);
                    table.addCell(cell);


                }
            }//end of outer for loop with s var

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
            response.setContentLength(baos.size());

            ServletOutputStream out = response.getOutputStream();
            baos.writeTo(out);
            out.flush();

        } catch (SAXParseException err) {
            System.out.println("** Parsing error" + ", line "
                    + err.getLineNumber() + ", uri " + err.getSystemId());
            System.out.println(" " + err.getMessage());
            response.sendRedirect("jsppages/reports/defaulters_creditors.jsp");
            return;

        } catch (SAXException e) {
            Exception x = e.getException();
            ((x == null) ? e : x).printStackTrace();

        } catch (Throwable et) {
            et.printStackTrace();
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
            response.sendRedirect("jsppages/reports/defaulters_creditors.jsp");
        }
    }
}
