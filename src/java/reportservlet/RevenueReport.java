/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package reportservlet;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.ExceptionConverter;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;
import com.smp.jal.ConvertToDate;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.naming.InitialContext;
import javax.naming.NamingException;

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
import org.w3c.dom.NodeList;

/**
 *
 * @author smp
 */
public class RevenueReport extends HttpServlet {

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
//                ;
//                int i = writer.getPageNumber();
//                table.setFooterRows(i);
//                table.addCell(" ");
//                table.addCell(" ");
//                table.addCell(" ");
//                table.addCell(" ");
//                PdfPCell cell = new PdfPCell(new Phrase("Page-" + i));
//                cell.setHorizontalAlignment(cell.ALIGN_CENTER);
//                cell.setBorder(Rectangle.NO_BORDER);
//                table.addCell(cell);
//                //this cell will be blank. Yes! we can directly type in a string too above, but in order to
//                //use special fonts for special cell values, we are using a Phrase above
//                table.setTotalWidth(page.getWidth() - document.leftMargin() - document.rightMargin());
//                table.writeSelectedRows(0, -1, document.leftMargin(), document.bottomMargin() + 20, writer.getDirectContent());
//            } catch (Exception ex) {
//                ex.printStackTrace();
//            }
//        }
    }

    public class MyPdf implements Runnable {

        Connection con;
        String chll_table;
        String sec = "";
        PreparedStatement ps;
        ResultSet rs;
        int totcons = -1;
        int i = 0;
        int rows;
        int p = 0;
        float p1 = 0;
        int j = 0;
        DocumentBuilderFactory dbf = null;
        DocumentBuilder db = null;
        org.w3c.dom.Document docxml = null;
        NodeList nl = null;
        String xmlpath = null;
        ServletContext context = null;
        String div = null;
        String uid;
        String path;
        String address;
        java.sql.Date fr_date;
        java.sql.Date to_date;
        double surcharge;
        double paid_amt;
        double arrear;
        double noc;
        double secu;
        double t_fee;
        double css;
        double bill_amt;
        boolean threaddone = false;
        String division;
        int month = 0;
        int year = 0;
        Calendar bl_per_to = Calendar.getInstance();

        MyPdf(String userid, String div) {
            uid = userid;

            division = div;
            //fr_date=bl_fr_dt;
            //to_date=bl_to_dt;
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
                docxml = db.parse(xmlpath);
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                System.out.println("connectin open1");
                //con = DBConnection1.dbConnection(xmlpath);

                context = getServletContext();
                //path=context.getRealPath("")+"/resources/xmlreports/revenue_report_"+sec.trim()+".xml";
                path = context.getRealPath("") + "/resources/xmlreports/revenue_report.xml";
                File file = new File(path);
                if (file.exists()) {
                    file.delete();
                }

                int yearupto = bl_per_to.get(Calendar.YEAR);
                int monthupto = bl_per_to.get(Calendar.MONTH);
                if (monthupto >= 3 && monthupto <= 11) {
                    yearupto++;
                }


                PrintWriter w = new PrintWriter(new FileWriter(path));
                w.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                w.println("<revenue_details>");
                NodeList nl = docxml.getElementsByTagName("SectorList");
                NodeList nl1 = nl.item(0).getChildNodes();
                for (int j = 1; j < nl1.getLength() && !threaddone; j = j + 2) {
                    division = nl1.item(j).getNodeName().trim();

                    char number = division.charAt((division.length() - 1));
                    chll_table = "CHALLAN" + number;
                    // mst_table=nl2.item(0).getFirstChild().getNodeValue().trim();
                    w.println("<" + division + ">");

                    if (nl1.item(j).hasChildNodes()) {
                        NodeList nl2 = nl1.item(j).getChildNodes();
                        //  System.out.println("length is" + nl2.getLength());
                        for (int i = 1; i < nl2.getLength() && !threaddone; i = i + 2) {
                            sec = nl2.item(i).getTextContent().trim();
                            //System.out.println("Children is" + sec);
                            w.println("<sec_" + sec + ">");


                            year = 1990;


                            while (year < yearupto && !threaddone) {

                                fr_date = new java.sql.Date(new GregorianCalendar(year, 3, 1).getTimeInMillis());
                                to_date = new java.sql.Date(new GregorianCalendar((year + 1), 2, 31).getTimeInMillis());
                                w.println("<year_" + String.valueOf(year) + "-" + String.valueOf((year + 1)) + ">");

                                String sql = "select sum(BILL_AMT),sum(SURCHARGE),sum(PAID_AMT),sum(ARREAR),sum(NOC),sum(SECU),sum(T_FEE) from " + chll_table + " where trim(sec)='" + sec + "'  and (status= 'A' or status is null) and bl_per_fr is not null and pay_date is not null and (to_char(pay_date,'YYYY-MM-DD')>='" + fr_date + "' and to_char(pay_date,'YYYY-MM-DD')<='" + to_date + "')";

                                ps = con.prepareStatement(sql);
                                rs = ps.executeQuery();
                                if (rs.next()) {
                                    bill_amt = rs.getDouble(1);
                                    surcharge = rs.getDouble(2);
                                    paid_amt = rs.getDouble(3);
                                    arrear = rs.getDouble(4);
                                    noc = rs.getDouble(5);
                                    secu = rs.getDouble(6);
                                    t_fee = rs.getDouble(7);


                                    w.println("<bill_amt>");
                                    w.println(bill_amt);
                                    w.println("</bill_amt>");
                                    w.println("<surcharge>");
                                    w.println(surcharge);
                                    w.println("</surcharge>");
                                    w.println("<paid_amt>");
                                    w.println(paid_amt);
                                    w.println("</paid_amt>");
                                    w.println("<arrear>");
                                    w.println(arrear);
                                    w.println("</arrear>");
                                    w.println("<noc>");
                                    w.println(noc);
                                    w.println("</noc>");
                                    w.println("<secu>");
                                    w.println(secu);
                                    w.println("</secu>");
                                    w.println("<t_fee>");
                                    w.println(t_fee);
                                    w.println("</t_fee>");

                                    // totcons=100;
                                }
                                w.println("</year_" + String.valueOf(year) + "-" + String.valueOf((year + 1)) + ">");
                                year++;
                                //System.out.println("year is:" + year + "and sec is" + sec);

                            }

                            w.println("</sec_" + sec + ">");

                        }
                    }
                    w.println("</" + division + ">");
                }
                totcons = 100;
                p = totcons;
                w.println("</revenue_details>");

                w.close();
                rs.close();
                con.commit();
                con.close();
                System.out.println("connectin closed1");
//                if (!con.isClosed()) {
//                    con.close();
//                }
            } catch (Exception ex) {
                System.out.println("Exception in consumer reports:" + ex);
            }
            //p=totcons;

        }

        public String getPath() {

            return path;
        }

        public int getPercentage() {
            return p;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-store, no-cache");
        response.setDateHeader("Expires", 0);

        String cons_no;
        String sec = null;
        String division = null;

        String bdate = null;
        ConvertToDate ctd;
        String strbill_date = null;

        Calendar calbilldate = Calendar.getInstance();
        java.sql.Date bl_fr_date;
        java.sql.Date bl_to_date;
        java.sql.Date update_dt = new java.sql.Date(new java.util.Date().getTime());
        int i = 0;

        int totcons = 0;
        Object o;
        String fr_date = null;
        String to_date = null;
        Connection con;
        ServletContext context;
        String xmlpath;
        PreparedStatement pst;
        InputStream is = null;


        HttpSession session = request.getSession(false);
        //System.out.print("Inside doGet()");
        MyPdf pdf;

        try {

            String userid = (String) session.getAttribute("userid");
            String username = (String) session.getAttribute("username");
            // System.out.println("***username***" + username);
            ctd = new ConvertToDate();

            i++;
            o = session.getAttribute("myPdf");
            if (o == null) {
                pdf = new MyPdf(username, division);
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
                    sec = pdf.sec;
                    String path;
                    context = getServletContext();
                    xmlpath = context.getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                    // con = DBConnection1.dbConnection(xmlpath);
                    InitialContext initialContext = new InitialContext();
                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                    con = dataSource.getConnection();
                    System.out.println("connectin open2");
                    // path=context.getRealPath("")+"/resources/xmlreports/revenue_report_"+sec.trim()+".xml";
                    path = context.getRealPath("") + "/resources/xmlreports/revenue_report.xml";
                     
                    //if(totcons==100)
                    //    ServletOutputStream s= response.getOutputStream();
                    changes(response.getOutputStream(), sec, path, fr_date, to_date, username, session, request, response, con);
                    if (pdf.getPercentage() == totcons) {

                        session.removeAttribute("myPdf");
                        //------Insert xml file into database--------------//


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
                        // System.out.println(string);

//                        String sql = "delete from reports_tab where report_type='revenue_report'";
//                        pst = con.prepareStatement(sql);
//                        pst.executeUpdate();
                      String  sql = "select max(id) as high from reports_tab";
                        pst = con.prepareStatement(sql);
                        ResultSet rs = pst.executeQuery(sql);
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
                        String sql1 = "insert into reports_tab(id,sec,dt_fr,dt_to,update_dt,xmlfile,report_type) values(" + content_id + ",?,?,?,?,?,?)";

                        pst = con.prepareStatement(sql1);

                        pst.setString(1, sec);
                        pst.setString(2, fr_date);
                        pst.setString(3, to_date);
                        pst.setDate(4, update_dt);
                        pst.setString(5, string);
                        pst.setString(6, "revenue_report");
                        int j = pst.executeUpdate();
//-----------------------------------------------------------------------------------------//
                        //PrintWriter out=response.getWriter();
                        //out.println(sec+":"+path);
                         System.out.println("path in before isfinished is......"+path);
                        isFinished(response.getOutputStream(), sec, path, fr_date, to_date, username, request);
                        System.out.println("Report Generated-----------------------------");
                        pst.close();

                        return;
                    }
                    con.close();
                    System.out.println("connectin closed2");
                     
                    isBusy(pdf, response.getOutputStream(), username, path, sec, request);
                    return;
            }


        } catch (Exception ex) {
            System.out.println(ex);
        }


    }

    void changes(ServletOutputStream stream, String sec, String path, String fr_date, String to_date, String username, HttpSession session, HttpServletRequest request, HttpServletResponse response, Connection con) throws IOException, SQLException {
        int t = 0;
        int indexflag = 0;
        int rateflag = 0;
        int schemeflag = 0;
        int formflag = 0;
        int contactflag = 0;
        int siteflag = 0;
        int userflag = 0;
        int adminflag = 0;
        int serviceflag = 0;
        int dbflag = 0;
        int usflag = 0;
        int contentflag = 0;
        int infoflag = 0;
        int pageflag = 0;
        String content_type;
        String con_title;
        String display;
        String priority;
        String content;
        String sql;
        PreparedStatement pst;
        ResultSet rs;
        // Connection con;
        String con_id;
        stream.print("<html><head>"
                + "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" />"
                + "<script type=\"text/javascript\" SRC=\"" + request.getContextPath() + "/resources/js/jquery.min.js\"></script>"
                + "<script type=\"text/javascript\" src=\"" + request.getContextPath() + "/resources/js/jquery.cycle.js\"></script>"
                + "<script type=\"text/javascript\" src=\"" + request.getContextPath() + "/resources/js/jquery.tweet.js\"></script>"
                + "<script type=\"text/javascript\" src=\"" + request.getContextPath() + "/resources/js/jquery.scroll.js\"></script>"
                + "<script type=\"text/javascript\" src=\"" + request.getContextPath() + "/resources/js/jquery.lightbox.js\"></script>"
                + "<script type=\"text/javascript\">"
                + "function menu(){"//<script language=\"javascript\">
                + "$(\" #menu ul li ul \").css({display: \"none\"});"
                + "$(\" #menu ul li\").hover(function(){"
                + "$(this).find('ul:first').css({visibility: \"visible\",display: \"none\"}).slideToggle(500);"
                + "},function(){"
                + "$(this).find('ul:first').css({visibility: \"hidden\"});"
                + "});"
                + "}"
                + "$(document).ready(function(){"
                + "menu();"
                + "});"
                + "</script></head>");

        stream.print("<div id=\"canvas\">"
                + "<div id=\"header\">"
                + "<div class=\"inside\">"
                + "<div class=\"container\">"
                + "<div id=\"logo\"><a href=\"" + request.getContextPath() + "/index.jsp\" title=\"noida_logo\"><img src=\"" + request.getContextPath() + "/resources/images/logo.png\" alt=\"noida_logo\"/></a></div> <!-- #header #logo -->"
                + "<div id=\"toolbar\">");

        String userrole = (String) session.getAttribute("userrole");

        if (userrole == null) {


            stream.print("<div class=\"login\">");



            if (request.getAttribute("t1") != null) {

                t = (Integer) request.getAttribute("t1");

                if (t == 1) {

                    stream.print("<p class=\"errorcolor\"><label>Invalid Username or Password </label></p>");

                    t = (Integer) 0;

                }
            } else {


                stream.print("<p><label >&nbsp;&nbsp;Member Login</label></p>");
            }

            stream.print("<form action=\"+\"" + request.getContextPath() + "/login.jsp\" method=\"post\">"
                    + " <fieldset>"
                    + "<input class=\"user\" value=\"User Name\" name=\"userid\" id=\"userid\" onclick=\"this.value=''\" />"
                    + " <input class=\"small\" value=\"Password\" name=\"password\" id=\"password\" title=\"Please fill Your password !\" onfocus=\"this.type='password',this.value=''\"  onclick=\"this.value=''\" />"
                    + "<button type=\"submit\">Login</button>"
                    + "</fieldset>"
                    + "</form>"
                    + "</div>");

        }
        if (userrole != null) {
            stream.print("<div class=\"logout\">");
            if (!userrole.equals("consumer")) {

                stream.print("<a href=\"" + request.getContextPath() + "/jsppages/common/ch_pwd.jsp\">Change Password</a>&nbsp;|&nbsp;");
            }
            stream.print("<a href=\"" + request.getContextPath() + "/jsppages/common/logout.jsp\">Logout</a> </div>"
                    + "<br/>"
                    + "<div class=\"wel\">");
            if (userrole.equalsIgnoreCase("consumer")) {

                stream.print("Welcome " + session.getAttribute("cons_nm") + "!");
            } else {
                stream.print(" Welcome" + session.getAttribute("username") + "!");
            }
            stream.print("</div>");

        }


        stream.print("<br class=\"clear\" />"
                + "</div>"
                + "</div>"
                + "</div> <!-- #header .container -->"
                + "</div> <!-- #header .inside -->"
                + "</div> <!-- #header -->"
                + "<div id=\"menu\">"
                + "<div class=\"inside\">"
                + "<div class=\"container\">"
                + "<div class=\"leftcorners\">"
                + "<div class=\"rightcorners\">"
                + "<div class=\"bg\">"
                + "<ul>");
        try {

            indexflag = 0;
            rateflag = 0;
            schemeflag = 0;
            contactflag = 0;
            formflag = 0;
            userflag = 0;
            adminflag = 0;
            serviceflag = 0;
            infoflag = 0;
            pageflag = 0;
            String s = new String(request.getRequestURL());
            String s1 = s.substring(s.lastIndexOf("/") + 1);
            s = s.substring(0, s.lastIndexOf("/"));
            String searchstr = s.substring(s.lastIndexOf("/") + 1);



            if (searchstr.equals("common")) {
                if (s1.equals("home.jsp"));
                userflag = 1;
            } else if (searchstr.equals("sitepages")) {
                siteflag = 1;
            } else if (searchstr.equals("admin")) {
                userflag = 1;
            }



            if (siteflag == 1) {
                if (s1.equals("rate.jsp")) {
                    rateflag = 1;
                } else if (s1.equals("scheme.jsp")) {
                    infoflag = 1;
                } else if (s1.equals("services.jsp")) {
                    infoflag = 1;
                } else if (s1.equals("contact.jsp")) {
                    contactflag = 1;
                } else if (s1.equals("complaintForm.jsp")) {
                    contactflag = 1;
                } else if (s1.equals("downloads.jsp")) {
                    formflag = 1;
                } else if (s1.equals("news_list.jsp")) {
                    infoflag = 1;
                } else if (s1.equals("notices.jsp")) {
                    infoflag = 1;
                } else if (s1.equals("page.jsp")) {
                    pageflag = 1;
                }


            }


            if (userflag == 1) {
                if (s1.equals("admin.jsp")) {
                    adminflag = 1;
                } else if (s1.equals("viewcontent.jsp")) {
                    adminflag = 1;
                } else if (s1.equals("viewuploadfile.jsp")) {
                    adminflag = 1;
                } else if (s1.equals("view_complains.jsp")) {
                    adminflag = 1;
                } else if (s1.equals("create_user.jsp")) {
                    adminflag = 1;
                } else if (s1.equals("view_user.jsp")) {
                    adminflag = 1;
                }
            }

            stream.print("<li class=\"active\"><a href=\"" + request.getContextPath() + "/index.jsp\"  class=\"current\">Home</a></li>");
            if (infoflag == 1) {
                stream.print("<li class=\"boractive\">   <a href=\"#\" >News &amp; Events</a>");
            } else {

                stream.print("<li class=\"bor\">    <a href=\"#\" >News &amp; Events</a>");
            }



            stream.print("<ul>"
                    + "<li class=\"first\"><a href=\"" + request.getContextPath() + "/jsppages/sitepages/news_list.jsp\">News</a></li>"
                    + "<li><a href=\"" + request.getContextPath() + "/jsppages/sitepages/events.jsp\">Events</a></li>"
                    + "<li><a href=\"" + request.getContextPath() + "/jsppages/sitepages/services.jsp\">Services</a></li>"
                    + "<li><a href=\"" + request.getContextPath() + "/jsppages/sitepages/scheme.jsp\">Schemes</a></li>"
                    + "</ul>"
                    + "</li>");
            if (userrole == null || userrole.equals("admin") || userrole.equals("manager")) {
                stream.print("<li class=\"active\"><a href=\"" + request.getContextPath() + "/cons_detailslogin.jsp\">Consumer</a>"
                        + "</li>");
            }


            if (userrole != null) {
                if (userrole.equals("admin")) {

                    if (adminflag == 1) {


                        stream.print("<li class=\"boractive\"><a href=\"#\">Admin area</a>");
                    } else {


                        stream.print("<li class=\"bor\"><a href=\"#\">Admin area</a>");
                    }

                    stream.print("<ul>"
                            + "<li class=\"first\"> <a href=\"" + request.getContextPath() + "/jsppages/admin/admin.jsp\">DashBoard</a></li>"
                            + "<li class=\"bo left1\"><a href=\"#\">Contents</a>"
                            + "<ul>"
                            + "<li class=\"first\"><a href=\"" + request.getContextPath() + "/jsppages/admin/viewcontent.jsp\">Manage Contents</a></li>"
                            + "<li><a href=\"" + request.getContextPath() + "/jsppages/admin/viewuploadfile.jsp\">UploadedFiles</a></li>"
                            + "<li class=\"last\"><a href=\"" + request.getContextPath() + "/jsppages/admin/view_complains.jsp?b=inbox\">Suggestions/Complains</a></li>"
                            + "</ul>"
                            + "</li>"
                            + "<li class=\"bo left1 last\"><a href=\"#\">UserSettings</a>"
                            + "<ul>"
                            + "<li class=\"first\"><a href=\"" + request.getContextPath() + "/jsppages/admin/create_user.jsp\">Create User</a></li>"
                            + "<li class=\"last\"><a href=\"" + request.getContextPath() + "/jsppages/admin/view_user.jsp\">View User</a></li>"
                            + "</ul>"
                            + "</li>"
                            + "</ul>"
                            + "</li>");


                } else if (userrole.equals("manager")) {

                    stream.print("<li class=\"bor\"><a href=\"#\">Manager</a>"
                            + "<ul>"
                            + "<li class=\"first\"> <a href=\"" + request.getContextPath() + "/jsppages/manager/mgr_dashboard.jsp\">DashBoard</a></li>"
                            + "<li class=\"bo left1\"><a href=\"#\">Reports</a>"
                            + "<ul>"
                            + "<li class=\"first\"><a href=\"" + request.getContextPath() + "/jsppages/manager/revenue_report.jsp\">Revenue Report</a></li>"
                            + "<li class=\"last\"><a href=\"" + request.getContextPath() + "/jsppages/manager/cons_report.jsp\">Consumer Report</a></li>"
                            + "</ul>"
                            + "</li>"
                            + "<li class=\"bo left1 last\"><a href=\"#\">Graphs</a>"
                            + "<ul>"
                            + "<li class=\"first\"><a href=\"" + request.getContextPath() + "/jsppages/charts/Code/JSP/jal_chart.jsp\">Revenue Graph</a></li>"
                            + "<li class=\"last\"><a href=\"" + request.getContextPath() + "/jsppages/charts/Code/JSP/ConsumerChart.jsp\">Consumer Graph</a></li>"
                            + "</ul>"
                            + "</li>"
                            + "</ul>"
                            + "</li>");
                } else if (userrole.equals("consumer")) {


                    stream.print("<li class=\"active\"><a href=\"" + request.getContextPath() + "/jsppages/consumer/cons_details.jsp\">Consumer</a>"
                            + "</li>");
                }
            }



            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            con = dataSource.getConnection();
            System.out.println("connectin open3");
            sql = "select con_id,con_title from jal_content where content_type='page'and (display='default' or display='home') order by priority";
            // con = (Connection) pageContext.getServletContext().getAttribute("con");
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                con_id = rs.getString(1);
                con_title = rs.getString(2);
                if (pageflag == 1) {

                    stream.print("<li class=\"active\" ><a href=\"" + request.getContextPath() + "/jsppages/sitepages/page.jsp?con_id=" + con_id + "\" >" + con_title + "</a></li>");

                } else {

                    stream.print("<li><a href=\"" + request.getContextPath() + "/jsppages/sitepages/page.jsp?con_id=" + con_id + "\">" + con_title + "</a></li>");

                }
            }



            if (formflag == 1) {

                stream.print("<li  class=\"active\"><a href=\"" + request.getContextPath() + "/jsppages/sitepages/downloads.jsp\">Downloads</a></li>");
            } else {

                stream.print("<li><a href=\"" + request.getContextPath() + "/jsppages/sitepages/downloads.jsp\">Downloads</a></li>");
            }




            if (contactflag == 1) {

                stream.print("<li class=\"boractive\">   <a href=\"#\" >Contact Us </a>");
            } else {

                stream.print("<li class=\"bor\">    <a href=\"#\" >Contact Us</a>");
            }



            stream.print("<ul>"
                    + "<li class=\"first\"><a href=\"" + request.getContextPath() + "/jsppages/sitepages/contact.jsp\">Contact Details</a></li>"
                    + "<li><a href=\"" + request.getContextPath() + "/jsppages/sitepages/complaintForm.jsp\">Complaint Form</a></li>"
                    + "</ul>"
                    + "</li>");



        } catch (Exception ex) {
            System.out.println("Exception in navigation" + ex);
        } finally {
            con.close();
            System.out.println("connectin closed3");
        }




        stream.print("</ul>"
                + "</div> <!-- #menu .bg -->"
                + "</div> <!-- #menu. rightcorners -->"
                + "</div> <!-- #menu .leftcorners -->"
                + "</div> <!-- #menu .container -->"
                + "</div> <!-- #menu .inside -->"
                + "</div> <!-- #menu -->");
        stream.print("<div id=\"breadcrumbs\">"
                + "<div class=\"inside\">"
                + "<div class=\"container\">"
                + "<div id=\"breadcrumb\">"
                + "<div class=\"youarehere\">"
                + "<div class=\"leftcorners\">"
                + "<div class=\"rightarrow\">"
                + "<div class=\"bg\">"
                + "You are here:"
                + "</div> <!-- #breadcrums .bg -->"
                + "</div> <!-- #breadcrums .rightarrow -->"
                + "</div> <!-- #breadcrums .leftcorners -->"
                + "</div> <!-- #breadcrums .youarehere -->"
                + "<div class=\"inactive\">"
                + "<a href=\"" + request.getContextPath() + "/jsppages/admin/admin.jsp\" title=\"Home\">"
                + "<span class=\"leftcorners\">"
                + "<span class=\"rightarrow\">"
                + "<span class=\"bg\">"
                + "Admin"
                + "</span>"
                + "</span>"
                + "</span>"
                + "</a>"
                + "</div> <!-- #breadcrums .active -->"
                + "<div class=\"active\">"
                + "<a href=\"#\" title=\"Home\">"
                + "<span class=\"leftcorners\">"
                + "<span class=\"rightarrow\">"
                + "<span class=\"bg\">"
                + "Revenue Report"
                + "</span>"
                + "</span>"
                + "</span>"
                + "</a>"
                + "</div> <!-- #breadcrums .active -->"
                + "</div> <!-- #breadcrums .breadcrumb -->"
                + "</div> <!-- #breadcrums .container -->"
                + "</div> <!-- #breadcrums .inside -->"
                + "</div> <!-- #breadcrums -->");
    }

    private void isBusy(MyPdf pdf, ServletOutputStream stream, String username, String path, String sec, HttpServletRequest request)
            throws IOException, NamingException, SQLException {
         
        stream.print("<title>Please wait...</title><meta http-equiv=\"Refresh\" content=\"5\"></head>");
        //+ "<div id=\"canvas\"><div id=\"header\"><div class=\"inside\"><div class=\"container\"><div id=\"logo\">"
        //+ "<img SRC=\"resources/images/logo.png\" alt=\"noida_logo\" /></div><div id=\"toolbar\">"
        //+ "<div class=\"logout\"> <a href=\"/OnlineJal/RedirectToCP?page=RevenueReport\" >Change Password</a>&nbsp;|&nbsp;<a href=\"jsppages/common/logout.jsp\">Logout</a>"
        //+ "</div><br/><div class=\"wel\">Welcome " + username + "</div></div></div></div></div></div>"
//                + "<div id=\"helper\"><div class=\"inside\"><div class=\"container\"><div class=\"leftcorners\"><div class=\"rightcorners\">"
//                + "<div class=\"bg\"></div></div></div></div></div></div>"
//                + "<div id=\"heading\"><div class=\"inside\"><div class=\"container\"><div id=\"headinger\"><div class=\"head\"><div class=\"content\">"
//                + "<h2>OnlineJal</h2></div> </div></div> <div id=\"arrowhide\">"
//                + "<a href=\"#\" title=\"Hide/Show Slideshow\"></a></div></div></div></div>"
        // );
        stream.print("<div id=\"content\"><div class=\"inside\"><div class=\"container\"><div id=\"centerrail\"><div id=\"content\"> <div class=\"inside\">"
                + "<div class=\"container\"><div id=\"contentrail\" class=\"full\"><br/><br/>");

        stream.print("Revenue for sector " + sec + " is being calculated.Please Wait while this page refreshes automatically (every 5 seconds)</div>"
                + "<form action=\"/OnlineJal/CancelRevenueReport\" method=\"post\">"
                + "<input type=\"hidden\" name=\"path\" value=\"" + path + "\">"
                + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <div class=\"buttons\">"
                + "<button class=\"submit\" type=\"submit\" value=\"Cancel\" ><span class=\"leftcorners\">"
                + "<span class=\"rightcorners\"><span class=\"bg\">Cancel</span></span></span></button></div></form>"
                + "</div></div></div></div></div></div></div>"
                //                + "<div id=\"footer\"><div class=\"inside\"><div class=\"container\"><div class=\"left\"><ul><li class=\"first\">"
                //                + "Copyright &copy; 2009 Developed for NOIDA-JAL by &nbsp;&nbsp; <a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a>"
                //                + "</li> </ul></div> <div class=\"right\"><ul><li><a href=\"#\">Terms &amp; Condition</a>&nbsp;&nbsp;|&nbsp;&nbsp;"
                //                + "<a href=\"#\">Privacy Policy</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"#\">Sitemap</a></li><li class=\"last\">"
                //                + "<a href=\"#canvas\" class=\"scroll\" title=\"Top\">Top</a> &uArr;</li></ul></div></div></div> </div> "
                //                + "</div></body>\n</html>");
                + "<div id=\"footer\">"
                + "<div class=\"inside\">"
                + "<div class=\"container\">"
                + "<div class=\"left\">"
                + "<ul>"
                + "<li class=\"first\">Copyright &copy; 2011 Developed for NOIDAJAL by &nbsp;<a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a></li>"
                + "</ul>"
                + "</div> <!-- #footer .left -->"
                + "<div class=\"right\">");
        InitialContext initialContext = new InitialContext();
        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
        Connection connection = dataSource.getConnection();
        Statement stmt = connection.createStatement();
        ResultSet resultSet = stmt.executeQuery("select * from hit_counter");
        int count = 0;
        while (resultSet.next()) {
            count = resultSet.getInt("count");
        }
        connection.close();
        stream.print("<ul>"
                + "<li>Visitors - <label>" + count + "</label>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"" + request.getContextPath() + "/jsppages/sitepages/disclaimer.jsp\">Disclaimer</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"" + request.getContextPath() + "/jsppages/sitepages/sitemap.jsp\">Sitemap</a>"
                + "</li>"
                + "<li class=\"last\"><a href=\"#canvas\" class=\"scroll\" title=\"Top\">Top</a> &uArr;</li>"
                + "</ul>"
                + "</div> <!-- #footer .right -->"
                + "</div> <!-- #footer .container -->"
                + "</div> <!-- #footer .inside -->"
                + "</div> <!-- #footer -->");

    }

    private void isFinished(ServletOutputStream stream, String sec, String path, String fr_date, String to_date, String username, HttpServletRequest request) throws IOException, SQLException, NamingException {
       
         stream.print("<title>The document is finished.</title></head>");
        //      + "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" /></head>");
        //  + "<div id=\"canvas\"><div id=\"header\"><div class=\"inside\"><div class=\"container\"><div id=\"logo\">"
        //  + "<img SRC=\"resources/images/logo.png\" alt=\"noida_logo\" /></div><div id=\"toolbar\">"
        // + "<div class=\"logout\"> <a href=\"jsppages/common/ch_pwd.jsp\">Change Password</a>&nbsp;|&nbsp;<a href=\"jsppages/common/logout.jsp\">Logout</a>"
        //  + "</div><br/><div class=\"wel\">Welcome " + username + "</div></div></div></div></div></div>"
//                + "<div id=\"helper\"><div class=\"inside\"><div class=\"container\"><div class=\"leftcorners\"><div class=\"rightcorners\">"
//                + "<div class=\"bg\"></div></div></div></div></div></div>"
//                + "<div id=\"heading\"><div class=\"inside\"><div class=\"container\"><div id=\"headinger\"><div class=\"head\"><div class=\"content\">"
//                + "<h2>OnlineJal</h2></div> </div></div> <div id=\"arrowhide\">"
//                + "<a href=\"#\" title=\"Hide/Show Slideshow\"></a></div></div></div></div>"
        //  );
        stream.print("<div id=\"content\"><div class=\"inside\"><div class=\"container\"><div id=\"centerrail\"><div id=\"content\"> <div class=\"inside\">"
                + "<div class=\"container\"><div id=\"contentrail\" class=\"full\"><br/><br/>");

        stream.print("The document is finished:&nbsp;&nbsp;&nbsp;&nbsp;</div></div><br/><form method=\"POST\">"
                + "<input type=\"hidden\" name=\"path\" value=\"" + path + "\">"
                + "<input type=\"hidden\" name=\"sec\" value=\"" + sec + "\">"
                + "<input type=\"hidden\" name=\"fr_dt\" value=\"" + fr_date + "\">"
                + "<input type=\"hidden\" name=\"to_dt\" value=\"" + to_date + "\">"
                + "<div class=\"buttons\">"
                + "<button class=\"submit\" type=\"submit\" value=\"Get Pdf\" ><span class=\"leftcorners\">"
                + "<span class=\"rightcorners\"><span class=\"bg\">Get Pdf</span></span></span></button></div> "
                + "<a href=\"jsppages/reports/revenuereport.jsp\"><div class=\"buttons\"><button class=\"submit\" type=\"submit\" value=\"Back\" ><span class=\"leftcorners\">"
                + "<span class=\"rightcorners\"><span class=\"bg\">Back</span></span></span></button></div></a></form>"
                + "</div></div></div></div></div></div></div></div>"
                //                + "<div id=\"footer\"><div class=\"inside\"><div class=\"container\"><div class=\"left\"><ul><li class=\"first\">"
                //                + "Copyright &copy; 2009 Developed for NOIDA-JAL by &nbsp;&nbsp; <a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a>"
                //                + "</li> </ul></div> <div class=\"right\"><ul><li><a href=\"#\">Terms &amp; Condition</a>&nbsp;&nbsp;|&nbsp;&nbsp;"
                //                + "<a href=\"#\">Privacy Policy</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"#\">Sitemap</a></li><li class=\"last\">"
                //                + "<a href=\"#canvas\" class=\"scroll\" title=\"Top\">Top</a> &uArr;</li></ul></div></div></div> </div> "
                //                + "</div></body>\n</html>");
                + "<div id=\"footer\">"
                + "<div class=\"inside\">"
                + "<div class=\"container\">"
                + "<div class=\"left\">"
                + "<ul>"
                + "<li class=\"first\">Copyright &copy; 2011 Developed for NOIDAJAL by &nbsp;<a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a></li>"
                + "</ul>"
                + "</div> <!-- #footer .left -->"
                + "<div class=\"right\">");
        InitialContext initialContext = new InitialContext();
        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
        Connection connection = dataSource.getConnection();
        Statement stmt = connection.createStatement();
        ResultSet resultSet = stmt.executeQuery("select * from hit_counter");
        int count = 0;
        while (resultSet.next()) {
            count = resultSet.getInt("count");
        }
        connection.close();
        stream.print("<ul>"
                + "<li>Visitors - <label>" + count + "</label>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"" + request.getContextPath() + "/jsppages/sitepages/disclaimer.jsp\">Disclaimer</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"" + request.getContextPath() + "/jsppages/sitepages/sitemap.jsp\">Sitemap</a>"
                + "</li>"
                + "<li class=\"last\"><a href=\"#canvas\" class=\"scroll\" title=\"Top\">Top</a> &uArr;</li>"
                + "</ul>"
                + "</div> <!-- #footer .right -->"
                + "</div> <!-- #footer .container -->"
                + "</div> <!-- #footer .inside -->"
                + "</div> <!-- #footer -->");


    }

    private void isError(ServletOutputStream stream) throws IOException {
        stream.print("<html>\n\t<head>\n\t\t<title>Error</title>\n\t</head>\n\t<body>");
        stream.print("An error occured.\n\t</body>\n</html>");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, DocumentException {


        String sec;
        String division;
        ServletContext context = getServletContext();
        ByteArrayOutputStream baos;
        String year;
        String path = request.getParameter("path");
        

        sec = (String) request.getParameter("sec");

        String fr_date = (String) request.getParameter("fr_dt");
        String to_date = (String) request.getParameter("to_dt");

        //  path=context.getRealPath("")+"/resources/xmlreports/revenue_report_"+sec+".xml";
        path = request.getParameter("path");
        //response.setContentType("application/pdf");
        Rectangle pageSize = new Rectangle(720, 864);
        Document document = new Document(pageSize);
        try {
            //PdfWriter.getInstance(document,new FileOutputStream("C:/DEFAULTER"+chll_table+".pdf") );


            NumberFormat formatterno = new DecimalFormat("#0.00");

            baos = new ByteArrayOutputStream();
            PdfWriter docWriter = null;
            docWriter = PdfWriter.getInstance(document, baos);
            //document.setPageSize(PageSize.ARCH_B);
            Eventr er = new Eventr();
            docWriter.setPageEvent(er);
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


            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            org.w3c.dom.Document docxml = docBuilder.parse(path);

            NodeList nl = docxml.getElementsByTagName("revenue_details");


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
                    // System.out.println("length is" + nl2.getLength());
                    for (int i = 1; i < nl2.getLength(); i = i + 2) {
                        sec = nl2.item(i).getNodeName().trim();
                        sec = sec.substring(4).toUpperCase();
                        // System.out.println("Children is" + sec);

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
                            //System.out.println("length is" + nl3.getLength());
                            for (int k = 1; k < nl3.getLength(); k = k + 2) {
                                year = nl3.item(k).getNodeName().trim();
                                // System.out.println("Children is" + year);
                                year = year.substring(5);

                                if (nl3.item(k).hasChildNodes()) {
                                    NodeList nl4 = nl3.item(k).getChildNodes();
                                    // System.out.println("length is" + nl4.getLength());


                                    // normalize text representation
                                    docxml.getDocumentElement().normalize();
                                    //System.out.println("Root element of the doc is "
                                    //    + docxml.getDocumentElement().getNodeName());

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


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
            processRequest(request, response);
            HttpSession session = request.getSession(false);
            session.removeAttribute("myPdf");

        } catch (DocumentException e) {
            e.printStackTrace();
        }


    }
}
