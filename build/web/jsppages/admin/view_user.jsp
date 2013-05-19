
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : View User</title>
    <jsp:include page="../common/header.jsp"/>
    </head>

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*;"%>
<%!    String username;
    String userid;
    String password;
    String userrole;
    String crdate;
    String createdby;
    String sql;
    Connection con;
    ConvertToDate ctd;
    String sess;
    int t;
    int n = 1;
%>
<body>

    <script language="javascript" type="text/javascript">

        function confirmDel()
        {
            var msg;
            msg="Do you want to delete this record permanently?"
            var agree=confirm(msg);
            if(agree)
                return true;
            else
                return false;
        }

    </script>




        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

        %>


        <jsp:include page="../common/navigation.jsp"/>

        <div id="helper">
            <div class="inside">
                <div class="container">
                    <div class="bgr">
                    </div> <!-- #helper .leftcorners -->
                </div> <!-- #helper .container -->
            </div> <!-- #helper .inside -->
        </div> <!-- #helper -->

        <div id="breadcrumbs">
            <div class="inside">
                <div class="container">
                    <div id="breadcrumb">

                        <div class="youarehere">
                            <div class="leftcorners">
                                <div class="rightarrow">
                                    <div class="bg">
                                        You are here:
                                    </div> <!-- #breadcrums .bg -->
                                </div> <!-- #breadcrums .rightarrow -->
                            </div> <!-- #breadcrums .leftcorners -->
                        </div> <!-- #breadcrums .youarehere -->

                        <div class="inactive">
                            <a href="admin.jsp" title="Admin">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Admin
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                        <div class="active">
                            <a href="#" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            View User
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                    </div> <!-- #breadcrums .breadcrumb -->
                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->

        <div id="content">
            <div class="inside">
                <div class="container">


                    <%
                                if (t == 1) {
                                    t = (Integer) 0;
                                    request.setAttribute("t", t);
                    %>

                    <p class="error">There was some error!</p>

                    <%
                                }
                                if (t == 2) {
                                    t = (Integer) 0;
                                    request.setAttribute("t", t);
                    %>
                    <p class="success">Record updated!</p>
                    <%
                                }
                                if (t == 3) {
                                    t = (Integer) 0;
                                    request.setAttribute("t", t);
                    %>
                    <p class="success">Record deleted!</p>

                    <%
                                }
                                if (t == 4) {
                                    t = (Integer) 0;
                                    request.setAttribute("t", t);
                    %>

                    <p class="success">Record inserted!</p>
                    <%
                                }
                    %>

                    <!-- Container Starts -->

                    <div id="contentrail" class="full" >
                        <h2>User Details </h2>

                        <div id="table-blk" class="full">
                            <table class="box-table">
                                <colgroup>
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                </colgroup>

                                <thead>
                                    <tr >
                                        <th scope="col" >User Name</th>
                                        <th scope="col" >User ID</th>
                                        <th scope="col">User Role</th>
                                        <th scope="col" >Creation Date</th>
                                        <th scope="col" >Created By</th>
                                        <th scope="col" >Actions</th>
                                    </tr>
                                </thead>

                                <%
                                            try {
                                                InitialContext initialContext = new InitialContext();
                                                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                con = dataSource.getConnection();
                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                sql = "select username,userid,userrole,to_char(crdate,'DD-MM-YYYY'),createdby  from userlogin";
                                                PreparedStatement pst = con.prepareStatement(sql);
                                                ResultSet rs = pst.executeQuery();
                                                while (rs.next()) {
                                                    username = rs.getString(1);
                                                    userid = rs.getString(2);
                                                    userrole = rs.getString(3);
                                                    crdate = rs.getString(4);
                                                    createdby = rs.getString(5);
                                                    if (n % 2 == 0) {
                                %>
                             
                                    <tr>
                                        <td><%=username%></td>
                                        <td><%=userid%></td>
                                        <td><%=userrole%></td>
                                        <td><%=crdate%></td>
                                        <td><%=createdby%></td>

                                        <td class="fix"><div class="button contentfix"><a href="edit_user.jsp?userid=<%=userid%>">
                                                    <img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/>
                                                </a>

                                                <a href="delete_user.jsp?userid=<%=userid%>"  onclick="return confirmDel();">
                                                    <img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/>
                                                </a>
                                            </div></td>


                                    </tr>
                                    <%
                                                                                            n++;
                                                                                        } else {
                                    %>
                                    <tr>
                                        <td><%=username%></td>
                                        <td><%=userid%></td>
                                        <td><%=userrole%></td>
                                        <td><%=crdate%></td>
                                        <td><%=createdby%></td>
                                        <td class="fix1"><div class="button contentfix"><a href="edit_user.jsp?userid=<%=userid%>">
                                                    <img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/>
                                                </a>

                                                <a href="delete_user.jsp?userid=<%=userid%>"  onclick="return confirmDel();">
                                                    <img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/>
                                                </a>
                                            </div></td>


                                    </tr>

                                    <%
                                                            n++;
                                                        }
                                                    }
                                                } catch (Exception ex) {
                                                    System.out.println(ex);
                                                } finally {
                                                    con.close();
                                                }
                                    %>
                               
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>