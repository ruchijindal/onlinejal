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
%>

<%

            try {
                filename = request.getParameter("filename");
                page = request.getParameter("page");
                path = this.getServletContext().getRealPath("") + "/resources/uploadimg/" + filename;  // get path on the server
                delfile = new File(path);
                if (delfile.exists()) {
                    i = delfile.delete();
                }
                if (i) {
                    if (page.equals("viewuploadfile")) {
                        response.sendRedirect("viewuploadfile.jsp");
                    } else if (page.equals("admin")) {
                        response.sendRedirect("admin.jsp");
                    } else if (page.equals("create_content")) {
                        response.sendRedirect("create_content.jsp");
                    }
                } else {
                    if (page.equals("viewuploadfile")) {
                        response.sendRedirect("viewuploadfile.jsp");
                    } else if (page.equals("admin")) {
                        response.sendRedirect("admin.jsp");
                    } else if (page.equals("create_content")) {
                        response.sendRedirect("create_content.jsp");
                    }
                }

            } catch (Exception ex) {
                System.out.println(ex);
                if (page.equals("viewuploadfile")) {
                    response.sendRedirect("viewuploadfile.jsp");
                } else if (page.equals("admin")) {
                    response.sendRedirect("admin.jsp");
                } else if (page.equals("create_content")) {
                    response.sendRedirect("create_content.jsp");
                }
            }
%>