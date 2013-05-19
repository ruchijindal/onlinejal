<%--
    Document   : ins_user
    Created on : 27 Nov, 2009, 10:47:30 AM
    Author     : smp
--%>

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.security.*;"%>
<%!    String username;
    String userid;
    String password;
    String userrole;
    String crdate;
    String createdby;
    String sql;
    Connection con;
    PreparedStatement pst;
    ConvertToDate ctd;
    boolean i;
    boolean flag = false;
    ResultSet rs;
    String encyptpass = "";
    MessageDigest algorithm = null;
    String sess;
    int t = 0;
%>


<%
            sess = (String) session.getAttribute("userrole");

            java.util.Date dt = new java.util.Date();
            long crdt = dt.getTime();
            userid = request.getParameter("userid");

            try {
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                //con = (Connection) pageContext.getServletContext().getAttribute("con");


                username = request.getParameter("username");
                userid = request.getParameter("userid");
                password = request.getParameter("password");
                userrole = request.getParameter("userrole");
                crdate = request.getParameter("crdate");
                createdby = request.getParameter("createdby");
               // con = (Connection) pageContext.getServletContext().getAttribute("con");
                ctd = new ConvertToDate();

                if (password.equals("")) {
                    sql = "update userlogin set username=?,userrole=?,crdate=?,createdby=? where userid=?";
                    pst = con.prepareStatement(sql);
                    pst.setString(1, username);
                    pst.setString(2, userrole);

                    java.sql.Date sqlcrdate = ctd.convertStringToDate(crdate);
                    pst.setDate(3, sqlcrdate);

                    pst.setString(4, createdby);
                    pst.setString(5, userid);
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



                    sql = "update userlogin set username=?,password=?,userrole=?,crdate=?,createdby=? where userid=?";
                    pst = con.prepareStatement(sql);
                    pst.setString(1, username);
                    pst.setString(2, encyptpass);
                    pst.setString(3, userrole);


                    java.sql.Date sqlcrdate = ctd.convertStringToDate(crdate);
                    pst.setDate(4, sqlcrdate);

                    pst.setString(5, createdby);
                    pst.setString(6, userid);
                }
                i = pst.execute();
                if (!i) {
                    t = 2;
                    request.getSession(true);
                    request.setAttribute("t", t);
%>
<jsp:forward page="view_user.jsp"/>

<%
                } else {
                    t = 1;
                    request.getSession(true);
                    request.setAttribute("t", t);
%>
<jsp:forward page="edit_user.jsp"/>
<%
                }


            } catch (Exception ex) {
                System.out.println(ex);
                t = 1;
                request.getSession(true);
                request.setAttribute("t", t);
%>
<jsp:forward page="edit_user.jsp"/>

<%
            } finally {
                con.close();
            }

%>
