<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>

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
    String description;
    String heading;
    String page;
    String sql;
    PreparedStatement pst;
    Connection con;
    String filename;
    ByteArrayOutputStream buffer;
    String userrole;
    int t;
%>

<%
            request.getSession(false);
            request.setAttribute("t", t);

            userrole = (String) session.getAttribute("userrole");

%>

<%

            try {



                ServletInputStream in = request.getInputStream();


                byte[] line = new byte[128];
                int i = in.readLine(line, 0, 128);
                int boundaryLength = i - 2;
                String boundary = new String(line, 0, boundaryLength);

                while (i != -1) {
                    String newLine = new String(line, 0, i);
                    if (newLine.startsWith("Content-Disposition: form-data; name=\"heading\"")) {
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
                        heading = new String(buffer.toByteArray());

                       // System.out.println("Heading value is " + heading);
                    } else if (newLine.startsWith("Content-Disposition: form-data; name=\"description\"")) {
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
                        description = new String(buffer.toByteArray());
                       // System.out.println("Description value is " + description);
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


                String outputfile = this.getServletContext().getRealPath("") + "/resources/uploadimg/" + filename;  // get path on the server
                FileOutputStream fos = new FileOutputStream(outputfile);
                fos.write(buffer.toByteArray());

                //FileWriter fw=new FileWriter("/home/smp/Desktop/demo.txt");
                //fw.write(file);
                //fw.close();

                String path = "resources/uploadimg/" + filename;
 sql="select max(id) as high from upload_file";
                 pst=con.prepareStatement(sql);
                    ResultSet rs=pst.executeQuery(sql);
                   Long content_id=new Long(0);

                 while(rs.next())
                     {
                     content_id=rs.getLong("high");
                     }
                   //  {
                     //
                       //if(content_id<rs.getLong("con_id"))
                        //content_id=rs.getLong("con_id");
                     //}
                     if(content_id!=null){
                 content_id=content_id+1;}
                 else{
                     content_id=new Long(1);
                     }
                sql = "insert into upload_file(id,path,description,heading) values("+content_id+",?,?,?) ";
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                //con=(Connection)pageContext.getServletContext().getAttribute("con");
                pst = con.prepareStatement(sql);
                //pst.setBytes(1,buffer.toByteArray());
                pst.setString(1, path);
                pst.setString(2, description);
                pst.setString(3, heading);
                int j = pst.executeUpdate();

               // System.out.println("page is" + page + i);

                response.sendRedirect("viewuploadfile.jsp");


            } catch (Exception ex) {
                System.out.println("Exception in insert image" + ex);


                response.sendRedirect("viewuploadfile.jsp");
            } finally {
                con.close();
            }


%>

