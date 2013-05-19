<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%!    int t = 0;
    String sess;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
      <head> <title>Noida Jal Board :Contents</title></head>
    <jsp:include page="../common/header.jsp"/>
    <script type="text/javascript" src="../../resources/jquery/jquery.maskedinput-1.2.2.js"></script>
    <script type="text/javascript">
        $(document).ready(function()
        {

            $("#con_date").mask("99/99/99");
            $("#form1").validate();

        });




    </script>

    <%
                request.getSession(false);
                request.setAttribute("t", t);

                sess = (String) session.getAttribute("userrole");

    %>
    <body>


        <!-- Wrapper Starts -->
        <div id="wrapper">

            <jsp:include page="../common/toppanel.jsp"/><!--panel -->

            <!-- Menu Starts -->
            <jsp:include page="../common/navigation.jsp"/>

            <div id="container" class="clearfix ">



                <%
                            if (sess.equalsIgnoreCase("Admin")) {
                %>


                <ul>
                    <li>
                        <a href="view_user.jsp">&nbsp;&nbsp;View User</a>
                    </li>

                    <li>
                        <a href="create_user.jsp">&nbsp;&nbsp;Create User</a>
                    </li>

                    <li>
                        <a href="viewcontent.jsp">&nbsp;&nbsp;Update Site</a>
                    </li>

                    <li>
                        <a href="viewuploadfile.jsp">&nbsp;&nbsp;View Uploaded Files</a>
                    </li>

                    <li>
                        <a href="view_complains.jsp">&nbsp;&nbsp;View Suggestions/Complains</a>
                    </li>

                </ul>

                <%            }
                %>

                <br/>
                <br/>

            </div>
            <!-- Container Ends -->
            <!-- Footer Starts -->
            <jsp:include page="../common/footer.jsp"/>
            <!-- Footer Ends -->
        </div>
        <!-- Wrapper Ends -->

    </body>
</html>


