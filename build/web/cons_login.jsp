<%@page import="com.smp.jal.SelectSec_Div"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.security.*;" %>

<%!    String userid;
    String flatno;
    String blkno;
    String sec;
    String division;
    Connection con;
    ResultSet rs = null;
    String sql;
    PreparedStatement pst;
    int t = 0;
    int x;
    String userrole;
    String sector;
    String cons_nm;
    String trans_nm;
    String trf;
    String xmlpath;
    String cons_option;
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document docxml = null;
    int a = 0;
%>


<%

            if (request.getParameter("a") == null) {
                a = 0;
            } else {
                a = Integer.parseInt(request.getParameter("a"));
            }

            userid = request.getParameter("userid");
            if (userid == null) {
                userid = "";
            }
            flatno = request.getParameter("flatno");
            blkno = request.getParameter("blkno");
            cons_option = request.getParameter("consno");

//System.out.println("Now -----  consno----->"+ cons_option);
if(cons_option==null)
    {
cons_option="select";
}
 //System.out.println("consno----->"+ cons_option);

            sec = request.getParameter("sec");
            if (sec == null) {
                sec = "";
            }
            division = request.getParameter("division");
            if (division == null) {
                division = "";
            }
            //System.out.println("flatNo-->"+flatno+"division-->"+division+"sec-->"+sec+"cons_option-->"+cons_option);
            if (flatno == null || sec == null || division == null || cons_option == null) {
               // System.out.println("block1=" + blkno);
                t = 1;
                request.setAttribute("t", t);
                if (a == 1) {
%>
<jsp:forward page="cons_detailslogin.jsp"/>
<%                } else {
%>

<jsp:forward page="index.jsp"/>


<%        // System.out.println("block2=" + blkno);
}
            } else {
                try {
                    InitialContext initialContext = new InitialContext();
                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                    con = dataSource.getConnection();
                    //con = (Connection) pageContext.getServletContext().getAttribute("con");
//System.out.println("Mohit userId1------>"+userid);
//System.out.println("mohit userrole1--->"+session.getAttribute("userrole"));
                    if (userid != null && !userid.equals("")) {
                        //System.out.println("when user id not eq null");
                        //System.out.println("Mohit userId2------>"+userid);
                        //System.out.println("mohit userrole2--->"+session.getAttribute("userrole"));
                        int l = (int) userid.charAt(7);
                        if (l >= 65 && l <= 90) {
                            x = Integer.parseInt(userid.substring(0, 2));
                        } else {
                            x = Integer.parseInt(userid.substring(0, 3));
                        }
                        sec = Integer.toString(x);
                        if (x < 10) {
                            sec = Integer.toString(x);
                            sec = "0" + sec;
                        }
                    }

                    SelectSec_Div sec_Div = new SelectSec_Div();

                    dbf = DocumentBuilderFactory.newInstance();
                    db = dbf.newDocumentBuilder();
                    xmlpath = pageContext.getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";
                    docxml = db.parse(xmlpath);
                    //System.out.println("Mohit Sector-->"+docxml.getDoctype());
                    //System.out.println("Mohit Sector-->"+sec);

                    division = sec_Div.getDevision(sec, docxml).toUpperCase();
                    char number = division.charAt((division.length() - 1));
                    sector = "MASTER" + number;
                   // System.out.println("in page-->" + sector);
                    if (request.getParameter("blkno") != null) {
                        blkno = request.getParameter("blkno").toUpperCase().trim();

                    } else {
                        //System.out.println("in page-->" + sector);
                        blkno = request.getParameter("blkno");
                    }

                    flatno = request.getParameter("flatno");
                    flatno = flatno.trim();
                    if (flatno == null) {
                        flatno = "";
                    }

                    int count = 0;
                    count = flatno.length();
                    if (count == 2) {
                        flatno = "0" + flatno;
                    } else if (count == 1) {
                        flatno = "00" + flatno;
                    }



//System.out.println("userId-->"+userid);
                    if (!userid.equals("")) {
//System.out.println("in userId  ---------------  if -->"+userid);
                        request.setAttribute("t", t);
                           //System.out.println("mohit userrole3--->"+session.getAttribute("userrole"));
                            session.setAttribute("userrole", "consumer");
                        session.setAttribute("userid", userid);
                        response.sendRedirect("jsppages/consumer/cons_details.jsp");


                    } else if (!flatno.equals("") && !sec.equals("") && !division.equals("")) {
                        //System.out.println("Mohit no4----->"+cons_option);
                        //System.out.println("Mohit userId4------>"+userid);
                       // System.out.println("mohit userrole4--->"+session.getAttribute("userrole"));
                        if (cons_option.trim().equals("N/A")) {
                          //  System.out.println("inside if");
                            cons_option = " ";
                        }


                        if (blkno.equals("NULL")) {

                            sql = "select cons_no,cons_nm1,trf,trans_nm from " + sector + " where flat_no=" + "'" + flatno.trim() + "' and trim(sector)=" + "'" + sec.trim() + "' and cons_no like '%" + cons_option.trim() +"%'  and (status= 'A' or status is null) order by cons_no";
                        System.out.println("query 1----> " +  sql);
                        } else {

                            if(cons_option.equals("select"))
                                {
                            cons_option=" ";
                            }

                           // System.out.println("cons_option+++++11 " + cons_option);
                            sql = "select cons_no,cons_nm1,trf,trans_nm from " + sector + " where blk_no=" + "'" + blkno + "' and flat_no=" + "'" + flatno.trim() + "' and trim(sector)=" + "'" + sec.trim() + "' and trim(sector)=" + "'" + sec.trim() + "' and cons_no like '%" + cons_option.trim() + "%' and (status= 'A' or status is null) order by cons_no" ;
                       System.out.println("query 2----> " + sql);
                        }
                        pst = con.prepareStatement(sql);
                        rs = pst.executeQuery();


                        if (rs.next()) {
                          //  System.out.println("inside if");
                            request.getSession(true);
                            userid = rs.getString(1);
                            cons_nm = rs.getString(2);
                            trf = rs.getString(3);
                            trans_nm = rs.getString(4);
                            if (trf != null && (!(trf.trim()).equals("null"))) {
                                cons_nm = trans_nm;
                            }
//System.out.println("Mohit userId------>"+userid);
                       // System.out.println("mohit userrole5--->"+session.getAttribute("userrole"));
                        if(session.getAttribute("userrole") == null)
                            {
                            session.setAttribute("userrole", "consumer");
                            }
                            session.setAttribute("userid", userid.trim());
                            session.setAttribute("cons_nm", cons_nm);
                           // System.out.println("query 2----> jsppages/consumer/cons_details.jsp"  );
                            //response.sendRedirect("jsppages/consumer/cons_details.jsp");
                             response.sendRedirect(request.getContextPath()+"/jsppages/consumer/cons_details.jsp");

                        } else {
                          //  System.out.println("inside else");
                            t = 1;
                            request.setAttribute("t", t);
                            if (a == 1) {
%>
<jsp:forward page="cons_detailslogin.jsp"/>
<%                        } else {
%>

<jsp:forward page="index.jsp"/>


<%                            }
                        }                                                            //consumer login ends

                    } else {

                        t = 1;
                        request.setAttribute("t", t);
                        if (a == 1) {
%>
<jsp:forward page="cons_detailslogin.jsp"/>
<% } else {
%>

<jsp:forward page="index.jsp"/>


<%                        }
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                    t = 1;
                    request.setAttribute("t", t);
                    if (a == 1) {
%>
<jsp:forward page="cons_detailslogin.jsp"/>
<% } else {
%>

<jsp:forward page="index.jsp"/>


<%                    }

                } finally {
                    con.close();
                }
            }
%>
</body>
</html>
