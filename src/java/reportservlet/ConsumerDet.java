/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package reportservlet;

//import bill.utility.DBConnection1;
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
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class ConsumerDet extends HttpServlet {

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
        String mst_table;
        String sec;
        String cons_no;
        PreparedStatement ps;
        ResultSet rs;
        String cons_nm1;
        String flat_no;
        String blk_no;
        String sector;
        int totcons = -1;//Number of consumers who have water connection
        int totconc = 0;//Total consumers/connections in a sector
        int totcon_nocon = 0;//Total consumers without connection
        Object o;
        String division = "";
        int i = 0;
        int rows;
        int p = 0;
        float p1 = 0;
        int j = 0;
        int totalsec = 0;
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
        boolean threaddone = false;
        String totcons_path;
        int count = 0;

        MyPdf(String username, String div) {
            uid = username;

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
                System.out.println("Connection Open1");
                // con = DBConnection1.dbConnection(xmlpath);

                context = getServletContext();
                path = context.getRealPath("") + "/resources/xmlreports/cons_report.xml";
                totcons_path = context.getRealPath("") + "/resources/xmlreports/totcons_report.xml";
                File file = new File(path);
                if (file.exists()) {
                    file.delete();
                }

                file = new File(totcons_path);
                if (file.exists()) {
                    file.delete();
                }

                PrintWriter w = new PrintWriter(new FileWriter(path));
                w.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");

                PrintWriter totcons_w = new PrintWriter(new FileWriter(totcons_path));
                totcons_w.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");

                w.println("<cons_details>");
                totcons_w.println("<cons_details>");
                NodeList nl = docxml.getElementsByTagName("SectorList");
                NodeList nl1 = nl.item(0).getChildNodes();
                for (int j = 1; j < nl1.getLength() && !threaddone; j = j + 2) {
                    division = nl1.item(j).getNodeName().trim();
                    totalsec = 0;
                    char number = division.charAt((division.length() - 1));
                    mst_table = "MASTER" + number;
                    System.out.println("table++++++ " + mst_table);
                    // mst_table=nl2.item(0).getFirstChild().getNodeValue().trim();
                    w.println("<" + division + ">");
                    totcons_w.println("<" + division + ">");
                    if (nl1.item(j).hasChildNodes()) {
                        NodeList nl2 = nl1.item(j).getChildNodes();

                        totalsec = (nl2.getLength() - 1) / 2;
                        count = 0;
                        for (int i = 1; i < nl2.getLength() && !threaddone; i = i + 2) {
                            sec = nl2.item(i).getTextContent().trim();

                            w.println("<sec_" + sec + ">");
                            totcons_w.println("<sec_" + sec + ">");

                            String sql2 = "select COUNT(DISTINCT CONS_NO) from " + mst_table + " where trim(sector)='" + sec + "' and trim(cons_no) is not null and (status= 'A' or status is null)";

                            ps = con.prepareStatement(sql2);
                            rs = ps.executeQuery();
                            if (rs.next()) {
                                totconc = rs.getInt(1);
                            }
                            System.out.println("totconc+++++ " + totconc);
                            w.println("<totconc>");
                            w.println(totconc);
                            w.println("</totconc>");

                            totcons_w.println("<totcons>");
                            totcons_w.println(totconc);
                            totcons_w.println("</totcons>");
                            String sql1 = "select COUNT(DISTINCT CONS_NO) from " + mst_table + " where trim(sector)='" + sec + "' and trim(CONS_NO) is not null  and (status= 'A' or status is null) and (CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and ((FLAT_TYPE is not null and FLAT_TYPE !='PLOT') or (FLAT_TYPE='PLOT' and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not  null)"
                                    + " order by trim(cons_no)";

                            ps = con.prepareStatement(sql1);
                            rs = ps.executeQuery();
                            if (rs.next()) {
                                totcons = rs.getInt(1);
                            }

                            System.out.println("total cons+++++" + totcons);
                            w.println("<totcons>");
                            w.println(totcons);
                            w.println("</totcons>");
                            //System.err.println("Totalcon" + totconc);
                            totcon_nocon = totconc - totcons;

                            w.println("<totcons_nocon>");
                            w.println(totcon_nocon);
                            w.println("</totcons_nocon>");
                            totcons = totconc;

                            String sql = "select cons_no,cons_nm1,flat_no,blk_no,sector from " + mst_table + " where  trim(sector)='" + sec + "' and (status= 'A' or status is null) and  trim(CONS_NO) is not null and (CONS_NM1 is  not null and CON_TP is not null and CONS_CTG is not null and ((FLAT_TYPE is not null and FLAT_TYPE !='PLOT') or (FLAT_TYPE='PLOT' and PLOT_SIZE is not null)) and PIPE_SIZE is not null and CONN_DT is not null)"
                                    + "order by trim(cons_no)";
                            ps = con.prepareStatement(sql);
                            rs = ps.executeQuery();

                            w.println("<consumer_con>");

                            while (rs.next() && !threaddone) {
                                p++;
                                cons_no = rs.getString(1).trim();
                                cons_nm1 = rs.getString(2);
                                if (cons_nm1 != null) {
                                    cons_nm1 = cons_nm1.replaceAll("&", "AND");
                                } else {
                                    cons_nm1 = "_";
                                }
                                flat_no = rs.getString(3);
                                if (flat_no != null) {
                                    flat_no = flat_no.replaceAll("&", " AND ").trim();
                                } else {
                                    flat_no = "";
                                }
                                blk_no = rs.getString(4);
                                if (blk_no != null) {
                                    blk_no = blk_no.replaceAll("&", " AND ").trim();
                                } else {
                                    blk_no = "";
                                }
                                sector = rs.getString(5);
                                if (sector != null) {
                                    sector = sector.replaceAll("&", " AND ").trim();
                                } else {
                                    sector = "";
                                }

                                address = blk_no + "-" + flat_no + "/" + sector;

                                if (address == null) {
                                    address = "_";
                                }
                                w.println("<consumer>");

                                w.println(cons_no + ":" + cons_nm1 + ":" + address);

                                w.println("</consumer>");

                            }
                            w.println("</consumer_con>");
                            //System.err.println("Before" + p);
                            String sql3 = "select cons_no,cons_nm1,flat_no,blk_no,sector from " + mst_table + " where  trim(sector)='" + sec + "'  and (status= 'A' or status is null) and  trim(CONS_NO) is not null and (CONS_NM1 is null or CON_TP is null or CONS_CTG is null or (FLAT_TYPE is null or (FLAT_TYPE='PLOT' and PLOT_SIZE is null)) or PIPE_SIZE is null or CONN_DT is null)"
                                    + "order by trim(cons_no)";
                            ps = con.prepareStatement(sql3);
                            rs = ps.executeQuery();

                            w.println("<consumer_withoutcon>");
                            while (rs.next() && !threaddone) {
                                p++;
                                cons_no = rs.getString(1).trim();
                                //System.err.println("Consumer:"+cons_no);
                                cons_nm1 = rs.getString(2);
                                if (cons_nm1 != null) {
                                    cons_nm1 = cons_nm1.replaceAll("&", "AND");
                                } else {
                                    cons_nm1 = "_";
                                }
                                flat_no = rs.getString(3);
                                if (flat_no != null) {
                                    flat_no = flat_no.replaceAll("&", " AND ").trim();
                                } else {
                                    flat_no = "";
                                }
                                blk_no = rs.getString(4);
                                if (blk_no != null) {
                                    blk_no = blk_no.replaceAll("&", " AND ").trim();
                                } else {
                                    blk_no = "";
                                }
                                sector = rs.getString(5);
                                if (sector != null) {
                                    sector = sector.replaceAll("&", " AND ").trim();
                                } else {
                                    sector = "";
                                }

                                address = blk_no + "-" + flat_no + "/" + sector;
                                if (address == null) {
                                    address = "_";
                                }

                                w.println("<consumer_wocon>");
                                w.println(cons_no + ":" + cons_nm1 + ":" + address);

                                w.println("</consumer_wocon>");

                            }
                            w.println("</consumer_withoutcon>");


                            w.println("</sec_" + sec + ">");
                            totcons_w.println("</sec_" + sec + ">");
                            count++;
                        }
                    }
                    w.println("</" + division + ">");
                    totcons_w.println("</" + division + ">");
                }
                p = totcons;
                w.println("</cons_details>");
                totcons_w.println("</cons_details>");
                w.close();
                totcons_w.close();
                rs.close();
                con.commit();
                con.close();
                //System.out.println("Connection closed1");
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
        int totalsec;
        String bdate = null;
        ConvertToDate ctd;
        String strbill_date = null;
        String path;
        int i = 0;

        int totcons = 0;
        Object o;
        ServletContext context;
        PreparedStatement pst;
        String xmlpath;
        String totcons_path;
        Connection con;
        java.sql.Date update_dt = new java.sql.Date(new java.util.Date().getTime());

        HttpSession session = request.getSession(true);
        //System.out.print("Inside doGet()");
        MyPdf pdf;

        try {
            session.setAttribute("del", 1);

            String userid = (String) session.getAttribute("userid");
            String username = (String) session.getAttribute("username");
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
                    context = getServletContext();
                    xmlpath = context.getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                    //con = DBConnection1.dbConnection(xmlpath);
                    InitialContext initialContext = new InitialContext();
                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                    con = dataSource.getConnection();
                    //System.out.println("Connection Open2");
                    path = context.getRealPath("") + "/resources/xmlreports/cons_report.xml";
                    totcons_path = context.getRealPath("") + "/resources/xmlreports/totcons_report.xml";
                    totcons = pdf.totcons;
                    totalsec = pdf.totalsec;
                    changes(response.getOutputStream(), sec, path, username, session, request, response, con);
                    if (pdf.getPercentage() == totcons) {

                        session.removeAttribute("myPdf");
                        //------Insert xml file into database--------------//


                        File xmlfile = new File(path);
                        File totcons_file = new File(totcons_path);
                        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                        DocumentBuilder builder = factory.newDocumentBuilder();
                        org.w3c.dom.Document doc = builder.parse(xmlfile);
                        org.w3c.dom.Document doc1 = builder.parse(totcons_file);

                        TransformerFactory transformerFactory = TransformerFactory.newInstance();
                        Transformer transformer = transformerFactory.newTransformer();
                        //transformer.setOutputProperty(OutputKeys.INDENT, "yes");

                        StringWriter writer = new StringWriter();
                        StreamResult result = new StreamResult(writer);
                        DOMSource source = new DOMSource(doc);
                        transformer.transform(source, result);
                        String string = writer.toString();

                        StringWriter writer1 = new StringWriter();
                        StreamResult result1 = new StreamResult(writer1);
                        DOMSource source1 = new DOMSource(doc1);
                        transformer.transform(source1, result1);

                        String totcons_string = writer1.toString();


//                        String sql = "delete from reports_tab where report_type='cons_report' or report_type='totcons_report'";
//                        pst = con.prepareStatement(sql);
//                        pst.executeUpdate();
                        String sql = "select max(id) as high from reports_tab";
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
                        String sql1 = "insert into reports_tab(id,sec,update_dt,xmlfile,report_type) values(" + content_id + ",?,?,?,?)";


                        pst = con.prepareStatement(sql1);
                        pst.setString(1, "jal");
                        pst.setDate(2, update_dt);
                        pst.setString(3, string);
                        pst.setString(4, "cons_report");

                        int j = pst.executeUpdate();
                        sql = "select * from reports_tab";
                        pst = con.prepareStatement(sql);
                        rs = pst.executeQuery(sql);
                        content_id = new Long(0);
                        while (rs.next()) {

                            if (content_id < rs.getLong("id")) {
                                content_id = rs.getLong("id");
                            }
                        }
                        content_id = content_id + 1;
                        sql1 = "insert into reports_tab(id,sec,update_dt,xmlfile,report_type) values(" + content_id + ",?,?,?,?)";


                        pst = con.prepareStatement(sql1);
                        pst.setString(1, "jal");
                        pst.setDate(2, update_dt);
                        pst.setString(3, totcons_string);
                        pst.setString(4, "totcons_report");

                        j = pst.executeUpdate();
//-----------------------------------------------------------------------------------------//
                        isFinished(response.getOutputStream(), sec, path, username, request);
                        //System.out.println("Report Generated-----------------------------");
                        pst.close();
                        return;
                    }

                    con.close();
                    System.out.println("Connection closed2");
                    path = context.getRealPath("") + "/resources/xmlreports/cons_report.xml";
                    isBusy(pdf, response.getOutputStream(), path, username, totalsec, request);
                    return;
            }

        } catch (Exception ex) {
            System.out.println(ex);
        }

    }

    void changes(ServletOutputStream stream, String sec, String path, String username, HttpSession session, HttpServletRequest request, HttpServletResponse response, Connection con) throws IOException, SQLException {
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
        String position;
        PreparedStatement pst;
        ResultSet rs;
        // Connection con;
        String con_id;
        stream.print("<html><head>"
                + "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" />"
                + "<script type=\"text/javascript\" SRC=\"" + request.getContextPath() + "/resources/js/jquery.min.js\"></script>"
                + "<script type=\"text/javascript\" SRC=\"" + request.getContextPath() + "/resources/js/jquery.cycle.js\"></script>"
                + "<script type=\"text/javascript\" SRC=\"" + request.getContextPath() + "/resources/js/jquery.tweet.js\"></script>"
                + "<script type=\"text/javascript\" SRC=\"" + request.getContextPath() + "/resources/js/jquery.scroll.js\"></script>"
                + "<script type=\"text/javascript\" SRC=\"" + request.getContextPath() + "/resources/js/jquery.lightbox.js\"></script>"
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
            System.out.println("Connection Open3");
            sql = "select con_id,con_title,position from jal_content where content_type='page'and (display='default' or display='home') order by priority";
            // con = (Connection) pageContext.getServletContext().getAttribute("con");
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                con_id = rs.getString(1);
                con_title = rs.getString(2);
                position = rs.getString(3);
                if (position != null && position.trim().equals("news")) {
                if (pageflag == 1) {

                    stream.print("<li class=\"active\" ><a href=\"" + request.getContextPath() + "/jsppages/sitepages/page.jsp?con_id=" + con_id + "\" >" + con_title + "</a></li>");

                } else {

                    stream.print("<li><a href=\"" + request.getContextPath() + "/jsppages/sitepages/page.jsp?con_id=" + con_id + "\">" + con_title + "</a></li>");

                }
            } else {
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
            System.out.println("Connection closed3");
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
                + "Connection Report"
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

    private void isBusy(MyPdf pdf, ServletOutputStream stream, String path, String username, int totalsec, HttpServletRequest request)
            throws IOException, NamingException, SQLException {
        stream.print("<title>Please wait...</title><meta http-equiv=\"Refresh\" content=\"5\"></head>");
        // + "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" /></head>");
        //   + "<div id=\"canvas\"><div id=\"header\"><div class=\"inside\"><div class=\"container\"><div id=\"logo\">"
        //  + "<img SRC=\"resources/images/logo.png\" alt=\"noida_logo\" /></div><div id=\"toolbar\">"
        //  + "<div class=\"logout\"> <a href=\"/OnlineJal/RedirectToCP?page=ArrearReport\" >Change Password</a>&nbsp;|&nbsp;<a href=\"jsppages/common/logout.jsp\">Logout</a>"
        //   + "</div><br/><div class=\"wel\">Welcome " + username + "</div></div></div></div></div></div>"
//                + "<div id=\"helper\"><div class=\"inside\"><div class=\"container\"><div class=\"leftcorners\"><div class=\"rightcorners\">"
//                + "<div class=\"bg\"></div></div></div></div></div></div>"
//                + "<div id=\"heading\"><div class=\"inside\"><div class=\"container\"><div id=\"headinger\"><div class=\"head\"><div class=\"content\">"
//                + "<h2>OnlineJal</h2></div> </div></div> <div id=\"arrowhide\">"
//                + "<a href=\"#\" title=\"Hide/Show Slideshow\"></a></div></div></div></div>"
        //   );
        stream.print("<div id=\"content\"><div class=\"inside\"><div class=\"container\"><div id=\"centerrail\"><div id=\"content\"> <div class=\"inside\">"
                + "<div class=\"container\"><div id=\"contentrail\" class=\"full\"><br/><br/>");
        stream.print(totalsec - pdf.count + " sectors are left in division " + pdf.division + ". Please Wait while this page refreshes automatically (every 5 seconds)</div>"
                + "<form action=\"/OnlineJal/CancelConsumerDet\" method=\"post\">"
                + "<input type=\"hidden\" name=\"path\" value=\"" + path + "\">"
                + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <div class=\"buttons\">"
                + "<button class=\"submit\" type=\"submit\" value=\"Cancel\" ><span class=\"leftcorners\">"
                + "<span class=\"rightcorners\"><span class=\"bg\">Cancel</span></span></span></button></div></form>"
                + "</div></div></div></div></div></div>"
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

    private void isFinished(ServletOutputStream stream, String sec, String path, String username, HttpServletRequest request) throws IOException, NamingException, SQLException {
        stream.print("<title>The document is finished.</title></head>");
        //+ "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" /></head>");
        // + "<div id=\"canvas\"><div id=\"header\"><div class=\"inside\"><div class=\"container\"><div id=\"logo\">"
        //  + "<img SRC=\"resources/images/logo.png\" alt=\"noida_logo\" /></div><div id=\"toolbar\">"
        // + "<div class=\"logout\"> <a href=\"jsppages/common/ch_pwd.jsp\">Change Password</a>&nbsp;|&nbsp;<a href=\"jsppages/common/logout.jsp\">Logout</a>"
        // + "</div><br/><div class=\"wel\">Welcome " + username + "</div></div></div></div></div></div>"
//                + "<div id=\"helper\"><div class=\"inside\"><div class=\"container\"><div class=\"leftcorners\"><div class=\"rightcorners\">"
//                + "<div class=\"bg\"></div></div></div></div></div></div>"
//                + "<div id=\"heading\"><div class=\"inside\"><div class=\"container\"><div id=\"headinger\"><div class=\"head\"><div class=\"content\">"
//                + "<h2>OnlineJal</h2></div> </div></div> <div id=\"arrowhide\">"
//                + "<a href=\"#\" title=\"Hide/Show Slideshow\"></a></div></div></div></div>"
        //  );
        stream.print("<div id=\"content\"><div class=\"inside\"><div class=\"container\"><div id=\"centerrail\"><div id=\"content\"> <div class=\"inside\">"
                + "<div class=\"container\"><div id=\"contentrail\" class=\"full\"><br/><br/>");


        stream.print("The document is finished:&nbsp;&nbsp;&nbsp;&nbsp;</div></div><form method=\"POST\">"
                + "<input type=\"hidden\" name=\"path\" value=\"" + path + "\">"
                + "<input type=\"hidden\" name=\"sec\" value=\"" + sec + "\">"
                + "<div class=\"buttons\">"
                + "<button class=\"submit\" type=\"submit\" value=\"Get Pdf\" ><span class=\"leftcorners\">"
                + "<span class=\"rightcorners\"><span class=\"bg\">Get Pdf</span></span></span></button></div> "
                + "<a href=\"jsppages/reports/cons_report.jsp\">"
                + "<div class=\"buttons\"><button class=\"submit\" type=\"submit\" value=\"Back\" ><span class=\"leftcorners\">"
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


        String mst_table;
        String sec;
        String cons_no;

        String cons_nm1;

        String flat_no;
        String blk_no;
        String sector;

        Object o;
        String division;

        String address;


        ByteArrayOutputStream baos;

        String path = request.getParameter("path");


        mst_table = (String) request.getParameter("sec");


        //response.setContentType("application/pdf");
        Rectangle pageSize = new Rectangle(720, 864);
        Document document = new Document(pageSize);
        try {


            baos = new ByteArrayOutputStream();
            PdfWriter docWriter = null;
            docWriter = PdfWriter.getInstance(document, baos);
            //document.setPageSize(PageSize.ARCH_B);
            Eventr er = new Eventr();
            docWriter.setPageEvent(er);
            document.open();

            float[] widths1 = {2.5f, 5f, 2.5f};
            PdfPTable table = new PdfPTable(widths1);
            table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);

            PdfPCell cell = new PdfPCell(new Paragraph("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY"));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(3);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(20.0f);
            table.addCell(cell);
            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            org.w3c.dom.Document docxml = docBuilder.parse(path);

            // normalize text representation
            docxml.getDocumentElement().normalize();
            //System.out.println("Root element of the doc is "
            // + docxml.getDocumentElement().getNodeName());


            NodeList nl = docxml.getElementsByTagName("cons_details");


            NodeList nl1 = nl.item(0).getChildNodes();
            for (int l = 1; l < nl1.getLength(); l = l + 2) {
                division = nl1.item(l).getNodeName().trim();
                cell = new PdfPCell(new Paragraph("Consumer/Connection report for -" + division.toUpperCase()));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setColspan(3);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(15.0f);
                table.addCell(cell);

                if (nl1.item(l).hasChildNodes()) {
                    NodeList nl2 = nl1.item(l).getChildNodes();
                    // System.out.println("length is" + nl2.getLength());
                    for (int i = 1; i < nl2.getLength(); i = i + 2) {
                        sec = nl2.item(i).getNodeName().trim();
                        sec = sec.substring(4).toUpperCase();
                        // System.out.println("Children is" + sec);

                        cell = new PdfPCell(new Paragraph("Consumer/Connection report for Sector -" + sec));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(3);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        NodeList nl3 = docxml.getElementsByTagName("sec_" + sec);

                        //Total consumer/connections

                        //NodeList totcon= docxml.getElementsByTagName("totconc");
                        nl3 = nl3.item(0).getChildNodes();

                        int m = 1;
                        String totconc = nl3.item(m).getTextContent().trim();
                        m = m + 2;

                        cell = new PdfPCell(new Paragraph("1. Total number of connections/consumers-" + totconc));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(3);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);
                        ////////////////////////////////

                        //Consumers with connection

                        // NodeList totcons= docxml.getElementsByTagName("totcons");

                        String totcons_sec = nl3.item(m).getTextContent().trim();
                        m = m + 2;

//                        cell = new PdfPCell(new Paragraph("2. Number of consumrs with complete connection details-" + totcons_sec));
//                        cell.setBorder(Rectangle.NO_BORDER);
//                        cell.setColspan(3);
//                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
//                        cell.setPaddingBottom(15.0f);
//                        table.addCell(cell);


                        String totcons_nocon_sec = nl3.item(m).getTextContent().trim();
                        m = m + 2;

//                        cell = new PdfPCell(new Paragraph("3. Number of consumers with incomplete connection details-" + totcons_nocon_sec));
//                        cell.setBorder(Rectangle.NO_BORDER);
//                        cell.setColspan(3);
//                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
//                        cell.setPaddingBottom(15.0f);
//                        table.addCell(cell);

                        ////////////////////////////////////////

                        //List of consumers with complete details
                        cell = new PdfPCell(new Paragraph("2. List of consumers with complete connection details:-"));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(3);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph("Consumer Number"));
                        cell.setBorder(Rectangle.BOTTOM);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph("Consumer Name"));
                        cell.setBorder(Rectangle.BOTTOM);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph("Address"));
                        cell.setBorder(Rectangle.BOTTOM);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);



                        // NodeList consumer = docxml.getElementsByTagName("consumer_con");

                        NodeList consumer = nl3.item(m).getChildNodes();
                        m = m + 2;
                        int total_cons = consumer.getLength();
                        //System.out.println("Total no of consumers : " + total_cons);
                        int k = 0;
                        for (int s = 1; s < consumer.getLength(); s = s + 2) {
                            String cons = consumer.item(s).getTextContent().trim();

                            String a[] = cons.split(":");

                            cons_no = a[0];
                            cons_nm1 = a[1];
                            address = a[2];

                            k = k + 1;



                            cell = new PdfPCell(new Paragraph(k + ". " + cons_no));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                            table.addCell(cell);



                            cell = new PdfPCell(new Paragraph(cons_nm1));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                            table.addCell(cell);




                            cell = new PdfPCell(new Paragraph(address));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                            table.addCell(cell);


                        }
                        /////////////////////////////////////
                        /////////List of consumersw with incomplete records
                        Paragraph paragraph1 = new Paragraph(" ");
                        cell = new PdfPCell(paragraph1);
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(3);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        cell.setPaddingBottom(15.0f);
                        addEmptyLine(paragraph1, 2);
                        table.addCell(cell);
//********************

                        cell = new PdfPCell(new Paragraph("3. List of consumers with incomplete connection details:-"));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(3);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph("Consumer Number"));
                        cell.setBorder(Rectangle.BOTTOM);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph("Consumer Name"));
                        cell.setBorder(Rectangle.BOTTOM);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph("Address"));
                        cell.setBorder(Rectangle.BOTTOM);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);



                        NodeList consumer_wocon = nl3.item(m).getChildNodes();
                        m = m + 2;
                        int total_cons_wocon = consumer_wocon.getLength();
                        //System.out.println("Total no of consumers : " + total_cons_wocon);
                        int k_wocon = 0;
                        for (int j = 1; j < consumer_wocon.getLength(); j = j + 2) {

                            k_wocon = k_wocon + 1;

                            if (consumer_wocon.item(j) != null) {
                                String cons = consumer_wocon.item(j).getTextContent().trim();

                                String a[] = cons.split(":");
                                cons_no = a[0];
                                cons_nm1 = a[1];
                                address = a[2];

                                cell = new PdfPCell(new Paragraph(k_wocon + ". " + cons_no));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                                table.addCell(cell);



                                cell = new PdfPCell(new Paragraph(cons_nm1));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                                table.addCell(cell);



                                cell = new PdfPCell(new Paragraph(address));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                                table.addCell(cell);

                            }
                        }

                        cell = new PdfPCell(new Paragraph(""));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setColspan(3);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        cell.setPaddingBottom(15.0f);
                        table.addCell(cell);

                    }
                }
                cell = new PdfPCell(new Paragraph(""));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setColspan(3);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                cell.setPaddingBottom(15.0f);
                table.addCell(cell);
            }


            /////////////////////////////////////////////////
            table.setWidthPercentage(100);
            table.setHorizontalAlignment(Element.ALIGN_CENTER);

            document.add(table);
            document.newPage();

            document.add(new Paragraph("  "));
            document.close();
            docWriter.close();

            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            response.setContentType("application/pdf");
            response.setContentLength(baos.size());
            ServletOutputStream out = response.getOutputStream();
            baos.writeTo(out);
            out.flush();


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int j = 0; j < number; j++) {
            paragraph.add(new Paragraph(" "));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-store, no-cache");
        response.setDateHeader("Expires", 0);


        try {


            processRequest(request, response);
            HttpSession session = request.getSession(false);
            session.removeAttribute("myPdf");

        } catch (DocumentException e) {
            e.printStackTrace();
        }


    }
}
