<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.*;"%>

<%!    String con_id;
    String con_title;
    String content;
    String content_type;
    java.sql.Date con_date;
    String sql;
    Statement pst;
    Connection con;
    java.util.Date dt;
    String strcon_date;
    String display;
    String priority;
    String cont_position;
%>


<%
            try {
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                // con = (Connection) pageContext.getServletContext().getAttribute("con");
                dt = new java.util.Date();
                con_date = new java.sql.Date(dt.getTime());

                con_title = request.getParameter("con_title");
                if (con_title.equals("")) {
                    con_title = null;
                }

                content = request.getParameter("content1");
                if (content.equals("")) {
                    content = null;
                }
                content_type = request.getParameter("content_type");
                cont_position = request.getParameter("page_position");
                if (content_type.equalsIgnoreCase("page")) {
                    if (cont_position.equals("")) {
                        cont_position = "root";

                    }
                } else {
                    cont_position = null;
                }

                display = request.getParameter("display");
                priority = request.getParameter("priority");
                sql = "select max(con_id) as high from jal_content ";
                pst = con.createStatement();
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
                sql = "insert into jal_content (con_id,con_title,content,content_type,con_date,display,priority,position) values (" + content_id + ",'" + con_title + "','" + content + "','" + content_type + "',to_date('" + con_date.toString() + "','yyyy-mm-dd'),'" + display + "','" + priority + "','" + cont_position + "')";
                pst = con.createStatement();

                int i = pst.executeUpdate(sql);
                if (i > 0) {
                    response.sendRedirect("viewcontent.jsp");
                }
            } catch (Exception ex) {
                System.out.println(ex);
                response.sendRedirect("viewcontent.jsp");
            } finally {
                con.close();
                request.removeAttribute("con_position");
            }


%>
