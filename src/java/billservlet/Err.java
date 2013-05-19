/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package billservlet;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.smp.jal.ConvertToDate;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;

import java.text.SimpleDateFormat;
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

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.NodeList;

/**
 *
 * @author smp
 */
public class Err extends HttpServlet {

    public class MyPdf implements Runnable {

        Connection con;
        String sector;
        String sec;
        String cons_no;
        PreparedStatement ps;
        ResultSet rs;
        java.sql.Date billdate;
        String bdate = null;
        ConvertToDate ctd;
        java.sql.Date calbilldate;
        Calendar dt = Calendar.getInstance();
        String cons_nm1;
        String con_tp;
        String cons_ctg;
        String flat_type;
        String plot_size;
        String pipe_size;
        String conn_dt;
        String nodue_dt;
        int totcons = -1;
        Object o;
        String division;
        ArrayList<ArrayList> alsec = new <ArrayList>ArrayList();
        ArrayList al = new ArrayList();

        ;
        ArrayList alrow;
        int i = 0;
        int rows;
        public Thread t;
        int p = 0;
        float p1 = 0;
        int j = 0;
        DocumentBuilderFactory dbf = null;
        DocumentBuilder db = null;
        org.w3c.dom.Document doc = null;
        NodeList nl = null;
        String xmlpath = null;
        ServletContext context = null;
        String div = null;

        MyPdf(java.sql.Date billdate, String sec1) {
            calbilldate = billdate;
            sec = sec1;
            t = new Thread(this);
            al = new ArrayList<ArrayList>();
            alrow = new ArrayList();
            t.start();
        }

        public void run() {


            try {


                dbf = DocumentBuilderFactory.newInstance();
                db = dbf.newDocumentBuilder();
                context = getServletContext();
                xmlpath = context.getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                doc = db.parse(xmlpath);

                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                //con = DBConnection1.dbConnection(xmlpath);

                NodeList nl1 = doc.getElementsByTagName("division");

                div = nl1.item(0).getFirstChild().getNodeValue().trim();
                division = "JAL" + div;

                NodeList nl2 = doc.getElementsByTagName("master_tab");


                //sector="MASTER_"+division;
                sector = nl2.item(0).getFirstChild().getNodeValue().trim();


                String sql1 = "select COUNT(DISTINCT CONS_NO) from " + sector + " where  trim(sector)='" + sec + "' and CONS_NO is not null and (CONS_NM1 is  null or CON_TP is  null or CONS_CTG is  null or FLAT_TYPE is  null or (FLAT_TYPE='PLOT'and PLOT_SIZE is null) or PIPE_SIZE is  null  or CONN_DT is  null "
                        + "or ((to_char(CAL_DATE,'YYYY-MM-DD')>='" + billdate + "' and NODUE_DT IS NULL) or (NODUE_DT IS NOT NULL  and to_char(NODUE_DT,'YYYY-MM-DD')>='" + billdate + "'))) order by cons_no";

                ps =  con.prepareStatement(sql1);
                rs =  ps.executeQuery();
                if (rs.next()) {
                    totcons = rs.getInt(1);
                }

                String sql = "select cons_no,cons_nm1,con_tp,cons_ctg,flat_type,plot_size,pipe_size,conn_dt,nodue_dt from " + sector + " where  trim(sector)='" + sec + "' and  CONS_NO is not null and (CONS_NM1 is  null or CON_TP is  null or CONS_CTG is  null or FLAT_TYPE is  null or (FLAT_TYPE='PLOT'and PLOT_SIZE is null) or PIPE_SIZE is  null  or CONN_DT is  null "
                        + "or ((to_char(CAL_DATE,'YYYY-MM-DD')>='" + billdate + "' and NODUE_DT IS NULL) or (NODUE_DT IS NOT NULL  and to_char(NODUE_DT,'YYYY-MM-DD')>='" + billdate + "'))) order by cons_no";
                ps =  con.prepareStatement(sql);
                rs =  ps.executeQuery();
                while (rs.next()) {
                    p++;
                    cons_no = rs.getString(1);
                    cons_nm1 = rs.getString(2);
                    con_tp = rs.getString(3);
                    cons_ctg = rs.getString(4);
                    flat_type = rs.getString(5);
                    plot_size = rs.getString(6);
                    pipe_size = rs.getString(7);
                    conn_dt = rs.getString(8);
                    nodue_dt = rs.getString(9);
                    al.add(0, cons_no);
                    al.add(1, cons_nm1);
                    al.add(2, con_tp);
                    al.add(3, cons_ctg);
                    al.add(4, flat_type);
                    al.add(5, plot_size);
                    al.add(6, pipe_size);
                    al.add(7, conn_dt);
                    al.add(8, nodue_dt);
                    alsec.add(new ArrayList(al));
                    al.clear();

                }
                rs.close();
                con.commit();
                con.close();
//                if (!con.isClosed()) {
//                    con.close();
//                }
            } catch (Exception ex) {
                System.out.println("Exception in Err:" + ex);
            }
            //p=totcons;

        }

