<%--
    Document   : ins_user
    Created on : 27 Nov, 2009, 10:47:30 AM
    Author     : smp
--%>

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.security.*;"%>
<%!    String userid;
    String password;
    String oldpassword;
    String npassword;
    String sql;
    Connection connn;
    int i;
    int cp = 0;
    String encyptoldpass = "";
    String encyptnewpass = "";
    MessageDigest algorithm = null;
    MessageDigest algorithmnew = null;
    MessageDigest algorithmold = null;
%>




<%


            userid = (String) session.getAttribute("userid");
            npassword = request.getParameter("npassword");
            oldpassword = request.getParameter("oldpassword");


            try {
                algorithmnew = MessageDigest.getInstance("SHA-256");
                algorithmold = MessageDigest.getInstance("SHA-256");

            } catch (NoSuchAlgorithmException nsae) {
                System.out.println("Cannot find digest algorithm" + nsae);
                System.exit(1);
            }

            byte[] defaultBytesNew = npassword.getBytes();
            algorithmnew.reset();
            algorithmnew.update(defaultBytesNew);
            byte messageDigestNew[] = algorithmnew.digest();
            StringBuffer hexStringNew = new StringBuffer();

            for (int i = 0; i < messageDigestNew.length; i++) {
                String hexNew = Integer.toHexString(0xFF & messageDigestNew[i]);
                if (hexNew.length() == 1) {
                    hexStringNew.append('0');
                }
                hexStringNew.append(hexNew);
            }
            encyptnewpass = hexStringNew.toString();

            byte[] defaultBytesOld = oldpassword.getBytes();
            algorithmold.reset();
            algorithmold.update(defaultBytesOld);
            byte messageDigestOld[] = algorithmold.digest();
            StringBuffer hexStringOld = new StringBuffer();

            for (int i = 0; i < messageDigestOld.length; i++) {
                String hexOld = Integer.toHexString(0xFF & messageDigestOld[i]);
                if (hexOld.length() == 1) {
                    hexStringOld.append('0');
                }
                hexStringOld.append(hexOld);
            }
            encyptoldpass = hexStringOld.toString();





            try {

                sql = "update userlogin set password=? where userid=? and password=?";
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                connn = dataSource.getConnection();
                PreparedStatement pst = connn.prepareStatement(sql);
                pst.setString(1, encyptnewpass);
                pst.setString(2, userid);
                pst.setString(3, encyptoldpass);
               // System.out.println("encrypt password+++" + encyptoldpass);
                i = pst.executeUpdate();
                if (i > 0) {

                    response.sendRedirect("ch_pwd.jsp?cp=1");
                } else {

                    response.sendRedirect("ch_pwd.jsp?cp=2");

                }
                pst.close();

            } catch (Exception ex) {
                System.out.println(ex);
                response.sendRedirect("ch_pwd.jsp?cp=2");

            } finally {
                connn.close();
            }
%>
