<%@page contentType="text/html" import="java.io.*,java.util.*,javax.servlet.*"  pageEncoding="UTF-8"%>

<%!    byte b[] = null;
    byte a[] = null;
    int size = 0;
    String path = null;
    int x = 0;
    int j = 0;
    String div;
    String img;
    String temppath;
    File delfile;
    String filename;
    boolean i;
    String page;
    String cons_no;
%>

<%

            try {
                cons_no = (String) session.getAttribute("cons_no");
                path = this.getServletContext().getRealPath("") + "/resources/ledger/" + cons_no + ".xml";  // get path on the server
                delfile = new File(path);
                if (delfile.exists()) {
                    i = delfile.delete();
                }

                response.sendRedirect("cons_details.jsp?cons_no=" + cons_no);
            } catch (Exception ex) {
                System.out.println(ex);

                response.sendRedirect("cons_details.jsp?cons_no=" + cons_no);
            }
%>