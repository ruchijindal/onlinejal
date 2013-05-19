<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page  import="java.sql.*" %>

<%!    String name;
    String address;
    String emailid;
    String phoneno;
    String subject;
    String sugg_com;
    Connection con;
    PreparedStatement pst;
    String sql;
    java.sql.Date sugg_date;
%>


<%
            try {
                name = request.getParameter("name");
                address = request.getParameter("address");
                emailid = request.getParameter("email");
                phoneno = request.getParameter("phone");
                subject = request.getParameter("subject");
                sugg_com = request.getParameter("message");

                java.util.Date dt = new java.util.Date();
                sugg_date = new java.sql.Date(dt.getTime());
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                sql = "select max(id) as high from contact_tab";
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(sql);
                Long content_id = new Long(0);

                while (rs.next()) {
                    content_id = rs.getLong("high");
                }
                if (content_id != null) {
                    content_id = content_id + 1;
                } else {
                    content_id = new Long(1);
                }
                sql = "insert into contact_tab(ID,name,address,emailid,subject,sugg_com,sugg_date,phoneno) values("+content_id+",?,?,?,?,?,?,?)";
                pst = con.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, address);
                pst.setString(3, emailid);
                pst.setString(4, subject);
                pst.setString(5, sugg_com);
                pst.setDate(6, sugg_date);
                pst.setString(7, phoneno);
                pst.executeUpdate();
                response.sendRedirect("complaintForm.jsp?msg=a");
            } catch (Exception ex) {
                System.out.println(ex);
                response.sendRedirect("complaintForm.jsp?msg=b");
            } finally {
                con.close();
            }
%>