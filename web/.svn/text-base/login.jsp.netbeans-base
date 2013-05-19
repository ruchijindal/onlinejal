<%@page import="com.smp.jal.SelectSec_Div"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.security.*;" %>

<%!    String userid;
    String password;
    String userrole;
    String username;
    Connection con;
    ResultSet rs = null;
    String sql;
    PreparedStatement pst;
    int t1 = 0;
    int x;
    String sec;
    String sector;
    String encyptpass = "";
    MessageDigest algorithm = null;
    String cons_nm;
    String division;
    String trans_nm;
    String trf;
    ServletContext context = null;
 String xmlpath;
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document docxml = null;
%>


<%
            userid = request.getParameter("userid");
            password = request.getParameter("password");
            password=password.trim();
            if (password == null || userid == null) {
                t1 = 1;
                request.setAttribute("t1", t1);
%>


<jsp:forward page="index.jsp"/>


<%
            } else {

                try {
                    algorithm = MessageDigest.getInstance("SHA-256");
                } catch (NoSuchAlgorithmException nsae) {
                    System.out.println("Cannot find digest algorithm" + nsae);
                    System.exit(1);
                }

                byte[] defaultBytes = password.getBytes();
                algorithm.reset();
                algorithm.update(defaultBytes);
                byte messageDigest[] = algorithm.digest();
                StringBuffer hexString = new StringBuffer();

                for (int i = 0; i < messageDigest.length; i++) {
                    String hex = Integer.toHexString(0xFF & messageDigest[i]);
                    if (hex.length() == 1) {
                        hexString.append('0');
                    }
                    hexString.append(hex);
                }
                encyptpass = hexString.toString();
                try {
                    InitialContext initialContext = new InitialContext();
                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                    con = dataSource.getConnection();
                    //con = (Connection) pageContext.getServletContext().getAttribute("con");
                    sql = "select userid,password,userrole,username from userlogin where userid='" + userid.trim() + "'and password='" + encyptpass + "'";
                    pst = con.prepareStatement(sql);
                    rs = pst.executeQuery();
 
                    if (rs.next()) {
                        request.getSession(true);
                        userid = rs.getString(1);
                        password = rs.getString(2);
                        userrole = rs.getString(3);
                        username = rs.getString(4);
                        session.setAttribute("userrole", userrole);
                        session.setAttribute("userid", userid);
                        session.setAttribute("username", username);

                        response.sendRedirect("index.jsp");

                    } else if (password.equals("abc")) //consumer login  starts
                    {


                        if (userid != null && !userid.equals("")) {
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

                  dbf = DocumentBuilderFactory.newInstance();
                                        db = dbf.newDocumentBuilder();
                                        xmlpath = getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";
                                        docxml = db.parse(xmlpath);
                                        SelectSec_Div sec_Div = new SelectSec_Div();
                                        division = sec_Div.getDevision(sec, docxml);




                     /*   if (sec.equals("01") || sec.equals("02") || sec.equals("03") || sec.equals("04") || sec.equals("05") || sec.equals("06") || sec.equals("07") || sec.equals("08") || sec.equals("09") || sec.equals("10") || sec.equals("11") || sec.equals("11IND") || sec.equals("12")
                                || sec.equals("14") || sec.equals("14A") || sec.equals("15") || sec.equals("15A") || sec.equals("16") || sec.equals("16A") || sec.equals("17") || sec.equals("18") || sec.equals("19") || sec.equals("22") || sec.equals("23") || sec.equals("24") || sec.equals("27") || sec.equals("55") || sec.equals("56") || sec.equals("57")
                                || sec.equals("58") || sec.equals("59") || sec.equals("60") || sec.equals("62") || sec.equals("63") || sec.equals("64") || sec.equals("65") || sec.equals("105")) {
                            division = "JAL1";
                        } else if (sec.equals("20") || sec.equals("21") || sec.equals("21A") || sec.equals("25") || sec.equals("26") || sec.equals("28") || sec.equals("29") || sec.equals("30") || sec.equals("31") || sec.equals("33") || sec.equals("33A") || sec.equals("34") || sec.equals("35")
                                || sec.equals("36") || sec.equals("37") || sec.equals("37ADD") || sec.equals("52") || sec.equals("53") || sec.equals("61") || sec.equals("71") || sec.equals("72")) {
                            division = "JAL2";
                        } else if (sec.equals("39") || sec.equals("40") || sec.equals("41") || sec.equals("42") || sec.equals("43") || sec.equals("44") || sec.equals("46") || sec.equals("47") || sec.equals("48") || sec.equals("49") || sec.equals("50") || sec.equals("51") || sec.equals("73") || sec.equals("80") || sec.equals("81") || sec.equals("82") || sec.equals("83") || sec.equals("84") || sec.equals("92") || sec.equals("93") || sec.equals("94") || sec.equals("95")) {
                            division = "JAL3";
                        }*/

                        sector = "MASTER_" + division.toUpperCase().trim();                     
                        sql = "select cons_no,cons_nm1,trans_nm,trf from  " + sector + "  where cons_no='" + userid + "'";
                        pst = con.prepareStatement(sql);
                        rs = pst.executeQuery();

                        if (rs.next() && password.equals("abc")) {
                            request.getSession(true);
                            userid = rs.getString(1);
                            cons_nm = rs.getString(2);
                            trans_nm = rs.getString(3);
                            trf = rs.getString(4);
                            if (trf != null && (!(trf.trim()).equals("null"))) {
                                cons_nm = trans_nm;
                            }

                            session.setAttribute("userrole", "consumer");
                            session.setAttribute("userid", userid);
                            session.setAttribute("cons_nm", cons_nm);
                            response.sendRedirect("index.jsp");

                        } else {
                            t1 = 1;
                            request.setAttribute("t1", t1);
                            response.sendRedirect("index.jsp");
                        }                                                            //consumer login ends

                    } else {

                        t1 = 1;
                        request.setAttribute("t1", t1);
                        
%>

<jsp:forward page="index.jsp"/>

<%
            }
        } catch (Exception ex) {
            System.out.println(ex);
            t1 = 1;
            request.setAttribute("t1", t1);
%>

<jsp:forward page="index.jsp"/>
<%

                } finally {
                    con.close();
                }
            }
%>
</body>
</html>

