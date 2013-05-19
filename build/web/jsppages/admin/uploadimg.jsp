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
    File tmpDir;
    File destinationDir;
    FileOutputStream fos;
    String page;
%>



<%

            try {
                response.setContentType("text/html;charset=UTF-8");
                // get access to file that is uploaded from client


                Part p1 = request.getPart("image");
                page = request.getQueryString();
                InputStream is = p1.getInputStream();
                String file = p1.toString();
                


                String filename = file.substring(file.indexOf("File name=") + 10);
                filename = filename.substring(0, filename.indexOf(","));
               

                // get filename to use on the server
                String outputfile = this.getServletContext().getRealPath("") + "/resources/uploadimg/" + filename;  // get path on the server
                fos = new FileOutputStream(outputfile);

                // write bytes taken from uploaded file to target file
                int ch = is.read();
                while (ch != -1) {
                    fos.write(ch);
                    ch = is.read();
                }
                fos.close();

                if (page.equals("admin")) {
                    response.sendRedirect("admin.jsp");
                } else if (page.equals("viewuploadfile")) {
                    response.sendRedirect("viewuploadfile.jsp");
                } else if (page.equals("create_content")) {
                    response.sendRedirect("create_content.jsp");
                }

            } catch (Exception ex) {
                System.out.println("Exception in upload image" + ex);


                if (page.equals("admin")) {
                    response.sendRedirect("admin.jsp");
                } else if (page.equals("viewuploadfile")) {
                    response.sendRedirect("viewuploadfile.jsp");
                }
            }



%>

