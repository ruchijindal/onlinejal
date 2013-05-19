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
                sql = "select userid from userlogin";
                pst = con.prepareStatement(sql);
                rs = pst.executeQuery();
                while (rs.next()) {
                    if (userid.equals(rs.getString("userid"))) {
                        flag = true;
                        break;
                    } else {
                        flag = false;
                    }
                }

                if (flag) {
                    t = 2;
                    request.getSession(true);
                    request.setAttribute("t", t);
%>
<jsp:forward page="create_user.jsp"/>
<%
                } else {
                    password = request.getParameter("password");

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





                    username = request.getParameter("username");

                    userrole = request.getParameter("userrole");
                    createdby = request.getParameter("createdby");

                    ctd = new ConvertToDate();
                    sql = "insert into userlogin values(?,?,?,?,?,?)";
                    pst = con.prepareStatement(sql);
                    pst.setString(1, username);
                    pst.setString(2, userid);
                    pst.setString(3, encyptpass);
                    pst.setString(4, userrole);
                    pst.setDate(5, new java.sql.Date(crdt));
                    pst.setString(6, createdby);
                    i = pst.execute();

                    if (!i) {
                        t = 4;
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

<jsp:forward page="create_user.jsp"/>


<%
                    }
                }
            } catch (Exception ex) {
                System.out.println(ex);
                t = 1;
                request.getSession(true);
                request.setAttribute("t", t);
%>
%>
<jsp:forward page="create_user.jsp"/>

<%
            } finally {
                con.close();
            }



%>
