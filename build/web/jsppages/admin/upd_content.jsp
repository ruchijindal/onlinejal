<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.*;"%>

<%!    String con_id;
    String con_title;
    String content;
    String content_type;
    String con_date;
    String sql;
    PreparedStatement pst;
    Connection con;
    String display;
    String priority;
    int chktab=0;
%>



<%

            try {
                 if (request.getParameter("chktab") != null) {
                       chktab = Integer.parseInt(request.getParameter("chktab"));
                    } else {
                        chktab = 0;
                    }
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                con_id = request.getParameter("con_id");
                con_title = request.getParameter("con_title");
                if (con_title != null) {
                    con_title = con_title.trim();
                }
                content = request.getParameter("content1");
                if (content != null) {
                    content = content.trim();
                }
                content_type = request.getParameter("content_type");
                if (content_type != null) {
                    content_type = content_type.trim();
                }
                con_date = request.getParameter("con_date");
                if (con_date != null) {
                    con_date = con_date.trim();
                }
                display = request.getParameter("display");
                if (display != null) {
                    display = display.trim();
                }
                priority = request.getParameter("priority");
                if (priority != null) {
                    priority = priority.trim();
                }
               
                sql = "update jal_content set con_title=?,content=?,content_type=?,con_date=?,display=?,priority=? where con_id=?";
                pst = con.prepareStatement(sql);
                pst.setString(1, con_title);
                pst.setString(2, content);
                pst.setString(3, content_type);
                pst.setString(4, con_date);
                pst.setString(5, display);
                pst.setString(6, priority);
                pst.setString(7, con_id);
                int i = pst.executeUpdate();
                if (i > 0)
                System.out.println(+chktab);
                {%>

                <jsp:forward page="viewcontent.jsp?chktab=<%=chktab%>"/>
                
               <% }
            } catch (Exception ex) {
                System.out.println(ex);
                response.sendRedirect("viewcontent.jsp");
            } finally {
                con.close();
            }

%>