        public ArrayList<ArrayList> calAl() {

            return alsec;
        }

        public int getPercentage() {
            return p;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {



        String cons_no;
        String sec = null;

        Calendar calbilldate = Calendar.getInstance();
        java.sql.Date billdate = null;
        String bdate = null;
        ConvertToDate ctd;
        String strbill_date = null;
        ArrayList<ArrayList> alsec;
        int i = 0;

        int totcons = 0;
        Object o;


        HttpSession session = request.getSession(true);
        //System.out.print("Inside doGet()");
        MyPdf pdf;



        try {


            ctd = new ConvertToDate();

            sec = request.getParameter("sec");

            bdate = request.getParameter("billdate");
            if (bdate.equals("")) {
                billdate = null;
                calbilldate = null;
            } else {
                calbilldate.setTimeInMillis(ctd.convertStringToCLDate(bdate).getTimeInMillis());
                billdate = new java.sql.Date(calbilldate.getTimeInMillis());
            }

            i++;
            o = session.getAttribute("myPdf");
            if (o == null) {
                pdf = new MyPdf(billdate, sec);
                session.setAttribute("myPdf", pdf);
                //Thread t = new Thread(pdf);
                //t.start();
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
                    if (pdf.getPercentage() == totcons) {
                        alsec = pdf.calAl();
                        session.removeAttribute("myPdf");
                        isFinished(response.getOutputStream(), strbill_date, sec, alsec);
                        System.out.println("Error List Generated-----------------------------");
                        return;
                    }
                    isBusy(pdf, response.getOutputStream());
                    return;
            }

        } catch (Exception ex) {
            System.out.println(ex);
        }

    }

    private void isBusy(MyPdf pdf, ServletOutputStream stream)
            throws IOException {
        stream.print("<html><head><title>Please wait...</title><meta http-equiv=\"Refresh\" content=\"5\">"
                + "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" />"
                + "<div id=\"login\"><div id=\"login-wrapper\" class=\"png_bg\"><div id=\"login-top\">"
                + "<img  alt=\"DMS-JAL\"  src=\"resources/images/logo.png\"/><div id=\"profile-links\">"
                + "<a href=\"jsppages/common/logout.jsp\"  title=\"Sign Out\">Sign Out</a>&nbsp;|&nbsp;"
                + "<a href=\"/DMS/RedirectToCP?page=Err\"  title=\"Sign Out\"> Change Password</a> </div> </div></div></div></head>"
                + "<body> <div id=\"body-wrapper\"> ");
        stream.print(" <div id=\"main-content\">  <div class=\"content-box\"><div class=\"content-box-header\"></div><div class=\"content-box-content \">");


        stream.print("Please Wait while this page refreshes automatically (every 5 seconds)</div></div></div><div id=\"footer\">"
                + "<p>&copy; 2009 <a href=\"http//www.smptechnologies.org\">SMP Technologies Pvt. Ltd.</a></p></div></div></body>\n</html>");
    }

    private void isFinished(ServletOutputStream stream, String bill_date, String sec, ArrayList<ArrayList> al) throws IOException {
        stream.print("<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" />"
                + "<div id=\"login\"><div id=\"login-wrapper\" class=\"png_bg\"><div id=\"login-top\">"
                + "<a href=\"jsppages/Search/search.jsp\"><img  alt=\"DMS-JAL\"  src=\"resources/images/logo.png\"/></a><div id=\"profile-links\">"
                + "<a href=\"jsppages/common/logout.jsp\"  title=\"Sign Out\">Sign Out</a>&nbsp;|&nbsp;"
                + "<a href=\"jsppages/common/ch_pass.jsp\"  title=\"Sign Out\"> Change Password</a> </div> </div></div></div></head>"
                + "<body> <div id=\"body-wrapper\">");

        stream.print(" <div id=\"main-content\">  <div class=\"content-box\"><div class=\"content-box-header\"></div><div class=\"content-box-content \">"
                + " <div class=\"notification information png_bg\"><a href=\"#\" class=\"close\">"
                + "<img src=\"resources/images/icons/cross_grey_small.png\" title=\"Close this notification\" alt=\"close\" /></a><div>"
                + "The document is finished:&nbsp;&nbsp;&nbsp;&nbsp;</div></div><form method=\"POST\">"
                + "<input type=\"hidden\" name=\"al\" value=\"" + al + "\">"
                + "<input type=\"hidden\" name=\"sec\" value=\"" + sec + "\"><input type=\"hidden\" name=\"billdate\" value=\"" + bill_date + "\">"
                + "<input type=\"Submit\"  class=\"button\" value=\"Get PDF\"> <a href=\"jsppages/duprecords/error_list.jsp\"><input type=\"button\"  class=\"button\" value=\"Back\"></a></form></div></div></div><div id=\"footer\"><small>"
                + "<p >Copyright &copy; 2009 Developed for JAL by <a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a></p></small></div></div></body>\n</html>");


    }

    private void isError(ServletOutputStream stream) throws IOException {
        stream.print("<html>\n\t<head>\n\t\t<title>Error</title>\n\t</head>\n\t<body>");
        stream.print("An error occured.\n\t</body>\n</html>");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, DocumentException {


        //Connection con;
        String sector;
        String sec;
        String cons_no;
        PreparedStatement ps;
        ResultSet rs;
        java.sql.Date billdate;
        String bdate = null;
        ConvertToDate ctd;
        Calendar calbilldate = Calendar.getInstance();
        Calendar dt = Calendar.getInstance();
        String cons_nm1;
        String con_tp;
        String cons_ctg;
        String flat_type;
        String plot_size;
        String pipe_size;
        String conn_dt;
        String nodue_dt;
        int totcons = 0;
        Object o;
        String division;

        ArrayList<ArrayList> alsec = new <ArrayList>ArrayList();
        ArrayList alr1;

        ArrayList al = new ArrayList();
        ArrayList alrow;
        int i = 0;
        int rows;


        ByteArrayOutputStream baos;
        SimpleDateFormat formatter;
        java.util.Date utilconn_dt = null;
        java.util.Date utilnodue_dt = null;

        String alist = request.getParameter("al");
        alr1 = new ArrayList();

        alsec = new ArrayList<ArrayList>();

        alist = alist.substring(alist.indexOf("[") + 1, alist.lastIndexOf("]"));

        String[] aliststr = alist.split("]");

        for (int l = 0; l < aliststr.length; l++) {
            String[] alstr = aliststr[l].split(",");
            for (int m = 0; m < alstr.length; m++) {
                if (m == 0 && l == 0) {
                    alr1.add(alstr[m].substring(1));
                } else if (m == 1 && l != 0) {
                    alr1.add(alstr[m].substring(2));
                } else if (m != 0) {
                    alr1.add(alstr[m]);
                }

            }
            alsec.add(new ArrayList(alr1));
            alr1.clear();
        }
        rows = alsec.size();

        sector = (String) request.getParameter("sec");
        response.setHeader("Content-Disposition", "attachment;filename=" + "ErrorList.pdf");


        //response.setContentType("application/pdf");
        Rectangle pageSize = new Rectangle(720, 864);
        Document document = new Document(pageSize);
        try {
            //PdfWriter.getInstance(document,new FileOutputStream("C:/DEFAULTER"+sector+".pdf") );

            baos = new ByteArrayOutputStream();
            PdfWriter docWriter = null;
            docWriter = PdfWriter.getInstance(document, baos);
            //document.setPageSize(PageSize.ARCH_B);
            document.open();

            float[] widths1 = {2f, 1f, 1f, 1f, 1f, 1f, 1f, 1f, 1f};
            PdfPTable table = new PdfPTable(widths1);
            table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);

            PdfPCell cell = new PdfPCell(new Paragraph("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY"));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(9);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(30.0f);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Error list of consumers for Sector-" + sector));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(6);
            cell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
            cell.setPaddingBottom(10.0f);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph());
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(6);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPaddingBottom(10.0f);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Consumer Name"));
            cell.setBorder(Rectangle.BOTTOM);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Consumer Number"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Connection Type"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Connection Category"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Flat Type"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Plot size"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Pipe size"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Connection Date"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("No Due Date"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);


            for (int k = 0; k < rows; k++) {
                alrow = (ArrayList) alsec.get(k);
                cons_no = (String) alrow.get(0);
                if (cons_no.trim().equals("null")) {
                    cons_no = " ";
                }
                cons_nm1 = (String) alrow.get(1);
                if (cons_nm1.trim().equals("null")) {
                    cons_nm1 = " ";
                }
                con_tp = (String) alrow.get(2);
                if (con_tp.trim().equals("null")) {
                    con_tp = " ";
                }
                cons_ctg = (String) alrow.get(3);
                if (cons_ctg.trim().equals("null")) {
                    cons_ctg = " ";
                }
                flat_type = (String) alrow.get(4);
                if (flat_type.trim().equals("null")) {
                    flat_type = " ";
                }
                plot_size = (String) alrow.get(5);
                if (plot_size.trim().equals("null")) {
                    plot_size = " ";
                }
                pipe_size = (String) alrow.get(6);
                if (pipe_size.trim().equals("null")) {
                    pipe_size = " ";
                }
                conn_dt = (String) alrow.get(7);

                if (conn_dt.trim().equals("null")) {
                    conn_dt = " ";
                } else {
                    try {
                        formatter = new SimpleDateFormat("yyyy-MM-dd");
                        utilconn_dt = (java.util.Date) formatter.parse(conn_dt);
                    } catch (ParseException e) {
                        System.out.println("Exception:" + e);
                    }
                    formatter = new SimpleDateFormat("dd-MMM-yy");
                    conn_dt = formatter.format(new java.sql.Date(utilconn_dt.getTime()));

                }

                nodue_dt = (String) alrow.get(8);

                if (nodue_dt.trim().equals("null")) {
                    nodue_dt = " ";
                } else {
                    try {
                        formatter = new SimpleDateFormat("yyyy-MM-dd");
                        utilnodue_dt = (java.util.Date) formatter.parse(nodue_dt);
                    } catch (ParseException e) {
                        System.out.println("Exception:" + e);
                    }
                    formatter = new SimpleDateFormat("dd-MMM-yy");
                    nodue_dt = formatter.format(new java.sql.Date(utilnodue_dt.getTime()));

                }
                cell = new PdfPCell(new Paragraph(cons_nm1));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);


                //table.addCell (cons_no);
                cell = new PdfPCell(new Paragraph(cons_no));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                // table.addCell (address);
                cell = new PdfPCell(new Paragraph(con_tp));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                //table.addCell (Double.toString(principal));
                cell = new PdfPCell(new Paragraph(cons_ctg));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                //table.addCell (Double.toString(principal));
                cell = new PdfPCell(new Paragraph(flat_type));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                //table.addCell (Double.toString(principal));
                cell = new PdfPCell(new Paragraph(plot_size));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                // table.addCell (Double.toString(interest));
                cell = new PdfPCell(new Paragraph(pipe_size));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                //table.addCell (Double.toString(principal));
                cell = new PdfPCell(new Paragraph(conn_dt));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                //table.addCell (Double.toString(principal));
                cell = new PdfPCell(new Paragraph(nodue_dt));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);


            }
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


            processRequest(request, response);
            HttpSession session = request.getSession(false);
            session.removeAttribute("myPdf");

        } catch (DocumentException e) {
            e.printStackTrace();
        }


    }
}
