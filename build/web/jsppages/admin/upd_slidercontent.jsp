<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" import="java.io.*,java.sql.*,java.util.*,javax.servlet.*"  pageEncoding="UTF-8"%>

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
    FileInputStream fis;
    String captiontxt, id1;
    String caption_heading;
    String page;
    String sql;
    PreparedStatement pst;
    Connection con;
    String filename;
    ByteArrayOutputStream buffer;
    int flag;

%>



<%
            filename = null;
            try {

                // write bytes taken from uploaded file to target file
                ServletInputStream in = request.getInputStream();


                byte[] line = new byte[128];
                int i = in.readLine(line, 0, 128);
                int boundaryLength = i - 2;
                String boundary = new String(line, 0, boundaryLength);

                while (i != -1) {
                    String newLine = new String(line, 0, i);
                    if (newLine.startsWith("Content-Disposition: form-data; name=\"caption_heading\"")) {
                        String s = new String(line, 0, i - 2);
                        //this is the  content
                        i = in.readLine(line, 0, 128);
                        i = in.readLine(line, 0, 128);
                        // blank line
                        buffer = new ByteArrayOutputStream();
                        newLine = new String(line, 0, i);
                        while (i != -1 && !newLine.startsWith(boundary)) {

                            buffer.write(line, 0, i);
                            i = in.readLine(line, 0, 128);
                            newLine = new String(line, 0, i);
                        }
                        caption_heading = new String(buffer.toByteArray());

                       
                    } else if (newLine.startsWith("Content-Disposition: form-data; name=\"captiontxt\"")) {
                        String s = new String(line, 0, i - 2);
                        //this is the  content
                        i = in.readLine(line, 0, 128);
                        // blank line
                        i = in.readLine(line, 0, 128);
                        buffer = new ByteArrayOutputStream();
                        newLine = new String(line, 0, i);
                        while (i != -1 && !newLine.startsWith(boundary)) {
                            buffer.write(line, 0, i);
                            i = in.readLine(line, 0, 128);
                            newLine = new String(line, 0, i);
                        }
                        captiontxt = new String(buffer.toByteArray());
                       
                    } else if (newLine.startsWith("Content-Disposition: form-data; name=\"id1\"")) {
                        String s = new String(line, 0, i - 2);
                        //this is the  content
                        i = in.readLine(line, 0, 128);
                        // blank line
                        i = in.readLine(line, 0, 128);
                        buffer = new ByteArrayOutputStream();
                        newLine = new String(line, 0, i);
                        while (i != -1 && !newLine.startsWith(boundary)) {
                            buffer.write(line, 0, i);
                            i = in.readLine(line, 0, 128);
                            newLine = new String(line, 0, i);
                        }
                        id1 = new String(buffer.toByteArray());
                       
                    } else if (newLine.startsWith("Content-Disposition: form-data; name=\"image\"")) {

                        String s = new String(line, 0, i - 2);

                        //We don't require file name.
                        int pos = s.indexOf("filename=\"");
                        if (pos != -1) {
                            String filepath = s.substring(pos + 10, s.length() - 1);
                            // Windows browsers include the full path on the client
                            // But Linux/Unix and Mac browsers only send the filename
                            // test if this is from a Windows browser

                            pos = filepath.lastIndexOf("\"");
                            if (pos != -1) {
                                filename = filepath.substring(pos + 1);
                            } else {
                                filename = filepath;
                            }
                        }
                        //this is the file content
                        i = in.readLine(line, 0, 128);
                        i = in.readLine(line, 0, 128);
                        // blank line
                        i = in.readLine(line, 0, 128);
                        buffer = new ByteArrayOutputStream();
                        newLine = new String(line, 0, i);
                        while (i != -1 && !newLine.startsWith(boundary)) {
                            buffer.write(line, 0, i);
                            i = in.readLine(line, 0, 128);
                            newLine = new String(line, 0, i);
                        }

                    }
                    i = in.readLine(line, 0, 128);

                }
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                if (filename.equals("")) {
                    flag = 1;
                } else {
                    flag = 0;
                    String outputfile = this.getServletContext().getRealPath("") + "/resources/sliderimage/" + filename;  // get path on the server
                    FileOutputStream fos = new FileOutputStream(outputfile);
                    fos.write(buffer.toByteArray());

                    String path = "resources/sliderimage/" + filename;
                    

                    sql = "update slider_image set captiontxt='" + captiontxt + "',caption_heading='" + caption_heading + "',path='" + path + "' where id=" + id1 + "";

                    pst = con.prepareStatement(sql);
                    int j = pst.executeUpdate();
                   
                    response.sendRedirect("viewuploadfile.jsp");
                }
                if (flag == 1) {
                    sql = "update slider_image set captiontxt='" + captiontxt + "',caption_heading='" + caption_heading + "' where id=" + id1 + "";

                    pst = con.prepareStatement(sql);
                    int j = pst.executeUpdate();
                   
                    response.sendRedirect("viewuploadfile.jsp");
                }


            } catch (Exception ex) {
                System.out.println("Exception in insert image" + ex);


                response.sendRedirect("viewuploadfile.jsp");
            } finally {
                con.close();
            }

%>

